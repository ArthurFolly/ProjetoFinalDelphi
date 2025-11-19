unit TUsuarioModel;

interface

type
  TUsuario = class
  public
    Id           : Integer;
    Nome         : string;
    Email        : string;
    Telefone     : string;
    CPF          : string;
    Senha        : string;
    TipoUsuario  : string;
    NivelUsuario : Integer;
    Ativo        : Boolean;
    CriadoEm     : TDateTime;
    AtualizadoEm : TDateTime;

    constructor Create;

    // GETTERS
    function getId: Integer;
    function getNome: string;
    function getEmail: string;
    function getTelefone: string;
    function getNivelUsuario: Integer;
    function getAtivo: Boolean;
    function getCriadoEm: TDateTime;
    function getAtualizadoEm: TDateTime;
    function getSenha : String;

    // SETTERS
    procedure setNome(const Value: string);
    procedure setEmail(const Value: string);
    procedure setTelefone(const Value: string);
    procedure setNivelUsuario(Value: Integer);
    procedure setAtivo(Value: Boolean);
    procedure setSenha(const Value: string);   // AQUI ESTAVA FALTANDO!
  end;

implementation

constructor TUsuario.Create;
begin

end;

// GETTERS
function TUsuario.getId: Integer;
begin
  Result := Id;
end;

function TUsuario.getNome: string;
begin
  Result := Nome;
end;

function TUsuario.getSenha: String;
begin
  Result := Senha;
end;

function TUsuario.getEmail: string;
begin
  Result := Email;
end;

function TUsuario.getTelefone: string;
begin
  Result := Telefone;
end;

function TUsuario.getNivelUsuario: Integer;
begin
  Result := NivelUsuario;
end;

function TUsuario.getAtivo: Boolean;
begin
  Result := Ativo;
end;

function TUsuario.getCriadoEm: TDateTime;
begin
  Result := CriadoEm;
end;

function TUsuario.getAtualizadoEm: TDateTime;
begin
  Result := AtualizadoEm;
end;

// SETTERS
procedure TUsuario.setNome(const Value: string);
begin
  Nome := Value;
end;

procedure TUsuario.setEmail(const Value: string);
begin
  Email := Value;
end;

procedure TUsuario.setTelefone(const Value: string);
begin
  Telefone := Value;
end;

procedure TUsuario.setNivelUsuario(Value: Integer);
begin
  NivelUsuario := Value;
end;

procedure TUsuario.setAtivo(Value: Boolean);
begin
  Ativo := Value;
end;

procedure TUsuario.setSenha(const Value: string);   // ESSA É A NOVA!
begin
  Senha := Value;
end;

end.
