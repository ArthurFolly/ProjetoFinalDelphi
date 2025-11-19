unit PermissoesRepository;

interface

uses
  ConexaoBanco, FireDAC.Comp.Client, FireDAC.DApt,
  PermissoesModel, System.SysUtils, System.Generics.Collections;

type
  TPermissoesRepository = class
  private
    FQuery: TFDQuery;
  public
    constructor Create;
    destructor Destroy; override;

    function Adicionar(const APermissao: TPermissao): Boolean;
    function Atualizar(const APermissao: TPermissao): Boolean;
    function Excluir(AId: Integer): Boolean;
    function BuscarPorId(AId: Integer): TPermissao;
    function BuscarPorNome(const ANome: string): TPermissao;
    function ListarTodas: TObjectList<TPermissao>;

    function VerificarPermissao(const AOperacao: string; ANivelUsuario: Integer): Boolean;

    procedure CriarPermissoesPadrao;
  end;

implementation

{ TPermissoesRepository }

constructor TPermissoesRepository.Create;
begin
  inherited Create;
  FQuery := TFDQuery.Create(nil);
  FQuery.Connection := DataModule1.FDConnection1;
end;

destructor TPermissoesRepository.Destroy;
begin
  FQuery.Free;
  inherited;
end;

function TPermissoesRepository.Adicionar(const APermissao: TPermissao): Boolean;
begin
  Result := False;
  try
    FQuery.Close;
    FQuery.SQL.Text :=
      'INSERT INTO "Permissoes" (nome, descricao, nivel_requerido, ativo) ' +
      'VALUES (:nome, :descricao, :nivel_requerido, :ativo)';

    FQuery.ParamByName('nome').AsString            := APermissao.getNome;
    FQuery.ParamByName('descricao').AsString       := APermissao.getDescricao;
    FQuery.ParamByName('nivel_requerido').AsInteger := APermissao.getNivelRequerido;
    FQuery.ParamByName('ativo').AsBoolean          := APermissao.getAtivo;

    FQuery.ExecSQL;
    Result := True;
  except
    on E: Exception do
      raise Exception.Create('Erro ao adicionar permissão: ' + E.Message);
  end;
end;

function TPermissoesRepository.Atualizar(const APermissao: TPermissao): Boolean;
begin
  Result := False;
  try
    FQuery.Close;
    FQuery.SQL.Text :=
      'UPDATE "Permissoes" SET ' +
      '  nome = :nome, ' +
      '  descricao = :descricao, ' +
      '  nivel_requerido = :nivel_requerido, ' +
      '  ativo = :ativo ' +
      'WHERE id_permissao = :id';

    FQuery.ParamByName('id').AsInteger             := APermissao.getId;
    FQuery.ParamByName('nome').AsString            := APermissao.getNome;
    FQuery.ParamByName('descricao').AsString       := APermissao.getDescricao;
    FQuery.ParamByName('nivel_requerido').AsInteger := APermissao.getNivelRequerido;
    FQuery.ParamByName('ativo').AsBoolean          := APermissao.getAtivo;

    FQuery.ExecSQL;
    Result := FQuery.RowsAffected > 0;
  except
    on E: Exception do
      raise Exception.Create('Erro ao atualizar permissão: ' + E.Message);
  end;
end;

function TPermissoesRepository.Excluir(AId: Integer): Boolean;
begin
  Result := False;
  try
    FQuery.Close;
    FQuery.SQL.Text := 'UPDATE "Permissoes" SET ativo = FALSE WHERE id_permissao = :id';
    FQuery.ParamByName('id').AsInteger := AId;
    FQuery.ExecSQL;
    Result := FQuery.RowsAffected > 0;
  except
    Result := False;
  end;
end;

function TPermissoesRepository.BuscarPorId(AId: Integer): TPermissao;
begin
  Result := nil;
  FQuery.Close;
  FQuery.SQL.Text := 'SELECT * FROM "Permissoes" WHERE id_permissao = :id AND ativo = TRUE';
  FQuery.ParamByName('id').AsInteger := AId;
  FQuery.Open;

  if not FQuery.IsEmpty then
  begin
    Result := TPermissao.Create;
    Result.setId(FQuery.FieldByName('id_permissao').AsInteger);
    Result.setNome(FQuery.FieldByName('nome').AsString);
    Result.setDescricao(FQuery.FieldByName('descricao').AsString);
    Result.setNivelRequerido(FQuery.FieldByName('nivel_requerido').AsInteger);
    Result.setAtivo(FQuery.FieldByName('ativo').AsBoolean);
  end;

  FQuery.Close;
