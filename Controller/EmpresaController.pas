unit EmpresaController;

interface

uses
  System.SysUtils, FireDAC.Comp.Client, Datasnap.DBClient, ConexaoBanco, EmpresaModel;

type
  TEmpresaController = class
  private
    FUsuarioId: Integer;
  public
    constructor Create(AUsuarioId: Integer = 0);

    function Adicionar(var AEmpresa: Empresa; out Mensagem: string): Boolean;
    function Atualizar(var AEmpresa: Empresa; out Mensagem: string): Boolean;
    function Remover(ACodigo: Integer; out Mensagem: string): Boolean;
    function Restaurar(ACodigo: Integer; out Mensagem: string): Boolean;
    function BuscarPorId(ACodigo: Integer; out AEmpresa: Empresa): Boolean;

    function CarregarEmpresas(DataSet: TClientDataSet): Boolean;        // Ativas
    function CarregarInativas(DataSet: TClientDataSet): Boolean;        // Excluídas
    function CarregarTodas(DataSet: TClientDataSet): Boolean;           // Todas com status
  end;

implementation

{ TEmpresaController }

constructor TEmpresaController.Create(AUsuarioId: Integer);
begin
  FUsuarioId := AUsuarioId;
end;



// === ADICIONAR ===
function TEmpresaController.Adicionar(var AEmpresa: Empresa; out Mensagem: string): Boolean;
var
  Query: TFDQuery;
begin
  Result := False;
  Mensagem := '';
  Query := TFDQuery.Create(nil);
  try
    Query.Connection := DataModule1.FDConnection1;
    Query.SQL.Text :=
      'INSERT INTO empresa (cnpj, nome_empresa, telefone, endereco, email, uf, ativo) ' +
      'VALUES (:cnpj, :nome, :telefone, :endereco, :email, :uf, TRUE) ' +
      'ON CONFLICT (cnpj) DO NOTHING ' +
      'RETURNING codigo';

    Query.ParamByName('cnpj').AsString      := AEmpresa.getCNPJ;
    Query.ParamByName('nome').AsString      := AEmpresa.getNome;
    Query.ParamByName('telefone').AsString  := AEmpresa.getTelefone;
    Query.ParamByName('endereco').AsString  := AEmpresa.getEndereco;
    Query.ParamByName('email').AsString     := AEmpresa.getEmail;
    Query.ParamByName('uf').AsString        := AEmpresa.getUF;

    Query.Open;

    if not Query.Eof then
    begin
      AEmpresa.setCodigo(Query.FieldByName('codigo').AsInteger);
      Result := True;
      Mensagem := 'Empresa adicionada com sucesso!';
    end
    else
    begin
      Mensagem := 'CNPJ já cadastrado.';
    end;
  finally
    Query.Free;
  end;
end;

// === ATUALIZAR ===
function TEmpresaController.Atualizar(var AEmpresa: Empresa; out Mensagem: string): Boolean;
var
  Query: TFDQuery;
begin
  Result := False;
  Mensagem := '';
  Query := TFDQuery.Create(nil);
  try
    Query.Connection := DataModule1.FDConnection1;
    Query.SQL.Text :=
      'UPDATE empresa SET ' +
      'cnpj = :cnpj, ' +
      'nome_empresa = :nome, ' +
      'telefone = :telefone, ' +
      'endereco = :endereco, ' +
      'email = :email, ' +
      'uf = :uf ' +
      'WHERE codigo = :codigo AND ativo = TRUE';

    Query.ParamByName('codigo').AsInteger    := AEmpresa.getCodigo;
    Query.ParamByName('cnpj').AsString       := AEmpresa.getCNPJ;
    Query.ParamByName('nome').AsString       := AEmpresa.getNome;
    Query.ParamByName('telefone').AsString   := AEmpresa.getTelefone;
    Query.ParamByName('endereco').AsString   := AEmpresa.getEndereco;
    Query.ParamByName('email').AsString      := AEmpresa.getEmail;
    Query.ParamByName('uf').AsString         := AEmpresa.getUF;

    Query.ExecSQL;

    Result := Query.RowsAffected > 0;
    if Result then
      Mensagem := 'Empresa atualizada com sucesso!'
    else
      Mensagem := 'Empresa não encontrada ou já inativa.';
  finally
    Query.Free;
  end;
end;

