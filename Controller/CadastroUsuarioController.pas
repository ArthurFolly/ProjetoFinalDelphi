unit CadastroUsuarioController;

interface

uses TUsuarioRepository,TUsuarioModel,SysUtils;

type TUsuarioController = Class

private

repository : UsuarioRepository;


public
constructor  Create;

destructor Destroy;


function CadastrarUsuario(id: Integer; senha, email, CPF, nome, numero: String; var msgErro: String): Boolean;



End;

implementation




{ UsuarioController }



function TUsuarioController.CadastrarUsuario(id: Integer; senha, email, CPF,
  nome, numero: String; var msgErro: String): Boolean;
  var
  usuario :TUsuario;

begin
Result := False;
msgErro := '';

if Trim(nome) = '' then  begin
  msgErro := 'Nome não pode estar vazio';
  exit;
end;

if Trim(email) = '' then  begin
  msgErro:= 'Email não pode estar vazio';
  Exit;

end;

if Trim(numero) = '' then  begin
  msgErro:= 'O Campo numero não pode estar vazio';
  Exit;

end;
if Trim(senha) = '' then  begin
  msgErro:= 'O campo senha não pode estar vazio';
  Exit;

end;

usuario := TUsuario.Create;

try
  usuario.Id := Id;
  usuario.Nome := nome;
  usuario.Email := email;

  usuario.Telefone := numero;
  usuario.senha := senha;

  Result := repository.Salvar(usuario);
finally

usuario.Free;

end;



end;





constructor TUsuarioController.Create;
begin
inherited Create;

Self.repository := UsuarioRepository.Create;

end;

destructor TUsuarioController.Destroy;
begin

self.repository.Free;
Inherited Destroy;

end;



end.
