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
    function Excluir(AId: Integer): Boolean;
    function ExcluirPorNome(ANome: string): Boolean;
    function BuscarPorId(AId: Integer): Contatos;
    function ListarTodos: TObjectList<Contatos>;
    function BuscarPorNome(ANome: string): TObjectList<Contatos>;
    function BuscarPorTelefone(ATelefone: string): TObjectList<Contatos>;
    function BuscarPorEmpresa(AEmpresa: string): TObjectList<Contatos>;
    function ListarFavoritos: TObjectList<Contatos>;
    function AlternarFavorito(AId: Integer): Boolean;




end;

{ Contatos }




function TContatosRepository.AlternarFavorito(aId: Integer): Boolean;
begin

end;

function TContatosRepository.Atualizar(aContato: Contatos): Boolean;
begin

end;

function TContatosRepository.BuscarPorEmpresa(aEmpresa: string): TObjectList<Contatos>;
begin

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

function TContatosRepository.Excluir(aId: Integer): Boolean;
begin



end;

function TContatosRepository.ExcluirPorNome(ANome: string): Boolean;
begin
  Result := false;
  self.query.SQL.Text := 'DELETE FROM contatos Where nome = :nome';
  self.query.ParamByName('nome').AsString := aNome;
  Self.query.ExecSQL;


end;

function TContatosRepository.Adicionar(aContato: Contatos): Boolean;

var query : TFDQuery;


begin

  Result := False;
  Self.query.sql.clear;
  Self.query.SQL.Text := 'INSERT INTO contatos (id_contato, nome, telefone, email, endereco, empresa, observacoes, id_usuario,favoritos) ' +
                      'VALUES (:id_contato, :nome, :telefone, :email, :endereco, :empresa, :observacoes, :id_usuario,:favoritos)';
  Self.query.ParamByName('id_contato').AsInteger := aContato.Id;
  Self.query.ParamByName('nome').AsString := aContato.Nome;
  Self.query.ParamByName('telefone').AsString := aContato.Telefone;
  Self.query.ParamByName('email').AsString := aContato.Email;
  Self.query.ParamByName('endereco').AsString := aContato.Endereco;
  Self.query.ParamByName('empresa').AsString := aContato.Empresa;
  self.query.ParamByName('observacoes').AsString := aContato.Observacoes;
  self.query.ParamByName('favoritos').AsBoolean := aContato.Favorito;
  self.query.ParamByName('id_usuario').AsInteger := aContato.Id_usuario;


  Result := True




end;

function TContatosRepository.ListarFavoritos: TObjectList<Contatos>;
begin

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
  Self.query.FieldByName('id_contato').AsInteger := Contato.Id;
  Self.query.FieldByName('id_contato').AsInteger := Contato.Id;
  Self.query.FieldByName('id_contato').AsInteger := Contato.Id;
  Self.query.FieldByName('id_contato').AsInteger := Contato.Id;
  Self.query.FieldByName('id_contato').AsInteger := Contato.Id;

  Result.Add(Contato);
  Self.query.Next;
end;

end;

end.
