unit ContatosController;

interface

uses
  System.SysUtils, System.Generics.Collections,
  TContatosModel, ContatosRepository,
  Vcl.Dialogs, Vcl.Forms, Vcl.Controls;

type
  TContatosController = class
  private
    ContatosRepository: TContatosRepository;
  public
    constructor Create;
    destructor Destroy; override;

    // Métodos para compatibilidade com o Form
    function AdicionarContato(AContato: Contatos): Boolean;
    function AtualizarContato(AContato: Contatos): Boolean;
    function ExcluirContato(AId: Integer): Boolean;
    procedure CarregarContatos(ALista: TObjectList<Contatos>);
    function ListarContatos: TObjectList<Contatos>;
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

function TContatosController.ExcluirContato(AId: Integer): Boolean;
begin
  // Para exclusão lógica (só remover do grid)
  Result := True;
end;

function TContatosController.ListarContatos: TObjectList<Contatos>;
begin
  Result := ContatosRepository.ListarTodos;
end;

procedure TContatosController.CarregarContatos(ALista: TObjectList<Contatos>);
var
  TempLista: TObjectList<Contatos>;
  I: Integer;
begin
  ALista.Clear;
  TempLista := ListarContatos;
  try
    for I := 0 to TempLista.Count - 1 do
      ALista.Add(TempLista[I]);
  finally
    TempLista.Free;
  end;
end;

end.
