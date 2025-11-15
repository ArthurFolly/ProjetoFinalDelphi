unit ContatosRepository;

interface

uses
  ConexaoBanco, FireDAC.Comp.Client, FireDAC.DApt, TContatosModel, SysUtils,
  System.Generics.Collections;

type
  TContatosRepository = class
  private
    query: TFDQuery;
  public
    constructor Create;
    destructor Destroy; override;

    function Adicionar(AContato: Contatos): Boolean;
    function Atualizar(AContato: Contatos): Boolean;
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
  inherited Create;  // CORRETO
  Self.query := TFDQuery.Create(nil);
  Self.query.Connection := DataModule1.FDConnection1;
end;

destructor TContatosRepository.Destroy;
begin
  Self.query.Free;
  inherited;  // CORRETO
end;

// ====================================================================
// ADICIONAR
// ====================================================================
function TContatosRepository.Adicionar(AContato: Contatos): Boolean;
begin
  Result := False;
  Self.query.SQL.Clear;
  Self.query.SQL.Text :=
    'INSERT INTO public."Contato" ' +
    '(nome, telefone, email, empresa, endereco, observacoes, ' +
    'cep, logradouro, numero, complemento, bairro, cidade, uf, ativo) ' +
    'VALUES (:nome, :telefone, :email, :empresa, :endereco, :observacoes, ' +
    ':cep, :logradouro, :numero, :complemento, :bairro, :cidade, :uf, :ativo) ' +
    'RETURNING id_contato';

  Self.query.ParamByName('nome').AsString := AContato.Nome;
  Self.query.ParamByName('telefone').AsString := AContato.Telefone;
  Self.query.ParamByName('email').AsString := AContato.Email;
  Self.query.ParamByName('empresa').AsString := AContato.Empresa;
  Self.query.ParamByName('endereco').AsString := AContato.Endereco;
  Self.query.ParamByName('observacoes').AsString := AContato.Observacoes;
  Self.query.ParamByName('cep').AsString := AContato.CEP;
  Self.query.ParamByName('logradouro').AsString := AContato.Logradouro;
  Self.query.ParamByName('numero').AsString := AContato.Numero;
  Self.query.ParamByName('complemento').AsString := AContato.Complemento;
  Self.query.ParamByName('bairro').AsString := AContato.Bairro;
  Self.query.ParamByName('cidade').AsString := AContato.Cidade;
  Self.query.ParamByName('uf').AsString := AContato.UF;
  Self.query.ParamByName('ativo').AsBoolean := AContato.Ativo;

  Self.query.Open;
  if not Self.query.Eof then
  begin
    AContato.Id := Self.query.FieldByName('id_contato').AsInteger;
    Result := True;
  end;
  Self.query.Close;  // ADICIONADO
end;

// ====================================================================
// ATUALIZAR
// ====================================================================
function TContatosRepository.Atualizar(AContato: Contatos): Boolean;
begin
  Result := False;
  Self.query.SQL.Clear;
  Self.query.SQL.Text :=
    'UPDATE public."Contato" SET ' +
    'nome = :nome, telefone = :telefone, email = :email, ' +
    'empresa = :empresa, endereco = :endereco, observacoes = :observacoes, ' +
    'cep = :cep, logradouro = :logradouro, numero = :numero, ' +
    'complemento = :complemento, bairro = :bairro, cidade = :cidade, uf = :uf, ' +
    'ativo = :ativo ' +
    'WHERE id_contato = :id_contato';

  Self.query.ParamByName('id_contato').AsInteger := AContato.Id;
  Self.query.ParamByName('nome').AsString := AContato.Nome;
  Self.query.ParamByName('telefone').AsString := AContato.Telefone;
  Self.query.ParamByName('email').AsString := AContato.Email;
  Self.query.ParamByName('empresa').AsString := AContato.Empresa;
  Self.query.ParamByName('endereco').AsString := AContato.Endereco;
  Self.query.ParamByName('observacoes').AsString := AContato.Observacoes;
  Self.query.ParamByName('cep').AsString := AContato.CEP;
  Self.query.ParamByName('logradouro').AsString := AContato.Logradouro;
  Self.query.ParamByName('numero').AsString := AContato.Numero;
  Self.query.ParamByName('complemento').AsString := AContato.Complemento;
  Self.query.ParamByName('bairro').AsString := AContato.Bairro;
  Self.query.ParamByName('cidade').AsString := AContato.Cidade;
  Self.query.ParamByName('uf').AsString := AContato.UF;
  Self.query.ParamByName('ativo').AsBoolean := AContato.Ativo;

  Self.query.ExecSQL;
  Result := Self.query.RowsAffected > 0;
