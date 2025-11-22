unit TUsuarioRepository;

interface

uses ConexaoBanco, firedac.Comp.Client, firedac.DApt,TUsuarioModel,SysUtils,System.Hash;



type UsuarioRepository = Class

private

query: TFDQuery;

function GerarHashSenha(senha: String): String;


public
constructor  Create;

destructor Destroy;

function  BuscarUsuarioPorId(id:integer): TUsuario;

function Salvar(usuario: TUsuario): Boolean;

function BuscarPorEmail(email:String):TUsuario;

function VerificarSenha (email,senha:string) : Boolean ;

function AutenticarUsuario (email,senha : String) :TUsuario;



End;

implementation



function UsuarioRepository.AutenticarUsuario(email, senha: String): TUsuario;
var
  Usuario  : TUsuario;
  senhaHash: String;
begin
  Result := nil;

  senhaHash := GerarHashSenha(senha);

  Self.query.Close;
  Self.query.SQL.Clear;
  Self.query.SQL.Text :=
    'SELECT id_usuario, nome, email, telefone, senha_hash, nivel_usuario, ativo ' +
    'FROM "Usuario" ' +
    'WHERE email = :email AND senha_hash = :senha_hash';

  Self.query.ParamByName('email').AsString      := email;
  Self.query.ParamByName('senha_hash').AsString := senhaHash;
  Self.query.Open;

  if not Self.query.IsEmpty then
  begin
    Usuario := TUsuario.Create;

    // campos básicos
    Usuario.Id       := Self.query.FieldByName('id_usuario').AsInteger;
    Usuario.Nome     := Self.query.FieldByName('nome').AsString;
    Usuario.Email    := Self.query.FieldByName('email').AsString;
    Usuario.Telefone := Self.query.FieldByName('telefone').AsString;
    Usuario.Senha    := Self.query.FieldByName('senha_hash').AsString;

    // **CAMPO QUE FALTAVA**  -> vem da coluna nivel_usuario do banco
    Usuario.NivelUsuario := Self.query.FieldByName('nivel_usuario').AsInteger;

    // opcional, mas recomendável
    Usuario.Ativo := Self.query.FieldByName('ativo').AsBoolean;

    Result := Usuario;
  end;

  Self.query.Close;
end;


function UsuarioRepository.BuscarPorEmail(email: String): TUsuario;
var Usuario: TUsuario;

begin
  Result := nil;

  Self.query.Close;
  Self.query.SQL.Clear;


  Self.query.SQL.Text := 'SELECT * FROM "Usuario" WHERE email = :email';
  Self.query.ParamByName('email').AsString := email;
  Self.query.Open();

  if not self.query.IsEmpty then begin
    Usuario := TUsuario.create;
    usuario.Email := Self.query.FieldByName('email').asString;
  end;

  Result := Usuario;


end;

function UsuarioRepository.BuscarUsuarioPorId(id: Integer): TUsuario;
var
  Usuario: TUsuario;
begin
  Result := nil;

  Self.query.Close;
  Self.query.SQL.Clear;
  Self.query.SQL.Text :=
    'SELECT id_usuario, nome, email, telefone, senha_hash, nivel_usuario, ativo ' +
    'FROM "Usuario" ' +
    'WHERE id_usuario = :id_usuario';

  Self.query.ParamByName('id_usuario').AsInteger := id;
  Self.query.Open;

  if not Self.query.IsEmpty then
  begin
    Usuario := TUsuario.Create;
    Usuario.Id           := Self.query.FieldByName('id_usuario').AsInteger;
    Usuario.Nome         := Self.query.FieldByName('nome').AsString;
    Usuario.Email        := Self.query.FieldByName('email').AsString;
    Usuario.Telefone     := Self.query.FieldByName('telefone').AsString;
    Usuario.Senha        := Self.query.FieldByName('senha_hash').AsString;
    Usuario.NivelUsuario := Self.query.FieldByName('nivel_usuario').AsInteger;
    Usuario.Ativo        := Self.query.FieldByName('ativo').AsBoolean;

    Result := Usuario;
  end;

  Self.query.Close;
end;


constructor UsuarioRepository.Create;
begin

  Inherited create;

  Self.query := TFDQuery.Create(nil);

  Self.query.Connection :=  DataModule1.FDConnection1;

end;

destructor UsuarioRepository.Destroy;
begin
  Self.query.Free;
  Inherited destroy;

end;

function UsuarioRepository.GerarHashSenha(senha: String): String;
begin

  Result := THashMD5.GetHashString(senha);

end;

function UsuarioRepository.Salvar(usuario: TUsuario): Boolean;
var
  senhaHash: String;
begin
  Result := False;


  senhaHash := GerarHashSenha(usuario.getSenha);

  try
    Self.query.SQL.Clear;
    Self.query.SQL.Text :=
      'INSERT INTO "Usuario" (email, nome, senha_hash, telefone, nivel_usuario) ' +
      'VALUES (:email, :nome, :senha_hash, :telefone, :nivel_usuario)';

    Self.query.ParamByName('email').AsString      := usuario.getEmail;
    Self.query.ParamByName('nome').AsString       := usuario.getNome;
    Self.query.ParamByName('senha_hash').AsString := senhaHash;
    Self.query.ParamByName('telefone').AsString   := usuario.getTelefone;
    Self.query.ParamByName('nivel_usuario').AsInteger := 1;

    Self.query.ExecSQL;
    Result := True;

  except
    Result := False;
  end;
end;

function UsuarioRepository.VerificarSenha(email, senha: string): Boolean;

var senhaHash: String;

begin
  Result := False;
  senhaHash := GerarHashSenha(senha);

  Self.query.SQL.Clear;
  Self.query.SQL.Text := 'SELECT * FROM "Usuario" WHERE email = :email AND senha_hash = :senha_hash';
  Self.query.ParamByName('email').AsString := email;
  Self.query.ParamByName('senha_hash').asString := senhaHash;
  Self.query.Open();


  Result := query.FieldByName('total').AsInteger > 0;
  Self.query.Close;


end;

end.


