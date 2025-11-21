unit GruposRepository;

interface

uses
  System.SysUtils, System.Generics.Collections,
  FireDAC.Comp.Client, FireDAC.DApt,
  ConexaoBanco, GruposModel;

type
  TGruposRepository = class
  private
    FQuery: TFDQuery;
  public
    constructor Create;
    destructor Destroy; override;

    function Inserir(AGrupo: TGrupos): Boolean;
    function Atualizar(AGrupo: TGrupos): Boolean;

    // "Excluir" = soft delete → ativo := false
    function MarcarInativo(AIdGrupo: Integer): Boolean;
    function MarcarAtivo(AIdGrupo: Integer): Boolean;

    function BuscarPorId(AIdGrupo: Integer): TGrupos;
    function ListarTodos: TObjectList<TGrupos>;
    function ExcluirGrupo(AIdGrupo: Integer): Boolean;

  end;

implementation

{ TGruposRepository }

constructor TGruposRepository.Create;
begin
  inherited Create;
  FQuery := TFDQuery.Create(nil);
  FQuery.Connection := DataModule1.FDConnection1;
end;

destructor TGruposRepository.Destroy;
begin
  FQuery.Free;
  inherited;
end;

function TGruposRepository.Inserir(AGrupo: TGrupos): Boolean;
begin
  Result := False;

  FQuery.SQL.Clear;
  FQuery.SQL.Text :=
    'INSERT INTO "Grupos" (nome, ativo) ' +
    'VALUES (:nome, :ativo) ' +
    'RETURNING id_grupo';

  FQuery.ParamByName('nome').AsString  := AGrupo.getNome;
  FQuery.ParamByName('ativo').AsBoolean := AGrupo.getAtivo;

  FQuery.Open;
  try
    if not FQuery.Eof then
    begin
      AGrupo.setId(FQuery.FieldByName('id_grupo').AsInteger);
      Result := True;
    end;
  finally
    FQuery.Close;
  end;
end;

function TGruposRepository.Atualizar(AGrupo: TGrupos): Boolean;
begin
  Result := False;

  FQuery.SQL.Clear;
  FQuery.SQL.Text :=
    'UPDATE "Grupos" ' +
    'SET nome = :nome, ativo = :ativo ' +
    'WHERE id_grupo = :id_grupo';

  FQuery.ParamByName('id_grupo').AsInteger := AGrupo.getId;
  FQuery.ParamByName('nome').AsString      := AGrupo.getNome;
  FQuery.ParamByName('ativo').AsBoolean    := AGrupo.getAtivo;

  FQuery.ExecSQL;
  Result := FQuery.RowsAffected > 0;
end;

function TGruposRepository.MarcarInativo(AIdGrupo: Integer): Boolean;
begin
  Result := False;

  FQuery.SQL.Clear;
  FQuery.SQL.Text :=
    'UPDATE "Grupos" SET ativo = FALSE ' +
    'WHERE id_grupo = :id_grupo';

  FQuery.ParamByName('id_grupo').AsInteger := AIdGrupo;
  FQuery.ExecSQL;

  Result := FQuery.RowsAffected > 0;
end;

function TGruposRepository.MarcarAtivo(AIdGrupo: Integer): Boolean;
begin
  Result := False;

  FQuery.SQL.Clear;
  FQuery.SQL.Text :=
    'UPDATE "Grupos" SET ativo = TRUE ' +
    'WHERE id_grupo = :id_grupo';

  FQuery.ParamByName('id_grupo').AsInteger := AIdGrupo;
  FQuery.ExecSQL;

  Result := FQuery.RowsAffected > 0;
end;

function TGruposRepository.BuscarPorId(AIdGrupo: Integer): TGrupos;
begin
  Result := nil;

  FQuery.SQL.Clear;
  FQuery.SQL.Text :=
    'SELECT id_grupo, nome, ativo ' +
    'FROM "Grupos" ' +
    'WHERE id_grupo = :id_grupo';

  FQuery.ParamByName('id_grupo').AsInteger := AIdGrupo;
  FQuery.Open;

  try
    if not FQuery.Eof then
    begin
      Result := TGrupos.Create;
      Result.setId(FQuery.FieldByName('id_grupo').AsInteger);
      Result.setNome(FQuery.FieldByName('nome').AsString);
      Result.setAtivo(FQuery.FieldByName('ativo').AsBoolean);
    end;
  finally
    FQuery.Close;
  end;
end;

function TGruposRepository.ListarTodos: TObjectList<TGrupos>;
var
  G: TGrupos;
begin
  Result := TObjectList<TGrupos>.Create(True);

  FQuery.SQL.Clear;
  FQuery.SQL.Text :=
    'SELECT id_grupo, nome, ativo ' +
    'FROM "Grupos" ' +
    'ORDER BY id_grupo';

  FQuery.Open;
  try
    while not FQuery.Eof do
    begin
      G := TGrupos.Create;
      G.setId(FQuery.FieldByName('id_grupo').AsInteger);
      G.setNome(FQuery.FieldByName('nome').AsString);
      G.setAtivo(FQuery.FieldByName('ativo').AsBoolean);
      Result.Add(G);

      FQuery.Next;
    end;
  finally
    FQuery.Close;
  end;
end;

function TGruposRepository.ExcluirGrupo(AIdGrupo: Integer): Boolean;
begin
  Result := False;

  FQuery.Close;
  FQuery.SQL.Clear;
  FQuery.SQL.Text :=
    'DELETE FROM "Grupos" ' +         // <-- mesmo nome usado no SELECT/INSERT/UPDATE
    'WHERE id_grupo = :id_grupo';

  FQuery.ParamByName('id_grupo').AsInteger := AIdGrupo;

  try
    FQuery.ExecSQL;
    Result := (FQuery.RowsAffected > 0);
  except
    on E: Exception do
    begin
      // Aqui normalmente cai erro de chave estrangeira, etc.
      // ShowMessage('Erro ao excluir grupo: ' + E.Message);
      Result := False;
    end;
  end;
end;


end.