// === REMOVER (soft delete) ===
function TEmpresaController.Remover(ACodigo: Integer; out Mensagem: string): Boolean;
var
  Query: TFDQuery;
begin
  Result := False;
  Mensagem := '';
  Query := TFDQuery.Create(nil);
  try
    Query.Connection := DataModule1.FDConnection1;
    Query.SQL.Text :=
      'UPDATE empresa SET ativo = FALSE WHERE codigo = :codigo AND ativo = TRUE';
    Query.ParamByName('codigo').AsInteger := ACodigo;
    Query.ExecSQL;

    Result := Query.RowsAffected > 0;
    if Result then
      Mensagem := 'Empresa removida com sucesso!'
    else
      Mensagem := 'Empresa não encontrada ou já inativa.';
  finally
    Query.Free;
  end;
end;

// === RESTAURAR (desfazer exclusão lógica) ===
function TEmpresaController.Restaurar(ACodigo: Integer; out Mensagem: string): Boolean;
var
  Query: TFDQuery;
begin
  Result := False;
  Mensagem := '';
  Query := TFDQuery.Create(nil);
  try
    Query.Connection := DataModule1.FDConnection1;
    Query.SQL.Text :=
      'UPDATE empresa SET ativo = TRUE WHERE codigo = :codigo AND ativo = FALSE';
    Query.ParamByName('codigo').AsInteger := ACodigo;
    Query.ExecSQL;

    Result := Query.RowsAffected > 0;
    if Result then
      Mensagem := 'Empresa restaurada com sucesso!'
    else
      Mensagem := 'Empresa não encontrada ou já ativa.';
  finally
    Query.Free;
  end;
end;

// === BUSCAR POR ID (para edição) ===
function TEmpresaController.BuscarPorId(ACodigo: Integer; out AEmpresa: Empresa): Boolean;
var
  Query: TFDQuery;
begin
  Result := False;
  AEmpresa := nil;
  Query := TFDQuery.Create(nil);
  try
    Query.Connection := DataModule1.FDConnection1;
    Query.SQL.Text :=
      'SELECT * FROM empresa WHERE codigo = :codigo AND ativo = TRUE';
    Query.ParamByName('codigo').AsInteger := ACodigo;
    Query.Open;

    if not Query.Eof then
    begin
      AEmpresa := Empresa.Create;
      AEmpresa.setCodigo(Query.FieldByName('codigo').AsInteger);
      AEmpresa.setCNPJ(Query.FieldByName('cnpj').AsString);
      AEmpresa.setNome(Query.FieldByName('nome_empresa').AsString);
      AEmpresa.setTelefone(Query.FieldByName('telefone').AsString);
      AEmpresa.setEndereco(Query.FieldByName('endereco').AsString);
      AEmpresa.setEmail(Query.FieldByName('email').AsString);
      AEmpresa.setUF(Query.FieldByName('uf').AsString);
      Result := True;
    end;
  finally
    Query.Free;
  end;
end;

// === CARREGAR ATIVAS ===
function TEmpresaController.CarregarEmpresas(DataSet: TClientDataSet): Boolean;
var
  Query: TFDQuery;
begin
  Result := False;
  if not Assigned(DataSet) then Exit;

  DataSet.DisableControls;
  try
    DataSet.EmptyDataSet;
    Query := TFDQuery.Create(nil);
    try
      Query.Connection := DataModule1.FDConnection1;
      Query.SQL.Text :=
        'SELECT ' +
        '  codigo AS ID, ' +
        '  cnpj AS CNPJ, ' +
        '  nome_empresa AS NOME, ' +
        '  telefone AS TELEFONE, ' +
        '  email AS EMAIL, ' +
        '  endereco AS ENDERECO, ' +
        '  uf AS UF ' +
        'FROM empresa ' +
        'WHERE ativo = TRUE ' +
        'ORDER BY nome_empresa';

      Query.Open;

      while not Query.Eof do
      begin
        DataSet.Append;
        DataSet.FieldByName('ID').AsInteger       := Query.FieldByName('ID').AsInteger;
        DataSet.FieldByName('CNPJ').AsString      := Query.FieldByName('CNPJ').AsString;
        DataSet.FieldByName('NOME').AsString      := Query.FieldByName('NOME').AsString;
        DataSet.FieldByName('TELEFONE').AsString  := Query.FieldByName('TELEFONE').AsString;
        DataSet.FieldByName('EMAIL').AsString     := Query.FieldByName('EMAIL').AsString;
        DataSet.FieldByName('ENDERECO').AsString  := Query.FieldByName('ENDERECO').AsString;
        DataSet.FieldByName('UF').AsString        := Query.FieldByName('UF').AsString;
        DataSet.Post;
        Query.Next;
      end;

      Result := True;
    finally
      Query.Free;
    end;
  finally
    DataSet.EnableControls;
  end;
