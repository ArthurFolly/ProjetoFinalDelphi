unit TContatosModel;

interface

type
  Contatos = class
  public
    Id: Integer;
    Nome: String;
    Email: String;
    Telefone: String;
    Endereco: String;
    Empresa: String;
    IdEmpresa : Integer;
    Observacoes: String;
    Favorito: Boolean;
    Ativo: Boolean;
    CEP: String;
    Logradouro: String;
    Numero: String;
    Complemento: String;
    Bairro: String;
    Cidade: String;
    UF: String;

    // === GETTERS ===
    function getId: Integer;
    function getNome: String;
    function getEmail: String;
    function getTelefone: String;
    function getEndereco: String;
    function getEmpresa: String;
    function getObservacoes: String;
    function getFavorito: Boolean;
    function getAtivo: Boolean;
    function getCEP: String;
    function getLogradouro: String;
    function getNumero: String;
    function getComplemento: String;
    function getBairro: String;
    function getCidade: String;
    function getUF: String;
    function getIdEmpresa:Integer;



    // === SETTERS ===
    procedure setId(AId: Integer);
    procedure setNome(ANome: String);
    procedure setEmail(AEmail: String);
    procedure setTelefone(ATelefone: String);
    procedure setEndereco(AEndereco: String);
    procedure setEmpresa(AEmpresa: String);
    procedure setObservacoes(AObservacoes: String);
    procedure setFavorito(AFavorito: Boolean);
    procedure setAtivo(AAtivo: Boolean);
    procedure setCEP(ACEP: String);
    procedure setLogradouro(ALogradouro: String);
    procedure setNumero(ANumero: String);
    procedure setComplemento(AComplemento: String);
    procedure setBairro(ABairro: String);
    procedure setCidade(ACidade: String);
    procedure setUF(AUF: String);
    procedure setIdEmpresa(AIdEmpresa:Integer);
  end;

implementation

{ Contatos }

// === GETTERS ===
function Contatos.getId: Integer;
begin
  Result := Id;
end;

function Contatos.getIdEmpresa: Integer;
begin
   Result := IdEmpresa;
end;

function Contatos.getNome: String;
begin
  Result := Nome;
end;

function Contatos.getEmail: String;
begin
  Result := Email;
end;

function Contatos.getTelefone: String;
begin
  Result := Telefone;
end;

function Contatos.getEndereco: String;
begin
  Result := Endereco;
end;

function Contatos.getEmpresa: String;
begin
  Result := Empresa;
end;

function Contatos.getObservacoes: String;
begin
  Result := Observacoes;
end;

function Contatos.getFavorito: Boolean;
begin
  Result := Favorito;
end;

function Contatos.getAtivo: Boolean;
begin
  Result := Ativo;
end;

function Contatos.getCEP: String;
begin
  Result := CEP;
end;

function Contatos.getLogradouro: String;
begin
  Result := Logradouro;
end;

function Contatos.getNumero: String;
begin
  Result := Numero;
end;

function Contatos.getComplemento: String;
begin
  Result := Complemento;
end;

function Contatos.getBairro: String;
begin
  Result := Bairro;
end;

function Contatos.getCidade: String;
begin
  Result := Cidade;
end;

function Contatos.getUF: String;
begin
  Result := UF;
end;

// === SETTERS ===
procedure Contatos.setId(AId: Integer);
begin
  Id := AId;
end;

procedure Contatos.setIdEmpresa(AIdEmpresa: Integer);
begin
 IdEmpresa := AIdEmpresa;
end;

procedure Contatos.setNome(ANome: String);
begin
  Nome := ANome;
end;

procedure Contatos.setEmail(AEmail: String);
begin
  Email := AEmail;
end;

procedure Contatos.setTelefone(ATelefone: String);
begin
  Telefone := ATelefone;
end;

procedure Contatos.setEndereco(AEndereco: String);
begin
  Endereco := AEndereco;
end;

procedure Contatos.setEmpresa(AEmpresa: String);
begin
  Empresa := AEmpresa;
end;

procedure Contatos.setObservacoes(AObservacoes: String);
begin
  Observacoes := AObservacoes;
end;

procedure Contatos.setFavorito(AFavorito: Boolean);
begin
  Favorito := AFavorito;
end;

procedure Contatos.setAtivo(AAtivo: Boolean);
begin
  Ativo := AAtivo;
end;

procedure Contatos.setCEP(ACEP: String);
begin
  CEP := ACEP;
end;

procedure Contatos.setLogradouro(ALogradouro: String);
begin
  Logradouro := ALogradouro;
end;

procedure Contatos.setNumero(ANumero: String);
begin
  Numero := ANumero;
end;

procedure Contatos.setComplemento(AComplemento: String);
begin
  Complemento := AComplemento;
end;

procedure Contatos.setBairro(ABairro: String);
begin
  Bairro := ABairro;
end;

procedure Contatos.setCidade(ACidade: String);
begin
  Cidade := ACidade;
end;

procedure Contatos.setUF(AUF: String);
begin
  UF := AUF;
end;

end.