end;

// ====================================================================
// BUSCAR POR ID
// ====================================================================
function TContatosRepository.BuscarPorId(AId: Integer): Contatos;
begin
  Result := nil;
  Self.query.SQL.Clear;
  Self.query.SQL.Text :=
    'SELECT * FROM public."Contato" WHERE id_contato = :id_contato AND ativo = TRUE';
  Self.query.ParamByName('id_contato').AsInteger := AId;
  Self.query.Open;
  if not Self.query.Eof then
  begin
    Result := Contatos.Create;
    Result.Id := Self.query.FieldByName('id_contato').AsInteger;
    Result.Nome := Self.query.FieldByName('nome').AsString;
    Result.Telefone := Self.query.FieldByName('telefone').AsString;
    Result.Email := Self.query.FieldByName('email').AsString;
    Result.Endereco := Self.query.FieldByName('endereco').AsString;
    Result.Empresa := Self.query.FieldByName('empresa').AsString;
    Result.Observacoes := Self.query.FieldByName('observacoes').AsString;
    Result.CEP := Self.query.FieldByName('cep').AsString;
    Result.Logradouro := Self.query.FieldByName('logradouro').AsString;
    Result.Numero := Self.query.FieldByName('numero').AsString;
    Result.Complemento := Self.query.FieldByName('complemento').AsString;
    Result.Bairro := Self.query.FieldByName('bairro').AsString;
    Result.Cidade := Self.query.FieldByName('cidade').AsString;
    Result.UF := Self.query.FieldByName('uf').AsString;
    Result.Ativo := Self.query.FieldByName('ativo').AsBoolean;
  end;
  Self.query.Close;
end;


function TContatosRepository.ListarTodos: TObjectList<Contatos>;
var
  Contato: Contatos;
begin
  Result := TObjectList<Contatos>.Create(True);

  Self.query.SQL.Clear;
  Self.query.SQL.Text :=
    'SELECT * FROM public."Contato" ' +
    'WHERE ativo = TRUE ' +  // Só TRUE → simples e direto
    'ORDER BY nome';

  try
    Self.query.Open;

    while not Self.query.Eof do
    begin
      Contato := Contatos.Create;

      Contato.Id := Self.query.FieldByName('id_contato').AsInteger;
      Contato.Nome := Self.query.FieldByName('nome').AsString;
      Contato.Telefone := Self.query.FieldByName('telefone').AsString;
      Contato.Email := Self.query.FieldByName('email').AsString;
      Contato.Empresa := Self.query.FieldByName('empresa').AsString;
      Contato.Endereco := Self.query.FieldByName('endereco').AsString;
      Contato.Observacoes := Self.query.FieldByName('observacoes').AsString;
      Contato.CEP := Self.query.FieldByName('cep').AsString;
      Contato.Logradouro := Self.query.FieldByName('logradouro').AsString;
      Contato.Numero := Self.query.FieldByName('numero').AsString;
      Contato.Complemento := Self.query.FieldByName('complemento').AsString;
      Contato.Bairro := Self.query.FieldByName('bairro').AsString;
      Contato.Cidade := Self.query.FieldByName('cidade').AsString;
      Contato.UF := Self.query.FieldByName('uf').AsString;

      Contato.Ativo := Self.query.FieldByName('ativo').AsBoolean; // TRUE → True

      Result.Add(Contato);
      Self.query.Next;
    end;
  finally
    Self.query.Close;
  end;
end;



function TContatosRepository.BuscarPorNome(ANome: string): TObjectList<Contatos>;
var
  Contato: Contatos;
