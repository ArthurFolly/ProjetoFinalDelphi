unit CadastroUsuarioController;

interface  uses CadastroUsuarioRepository,TUsuarioModel;

type UsuarioController = Class

private

repository : UsuarioRepository;


public
constructor  Create;

destructor Destroy;


function CadastrarUsuario (id:integer; senha,email,CPF,nome,numero: String) : TUsuario;


End;

implementation




{ UsuarioController }

function UsuarioController.CadastrarUsuario(id: integer; senha, email, CPF,
nome, numero: String): TUsuario;
begin

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
