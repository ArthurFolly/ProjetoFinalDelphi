unit PermissoesRepository;

interface

uses
  ConexaoBanco, FireDAC.Comp.Client, FireDAC.DApt, PermissoesModel, System.SysUtils,
  System.Generics.Collections;

type
  TPermissoesRepository = class
  private
    query: TFDQuery;
  public
    constructor Create;
    destructor Destroy; override;

    function Adicionar(APermissao: TPermissao): Boolean;
    function Atualizar(APermissao: TPermissao): Boolean;
    function Excluir(AId: Integer): Boolean;
    function BuscarPorId(AId: Integer): TPermissao;
    function ListarTodas: TObjectList<TPermissao>;
    function BuscarPorNome(ANome: string): TObjectList<TPermissao>;
    function BuscarPorNivel(ANivel: Integer): TObjectList<TPermissao>;

    // Métodos específicos para validação
    function VerificarPermissao(AOperacao: string; ANivelUsuario: Integer): Boolean;
    function BuscarPermissaoPorOperacao(AOperacao: string): TPermissao;

    // Método para criar as permissões padrão
    function CriarPermissoesPadrao: Boolean;
  end;

implementation

{ ========================== CONSTRUTOR / DESTRUTOR ========================== }

constructor TPermissoesRepository.Create;
begin
  inherited Create;
  Self.query := TFDQuery.Create(nil);
  Self.query.Connection := DataModule1.FDConnection1;
end;

destructor TPermissoesRepository.Destroy;
begin
  Self.query.Free;
  inherited Destroy;
end;

{ ========================== CRUD BÁSICO ========================== }

function TPermissoesRepository.Adicionar(APermissao: TPermissao): Boolean;
begin
  Result := False;

  Self.query.SQL.Clear;
  Self.query.SQL.Text :=
    'INSERT INTO "Permissoes" (nome, descricao, nivel_requerido, ativo) ' +
    'VALUES (:nome, :descricao, :nivel_requerido, :ativo)';

  Self.query.ParamByName('nome').AsString := APermissao.getNome;
  Self.query.ParamByName('descricao').AsString := APermissao.getDescricao;
  Self.query.ParamByName('nivel_requerido').AsInteger := APermissao.getNivelRequerido;
  Self.query.ParamByName('ativo').AsBoolean := APermissao.getAtivo;
  Self.query.ExecSQL;

  Result := Self.query.RowsAffected > 0;
end;

function TPermissoesRepository.Atualizar(APermissao: TPermissao): Boolean;
begin
  Result := False;

  Self.query.SQL.Clear;
  Self.query.SQL.Text :=
    'UPDATE "Permissoes" SET nome = :nome, descricao = :descricao, ' +
    'nivel_requerido = :nivel_requerido, ativo = :ativo ' +
    'WHERE id_permissao = :id_permissao';

  Self.query.ParamByName('id_permissao').AsInteger := APermissao.getId;
  Self.query.ParamByName('nome').AsString := APermissao.getNome;
  Self.query.ParamByName('descricao').AsString := APermissao.getDescricao;
  Self.query.ParamByName('nivel_requerido').AsInteger := APermissao.getNivelRequerido;
  Self.query.ParamByName('ativo').AsBoolean := APermissao.getAtivo;
  Self.query.ExecSQL;

  Result := Self.query.RowsAffected > 0;
end;

function TPermissoesRepository.Excluir(AId: Integer): Boolean;
begin
  Result := False;

  Self.query.SQL.Clear;
  Self.query.SQL.Text := 'UPDATE "Permissoes" SET ativo = FALSE WHERE id_permissao = :id_permissao';
  Self.query.ParamByName('id_permissao').AsInteger := AId;
  Self.query.ExecSQL;

  Result := Self.query.RowsAffected > 0;
end;

{ ========================== BUSCAS ========================== }

