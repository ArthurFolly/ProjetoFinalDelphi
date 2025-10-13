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

    function ValidarDados(ANome, ATelefone, AEmail, AEndereco, AEmpresa: string): Boolean;
  public
    constructor Create;
    destructor Destroy; override;

    procedure SalvarContato(ANome, ATelefone, AEmail, AEndereco, AEmpresa, AObservacoes: string);
    procedure AtualizarContato(AId: Integer; ANome, ATelefone, AEmail, AEndereco, AEmpresa, AObservacoes: string);
    procedure ExcluirContato(AId: Integer);
    function ListarContatos: TObjectList<Contatos>;
    function BuscarPorNome(ANome: string): TObjectList<Contatos>;
    function BuscarPorTelefone(ATelefone: string): TObjectList<Contatos>;
    function BuscarPorEmpresa(AEmpresa: string): TObjectList<Contatos>;
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

function TContatosController.ValidarDados(ANome, ATelefone, AEmail, AEndereco, AEmpresa: string): Boolean;
begin
  Result := False;

  if Trim(ANome) = '' then
  begin
    ShowMessage('Nome Completo é obrigatório!');
    Exit;
  end;

  if Trim(ATelefone) = '' then
  begin
    ShowMessage('Número de Celular é obrigatório!');
    Exit;
  end;

  if Trim(AEmail) = '' then
  begin
    ShowMessage('E-mail é obrigatório!');
    Exit;
  end;

  if Trim(AEndereco) = '' then
  begin
    ShowMessage('Endereço é obrigatório!');
    Exit;
  end;

  if Trim(AEmpresa) = '' then
  begin
    ShowMessage('Empresa é obrigatória!');
    Exit;
  end;

  Result := True;
end;

procedure TContatosController.SalvarContato(ANome, ATelefone, AEmail, AEndereco, AEmpresa, AObservacoes: string);
var
  Contato: Contatos;
  Lista: TObjectList<Contatos>;
begin
  if not ValidarDados(ANome, ATelefone, AEmail, AEndereco, AEmpresa) then
    Exit;

  // Verifica se telefone já existe
  Lista := ContatosRepository.BuscarPorTelefone(ATelefone);
  if Lista.Count > 0 then
  begin
    Lista.Free;
    if MessageDlg('Já existe contato com este telefone. Continuar?',
                  mtWarning, [mbYes, mbNo], 0) = mrNo then
      Exit;
  end
  else
    Lista.Free;

  Contato := Contatos.Create;
  Contato.Nome := Trim(ANome);
  Contato.Telefone := Trim(ATelefone);
  Contato.Email := Trim(AEmail);
  Contato.Endereco := Trim(AEndereco);
  Contato.Empresa := Trim(AEmpresa);
  Contato.Observacoes := Trim(AObservacoes);
  Contato.Id_usuario := 1;
  Contato.Ativo := True;

  if ContatosRepository.Adicionar(Contato) then
    ShowMessage('Contato salvo!')
  else
    ShowMessage('Erro ao salvar.');

  Contato.Free;
end;

procedure TContatosController.AtualizarContato(AId: Integer; ANome, ATelefone, AEmail, AEndereco, AEmpresa, AObservacoes: string);
var
  Contato: Contatos;
begin
  if not ValidarDados(ANome, ATelefone, AEmail, AEndereco, AEmpresa) then
    Exit;

  Contato := Contatos.Create;
  Contato.Id := AId;
  Contato.Nome := Trim(ANome);
  Contato.Telefone := Trim(ATelefone);
  Contato.Email := Trim(AEmail);
  Contato.Endereco := Trim(AEndereco);
  Contato.Empresa := Trim(AEmpresa);
  Contato.Observacoes := Trim(AObservacoes);
  Contato.Id_usuario := 1;
  Contato.Ativo := True;

  if ContatosRepository.Atualizar(Contato) then
    ShowMessage('Contato atualizado!')
  else
    ShowMessage('Erro ao atualizar.');

  Contato.Free;
end;

procedure TContatosController.ExcluirContato(AId: Integer);
begin
  if MessageDlg('Excluir este contato?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    // ContatosRepository.Excluir(AId);
    ShowMessage('Contato excluído!');
  end;
end;

function TContatosController.ListarContatos: TObjectList<Contatos>;
begin
  Result := ContatosRepository.ListarTodos;
end;

function TContatosController.BuscarPorNome(ANome: string): TObjectList<Contatos>;
begin
  if Trim(ANome) = '' then
    Result := ContatosRepository.ListarTodos
  else
    Result := ContatosRepository.BuscarPorNome(Trim(ANome));
end;

function TContatosController.BuscarPorTelefone(ATelefone: string): TObjectList<Contatos>;
begin
  Result := ContatosRepository.BuscarPorTelefone(Trim(ATelefone));
end;

function TContatosController.BuscarPorEmpresa(AEmpresa: string): TObjectList<Contatos>;
begin
  Result := ContatosRepository.BuscarPorEmpresa(Trim(AEmpresa));
end;

end.
