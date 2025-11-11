unit PermissoesController;

interface

uses System.SysUtils, PermissoesRepository, PermissoesModel, System.Generics.Collections;

type
  TPermissoesController = class
  private
    FRepository: TPermissoesRepository;
  public
    constructor Create;
    destructor Destroy; override;

    // Métodos CRUD
    function AdicionarPermissao(const ANome, ADescricao: string; ANivelRequerido: Integer): Boolean;
    function AtualizarPermissao(AId: Integer; const ANome, ADescricao: string; ANivelRequerido: Integer; AAtivo: Boolean): Boolean;
    function ExcluirPermissao(AId: Integer): Boolean;
    function BuscarPermissaoPorId(AId: Integer): TPermissao;
    function ListarTodasPermissoes: TObjectList<TPermissao>;
    function BuscarPermissoesPorNome(const ANome: string): TObjectList<TPermissao>;
    function BuscarPermissoesPorNivel(ANivel: Integer): TObjectList<TPermissao>;

    // Métodos de validação
    function VerificarPermissao(const AOperacao: string; ANivelUsuario: Integer): Boolean;
    procedure ValidarPermissao(const AOperacao: string; ANivelUsuario: Integer);
    function BuscarPermissaoPorOperacao(const AOperacao: string): TPermissao;

    // Métodos utilitários
    function CriarPermissoesPadrao: Boolean;
    function ValidarDadosPermissao(const ANome, ADescricao: string; ANivelRequerido: Integer): Boolean;
  end;

implementation

{ TPermissoesController }

constructor TPermissoesController.Create;
begin
  inherited Create;
  FRepository := TPermissoesRepository.Create;
end;

destructor TPermissoesController.Destroy;
begin
  FRepository.Free;
  inherited Destroy;
end;

function TPermissoesController.AdicionarPermissao(const ANome, ADescricao: string; ANivelRequerido: Integer): Boolean;
var
  permissao: TPermissao;
begin
  Result := False;

  if not ValidarDadosPermissao(ANome, ADescricao, ANivelRequerido) then
    raise Exception.Create('Dados da permissão inválidos');

  permissao := TPermissao.Create;
  try
    permissao.setNome(ANome);
    permissao.setDescricao(ADescricao);
    permissao.setNivelRequerido(ANivelRequerido);
    permissao.setAtivo(True);

    Result := FRepository.Adicionar(permissao);
  finally
    permissao.Free;
  end;
end;

function TPermissoesController.AtualizarPermissao(AId: Integer; const ANome, ADescricao: string; ANivelRequerido: Integer; AAtivo: Boolean): Boolean;
var
  permissao: TPermissao;
begin
  Result := False;

  if not ValidarDadosPermissao(ANome, ADescricao, ANivelRequerido) then
    raise Exception.Create('Dados da permissão inválidos');

  if AId <= 0 then
    raise Exception.Create('ID da permissão inválido');

  permissao := TPermissao.Create;
  try
    permissao.setId(AId);
    permissao.setNome(ANome);
    permissao.setDescricao(ADescricao);
    permissao.setNivelRequerido(ANivelRequerido);
    permissao.setAtivo(AAtivo);

    Result := FRepository.Atualizar(permissao);
  finally
    permissao.Free;
  end;
end;

function TPermissoesController.ExcluirPermissao(AId: Integer): Boolean;
begin
  Result := False;

  if AId <= 0 then
    raise Exception.Create('ID da permissão inválido');

  Result := FRepository.Excluir(AId);
end;

function TPermissoesController.BuscarPermissaoPorId(AId: Integer): TPermissao;
begin
  Result := nil;

  if AId <= 0 then
    raise Exception.Create('ID da permissão inválido');

  Result := FRepository.BuscarPorId(AId);
end;

function TPermissoesController.ListarTodasPermissoes: TObjectList<TPermissao>;
begin
  Result := FRepository.ListarTodas;
end;

function TPermissoesController.BuscarPermissoesPorNome(const ANome: string): TObjectList<TPermissao>;
begin
  Result := nil;

  if Trim(ANome).IsEmpty then
    raise Exception.Create('Nome para pesquisa não pode ser vazio');

  Result := FRepository.BuscarPorNome(ANome);
end;

function TPermissoesController.BuscarPermissoesPorNivel(ANivel: Integer): TObjectList<TPermissao>;
begin
  Result := nil;

  if (ANivel < 1) or (ANivel > 3) then
    raise Exception.Create('Nível deve ser entre 1 e 3');

  Result := FRepository.BuscarPorNivel(ANivel);
end;

function TPermissoesController.VerificarPermissao(const AOperacao: string; ANivelUsuario: Integer): Boolean;
begin
  Result := False;

  if Trim(AOperacao).IsEmpty then
    raise Exception.Create('Operação não pode ser vazia');

  if (ANivelUsuario < 1) or (ANivelUsuario > 3) then
    raise Exception.Create('Nível do usuário deve ser entre 1 e 3');

  Result := FRepository.VerificarPermissao(AOperacao, ANivelUsuario);
end;

procedure TPermissoesController.ValidarPermissao(const AOperacao: string; ANivelUsuario: Integer);
begin
  if not VerificarPermissao(AOperacao, ANivelUsuario) then
    raise Exception.CreateFmt('Sem permissão para a operação: %s', [AOperacao]);
end;

function TPermissoesController.BuscarPermissaoPorOperacao(const AOperacao: string): TPermissao;
begin
  Result := nil;

  if Trim(AOperacao).IsEmpty then
    raise Exception.Create('Operação não pode ser vazia');

  Result := FRepository.BuscarPermissaoPorOperacao(AOperacao);
end;

function TPermissoesController.CriarPermissoesPadrao: Boolean;
begin
  Result := FRepository.CriarPermissoesPadrao;
end;

function TPermissoesController.ValidarDadosPermissao(const ANome, ADescricao: string; ANivelRequerido: Integer): Boolean;
begin
  Result := False;

  // Validação do nome
  if Trim(ANome).IsEmpty then
    raise Exception.Create('Nome da permissão não pode ser vazio');

  if Length(Trim(ANome)) > 50 then
    raise Exception.Create('Nome da permissão não pode ter mais de 50 caracteres');

  // Validação da descrição
  if Trim(ADescricao).IsEmpty then
    raise Exception.Create('Descrição da permissão não pode ser vazia');

  if Length(Trim(ADescricao)) > 200 then
    raise Exception.Create('Descrição da permissão não pode ter mais de 200 caracteres');

  // Validação do nível requerido
  if (ANivelRequerido < 1) or (ANivelRequerido > 3) then
    raise Exception.Create('Nível requerido deve ser entre 1 e 3');

  Result := True;
end;

end.