unit TUsuarioModel;

interface

Type TUsuario = Class
  Id : Integer;
  Nome : String;
  Email : String;
  Telefone : String;
  CPF : String;
function getNome :String;
procedure setNome (aNome:String);
function getEmail :String;
procedure setEmail (aEmail:String);
function getTelefone :String;
procedure setTelefone (aTelefone:String);
function getCPF :String;
procedure setCPF (aCPF:String);



End;

implementation

{ TUsuario }

function TUsuario.getCPF: String;
begin
  result := Self.Nome;
end;

function TUsuario.getEmail: String;
begin
  result := Self.Email;
end;

function TUsuario.getNome: String;
begin
  result := Self.Nome;
end;

function TUsuario.getTelefone: String;
begin
  result := Self.Telefone;
end;

procedure TUsuario.setCPF(aCPF: String);
begin
  aCPF := Self.CPF
end;

procedure TUsuario.setEmail(aEmail: String);
begin
  aEmail := Self.Email
end;

procedure TUsuario.setNome(aNome: String);
begin
  aNome := Self.Nome
end;

procedure TUsuario.setTelefone(aTelefone: String);
begin
  aTelefone := Self.Telefone
end;

end.
