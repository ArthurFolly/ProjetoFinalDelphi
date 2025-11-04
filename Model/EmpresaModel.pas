unit EmpresaModel;

interface

type
  TEmpresa = class
  public
    Codigo   : Integer;
    Nome     : string;
    UF       : string;
    CNPJ     : string;
    Telefone : string;
    Endereco : string;
    Email    : string;

    function  getCodigo: Integer;
    procedure setCodigo(aCodigo: Integer);
    function  getNome: string;
    procedure setNome(aNome: string);
    function  getUF: string;
    procedure setUF(aUF: string);
    function  getCNPJ: string;
    procedure setCNPJ(aCNPJ: string);
    function  getTelefone: string;
    procedure setTelefone(aTelefone: string);
    function  getEndereco: string;
    procedure setEndereco(aEndereco: string);
    function  getEmail: string;
    procedure setEmail(aEmail: string);
  end;

implementation

{ Empresa }

function TEmpresa.getCodigo: Integer;
begin
  Result := Self.Codigo;
end;

function TEmpresa.getNome: string;
begin
  Result := Self.Nome;
end;

function TEmpresa.getUF: string;
begin
  Result := Self.UF;
end;

function TEmpresa.getCNPJ: string;
begin
  Result := Self.CNPJ;
end;

function TEmpresa.getTelefone: string;
begin
  Result := Self.Telefone;
end;

function TEmpresa.getEndereco: string;
begin
  Result := Self.Endereco;
end;

function TEmpresa.getEmail: string;
begin
  Result := Self.Email;
end;

procedure TEmpresa.setCodigo(aCodigo: Integer);
begin
  Self.Codigo := aCodigo;
end;

procedure TEmpresa.setNome(aNome: string);
begin
  Self.Nome := aNome;
end;

procedure TEmpresa.setUF(aUF: string);
begin
  Self.UF := aUF;
end;

procedure TEmpresa.setCNPJ(aCNPJ: string);
begin
  Self.CNPJ := aCNPJ;
end;

procedure TEmpresa.setTelefone(aTelefone: string);
begin
  Self.Telefone := aTelefone;
end;

procedure TEmpresa.setEndereco(aEndereco: string);
begin
  Self.Endereco := aEndereco;
end;

procedure TEmpresa.setEmail(aEmail: string);
begin
  Self.Email := aEmail;
end;

end.
