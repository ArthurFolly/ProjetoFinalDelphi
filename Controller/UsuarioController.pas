unit UsuarioController;

interface

uses
  FireDAC.Comp.Client,
  System.SysUtils,
  System.Generics.Collections,
  System.Hash,          // << ADICIONE ESTA LINHA
  TUsuarioModel;

type
  TUsuarioController = class
  private
    FConn: TFDConnection;
    function HashSenha(const Senha: string): string;
  public
    constructor Create(AConexao: TFDConnection);
    destructor Destroy; override;

    function Login(const Email, Senha: string; out Nome: string; out Nivel, IdUsuario: Integer): Boolean;
    function ListarUsuarios: TFDQuery;
    function ListarTodasPermissoes: TFDQuery;
    function ListarTodos: TObjectList<TUsuario>;
    function GetPermissoesDoUsuario(ID: Integer): TList<Integer>;

    function AdicionarUsuario(const ANome, AEmail, ASenha, ATelefone: string;
      AAtivo: Boolean; ANivel: Integer): Boolean;

    function AtualizarUsuario(AUsuario: TUsuario): Boolean;

    function SalvarUsuario(
      ID: Integer;
      const Nome, Email, Senha, Telefone: string;
      Nivel: Integer;
      Ativo: Boolean;
      PermissoesSelecionadas: TList<Integer>
    ): Boolean;

    function ExcluirUsuario(ID: Integer): Boolean;
    function BuscarPorId(Id: Integer): TUsuario;
  end;

implementation



{ TUsuarioController }

constructor TUsuarioController.Create(AConexao: TFDConnection);
begin
  inherited Create;
  FConn := AConexao;
end;

destructor TUsuarioController.Destroy;
begin
  inherited;
end;

function TUsuarioController.HashSenha(const Senha: string): string;
begin
  if Trim(Senha) = '' then
    Exit('');

  // Mesmo algoritmo do TUsuarioRepository e do Arthur: MD5
  Result := THashMD5.GetHashString(Senha);
end;


function TUsuarioController.Login(const Email, Senha: string;
  out Nome: string; out Nivel, IdUsuario: Integer): Boolean;
var
  Q: TFDQuery;
begin
  Result := False;
  Q := TFDQuery.Create(nil);
  try
    Q.Connection := FConn;
    Q.SQL.Text :=
      'SELECT id_usuario, nome, nivel_usuario FROM "Usuario" ' +
      'WHERE email = :e AND senha_hash = :s AND ativo = true';

    Q.ParamByName('e').AsString := Email;
    Q.ParamByName('s').AsString := HashSenha(Senha);
    Q.Open;

    if not Q.IsEmpty then
    begin
      IdUsuario := Q.FieldByName('id_usuario').AsInteger;
      Nome      := Q.FieldByName('nome').AsString;
      Nivel     := Q.FieldByName('nivel_usuario').AsInteger;
      Result    := True;
    end;
  finally
    Q.Free;
  end;
end;

function TUsuarioController.ListarUsuarios: TFDQuery;
begin
  Result := TFDQuery.Create(nil);
  Result.Connection := FConn;
  Result.SQL.Text :=
    'SELECT id_usuario, nome, email, telefone, nivel_usuario, ativo, criado_em, atualizado_em ' +
    'FROM "Usuario" ORDER BY nome';
  Result.Open;
end;

function TUsuarioController.ListarTodasPermissoes: TFDQuery;
begin
  Result := TFDQuery.Create(nil);
  Result.Connection := FConn;
  Result.SQL.Text := 'SELECT id_permissao, nome FROM "Permissoes" ORDER BY nome';
  Result.Open;
end;

function TUsuarioController.ListarTodos: TObjectList<TUsuario>;
var
  Q: TFDQuery;
  U: TUsuario;
