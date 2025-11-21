unit GruposController;

interface

uses
  System.SysUtils, System.Generics.Collections,
  GruposModel, GruposRepository;

type
  TGruposController = class
  private
    FRepo: TGruposRepository;
    FNivelUsuarioLogado: Integer;
  public
    constructor Create(ANivelUsuarioLogado: Integer);
    destructor Destroy; override;

    property NivelUsuarioLogado: Integer read FNivelUsuarioLogado;

    function ListarGrupos: TObjectList<TGrupos>;
    function AdicionarGrupo(AGrupo: TGrupos): Boolean;
    function AtualizarGrupo(AGrupo: TGrupos): Boolean;

    // soft delete (ativo := false)
    function ExcluirGrupo(AIdGrupo: Integer): Boolean;

    // reativa (ativo := true)
    function RestaurarGrupo(AIdGrupo: Integer): Boolean;

    function BuscarGrupoPorId(AIdGrupo: Integer): TGrupos;
  end;

implementation

{ TGruposController }

constructor TGruposController.Create(ANivelUsuarioLogado: Integer);
begin
  inherited Create;
  FNivelUsuarioLogado := ANivelUsuarioLogado;
  FRepo := TGruposRepository.Create;
end;

destructor TGruposController.Destroy;
begin
  FRepo.Free;
  inherited;
end;

function TGruposController.ListarGrupos: TObjectList<TGrupos>;
begin
  Result := FRepo.ListarTodos;
end;

function TGruposController.AdicionarGrupo(AGrupo: TGrupos): Boolean;
begin
  Result := FRepo.Inserir(AGrupo);
end;

function TGruposController.AtualizarGrupo(AGrupo: TGrupos): Boolean;
begin
  Result := FRepo.Atualizar(AGrupo);
end;

function TGruposController.ExcluirGrupo(AIdGrupo: Integer): Boolean;
begin
  // Agora faz exclusão DEFINITIVA no banco
  Result := FRepo.ExcluirGrupo(AIdGrupo);
end;



function TGruposController.RestaurarGrupo(AIdGrupo: Integer): Boolean;
begin
  Result := FRepo.MarcarAtivo(AIdGrupo);
end;

function TGruposController.BuscarGrupoPorId(AIdGrupo: Integer): TGrupos;
begin
  Result := FRepo.BuscarPorId(AIdGrupo);
end;

end.

