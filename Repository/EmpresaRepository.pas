unit EmpresaRepository;

interface

uses
  ConexaoBanco, FireDAC.Comp.Client, FireDAC.DApt, EmpresaModel, SysUtils,
  System.Generics.Collections;

type
  TEmpresaRepository = class
  private
    query: TFDQuery;
  public
    constructor Create;
    destructor Destroy; override;

    function Adicionar(AEmpresa: TEmpresa): Boolean;
    function Atualizar(AEmpresa: TEmpresa): Boolean; // soft delete tratado no controller
    function BuscarPorId(ACodigo: Integer): TEmpresa;
    function BuscarPorCnpj(ACnpj: string): TEmpresa;
    function ListarTodas: TObjectList<TEmpresa>;
    function ListarPorNome(Nome: string): TObjectList<TEmpresa>;
    function ListarPorUF(UF: string): TObjectList<TEmpresa>;
  end;

implementation

{ TEmpresaRepository }

constructor TEmpresaRepository.Create;
begin
  inherited Create;
  Self.query := TFDQuery.Create(nil);
  Self.query.Connection := DataModule1.FDConnection1;
end;

destructor TEmpresaRepository.Destroy;
begin
  Self.query.Free;
  inherited;
end;

// === ADICIONAR ===
function TEmpresaRepository.Adicionar(AEmpresa: TEmpresa): Boolean;
begin
  Result := False;

  Self.query.SQL.Clear;
  Self.query.SQL.Text :=
    'INSERT INTO empresa ' +
    '  (cnpj, nome_empresa, telefone, endereco, email, uf, ativo) ' +
    'VALUES ' +
    '  (:cnpj, :nome, :telefone, :endereco, :email, :uf, :ativo) ' +
    'RETURNING id_empresa';

  Self.query.ParamByName('cnpj').AsString      := AEmpresa.getCNPJ;
  Self.query.ParamByName('nome').AsString      := AEmpresa.getNome;
  Self.query.ParamByName('telefone').AsString  := AEmpresa.getTelefone;
  Self.query.ParamByName('endereco').AsString  := AEmpresa.getEndereco;
  Self.query.ParamByName('email').AsString     := AEmpresa.getEmail;
  Self.query.ParamByName('uf').AsString        := AEmpresa.getUF;
  // ⚠️ IMPORTANTE: preencher o campo ativo
  Self.query.ParamByName('ativo').AsBoolean    := True;

  Self.query.Open; // usando RETURNING
  if not Self.query.Eof then
  begin
    AEmpresa.setCodigo(Self.query.FieldByName('id_empresa').AsInteger);
    Result := True; // ✅ deu certo
  end;

  Self.query.Close;
end;

// === ATUALIZAR ===
function TEmpresaRepository.Atualizar(AEmpresa: TEmpresa): Boolean;
begin
  Result := False;

  Self.query.SQL.Clear;
  Self.query.SQL.Text :=
    'UPDATE empresa SET ' +
    '  cnpj = :cnpj, ' +
    '  nome_empresa = :nome, ' +
    '  telefone = :telefone, ' +
    '  endereco = :endereco, ' +
    '  email = :email, ' +
    '  uf = :uf ' +
    'WHERE id_empresa = :id_empresa';

  Self.query.ParamByName('id_empresa').AsInteger := AEmpresa.getCodigo;
  Self.query.ParamByName('cnpj').AsString        := AEmpresa.getCNPJ;
  Self.query.ParamByName('nome').AsString        := AEmpresa.getNome;
  Self.query.ParamByName('telefone').AsString    := AEmpresa.getTelefone;
  Self.query.ParamByName('endereco').AsString    := AEmpresa.getEndereco;
  Self.query.ParamByName('email').AsString       := AEmpresa.getEmail;
  Self.query.ParamByName('uf').AsString          := AEmpresa.getUF;

  Self.query.ExecSQL;
  Result := Self.query.RowsAffected > 0;
end;

// === BUSCAR POR ID (apenas ativas) ===
function TEmpresaRepository.BuscarPorId(ACodigo: Integer): TEmpresa;
begin
  Result := nil;

  Self.query.SQL.Clear;
  Self.query.SQL.Text :=
    'SELECT * FROM empresa WHERE id_empresa = :id_empresa AND ativo = TRUE';
  Self.query.ParamByName('id_empresa').AsInteger := ACodigo;
  Self.query.Open;

  if not Self.query.Eof then
  begin
    Result := TEmpresa.Create;
    Result.setCodigo(Self.query.FieldByName('id_empresa').AsInteger);
    Result.setCNPJ(Self.query.FieldByName('cnpj').AsString);
    Result.setNome(Self.query.FieldByName('nome_empresa').AsString);
    Result.setTelefone(Self.query.FieldByName('telefone').AsString);
    Result.setEndereco(Self.query.FieldByName('endereco').AsString);
    Result.setEmail(Self.query.FieldByName('email').AsString);
    Result.setUF(Self.query.FieldByName('uf').AsString);
  end;

  Self.query.Close;
