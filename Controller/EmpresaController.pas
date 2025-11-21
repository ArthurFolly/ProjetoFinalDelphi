unit EmpresaController;

interface

uses
  System.SysUtils, System.Generics.Collections, Data.DB,
  FireDAC.Comp.Client,
  EmpresaModel, ConexaoBanco, Datasnap.DBClient, Vcl.Dialogs;

type
  TEmpresaController = class
  private
    FUsuarioId: Integer;
  public
    constructor Create(AUsuarioId: Integer = 0);

    // CRUD
    function Adicionar(AEmpresa: TEmpresa; out Mensagem: string): Boolean;
    function Atualizar(AEmpresa: TEmpresa; out Mensagem: string): Boolean;
    function Remover(ACodigo: Integer; out Mensagem: string): Boolean;       // exclusivo: ativo = FALSE
    function Restaurar(ACodigo: Integer; out Mensagem: string): Boolean;
    function RestaurarTodas(out Mensagem: string): Boolean;

    // Consultas
    function BuscarPorId(ACodigo: Integer; out AEmpresa: TEmpresa): Boolean;
    function ListarEmpresas: TObjectList<TEmpresa>;

    // Preenchimento de grids (uMain)
    function CarregarEmpresas(DataSet: TClientDataSet): Boolean;
    function CarregarInativas(DataSet: TClientDataSet): Boolean;
    function CarregarTodas(DataSet: TClientDataSet): Boolean;
  end;

implementation

{ TEmpresaController }

constructor TEmpresaController.Create(AUsuarioId: Integer);
begin
  inherited Create;
  FUsuarioId := AUsuarioId;
end;

// ============================================================================
// ADICIONAR
// ============================================================================
function TEmpresaController.Adicionar(AEmpresa: TEmpresa; out Mensagem: string): Boolean;
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
      'RETURNING id_empresa';

    Query.ParamByName('cnpj').AsString     := AEmpresa.getCNPJ;
    Query.ParamByName('nome').AsString     := AEmpresa.getNome;
    Query.ParamByName('telefone').AsString := AEmpresa.getTelefone;
    Query.ParamByName('endereco').AsString := AEmpresa.getEndereco;
    Query.ParamByName('email').AsString    := AEmpresa.getEmail;
    Query.ParamByName('uf').AsString       := AEmpresa.getUF;

    Query.Open; // para ler o RETURNING
    if not Query.Eof then
      AEmpresa.setCodigo(Query.FieldByName('id_empresa').AsInteger);

    Result := True;
    Mensagem := 'Empresa adicionada com sucesso!';
  except
    on E: Exception do
    begin
      Mensagem := 'Erro ao adicionar empresa: ' + E.Message;
      Result   := False;
    end;
  end;
  Query.Free;
end;

// ============================================================================
// ATUALIZAR
// ============================================================================
function TEmpresaController.Atualizar(AEmpresa: TEmpresa; out Mensagem: string): Boolean;
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
      '  cnpj = :cnpj, ' +
      '  nome_empresa = :nome, ' +
      '  telefone = :telefone, ' +
      '  endereco = :endereco, ' +
      '  email = :email, ' +
      '  uf = :uf ' +
      'WHERE id_empresa = :id_empresa AND ativo = TRUE';

    Query.ParamByName('id_empresa').AsInteger := AEmpresa.getCodigo;
    Query.ParamByName('cnpj').AsString        := AEmpresa.getCNPJ;
    Query.ParamByName('nome').AsString        := AEmpresa.getNome;
    Query.ParamByName('telefone').AsString    := AEmpresa.getTelefone;
    Query.ParamByName('endereco').AsString    := AEmpresa.getEndereco;
    Query.ParamByName('email').AsString       := AEmpresa.getEmail;
    Query.ParamByName('uf').AsString          := AEmpresa.getUF;

    Query.ExecSQL;

    Result := Query.RowsAffected > 0;
    if Result then
      Mensagem := 'Empresa atualizada com sucesso!'
    else
      Mensagem := 'Nenhuma empresa foi atualizada.';
  except
    on E: Exception do
    begin
      Mensagem := 'Erro ao atualizar empresa: ' + E.Message;
      Result   := False;
    end;
  end;
  Query.Free;
end;

// ============================================================================
// REMOVER (Exclusão lógica)
// ============================================================================
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
      'UPDATE empresa SET ativo = FALSE ' +
      'WHERE id_empresa = :id_empresa AND ativo = TRUE';

    Query.ParamByName('id_empresa').AsInteger := ACodigo;
    Query.ExecSQL;

    Result := Query.RowsAffected > 0;
    if Result then
      Mensagem := 'Empresa excluída (inativada) com sucesso!'
    else
      Mensagem := 'Nenhuma empresa foi inativada.';
  except
    on E: Exception do
    begin
      Mensagem := 'Erro ao excluir empresa: ' + E.Message;
      Result   := False;
    end;
  end;
  Query.Free;
end;