end;

// === CARREGAR INATIVAS (excluídas logicamente) ===
function TEmpresaController.CarregarInativas(DataSet: TClientDataSet): Boolean;
var
  Query: TFDQuery;
begin
  Result := False;
  if not Assigned(DataSet) then Exit;

  DataSet.DisableControls;
  try
    DataSet.EmptyDataSet;
    Query := TFDQuery.Create(nil);
    try
      Query.Connection := DataModule1.FDConnection1;
      Query.SQL.Text :=
        'SELECT ' +
        '  codigo AS ID, ' +
        '  cnpj AS CNPJ, ' +
        '  nome_empresa AS NOME, ' +
        '  telefone AS TELEFONE, ' +
        '  email AS EMAIL, ' +
        '  endereco AS ENDERECO, ' +
        '  uf AS UF ' +
        'FROM empresa ' +
        'WHERE ativo = FALSE ' +
        'ORDER BY nome_empresa';

      Query.Open;

      while not Query.Eof do
      begin
        DataSet.Append;
        DataSet.FieldByName('ID').AsInteger       := Query.FieldByName('ID').AsInteger;
        DataSet.FieldByName('CNPJ').AsString      := Query.FieldByName('CNPJ').AsString;
        DataSet.FieldByName('NOME').AsString      := Query.FieldByName('NOME').AsString;
        DataSet.FieldByName('TELEFONE').AsString  := Query.FieldByName('TELEFONE').AsString;
        DataSet.FieldByName('EMAIL').AsString     := Query.FieldByName('EMAIL').AsString;
        DataSet.FieldByName('ENDERECO').AsString  := Query.FieldByName('ENDERECO').AsString;
        DataSet.FieldByName('UF').AsString        := Query.FieldByName('UF').AsString;
        DataSet.Post;
        Query.Next;
      end;

      Result := True;
    finally
      Query.Free;
    end;
  finally
    DataSet.EnableControls;
  end;
end;

// === CARREGAR TODAS (com status) ===
function TEmpresaController.CarregarTodas(DataSet: TClientDataSet): Boolean;
var
  Query: TFDQuery;
begin
  Result := False;
  if not Assigned(DataSet) then Exit;

  DataSet.DisableControls;
  try
    DataSet.EmptyDataSet;
    Query := TFDQuery.Create(nil);
    try
      Query.Connection := DataModule1.FDConnection1;
      Query.SQL.Text :=
        'SELECT ' +
        '  codigo AS ID, ' +
        '  cnpj AS CNPJ, ' +
        '  nome_empresa AS NOME, ' +
        '  CASE WHEN ativo THEN ''Ativa'' ELSE ''Inativa'' END AS STATUS, ' +
        '  telefone AS TELEFONE, ' +
        '  email AS EMAIL, ' +
        '  endereco AS ENDERECO, ' +
        '  uf AS UF ' +
        'FROM empresa ' +
        'ORDER BY nome_empresa';

      Query.Open;

      while not Query.Eof do
      begin
        DataSet.Append;
        DataSet.FieldByName('ID').AsInteger       := Query.FieldByName('ID').AsInteger;
        DataSet.FieldByName('CNPJ').AsString      := Query.FieldByName('CNPJ').AsString;
        DataSet.FieldByName('NOME').AsString      := Query.FieldByName('NOME').AsString;
        DataSet.FieldByName('STATUS').AsString    := Query.FieldByName('STATUS').AsString;
        DataSet.FieldByName('TELEFONE').AsString  := Query.FieldByName('TELEFONE').AsString;
        DataSet.FieldByName('EMAIL').AsString     := Query.FieldByName('EMAIL').AsString;
        DataSet.FieldByName('ENDERECO').AsString  := Query.FieldByName('ENDERECO').AsString;
        DataSet.FieldByName('UF').AsString        := Query.FieldByName('UF').AsString;
        DataSet.Post;
        Query.Next;
      end;

      Result := True;
    finally
      Query.Free;
    end;
  finally
    DataSet.EnableControls;
  end;
end;

end.
