unit ContatosRepository;

interface

uses
  ConexaoBanco,
  FireDAC.Comp.Client,
  FireDAC.DApt,
  TContatosModel,
  SysUtils,
  System.Generics.Collections,
  Data.DB;  // << ADICIONE ESTA LINHA

type
  TContatosRepository = class
  private
    query: TFDQuery;
  public
    constructor Create;
    destructor Destroy; override;

    function Adicionar(AContato: Contatos): Boolean;
    function Atualizar(AContato: Contatos): Boolean;
    function Excluir(AId: Integer): Boolean;   // << NOVA FUNÇÃO
    function BuscarPorId(AId: Integer): Contatos;
    function ListarTodos: TObjectList<Contatos>;
    function BuscarPorNome(ANome: string): TObjectList<Contatos>;
    function BuscarPorTelefone(ATelefone: string): TObjectList<Contatos>;
    function BuscarPorEmail(AEmail: string): TObjectList<Contatos>;
    function BuscarPorEmpresa(AEmpresa: string): TObjectList<Contatos>;
    function AtualizarPorId(
      AId: Integer; ANome, ATelefone, AEmail, AEmpresa, AEndereco,
      ACEP, ALogradouro, ANumero, AComplemento, ABairro, ACidade, AUF: string
    ): Boolean;
  end;

implementation

{ TContatosRepository }

constructor TContatosRepository.Create;
begin
  inherited Create;
  query := TFDQuery.Create(nil);
  query.Connection := DataModule1.FDConnection1;
end;

destructor TContatosRepository.Destroy;
begin
  query.Free;
  inherited;
end;

// ====================================================================
// ADICIONAR
// ====================================================================
function TContatosRepository.Adicionar(AContato: Contatos): Boolean;
begin
  Result := False;
  query.SQL.Clear;

  query.SQL.Text :=
    'INSERT INTO public."Contato" ' +
    '(nome, telefone, email, id_empresa, empresa, endereco, ' +
    ' cep, logradouro, numero, complemento, bairro, cidade, uf, ativo) ' +
    'VALUES (:nome, :telefone, :email, :id_empresa, :empresa, :endereco, ' +
    ' :cep, :logradouro, :numero, :complemento, :bairro, :cidade, :uf, :ativo) ' +
    'RETURNING id_contato';

  query.ParamByName('nome').AsString      := AContato.Nome;
  query.ParamByName('telefone').AsString  := AContato.Telefone;
  query.ParamByName('email').AsString     := AContato.Email;

  // --------- ID_EMPRESA: garante tipo e manda NULL quando não tiver empresa ----------
  with query.ParamByName('id_empresa') do
  begin
    DataType := ftInteger;  // IMPORTANTE para evitar o erro [ID_EMPRESA] data type is unknown
    if (AContato.IdEmpresa <= 0) then
      Clear                    // grava NULL no PostgreSQL
    else
      AsInteger := AContato.IdEmpresa;
  end;

  // Nome da empresa (campo texto, opcional)
  query.ParamByName('empresa').AsString   := AContato.Empresa;

  query.ParamByName('endereco').AsString      := AContato.Endereco;
  query.ParamByName('cep').AsString           := AContato.CEP;
  query.ParamByName('logradouro').AsString    := AContato.Logradouro;
  query.ParamByName('numero').AsString        := AContato.Numero;
  query.ParamByName('complemento').AsString   := AContato.Complemento;
  query.ParamByName('bairro').AsString        := AContato.Bairro;
  query.ParamByName('cidade').AsString        := AContato.Cidade;
  query.ParamByName('uf').AsString            := AContato.UF;
  query.ParamByName('ativo').AsBoolean        := AContato.Ativo;

  // Como usamos RETURNING, abrimos o dataset para pegar o id gerado
  query.Open;

  if not query.Eof then
  begin
    AContato.Id := query.FieldByName('id_contato').AsInteger;
    Result := True;
  end;

  query.Close;
end;

