unit uMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Imaging.jpeg,
  Vcl.Imaging.pngimage, Vcl.StdCtrls, Vcl.ComCtrls, Vcl.WinXPanels, Vcl.Mask,
  Vcl.Buttons, Vcl.Grids, Data.DB, Vcl.DBGrids, ContatosController, TContatosModel,
  ContatosRepository, System.Generics.Collections, Data.FMTBcd, Data.SqlExpr, Datasnap.DBClient,
  FireDAC.Phys.PGDef, FireDAC.Phys.PG, FireDAC.Comp.Client,ConexaoBanco,FavoritosModel,FavoritosController,FavoritosRepository,
  EmpresaModel, EmpresaController,GruposModel,GruposRepository,GruposController;

type
  TFMain = class(TForm)
    Fundo: TImage;
    Panel1: TPanel;
    Logo: TImage;
    PanelContatos: TPanel;
    ImageContato: TImage;
    PanelConfiguracao: TPanel;
    PanelImportExport: TPanel;
    PanelEmpresa: TPanel;
    PanelFavoritos: TPanel;
    PanelGrupos: TPanel;
    ContactHub: TPanel;
    ImageFavoritos: TImage;
    ImageEmpresa: TImage;
    ImageImpExp: TImage;
    ImageConfig: TImage;
    ImageGrupos: TImage;
    PanelForm: TPanel;
    CardPanel1: TCardPanel;
    Card1: TCard;
    Card2: TCard;
    Card3: TCard;
    Card5: TCard;
    Card4: TCard;
    Card6: TCard;
    PageControl: TPageControl;
    Principal: TTabSheet;
    Cadastro: TTabSheet;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Label1: TLabel;
    Bevel1: TBevel;
    Bevel2: TBevel;
    Edit1: TEdit;
    Nome: TLinkLabel;
    Edit2: TEdit;
    Label2: TLabel;
    Numero: TMaskEdit;
    Label3: TLabel;
    Endereco: TEdit;
    Label4: TLabel;
    Empresa: TLabel;
    Edit3: TEdit;
    Edit4: TEdit;
    SpdAdicionar: TSpeedButton;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    Panel5: TPanel;
    Panel6: TPanel;
    Label5: TLabel;
    Bevel3: TBevel;
    Panel7: TPanel;
    SpdEditarContatosGrid: TSpeedButton;
    SpdExcluir: TSpeedButton;
    SpdListar: TSpeedButton;
    DataSource1: TDataSource;
    ClientDataSet1: TClientDataSet;
    SQLConnection1: TSQLConnection;
    SQLQuery1: TSQLQuery;
    DBGrid2: TDBGrid;
    SpdAdicionarFavorito: TSpeedButton;
    SpdRemoverFavorito: TSpeedButton;
    DBGridFavoritos: TDBGrid;
    ComboBoxContatos: TComboBox;
    PageControl2: TPageControl;
    TabSheet2: TTabSheet;
    Panel8: TPanel;
    Panel9: TPanel;
    Label6: TLabel;
    CodigoEmpresa: TEdit;
    Label7: TLabel;
    NomeDaEmpresa: TEdit;
    Label8: TLabel;
    MaskEdit1: TMaskEdit;
    Label9: TLabel;
    Edit5: TEdit;
    Label10: TLabel;
    MaskEdit2: TMaskEdit;
    Label11: TLabel;
    Edit6: TEdit;
    Label12: TLabel;
    Bevel4: TBevel;
    Bevel5: TBevel;
    Bevel6: TBevel;
    TabSheet3: TTabSheet;
    Panel10: TPanel;
    Label13: TLabel;
    Label14: TLabel;
    DBGrid1: TDBGrid;
    SpdEditarEmpresa: TSpeedButton;
    SpdRestaurarEmpresa: TSpeedButton;
    SpdExcluirEmpresa: TSpeedButton;
    SpdAdicionarEmpresa: TSpeedButton;
    PageControl3: TPageControl;
    TabSheet4: TTabSheet;
    PageControl4: TPageControl;
    TabSheet6: TTabSheet;
    Panel13: TPanel;
    Panel14: TPanel;
    Label15: TLabel;
    DBGridGrupos: TDBGrid;
    Edit7: TEdit;
    Edit8: TEdit;
    Label16: TLabel;
    Label17: TLabel;
    SpdAdicionarGrupo: TSpeedButton;
    SpdExcluirGrupo: TSpeedButton;
    SpdEditarGrupo: TSpeedButton;
    SpdListarGrupo: TSpeedButton;
    Bevel9: TBevel;
    Bevel7: TBevel;
    Label18: TLabel;
    DBGrid3: TDBGrid;
    ComboBox1: TComboBox;
    Label19: TLabel;
    Bevel8: TBevel;
    Bevel10: TBevel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    Edit9: TEdit;
    Label20: TLabel;

    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure LogoClick(Sender: TObject);
    procedure PanelContatosClick(Sender: TObject);
    procedure PanelFavoritosClick(Sender: TObject);
    procedure PanelEmpresaClick(Sender: TObject);
    procedure PanelImportExportClick(Sender: TObject);
    procedure PanelConfiguraçaoClick(Sender: TObject);
    procedure PanelConfigClick(Sender: TObject);
    procedure PanelConfiguracaoClick(Sender: TObject);
    procedure PanelContatosMouseEnter(Sender: TObject);
    procedure PanelContatosMouseLeave(Sender: TObject);
    procedure PanelFavoritosMouseEnter(Sender: TObject);
    procedure PanelFavoritosMouseLeave(Sender: TObject);
    procedure PanelEmpresaMouseEnter(Sender: TObject);
    procedure PanelEmpresaMouseLeave(Sender: TObject);
    procedure PanelImportExportMouseEnter(Sender: TObject);
    procedure PanelImportExportMouseLeave(Sender: TObject);
    procedure PanelConfiguracaoMouseEnter(Sender: TObject);
    procedure PanelConfiguracaoMouseLeave(Sender: TObject);
//    procedure PanelConfigMouseEnter(Sender: TObject);
//    procedure PanelConfigMouseLeave(Sender: TObject);
    procedure SpdAdicionarClick(Sender: TObject);
    procedure SpdRemoverClick(Sender: TObject);
    procedure SpdEditarClick(Sender: TObject);
    procedure SpdEditarContatosGridClick(Sender: TObject);
    procedure SpdListarClick(Sender: TObject);
    procedure DBGrid2DblClick(Sender: TObject);
    procedure SpdExcluirClick(Sender: TObject);
    procedure SpdAdicionarFavoritoClick(Sender: TObject);
    procedure SpdRemoverFavoritoClick(Sender: TObject);
    procedure SpdAdicionarEmpresaClick(Sender: TObject);
    procedure SpdEditarEmpresaClick(Sender: TObject);
    procedure SpdExcluirEmpresaClick(Sender: TObject);
    procedure SpdRestaurarEmpresaClick(Sender: TObject);
    procedure SpdListarEmpresaClick(Sender: TObject);
    procedure PanelGruposClick(Sender: TObject);
    procedure PanelGruposMouseLeave(Sender: TObject);
    procedure PanelGruposMouseEnter(Sender: TObject);
    procedure SpdAdicionarGrupoClick(Sender: TObject);

