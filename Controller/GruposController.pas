unit GruposController;

interface

uses
  System.SysUtils, System.Generics.Collections,
  GruposModel, GruposRepository,
  PermissoesController, PermissoesModel,
  Vcl.Dialogs, Vcl.Forms, Vcl.Controls, Data.DB;

type
  TGruposController = class
  private
    GruposRepository: TGruposRepository;
    PermissoesController: TPermissoesController;
    FNivelUsuarioLogado: Integer; // Nível do usuário logado
  public
    constructor Create(ANivelUsuarioLogado: Integer = 1);
    destructor Destroy; override;

    // Métodos de gerenciamento de grupos
    function AdicionarGrupo(AGrupo: TGrupos): Boolean;
    function AtualizarGrupo(AGrupo: TGrupos): Boolean;
    function ExcluirGrupo(AId: Integer): Boolean;
    function BuscarGrupoPorId(AId: Integer): TGrupos;
    procedure CarregarGrupos(ALista: TObjectList<TGrupos>);
    function ListarGrupos: TObjectList<TGrupos>;
    function BuscarGruposPorNome(ANome: string): TObjectList<TGrupos>;
    function BuscarGruposPorNivel(ANivel: Integer): TObjectList<TGrupos>;
    function RestaurarGrupo(AId: Integer): Boolean;
    // Métodos para grid
    procedure SalvarEdicaoGrid(DataSet: TDataSet);

    // Métodos utilitários
    function CriarGruposPadrao: Boolean;
    function VerificarPermissaoOperacao(AOperacao: string): Boolean;

    // Propriedades
    property NivelUsuarioLogado: Integer read FNivelUsuarioLogado write FNivelUsuarioLogado;
  end;

implementation

constructor TGruposController.Create(ANivelUsuarioLogado: Integer);
begin
  Inherited Create;
  GruposRepository := TGruposRepository.Create;
  PermissoesController := TPermissoesController.Create;
  FNivelUsuarioLogado := ANivelUsuarioLogado;
end;

destructor TGruposController.Destroy;
begin
  GruposRepository.Free;
  PermissoesController.Free;
  Inherited;
end;


function TGruposController.AdicionarGrupo(AGrupo: TGrupos): Boolean;
begin
  PermissoesController.ValidarPermissao('CREATE', FNivelUsuarioLogado);
  Result := GruposRepository.Adicionar(AGrupo);
end;

function TGruposController.AtualizarGrupo(AGrupo: TGrupos): Boolean;
begin
  PermissoesController.ValidarPermissao('UPDATE', FNivelUsuarioLogado);
  Result := GruposRepository.Atualizar(AGrupo);
end;

function TGruposController.ExcluirGrupo(AId: Integer): Boolean;
begin
  PermissoesController.ValidarPermissao('DELETE', FNivelUsuarioLogado);
  Result := GruposRepository.Excluir(AId);
end;

function TGruposController.BuscarGrupoPorId(AId: Integer): TGrupos;
begin
  PermissoesController.ValidarPermissao('READ', FNivelUsuarioLogado);
  Result := GruposRepository.BuscarPorId(AId);
end;

procedure TGruposController.CarregarGrupos(ALista: TObjectList<TGrupos>);
var
  ListaNova: TObjectList<TGrupos>;
  i: Integer;
begin
  PermissoesController.ValidarPermissao('READ', FNivelUsuarioLogado);
  ALista.Clear;
  ListaNova := ListarGrupos;

  for i := 0 to ListaNova.Count - 1 do
    ALista.Add(ListaNova[i]);

  ListaNova.OwnsObjects := False;
  ListaNova.Free;
end;

function TGruposController.ListarGrupos: TObjectList<TGrupos>;
begin
  PermissoesController.ValidarPermissao('READ', FNivelUsuarioLogado);
  Result := GruposRepository.ListarTodos;
end;

function TGruposController.BuscarGruposPorNome(ANome: string): TObjectList<TGrupos>;
begin
  PermissoesController.ValidarPermissao('READ', FNivelUsuarioLogado);
  Result := GruposRepository.BuscarPorNome(ANome);
end;

function TGruposController.BuscarGruposPorNivel(ANivel: Integer): TObjectList<TGrupos>;
begin
  PermissoesController.ValidarPermissao('READ', FNivelUsuarioLogado);
  Result := GruposRepository.BuscarPorNivel(ANivel);
end;

procedure TGruposController.SalvarEdicaoGrid(DataSet: TDataSet);
var
  nome, descricao: string;
  idPermissao: Integer;
begin
  PermissoesController.ValidarPermissao('UPDATE', FNivelUsuarioLogado);

  nome := DataSet.FieldByName('NOME').AsString;
  idPermissao := DataSet.FieldByName('ID_PERMISSAO').AsInteger;

  GruposRepository.AtualizarPorId(
    DataSet.FieldByName('ID').AsInteger,
    nome,
    descricao,
    idPermissao
  );
end;

function TGruposController.CriarGruposPadrao: Boolean;
begin
  // Apenas administradores podem criar grupos padrão
  PermissoesController.ValidarPermissao('MANAGE_USERS', FNivelUsuarioLogado);

  Result := GruposRepository.CriarGruposPadrao;
end;

function TGruposController.VerificarPermissaoOperacao(AOperacao: string): Boolean;
begin
  Result := PermissoesController.VerificarPermissao(AOperacao, FNivelUsuarioLogado);
end;

function TGruposController.RestaurarGrupo(AId: Integer): Boolean;
begin
  // REMOVA ESSA LINHA:
  // PermissoesController.ValidarPermissao('RESTORE', FNivelUsuarioLogado);

  // LIBERA PARA TODOS (OU SÓ ADMIN SE QUISER)
  if FNivelUsuarioLogado < 3 then
  begin
    ShowMessage('Apenas administradores podem restaurar grupos.');
    Result := False;
    Exit;
  end;

  Result := GruposRepository.RestaurarGrupo(AId);
end;

end.
