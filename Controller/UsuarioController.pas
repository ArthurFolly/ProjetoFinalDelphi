unit UsuarioController;

interface

uses
  FireDAC.Comp.Client, System.SysUtils, System.Generics.Collections,TUsuarioModel;

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
    function AdicionarUsuario(const ANome, AEmail, ASenha, ATelefone: string; AAtivo: Boolean; ANivel: Integer): Boolean;
    function AtualizarUsuario(AUsuario: TUsuario): Boolean;
    function BuscarPorId(Id: Integer): TUsuario;

    function SalvarUsuario(
      ID: Integer;
      const Nome, Email, Senha, Telefone: string;
      Nivel: Integer;
      Ativo: Boolean;
      PermissoesSelecionadas: TList<Integer>
    ): Boolean;

    function ExcluirUsuario(ID: Integer): Boolean;

    function GetPermissoesDoUsuario(ID: Integer): TList<Integer>;
  end;

implementation

uses
  System.Hash;   // <<< ESSA LINHA TAVA FALTANDO !!!

{ TUsuarioController }

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
  ListaVazia: TList<Integer>;
begin
  ListaVazia := TList<Integer>.Create;
  try
    Result := SalvarUsuario(AUsuario.Id,
                            AUsuario.Nome,
                            AUsuario.Email,
                            AUsuario.Senha,
                            AUsuario.Telefone,
                            AUsuario.NivelUsuario,
                            AUsuario.Ativo,
                            ListaVazia);
  finally
    ListaVazia.Free;
  end;
end;

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

  Result := THashSHA2.GetHashString(Senha, SHA256);
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
      'WHERE email = :e AND senha = :s AND ativo = true';
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
  Q := ListarUsuarios;  // reaproveita o método que você já tem
  try
    Q.First;
    while not Q.Eof do
    begin
      U := TUsuario.Create;
      U.Id           := Q.FieldByName('id_usuario').AsInteger;
      U.Nome         := Q.FieldByName('nome').AsString;
      U.Email        := Q.FieldByName('email').AsString;
      U.Telefone     := Q.FieldByName('telefone').AsString;
      U.NivelUsuario := Q.FieldByName('nivel_usuario').AsInteger;
      U.Ativo        := Q.FieldByName('ativo').AsBoolean;
      U.CriadoEm     := Q.FieldByName('criado_em').AsDateTime;
      U.AtualizadoEm := Q.FieldByName('atualizado_em').AsDateTime;
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

function TUsuarioController.SalvarUsuario(
  ID: Integer;
  const Nome, Email, Senha, Telefone: string;
  Nivel: Integer;
  Ativo: Boolean;
  PermissoesSelecionadas: TList<Integer>): Boolean;
var
  Q: TFDQuery;
  NovoID: Integer;
  i: Integer;
begin
  Result := False;

  FConn.StartTransaction;
  try
    Q := TFDQuery.Create(nil);
    try
      Q.Connection := FConn;

      // ---------- SALVA USUÁRIO ----------
      if ID = 0 then   // INSERT
      begin
        Q.SQL.Text :=
          'INSERT INTO "Usuario" (nome, email, senha, telefone, nivel_usuario, ativo, criado_em, atualizado_em) ' +
          'VALUES (:nome, :email, :senha, :tel, :nivel, :ativo, NOW(), NOW()) ' +
          'RETURNING id_usuario';
        Q.ParamByName('senha').AsString := HashSenha(Senha);
      end
      else             // UPDATE
      begin
        Q.SQL.Text :=
          'UPDATE "Usuario" SET nome=:nome, email=:email, telefone=:tel, ' +
          'nivel_usuario=:nivel, ativo=:ativo, atualizado_em=NOW()';
        if Senha <> '' then
          Q.SQL.Text := Q.SQL.Text + ', senha=:senha';
        Q.SQL.Text := Q.SQL.Text + ' WHERE id_usuario=:id';

        Q.ParamByName('id').AsInteger := ID;
        if Senha <> '' then
          Q.ParamByName('senha').AsString := HashSenha(Senha);
      end;

      Q.ParamByName('nome').AsString   := Nome;
      Q.ParamByName('email').AsString  := Email;
      Q.ParamByName('tel').AsString    := Telefone;
      Q.ParamByName('nivel').AsInteger := Nivel;
      Q.ParamByName('ativo').AsBoolean := Ativo;
      Q.ExecSQL;

      if ID = 0 then
        NovoID := Q.Fields[0].AsInteger   // RETURNING
      else
        NovoID := ID;

      // ---------- LIMPA E REINSERE PERMISSÕES ----------
      Q.Close;
      Q.SQL.Text := 'DELETE FROM usuario_permissoes WHERE id_usuario = :id';
      Q.ParamByName('id').AsInteger := NovoID;
      Q.ExecSQL;

      for i := 0 to PermissoesSelecionadas.Count - 1 do
      begin
        Q.SQL.Text := 'INSERT INTO usuario_permissoes (id_usuario, id_permissao) VALUES (:u, :p)';
        Q.ParamByName('u').AsInteger := NovoID;
        Q.ParamByName('p').AsInteger := PermissoesSelecionadas[i];
        Q.ExecSQL;
      end;

    finally
      Q.Free;
    end;

    FConn.Commit;
    Result := True;
  except
    on E: Exception do
    begin
      FConn.Rollback;
      raise Exception.Create('Erro ao salvar usuário: ' + E.Message);
    end;
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

      Q.SQL.Text := 'UPDATE "Usuario" SET ativo = false, atualizado_em = NOW() WHERE id_usuario = :id';
      Q.ParamByName('id').AsInteger := ID;
      Q.ExecSQL;

      Q.SQL.Text := 'DELETE FROM usuario_permissoes WHERE id_usuario = :id';
      Q.ParamByName('id').AsInteger := ID;
      Q.ExecSQL;
    finally
      Q.Free;
    end;

    FConn.Commit;
    Result := True;
  except
    FConn.Rollback;
    raise;
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
      Result.Id := Q.FieldByName('id_usuario').AsInteger;
      Result.Nome := Q.FieldByName('nome').AsString;
      Result.Email := Q.FieldByName('email').AsString;
      Result.Telefone := Q.FieldByName('telefone').AsString;
      Result.NivelUsuario := Q.FieldByName('nivel_usuario').AsInteger;
      Result.Ativo := Q.FieldByName('ativo').AsBoolean;
      Result.CriadoEm := Q.FieldByName('criado_em').AsDateTime;
      Result.AtualizadoEm := Q.FieldByName('atualizado_em').AsDateTime;
    end;
  finally
    Q.Free;
  end;
end;

end.