private
  Editando: Boolean;
  ContatoAtual: Contatos;
  ContatosLista: TObjectList<Contatos>;
  ContatosController: TContatosController;
  FavoritosController: TFavoritosController;
  ClientDataSetFavoritos: TClientDataSet;
  DataSourceFavoritos: TDataSource;
  LoadingDataset: Boolean;




  // === EMPRESAS ===
  EditandoEmpresa: Boolean;
  EmpresaAtual: TEmpresa;
  EmpresasController: TEmpresaController;
  ClientDataSetEmpresas: TClientDataSet;
  DataSourceEmpresas: TDataSource;
  LoadingDatasetEmpresas: Boolean;

// === GRUPOS - VARIÁVEIS ===
  ClientDataSetGrupos: TClientDataSet;
  DataSourceGrupos: TDataSource;
  LoadingGrupos: Boolean;
  EditandoGrupo: Boolean;
  GrupoAtualId: Integer;
  GruposController: TGruposController;


  // === GRUPOS - MÉTODOS ===
  procedure ConfigurarDBGridGrupos;
  procedure CarregarGrupos;
  procedure SalvarEdicaoGrupo(DataSet: TDataSet);
  procedure ExcluirGrupo(DataSet: TDataSet);
  procedure LimparFormularioGrupo;
  function ValidarFormularioGrupo: Boolean;
  function ValidarPermissaoGrupo(Operacao: string): Boolean;


  // === CONTATOS ===
  procedure AtivarPainel(Panel: TPanel);
  procedure ResetarPainelAnterior;
  procedure AtualizarDBGrid;
  procedure LimparFormulario;
  function ValidarFormulario: Boolean;
  function ContatoSelecionado: Contatos;
  procedure PreencherFormulario(Contato: Contatos);
  procedure ConfigurarDBGrid;
  procedure CarregarContatosDB;
  procedure SalvarEdicaoGridView(DataSet: TDataSet);
  procedure ConfirmarExclusaoGrid(DataSet: TDataSet);
  procedure ConfigurarDBGridFavoritos;
  procedure CarregarFavoritos;
  procedure SalvarEdicaoFavorito(DataSet: TDataSet);
  procedure ConfirmarExclusaoFavorito(DataSet: TDataSet);
  procedure CarregarContatosNoComboBox;

  // === EMPRESAS ===
  procedure ConfigurarDBGridEmpresas;
  procedure CarregarEmpresas;
  procedure AtualizarDBGridEmpresas;
  procedure SalvarEdicaoEmpresaGrid(DataSet: TDataSet);
  procedure ConfirmarExclusaoEmpresaGrid(DataSet: TDataSet);
  procedure LimparFormularioEmpresa;
  function ValidarFormularioEmpresa: Boolean;
  function EmpresaSelecionada: TEmpresa;
  procedure PreencherFormularioEmpresa(TEmpresa: TEmpresa);
  procedure DBGrid1DblClick(Sender: TObject);


  end;
var
FMain: TFMain;
implementation

{$R *.dfm}

var
  PainelPressionado: TPanel;

procedure TFMain.FormCreate(Sender: TObject);
begin
  DataModule1.FDConnection1.Connected := True;



  ContatosLista := TObjectList<Contatos>.Create(True);
  ContatosController := TContatosController.Create;
  ConfigurarDBGrid;
  CarregarContatosDB;


  FavoritosController := TFavoritosController.Create(1);
  ClientDataSetFavoritos := TClientDataSet.Create(Self);
  DataSourceFavoritos := TDataSource.Create(Self);
  DBGridFavoritos.DataSource := DataSourceFavoritos;
  ConfigurarDBGridFavoritos;
  CarregarFavoritos;


  EmpresasController := TEmpresaController.Create;
  ClientDataSetEmpresas := TClientDataSet.Create(Self);
  DataSourceEmpresas := TDataSource.Create(Self);
  DBGrid1.DataSource := DataSourceEmpresas;
  ConfigurarDBGridEmpresas;




  GruposController := TGruposController.Create(3); // 3 = Admin

  ClientDataSetGrupos := TClientDataSet.Create(Self);
  DataSourceGrupos := TDataSource.Create(Self);
  DataSourceGrupos.DataSet := ClientDataSetGrupos;
  DBGridGrupos.DataSource := DataSourceGrupos;

  LoadingGrupos := False;
  EditandoGrupo := False;
  GrupoAtualId := 0;

  ConfigurarDBGridGrupos;
  CarregarGrupos;


  Editando := False;
  ContatoAtual := nil;
  EditandoEmpresa := False;
  EmpresaAtual := nil;


  Card5.Visible := False;
  PageControl2.Visible := False;
end;

procedure TFMain.FormDestroy(Sender: TObject);
begin
  ContatosLista.Free;
  ContatosController.Free;

  FreeAndNil(EmpresaAtual);

  FavoritosController.Free;
  ClientDataSetFavoritos.Free;
  DataSourceFavoritos.Free;

  EmpresasController.Free;
  ClientDataSetEmpresas.Free;
  DataSourceEmpresas.Free;


  GruposController.Free;
  ClientDataSetGrupos.Free;
  DataSourceGrupos.Free;


end;

procedure TFMain.ConfigurarDBGrid;
var
  I: Integer;
begin
  DataSource1.DataSet := ClientDataSet1;
  DBGrid2.DataSource := DataSource1;

  ClientDataSet1.Close;
  ClientDataSet1.FieldDefs.Clear;

  ClientDataSet1.FieldDefs.Add('ID', ftInteger);
  ClientDataSet1.FieldDefs.Add('NOME', ftString, 100);
  ClientDataSet1.FieldDefs.Add('TELEFONE', ftString, 20);
  ClientDataSet1.FieldDefs.Add('EMAIL', ftString, 100);
  ClientDataSet1.FieldDefs.Add('EMPRESA', ftString, 100);
  ClientDataSet1.FieldDefs.Add('ENDERECO', ftString, 200);

  ClientDataSet1.CreateDataSet;
  ClientDataSet1.Open;


  DBGrid2.Columns.Clear;

  // ID
  with DBGrid2.Columns.Add do
  begin
    FieldName := 'ID';
    Title.Caption := 'ID';
    Width := 40;
  end;

  // NOME
  with DBGrid2.Columns.Add do
  begin
    FieldName := 'NOME';
    Title.Caption := 'NOME';
    Width := 150;
  end;

  // TELEFONE
  with DBGrid2.Columns.Add do
  begin
    FieldName := 'TELEFONE';
    Title.Caption := 'TELEFONE';
    Width := 120;
  end;

  // EMAIL
  with DBGrid2.Columns.Add do
  begin
    FieldName := 'EMAIL';
    Title.Caption := 'EMAIL';
    Width := 150;
  end;

  // EMPRESA
  with DBGrid2.Columns.Add do
  begin
    FieldName := 'EMPRESA';
    Title.Caption := 'EMPRESA';
    Width := 120;
  end;

  // ENDEREÇO
  with DBGrid2.Columns.Add do
  begin
    FieldName := 'ENDERECO';
    Title.Caption := 'ENDEREÇO';
    Width := 200;
  end;


  DBGrid2.ReadOnly := False;
  DBGrid2.Options := [dgEditing, dgColumnResize];
  ClientDataSet1.AfterPost := SalvarEdicaoGridView;
  ClientDataSet1.AfterDelete := ConfirmarExclusaoGrid;
  DBGrid2.Visible := True;
  DBGrid2.Refresh;
  DBGrid2.Options := [dgTitles, dgEditing, dgColumnResize];

end;

procedure TFMain.ConfigurarDBGridEmpresas;
begin
  // === DATASET ===
  DataSourceEmpresas.DataSet := ClientDataSetEmpresas;
  DBGrid1.DataSource := DataSourceEmpresas;

  ClientDataSetEmpresas.Close;
