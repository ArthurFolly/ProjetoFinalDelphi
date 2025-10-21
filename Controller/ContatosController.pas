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

    function AdicionarContato(AContato: Contatos): Boolean;
    function AtualizarContato(AContato: Contatos): Boolean;
    function ExcluirContato(AId: Integer): Boolean;
    procedure CarregarContatos(ALista: TObjectList<Contatos>);
    function ListarContatos: TObjectList<Contatos>;

    // *** CORRIGIDO - COM PARÂMETRO ***
    procedure RemoverDaLista(ALista: TObjectList<Contatos>; AId: Integer);
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
  Result := True;
end;


procedure TContatosController.RemoverDaLista(ALista: TObjectList<Contatos>; AId: Integer);
var
  I: Integer;
begin
  for I := 0 to ALista.Count - 1 do
  begin
    if ALista[I].Id = AId then
    begin
      ALista.Delete(I);
      Break;
    end;
  end;
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

end.
