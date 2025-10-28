unit EmpresaModel;

interface

type
  Empresa = class
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

function Empresa.getCodigo: Integer;
begin
  Result := Self.Codigo;
end;

function Empresa.getNome: string;
begin
  Result := Self.Nome;
end;

function Empresa.getUF: string;
begin
  Result := Self.UF;
end;

function Empresa.getCNPJ: string;
begin
  Result := Self.CNPJ;
end;

function Empresa.getTelefone: string;
begin
  Result := Self.Telefone;
end;

function Empresa.getEndereco: string;
begin
  Result := Self.Endereco;
end;

function Empresa.getEmail: string;
begin
  Result := Self.Email;
end;

procedure Empresa.setCodigo(aCodigo: Integer);
begin
  Self.Codigo := aCodigo;
end;

procedure Empresa.setNome(aNome: string);
begin
  Self.Nome := aNome;
end;

procedure Empresa.setUF(aUF: string);
begin
  Self.UF := aUF;
end;

procedure Empresa.setCNPJ(aCNPJ: string);
begin
  Self.CNPJ := aCNPJ;
end;

procedure Empresa.setTelefone(aTelefone: string);
begin
  Self.Telefone := aTelefone;
end;

procedure Empresa.setEndereco(aEndereco: string);
begin
  Self.Endereco := aEndereco;
end;

procedure Empresa.setEmail(aEmail: string);
begin
  Self.Email := aEmail;
end;

end.