function TPermissoesRepository.BuscarPorId(AId: Integer): TPermissao;
begin
  Result := nil;

  Self.query.SQL.Clear;
  Self.query.SQL.Text :=
    'SELECT * FROM "Permissoes" WHERE id_permissao = :id_permissao AND ativo = TRUE';
  Self.query.ParamByName('id_permissao').AsInteger := AId;
  Self.query.Open;

  if not Self.query.Eof then
  begin
    Result := TPermissao.Create;
    Result.setId(Self.query.FieldByName('id_permissao').AsInteger);
    Result.setNome(Self.query.FieldByName('nome').AsString);
    Result.setDescricao(Self.query.FieldByName('descricao').AsString);
    Result.setNivelRequerido(Self.query.FieldByName('nivel_requerido').AsInteger);
    Result.setAtivo(Self.query.FieldByName('ativo').AsBoolean);
  end;

  Self.query.Close;
end;

function TPermissoesRepository.ListarTodas: TObjectList<TPermissao>;
var
  Permissao: TPermissao;
begin
  Result := TObjectList<TPermissao>.Create(True);

  Self.query.SQL.Clear;
  Self.query.SQL.Text :=
    'SELECT * FROM "Permissoes" WHERE ativo = TRUE ORDER BY nivel_requerido, nome';
  Self.query.Open;

  while not Self.query.Eof do
  begin
    Permissao := TPermissao.Create;
    Permissao.setId(Self.query.FieldByName('id_permissao').AsInteger);
    Permissao.setNome(Self.query.FieldByName('nome').AsString);
    Permissao.setDescricao(Self.query.FieldByName('descricao').AsString);
    Permissao.setNivelRequerido(Self.query.FieldByName('nivel_requerido').AsInteger);
    Permissao.setAtivo(Self.query.FieldByName('ativo').AsBoolean);

    Result.Add(Permissao);
    Self.query.Next;
  end;

  Self.query.Close;
end;

function TPermissoesRepository.BuscarPorNome(ANome: string): TObjectList<TPermissao>;
var
  Permissao: TPermissao;
begin
  Result := TObjectList<TPermissao>.Create(True);

  Self.query.SQL.Clear;
  Self.query.SQL.Text :=
    'SELECT * FROM "Permissoes" WHERE nome LIKE :nome AND ativo = TRUE';
  Self.query.ParamByName('nome').AsString := '%' + ANome + '%';
  Self.query.Open;

  while not Self.query.Eof do
  begin
    Permissao := TPermissao.Create;
    Permissao.setId(Self.query.FieldByName('id_permissao').AsInteger);
    Permissao.setNome(Self.query.FieldByName('nome').AsString);
    Permissao.setDescricao(Self.query.FieldByName('descricao').AsString);
    Permissao.setNivelRequerido(Self.query.FieldByName('nivel_requerido').AsInteger);
    Permissao.setAtivo(Self.query.FieldByName('ativo').AsBoolean);

    Result.Add(Permissao);
    Self.query.Next;
  end;

  Self.query.Close;
end;

function TPermissoesRepository.BuscarPorNivel(ANivel: Integer): TObjectList<TPermissao>;
var
  Permissao: TPermissao;
begin
  Result := TObjectList<TPermissao>.Create(True);

  Self.query.SQL.Clear;
  Self.query.SQL.Text :=
    'SELECT * FROM "Permissoes" WHERE nivel_requerido = :nivel AND ativo = TRUE';
  Self.query.ParamByName('nivel').AsInteger := ANivel;
  Self.query.Open;

  while not Self.query.Eof do
  begin
    Permissao := TPermissao.Create;
    Permissao.setId(Self.query.FieldByName('id_permissao').AsInteger);
    Permissao.setNome(Self.query.FieldByName('nome').AsString);
    Permissao.setDescricao(Self.query.FieldByName('descricao').AsString);
    Permissao.setNivelRequerido(Self.query.FieldByName('nivel_requerido').AsInteger);
    Permissao.setAtivo(Self.query.FieldByName('ativo').AsBoolean);

    Result.Add(Permissao);
    Self.query.Next;
  end;

  Self.query.Close;
