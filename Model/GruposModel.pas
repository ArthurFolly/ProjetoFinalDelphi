unit GruposModel;

interface

uses
  PermissoesModel, System.SysUtils;

type
  TGrupos = class
  private
    FId: integer;
    FNome: String;
    FDescricao: String;
    FIdPermissao: Integer;
    FDataCriacao: TDateTime;
    FAtivo: Boolean;

    // Métodos de validação privada
    procedure ValidarId(AId: Integer);
    procedure ValidarNome(const ANome: String);
    procedure ValidarDescricao(const ADescricao: String);
    procedure ValidarIdPermissao(AIdPermissao: Integer);
  public
    constructor Create;

    // Getters e Setters com validação
    function getId: integer;
    procedure setId(aId: integer);
    function getNome: String;
    procedure setNome(aNome: String);
    function getDescricao: String;
    procedure setDescricao(aDescricao: String);
    function getIdPermissao: Integer;
    procedure setIdPermissao(aIdPermissao: Integer);
    function getDataCriacao: TDateTime;
    procedure setDataCriacao(aDataCriacao: TDateTime);
    function getAtivo: Boolean;
    procedure setAtivo(aAtivo: Boolean);

    // Métodos para compatibilidade com código antigo
    function getNivelPermissao: Integer;
    procedure setNivelPermissao(aNivel: Integer);
    function getNivelPermissaoAsString: String;
    procedure setNivelPermissaoFromString(aNivelStr: String);

    // Métodos utilitários
    function Validar: Boolean;
    function ToString: String; override;
    function PermissaoDescricao: String;
  end;

 

implementation



{ TGrupos }

function TGrupos.getId: integer;
begin
  Result := FId;
end;

procedure TGrupos.setId(aId: integer);
begin
  ValidarId(aId);
  FId := aId;
end;

function TGrupos.getNome: String;
begin
  Result := FNome;
end;

function TGrupos.PermissaoDescricao: String;
begin
  case FIdPermissao of
    1: Result := 'Usuário';
    2: Result := 'Supervisor';
    3: Result := 'Administrador';
  else
    Result := 'Desconhecido';
  end;
end;

procedure TGrupos.setNome(aNome: String);
begin
  ValidarNome(aNome);
  FNome := Trim(aNome);
end;

function TGrupos.ToString: String;
begin
  Result := Format('Grupo: %s (ID: %d) - Permissão: %s - %s', [
    FNome,
    FId,
    PermissaoDescricao,
    FDescricao
  ]);
end;

function TGrupos.Validar: Boolean;
begin
  try
    ValidarNome(FNome);
    ValidarDescricao(FDescricao);
    ValidarIdPermissao(FIdPermissao);
    Result := True;
  except
    Result := False;
  end;
end;



procedure TGrupos.ValidarDescricao(const ADescricao: String);
begin
  if Trim(ADescricao).IsEmpty then
    raise Exception.Create('Descrição do grupo não pode ser vazia');

  if Length(Trim(ADescricao)) > 200 then
    raise Exception.Create('Descrição do grupo não pode ter mais de 200 caracteres');
end;

procedure TGrupos.ValidarId(AId: Integer);
begin
  if AId < 0 then
    raise Exception.Create('ID do grupo não pode ser negativo');
end;

procedure TGrupos.ValidarIdPermissao(AIdPermissao: Integer);
begin
  if (AIdPermissao < 1) or (AIdPermissao > 3) then
    raise Exception.Create('ID da permissão deve ser entre 1 e 3');
end;

procedure TGrupos.ValidarNome(const ANome: String);
begin
  if Trim(ANome).IsEmpty then
    raise Exception.Create('Nome do grupo não pode ser vazio');

  if Length(Trim(ANome)) > 100 then
    raise Exception.Create('Nome do grupo não pode ter mais de 100 caracteres');
end;

function TGrupos.getDescricao: String;
begin
  Result := FDescricao;
end;

procedure TGrupos.setDescricao(aDescricao: String);
begin
  ValidarDescricao(aDescricao);
  FDescricao := Trim(aDescricao);
end;

function TGrupos.getIdPermissao: Integer;
begin
  Result := FIdPermissao;
end;

procedure TGrupos.setIdPermissao(aIdPermissao: Integer);
begin
  ValidarIdPermissao(aIdPermissao);
  FIdPermissao := aIdPermissao;
end;

function TGrupos.getDataCriacao: TDateTime;
begin
  Result := FDataCriacao;
end;

procedure TGrupos.setDataCriacao(aDataCriacao: TDateTime);
begin

  FDataCriacao := aDataCriacao;
end;

constructor TGrupos.Create;
begin
  inherited Create;
  FId := 0;
  FNome := '';
  FDescricao := '';
  FIdPermissao := 1; // Padrão: Usuário
  FDataCriacao := Now;
  FAtivo := True;
end;

function TGrupos.getAtivo: Boolean;
begin
  Result := FAtivo;
end;

procedure TGrupos.setAtivo(aAtivo: Boolean);
begin
  FAtivo := aAtivo;
end;

function TGrupos.getNivelPermissao: Integer;
begin
  Result := FIdPermissao;
end;

procedure TGrupos.setNivelPermissao(aNivel: Integer);
begin
  FIdPermissao := aNivel;
end;

function TGrupos.getNivelPermissaoAsString: String;
begin
  case FIdPermissao of
    1: Result := 'Usuário';
    2: Result := 'Supervisor';
    3: Result := 'Administrador';
  else
    Result := 'Desconhecido';
  end;
end;

procedure TGrupos.setNivelPermissaoFromString(aNivelStr: String);
begin
  if LowerCase(aNivelStr) = 'usuário' then
    FIdPermissao := 1
  else if LowerCase(aNivelStr) = 'supervisor' then
    FIdPermissao := 2
  else if LowerCase(aNivelStr) = 'administrador' then
    FIdPermissao := 3
  else
    FIdPermissao := 1;
end;

end.