end;

function TPermissoesRepository.BuscarPorNome(const ANome: string): TPermissao;
begin
  Result := nil;
  FQuery.Close;
  FQuery.SQL.Text := 'SELECT * FROM "Permissoes" WHERE UPPER(nome) = UPPER(:nome) AND ativo = TRUE';
  FQuery.ParamByName('nome').AsString := ANome;
  FQuery.Open;

  if not FQuery.IsEmpty then
  begin
    Result := TPermissao.Create;
    Result.setId(FQuery.FieldByName('id_permissao').AsInteger);
    Result.setNome(FQuery.FieldByName('nome').AsString);
    Result.setDescricao(FQuery.FieldByName('descricao').AsString);
    Result.setNivelRequerido(FQuery.FieldByName('nivel_requerido').AsInteger);
    Result.setAtivo(True);
  end;

  FQuery.Close;
end;

function TPermissoesRepository.ListarTodas: TObjectList<TPermissao>;
var
  Perm: TPermissao;
begin
  Result := TObjectList<TPermissao>.Create(True);
  FQuery.Close;
  FQuery.SQL.Text := 'SELECT * FROM "Permissoes" WHERE ativo = TRUE ORDER BY nivel_requerido, nome';
  FQuery.Open;

  while not FQuery.Eof do
  begin
    Perm := TPermissao.Create;
    Perm.setId(FQuery.FieldByName('id_permissao').AsInteger);
    Perm.setNome(FQuery.FieldByName('nome').AsString);
    Perm.setDescricao(FQuery.FieldByName('descricao').AsString);
    Perm.setNivelRequerido(FQuery.FieldByName('nivel_requerido').AsInteger);
    Perm.setAtivo(FQuery.FieldByName('ativo').AsBoolean);

    Result.Add(Perm);
    FQuery.Next;
  end;

  FQuery.Close;
end;

function TPermissoesRepository.VerificarPermissao(const AOperacao: string; ANivelUsuario: Integer): Boolean;
var
  Permissao: TPermissao;
begin
  Permissao := BuscarPorNome(AOperacao);
  try
    if Permissao = nil then
      Exit(False);

    Result := ANivelUsuario >= Permissao.getNivelRequerido;
  finally
    if Assigned(Permissao) then
      Permissao.Free;
  end;
end;

procedure TPermissoesRepository.CriarPermissoesPadrao;
var
  Perm: TPermissao;
begin
  if BuscarPorNome('CREATE') = nil then
  begin
    Perm := TPermissao.Create;
    Perm.setNome('CREATE');
    Perm.setDescricao('Cadastrar registros');
    Perm.setNivelRequerido(1);
    Perm.setAtivo(True);
    Adicionar(Perm);
  end;

  if BuscarPorNome('READ') = nil then
  begin
    Perm := TPermissao.Create;
    Perm.setNome('READ');
    Perm.setDescricao('Visualizar registros');
    Perm.setNivelRequerido(1);
    Perm.setAtivo(True);
    Adicionar(Perm);
  end;

  if BuscarPorNome('UPDATE') = nil then
  begin
    Perm := TPermissao.Create;
    Perm.setNome('UPDATE');
    Perm.setDescricao('Editar registros');
    Perm.setNivelRequerido(1);
    Perm.setAtivo(True);
    Adicionar(Perm);
  end;

  if BuscarPorNome('DELETE') = nil then
  begin
    Perm := TPermissao.Create;
    Perm.setNome('DELETE');
    Perm.setDescricao('Excluir registros');
    Perm.setNivelRequerido(2);
    Perm.setAtivo(True);
    Adicionar(Perm);
  end;

  if BuscarPorNome('MANAGE_USERS') = nil then
  begin
    Perm := TPermissao.Create;
    Perm.setNome('MANAGE_USERS');
    Perm.setDescricao('Gerenciar usuários');
    Perm.setNivelRequerido(3);
    Perm.setAtivo(True);
    Adicionar(Perm);
  end;
end;

end.
