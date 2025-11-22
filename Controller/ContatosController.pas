unit ContatosController;

interface

uses
  System.SysUtils, System.Generics.Collections,
  TContatosModel, ContatosRepository,
  Data.DB;

type
  TContatosController = class
  private
    ContatosRepository: TContatosRepository;
  public
    constructor Create;
    destructor Destroy; override;

    function AdicionarContato(AContato: Contatos; out Mensagem: string): Boolean;
    function AtualizarContato(AContato: Contatos; out Mensagem: string): Boolean;
    function ExcluirContato(AId: Integer; out Mensagem: string): Boolean; // << NOVA
    function ListarContatos: TObjectList<Contatos>;
    procedure CarregarContatos(ALista: TObjectList<Contatos>);

    // GRID: retorna se salvou ou não + mensagem
    function SalvarEdicaoGrid(DataSet: TDataSet; out Mensagem: string): Boolean;
  end;

implementation

{ TContatosController }

constructor TContatosController.Create;
begin
  ContatosRepository := TContatosRepository.Create;
end;

destructor TContatosController.Destroy;
begin
  ContatosRepository.Free;
  inherited;
end;

// ====================================================================
// ADICIONAR
// ====================================================================
function TContatosController.AdicionarContato(AContato: Contatos; out Mensagem: string): Boolean;
var
  Lista: TObjectList<Contatos>;
begin
  Mensagem := '';

  // VALIDA TELEFONE
  Lista := ContatosRepository.BuscarPorTelefone(AContato.Telefone);
  try
    if Lista.Count > 0 then
    begin
      Mensagem := 'Erro: Telefone "' + AContato.Telefone + '" já cadastrado!';
      Exit(False);
    end;
  finally
    Lista.Free;
  end;

  // VALIDA EMAIL
  if Trim(AContato.Email) <> '' then
  begin
    Lista := ContatosRepository.BuscarPorEmail(AContato.Email);
    try
      if Lista.Count > 0 then
      begin
        Mensagem := 'Erro: Email "' + AContato.Email + '" já cadastrado!';
        Exit(False);
      end;
    finally
      Lista.Free;
    end;
  end;

  // SALVA
  if ContatosRepository.Adicionar(AContato) then
  begin
    Mensagem := 'Contato adicionado com sucesso!';
    Exit(True);
  end
  else
  begin
    Mensagem := 'Erro ao salvar no banco.';
    Exit(False);
  end;
end;

// ====================================================================
// ATUALIZAR
// ====================================================================
function TContatosController.AtualizarContato(AContato: Contatos; out Mensagem: string): Boolean;
var
  Lista: TObjectList<Contatos>;
  i: Integer;
begin
  Mensagem := '';

  // VALIDA TELEFONE
  Lista := ContatosRepository.BuscarPorTelefone(AContato.Telefone);
  try
    for i := 0 to Lista.Count - 1 do
      if Lista[i].Id <> AContato.Id then
      begin
        Mensagem := 'Erro: Telefone já usado por outro contato!';
        Exit(False);
      end;
  finally
    Lista.Free;
  end;

  // VALIDA EMAIL
  if Trim(AContato.Email) <> '' then
  begin
    Lista := ContatosRepository.BuscarPorEmail(AContato.Email);
    try
      for i := 0 to Lista.Count - 1 do
        if Lista[i].Id <> AContato.Id then
        begin
          Mensagem := 'Erro: Email já usado por outro contato!';
          Exit(False);
        end;
    finally
      Lista.Free;
    end;
  end;

  // ATUALIZA
  if ContatosRepository.Atualizar(AContato) then
  begin
    Mensagem := 'Contato atualizado com sucesso!';
    Exit(True);
  end
  else
  begin
    Mensagem := 'Erro ao atualizar no banco.';
    Exit(False);
  end;
end;

function TContatosController.ExcluirContato(AId: Integer; out Mensagem: string): Boolean;
begin
  Mensagem := '';

  try
    if ContatosRepository.Excluir(AId) then
    begin
      Mensagem := 'Contato excluído com sucesso!';
      Result   := True;
    end
    else
    begin
      Mensagem := 'Contato não encontrado ou já excluído.';
      Result   := False;
    end;
  except
    on E: Exception do
    begin
      Mensagem := 'Erro ao excluir contato: ' + E.Message;
      Result   := False;
    end;
  end;
end;



// ====================================================================
// LISTAR
// ====================================================================
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
  try
    for i := 0 to ListaNova.Count - 1 do
      ALista.Add(ListaNova[i]);
  finally
    ListaNova.OwnsObjects := False;
    ListaNova.Free;
  end;
end;

// ====================================================================
// GRID: SALVAR EDIÇÃO
// ====================================================================
function TContatosController.SalvarEdicaoGrid(DataSet: TDataSet; out Mensagem: string): Boolean;
var
  ContatoTemp: Contatos;
begin
  ContatoTemp := Contatos.Create;
  try
    ContatoTemp.Id := DataSet.FieldByName('id_contato').AsInteger;
    ContatoTemp.Nome := DataSet.FieldByName('NOME').AsString;
    ContatoTemp.Telefone := DataSet.FieldByName('TELEFONE').AsString;
    ContatoTemp.Email := DataSet.FieldByName('EMAIL').AsString;
    ContatoTemp.Empresa := DataSet.FieldByName('EMPRESA').AsString;
    ContatoTemp.Endereco := DataSet.FieldByName('ENDERECO').AsString;
    ContatoTemp.CEP := DataSet.FieldByName('CEP').AsString;
    ContatoTemp.Logradouro := DataSet.FieldByName('LOGRADOURO').AsString;
    ContatoTemp.Numero := DataSet.FieldByName('NUMERO').AsString;
    ContatoTemp.Complemento := DataSet.FieldByName('COMPLEMENTO').AsString;
    ContatoTemp.Bairro := DataSet.FieldByName('BAIRRO').AsString;
    ContatoTemp.Cidade := DataSet.FieldByName('CIDADE').AsString;
    ContatoTemp.UF := DataSet.FieldByName('UF').AsString;
    ContatoTemp.Ativo := True;

    Result := AtualizarContato(ContatoTemp, Mensagem);
  finally
    ContatoTemp.Free;
  end;
end;

end.
