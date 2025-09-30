unit CadastroUsuarioController;

interface  uses CadastroUsuarioRepository,TUsuarioModel,SysUtils;

type UsuarioController = Class

private

repository : UsuarioRepository;


public
constructor  Create;

destructor Destroy;


function CadastrarUsuario(id: Integer; senha, email, CPF, nome, numero: String; var msgErro: String): Boolean;



End;

implementation




{ UsuarioController }



function UsuarioController.CadastrarUsuario(id: Integer; senha, email, CPF,
  nome, numero: String; var msgErro: String): Boolean;
  var
  usuario :TUsuario;

begin
Result := False;
msgErro := '';

if Trim(nome) = '' then  begin
  msgErro := 'Nome n�o pode estar vazio';
  exit;
end;

if Trim(email) = '' then  begin
  msgErro:= 'Email n�o pode estar vazio';
  Exit;

end;

if Trim(CPF) = '' then  begin
  msgErro:= 'O campo CPF n�o pode estar vazio';
  Exit;

end;
if Trim(numero) = '' then  begin
  msgErro:= 'O Campo numero n�o pode estar vazio';
  Exit;

end;
if Trim(senha) = '' then  begin
  msgErro:= 'O campo senha n�o pode estar vazio';
  Exit;

end;

usuario := TUsuario.Create;

try
  usuario.Id := Id;
  usuario.Nome := nome;
  usuario.Email := email;
  usuario.CPF := CPF;
  usuario.Telefone := numero;
  usuario.senha := senha;

  Result := repository.Salvar(usuario);
finally

usuario.Free;

end;



end;





constructor UsuarioController.Create;
begin
inherited Create;

Self.repository := UsuarioRepository.Create;

end;

destructor UsuarioController.Destroy;
begin

self.repository.Free;
Inherited Destroy;

end;



end.