// ====================================================================
// ATUALIZAR
// ====================================================================
function TContatosRepository.Atualizar(AContato: Contatos): Boolean;
begin
  Result := False;
  query.SQL.Clear;

  query.SQL.Text :=
    'UPDATE public."Contato" SET ' +
    ' nome = :nome, ' +
    ' telefone = :telefone, ' +
    ' email = :email, ' +
    ' id_empresa = :id_empresa, ' +
    ' empresa = :empresa, ' +
    ' endereco = :endereco, ' +
    ' cep = :cep, ' +
    ' logradouro = :logradouro, ' +
    ' numero = :numero, ' +
    ' complemento = :complemento, ' +
    ' bairro = :bairro, ' +
    ' cidade = :cidade, ' +
    ' uf = :uf, ' +
    ' ativo = :ativo ' +
    'WHERE id_contato = :id_contato';

  query.ParamByName('id_contato').AsInteger := AContato.Id;
  query.ParamByName('nome').AsString        := AContato.Nome;
  query.ParamByName('telefone').AsString    := AContato.Telefone;
  query.ParamByName('email').AsString       := AContato.Email;

  // --------- ID_EMPRESA: garante tipo e manda NULL quando não tiver empresa ----------
  with query.ParamByName('id_empresa') do
  begin
    DataType := ftInteger;  // evita o erro de tipo desconhecido
    if (AContato.IdEmpresa <= 0) then
      Clear
    else
      AsInteger := AContato.IdEmpresa;
  end;

  query.ParamByName('empresa').AsString      := AContato.Empresa;
  query.ParamByName('endereco').AsString     := AContato.Endereco;
  query.ParamByName('cep').AsString          := AContato.CEP;
  query.ParamByName('logradouro').AsString   := AContato.Logradouro;
  query.ParamByName('numero').AsString       := AContato.Numero;
  query.ParamByName('complemento').AsString  := AContato.Complemento;
  query.ParamByName('bairro').AsString       := AContato.Bairro;
  query.ParamByName('cidade').AsString       := AContato.Cidade;
  query.ParamByName('uf').AsString           := AContato.UF;
  query.ParamByName('ativo').AsBoolean       := AContato.Ativo;

  query.ExecSQL;
  Result := query.RowsAffected > 0;
end;

function TContatosRepository.Excluir(AId: Integer): Boolean;
begin
  Result := False;
  query.SQL.Clear;

  query.SQL.Text :=
    'DELETE FROM public."Contato" ' +
    'WHERE id_contato = :id';

  query.ParamByName('id').AsInteger := AId;

  query.ExecSQL;
  Result := query.RowsAffected > 0;
end;


// ====================================================================
// Preenchimento comum do Model a partir do Dataset
// ====================================================================
procedure PreencherContatoFromQuery(AQuery: TFDQuery; AContato: Contatos);
begin
  AContato.Id         := AQuery.FieldByName('id_contato').AsInteger;
  AContato.Nome       := AQuery.FieldByName('nome').AsString;
  AContato.Telefone   := AQuery.FieldByName('telefone').AsString;
  AContato.Email      := AQuery.FieldByName('email').AsString;
  AContato.Endereco   := AQuery.FieldByName('endereco').AsString;
  AContato.Empresa    := AQuery.FieldByName('empresa').AsString;
  AContato.CEP        := AQuery.FieldByName('cep').AsString;
  AContato.Logradouro := AQuery.FieldByName('logradouro').AsString;
  AContato.Numero     := AQuery.FieldByName('numero').AsString;
  AContato.Complemento:= AQuery.FieldByName('complemento').AsString;
  AContato.Bairro     := AQuery.FieldByName('bairro').AsString;
  AContato.Cidade     := AQuery.FieldByName('cidade').AsString;
  AContato.UF         := AQuery.FieldByName('uf').AsString;
  AContato.Ativo      := AQuery.FieldByName('ativo').AsBoolean;

  // Trata id_empresa NULL -> 0
  if not AQuery.FieldByName('id_empresa').IsNull then
    AContato.IdEmpresa := AQuery.FieldByName('id_empresa').AsInteger
  else
    AContato.IdEmpresa := 0;
end;

// ====================================================================
// BUSCAR POR ID
// ====================================================================
function TContatosRepository.BuscarPorId(AId: Integer): Contatos;
begin
  Result := nil;
  query.SQL.Clear;
  query.SQL.Text :=
    'SELECT * FROM public."Contato" ' +
    'WHERE id_contato = :id_contato AND ativo = TRUE';

  query.ParamByName('id_contato').AsInteger := AId;
  query.Open;

  if not query.Eof then
  begin
    Result := Contatos.Create;
    PreencherContatoFromQuery(query, Result);
  end;

  query.Close;
end;

// ====================================================================
// LISTAR TODOS
// ====================================================================
function TContatosRepository.ListarTodos: TObjectList<Contatos>;
var
  Contato: Contatos;
begin
  Result := TObjectList<Contatos>.Create(True);

  query.SQL.Clear;
  query.SQL.Text :=
    'SELECT * FROM public."Contato" ' +
    'WHERE ativo = TRUE ' +
    'ORDER BY nome';

  try
    query.Open;
    while not query.Eof do
    begin
      Contato := Contatos.Create;
      PreencherContatoFromQuery(query, Contato);
      Result.Add(Contato);
      query.Next;
    end;
  finally
    query.Close;
  end;
end;

// ====================================================================
// BUSCAR POR NOME
// ====================================================================
function TContatosRepository.BuscarPorNome(ANome: string): TObjectList<Contatos>;
var
  Contato: Contatos;
