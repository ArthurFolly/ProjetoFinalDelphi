unit LoginUsuarioController;

interface

uses
TUsuarioRepository,TUsuarioModel,SysUtils;

type TLoginUsuarioController = class

private
FUsuarioRepository : UsuarioRepository;

public

  constructor Create;
  destructor Destroy;
  function Login(email, senha: String; var mensagemErro: String): TUsuario;

end;

implementation

{ TLoginUsuarioController }

constructor TLoginUsuarioController.Create;
begin
  inherited Create;
  FUsuarioRepository := UsuarioRepository.Create;
end;

destructor TLoginUsuarioController.Destroy;
begin
  FUsuarioRepository.Free;
  inherited Destroy;
end;

function TLoginUsuarioController.Login(email, senha: String;
  var mensagemErro: String): TUsuario;
begin
  Result := nil;
  mensagemErro := '';

   if Trim(email) = '' then begin
    mensagemErro := 'Email não pode estar vazio';
    Exit;
  end;

   if Trim(senha) = '' then begin
    mensagemErro := 'Senha não pode estar vazia';
    Exit;
  end;


    Result := FUsuarioRepository.AutenticarUsuario(email,senha);

    if Result = nil then
    mensagemErro := 'Email ou senha incorretos'



end;

end.
