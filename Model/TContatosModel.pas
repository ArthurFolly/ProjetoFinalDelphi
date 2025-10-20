unit TContatosModel;

interface



Type Contatos = Class

  Id : integer;
  Nome : String;
  Email : String;
  Telefone : String;
  Endereco: String;
  Empresa : String;
  Observacoes : String;
  Favorito : Boolean;
  Id_usuario:Integer;
  Ativo : Boolean;

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
  function getFavorito :Boolean;
  procedure setFavorito (aFavorito:Boolean);
  function getAtivo :Boolean;
  procedure setAtivo (aAtivo:Boolean);

End;

implementation



{ Contatos }

function Contatos.getAtivo: Boolean;
begin
Result := Self.Ativo;
end;

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

function Contatos.getFavorito: Boolean;
begin
 Result := Self.Favorito;
end;

function Contatos.getNome: String;
begin
  Result := Self.Nome;
end;

function Contatos.getObservacao: String;
begin
  Result := Self.Observacoes;
end;

function Contatos.getTelefone: String;
begin
  Result := Self.Telefone;
end;

procedure Contatos.setAtivo(aAtivo: Boolean);
begin
aAtivo := Self.Ativo;
end;

procedure Contatos.setEmail(aEmail: String);
begin
aEmail := Self.Email;
end;

procedure Contatos.setEmpresa(aEmpresa: String);
begin
  aEmpresa := Self.Empresa;
end;

procedure Contatos.setEndereco(aEndereco: String);
begin
  aEndereco := Self.Endereco;
end;

procedure Contatos.setFavorito(aFavorito: Boolean);
begin
  aFavorito := self.Favorito;
end;

procedure Contatos.setNome(aNome: String);
begin
  aNome := Self.Nome;
end;

procedure Contatos.setObservacao(aObservacao: String);
begin
  aObservacao :=  Self.Observacoes;
end;

procedure Contatos.setTelefone(aTelefone: String);
begin
  aTelefone  := Self.Telefone;
end;

end.
