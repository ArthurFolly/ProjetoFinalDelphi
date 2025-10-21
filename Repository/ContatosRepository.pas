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
    destructor Destroy;

    function Adicionar(AContato: Contatos): Boolean;
    function Atualizar(AContato: Contatos): Boolean;
    function BuscarPorId(AId: Integer): Contatos;
    function ListarTodos: TObjectList<Contatos>;
    function BuscarPorNome(ANome: string): TObjectList<Contatos>;
    function BuscarPorTelefone(ATelefone: string): TObjectList<Contatos>;
    function BuscarPorEmpresa(AEmpresa: string): TObjectList<Contatos>;
  end;

implementation

constructor TContatosRepository.Create;
begin
  Inherited Create;
  Self.query := TFDQuery.Create(nil);
  Self.query.Connection := DataModule1.FDConnection1;
end;

destructor TContatosRepository.Destroy;
begin
  Self.query.Free;
  Inherited;
end;

function TContatosRepository.Adicionar(AContato: Contatos): Boolean;
begin
  Result := False;

    Self.query.SQL.Clear;
    Self.query.SQL.Text := 'INSERT INTO "Contato" (nome, telefone, email, endereco, empresa, observacoes,ativo) ' +
                           'VALUES (:nome, :telefone, :email, :endereco, :empresa, :observacoes,:ativo)';
    Self.query.ParamByName('nome').AsString := AContato.Nome;
    Self.query.ParamByName('telefone').AsString := AContato.Telefone;
    Self.query.ParamByName('email').AsString := AContato.Email;
    Self.query.ParamByName('endereco').AsString := AContato.Endereco;
    Self.query.ParamByName('empresa').AsString := AContato.Empresa;
    Self.query.ParamByName('observacoes').AsString := AContato.Observacoes;

    Self.query.ParamByName('ativo').AsBoolean := AContato.Ativo;
    Self.query.ExecSQL;
    Result := Self.query.RowsAffected > 0;

end;

function TContatosRepository.Atualizar(AContato: Contatos): Boolean;
begin
  Result := False;

    Self.query.SQL.Clear;
    Self.query.SQL.Text := 'UPDATE "Contato" SET nome = :nome, telefone = :telefone, email = :email, ' +
                           'endereco = :endereco, empresa = :empresa, observacoes = :observacoes, ' +
                           ' ativo = :ativo WHERE id_contato = :id_contato';
    Self.query.ParamByName('id_contato').AsInteger := AContato.Id;
    Self.query.ParamByName('nome').AsString := AContato.Nome;
    Self.query.ParamByName('telefone').AsString := AContato.Telefone;
    Self.query.ParamByName('email').AsString := AContato.Email;
    Self.query.ParamByName('endereco').AsString := AContato.Endereco;
    Self.query.ParamByName('empresa').AsString := AContato.Empresa;
    Self.query.ParamByName('observacoes').AsString := AContato.Observacoes;
    Self.query.ParamByName('ativo').AsBoolean := AContato.Ativo;
    Self.query.ExecSQL;
    Result := Self.query.RowsAffected > 0;

end;

function TContatosRepository.BuscarPorId(AId: Integer): Contatos;
begin
  Result := nil;

    Self.query.SQL.Clear;
    Self.query.SQL.Text := 'SELECT * FROM "Contato" WHERE id_contato = :id_contato AND ativo = TRUE';
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
  Self.query.SQL.Text := 'SELECT * FROM "Contato" WHERE ativo = TRUE';
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
    Contato.Ativo := Self.query.FieldByName('ativo').AsBoolean;

    Result.Add(Contato);
    Self.query.Next;
  end;

  Self.query.Close;
end;

function TContatosRepository.BuscarPorNome(ANome: string): TObjectList<Contatos>;
var
  Contato: Contatos;
begin
  Result := TObjectList<Contatos>.Create(True);

    Self.query.SQL.Clear;
    Self.query.SQL.Text := 'SELECT * FROM "Contato" WHERE nome LIKE :nome AND ativo = TRUE';
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
    Self.query.SQL.Text := 'SELECT * FROM "Contato" WHERE telefone LIKE :telefone AND ativo = TRUE';
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
    Self.query.SQL.Text := 'SELECT * FROM "Contato" WHERE empresa = :empresa AND ativo = TRUE';
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
      Contato.Ativo := Self.query.FieldByName('ativo').AsBoolean;
      Result.Add(Contato);
      Self.query.Next;
    end;
    Self.query.Close;

end;

end.