begin
  Result := TObjectList<Contatos>.Create(True);
  Self.query.SQL.Clear;
  Self.query.SQL.Text := 'SELECT * FROM public."Contato" WHERE nome LIKE :nome AND ativo = TRUE';
  Self.query.ParamByName('nome').AsString := '%' + ANome + '%';
  Self.query.Open;
  while not Self.query.Eof do
  begin
    Contato := Contatos.Create;
    Contato.Id := Self.query.FieldByName('id_contato').AsInteger;
    Contato.Nome := Self.query.FieldByName('nome').AsString;
    Contato.Telefone := Self.query.FieldByName('telefone').AsString;
    Contato.Email := Self.query.FieldByName('email').AsString;
    Contato.Endereco := Self.query.FieldByName('endereco').AsString;
    Contato.Empresa := Self.query.FieldByName('empresa').AsString;
    Contato.Observacoes := Self.query.FieldByName('observacoes').AsString;
    Contato.CEP := Self.query.FieldByName('cep').AsString;
    Contato.Logradouro := Self.query.FieldByName('logradouro').AsString;
    Contato.Numero := Self.query.FieldByName('numero').AsString;
    Contato.Complemento := Self.query.FieldByName('complemento').AsString;
    Contato.Bairro := Self.query.FieldByName('bairro').AsString;
    Contato.Cidade := Self.query.FieldByName('cidade').AsString;
    Contato.UF := Self.query.FieldByName('uf').AsString;
    Contato.Ativo := Self.query.FieldByName('ativo').AsBoolean;
    Result.Add(Contato);
    Self.query.Next;
  end;
  Self.query.Close;
end;

function TContatosRepository.BuscarPorTelefone(ATelefone: string): TObjectList<Contatos>;
var
  Contato: Contatos;
begin
  Result := TObjectList<Contatos>.Create(True);
  Self.query.SQL.Clear;
  Self.query.SQL.Text := 'SELECT * FROM public."Contato" WHERE telefone LIKE :telefone AND ativo = TRUE';
  Self.query.ParamByName('telefone').AsString := '%' + ATelefone + '%';
  Self.query.Open;
  while not Self.query.Eof do
  begin
    Contato := Contatos.Create;
    Contato.Id := Self.query.FieldByName('id_contato').AsInteger;
    Contato.Nome := Self.query.FieldByName('nome').AsString;
    Contato.Telefone := Self.query.FieldByName('telefone').AsString;
    Contato.Email := Self.query.FieldByName('email').AsString;
    Contato.Endereco := Self.query.FieldByName('endereco').AsString;
    Contato.Empresa := Self.query.FieldByName('empresa').AsString;
    Contato.Observacoes := Self.query.FieldByName('observacoes').AsString;
    Contato.CEP := Self.query.FieldByName('cep').AsString;
    Contato.Logradouro := Self.query.FieldByName('logradouro').AsString;
    Contato.Numero := Self.query.FieldByName('numero').AsString;
    Contato.Complemento := Self.query.FieldByName('complemento').AsString;
    Contato.Bairro := Self.query.FieldByName('bairro').AsString;
    Contato.Cidade := Self.query.FieldByName('cidade').AsString;
    Contato.UF := Self.query.FieldByName('uf').AsString;
    Contato.Ativo := Self.query.FieldByName('ativo').AsBoolean;
    Result.Add(Contato);
    Self.query.Next;
  end;
  Self.query.Close;
end;

function TContatosRepository.BuscarPorEmpresa(AEmpresa: string): TObjectList<Contatos>;
var
  Contato: Contatos;
begin
  Result := TObjectList<Contatos>.Create(True);
  Self.query.SQL.Clear;
  Self.query.SQL.Text := 'SELECT * FROM public."Contato" WHERE empresa = :empresa AND ativo = TRUE';
  Self.query.ParamByName('empresa').AsString := AEmpresa;
  Self.query.Open;
  while not Self.query.Eof do
  begin
    Contato := Contatos.Create;
    Contato.Id := Self.query.FieldByName('id_contato').AsInteger;
    Contato.Nome := Self.query.FieldByName('nome').AsString;
    Contato.Telefone := Self.query.FieldByName('telefone').AsString;
    Contato.Email := Self.query.FieldByName('email').AsString;
    Contato.Endereco := Self.query.FieldByName('endereco').AsString;
    Contato.Empresa := Self.query.FieldByName('empresa').AsString;
    Contato.Observacoes := Self.query.FieldByName('observacoes').AsString;
    Contato.CEP := Self.query.FieldByName('cep').AsString;
    Contato.Logradouro := Self.query.FieldByName('logradouro').AsString;
    Contato.Numero := Self.query.FieldByName('numero').AsString;
    Contato.Complemento := Self.query.FieldByName('complemento').AsString;
    Contato.Bairro := Self.query.FieldByName('bairro').AsString;
    Contato.Cidade := Self.query.FieldByName('cidade').AsString;
    Contato.UF := Self.query.FieldByName('uf').AsString;
    Contato.Ativo := Self.query.FieldByName('ativo').AsBoolean;
    Result.Add(Contato);
    Self.query.Next;
  end;
  Self.query.Close;
