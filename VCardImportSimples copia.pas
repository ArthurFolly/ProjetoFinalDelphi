unit VCardImportSimples;

interface

uses
  System.SysUtils, System.Classes, System.Generics.Collections, System.NetEncoding;

type
  TContato = record
    Nome: string;        // FN: ou N:
    Email: string;       // EMAIL:
    Telefone: string;    // TEL:
  end;

  TOnContato = reference to procedure(const C: TContato);

procedure ImportarVCardSimples(const AFileName: string; const OnContato: TOnContato);

implementation

// ----------------- Helpers de parsing/decodificação -----------------

// Junta linhas "dobradas" (folding): se a próxima começa com espaço/TAB, concatena
function DesdobrarLinhas(const List: TStrings): TStringList;
var
  i: Integer;
  cur: string;
begin
  Result := TStringList.Create;
  i := 0;
  while i < List.Count do
  begin
    cur := List[i];
    Inc(i);
    while (i < List.Count) and (List[i] <> '') and ((List[i][1] = ' ') or (List[i][1] = #9)) do
    begin
      cur := cur + List[i].Substring(1);
      Inc(i);
    end;
    Result.Add(cur);
  end;
end;

function ParamValue(const Params, Name: string): string;
var
  A: TArray<string>;
  i, p: Integer;
  s, k, v: string;
begin
  Result := '';
  A := Params.Split([';']);
  for i := 0 to High(A) do
  begin
    s := A[i];
    p := s.IndexOf('=');
    if p > 0 then
    begin
      k := UpperCase(s.Substring(0, p));
      v := s.Substring(p+1);
      if k = UpperCase(Name) then
        Exit(v);
    end;
  end;
end;

// Escolhe TEncoding confiável a partir do CHARSET
function SafeEncodingFromLabel(const CS: string): TEncoding;
var S: string;
begin
  S := UpperCase(Trim(CS));
  if (S = '') or (S = 'UTF8') or (S = 'UTF-8') then Exit(TEncoding.UTF8);
  if (S = 'UTF-16') or (S = 'UTF16') or (S = 'UTF-16LE') then Exit(TEncoding.Unicode);
  if (S = 'UTF-16BE') or (S = 'UTF16BE') then Exit(TEncoding.BigEndianUnicode);
  if (S = 'ISO-8859-1') or (S = 'ISO8859-1') then Exit(TEncoding.GetEncoding(28591));
  if (S.Contains('1252')) or (S = 'WINDOWS-1252') or (S = 'CP1252') or (S = 'ANSI') then Exit(TEncoding.GetEncoding(1252));
  try
    Result := TEncoding.GetEncoding(CS);
  except
    Result := TEncoding.UTF8;
  end;
end;

// Heurística: parece Quoted-Printable?
function LooksLikeQuotedPrintable(const S: string): Boolean;
var
  i, L: Integer;
  c1, c2: Char;
  hits: Integer;
begin
  hits := 0;
  L := Length(S);
  i := 1;
  while i <= L - 2 do
  begin
    if (S[i] = '=') then
    begin
      c1 := S[i+1]; c2 := S[i+2];
      if CharInSet(c1, ['0'..'9','A'..'F','a'..'f']) and CharInSet(c2, ['0'..'9','A'..'F','a'..'f']) then
      begin
        Inc(hits);
        if hits >= 2 then Break; // 2 acertos já é um bom indicativo
        Inc(i, 3);
        Continue;
      end;
    end;
    Inc(i);
  end;
  // também consideramos QP se terminar com '=' (soft break)
  Result := (hits >= 2) or ( (L > 0) and (S[L] = '=') );
end;

// decodifica Quoted-Printable em bytes (remove "=\r\n" / "=\n")
function DecodeQPToBytes(const S: string): TBytes;
var
  W: string;
  I, L: Integer;
  procedure Push(b: Byte);
  begin
    SetLength(Result, Length(Result)+1);
    Result[High(Result)] := b;
  end;
  function HexVal(C: Char): Integer;
  begin
    if (C >= '0') and (C <= '9') then Exit(Ord(C)-Ord('0'));
    if (C >= 'A') and (C <= 'F') then Exit(10 + Ord(C)-Ord('A'));
    if (C >= 'a') and (C <= 'f') then Exit(10 + Ord(C)-Ord('a'));
    Result := 0;
  end;
begin
  SetLength(Result, 0);
  W := S.Replace('=\r\n','').Replace('=\n','');
  I := 1; L := Length(W);
  while I <= L do
  begin
    if (W[I] = '=') and (I+2 <= L) and
       CharInSet(W[I+1],['0'..'9','A'..'F','a'..'f']) and
       CharInSet(W[I+2],['0'..'9','A'..'F','a'..'f']) then
    begin
      Push(Byte(HexVal(W[I+1]) * 16 + HexVal(W[I+2])));
      Inc(I, 3);
    end
    else
    begin
      Push(Byte(W[I]));
      Inc(I);
    end;
  end;
end;

// UTF-8 → texto com fallback; evita exceções
function DecodeQPToString(const S, Charset: string): string;
var
  Bytes: TBytes;
  Enc: TEncoding;
begin
  Bytes := DecodeQPToBytes(S);
  try
    Enc := SafeEncodingFromLabel(Charset);
    Exit(Enc.GetString(Bytes));
  except
    try
      Exit(TEncoding.UTF8.GetString(Bytes));
    except
      Exit(TEncoding.Default.GetString(Bytes));
    end;
  end;
end;

// Corrige mojibake comum (texto UTF-8 exibido como CP1252)
function FixMojibake(const S: string): string;
var
  bytes: TBytes;
begin
  if (Pos('Ã', S) > 0) or (Pos('Â', S) > 0) or (Pos('�', S) > 0) then
  try
    bytes := TEncoding.GetEncoding(1252).GetBytes(S);
    Result := TEncoding.UTF8.GetString(bytes);
    Exit;
  except
  end;
  Result := S;
end;

// Quebra "PROP;PARAMS:VALOR" em partes
function ExtractPropParams(const L: string; out Prop, Params, Value: string): Boolean;
var
  P: Integer;
  Left: string;
begin
  Result := False; Prop := ''; Params := ''; Value := '';
  P := L.IndexOf(':');
  if P < 0 then Exit;
  Left  := L.Substring(0, P);
  Value := L.Substring(P+1);
  if Left.Contains(';') then
  begin
    Prop   := UpperCase(Left.Substring(0, Left.IndexOf(';')));
    Params := Left.Substring(Left.IndexOf(';')+1);
  end
  else
    Prop := UpperCase(Left);
  Result := True;
end;

// Decodifica quando necessário (ENCODING ou heurística), + correção de mojibake
function DecodeIfNeeded(const Params, Raw: string): string;
var
  Enc, CS: string;
  OutText: string;
begin
  Enc := UpperCase(ParamValue(Params, 'ENCODING'));
  CS  := ParamValue(Params, 'CHARSET');

  if (Enc = 'QUOTED-PRINTABLE') or LooksLikeQuotedPrintable(Raw) then
  begin
    try
      OutText := DecodeQPToString(Raw, CS);
    except
      OutText := Raw;
    end;
    Exit(FixMojibake(OutText));
  end;

  // Não é QP → apenas corrige mojibake, se houver
  Result := FixMojibake(Raw);
end;

// ------------------------- Importador principal -------------------------

procedure ImportarVCardSimples(const AFileName: string; const OnContato: TOnContato);
var
  Raw, Lines: TStringList;
  R: TStreamReader;
  i: Integer;
  Dentro: Boolean;
  C: TContato;
  L, Prop, Params, Val: string;
  TXT: string;
  V: TArray<string>;
begin
  Raw := TStringList.Create;
  Lines := nil;
  try
    // Lê como UTF-8 (detecta BOM; se não houver BOM, mantém UTF-8)
    R := TStreamReader.Create(AFileName, TEncoding.UTF8, True);
    try
      while not R.EndOfStream do
        Raw.Add(R.ReadLine);
    finally
      R.Free;
    end;

    Lines := DesdobrarLinhas(Raw);

    Dentro := False;
    FillChar(C, SizeOf(C), 0);

    for i := 0 to Lines.Count - 1 do
    begin
      L := Lines[i].Trim;

      if SameText(L, 'BEGIN:VCARD') then
      begin
        Dentro := True;
        FillChar(C, SizeOf(C), 0);
        Continue;
      end;

      if SameText(L, 'END:VCARD') then
      begin
        if Assigned(OnContato) and (C.Nome <> '') then
        try
          OnContato(C);
        except
          // ignora erro no callback e segue importando
        end;

        Dentro := False;
        FillChar(C, SizeOf(C), 0);
        Continue;
      end;

      if not Dentro then
        Continue;

      if not ExtractPropParams(L, Prop, Params, Val) then
        Continue;

      if Prop = 'FN' then
      begin
        try
          C.Nome := DecodeIfNeeded(Params, Val);
        except
          C.Nome := Val;
        end;
      end
      else if (Prop = 'N') and (C.Nome = '') then
      begin
        try
          TXT := DecodeIfNeeded(Params, Val); // N: Sobrenome;Nome;...
        except
          TXT := Val;
        end;
        V := TXT.Split([';']);
        if Length(V) >= 2 then
          C.Nome := (V[1] + ' ' + V[0]).Trim
        else if Length(V) = 1 then
          C.Nome := V[0];
      end
      else if (Prop = 'EMAIL') and (C.Email = '') then
      begin
        try
          C.Email := DecodeIfNeeded(Params, Val);
        except
          C.Email := Val;
        end;
      end
      else if (Prop = 'TEL') and (C.Telefone = '') then
      begin
        try
          C.Telefone := DecodeIfNeeded(Params, Val);
        except
          C.Telefone := Val;
        end;
      end;
    end;

  finally
    Lines.Free;
    Raw.Free;
  end;
end;

end.

