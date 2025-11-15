unit VCardImportController;

interface

uses
  System.SysUtils, System.Classes, System.Generics.Collections, System.NetEncoding,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, FireDAC.Stan.Option, FireDAC.DApt,
  Vcl.Dialogs, System.Threading;

type
  TContato = record
    Nome: string;
    Email: string;
    Telefone: string;
  end;

  TOnContato = reference to procedure(const C: TContato);

  IVCardController = interface
    ['{B1C2D3E4-F5A6-7890-1234-567890ABCDEF}']
    procedure ImportarEPreencher(const Arquivo: string; MemTable: TFDMemTable);
    procedure SalvarNoBanco(MemTable: TFDMemTable; Connection: TFDConnection);
  end;

  TVCardController = class(TInterfacedObject, IVCardController)
  public
    procedure ImportarEPreencher(const Arquivo: string; MemTable: TFDMemTable);
    procedure SalvarNoBanco(MemTable: TFDMemTable; Connection: TFDConnection);
  end;

procedure ImportarVCardSimples(const AFileName: string; const OnContato: TOnContato);

implementation

// ----------------- Helpers de parsing/decodificação -----------------
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

function LooksLikeQuotedPrintable(const S: string): Boolean;
var
  i, L: Integer;
  hits: Integer;
begin
  hits := 0;
  L := Length(S);
  i := 1;
  while i <= L - 2 do
  begin
    if (S[i] = '=') and (i+2 <= L) and
       CharInSet(S[i+1], ['0'..'9','A'..'F','a'..'f']) and
       CharInSet(S[i+2], ['0'..'9','A'..'F','a'..'f']) then
    begin
      Inc(hits);
      if hits >= 2 then Break;
      Inc(i, 3);
      Continue;
    end;
    Inc(i);
  end;
  Result := (hits >= 2) or ((L > 0) and (S[L] = '='));
end;

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

function ExtractPropParams(const L: string; out Prop, Params, Value: string): Boolean;
var
  P: Integer;
  Left: string;
begin
  Result := False; Prop := ''; Params := ''; Value := '';
  P := L.IndexOf(':');
  if P < 0 then Exit;
  Left := L.Substring(0, P);
  Value := L.Substring(P+1);
  if Left.Contains(';') then
  begin
    Prop := UpperCase(Left.Substring(0, Left.IndexOf(';')));
    Params := Left.Substring(Left.IndexOf(';')+1);
  end
  else
    Prop := UpperCase(Left);
  Result := True;
end;

function DecodeIfNeeded(const Params, Raw: string): string;
var
  Enc, CS: string;
  OutText: string;
begin
  Enc := UpperCase(ParamValue(Params, 'ENCODING'));
  CS := ParamValue(Params, 'CHARSET');
  if (Enc = 'QUOTED-PRINTABLE') or LooksLikeQuotedPrintable(Raw) then
  begin
    try
      OutText := DecodeQPToString(Raw, CS);
    except
      OutText := Raw;
    end;
    Exit(FixMojibake(OutText));
  end;
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
  L, Prop, Params, Val, TXT: string;
  V: TArray<string>;
begin
  Raw := TStringList.Create;
  Lines := nil;
  try
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
        end;
        Dentro := False;
        FillChar(C, SizeOf(C), 0);
        Continue;
      end;
      if not Dentro or not ExtractPropParams(L, Prop, Params, Val) then
        Continue;

      if Prop = 'FN' then
        C.Nome := DecodeIfNeeded(Params, Val)
      else if (Prop = 'N') and (C.Nome = '') then
      begin
        TXT := DecodeIfNeeded(Params, Val);
        V := TXT.Split([';']);
        if Length(V) >= 2 then
          C.Nome := (V[1] + ' ' + V[0]).Trim
        else if Length(V) = 1 then
          C.Nome := V[0];
      end
      else if (Prop = 'EMAIL') and (C.Email = '') then
        C.Email := DecodeIfNeeded(Params, Val)
      else if (Prop = 'TEL') and (C.Telefone = '') then
        C.Telefone := DecodeIfNeeded(Params, Val);
    end;
  finally
    Lines.Free;
    Raw.Free;
  end;
end;

// ---------------------- Verifica duplicata (ignorando campos vazios) ----------------------
function VerificarDuplicata(Connection: TFDConnection; const Email, Telefone: string): Boolean;
var
  Q: TFDQuery;
  TemEmail, TemTel: Boolean;