// ============================================================================
// RESTAURAR (uma empresa)
// ============================================================================
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
      'UPDATE empresa SET ativo = TRUE ' +
      'WHERE id_empresa = :id_empresa AND ativo = FALSE';

    Query.ParamByName('id_empresa').AsInteger := ACodigo;
    Query.ExecSQL;

    Result := Query.RowsAffected > 0;
    if Result then
      Mensagem := 'Empresa restaurada com sucesso!'
    else
      Mensagem := 'Nenhuma empresa foi restaurada.';
  except
    on E: Exception do
    begin
      Mensagem := 'Erro ao restaurar empresa: ' + E.Message;
      Result   := False;
    end;
  end;
  Query.Free;
end;

// ============================================================================
// RESTAURAR TODAS (todas inativas)
// ============================================================================
function TEmpresaController.RestaurarTodas(out Mensagem: string): Boolean;
var
  Query: TFDQuery;
begin
  Result := False;
  Mensagem := '';
  Query := TFDQuery.Create(nil);
  try
    Query.Connection := DataModule1.FDConnection1;

    // aqui só existem empresas; não há relação direta com usuário
    Query.SQL.Text :=
      'UPDATE empresa SET ativo = TRUE WHERE ativo = FALSE';

    Query.ExecSQL;

    Result := Query.RowsAffected > 0;
    if Result then
      Mensagem := 'Todas as empresas inativas foram restauradas.'
    else
      Mensagem := 'Nenhuma empresa estava inativa.';
  except
    on E: Exception do
    begin
      Mensagem := 'Erro ao restaurar empresas: ' + E.Message;
      Result   := False;
    end;
  end;
  Query.Free;
end;

// ============================================================================
// BUSCAR POR ID
// ============================================================================
function TEmpresaController.BuscarPorId(ACodigo: Integer; out AEmpresa: TEmpresa): Boolean;
var
  Query: TFDQuery;
begin
  Result  := False;
  AEmpresa := nil;

  Query := TFDQuery.Create(nil);
  try
    Query.Connection := DataModule1.FDConnection1;
    Query.SQL.Text :=
      'SELECT id_empresa, cnpj, nome_empresa, telefone, endereco, email, uf ' +
      'FROM empresa ' +
      'WHERE id_empresa = :id_empresa AND ativo = TRUE';

    Query.ParamByName('id_empresa').AsInteger := ACodigo;
    Query.Open;

    if not Query.Eof then
    begin
      AEmpresa := TEmpresa.Create;
      AEmpresa.setCodigo(Query.FieldByName('id_empresa').AsInteger);
      AEmpresa.setCNPJ(Query.FieldByName('cnpj').AsString);
      AEmpresa.setNome(Query.FieldByName('nome_empresa').AsString);
      AEmpresa.setTelefone(Query.FieldByName('telefone').AsString);
      AEmpresa.setEndereco(Query.FieldByName('endereco').AsString);
      AEmpresa.setEmail(Query.FieldByName('email').AsString);
      AEmpresa.setUF(Query.FieldByName('uf').AsString);
      Result := True;
    end;
  except
    on E: Exception do
    begin
      ShowMessage('Erro ao buscar empresa por ID: ' + E.Message);
      Result := False;
      FreeAndNil(AEmpresa);
    end;
  end;
  Query.Free;
end;

// ============================================================================
// LISTAREMPRESAS  (para ComboBox, etc.)
// ============================================================================
function TEmpresaController.ListarEmpresas: TObjectList<TEmpresa>;
var
  Query: TFDQuery;
  Empresa: TEmpresa;
begin
  Result := TObjectList<TEmpresa>.Create(True);
  Query := TFDQuery.Create(nil);
  try
    Query.Connection := DataModule1.FDConnection1;
    Query.SQL.Text :=
      'SELECT id_empresa, cnpj, nome_empresa, telefone, endereco, email, uf ' +
      'FROM empresa ' +
      'WHERE ativo = TRUE ' +
      'ORDER BY nome_empresa';
    Query.Open;

    while not Query.Eof do
    begin
      Empresa := TEmpresa.Create;
      Empresa.setCodigo(Query.FieldByName('id_empresa').AsInteger);
      Empresa.setCNPJ(Query.FieldByName('cnpj').AsString);
      Empresa.setNome(Query.FieldByName('nome_empresa').AsString);
      Empresa.setTelefone(Query.FieldByName('telefone').AsString);
      Empresa.setEndereco(Query.FieldByName('endereco').AsString);
      Empresa.setEmail(Query.FieldByName('email').AsString);
      Empresa.setUF(Query.FieldByName('uf').AsString);
      Result.Add(Empresa);
      Query.Next;
    end;
  except
    on E: Exception do
    begin
      ShowMessage('Erro ao listar empresas: ' + E.Message);
      Result.Free;
      Result := TObjectList<TEmpresa>.Create(True);
    end;
  end;
  Query.Free;
end;

// ============================================================================
// CARREGAR EMPRESAS (ativas) em um TClientDataSet (Grid da aba Empresas)
// ============================================================================
function TEmpresaController.CarregarEmpresas(DataSet: TClientDataSet): Boolean;
var
  Query: TFDQuery;