begin
  Result := TObjectList<Contatos>.Create(True);

  query.SQL.Clear;
  query.SQL.Text :=
    'SELECT * FROM public."Contato" ' +
    'WHERE nome LIKE :nome AND ativo = TRUE';

  query.ParamByName('nome').AsString := '%' + ANome + '%';
  query.Open;

  while not query.Eof do
  begin
    Contato := Contatos.Create;
    PreencherContatoFromQuery(query, Contato);
    Result.Add(Contato);
    query.Next;
  end;

  query.Close;
end;

// ====================================================================
// BUSCAR POR TELEFONE
// ====================================================================
function TContatosRepository.BuscarPorTelefone(ATelefone: string): TObjectList<Contatos>;
var
  Contato: Contatos;
begin
  Result := TObjectList<Contatos>.Create(True);

  query.SQL.Clear;
  query.SQL.Text :=
    'SELECT * FROM public."Contato" ' +
    'WHERE telefone LIKE :telefone AND ativo = TRUE';

  query.ParamByName('telefone').AsString := '%' + ATelefone + '%';
  query.Open;

  while not query.Eof do
  begin
    Contato := Contatos.Create;
    PreencherContatoFromQuery(query, Contato);
    Result.Add(Contato);
    query.Next;
  end;

  query.Close;
end;

// ====================================================================
// BUSCAR POR EMPRESA (campo texto "empresa")
// ====================================================================
function TContatosRepository.BuscarPorEmpresa(AEmpresa: string): TObjectList<Contatos>;
var
  Contato: Contatos;
begin
  Result := TObjectList<Contatos>.Create(True);

  query.SQL.Clear;
  query.SQL.Text :=
    'SELECT * FROM public."Contato" ' +
    'WHERE empresa = :empresa AND ativo = TRUE';

  query.ParamByName('empresa').AsString := AEmpresa;
  query.Open;

  while not query.Eof do
  begin
    Contato := Contatos.Create;
    PreencherContatoFromQuery(query, Contato);
    Result.Add(Contato);
    query.Next;
  end;

  query.Close;
end;

// ====================================================================
// BUSCAR POR EMAIL
// ====================================================================
function TContatosRepository.BuscarPorEmail(AEmail: string): TObjectList<Contatos>;
var
  Contato: Contatos;
begin
  Result := TObjectList<Contatos>.Create(True);

  query.SQL.Clear;
  query.SQL.Text :=
    'SELECT * FROM public."Contato" ' +
    'WHERE email = :email AND ativo = TRUE';

  query.ParamByName('email').AsString := AEmail;
  query.Open;

  while not query.Eof do
  begin
    Contato := Contatos.Create;
    PreencherContatoFromQuery(query, Contato);
    Result.Add(Contato);
    query.Next;
  end;

  query.Close;
end;

// ====================================================================
// ATUALIZAR POR ID (EDIÇÃO NO GRID) – continua sem id_empresa
// ====================================================================
function TContatosRepository.AtualizarPorId(
  AId: Integer; ANome, ATelefone, AEmail, AEmpresa, AEndereco,
  ACEP, ALogradouro, ANumero, AComplemento, ABairro, ACidade, AUF: string
): Boolean;
begin
  Result := False;
  query.SQL.Clear;

  query.SQL.Text :=
    'UPDATE public."Contato" SET ' +
    ' nome = :nome, ' +
    ' telefone = :telefone, ' +
    ' email = :email, ' +
    ' empresa = :empresa, ' +
    ' endereco = :endereco, ' +
    ' cep = :cep, ' +
    ' logradouro = :logradouro, ' +
    ' numero = :numero, ' +
    ' complemento = :complemento, ' +
    ' bairro = :bairro, ' +
    ' cidade = :cidade, ' +
    ' uf = :uf ' +
    'WHERE id_contato = :id_contato AND ativo = TRUE';

  query.ParamByName('id_contato').AsInteger := AId;
  query.ParamByName('nome').AsString        := ANome;
  query.ParamByName('telefone').AsString    := ATelefone;
  query.ParamByName('email').AsString       := AEmail;
  query.ParamByName('empresa').AsString     := AEmpresa;
  query.ParamByName('endereco').AsString    := AEndereco;
  query.ParamByName('cep').AsString         := ACEP;
  query.ParamByName('logradouro').AsString  := ALogradouro;
  query.ParamByName('numero').AsString      := ANumero;
  query.ParamByName('complemento').AsString := AComplemento;
  query.ParamByName('bairro').AsString      := ABairro;
  query.ParamByName('cidade').AsString      := ACidade;
  query.ParamByName('uf').AsString          := AUF;

  query.ExecSQL;
  Result := query.RowsAffected > 0;
end;

end.