//  ClientDataSetEmpresas.Open;
  ClientDataSetEmpresas.FieldDefs.Clear;

  ClientDataSetEmpresas.FieldDefs.Add('ID', ftInteger);
  ClientDataSetEmpresas.FieldDefs.Add('CNPJ', ftString, 18);
  ClientDataSetEmpresas.FieldDefs.Add('NOME', ftString, 100);
  ClientDataSetEmpresas.FieldDefs.Add('TELEFONE', ftString, 20);
  ClientDataSetEmpresas.FieldDefs.Add('EMAIL', ftString, 100);
  ClientDataSetEmpresas.FieldDefs.Add('ENDERECO', ftString, 200);
  ClientDataSetEmpresas.FieldDefs.Add('UF', ftString, 2);

  ClientDataSetEmpresas.CreateDataSet;
  ClientDataSetEmpresas.Open;

  // === COLUNAS ===
  DBGrid1.Columns.Clear;

  with DBGrid1.Columns.Add do
  begin
    FieldName := 'ID';
    Title.Caption := 'ID';
    Width := 50;
  end;

  with DBGrid1.Columns.Add do
  begin
    FieldName := 'CNPJ';
    Title.Caption := 'CNPJ';
    Width := 130;
  end;

  with DBGrid1.Columns.Add do
  begin
    FieldName := 'NOME';
    Title.Caption := 'NOME';
    Width := 180;
  end;

  with DBGrid1.Columns.Add do
  begin
    FieldName := 'TELEFONE';
    Title.Caption := 'TELEFONE';
    Width := 110;
  end;

  with DBGrid1.Columns.Add do
  begin
    FieldName := 'EMAIL';
    Title.Caption := 'EMAIL';
    Width := 150;
  end;

  with DBGrid1.Columns.Add do
  begin
    FieldName := 'ENDERECO';
    Title.Caption := 'ENDEREÇO';
    Width := 200;
  end;

  with DBGrid1.Columns.Add do
  begin
    FieldName := 'UF';
    Title.Caption := 'UF';
    Width := 50;
  end;

  DBGrid1.ReadOnly := False;
  DBGrid1.Options := [dgEditing, dgColumnResize, dgTitles, dgIndicator, dgColLines, dgRowLines, dgTabs, dgRowSelect];

  // ✅ MANTENHA APENAS ESTA LINHA:
  ClientDataSetEmpresas.AfterPost := SalvarEdicaoEmpresaGrid;

  // ❌ REMOVA ESTA LINHA (se existir):
  // ClientDataSetEmpresas.BeforeDelete := ConfirmarExclusaoEmpresaGrid;

  DBGrid1.Options := DBGrid1.Options + [dgEditing, dgAlwaysShowEditor];
  DBGrid1.Visible := True;
end;


procedure TFMain.ConfigurarDBGridFavoritos;
begin
  DataSourceFavoritos.DataSet := ClientDataSetFavoritos;
  DBGridFavoritos.DataSource := DataSourceFavoritos;
  ClientDataSetFavoritos.Close;
  ClientDataSetFavoritos.FieldDefs.Clear;

  // CAMPOS OBRIGATÓRIOS
  ClientDataSetFavoritos.FieldDefs.Add('ID_FAVORITO', ftInteger);
  ClientDataSetFavoritos.FieldDefs.Add('ID', ftInteger);           // ESSA LINHA!
  ClientDataSetFavoritos.FieldDefs.Add('NOME', ftString, 100);
  ClientDataSetFavoritos.FieldDefs.Add('TELEFONE', ftString, 20);
  ClientDataSetFavoritos.FieldDefs.Add('EMAIL', ftString, 100);
  ClientDataSetFavoritos.FieldDefs.Add('EMPRESA', ftString, 100);
  ClientDataSetFavoritos.FieldDefs.Add('ENDERECO', ftString, 200);

  ClientDataSetFavoritos.CreateDataSet;
  ClientDataSetFavoritos.Open;

  DBGridFavoritos.Columns.Clear;

  with DBGridFavoritos.Columns.Add do
  begin
    FieldName := 'ID_FAVORITO';
    Title.Caption := 'ID Fav';
    Width := 60;
  end;

  with DBGridFavoritos.Columns.Add do
  begin
    FieldName := 'ID';
    Title.Caption := 'ID Contato';
    Width := 70;
    Visible := False; // opcional
  end;

  with DBGridFavoritos.Columns.Add do
  begin
    FieldName := 'NOME';
    Title.Caption := 'Nome';
    Width := 180;
  end;

  with DBGridFavoritos.Columns.Add do
  begin
    FieldName := 'TELEFONE';
    Title.Caption := 'Telefone';
    Width := 120;
  end;

  with DBGridFavoritos.Columns.Add do
  begin
    FieldName := 'EMPRESA';
    Title.Caption := 'Empresa';
    Width := 150;
  end;

  DBGridFavoritos.Options := [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect];
  DBGridFavoritos.ReadOnly := True; // favoritos não editáveis
end;

procedure TFMain.ConfigurarDBGridGrupos;
begin
  // === DATASET ===
  DataSourceGrupos.DataSet := ClientDataSetGrupos;
  DBGridGrupos.DataSource := DataSourceGrupos;

  ClientDataSetGrupos.Close;
  ClientDataSetGrupos.FieldDefs.Clear;
  ClientDataSetGrupos.FieldDefs.Add('ID', ftInteger);
  ClientDataSetGrupos.FieldDefs.Add('NOME', ftString, 100);
  ClientDataSetGrupos.FieldDefs.Add('DESCRICAO', ftString, 300);
  ClientDataSetGrupos.CreateDataSet;
  ClientDataSetGrupos.Open;

  // === COLUNAS ===
  DBGridGrupos.Columns.Clear;

  with DBGridGrupos.Columns.Add do
  begin
    FieldName := 'ID';
    Title.Caption := 'CÓDIGO';
    Width := 80;
    Title.Font.Style := [fsBold];
  end;

  with DBGridGrupos.Columns.Add do
  begin
    FieldName := 'NOME';
    Title.Caption := 'NOME DO GRUPO';
    Width := 320;
    Title.Font.Style := [fsBold];
  end;

  with DBGridGrupos.Columns.Add do
  begin
    FieldName := 'DESCRICAO';
    Title.Caption := 'DESCRIÇÃO';
    Width := 500;
    Title.Font.Style := [fsBold];
  end;

  // === ESTILO PADRÃO DO SISTEMA ===
  DBGridGrupos.Options := [
    dgEditing, dgTitles, dgIndicator, dgColumnResize,
    dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowEditor
  ];

  DBGridGrupos.TitleFont.Name := 'Segoe UI';
  DBGridGrupos.TitleFont.Size := 10;
  DBGridGrupos.TitleFont.Style := [fsBold];
  DBGridGrupos.Font.Size := 10;

  // === EVENTOS ===
  ClientDataSetGrupos.AfterPost := SalvarEdicaoGrupo;
  ClientDataSetGrupos.AfterDelete := ExcluirGrupo;

  DBGridGrupos.Refresh;
end;
procedure TFMain.ConfirmarExclusaoEmpresaGrid(DataSet: TDataSet);
var
  IdEmpresa: Integer;
  Msg: string;
