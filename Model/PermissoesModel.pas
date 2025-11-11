unit PermissoesModel;

interface

uses
  System.SysUtils;

type
  // Constants para evitar "magic strings"
  TPermissoesConstants = class
  public const
    CREATE = 'CREATE';
    READ = 'READ';
    UPDATE = 'UPDATE';
    DELETE = 'DELETE';
    MANAGE_USERS = 'MANAGE_USERS';
    DEFINE_SUPERVISORS = 'DEFINE_SUPERVISORS';

    DESC_CREATE = 'Cadastrar registros';
    DESC_READ = 'Consultar registros';
    DESC_UPDATE = 'Alterar registros';
    DESC_DELETE = 'Excluir registros';
    DESC_MANAGE_USERS = 'Gerenciar Usuários (níveis)';
    DESC_DEFINE_SUPERVISORS = 'Definir Supervisores';
  end;

  TPermissao = class
  private
    FId: integer;
    FNome: String;
    FDescricao: String;
    FNivelRequerido: Integer;
    FAtivo: Boolean;

    procedure ValidarNome(const ANome: String);
    procedure ValidarDescricao(const ADescricao: String);
    procedure ValidarNivel(ANivel: Integer);
    procedure ValidarId(AId: Integer);

  public
    // Getters e Setters com validação
    function getId: integer;
    procedure setId(aId: integer);
    function getNome: String;
    procedure setNome(aNome: String);
    function getDescricao: String;
    procedure setDescricao(aDescricao: String);
    function getNivelRequerido: Integer;
    procedure setNivelRequerido(aNivel: Integer);
    function getAtivo: Boolean;
    procedure setAtivo(aAtivo: Boolean);

    // Métodos utilitários
    function getNivelDescricao: String;
    procedure setNivelDescricao(aNivelStr: String);

    // Métodos de validação
    function Validar: Boolean;
    function ToString: String; override;
  end;

  // Enum para facilitar o uso das operações padrão
  TOperacaoSistema = (opCreate, opRead, opUpdate, opDelete, opManageUsers, opDefineSupervisors);

implementation

{ TPermissao }

// Métodos de validação privada
procedure TPermissao.ValidarId(AId: Integer);
begin
  if AId < 0 then
    raise Exception.Create('ID da permissão não pode ser negativo');
end;

procedure TPermissao.ValidarNome(const ANome: String);
begin
  if Trim(ANome).IsEmpty then
    raise Exception.Create('Nome da permissão não pode ser vazio');

  if Length(Trim(ANome)) > 50 then
    raise Exception.Create('Nome da permissão não pode ter mais de 50 caracteres');
end;

procedure TPermissao.ValidarDescricao(const ADescricao: String);
begin
  if Trim(ADescricao).IsEmpty then
    raise Exception.Create('Descrição da permissão não pode ser vazia');

  if Length(Trim(ADescricao)) > 200 then
    raise Exception.Create('Descrição da permissão não pode ter mais de 200 caracteres');
end;

procedure TPermissao.ValidarNivel(ANivel: Integer);
begin
  if (ANivel < 1) or (ANivel > 3) then
    raise Exception.Create('Nível da permissão deve ser entre 1 e 3');
end;

// Getters e Setters com validação
function TPermissao.getId: integer;
begin
  Result := Self.FId;
end;

procedure TPermissao.setId(aId: integer);
begin
  ValidarId(aId);
  Self.FId := aId;
end;

function TPermissao.getNome: String;
begin
  Result := Self.FNome;
end;

procedure TPermissao.setNome(aNome: String);
begin
  ValidarNome(aNome);
  Self.FNome := Trim(aNome);
end;

function TPermissao.getDescricao: String;
begin
  Result := Self.FDescricao;
end;

procedure TPermissao.setDescricao(aDescricao: String);
begin
  ValidarDescricao(aDescricao);
  Self.FDescricao := Trim(aDescricao);
end;

function TPermissao.getNivelRequerido: Integer;
begin
  Result := Self.FNivelRequerido;
end;

procedure TPermissao.setNivelRequerido(aNivel: Integer);
begin
  ValidarNivel(aNivel);
  Self.FNivelRequerido := aNivel;
end;

function TPermissao.getAtivo: Boolean;
begin
  Result := Self.FAtivo;
end;

procedure TPermissao.setAtivo(aAtivo: Boolean);
begin
  Self.FAtivo := aAtivo;
end;

// Métodos utilitários
function TPermissao.getNivelDescricao: String;
begin
  case Self.FNivelRequerido of
    1: Result := 'Usuário';
    2: Result := 'Supervisor';
    3: Result := 'Administrador';
  else
    Result := 'Desconhecido';
  end;
end;

procedure TPermissao.setNivelDescricao(aNivelStr: String);
begin
  if LowerCase(aNivelStr) = 'usuário' then
    Self.FNivelRequerido := 1
  else if LowerCase(aNivelStr) = 'supervisor' then
    Self.FNivelRequerido := 2
  else if LowerCase(aNivelStr) = 'administrador' then
    Self.FNivelRequerido := 3
  else
    Self.FNivelRequerido := 1; // Padrão
end;

// Métodos de validação
function TPermissao.Validar: Boolean;
begin
  try
    ValidarNome(Self.FNome);
    ValidarDescricao(Self.FDescricao);
    ValidarNivel(Self.FNivelRequerido);
    Result := True;
  except
    Result := False;
  end;
end;

function TPermissao.ToString: String;
begin
  Result := Format('Permissão: %s (Nível %d - %s) - %s', [
    Self.FNome,
    Self.FNivelRequerido,
    Self.getNivelDescricao,
    Self.FDescricao
  ]);
end;

end.