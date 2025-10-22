unit ContatosController;

interface

uses
  System.SysUtils, System.Generics.Collections,
  TContatosModel, ContatosRepository,
  Vcl.Dialogs, Vcl.Forms, Vcl.Controls, Data.DB;

type
  TContatosController = class
  private
    ContatosRepository: TContatosRepository;
  public
    constructor Create;
    destructor Destroy; override;

    function AdicionarContato(AContato: Contatos): Boolean;
    function AtualizarContato(AContato: Contatos): Boolean;
    procedure CarregarContatos(ALista: TObjectList<Contatos>);
    function ListarContatos: TObjectList<Contatos>;

    // *** GRID - EDIÇÃO NO BANCO ***
    procedure SalvarEdicaoGrid(DataSet: TDataSet);
  end;

implementation

constructor TContatosController.Create;
begin
  ContatosRepository := TContatosRepository.Create;
end;

destructor TContatosController.Destroy;
begin
  ContatosRepository.Free;
  inherited;
end;

function TContatosController.AdicionarContato(AContato: Contatos): Boolean;
begin
  Result := ContatosRepository.Adicionar(AContato);
end;

function TContatosController.AtualizarContato(AContato: Contatos): Boolean;
begin
  Result := ContatosRepository.Atualizar(AContato);
end;

function TContatosController.ListarContatos: TObjectList<Contatos>;
begin
  Result := ContatosRepository.ListarTodos;
end;

procedure TContatosController.CarregarContatos(ALista: TObjectList<Contatos>);
var
  ListaNova: TObjectList<Contatos>;
  i: Integer;
begin
  ALista.Clear;
  ListaNova := ListarContatos;

  for i := 0 to ListaNova.Count - 1 do
    ALista.Add(ListaNova[i]);

  ListaNova.OwnsObjects := False;
  ListaNova.Free;
end;


procedure TContatosController.SalvarEdicaoGrid(DataSet: TDataSet);
begin
  ContatosRepository.AtualizarPorId(
    DataSet.FieldByName('ID').AsInteger,
    DataSet.FieldByName('NOME').AsString,
    DataSet.FieldByName('TELEFONE').AsString,
    DataSet.FieldByName('EMAIL').AsString,
    DataSet.FieldByName('EMPRESA').AsString,
    DataSet.FieldByName('ENDERECO').AsString
  );
end;

end.