end;

// === BUSCAR POR CNPJ (ativa) ===
function TEmpresaRepository.BuscarPorCnpj(ACnpj: string): TEmpresa;
begin
  Result := nil;

  Self.query.SQL.Clear;
  Self.query.SQL.Text :=
    'SELECT * FROM empresa WHERE cnpj = :cnpj AND ativo = TRUE';
  Self.query.ParamByName('cnpj').AsString := ACnpj;
  Self.query.Open;

  if not Self.query.Eof then
  begin
    Result := TEmpresa.Create;
    Result.setCodigo(Self.query.FieldByName('id_empresa').AsInteger);
    Result.setCNPJ(Self.query.FieldByName('cnpj').AsString);
    Result.setNome(Self.query.FieldByName('nome_empresa').AsString);
    Result.setTelefone(Self.query.FieldByName('telefone').AsString);
    Result.setEndereco(Self.query.FieldByName('endereco').AsString);
    Result.setEmail(Self.query.FieldByName('email').AsString);
    Result.setUF(Self.query.FieldByName('uf').AsString);
  end;

  Self.query.Close;
end;

// === LISTAR TODAS (ativas) ===
function TEmpresaRepository.ListarTodas: TObjectList<TEmpresa>;
var
  emp: TEmpresa;
begin
  Result := TObjectList<TEmpresa>.Create(True);

  Self.query.SQL.Clear;
  Self.query.SQL.Text :=
    'SELECT * FROM empresa WHERE ativo = TRUE ORDER BY nome_empresa';
  Self.query.Open;

  while not Self.query.Eof do
  begin
    emp := TEmpresa.Create;
    emp.setCodigo(Self.query.FieldByName('id_empresa').AsInteger);
    emp.setCNPJ(Self.query.FieldByName('cnpj').AsString);
    emp.setNome(Self.query.FieldByName('nome_empresa').AsString);
    emp.setTelefone(Self.query.FieldByName('telefone').AsString);
    emp.setEndereco(Self.query.FieldByName('endereco').AsString);
    emp.setEmail(Self.query.FieldByName('email').AsString);
    emp.setUF(Self.query.FieldByName('uf').AsString);
    Result.Add(emp);
    Self.query.Next;
  end;

  Self.query.Close;
end;

// === LISTAR POR NOME (ativas) ===
function TEmpresaRepository.ListarPorNome(Nome: string): TObjectList<TEmpresa>;
var
  emp: TEmpresa;
begin
  Result := TObjectList<TEmpresa>.Create(True);

  Self.query.SQL.Clear;
  Self.query.SQL.Text :=
    'SELECT * FROM empresa ' +
    'WHERE nome_empresa ILIKE :nome AND ativo = TRUE ' +
    'ORDER BY nome_empresa';
  Self.query.ParamByName('nome').AsString := '%' + Nome + '%';
  Self.query.Open;

  while not Self.query.Eof do
  begin
    emp := TEmpresa.Create;
    emp.setCodigo(Self.query.FieldByName('id_empresa').AsInteger);
    emp.setCNPJ(Self.query.FieldByName('cnpj').AsString);
    emp.setNome(Self.query.FieldByName('nome_empresa').AsString);
    emp.setTelefone(Self.query.FieldByName('telefone').AsString);
    emp.setEndereco(Self.query.FieldByName('endereco').AsString);
    emp.setEmail(Self.query.FieldByName('email').AsString);
    emp.setUF(Self.query.FieldByName('uf').AsString);
    Result.Add(emp);
    Self.query.Next;
  end;

  Self.query.Close;
end;

// === LISTAR POR UF (ativas) ===
function TEmpresaRepository.ListarPorUF(UF: string): TObjectList<TEmpresa>;
var
  emp: TEmpresa;
begin
  Result := TObjectList<TEmpresa>.Create(True);

  Self.query.SQL.Clear;
  Self.query.SQL.Text :=
    'SELECT * FROM empresa ' +
    'WHERE uf ILIKE :uf AND ativo = TRUE ' +
    'ORDER BY nome_empresa';
  Self.query.ParamByName('uf').AsString := UF;
  Self.query.Open;

  while not Self.query.Eof do
  begin
    emp := TEmpresa.Create;
    emp.setCodigo(Self.query.FieldByName('id_empresa').AsInteger);
    emp.setCNPJ(Self.query.FieldByName('cnpj').AsString);
    emp.setNome(Self.query.FieldByName('nome_empresa').AsString);
    emp.setTelefone(Self.query.FieldByName('telefone').AsString);
    emp.setEndereco(Self.query.FieldByName('endereco').AsString);
    emp.setEmail(Self.query.FieldByName('email').AsString);
    emp.setUF(Self.query.FieldByName('uf').AsString);
    Result.Add(emp);
    Self.query.Next;
  end;

  Self.query.Close;
end;

end.

