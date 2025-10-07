unit TContatosModel;

interface

implementation

Type Contatos = Class

  Id : integer;
  Nome : String;
  Email : String;
  Telefone : String;
  Endereco: String;
  Empresa : String;
  Observacao : String;

  function getNome :String;
  procedure setNome (aNome:String);
  function getEmail :String;
  procedure setEmail (aEmail:String);
  function getTelefone :String;
  procedure setTelefone (aTelefone:String);
  function getEndereco :String;
  procedure setEndereco (aEndereco:String);
  function getEmpresa :String;
  procedure setEmpresa (aEmpresa:String);
  function getObservacao :String;
  procedure setObservacao (aObservacao:String);


End;

{ Contatos }

function Contatos.getEmail: String;
begin
  Result := Self.Email;
end;

function Contatos.getEmpresa: String;
begin
  Result := Self.Empresa;
end;

function Contatos.getEndereco: String;
begin
  Result := Self.Endereco;
end;

function Contatos.getNome: String;
begin
  Result := Self.Nome;
end;

function Contatos.getObservacao: String;
begin
  Result := Self.Observacao;
end;

function Contatos.getTelefone: String;
begin
  Result := Self.Telefone;
end;

procedure Contatos.setEmail(aEmail: String);
begin
  aEmail := Self.Email
end;

procedure Contatos.setEmpresa(aEmpresa: String);
begin
  aEmpresa := Self.Empresa;
end;

procedure Contatos.setEndereco(aEndereco: String);
begin
  aEndereco := Self.Endereco;
end;

procedure Contatos.setNome(aNome: String);
begin
  aNome := Self.Nome;
end;

procedure Contatos.setObservacao(aObservacao: String);
begin
  aObservacao :=  Self.Observacao;
end;

procedure Contatos.setTelefone(aTelefone: String);
begin
  aTelefone  := Self.Telefone;
end;

end.
