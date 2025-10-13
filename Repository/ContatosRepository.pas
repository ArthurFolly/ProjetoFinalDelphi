unit ContatosRepository;

interface

uses ConexaoBanco,firedac.Comp.Client, firedac.DApt,TContatosModel,SysUtils,System.Hash,System.Generics.Collections;

implementation

Type TContatosRepository = class

private

query : TFDQuery;

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
    function AlternarFavorito(AId: Integer): Boolean;




end;

{ Contatos }




function TContatosRepository.AlternarFavorito(aId: Integer): Boolean;
begin

end;

function TContatosRepository.Atualizar(AContato: Contatos): Boolean;
begin
  Result := False;

    Self.query.SQL.Clear;
    Self.query.SQL.Text := 'UPDATE contatos SET nome = :nome, telefone = :telefone, email = :email, ' +
                           'endereco = :endereco, empresa = :empresa, observacoes = :observacoes, ' +
                           'id_usuario = :id_usuario WHERE id_contato = :id_contato';
    Self.query.ParamByName('id_contato').AsInteger := AContato.Id;
    Self.query.ParamByName('nome').AsString := AContato.Nome;
    Self.query.ParamByName('telefone').AsString := AContato.Telefone;
    Self.query.ParamByName('email').AsString := AContato.Email;
    Self.query.ParamByName('endereco').AsString := AContato.Endereco;
    Self.query.ParamByName('empresa').AsString := AContato.Empresa;
    Self.query.ParamByName('observacoes').AsString := AContato.Observacoes;
    Self.query.ParamByName('id_usuario').AsInteger := AContato.Id_usuario;
    Self.query.ExecSQL;

    Result := Self.query.RowsAffected > 0;
  end;
function TContatosRepository.BuscarPorEmpresa(aEmpresa: string): TObjectList<Contatos>;
var
  TContato: Contatos;
begin
  Result := TObjectList<Contatos>.Create(True);
  try
    Self.query.SQL.Clear;
    Self.query.SQL.Text := 'SELECT id_contato, nome, empresa FROM contatos WHERE empresa = :empresa';
    Self.query.ParamByName('empresa').AsString := aEmpresa;
    Self.query.Open;

    while not Self.query.Eof do
    begin
      TContato := Contatos.Create;
      TContato.Id := Self.query.FieldByName('id_contato').AsInteger;
      TContato.Nome := Self.query.FieldByName('nome').AsString;
      TContato.Empresa := Self.query.FieldByName('empresa').AsString;
      Result.Add(TContato);
      Self.query.Next;
    end;
    Self.query.Close;
  except
    Result.Free;
    raise;
  end;
end;

function TContatosRepository.BuscarPorId(aId: Integer): Contatos;
begin

end;

function TContatosRepository.BuscarPorNome(aNome: string): TObjectList<Contatos>;
begin

end;

function TContatosRepository.BuscarPorTelefone(ATelefone: string): TObjectList<Contatos>;
begin

end;

constructor TContatosRepository.Create;
begin
  Inherited create;

  Self.query := TFDQuery.Create(nil);

  Self.query.Connection :=  DataModule1.FDConnection1;


end;

destructor TContatosRepository.Destroy;
begin
  Inherited;
end;



function TContatosRepository.Adicionar(aContato: Contatos): Boolean;




begin

  Result := False;
  Self.query.sql.clear;
  Self.query.SQL.Text := 'INSERT INTO contatos (id_contato, nome, telefone, email, endereco, empresa, observacoes, id_usuario,favoritos) ' +
                      'VALUES (:id_contato, :nome, :telefone, :email, :endereco, :empresa, :observacoes, :id_usuario,)';
  Self.query.ParamByName('id_contato').AsInteger := aContato.Id;
  Self.query.ParamByName('nome').AsString := aContato.Nome;
  Self.query.ParamByName('telefone').AsString := aContato.Telefone;
  Self.query.ParamByName('email').AsString := aContato.Email;
  Self.query.ParamByName('endereco').AsString := aContato.Endereco;
  Self.query.ParamByName('empresa').AsString := aContato.Empresa;
  self.query.ParamByName('observacoes').AsString := aContato.Observacoes;
  Self.query.ExecSQL;

  Result := True
end;


function TContatosRepository.ListarTodos: TObjectList<Contatos>;
var Contato: Contatos;
begin
Result := TObjectList<Contatos>.Create(True);

Self.query.sql.Clear;
Self.query.SQL.Text := 'SELECT id_contato, nome, telefone, email, endereco, empresa, observacoes, id_usuario, favoritos FROM contatos';
Self.query.Open();

while not Self.query.Eof do begin

  Contato := Contatos.Create;


  Self.query.FieldByName('id_contato').AsInteger := Contato.Id;
  Self.query.FieldByName('nome').AsString := Contato.Nome;
  Self.query.FieldByName('telefone').AsString := Contato.Telefone;
  Self.query.FieldByName('email').AsString := Contato.Email;
  Self.query.FieldByName('endereco').AsString := Contato.Endereco;
  Self.query.FieldByName('empresa').AsString := Contato.Empresa;
  Self.query.FieldByName('observacoes').AsString := Contato.Observacoes;
  Self.query.FieldByName('id_usuario').AsInteger := Contato.Id_usuario;
  Self.query.FieldByName('favoritos').AsBoolean := Contato.Favorito;
  Result.Add(Contato);
  Self.query.Next;

end;
  Self.query.Close;
end;

end.
