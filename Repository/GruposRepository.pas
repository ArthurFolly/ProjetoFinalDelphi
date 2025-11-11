unit GruposRepository;

interface

uses
  ConexaoBanco, FireDAC.Comp.Client, FireDAC.DApt, GruposModel, System.SysUtils,
  System.Generics.Collections;

type
  TGruposRepository = class
  private
    query: TFDQuery;
  public
    constructor Create;
    destructor Destroy;

    function Adicionar(AGrupo: TGrupos): Boolean;
    function Atualizar(AGrupo: TGrupos): Boolean;
    function Excluir(AId: Integer): Boolean;
    function BuscarPorId(AId: Integer): TGrupos;
    function ListarTodos: TObjectList<TGrupos>;
    function BuscarPorNome(ANome: string): TObjectList<TGrupos>;
    function BuscarPorNivel(ANivel: Integer): TObjectList<TGrupos>;

    // Método para atualização via grid
    function AtualizarPorId(AId: Integer; ANome, ADescricao: string; AIdPermissao: Integer): Boolean;

    // Método para criação de grupos padrão
    function CriarGruposPadrao: Boolean;
  end;

implementation

constructor TGruposRepository.Create;
begin
  Inherited Create;
  Self.query := TFDQuery.Create(nil);
  Self.query.Connection := DataModule1.FDConnection1;
end;

destructor TGruposRepository.Destroy;
begin
  Self.query.Free;
  Inherited;
end;

function TGruposRepository.Adicionar(AGrupo: TGrupos): Boolean;
begin
  Result := False;

  Self.query.SQL.Clear;
  Self.query.SQL.Text := 'INSERT INTO "Grupos" (nome, descricao, id_permissao, data_criacao, ativo) ' +
                         'VALUES (:nome, :descricao, :id_permissao, :data_criacao, :ativo)';
  Self.query.ParamByName('nome').AsString := AGrupo.getNome;
  Self.query.ParamByName('descricao').AsString := AGrupo.getDescricao;
  Self.query.ParamByName('id_permissao').AsInteger := AGrupo.getIdPermissao;
  Self.query.ParamByName('data_criacao').AsDateTime := AGrupo.getDataCriacao;
  Self.query.ParamByName('ativo').AsBoolean := AGrupo.getAtivo;
  Self.query.ExecSQL;
  Result := Self.query.RowsAffected > 0;
end;

function TGruposRepository.Atualizar(AGrupo: TGrupos): Boolean;
begin
  Result := False;

  Self.query.SQL.Clear;
  Self.query.SQL.Text := 'UPDATE "Grupos" SET nome = :nome, descricao = :descricao, ' +
                         'id_permissao = :id_permissao, ativo = :ativo WHERE id_grupo = :id_grupo';
  Self.query.ParamByName('id_grupo').AsInteger := AGrupo.getId;
  Self.query.ParamByName('nome').AsString := AGrupo.getNome;
  Self.query.ParamByName('descricao').AsString := AGrupo.getDescricao;
  Self.query.ParamByName('id_permissao').AsInteger := AGrupo.getIdPermissao;
  Self.query.ParamByName('ativo').AsBoolean := AGrupo.getAtivo;
  Self.query.ExecSQL;
  Result := Self.query.RowsAffected > 0;
end;

function TGruposRepository.Excluir(AId: Integer): Boolean;
begin
  Result := False;

  Self.query.SQL.Clear;
  Self.query.SQL.Text := 'UPDATE "Grupos" SET ativo = FALSE WHERE id_grupo = :id_grupo';
  Self.query.ParamByName('id_grupo').AsInteger := AId;
  Self.query.ExecSQL;
  Result := Self.query.RowsAffected > 0;
end;

function TGruposRepository.BuscarPorId(AId: Integer): TGrupos;
begin
  Result := nil;

  Self.query.SQL.Clear;
  Self.query.SQL.Text := 'SELECT * FROM "Grupos" WHERE id_grupo = :id_grupo AND ativo = TRUE';
  Self.query.ParamByName('id_grupo').AsInteger := AId;
  Self.query.Open;

  if not Self.query.Eof then
  begin
    Result := TGrupos.Create;
    Result.setId(Self.query.FieldByName('id_grupo').AsInteger);
    Result.setNome(Self.query.FieldByName('nome').AsString);
    Result.setDescricao(Self.query.FieldByName('descricao').AsString);
    Result.setIdPermissao(Self.query.FieldByName('id_permissao').AsInteger);
    Result.setDataCriacao(Self.query.FieldByName('data_criacao').AsDateTime);
    Result.setAtivo(Self.query.FieldByName('ativo').AsBoolean);
  end;
  Self.query.Close;
end;

function TGruposRepository.ListarTodos: TObjectList<TGrupos>;
var
  Grupo: TGrupos;