begin
  Result   := False;
  TemEmail := Trim(Email) <> '';
  TemTel   := Trim(Telefone) <> '';

  // Se não tiver NENHUM dado pra comparar, não considera duplicado
  if not (TemEmail or TemTel) then
    Exit;

  Q := TFDQuery.Create(nil);
  try
    Q.Connection := Connection;
    Q.SQL.Clear;
    Q.SQL.Add('SELECT 1 FROM "Contato" WHERE');

    // Monta o WHERE somente com o que tiver preenchido
    if TemEmail then
    begin
      Q.SQL.Add(' email = :EMAIL');
      if TemTel then
        Q.SQL.Add(' OR telefone = :TELEFONE');
    end
    else
    begin
      // Só telefone
      Q.SQL.Add(' telefone = :TELEFONE');
    end;

    if TemEmail then
      Q.ParamByName('EMAIL').AsString := Email;

    if TemTel then
      Q.ParamByName('TELEFONE').AsString := Telefone;

    Q.Open;
    Result := not Q.Eof;  // True = já existe algum registro com esses dados
  finally
    Q.Free;
  end;
end;


// ---------------------- Importar e preencher ----------------------
procedure TVCardController.ImportarEPreencher(const Arquivo: string; MemTable: TFDMemTable);
begin
  if not FileExists(Arquivo) then
    raise Exception.Create('Arquivo não encontrado: ' + Arquivo);

  TThread.CreateAnonymousThread(
    procedure
    begin
      ImportarVCardSimples(Arquivo,
        procedure(const C: TContato)
        begin
          if Trim(C.Nome) = '' then Exit;
          TThread.Queue(nil,
            procedure
            begin
              MemTable.Append;
              MemTable.FieldByName('NOME').AsString := C.Nome.Trim;
              MemTable.FieldByName('EMAIL').AsString := C.Email.Trim;
              MemTable.FieldByName('TELEFONE').AsString := C.Telefone.Trim;
              MemTable.Post;
            end);
        end);
    end).Start;
end;

// ---------------------- Salvar no banco (SIMPLES) ----------------------
procedure TVCardController.SalvarNoBanco(MemTable: TFDMemTable; Connection: TFDConnection);
var
  Query: TFDQuery;
  Transacao: TFDTransaction;
  Salvos, Duplicados: Integer;
  Nome, Email, Telefone: string;
begin
  if MemTable.IsEmpty then
    raise Exception.Create('Nenhum contato para salvar.');

  Query := TFDQuery.Create(nil);
  Transacao := TFDTransaction.Create(nil);
  Salvos := 0;
  Duplicados := 0;

  try
    Query.Connection := Connection;
    Transacao.Connection := Connection;
    Query.SQL.Text := 'INSERT INTO "Contato" (NOME, EMAIL, TELEFONE) VALUES (:NOME, :EMAIL, :TELEFONE)';

    Transacao.StartTransaction;
    try
      MemTable.DisableControls;
      try
        MemTable.First;
        while not MemTable.Eof do
        begin
          Nome := MemTable.FieldByName('NOME').AsString;
          Email := MemTable.FieldByName('EMAIL').AsString;
          Telefone := MemTable.FieldByName('TELEFONE').AsString;

          if VerificarDuplicata(Connection, Email, Telefone) then
            Inc(Duplicados)
          else
          begin
            Query.ParamByName('NOME').AsString := Nome;
            Query.ParamByName('EMAIL').AsString := Email;
            Query.ParamByName('TELEFONE').AsString := Telefone;
            Query.ExecSQL;
            Inc(Salvos);
          end;

          MemTable.Next;
        end;
      finally
        MemTable.EnableControls;
      end;

      Transacao.Commit;

      // MENSAGEM FINAL
      var Msg := Format('SUCESSO: %d contatos salvos!', [Salvos]);
      if Duplicados > 0 then
        Msg := Msg + sLineBreak + Format('AVISO: %d duplicados ignorados.', [Duplicados]);

      TThread.Queue(nil,
        procedure
        begin
          ShowMessage(Msg);
        end);

    except
      on E: Exception do
      begin
        Transacao.Rollback;
        raise Exception.Create('Erro ao salvar: ' + E.Message);
      end;
    end;
  finally
    Query.Free;
    Transacao.Free;
  end;
end;

end.