begin
  Result := False;
  Query := TFDQuery.Create(nil);
  try
    Query.Connection := DataModule1.FDConnection1;
    Query.SQL.Text :=
      'SELECT id_empresa AS ID, cnpj, nome_empresa AS NOME, telefone, ' +
      '       email, endereco, uf ' +
      'FROM empresa ' +
      'WHERE ativo = TRUE ' +
      'ORDER BY nome_empresa';
    Query.Open;

    DataSet.DisableControls;
    try
      DataSet.EmptyDataSet;
      while not Query.Eof do
      begin
        DataSet.Append;
        DataSet.FieldByName('ID').AsInteger        := Query.FieldByName('ID').AsInteger;
        DataSet.FieldByName('CNPJ').AsString       := Query.FieldByName('cnpj').AsString;
        DataSet.FieldByName('NOME').AsString       := Query.FieldByName('NOME').AsString;
        DataSet.FieldByName('TELEFONE').AsString   := Query.FieldByName('telefone').AsString;
        DataSet.FieldByName('EMAIL').AsString      := Query.FieldByName('email').AsString;
        DataSet.FieldByName('ENDERECO').AsString   := Query.FieldByName('endereco').AsString;
        DataSet.FieldByName('UF').AsString         := Query.FieldByName('uf').AsString;
        DataSet.Post;
        Query.Next;
      end;
      Result := True;
    finally
      DataSet.EnableControls;
    end;
  except
    on E: Exception do
      ShowMessage('Erro ao carregar empresas: ' + E.Message);
  end;
  Query.Free;
end;

// ============================================================================
// CARREGAR INATIVAS
// ============================================================================
function TEmpresaController.CarregarInativas(DataSet: TClientDataSet): Boolean;
var
  Query: TFDQuery;
begin
  Result := False;
  Query := TFDQuery.Create(nil);
  try
    Query.Connection := DataModule1.FDConnection1;
    Query.SQL.Text :=
      'SELECT id_empresa AS ID, cnpj, nome_empresa AS NOME, telefone, ' +
      '       email, endereco, uf ' +
      'FROM empresa ' +
      'WHERE ativo = FALSE ' +
      'ORDER BY nome_empresa';
    Query.Open;

    DataSet.DisableControls;
    try
      DataSet.EmptyDataSet;
      while not Query.Eof do
      begin
        DataSet.Append;
        DataSet.FieldByName('ID').AsInteger        := Query.FieldByName('ID').AsInteger;
        DataSet.FieldByName('CNPJ').AsString       := Query.FieldByName('cnpj').AsString;
        DataSet.FieldByName('NOME').AsString       := Query.FieldByName('NOME').AsString;
        DataSet.FieldByName('TELEFONE').AsString   := Query.FieldByName('telefone').AsString;
        DataSet.FieldByName('EMAIL').AsString      := Query.FieldByName('email').AsString;
        DataSet.FieldByName('ENDERECO').AsString   := Query.FieldByName('endereco').AsString;
        DataSet.FieldByName('UF').AsString         := Query.FieldByName('uf').AsString;
        DataSet.Post;
        Query.Next;
      end;
      Result := True;
    finally
      DataSet.EnableControls;
    end;
  except
    on E: Exception do
      ShowMessage('Erro ao carregar empresas inativas: ' + E.Message);
  end;
  Query.Free;
end;

// ============================================================================
// CARREGAR TODAS (ativas e inativas)
// ============================================================================
function TEmpresaController.CarregarTodas(DataSet: TClientDataSet): Boolean;
var
  Query: TFDQuery;
begin
  Result := False;
  Query := TFDQuery.Create(nil);
  try
    Query.Connection := DataModule1.FDConnection1;
    Query.SQL.Text :=
      'SELECT id_empresa AS ID, cnpj, nome_empresa AS NOME, telefone, ' +
      '       email, endereco, uf, ativo ' +
      'FROM empresa ' +
      'ORDER BY nome_empresa';
    Query.Open;

    DataSet.DisableControls;
    try
      DataSet.EmptyDataSet;
      while not Query.Eof do
      begin
        DataSet.Append;
        DataSet.FieldByName('ID').AsInteger        := Query.FieldByName('ID').AsInteger;
        DataSet.FieldByName('CNPJ').AsString       := Query.FieldByName('cnpj').AsString;
        DataSet.FieldByName('NOME').AsString       := Query.FieldByName('NOME').AsString;
        DataSet.FieldByName('TELEFONE').AsString   := Query.FieldByName('telefone').AsString;
        DataSet.FieldByName('EMAIL').AsString      := Query.FieldByName('email').AsString;
        DataSet.FieldByName('ENDERECO').AsString   := Query.FieldByName('endereco').AsString;
        DataSet.FieldByName('UF').AsString         := Query.FieldByName('uf').AsString;
        if DataSet.FindField('ATIVO') <> nil then
          DataSet.FieldByName('ATIVO').AsBoolean := Query.FieldByName('ativo').AsBoolean;
        DataSet.Post;
        Query.Next;
      end;
      Result := True;
    finally
      DataSet.EnableControls;
    end;
  except
    on E: Exception do
      ShowMessage('Erro ao carregar todas as empresas: ' + E.Message);
  end;
  Query.Free;
end;

end.