begin
  Result := TObjectList<TUsuario>.Create(True);
  Q := ListarUsuarios;
  try
    Q.First;
    while not Q.Eof do
    begin
      U := TUsuario.Create;
      U.Id            := Q.FieldByName('id_usuario').AsInteger;
      U.Nome          := Q.FieldByName('nome').AsString;
      U.Email         := Q.FieldByName('email').AsString;
      U.Telefone      := Q.FieldByName('telefone').AsString;
      U.NivelUsuario  := Q.FieldByName('nivel_usuario').AsInteger;
      U.Ativo         := Q.FieldByName('ativo').AsBoolean;
      U.CriadoEm      := Q.FieldByName('criado_em').AsDateTime;
      U.AtualizadoEm  := Q.FieldByName('atualizado_em').AsDateTime;
      Result.Add(U);
      Q.Next;
    end;
  finally
    Q.Free;
  end;
end;

function TUsuarioController.GetPermissoesDoUsuario(ID: Integer): TList<Integer>;
var
  Q: TFDQuery;
begin
  Result := TList<Integer>.Create;
  Q := TFDQuery.Create(nil);
  try
    Q.Connection := FConn;
    Q.SQL.Text := 'SELECT id_permissao FROM usuario_permissoes WHERE id_usuario = :id';
    Q.ParamByName('id').AsInteger := ID;
    Q.Open;
    while not Q.Eof do
    begin
      Result.Add(Q.FieldByName('id_permissao').AsInteger);
      Q.Next;
    end;
  finally
    Q.Free;
  end;
end;

function TUsuarioController.BuscarPorId(Id: Integer): TUsuario;
var
  Q: TFDQuery;
begin
  Result := nil;
  Q := TFDQuery.Create(nil);
  try
    Q.Connection := FConn;
    Q.SQL.Text :=
      'SELECT id_usuario, nome, email, telefone, nivel_usuario, ativo, criado_em, atualizado_em ' +
      'FROM "Usuario" WHERE id_usuario = :id';
    Q.ParamByName('id').AsInteger := Id;
    Q.Open;

    if not Q.IsEmpty then
    begin
      Result := TUsuario.Create;
      Result.Id            := Q.FieldByName('id_usuario').AsInteger;
      Result.Nome          := Q.FieldByName('nome').AsString;
      Result.Email         := Q.FieldByName('email').AsString;
      Result.Telefone      := Q.FieldByName('telefone').AsString;
      Result.NivelUsuario  := Q.FieldByName('nivel_usuario').AsInteger;
      Result.Ativo         := Q.FieldByName('ativo').AsBoolean;
      Result.CriadoEm      := Q.FieldByName('criado_em').AsDateTime;
      Result.AtualizadoEm  := Q.FieldByName('atualizado_em').AsDateTime;
    end;
  finally
    Q.Free;
  end;
end;

function TUsuarioController.AdicionarUsuario(const ANome, AEmail, ASenha, ATelefone: string;
  AAtivo: Boolean; ANivel: Integer): Boolean;
var
  ListaVazia: TList<Integer>;
begin
  ListaVazia := TList<Integer>.Create;
  try
    Result := SalvarUsuario(0, ANome, AEmail, ASenha, ATelefone, ANivel, AAtivo, ListaVazia);
  finally
    ListaVazia.Free;
  end;
end;

function TUsuarioController.AtualizarUsuario(AUsuario: TUsuario): Boolean;
var
  PermissoesAtuais: TList<Integer>;
begin
  // Mantém as permissões que já estavam marcadas (ou você pode passar uma lista nova do form)
  PermissoesAtuais := GetPermissoesDoUsuario(AUsuario.Id);
  try
    Result := SalvarUsuario(
      AUsuario.Id,
      AUsuario.Nome,
      AUsuario.Email,
      AUsuario.Senha,        // geralmente vem vazio no edit
      AUsuario.Telefone,
      AUsuario.NivelUsuario,
      AUsuario.Ativo,
      PermissoesAtuais
    );
  finally
    PermissoesAtuais.Free;
  end;
end;

function TUsuarioController.ExcluirUsuario(ID: Integer): Boolean;
var
  Q: TFDQuery;