end;

function TContatosRepository.BuscarPorEmail(AEmail: string): TObjectList<Contatos>;
var
  Contato: Contatos;
begin
  Result := TObjectList<Contatos>.Create(True);
  Self.query.SQL.Clear;
  Self.query.SQL.Text :=
    'SELECT * FROM public."Contato" WHERE email = :email AND ativo = TRUE';
  Self.query.ParamByName('email').AsString := AEmail;
  Self.query.Open;
  while not Self.query.Eof do
  begin
    Contato := Contatos.Create;
    Contato.Id := Self.query.FieldByName('id_contato').AsInteger;
    Contato.Nome := Self.query.FieldByName('nome').AsString;
    Contato.Telefone := Self.query.FieldByName('telefone').AsString;
    Contato.Email := Self.query.FieldByName('email').AsString;
    Contato.Endereco := Self.query.FieldByName('endereco').AsString;
    Contato.Empresa := Self.query.FieldByName('empresa').AsString;
    Contato.Observacoes := Self.query.FieldByName('observacoes').AsString;
    Contato.CEP := Self.query.FieldByName('cep').AsString;
    Contato.Logradouro := Self.query.FieldByName('logradouro').AsString;
    Contato.Numero := Self.query.FieldByName('numero').AsString;
    Contato.Complemento := Self.query.FieldByName('complemento').AsString;
    Contato.Bairro := Self.query.FieldByName('bairro').AsString;
    Contato.Cidade := Self.query.FieldByName('cidade').AsString;
    Contato.UF := Self.query.FieldByName('uf').AsString;
    Contato.Ativo := Self.query.FieldByName('ativo').AsBoolean;
    Result.Add(Contato);
    Self.query.Next;
  end;
  Self.query.Close;
end;

// ====================================================================
// ATUALIZAR POR ID (PARA GRID)
// ====================================================================
function TContatosRepository.AtualizarPorId(
  AId: Integer; ANome, ATelefone, AEmail, AEmpresa, AEndereco,
  ACEP, ALogradouro, ANumero, AComplemento, ABairro, ACidade, AUF: string
): Boolean;
begin
  Result := False;
  Self.query.SQL.Clear;
  Self.query.SQL.Text :=
    'UPDATE public."Contato" SET ' +
    'nome = :nome, telefone = :telefone, email = :email, ' +
    'empresa = :empresa, endereco = :endereco, ' +
    'cep = :cep, logradouro = :logradouro, numero = :numero, ' +
    'complemento = :complemento, bairro = :bairro, cidade = :cidade, uf = :uf ' +
    'WHERE id_contato = :id_contato AND ativo = TRUE';

  Self.query.ParamByName('id_contato').AsInteger := AId;
  Self.query.ParamByName('nome').AsString := ANome;
  Self.query.ParamByName('telefone').AsString := ATelefone;
  Self.query.ParamByName('email').AsString := AEmail;
  Self.query.ParamByName('empresa').AsString := AEmpresa;
  Self.query.ParamByName('endereco').AsString := AEndereco;
  Self.query.ParamByName('cep').AsString := ACEP;
  Self.query.ParamByName('logradouro').AsString := ALogradouro;
  Self.query.ParamByName('numero').AsString := ANumero;
  Self.query.ParamByName('complemento').AsString := AComplemento;
  Self.query.ParamByName('bairro').AsString := ABairro;
  Self.query.ParamByName('cidade').AsString := ACidade;
  Self.query.ParamByName('uf').AsString := AUF;

  Self.query.ExecSQL;
  Result := Self.query.RowsAffected > 0;
end;

end.
