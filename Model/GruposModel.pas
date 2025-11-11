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
    procedure ValidarDataCriacao(AData: TDateTime);

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
  FId := aId;
end;

function TGrupos.getNome: String;
begin
  Result := FNome;
end;

function TGrupos.PermissaoDescricao: String;
begin

end;

procedure TGrupos.setNome(aNome: String);
begin
  FNome := aNome;
end;

function TGrupos.ToString: String;
begin

end;

function TGrupos.Validar: Boolean;
begin

end;

procedure TGrupos.ValidarDataCriacao(AData: TDateTime);
begin

end;

procedure TGrupos.ValidarDescricao(const ADescricao: String);
begin

end;

procedure TGrupos.ValidarId(AId: Integer);
begin

end;

procedure TGrupos.ValidarIdPermissao(AIdPermissao: Integer);
begin

end;

procedure TGrupos.ValidarNome(const ANome: String);
begin

end;

function TGrupos.getDescricao: String;
begin
  Result := FDescricao;
end;

procedure TGrupos.setDescricao(aDescricao: String);
begin
  FDescricao := aDescricao;
end;

function TGrupos.getIdPermissao: Integer;
begin
  Result := FIdPermissao;
end;

procedure TGrupos.setIdPermissao(aIdPermissao: Integer);
begin
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