begin
  Result := TObjectList<TGrupos>.Create(True);

  Self.query.SQL.Clear;
  Self.query.SQL.Text := 'SELECT * FROM "Grupos" WHERE ativo = TRUE ORDER BY id_permissao, nome';
  Self.query.Open;

  while not Self.query.Eof do
  begin
    Grupo := TGrupos.Create;
    Grupo.setId(Self.query.FieldByName('id_grupo').AsInteger);
    Grupo.setNome(Self.query.FieldByName('nome').AsString);
    Grupo.setDescricao(Self.query.FieldByName('descricao').AsString);
    Grupo.setIdPermissao(Self.query.FieldByName('id_permissao').AsInteger);
    Grupo.setDataCriacao(Self.query.FieldByName('data_criacao').AsDateTime);
    Grupo.setAtivo(Self.query.FieldByName('ativo').AsBoolean);

    Result.Add(Grupo);
    Self.query.Next;
  end;

  Self.query.Close;
end;

function TGruposRepository.BuscarPorNome(ANome: string): TObjectList<TGrupos>;
var
  Grupo: TGrupos;
begin
  Result := TObjectList<TGrupos>.Create(True);

  Self.query.SQL.Clear;
  Self.query.SQL.Text := 'SELECT * FROM "Grupos" WHERE nome LIKE :nome AND ativo = TRUE';
  Self.query.ParamByName('nome').AsString := '%' + ANome + '%';
  Self.query.Open;

  while not Self.query.Eof do
  begin
    Grupo := TGrupos.Create;
    Grupo.setId(Self.query.FieldByName('id_grupo').AsInteger);
    Grupo.setNome(Self.query.FieldByName('nome').AsString);
    Grupo.setDescricao(Self.query.FieldByName('descricao').AsString);
    Grupo.setIdPermissao(Self.query.FieldByName('id_permissao').AsInteger);
    Grupo.setDataCriacao(Self.query.FieldByName('data_criacao').AsDateTime);
    Grupo.setAtivo(Self.query.FieldByName('ativo').AsBoolean);

    Result.Add(Grupo);
    Self.query.Next;
  end;
  Self.query.Close;
end;

function TGruposRepository.BuscarPorNivel(ANivel: Integer): TObjectList<TGrupos>;
var
  Grupo: TGrupos;
begin
  Result := TObjectList<TGrupos>.Create(True);

  Self.query.SQL.Clear;
  Self.query.SQL.Text := 'SELECT * FROM "Grupos" WHERE id_permissao = :id_permissao AND ativo = TRUE';
  Self.query.ParamByName('id_permissao').AsInteger := ANivel;
  Self.query.Open;

  while not Self.query.Eof do
  begin
    Grupo := TGrupos.Create;
    Grupo.setId(Self.query.FieldByName('id_grupo').AsInteger);
    Grupo.setNome(Self.query.FieldByName('nome').AsString);
    Grupo.setDescricao(Self.query.FieldByName('descricao').AsString);
    Grupo.setIdPermissao(Self.query.FieldByName('id_permissao').AsInteger);
    Grupo.setDataCriacao(Self.query.FieldByName('data_criacao').AsDateTime);
    Grupo.setAtivo(Self.query.FieldByName('ativo').AsBoolean);

    Result.Add(Grupo);
    Self.query.Next;
  end;
  Self.query.Close;
end;

function TGruposRepository.AtualizarPorId(AId: Integer; ANome, ADescricao: string; AIdPermissao: Integer): Boolean;
begin
  Result := False;

  Self.query.SQL.Clear;
  Self.query.SQL.Text := 'UPDATE "Grupos" SET ' +
                         'nome = :nome, ' +
                         'descricao = :descricao, ' +
                         'id_permissao = :id_permissao ' +
                         'WHERE id_grupo = :id_grupo AND ativo = TRUE';

  Self.query.ParamByName('id_grupo').AsInteger := AId;
  Self.query.ParamByName('nome').AsString := ANome;
  Self.query.ParamByName('descricao').AsString := ADescricao;
  Self.query.ParamByName('id_permissao').AsInteger := AIdPermissao;

  Self.query.ExecSQL;
  Result := Self.query.RowsAffected > 0;
end;

function TGruposRepository.CriarGruposPadrao: Boolean;
var
  grupo: TGrupos;
begin
  Result := True;

  try
    // Criar grupo Usuário (ID Permissão 1)
    grupo := TGrupos.Create;
    try
      grupo.setNome('Usuário');
      grupo.setDescricao('Acesso básico: Criar, Ler, Atualizar registros');
      grupo.setIdPermissao(1);
      grupo.setDataCriacao(Now);
      grupo.setAtivo(True);
      Result := Result and Self.Adicionar(grupo);
    finally
      grupo.Free;
    end;

    // Criar grupo Supervisor (ID Permissão 2)
    grupo := TGrupos.Create;
    try
      grupo.setNome('Supervisor');
      grupo.setDescricao('Acesso intermediário: Todas as operações CRUD');
      grupo.setIdPermissao(2);
      grupo.setDataCriacao(Now);
      grupo.setAtivo(True);
      Result := Result and Self.Adicionar(grupo);
    finally
      grupo.Free;
    end;

    // Criar grupo Administrador (ID Permissão 3)
    grupo := TGrupos.Create;
    try
      grupo.setNome('Administrador');
      grupo.setDescricao('Acesso total: Todas as operações incluindo gerenciamento de usuários');
      grupo.setIdPermissao(3);
      grupo.setDataCriacao(Now);
      grupo.setAtivo(True);
      Result := Result and Self.Adicionar(grupo);
    finally
      grupo.Free;
    end;

  except
    Result := False;
  end;
end;

end.