begin
  Result := False;

  FConn.StartTransaction;
  try
    Q := TFDQuery.Create(nil);
    try
      Q.Connection := FConn;

      // Exclui o usuário diretamente da tabela "Usuario"
      Q.SQL.Text := 'DELETE FROM "Usuario" WHERE id_usuario = :id';
      Q.ParamByName('id').AsInteger := ID;
      Q.ExecSQL;

      // Se nenhuma linha foi afetada, algo deu errado (ID inexistente)
      if Q.RowsAffected = 0 then
      begin
        FConn.Rollback;
        Exit(False);
      end;

    finally
      Q.Free;
    end;

    FConn.Commit;
    Result := True;
  except
    on E: Exception do
    begin
      if FConn.InTransaction then
        FConn.Rollback;
      raise; // deixa a mensagem subir para o formulário
    end;
  end;
end;

function TUsuarioController.SalvarUsuario(
  ID: Integer;
  const Nome, Email, Senha, Telefone: string;
  Nivel: Integer;
  Ativo: Boolean;
  PermissoesSelecionadas: TList<Integer>): Boolean;
var
  Q: TFDQuery;
  NovoID: Integer;
  SenhaHash: string;
begin
  Result := False;

  // Gera o hash só se tiver senha digitada
  SenhaHash := '';
  if Trim(Senha) <> '' then
    SenhaHash := HashSenha(Senha);

  FConn.StartTransaction;
  Q := TFDQuery.Create(nil);
  try
    Q.Connection := FConn;

    // ========== INSERT ==========
    if ID = 0 then
    begin
      Q.SQL.Text :=
        'INSERT INTO "Usuario" ' +
        ' (nome, email, telefone, nivel_usuario, ativo, criado_em, atualizado_em, senha_hash) ' +
        'VALUES ' +
        ' (:nome, :email, :tel, :nivel, :ativo, NOW(), NOW(), :senha_hash) ' +
        'RETURNING id_usuario';

      Q.ParamByName('nome').AsString       := Nome;
      Q.ParamByName('email').AsString      := Email;
      Q.ParamByName('tel').AsString        := Telefone;
      Q.ParamByName('nivel').AsInteger     := Nivel;
      Q.ParamByName('ativo').AsBoolean     := Ativo;
      Q.ParamByName('senha_hash').AsString := SenhaHash;

      Q.Open;
      NovoID := Q.FieldByName('id_usuario').AsInteger;
      Q.Close;
    end
    // ========== UPDATE ==========
    else
    begin
      Q.SQL.Clear;
      Q.SQL.Add('UPDATE "Usuario"');
      Q.SQL.Add('   SET nome          = :nome,');
      Q.SQL.Add('       email         = :email,');
      Q.SQL.Add('       telefone      = :tel,');
      Q.SQL.Add('       nivel_usuario = :nivel,');
      Q.SQL.Add('       ativo         = :ativo,');

      // Só troca a senha se o usuário digitou uma nova
      if SenhaHash <> '' then
        Q.SQL.Add('       senha_hash    = :senha_hash,');

      Q.SQL.Add('       atualizado_em  = NOW()');
      Q.SQL.Add(' WHERE id_usuario = :id');

      Q.ParamByName('id').AsInteger    := ID;
      Q.ParamByName('nome').AsString   := Nome;
      Q.ParamByName('email').AsString  := Email;
      Q.ParamByName('tel').AsString    := Telefone;
      Q.ParamByName('nivel').AsInteger := Nivel;
      Q.ParamByName('ativo').AsBoolean := Ativo;
      if SenhaHash <> '' then
        Q.ParamByName('senha_hash').AsString := SenhaHash;

      Q.ExecSQL;
      NovoID := ID;
    end;

    // ?? NESTA VERSÃO NÃO EXISTE MAIS NADA DE PERMISSÕES
    // Não mexe com usuario_permissoes, pois você não usa essa tabela agora.

    FConn.Commit;
    Result := True;
  except
    on E: Exception do
    begin
      if FConn.InTransaction then
        FConn.Rollback;
      raise Exception.Create('Erro ao salvar usuário: ' + E.Message);
    end;
  end;

  Q.Free;
end;





end.
