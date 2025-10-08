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

function TContatosRepository.Adicionar(aContato: Contatos): Boolean;

var query : TFDQuery;

begin
Result := False;





end;

function TContatosRepository.ListarFavoritos: TObjectList<Contatos>;
begin

end;

function TContatosRepository.ListarTodos: TObjectList<Contatos>;
begin

end;

end.