end;

{ ========================== VALIDAÇÃO DE PERMISSÃO ========================== }

function TPermissoesRepository.VerificarPermissao(AOperacao: string; ANivelUsuario: Integer): Boolean;
var
  permissao: TPermissao;
begin
  Result := False;

  permissao := BuscarPermissaoPorOperacao(AOperacao);

  // Se a permissão não existir, cria padrão e tenta novamente
  if not Assigned(permissao) then
  begin
    Self.CriarPermissoesPadrao;
    permissao := BuscarPermissaoPorOperacao(AOperacao);
  end;

  if Assigned(permissao) then
  begin
    Result := ANivelUsuario >= permissao.getNivelRequerido;
    permissao.Free;
  end;
end;

function TPermissoesRepository.BuscarPermissaoPorOperacao(AOperacao: string): TPermissao;
begin
  Result := nil;

  Self.query.SQL.Clear;
  Self.query.SQL.Text :=
    'SELECT * FROM "Permissoes" WHERE UPPER(nome) = UPPER(:nome) AND ativo = TRUE';
  Self.query.ParamByName('nome').AsString := AOperacao;
  Self.query.Open;

  if not Self.query.Eof then
  begin
    Result := TPermissao.Create;
    Result.setId(Self.query.FieldByName('id_permissao').AsInteger);
    Result.setNome(Self.query.FieldByName('nome').AsString);
    Result.setDescricao(Self.query.FieldByName('descricao').AsString);
    Result.setNivelRequerido(Self.query.FieldByName('nivel_requerido').AsInteger);
    Result.setAtivo(Self.query.FieldByName('ativo').AsBoolean);
  end;

  Self.query.Close;
end;

{ ========================== PERMISSÕES PADRÃO ========================== }

function TPermissoesRepository.CriarPermissoesPadrao: Boolean;
var
  permissao: TPermissao;
begin
  Result := True;
  try
    // CREATE
    permissao := TPermissao.Create;
    try
      permissao.setNome('CREATE');
      permissao.setDescricao('Cadastrar registros');
      permissao.setNivelRequerido(1);
      permissao.setAtivo(True);
      Result := Result and Self.Adicionar(permissao);
    finally
      permissao.Free;
    end;

    // READ
    permissao := TPermissao.Create;
    try
      permissao.setNome('READ');
      permissao.setDescricao('Consultar registros');
      permissao.setNivelRequerido(1);
      permissao.setAtivo(True);
      Result := Result and Self.Adicionar(permissao);
    finally
      permissao.Free;
    end;

    // UPDATE
    permissao := TPermissao.Create;
    try
      permissao.setNome('UPDATE');
      permissao.setDescricao('Alterar registros');
      permissao.setNivelRequerido(1);
      permissao.setAtivo(True);
      Result := Result and Self.Adicionar(permissao);
    finally
      permissao.Free;
    end;

    // DELETE
    permissao := TPermissao.Create;
    try
      permissao.setNome('DELETE');
      permissao.setDescricao('Excluir registros');
      permissao.setNivelRequerido(2);
      permissao.setAtivo(True);
      Result := Result and Self.Adicionar(permissao);
    finally
      permissao.Free;
    end;

    // MANAGE_USERS
    permissao := TPermissao.Create;
    try
      permissao.setNome('MANAGE_USERS');
      permissao.setDescricao('Gerenciar Usuários (níveis)');
      permissao.setNivelRequerido(3);
      permissao.setAtivo(True);
      Result := Result and Self.Adicionar(permissao);
    finally
      permissao.Free;
    end;

    // DEFINE_SUPERVISORS
    permissao := TPermissao.Create;
    try
      permissao.setNome('DEFINE_SUPERVISORS');
      permissao.setDescricao('Definir Supervisores');
      permissao.setNivelRequerido(3);
      permissao.setAtivo(True);
      Result := Result and Self.Adicionar(permissao);
    finally
      permissao.Free;
    end;

  except
    Result := False;
  end;
end;

end.

