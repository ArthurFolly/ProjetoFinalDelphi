unit PermissoesController;

interface

uses
  System.SysUtils, PermissoesRepository, PermissoesModel, System.Generics.Collections;

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

    // Buscas adicionais (agora compatíveis com o Repository real)
    function BuscarPermissaoPorNome(const ANome: string): TPermissao;  // ← retorna 1
    function BuscarPermissoesPorNomeLike(const ANome: string): TObjectList<TPermissao>; // ← busca parcial
    function BuscarPermissoesPorNivel(ANivel: Integer): TObjectList<TPermissao>;

    // Validação de permissão
    function VerificarPermissao(const AOperacao: string; ANivelUsuario: Integer): Boolean;
    procedure ValidarPermissao(const AOperacao: string; ANivelUsuario: Integer);

    // Utilitários
    procedure CriarPermissoesPadrao;
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
  inherited;
end;

function TPermissoesController.AdicionarPermissao(const ANome, ADescricao: string; ANivelRequerido: Integer): Boolean;
var
  Permissao: TPermissao;
begin
  if not ValidarDadosPermissao(ANome, ADescricao, ANivelRequerido) then
    Exit(False);

  Permissao := TPermissao.Create;
  try
    Permissao.setNome(ANome);
    Permissao.setDescricao(ADescricao);
    Permissao.setNivelRequerido(ANivelRequerido);
    Permissao.setAtivo(True);

    Result := FRepository.Adicionar(Permissao);
  finally
    Permissao.Free;
  end;
end;

function TPermissoesController.AtualizarPermissao(AId: Integer; const ANome, ADescricao: string;
     ANivelRequerido: Integer; AAtivo: Boolean): Boolean;
var
  Permissao: TPermissao;
begin
  if not ValidarDadosPermissao(ANome, ADescricao, ANivelRequerido) then
    Exit(False);

  if AId <= 0 then
    raise Exception.Create('ID da permissão inválido');

  Permissao := TPermissao.Create;
  try
    Permissao.setId(AId);
    Permissao.setNome(ANome);
    Permissao.setDescricao(ADescricao);
    Permissao.setNivelRequerido(ANivelRequerido);
    Permissao.setAtivo(AAtivo);

    Result := FRepository.Atualizar(Permissao);
  finally
    Permissao.Free;
  end;
end;

function TPermissoesController.ExcluirPermissao(AId: Integer): Boolean;
begin
  if AId <= 0 then
    raise Exception.Create('ID da permissão inválido');

  Result := FRepository.Excluir(AId);
end;

function TPermissoesController.BuscarPermissaoPorId(AId: Integer): TPermissao;
begin
  if AId <= 0 then
    raise Exception.Create('ID da permissão inválido');

  Result := FRepository.BuscarPorId(AId);
  // Result pode ser nil se não encontrar
end;

function TPermissoesController.ListarTodasPermissoes: TObjectList<TPermissao>;
begin
  Result := FRepository.ListarTodas;
end;

function TPermissoesController.BuscarPermissaoPorNome(const ANome: string): TPermissao;
begin
  if Trim(ANome).IsEmpty then
    raise Exception.Create('Nome da permissão não pode ser vazio');

  Result := FRepository.BuscarPorNome(ANome); // ← usa o método exato do Repository
end;

function TPermissoesController.BuscarPermissoesPorNomeLike(const ANome: string): TObjectList<TPermissao>;
var
  ListaTodas, Resultado: TObjectList<TPermissao>;
  Perm: TPermissao;
begin
  Resultado := TObjectList<TPermissao>.Create(False);
  if Trim(ANome).IsEmpty then
    Exit(Resultado);

  ListaTodas := FRepository.ListarTodas;
  try
    for Perm in ListaTodas do
    begin
      if Pos(UpperCase(ANome), UpperCase(Perm.getNome)) > 0 then
        Resultado.Add(Perm);
    end;
  finally
    ListaTodas.Free; // não libera os objetos internos (False no Create)
  end;

  Result := Resultado;
end;

function TPermissoesController.BuscarPermissoesPorNivel(ANivel: Integer): TObjectList<TPermissao>;
var
  ListaTodas: TObjectList<TPermissao>;
  Perm: TPermissao;
begin
  Result := TObjectList<TPermissao>.Create(False);

  if (ANivel < 1) or (ANivel > 3) then
    Exit(Result);

  ListaTodas := FRepository.ListarTodas;
  try
    for Perm in ListaTodas do
    begin
      if Perm.getNivelRequerido = ANivel then
        Result.Add(Perm);
    end;
  finally
    ListaTodas.Free;
  end;
end;

function TPermissoesController.VerificarPermissao(const AOperacao: string; ANivelUsuario: Integer): Boolean;
begin
  if Trim(AOperacao).IsEmpty then
    raise Exception.Create('Operação não informada');

  if (ANivelUsuario < 1) or (ANivelUsuario > 3) then
    raise Exception.Create('Nível do usuário inválido');

  Result := FRepository.VerificarPermissao(AOperacao, ANivelUsuario);
end;

procedure TPermissoesController.ValidarPermissao(const AOperacao: string; ANivelUsuario: Integer);
begin
  if not VerificarPermissao(AOperacao, ANivelUsuario) then
    raise Exception.CreateFmt('Acesso negado: você não tem permissão para "%s"', [AOperacao]);
end;

procedure TPermissoesController.CriarPermissoesPadrao;
begin
  FRepository.CriarPermissoesPadrao;
end;

function TPermissoesController.ValidarDadosPermissao(const ANome, ADescricao: string; ANivelRequerido: Integer): Boolean;
begin
  if Trim(ANome).IsEmpty then
    raise Exception.Create('O nome da permissão é obrigatório');

  if Length(Trim(ANome)) > 50 then
    raise Exception.Create('O nome da permissão não pode ter mais de 50 caracteres');

  if Trim(ADescricao).IsEmpty then
    raise Exception.Create('A descrição da permissão é obrigatória');

  if Length(Trim(ADescricao)) > 200 then
    raise Exception.Create('A descrição não pode ter mais de 200 caracteres');

  if (ANivelRequerido < 1) or (ANivelRequerido > 3) then
    raise Exception.Create('O nível requerido deve ser 1, 2 ou 3');

  Result := True;
end;

end.