begin
  if ClientDataSetEmpresas.IsEmpty then Exit;
  IdEmpresa := ClientDataSetEmpresas.FieldByName('ID').AsInteger;

  if MessageDlg('Deseja realmente excluir esta empresa?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    if not EmpresasController.Remover(IdEmpresa, Msg) then
    begin
      ShowMessage('Erro: ' + Msg);
      DataSet.Cancel;
    end
    else
      CarregarEmpresas;  // RECARREGA O GRID
  end
  else
    DataSet.Cancel;
end;

procedure TFMain.ConfirmarExclusaoFavorito(DataSet: TDataSet);
begin

end;

procedure TFMain.ConfirmarExclusaoGrid(DataSet: TDataSet);
var
  Contato: Contatos;
begin
  Contato := ContatoSelecionado;
  if Contato <> nil then
  begin
    if MessageDlg('Deseja realmente excluir este contato?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    begin
      Contato.Ativo := False; // exclusão lógica
      if ContatosController.AtualizarContato(Contato) then
      begin
        ShowMessage('Contato excluído com sucesso!');
        CarregarContatosDB; // atualiza o grid
      end
      else
        ShowMessage('Erro ao excluir o contato!');
    end
    else
      DataSet.Cancel; // desfaz a exclusão do ClientDataSet
  end;
end;


procedure TFMain.CarregarContatosDB;
begin

  ContatosController.CarregarContatos(ContatosLista);
  AtualizarDBGrid;
end;

procedure TFMain.CarregarContatosNoComboBox;
var
  Lista: TObjectList<Contatos>;
  Contato: Contatos;
begin
  ComboBoxContatos.Clear;

  Lista := ContatosController.ListarContatos;
  try
    for Contato in Lista do
    begin
      // PULA SE JÁ É FAVORITO
      if ClientDataSetFavoritos.Locate('ID', Contato.Id, []) then
        Continue;

      ComboBoxContatos.Items.AddObject(
        Format('%s - %s (%s)', [Contato.Nome, Contato.Telefone, Contato.Empresa]),
        TObject(Contato.Id)
      );
    end;
  finally
    Lista.Free;
  end;
end;

procedure TFMain.CarregarEmpresas;
begin
  if LoadingDatasetEmpresas then Exit;
  LoadingDatasetEmpresas := True;
  try
    ClientDataSetEmpresas.DisableControls;
    try
      // NÃO FECHE! SÓ LIMPE SE ESTIVER ABERTO
      if ClientDataSetEmpresas.Active then
        ClientDataSetEmpresas.EmptyDataSet
      else
        ClientDataSetEmpresas.Open;  // Já foi aberto em ConfigurarDBGridEmpresas

      // CARREGA DADOS
      EmpresasController.CarregarEmpresas(ClientDataSetEmpresas);

    finally
      ClientDataSetEmpresas.EnableControls;
    end;
  finally
    LoadingDatasetEmpresas := False;
  end;
end;
procedure TFMain.CarregarFavoritos;
begin
  // DEIXA O CONTROLLER FAZER TUDO
  FavoritosController.CarregarFavoritos(ClientDataSetFavoritos);
  DBGridFavoritos.Refresh;  // só atualiza o visual
end;

procedure TFMain.CarregarGrupos;
var
  Lista: TObjectList<TGrupos>;
  Grupo: TGrupos;
begin
  if LoadingGrupos then Exit;
  LoadingGrupos := True;
  ClientDataSetGrupos.DisableControls;
  try
    ClientDataSetGrupos.Close;
    ClientDataSetGrupos.FieldDefs.Clear;
    ClientDataSetGrupos.FieldDefs.Add('ID', ftInteger);
    ClientDataSetGrupos.FieldDefs.Add('NOME', ftString, 100);
    ClientDataSetGrupos.FieldDefs.Add('DESCRICAO', ftString, 300);
    ClientDataSetGrupos.FieldDefs.Add('ID_PERMISSAO', ftInteger);
    ClientDataSetGrupos.CreateDataSet;
    ClientDataSetGrupos.Open;
    ClientDataSetGrupos.EmptyDataSet;

    // USA O MÉTODO QUE JÁ EXISTE NO SEU CONTROLLER: ListarGrupos!
    Lista := GruposController.ListarGrupos;
    try
      for Grupo in Lista do
      begin
        ClientDataSetGrupos.Append;
        ClientDataSetGrupos.FieldByName('ID').AsInteger := Grupo.getId;
        ClientDataSetGrupos.FieldByName('NOME').AsString := Grupo.getNome;
        ClientDataSetGrupos.FieldByName('DESCRICAO').AsString := Grupo.getDescricao;
        ClientDataSetGrupos.FieldByName('ID_PERMISSAO').AsInteger := Grupo.getIdPermissao;
        ClientDataSetGrupos.Post;
      end;
    finally
      Lista.Free; // libera a lista
    end;

  finally
    ClientDataSetGrupos.EnableControls;
    LoadingGrupos := False;
  end;
  DBGridGrupos.Refresh;
end;

procedure TFMain.AtualizarDBGrid;
var
  I: Integer;
  Contato: Contatos;
begin
  LoadingDataset := True;
  ClientDataSet1.DisableControls;
  try
    ClientDataSet1.EmptyDataSet;
    for I := 0 to ContatosLista.Count - 1 do
    begin
      Contato := ContatosLista[I];
      ClientDataSet1.Append;
      ClientDataSet1.FieldByName('ID').AsInteger := Contato.Id;
      ClientDataSet1.FieldByName('NOME').AsString := Contato.Nome;
      ClientDataSet1.FieldByName('TELEFONE').AsString := Contato.Telefone;
      ClientDataSet1.FieldByName('EMAIL').AsString := Contato.Email;
      ClientDataSet1.FieldByName('EMPRESA').AsString := Contato.Empresa;
      ClientDataSet1.FieldByName('ENDERECO').AsString := Contato.Endereco;
      ClientDataSet1.Post;
    end;

    if not ClientDataSet1.IsEmpty then
      ClientDataSet1.First;
  finally
    ClientDataSet1.EnableControls;
    LoadingDataset := False; // <- E AQUI
  end;

  DBGrid2.Refresh;
end;


procedure TFMain.AtualizarDBGridEmpresas;
begin
  LoadingDatasetEmpresas := True;
  ClientDataSetEmpresas.DisableControls;
  try
    ClientDataSetEmpresas.EmptyDataSet;
    EmpresasController.CarregarEmpresas(ClientDataSetEmpresas);
  finally
    ClientDataSetEmpresas.EnableControls;
    LoadingDatasetEmpresas := False;
  end;
  DBGrid1.Refresh;
end;

procedure TFMain.SalvarEdicaoEmpresaGrid(DataSet: TDataSet);
var
  Empresa: TEmpresa;
  Mensagem: string;
begin
  if LoadingDatasetEmpresas then Exit;
  Empresa := EmpresaSelecionada;
  if Empresa = nil then Exit;

  try
    Empresa.setCNPJ(DataSet.FieldByName('CNPJ').AsString);
    Empresa.setNome(DataSet.FieldByName('NOME').AsString);
    Empresa.setTelefone(DataSet.FieldByName('TELEFONE').AsString);
    Empresa.setEmail(DataSet.FieldByName('EMAIL').AsString);
    Empresa.setEndereco(DataSet.FieldByName('ENDERECO').AsString);
    Empresa.setUF(DataSet.FieldByName('UF').AsString);

    if not EmpresasController.Atualizar(Empresa, Mensagem) then
    begin
      Application.MessageBox(PChar('Erro: ' + Mensagem), 'Erro', MB_OK + MB_ICONERROR);
      DataSet.Cancel;
    end;
    // SEM NENHUMA MENSAGEM DE SUCESSO → EVITA LOOP
  except
    on E: Exception do
    begin
      Application.MessageBox(PChar('Erro ao salvar: ' + E.Message), 'Erro', MB_OK + MB_ICONERROR);
      DataSet.Cancel;
    end;
  end;
end;

procedure TFMain.SalvarEdicaoFavorito(DataSet: TDataSet);
begin

end;

procedure TFMain.SalvarEdicaoGridView(DataSet: TDataSet);
var
  Contato: Contatos;
begin
  if LoadingDataset then Exit; // <- ADICIONE ESTA LINHA

  try
    Contato := ContatoSelecionado;
    if Contato <> nil then
    begin
      Contato.Nome := DataSet.FieldByName('NOME').AsString;
      Contato.Telefone := DataSet.FieldByName('TELEFONE').AsString;
      Contato.Email := DataSet.FieldByName('EMAIL').AsString;
      Contato.Empresa := DataSet.FieldByName('EMPRESA').AsString;
      Contato.Endereco := DataSet.FieldByName('ENDERECO').AsString;

      if ContatosController.AtualizarContato(Contato) then
        ShowMessage('Contato atualizado com sucesso!')
      else
        ShowMessage('Erro ao atualizar o contato no banco!');
    end;
  except
    on E: Exception do
      ShowMessage('Erro ao salvar: ' + E.Message);
  end;
end;


procedure TFMain.SalvarEdicaoGrupo(DataSet: TDataSet);
begin

end;

procedure TFMain.SpdAdicionarClick(Sender: TObject);
var
  NovoContato: Contatos;
begin
  if not ValidarFormulario then Exit;

  NovoContato := Contatos.Create;
  try
    NovoContato.Nome := Edit1.Text;
    NovoContato.Telefone := Numero.Text;
    NovoContato.Email := Edit2.Text;
    NovoContato.Empresa := Edit3.Text;
    NovoContato.Endereco := Endereco.Text;
    NovoContato.Observacoes := Edit4.Text;
    NovoContato.Favorito := False;
    NovoContato.Ativo := True;

    if ContatosController.AdicionarContato(NovoContato) then
    begin
      ContatosLista.Add(NovoContato);
      AtualizarDBGrid;
      LimparFormulario;
      ShowMessage('Contato adicionado!');
    end
    else
    begin
      NovoContato.Free;
      ShowMessage('Erro ao adicionar contato!');
    end;
  except
    on E: Exception do
    begin
      NovoContato.Free;
      ShowMessage('Erro: ' + E.Message);
    end;
  end;
end;

procedure TFMain.SpdAdicionarEmpresaClick(Sender: TObject);
var
  NovaEmpresa: TEmpresa;
  Mensagem: string;
begin


  if not ValidarFormularioEmpresa then
    Exit;

  NovaEmpresa := TEmpresa.Create;
  try
    NovaEmpresa.setCNPJ(CodigoEmpresa.Text);
    NovaEmpresa.setNome(NomeDaEmpresa.Text);
    NovaEmpresa.setTelefone(MaskEdit1.Text);
    NovaEmpresa.setEmail(Edit5.Text);
    NovaEmpresa.setEndereco(Edit6.Text);
    NovaEmpresa.setUF(MaskEdit2.Text);

    if EmpresasController.Adicionar(NovaEmpresa, Mensagem) then
    begin
      ShowMessage(Mensagem);
      LimparFormularioEmpresa;
      CarregarEmpresas;
    end
    else
      ShowMessage(Mensagem);
  finally
    NovaEmpresa.Free;
  end;
end;

procedure TFMain.SpdAdicionarFavoritoClick(Sender: TObject);
var
  IdContato: Integer;
  Msg: string;
begin
  if ComboBoxContatos.ItemIndex = -1 then
  begin
    ShowMessage('Selecione um contato no ComboBox!');
    Exit;
  end;

  IdContato := Integer(ComboBoxContatos.Items.Objects[ComboBoxContatos.ItemIndex]);

  if FavoritosController.Adicionar(IdContato, Msg) then
  begin
    ShowMessage(Msg);
    CarregarFavoritos;
    CarregarContatosNoComboBox;  // ← ATUALIZA COMBOBOX
    ComboBoxContatos.ItemIndex := -1; // limpa seleção
  end
  else
    ShowMessage(Msg);
end;

procedure TFMain.SpdAdicionarGrupoClick(Sender: TObject);
var
  Grupo: TGrupos;
  Editando: Boolean;
  GrupoId: Integer;
begin
  // === VALIDAÇÕES COM FOCO NO CAMPO ERRADO ===
  if Trim(Edit7.Text) = '' then
  begin
    ShowMessage('Digite o nome do grupo!');
    Edit7.SetFocus;
    Exit;
  end;

  if Trim(Edit8.Text) = '' then
  begin
    ShowMessage('Digite a descrição do grupo!');
    Edit8.SetFocus;
    Exit;
  end;

  if ComboBox1.ItemIndex = -1 then
  begin
    ShowMessage('Selecione o nível de permissão!');
    ComboBox1.SetFocus;
    Exit;
  end;

  // === VERIFICA SE É EDIÇÃO ===
  GrupoId := 0;
  Editando := False;
  if not ClientDataSetGrupos.IsEmpty then
  begin
    GrupoId := ClientDataSetGrupos.FieldByName('ID').AsInteger;
    Editando := (GrupoId > 0);
  end;

  Grupo := TGrupos.Create;
  try
    // USA OS SETTERS CORRETOS DO MODEL
    Grupo.setNome(Trim(Edit7.Text));
    Grupo.setDescricao(Trim(Edit8.Text));
    Grupo.setIdPermissao(ComboBox1.ItemIndex + 1); // 0=Usuário, 1=Supervisor, 2=Admin

    if Editando then
    begin
      Grupo.setId(GrupoId);
      if GruposController.AtualizarGrupo(Grupo) then
        ShowMessage('Grupo atualizado com sucesso!')
      else
        ShowMessage('Erro ao atualizar grupo!');
    end
    else
    begin
      if GruposController.AdicionarGrupo(Grupo) then
        ShowMessage('Grupo adicionado com sucesso!')
      else
        ShowMessage('Erro ao adicionar grupo!');
    end;

    LimparFormularioGrupo;
    CarregarGrupos;

  except
    on E: Exception do
    begin
      ShowMessage('Erro de validação: ' + E.Message);
      // NÃO DEIXA O EXCEPT "ENGOLIR" O ERRO
    end;
  end;
end;
procedure TFMain.SpdRemoverClick(Sender: TObject);
begin
  LimparFormulario;
  Editando := False;
  ContatoAtual := nil;
  SpdAdicionar.Enabled := True;
  SpdEditarContatosGrid.Caption := 'Editar';
end;

procedure TFMain.SpdRemoverFavoritoClick(Sender: TObject);
var
  IdFavorito: Integer;
  Msg: string;
begin
  if ClientDataSetFavoritos.IsEmpty then
  begin
    ShowMessage('Nenhum favorito selecionado.');
    Exit;
  end;

  IdFavorito := ClientDataSetFavoritos.FieldByName('ID_FAVORITO').AsInteger;

  if MessageDlg('Remover dos favoritos?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    if FavoritosController.Remover(IdFavorito, Msg) then
    begin
      ClientDataSetFavoritos.Delete;
      ShowMessage(Msg);
    end
    else
      ShowMessage(Msg);
  end;
end;


procedure TFMain.SpdRestaurarEmpresaClick(Sender: TObject);
var
  Query: TFDQuery;
  TotalRestauradas: Integer;
  Msg: string;
begin
  // Pergunta se quer restaurar TODAS
  if MessageDlg('Deseja restaurar TODAS as empresas excluídas?',
                mtConfirmation, [mbYes, mbNo], 0) = mrNo then
    Exit;

  Query := TFDQuery.Create(nil);
  TotalRestauradas := 0;
  try
    Query.Connection := DataModule1.FDConnection1;
    Query.SQL.Text := 'SELECT codigo FROM empresa WHERE ativo = FALSE';
    Query.Open;

    // Percorre todas as empresas inativas
    while not Query.Eof do
    begin
      if EmpresasController.Restaurar(Query.FieldByName('codigo').AsInteger, Msg) then
        Inc(TotalRestauradas);
      Query.Next;
    end;

    // Mensagem final
    if TotalRestauradas > 0 then
      ShowMessage(Format('Restauradas %d empresa(s) com sucesso!', [TotalRestauradas]))
    else
      ShowMessage('Nenhuma empresa inativa para restaurar.');

    CarregarEmpresas; // Atualiza o grid
  finally
    Query.Free;
  end;
end;

procedure TFMain.SpdEditarClick(Sender: TObject);
begin
  if Editando and (ContatoAtual <> nil) then
  begin
    // Se estamos editando, salva as alterações
    if not ValidarFormulario then Exit;

    ContatoAtual.Nome := Edit1.Text;
    ContatoAtual.Telefone := Numero.Text;
    ContatoAtual.Email := Edit2.Text;
    ContatoAtual.Empresa := Edit3.Text;
    ContatoAtual.Endereco := Endereco.Text;
    ContatoAtual.Observacoes := Edit4.Text;

    if ContatosController.AtualizarContato(ContatoAtual) then
    begin
      AtualizarDBGrid;
      LimparFormulario;
      Editando := False;
      ContatoAtual := nil;
      SpdAdicionar.Enabled := True;
//      SpdEditarContatosGridClick().Caption := 'Editar'; // volta a ser "Editar"
      ShowMessage('Contato atualizado!');
    end
    else
      ShowMessage('Erro ao atualizar!');
  end
  else
  begin
    // Caso não esteja editando
    ShowMessage('Selecione um contato no grid primeiro!');
  end;
end;


procedure TFMain.SpdEditarContatosGridClick(Sender: TObject);
var
  Contato: Contatos;
begin
  // Se o usuário está editando diretamente no grid (dataset em modo de edição),
  // então apenas finalize a edição (Post) — isso dispara AfterPost -> SalvarEdicaoGridView
  if ClientDataSet1.State in [dsEdit, dsInsert] then
  begin
    try
      ClientDataSet1.Post; // dispara AfterPost que você já ligou a SalvarEdicaoGridView
      ShowMessage('Alterações do grid salvas.');
    except
      on E: Exception do
        ShowMessage('Erro ao salvar edição no grid: ' + E.Message);
    end;
    Exit;
  end;

  // Caso não esteja editando no grid, mantém comportamento atual: carregar no formulário
  Contato := ContatoSelecionado;
  if Contato <> nil then
  begin
    ContatoAtual := Contato;
    PreencherFormulario(ContatoAtual);
    Editando := True;
    SpdAdicionar.Enabled := False;
//    SpdEditarContatosGrid.Caption := 'Salvar'; // muda para "Salvar" ao editar
    // Edit1.SetFocus; // opcional
  end
  else
    ShowMessage('Selecione um contato no grid!');
end;


procedure TFMain.SpdEditarEmpresaClick(Sender: TObject);
var
  EmpresaTemp: TEmpresa;
  Mensagem: string;
begin
  // === SALVAR EDIÇÃO ===
  if EditandoEmpresa and (EmpresaAtual <> nil) then
  begin
    if not ValidarFormularioEmpresa then Exit;

    EmpresaAtual.setCNPJ(CodigoEmpresa.Text);
    EmpresaAtual.setNome(NomeDaEmpresa.Text);
    EmpresaAtual.setTelefone(MaskEdit1.Text);
    EmpresaAtual.setEmail(Edit5.Text);
    EmpresaAtual.setEndereco(Edit6.Text);
    EmpresaAtual.setUF(MaskEdit2.Text);

    if EmpresasController.Atualizar(EmpresaAtual, Mensagem) then
    begin
      ShowMessage(Mensagem);
      LimparFormularioEmpresa;
      FreeAndNil(EmpresaAtual);
      EditandoEmpresa := False;
      SpdAdicionarEmpresa.Enabled := True;
      SpdEditarEmpresa.Caption := 'Editar';
      PageControl2.ActivePage := TabSheet3;
      CarregarEmpresas;
    end
    else
      ShowMessage('Erro: ' + Mensagem);
  end
  else
  // === INICIAR EDIÇÃO ===
  begin
    EmpresaTemp := EmpresaSelecionada;
    if EmpresaTemp = nil then
    begin
      ShowMessage('Selecione uma empresa no grid primeiro!');
      Exit;
    end;

    // CRIA CÓPIA COMPLETA (COM CODIGO!)
    EmpresaAtual := TEmpresa.Create;
    EmpresaAtual.setCodigo(EmpresaTemp.getCodigo);  // ← USANDO CODIGO!
    EmpresaAtual.setCNPJ(EmpresaTemp.getCNPJ);
    EmpresaAtual.setNome(EmpresaTemp.getNome);
    EmpresaAtual.setTelefone(EmpresaTemp.getTelefone);
    EmpresaAtual.setEmail(EmpresaTemp.getEmail);
    EmpresaAtual.setEndereco(EmpresaTemp.getEndereco);
    EmpresaAtual.setUF(EmpresaTemp.getUF);

    PreencherFormularioEmpresa(EmpresaAtual);

    EditandoEmpresa := True;
    SpdAdicionarEmpresa.Enabled := False;
    SpdEditarEmpresa.Caption := 'Salvar';
    PageControl2.ActivePage := TabSheet2;
  end;
end;
procedure TFMain.SpdExcluirClick(Sender: TObject);
var
  Contato: Contatos;
begin
  Contato := ContatoSelecionado;
  if Contato = nil then
  begin
    ShowMessage('Nenhum contato selecionado para excluir!');
    Exit;
  end;

  if MessageDlg('Deseja realmente excluir este contato?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    Contato.Ativo := False; // exclusão lógica
    if ContatosController.AtualizarContato(Contato) then
    begin
      ShowMessage('Contato excluído com sucesso!');
      CarregarContatosDB; // atualiza o grid
    end
    else
      ShowMessage('Erro ao excluir o contato!');
  end;
end;

procedure TFMain.SpdExcluirEmpresaClick(Sender: TObject);
var
  IdEmpresa: Integer;
  Msg: string;
begin
  if ClientDataSetEmpresas.IsEmpty then
  begin
    ShowMessage('Selecione uma empresa no grid!');
    Exit;
  end;

  IdEmpresa := ClientDataSetEmpresas.FieldByName('ID').AsInteger;

  if MessageDlg('Excluir empresa selecionada?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    if EmpresasController.Remover(IdEmpresa, Msg) then
    begin
      ShowMessage(Msg);
      CarregarEmpresas;
    end
    else
      ShowMessage('Erro: ' + Msg);
  end;
end;

procedure TFMain.SpdListarClick(Sender: TObject);
begin
  LimparFormulario;
  CarregarContatosDB;
//  ShowMessage('Lista de contatos atualizada!');
end;


procedure TFMain.SpdListarEmpresaClick(Sender: TObject);
begin
  LimparFormularioEmpresa;
  EditandoEmpresa := False;
  SpdAdicionarEmpresa.Enabled := True;
  SpdEditarEmpresa.Caption := 'Editar';

  // FORÇA IR PARA A ABA DO GRID
  PageControl2.ActivePage := TabSheet3;

  // ATUALIZA O GRID AUTOMATICAMENTE
  CarregarEmpresas;
end;

procedure TFMain.DBGrid1DblClick(Sender: TObject);
begin
  if not ClientDataSetEmpresas.IsEmpty then
    SpdEditarEmpresaClick(Sender);
end;

procedure TFMain.DBGrid2DblClick(Sender: TObject);
begin
  SpdEditarContatosGridClick(Sender);
end;

function TFMain.EmpresaSelecionada: TEmpresa;
var
  IdSelecionado: Integer;
begin
  Result := nil;

  if not ClientDataSetEmpresas.IsEmpty then
  begin
    try
      IdSelecionado := ClientDataSetEmpresas.FieldByName('ID').AsInteger;
      EmpresasController.BuscarPorId(IdSelecionado, Result);
    except
      on E: Exception do
        ShowMessage('Erro ao buscar empresa: ' + E.Message);
    end;
  end;
end;

procedure TFMain.ExcluirGrupo(DataSet: TDataSet);
begin

end;

function TFMain.ValidarFormulario: Boolean;
begin
  Result := False;

  if Trim(Edit1.Text) = '' then
  begin
    ShowMessage('Digite o nome!');
//    Edit1.SetFocus;
    Exit;
  end;

  if Trim(Numero.Text) = '' then
  begin
    ShowMessage('Digite o telefone!');
//    Numero.SetFocus;
    Exit;
  end;

  Result := True;
end;

function TFMain.ValidarFormularioEmpresa: Boolean;
begin
  Result := False;

  if Trim(CodigoEmpresa.Text) = '' then
  begin
    ShowMessage('Digite o CNPJ!');
    Exit;
  end;

  if Trim(NomeDaEmpresa.Text) = '' then
  begin
    ShowMessage('Digite o nome da empresa!');
    Exit;
  end;

  if Trim(MaskEdit1.Text) = '' then
  begin
    ShowMessage('Digite o telefone!');
    Exit;
  end;

  if Trim(Edit5.Text) = '' then
  begin
    ShowMessage('Digite o email!');
    Exit;
  end;

  if Trim(Edit6.Text) = '' then
  begin
    ShowMessage('Digite o endereço!');
    Exit;
  end;

  if Trim(MaskEdit2.Text) = '' then
  begin
    ShowMessage('Digite a UF!');
    Exit;
  end;

  Result := True;
end;

function TFMain.ValidarFormularioGrupo: Boolean;
begin

end;

function TFMain.ValidarPermissaoGrupo(Operacao: string): Boolean;
begin

end;

function TFMain.ContatoSelecionado: Contatos;
var
  IdSelecionado: Integer;
  I: Integer;
begin
  Result := nil;

  if not ClientDataSet1.IsEmpty then
  begin
    try
      IdSelecionado := ClientDataSet1.FieldByName('ID').Value;

      for I := 0 to ContatosLista.Count - 1 do
      begin
        if ContatosLista[I].Id = IdSelecionado then
        begin
          Result := ContatosLista[I];
          Break;
        end;
      end;
    except

    end;
  end;
end;

procedure TFMain.PreencherFormulario(Contato: Contatos);
begin
  if Contato <> nil then
  begin
    Edit1.Text := Contato.Nome;
    Numero.Text := Contato.Telefone;
    Edit2.Text := Contato.Email;
    Edit3.Text := Contato.Empresa;
    Endereco.Text := Contato.Endereco;
    Edit4.Text := Contato.Observacoes;
  end;
end;

procedure TFMain.PreencherFormularioEmpresa(TEmpresa: TEmpresa);
begin
  if TEmpresa <> nil then
  begin
    CodigoEmpresa.Text := TEmpresa.getCNPJ;
    NomeDaEmpresa.Text := TEmpresa.getNome;
    MaskEdit1.Text := TEmpresa.getTelefone;
    Edit5.Text := TEmpresa.getEmail;
    Edit6.Text := TEmpresa.getEndereco;
    MaskEdit2.Text := TEmpresa.getUF;
  end;
end;

procedure TFMain.LimparFormulario;
begin
  Edit1.Text := '';
  Numero.Text := '';
  Edit2.Text := '';
  Edit3.Text := '';
  Endereco.Text := '';
  Edit4.Text := '';
//  Edit1.SetFocus;
end;

procedure TFMain.LimparFormularioEmpresa;
begin
  CodigoEmpresa.Text := '';
  NomeDaEmpresa.Text := '';
  MaskEdit1.Text := '';
  Edit5.Text := '';
  Edit6.Text := '';
  MaskEdit2.Text := '';
end;

procedure TFMain.LimparFormularioGrupo;
begin

end;

procedure TFMain.AtivarPainel(Panel: TPanel);
begin
  if PainelPressionado = Panel then
  begin
    Panel.Color := $00121212;
    Panel.BevelOuter := bvNone;
    Panel.BevelInner := bvNone;
    Panel.Cursor := crDefault;
    PainelPressionado := nil;
  end
  else
  begin
    ResetarPainelAnterior;

    Panel.Color := $6B0C44;
    Panel.BevelOuter := bvNone;
    Panel.BevelInner := bvLowered;
    Panel.Cursor := crDefault;
    PainelPressionado := Panel;
  end;
end;

procedure TFMain.ResetarPainelAnterior;
begin
  if Assigned(PainelPressionado) then
  begin
    PainelPressionado.Color := $00121212;
    PainelPressionado.BevelOuter := bvNone;
    PainelPressionado.BevelInner := bvNone;
    PainelPressionado.Cursor := crDefault;
  end;
end;

procedure TFMain.FormResize(Sender: TObject);
begin
  if (WindowState = wsMaximized) then
  begin
    Logo.Width := 100;
    Logo.Height := 90;
    ContactHub.Font.Size := 20;
    ContactHub.Alignment := taCenter;

    ImageConfig.Width := 32;
    ImageConfig.Height := 32;
    ImageConfig.Margins.Top := 10;
    ImageConfig.Align := alLeft;

    PanelContatos.Margins.Top := 45;
    PanelContatos.Height := 70;
    PanelContatos.Width := 100;
    PanelContatos.Font.Size := 18;

    PanelFavoritos.Margins.Top := 20;
    PanelFavoritos.Font.Size := 18;


    PanelGrupos.Margins.Top := 20;
    PanelGrupos.Font.Size := 19;


    PanelEmpresa.Margins.Top := 20;
    PanelEmpresa.Font.Size := 18;

    PanelImportExport.Margins.Top := 20;
    PanelImportExport.Font.Size := 18;

    PanelConfiguracao.Margins.Top := 20;
    PanelConfiguracao.Font.Size := 18;
  end
  else
  begin
    Logo.Width := 80;
    PanelContatos.Margins.Top := 5;
  end;
end;

procedure TFMain.LogoClick(Sender: TObject);
begin
  Logo.Stretch := True;
  Logo.Proportional := True;
  Logo.Center := True;
end;

procedure TFMain.PanelContatosClick(Sender: TObject);
begin
  AtivarPainel(PanelContatos);
  CardPanel1.ActiveCard := Card2;
  PageControl.Visible := True;
  Card2.Visible := True;
  Card2.CardVisible := True;

  CarregarContatosDB;
end;

procedure TFMain.PanelFavoritosClick(Sender: TObject);
begin
  AtivarPainel(PanelFavoritos);
  CardPanel1.ActiveCard := Card3;
  PageControl1.Visible := True;
  Card3.Visible := True;
  CarregarFavoritos;
  CarregarContatosNoComboBox;
end;

procedure TFMain.PanelEmpresaClick(Sender: TObject);
begin
  AtivarPainel(PanelEmpresa);
  CardPanel1.ActiveCard := Card5;
  PageControl2.Visible := True;
  Card5.Visible := True;


  ConfigurarDBGridEmpresas;
  CarregarEmpresas;
  PageControl2.ActivePage := TabSheet3;
end;
procedure TFMain.PanelImportExportClick(Sender: TObject);
begin
 AtivarPainel(PanelImportExport);
  CardPanel1.ActiveCard := Card5;
  PageControl2.Visible := True;
  Card5.Visible := True;
  CarregarEmpresas;
  PageControl2.ActivePage := TabSheet3;
  //CarregarContatosNoComboBox;
end;

procedure TFMain.PanelConfiguraçaoClick(Sender: TObject);
begin
  AtivarPainel(PanelConfiguracao);
  CardPanel1.ActiveCard := Card6;
  PageControl2.Visible := True;
  Card5.Visible := True;
  CarregarEmpresas;
  PageControl2.ActivePage := TabSheet3;
end;

procedure TFMain.PanelConfigClick(Sender: TObject);
begin
  AtivarPainel(PanelConfiguracao);
end;

procedure TFMain.PanelConfiguracaoClick(Sender: TObject);
begin
  AtivarPainel(PanelConfiguracao);
end;

procedure TFMain.PanelContatosMouseEnter(Sender: TObject);
begin
  if PainelPressionado <> PanelContatos then
  begin
    PanelContatos.BevelOuter := bvRaised;
    PanelContatos.Color := $00D6498F;
    PanelContatos.Cursor := crHandPoint;
    ImageContato.Picture.LoadFromFile(ExtractFilePath(Application.ExeName) + 'Pictures\ContatoPreta.png');
  end;
end;

procedure TFMain.PanelContatosMouseLeave(Sender: TObject);
begin
  if PainelPressionado <> PanelContatos then
  begin
    PanelContatos.BevelOuter := bvNone;
    PanelContatos.Color := $00121212;
    PanelContatos.Cursor := crDefault;
    ImageContato.Picture.LoadFromFile(ExtractFilePath(Application.ExeName) + 'Pictures\ContatoRoxa.png');
  end;
end;

procedure TFMain.PanelFavoritosMouseEnter(Sender: TObject);
begin
  if PainelPressionado <> PanelFavoritos then
  begin
    PanelFavoritos.BevelOuter := bvRaised;
    PanelFavoritos.Color := $00D6498F;
    PanelFavoritos.Cursor := crHandPoint;
    ImageFavoritos.Picture.LoadFromFile(ExtractFilePath(Application.ExeName) + 'Pictures\FavoritosPreta.png');
  end;
end;

procedure TFMain.PanelFavoritosMouseLeave(Sender: TObject);
begin
  if PainelPressionado <> PanelFavoritos then
  begin
    PanelFavoritos.BevelOuter := bvNone;
    PanelFavoritos.Color := $00121212;
    PanelFavoritos.Cursor := crDefault;
    ImageFavoritos.Picture.LoadFromFile(ExtractFilePath(Application.ExeName) + 'Pictures\FavoritosRoxa.png');
  end;
end;

procedure TFMain.PanelEmpresaMouseEnter(Sender: TObject);
begin
  if PainelPressionado <> PanelEmpresa then
  begin
    PanelEmpresa.BevelOuter := bvRaised;
    PanelEmpresa.Color := $00D6498F;
    PanelEmpresa.Cursor := crHandPoint;
    ImageEmpresa.Picture.LoadFromFile(ExtractFilePath(Application.ExeName) + 'Pictures\LogoEmpresaPreta.png');
  end;
end;

procedure TFMain.PanelEmpresaMouseLeave(Sender: TObject);
begin
  if PainelPressionado <> PanelEmpresa then
  begin
    PanelEmpresa.BevelOuter := bvNone;
    PanelEmpresa.Color := $00121212;
    PanelEmpresa.Cursor := crDefault;
    ImageEmpresa.Picture.LoadFromFile(ExtractFilePath(Application.ExeName) + 'Pictures\LogoEmpresaRoxa.png');
  end;
end;

procedure TFMain.PanelImportExportMouseEnter(Sender: TObject);
begin
  if PainelPressionado <> PanelImportExport then
  begin
    PanelImportExport.BevelOuter := bvRaised;
    PanelImportExport.Color := $00D6498F;
    PanelImportExport.Cursor := crHandPoint;
    ImageImpExp.Picture.LoadFromFile(ExtractFilePath(Application.ExeName) + 'Pictures\ImpPreta.png');
  end;
end;

procedure TFMain.PanelImportExportMouseLeave(Sender: TObject);
begin
  if PainelPressionado <> PanelImportExport then
  begin
    PanelImportExport.BevelOuter := bvNone;
    PanelImportExport.Color := $00121212;
    PanelImportExport.Cursor := crDefault;
    ImageImpExp.Picture.LoadFromFile(ExtractFilePath(Application.ExeName) + 'Pictures\ImpRoxa.png');
  end;
end;

procedure TFMain.PanelGruposClick(Sender: TObject);
begin
AtivarPainel(PanelGrupos);
CardPanel1.ActiveCard := Card4;


  PageControl4.Visible := True;
  TabSheet6.Visible := True;
  Card6.Visible := True;


  ConfigurarDBGridGrupos;
  CarregarGrupos;



end;

procedure TFMain.PanelGruposMouseEnter(Sender: TObject);
begin
  if PainelPressionado <> PanelGrupos then
  begin
    PanelGrupos.BevelOuter := bvRaised;
    PanelGrupos.Color := $00D6498F;
    PanelGrupos.Cursor := crHandPoint;
    ImageGrupos.Picture.LoadFromFile(ExtractFilePath(Application.ExeName) + 'Pictures\LogoGruposPreta.png');
  end;
end;

procedure TFMain.PanelGruposMouseLeave(Sender: TObject);
begin
  if PainelPressionado <> PanelGrupos then
  begin
    PanelGrupos.BevelOuter := bvNone;
    PanelGrupos.Color := $00121212;
    PanelGrupos.Cursor := crDefault;
    ImageGrupos.Picture.LoadFromFile(ExtractFilePath(Application.ExeName) + 'Pictures\LogoGruposRoxa.png');
  end;
end;

procedure TFMain.PanelConfiguracaoMouseEnter(Sender: TObject);
begin
  if PainelPressionado <> PanelConfiguracao then
  begin
    PanelConfiguracao.BevelOuter := bvRaised;
    PanelConfiguracao.Color := $00D6498F;
    PanelConfiguracao.Cursor := crHandPoint;
    ImageConfig.Picture.LoadFromFile(ExtractFilePath(Application.ExeName) + 'Pictures\ConfiguracaoPreta.png');
  end;
end;

procedure TFMain.PanelConfiguracaoMouseLeave(Sender: TObject);
begin
  if PainelPressionado <> PanelConfiguracao then
  begin
    PanelConfiguracao.BevelOuter := bvNone;
    PanelConfiguracao.Color := $00121212;
    PanelConfiguracao.Cursor := crDefault;
    ImageConfig.Picture.LoadFromFile(ExtractFilePath(Application.ExeName) + 'Pictures\ConfiguracaoRoxa.png');
  end;
end;





end.
