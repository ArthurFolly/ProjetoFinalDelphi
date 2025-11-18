unit uMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.ExtCtrls, Vcl.Imaging.jpeg, Vcl.Imaging.pngimage, Vcl.StdCtrls,
  Vcl.ComCtrls, Vcl.WinXPanels, Vcl.Mask, Vcl.Buttons, Vcl.Grids,
  Data.DB, Vcl.DBGrids, ContatosController, TContatosModel,
  ContatosRepository, System.Generics.Collections, Data.FMTBcd,
  Data.SqlExpr, Datasnap.DBClient, FireDAC.Phys.PGDef,
  FireDAC.Phys.PG, FireDAC.Comp.Client,ConexaoBanco, FavoritosModel,
  FavoritosController,FavoritosRepository, EmpresaModel,
  EmpresaController,GruposModel,GruposRepository,GruposController,
  System.ImageList, Vcl.ImgList, System.Net.HttpClient,
  System.Net.URLClient, System.JSON, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Comp.DataSet, VCardImportController,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.UI.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Phys, FireDAC.VCLUI.Wait, frxSmartMemo, frxClass,
  frCoreClasses, frxDBSet,PermissoesController,PermissoesRepository,PermissoesModel;

type
  TFMain = class(TForm)
    Fundo: TImage;
    Panel1: TPanel;
    Logo: TImage;
    pnlContatos: TPanel;
    ImageContato: TImage;
    pnlConfiguracao: TPanel;
    pnlImportExport: TPanel;
    pnlEmpresa: TPanel;
    pnlFavoritos: TPanel;
    pnlGrupos: TPanel;
    ContactHub: TPanel;
    ImageFavoritos: TImage;
    ImageEmpresa: TImage;
    ImageImpExp: TImage;
    ImgConfig: TImage;
    ImageGrupos: TImage;
    PanelForm: TPanel;
    CardPanel1: TCardPanel;
    crdImpExp: TCard;
    crdContatos: TCard;
    crdFavoritos: TCard;
    crdEmpresas: TCard;
    crdGrupos: TCard;
    crdConfig: TCard;
    pgcContatos: TPageControl;
    tbsContatosList: TTabSheet;
    tbsContatosCad: TTabSheet;
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
    txtLogradouro: TEdit;
    Label4: TLabel;
    Empresa: TLabel;
    Edit3: TEdit;
    Edit4: TEdit;
    SpdAdicionar: TSpeedButton;
    pgcFavoritos: TPageControl;
    tbsFavoritosCad: TTabSheet;
    Panel5: TPanel;
    Panel6: TPanel;
    Label5: TLabel;
    Bevel3: TBevel;
    Panel7: TPanel;
    SpdEditarContatosGrid: TSpeedButton;
    SpdExcluir: TSpeedButton;
    SpdListar: TSpeedButton;
    dbgContatos: TDBGrid;
    SpdAdicionarFavorito: TSpeedButton;
    SpdRemoverFavorito: TSpeedButton;
    DBGridFavoritos: TDBGrid;
    ComboBoxContatos: TComboBox;
    pgcEmpresas: TPageControl;
    tbsEmpresasCad: TTabSheet;
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
    tbsEmpresasList: TTabSheet;
    Panel10: TPanel;
    Label13: TLabel;
    Label14: TLabel;
    DBGrid1: TDBGrid;
    SpdEditarEmpresa: TSpeedButton;
    SpdRestaurarEmpresa: TSpeedButton;
    SpdExcluirEmpresa: TSpeedButton;
    SpdAdicionarEmpresa: TSpeedButton;
    PageControl4: TPageControl;
    TabSheet6: TTabSheet;
    Panel13: TPanel;
    Panel14: TPanel;
    Label15: TLabel;
    DBGridGrupos: TDBGrid;
    Edit8: TEdit;
    Label16: TLabel;
    SpdAdicionarGrupo: TSpeedButton;
    SpdExcluirGrupo: TSpeedButton;
    SpdEditarGrupo: TSpeedButton;
    SpdRestaurarGrupos: TSpeedButton;
    Bevel9: TBevel;
    Bevel7: TBevel;
    Label17: TLabel;
    Edit7: TEdit;
    txtNumero: TEdit;
    txtComplemento: TEdit;
    txtBairro: TEdit;
    txtCEP: TEdit;
    lblPesquisarCEP: TLabel;
    txtLocalidade: TEdit;
    txtUF: TEdit;
    SpeedButton5: TSpeedButton;
    pgcImpExp: TPageControl;
    tbsImport: TTabSheet;
    tbsExport: TTabSheet;
    Panel15: TPanel;
    Panel16: TPanel;
    Panel17: TPanel;
    Panel18: TPanel;
    pgcConfig: TPageControl;
    tbsPermissoes: TTabSheet;
    Panel11: TPanel;
    Panel12: TPanel;
    Label18: TLabel;
    Label19: TLabel;
    Bevel8: TBevel;
    Bevel10: TBevel;
    SpdAdicionarPerm: TSpeedButton;
    SpdExcluirPerm: TSpeedButton;
    SpdEditarPerm: TSpeedButton;
    SpdListarPerm: TSpeedButton;
    DBGridPerm: TDBGrid;
    ComboBox1: TComboBox;
    pnlRelatorios: TPanel;
    imgRelatorios: TImage;
    crdRelatorios: TCard;
    pgcRelatorios: TPageControl;
    tbsRelatorio: TTabSheet;
    Panel21: TPanel;
    Panel22: TPanel;
    OpenDialog1: TOpenDialog;
    dbgImportCont: TDBGrid;
    memImportCont: TMemo;
    sdbImpNovo: TSpeedButton;
    spdImpExcluir: TSpeedButton;
    spdImpSalvarDB: TSpeedButton;
    spdImpContatos: TSpeedButton;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    RadioButton3: TRadioButton;
    spdImprimir: TSpeedButton;
    Label20: TLabel;
    mtbContatos: TFDMemTable;
    fdcContatos: TSQLConnection;
    dsContatos: TDataSource;
    cdsContatos: TClientDataSet;
    qryContatos: TSQLQuery;
    mtbImportCont: TFDMemTable;
    fdcImportCont: TSQLConnection;
    dsImportCont: TDataSource;
    cdsImportCont: TClientDataSet;
    qryImportCont: TSQLQuery;
    frxDBDados: TfrxDBDataset;
    frxReportContatosNome: TfrxReport;
    frxReportContatosTelefone: TfrxReport;
    frxReportUsuariosNome: TfrxReport;
    qryRelContatos: TFDQuery;
    FDConnRel: TFDConnection;
    Label21: TLabel;
    qryRelUsuarios: TFDQuery;
    frxDBUsuarios: TfrxDBDataset;
    ComboBox2: TComboBox;

    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure LogoClick(Sender: TObject);
    procedure pnlContatosClick(Sender: TObject);
    procedure pnlFavoritosClick(Sender: TObject);
    procedure pnlEmpresaClick(Sender: TObject);
    procedure pnlImportExportClick(Sender: TObject);
    procedure PanelConfiguraçaoClick(Sender: TObject);
    procedure pnlContatosMouseEnter(Sender: TObject);
    procedure pnlContatosMouseLeave(Sender: TObject);
    procedure pnlFavoritosMouseEnter(Sender: TObject);
    procedure pnlFavoritosMouseLeave(Sender: TObject);
    procedure pnlEmpresaMouseEnter(Sender: TObject);
    procedure pnlEmpresaMouseLeave(Sender: TObject);
    procedure pnlImportExportMouseEnter(Sender: TObject);
    procedure pnlImportExportMouseLeave(Sender: TObject);
    procedure pnlConfiguracaoMouseEnter(Sender: TObject);
    procedure pnlConfiguracaoMouseLeave(Sender: TObject);
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
    procedure pnlGruposClick(Sender: TObject);
    procedure pnlGruposMouseLeave(Sender: TObject);
    procedure pnlGruposMouseEnter(Sender: TObject);
    procedure SpdAdicionarGrupoClick(Sender: TObject);
    procedure SpdEditarGrupoClick(Sender: TObject);
    procedure SpdExcluirGrupoClick(Sender: TObject);
    procedure SpdRestaurarGruposClick(Sender: TObject);
    procedure SpeedButton5Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure pnlRelatoriosMouseEnter(Sender: TObject);
    procedure pnlRelatoriosMouseLeave(Sender: TObject);
    procedure pnlRelatoriosClick(Sender: TObject);
    procedure spdImpContatosClick(Sender: TObject);
    procedure sdbImpNovoClick(Sender: TObject);
    procedure spdImpExcluirClick(Sender: TObject);
    procedure spdImpSalvarDBClick(Sender: TObject);
    procedure spdImprimirClick(Sender: TObject);
    procedure SpdAdicionarPermClick(Sender: TObject);
    procedure SpdExcluirPermClick(Sender: TObject);
    procedure SpdEditarPermClick(Sender: TObject);
    procedure SpdListarPermClick(Sender: TObject);



  private
    Editando: Boolean;
    ContatoAtual: Contatos;
    ContatosLista: TObjectList<Contatos>;
    ContatosController: TContatosController;
    FavoritosController: TFavoritosController;
    ClientDataSetFavoritos: TClientDataSet;
    DataSourceFavoritos: TDataSource;
    LoadingDataset: Boolean;

    // === PERMISSÕES ===
    PermissoesController: TPermissoesController;
    ClientDataSetPermissoes: TClientDataSet;
    DataSourcePermissoes: TDataSource;
    LoadingPermissoes: Boolean;
    EditandoPermissao: Boolean;
    PermissaoAtual: Integer;


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


    // === Permissões ===
    procedure ConfigurarDBgridPerm;
    procedure CarregarPermissoes;
    procedure CarregarUsuariosNoComboBox1;
    procedure CarregarPermissoesNoComboBox2;


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

    // ----- Importacao VCF
    procedure PrepareMemTable;
    procedure ConfigurarGrid;

  end;

var
  FMain: TFMain;

implementation

{$R *.dfm}

var
  PainelPressionado: TPanel;

{$REGION 'Ciclo de vida do formulário / Layout'}

procedure TFMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;          // libera o FMain da memória
  Application.Terminate;     // encerra toda a aplicação de forma definitiva
end;

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
  PermissoesController := TPermissoesController.Create;

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

  crdEmpresas.Visible := False;
  pgcEmpresas.Visible := False;

  CarregarUsuariosNoComboBox1;
  CarregarPermissoesNoComboBox2;
  // ----- Importacao VCF
  memImportCont.Font.Name := 'Segoe UI';
  OpenDialog1.Filter := 'vCard (*.vcf)|*.vcf|Todos os arquivos (*.*)|*.*';
  OpenDialog1.DefaultExt := 'vcf';
  OpenDialog1.FilterIndex := 1;
  OpenDialog1.InitialDir := 'C:\';

  PrepareMemTable;
  ConfigurarGrid;
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

procedure TFMain.FormResize(Sender: TObject);
begin
  if (WindowState = wsMaximized) then
  begin
    Logo.Width := 100;
    Logo.Height := 90;
    ContactHub.Font.Size := 20;
    ContactHub.Alignment := taCenter;

    ImgConfig.Width := 32;
    ImgConfig.Height := 32;
    ImgConfig.Margins.Top := 10;
    ImgConfig.Align := alLeft;

    pnlContatos.Margins.Top := 45;
    pnlContatos.Height := 70;
    pnlContatos.Width := 100;
    pnlContatos.Font.Size := 18;

    pnlFavoritos.Margins.Top := 20;
    pnlFavoritos.Font.Size := 18;

    pnlGrupos.Margins.Top := 20;
    pnlGrupos.Font.Size := 19;

    pnlEmpresa.Margins.Top := 20;
    pnlEmpresa.Font.Size := 18;

    pnlImportExport.Margins.Top := 20;
    pnlImportExport.Font.Size := 18;

    pnlConfiguracao.Margins.Top := 20;
    pnlConfiguracao.Font.Size := 18;
  end
  else
  begin
    Logo.Width := 80;
    pnlContatos.Margins.Top := 5;
  end;
end;

procedure TFMain.LogoClick(Sender: TObject);
begin
  Logo.Stretch := True;
  Logo.Proportional := True;
  Logo.Center := True;
end;

{$ENDREGION}

{$REGION 'Configuração de grids e datasets (Contatos, Empresas, Favoritos, Grupos)'}







procedure TFMain.ConfigurarDBGrid;
begin
  // 1. Sempre limpar e recriar
  cdsContatos.Close;
  cdsContatos.FieldDefs.Add('id_contato', ftInteger);
  cdsContatos.FieldDefs.Add('nome', ftString, 100);
  cdsContatos.FieldDefs.Add('telefone', ftString, 20);
  cdsContatos.FieldDefs.Add('email', ftString, 100);
  cdsContatos.FieldDefs.Add('endereco', ftString, 200);
  cdsContatos.FieldDefs.Add('empresa', ftString, 100);
  cdsContatos.FieldDefs.Add('observacoes', ftString, 300);
  cdsContatos.FieldDefs.Add('ativo', ftBoolean);
  cdsContatos.FieldDefs.Add('cep', ftString, 10);
  cdsContatos.FieldDefs.Add('logradouro', ftString, 150);
  cdsContatos.FieldDefs.Add('numero', ftString, 20);
  cdsContatos.FieldDefs.Add('complemento', ftString, 100);
  cdsContatos.FieldDefs.Add('bairro', ftString, 100);
  cdsContatos.FieldDefs.Add('cidade', ftString, 100);
  cdsContatos.FieldDefs.Add('uf', ftString, 2);
  cdsContatos.CreateDataSet;

  // 2. DataSource
  dsContatos.DataSet := cdsContatos;
  dbgContatos.DataSource := dsContatos;

  // 3. Sempre recriar colunas
  dbgContatos.Columns.Clear;
  with dbgContatos.Columns.Add do
  begin
    FieldName := 'id_contato';
    Title.Caption := 'ID';
    Width := 50;
    Title.Font.Style := [fsBold];
  end;

  with dbgContatos.Columns.Add do
  begin
    FieldName := 'nome';
    Title.Caption := 'Nome';
    Width := 180;
    Title.Font.Style := [fsBold];
  end;

  with dbgContatos.Columns.Add do
  begin
    FieldName := 'telefone';
    Title.Caption := 'Telefone';
    Width := 120;
  end;

  with dbgContatos.Columns.Add do
  begin
    FieldName := 'email';
    Title.Caption := 'E-mail';
    Width := 180;
  end;

  with dbgContatos.Columns.Add do
  begin
    FieldName := 'empresa';
    Title.Caption := 'Empresa';
    Width := 150;
  end;

  with dbgContatos.Columns.Add do
  begin
    FieldName := 'endereco';
    Title.Caption := 'Endereço';
    Width := 200;
  end;

  with dbgContatos.Columns.Add do
  begin
    FieldName := 'cep';
    Title.Caption := 'CEP';
    Width := 90;
  end;

  with dbgContatos.Columns.Add do
  begin
    FieldName := 'logradouro';
    Title.Caption := 'Logradouro';
    Width := 180;
  end;

  with dbgContatos.Columns.Add do
  begin
    FieldName := 'numero';
    Title.Caption := 'Número';
    Width := 70;
  end;

  with dbgContatos.Columns.Add do
  begin
    FieldName := 'complemento';
    Title.Caption := 'Complemento';
    Width := 100;
  end;

  with dbgContatos.Columns.Add do
  begin
    FieldName := 'bairro';
    Title.Caption := 'Bairro';
    Width := 120;
  end;

  with dbgContatos.Columns.Add do
  begin
    FieldName := 'cidade';
    Title.Caption := 'Cidade';
    Width := 130;
  end;

  with dbgContatos.Columns.Add do
  begin
    FieldName := 'uf';
    Title.Caption := 'UF';
    Width := 50;
  end;

  dbgContatos.Options := [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgEditing];
  dbgContatos.ReadOnly := False;

  // 5. Eventos
  cdsContatos.AfterPost := SalvarEdicaoGridView;
  cdsContatos.AfterDelete := ConfirmarExclusaoGrid;

  // 6. Abre
  if not cdsContatos.Active then
    cdsContatos.Open;
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
  DataSourceGrupos.DataSet := ClientDataSetGrupos;
  DBGridGrupos.DataSource := DataSourceGrupos;
  ClientDataSetGrupos.Close;
  ClientDataSetGrupos.FieldDefs.Clear;
  ClientDataSetGrupos.FieldDefs.Add('ID', ftInteger);
  ClientDataSetGrupos.FieldDefs.Add('NOME', ftString, 100);
  // REMOVA: DESCRICAO
  // REMOVA: ID_PERMISSAO (se não usa)
  ClientDataSetGrupos.CreateDataSet;
  ClientDataSetGrupos.Open;
  DBGridGrupos.Columns.Clear;

  // ID
  with DBGridGrupos.Columns.Add do
  begin
    FieldName := 'ID';
    Title.Caption := 'ID';
    Width := 60;
  end;

  // NOME
  with DBGridGrupos.Columns.Add do
  begin
    FieldName := 'NOME';
    Title.Caption := 'NOME DO GRUPO';
    Width := 400;
    Title.Font.Style := [fsBold];
  end;

  DBGridGrupos.Options := [
    dgTitles, dgIndicator, dgColumnResize,
    dgColLines, dgRowLines, dgTabs, dgRowSelect
  ];
end;


procedure TFMain.ConfigurarDBGridPerm;
begin
  // DataSource
  DataSourcePermissoes.DataSet := ClientDataSetPermissoes;
  DBGridPerm.DataSource := DataSourcePermissoes;

  // Cria dataset
  ClientDataSetPermissoes.Close;
  ClientDataSetPermissoes.FieldDefs.Clear;
  ClientDataSetPermissoes.FieldDefs.Add('id_permissao', ftInteger);
  ClientDataSetPermissoes.FieldDefs.Add('NOME', ftString, 100);
  ClientDataSetPermissoes.FieldDefs.Add('DESCRICAO', ftString, 300);
  ClientDataSetPermissoes.CreateDataSet;
  ClientDataSetPermissoes.Open;

  // Colunas
  DBGridPerm.Columns.Clear;
  with DBGridPerm.Columns.Add do
  begin
    FieldName := 'id_permissao';
    Title.Caption := 'ID';
    Width := 50;
  end;
  with DBGridPerm.Columns.Add do
  begin
    FieldName := 'NOME';
    Title.Caption := 'NOME DA PERMISSÃO';
    Width := 250;
    Title.Font.Style := [fsBold];
  end;
  with DBGridPerm.Columns.Add do
  begin
    FieldName := 'DESCRICAO';
    Title.Caption := 'DESCRIÇÃO';
    Width := 350;
  end;


  DBGridPerm.Options := [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect];
  DBGridPerm.ReadOnly := True;
end;

{$ENDREGION}

{$REGION 'Carregamento e atualização de dados (Contatos, Empresas, Favoritos, Grupos)'}

procedure TFMain.CarregarContatosDB;
begin
  ContatosLista.Clear;
  ContatosController.CarregarContatos(ContatosLista);
  AtualizarDBGrid;  // <-- recria colunas + dados
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
begin
  if not cdsContatos.Active then
    cdsContatos.Open; // Garante que esteja aberto

  LoadingDataset := True;
  cdsContatos.DisableControls;
  try
    cdsContatos.EmptyDataSet; // OK agora, porque já está aberto

    for var Contato in ContatosLista do
    begin
      cdsContatos.Append;
      cdsContatos.FieldByName('id_contato').AsInteger := Contato.Id;
      cdsContatos.FieldByName('nome').AsString := Contato.Nome;
      cdsContatos.FieldByName('telefone').AsString := Contato.Telefone;
      cdsContatos.FieldByName('email').AsString := Contato.Email;
      cdsContatos.FieldByName('empresa').AsString := Contato.Empresa;
      cdsContatos.FieldByName('endereco').AsString := Contato.Endereco;
      cdsContatos.FieldByName('observacoes').AsString := Contato.Observacoes;
      cdsContatos.FieldByName('ativo').AsBoolean := Contato.Ativo;
      cdsContatos.FieldByName('cep').AsString := Contato.CEP;
      cdsContatos.FieldByName('logradouro').AsString := Contato.Logradouro;
      cdsContatos.FieldByName('numero').AsString := Contato.Numero;
      cdsContatos.FieldByName('complemento').AsString := Contato.Complemento;
      cdsContatos.FieldByName('bairro').AsString := Contato.Bairro;
      cdsContatos.FieldByName('cidade').AsString := Contato.Cidade;
      cdsContatos.FieldByName('uf').AsString := Contato.UF;
      cdsContatos.Post;
    end;
  finally
    cdsContatos.EnableControls;
    cdsContatos.First;
    LoadingDataset := False;
  end;
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

procedure TFMain.CarregarPermissoes;
var
  Lista: TObjectList<TPermissao>;
  Perm: TPermissao;
begin
  if LoadingPermissoes then Exit;
  LoadingPermissoes := True;
  ClientDataSetPermissoes.DisableControls;
  try
    ClientDataSetPermissoes.Close;
    ClientDataSetPermissoes.FieldDefs.Clear;
    ClientDataSetPermissoes.FieldDefs.Add('id_permissão', ftInteger);
    ClientDataSetPermissoes.FieldDefs.Add('NOME', ftString, 100);
    ClientDataSetPermissoes.FieldDefs.Add('DESCRICAO', ftString, 300);
    ClientDataSetPermissoes.CreateDataSet;
    ClientDataSetPermissoes.Open;
    ClientDataSetPermissoes.EmptyDataSet;

    Lista := PermissoesController.ListarTodasPermissoes;
    try
      for Perm in Lista do
      begin
        ClientDataSetPermissoes.Append;
        ClientDataSetPermissoes.FieldByName('id_permissao').AsInteger := Perm.getId;
        ClientDataSetPermissoes.FieldByName('NOME').AsString := Perm.getNome;
        ClientDataSetPermissoes.FieldByName('DESCRICAO').AsString := Perm.getDescricao;
        ClientDataSetPermissoes.Post;
      end;
    finally
      Lista.Free;
    end;
  finally
    ClientDataSetPermissoes.EnableControls;
    LoadingPermissoes := False;
  end;
end;



procedure TFMain.CarregarUsuariosNoComboBox1;
var
  Query: TFDQuery;
begin
  ComboBox1.Clear;
  ComboBox1.Items.Add('← Selecione um usuário →');

  Query := TFDQuery.Create(nil);
  try
    Query.Connection := DataModule1.FDConnection1;
    Query.SQL.Text :=
      'SELECT id_usuario, nome, email FROM "Usuario" WHERE ativo = TRUE ORDER BY nome';
    Query.Open();

    while not Query.Eof do
    begin
      if Query.FieldByName('email').AsString <> '' then
        ComboBox1.Items.AddObject(
          Query.FieldByName('nome').AsString + ' <' + Query.FieldByName('email').AsString + '>',
          TObject(Query.FieldByName('id_usuario').AsInteger)
        )
      else
        ComboBox1.Items.AddObject(
          Query.FieldByName('nome').AsString,
          TObject(Query.FieldByName('id_usuario').AsInteger)
        );
      Query.Next;
    end;
  finally
    Query.Free;
  end;

  ComboBox1.ItemIndex := 0;
end;

procedure TFMain.CarregarPermissoesNoComboBox2;
var
  Query: TFDQuery;
begin
  ComboBox2.Clear;
  ComboBox2.Items.Add('← Selecione o nível →');

  Query := TFDQuery.Create(nil);
  try
    Query.Connection := DataModule1.FDConnection1;
    Query.SQL.Text :=
      'SELECT DISTINCT nivel_requerido ' +
      'FROM "Permissoes" ' +
      'WHERE ativo = TRUE ' +
      'ORDER BY nivel_requerido';

    Query.Open();

    while not Query.Eof do
    begin
      ComboBox2.Items.Add(Query.FieldByName('nivel_requerido').AsString);
      Query.Next;
    end;
  finally
    Query.Free;
  end;

  ComboBox2.ItemIndex := 0;
end;
{$ENDREGION}

{$REGION 'Persistência / salvar e excluir (Contatos, Empresas, Grupos, Favoritos)'}

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
  IdContato: Integer;
  Mensagem: string;
  Contato: Contatos;
  Lista: TObjectList<Contatos>;
  I: Integer;
begin
  if cdsContatos.IsEmpty then Exit;

  IdContato := cdsContatos.FieldByName('id_contato').AsInteger;

  if MessageDlg('Deseja realmente excluir este contato?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    // Busca o contato na lista completa
    Lista := ContatosController.ListarContatos;
    try
      Contato := nil;
      for I := 0 to Lista.Count - 1 do
      begin
        if Lista[I].Id = IdContato then
        begin
          Contato := Lista[I];
          Break;
        end;
      end;

      if Contato = nil then
      begin
        ShowMessage('Contato não encontrado na lista.');
        DataSet.Cancel;
        Exit;
      end;

      Contato.Ativo := False;
      if ContatosController.AtualizarContato(Contato, Mensagem) then
      begin
        ShowMessage('Contato excluído com sucesso!');
        CarregarContatosDB;
      end
      else
      begin
        ShowMessage('Erro: ' + Mensagem);
        DataSet.Cancel;
      end;
    finally
      Lista.Free;
    end;
  end
  else
    DataSet.Cancel;
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
  Mensagem: string;
begin
  if LoadingDataset then Exit;

  Contato := ContatoSelecionado;
  if Contato = nil then Exit;

  try
    Contato.Nome := DataSet.FieldByName('NOME').AsString;
    Contato.Telefone := DataSet.FieldByName('TELEFONE').AsString;
    Contato.Email := DataSet.FieldByName('EMAIL').AsString;
    Contato.Empresa := DataSet.FieldByName('EMPRESA').AsString;
    Contato.Endereco := DataSet.FieldByName('ENDERECO').AsString;
    Contato.CEP := DataSet.FieldByName('CEP').AsString;
    Contato.Logradouro := DataSet.FieldByName('LOGRADOURO').AsString;
    Contato.Numero := DataSet.FieldByName('NUMERO').AsString;
    Contato.Complemento := DataSet.FieldByName('COMPLEMENTO').AsString;
    Contato.Bairro := DataSet.FieldByName('BAIRRO').AsString;
    Contato.Cidade := DataSet.FieldByName('CIDADE').AsString;
    Contato.UF := DataSet.FieldByName('UF').AsString;

    if ContatosController.AtualizarContato(Contato, Mensagem) then
    begin
      // ShowMessage('Atualizado com sucesso!');
    end
    else
    begin
      ShowMessage('Erro: ' + Mensagem);
      DataSet.Cancel;
    end;
  except
    on E: Exception do
    begin
      ShowMessage('Erro ao salvar: ' + E.Message);
      DataSet.Cancel;
    end;
  end;
end;

procedure TFMain.SalvarEdicaoGrupo(DataSet: TDataSet);
begin

end;

procedure TFMain.ExcluirGrupo(DataSet: TDataSet);
begin

end;

{$ENDREGION}

{$REGION 'Validação e helpers de formulário'}

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

  if not cdsContatos.IsEmpty then
  begin
    try
      IdSelecionado := cdsContatos.FieldByName('id_contato').Value;

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
    txtLogradouro.Text := Contato.Endereco;
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
  txtLogradouro.Text := '';
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

{$ENDREGION}

{$REGION 'Controle visual de painéis e navegação de cards'}

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

procedure TFMain.pnlContatosClick(Sender: TObject);
begin
  AtivarPainel(pnlContatos);
  CardPanel1.ActiveCard := crdContatos;
  pgcContatos.Visible := True;
  crdContatos.Visible := True;
  crdContatos.CardVisible := True;
  pgcContatos.ActivePage := tbsContatosList;
  CarregarContatosDB;
end;

procedure TFMain.pnlFavoritosClick(Sender: TObject);
begin
  AtivarPainel(pnlFavoritos);
  CardPanel1.ActiveCard := crdFavoritos;
  pgcFavoritos.Visible := True;
  crdFavoritos.Visible := True;
  CarregarFavoritos;
  CarregarContatosNoComboBox;
end;

procedure TFMain.pnlEmpresaClick(Sender: TObject);
begin
  AtivarPainel(pnlEmpresa);
  CardPanel1.ActiveCard := crdEmpresas;
  pgcEmpresas.Visible := True;
  crdEmpresas.Visible := True;
  ConfigurarDBGridEmpresas;
  CarregarEmpresas;
  pgcEmpresas.ActivePage := tbsEmpresasList;
end;

procedure TFMain.pnlImportExportClick(Sender: TObject);
begin
  AtivarPainel(pnlImportExport);
  CardPanel1.ActiveCard := crdImpExp;
  crdImpExp.Visible := True;
  pgcImpexp.Visible := True;
  pgcImpExp.ActivePage := tbsImport;
end;

procedure TFMain.PanelConfiguraçaoClick(Sender: TObject);
begin
  AtivarPainel(pnlConfiguracao);
  CardPanel1.ActiveCard := crdConfig;
  crdConfig.Visible := True;
  pgcConfig.Visible := True;
  pgcConfig.ActivePage := tbsPermissoes;
  CarregarUsuariosNoComboBox1;
  CarregarPermissoesNoComboBox2;
  ConfigurarDBgridPerm;
end;


procedure TFMain.pnlRelatoriosClick(Sender: TObject);
begin
  AtivarPainel(pnlRelatorios);
  CardPanel1.ActiveCard := crdRelatorios;
  crdRelatorios.Visible := True;
  pgcRelatorios.Visible := True;
  pgcRelatorios.ActivePage := tbsRelatorio;
end;

procedure TFMain.pnlGruposClick(Sender: TObject);
begin
  AtivarPainel(pnlGrupos);
  CardPanel1.ActiveCard := crdGrupos;

  PageControl4.Visible := True;
  TabSheet6.Visible := True;
  crdConfig.Visible := True;

  ConfigurarDBGridGrupos;
  CarregarGrupos;
end;

{$ENDREGION}

{$REGION 'Mouse Enter/Leave dos painéis do menu lateral'}

procedure TFMain.pnlContatosMouseEnter(Sender: TObject);
begin
  if PainelPressionado <> pnlContatos then
  begin
    pnlContatos.BevelOuter := bvRaised;
    pnlContatos.Color := $00D6498F;
    pnlContatos.Cursor := crHandPoint;
    ImageContato.Picture.LoadFromFile(ExtractFilePath(Application.ExeName) + 'Pictures\ContatoPreta.png');
  end;
end;

procedure TFMain.pnlContatosMouseLeave(Sender: TObject);
begin
  if PainelPressionado <> pnlContatos then
  begin
    pnlContatos.BevelOuter := bvNone;
    pnlContatos.Color := $00121212;
    pnlContatos.Cursor := crDefault;
    ImageContato.Picture.LoadFromFile(ExtractFilePath(Application.ExeName) + 'Pictures\ContatoRoxa.png');
  end;
end;

procedure TFMain.pnlFavoritosMouseEnter(Sender: TObject);
begin
  if PainelPressionado <> pnlFavoritos then
  begin
    pnlFavoritos.BevelOuter := bvRaised;
    pnlFavoritos.Color := $00D6498F;
    pnlFavoritos.Cursor := crHandPoint;
    ImageFavoritos.Picture.LoadFromFile(ExtractFilePath(Application.ExeName) + 'Pictures\FavoritosPreta.png');
  end;
end;

procedure TFMain.pnlFavoritosMouseLeave(Sender: TObject);
begin
  if PainelPressionado <> pnlFavoritos then
  begin
    pnlFavoritos.BevelOuter := bvNone;
    pnlFavoritos.Color := $00121212;
    pnlFavoritos.Cursor := crDefault;
    ImageFavoritos.Picture.LoadFromFile(ExtractFilePath(Application.ExeName) + 'Pictures\FavoritosRoxa.png');
  end;
end;

procedure TFMain.pnlEmpresaMouseEnter(Sender: TObject);
begin
  if PainelPressionado <> pnlEmpresa then
  begin
    pnlEmpresa.BevelOuter := bvRaised;
    pnlEmpresa.Color := $00D6498F;
    pnlEmpresa.Cursor := crHandPoint;
    ImageEmpresa.Picture.LoadFromFile(ExtractFilePath(Application.ExeName) + 'Pictures\LogoEmpresaPreta.png');
  end;
end;

procedure TFMain.pnlEmpresaMouseLeave(Sender: TObject);
begin
  if PainelPressionado <> pnlEmpresa then
  begin
    pnlEmpresa.BevelOuter := bvNone;
    pnlEmpresa.Color := $00121212;
    pnlEmpresa.Cursor := crDefault;
    ImageEmpresa.Picture.LoadFromFile(ExtractFilePath(Application.ExeName) + 'Pictures\LogoEmpresaRoxa.png');
  end;
end;

// ----- Evento OnMouseEnter - pnlImportExport
procedure TFMain.pnlImportExportMouseEnter(Sender: TObject);
begin
  if PainelPressionado <> pnlImportExport then
  begin
    pnlImportExport.BevelOuter := bvRaised;
    pnlImportExport.Color := $00D6498F;
    pnlImportExport.Cursor := crHandPoint;
    ImageImpExp.Picture.LoadFromFile(ExtractFilePath(Application.ExeName) + 'Pictures\ImpPreta.png');
  end;
end;

// ----- Evento OnMouseLeave - pnlImportExport
procedure TFMain.pnlImportExportMouseLeave(Sender: TObject);
begin
  if PainelPressionado <> pnlImportExport then
  begin
    pnlImportExport.BevelOuter := bvNone;
    pnlImportExport.Color := $00121212;
    pnlImportExport.Cursor := crDefault;
    ImageImpExp.Picture.LoadFromFile(ExtractFilePath(Application.ExeName) + 'Pictures\ImpRoxa.png');
  end;
end;

procedure TFMain.pnlRelatoriosMouseEnter(Sender: TObject);
begin
  if PainelPressionado <> pnlRelatorios then
  begin
    pnlRelatorios.BevelOuter := bvRaised;
    pnlRelatorios.Color := $00D6498F;
    pnlRelatorios.Cursor := crHandPoint;
    imgRelatorios.Picture.LoadFromFile(ExtractFilePath(Application.ExeName) + 'Pictures\printer3.png');
  end;
end;

// ----- Evento OnMouseLeave - pnlRelatorios
procedure TFMain.pnlRelatoriosMouseLeave(Sender: TObject);
begin
 if PainelPressionado <> pnlRelatorios then
  begin
    pnlRelatorios.BevelOuter := bvNone;
    pnlRelatorios.Color := $00121212;
    pnlRelatorios.Cursor := crDefault;
    imgRelatorios.Picture.LoadFromFile(ExtractFilePath(Application.ExeName) + 'Pictures\printer3.png');
  end;
end;

procedure TFMain.pnlGruposMouseEnter(Sender: TObject);
begin
  if PainelPressionado <> pnlGrupos then
  begin
    pnlGrupos.BevelOuter := bvRaised;
    pnlGrupos.Color := $00D6498F;
    pnlGrupos.Cursor := crHandPoint;
    ImageGrupos.Picture.LoadFromFile(ExtractFilePath(Application.ExeName) + 'Pictures\LogoGruposPreta.png');
  end;
end;

procedure TFMain.pnlGruposMouseLeave(Sender: TObject);
begin
  if PainelPressionado <> pnlGrupos then
  begin
    pnlGrupos.BevelOuter := bvNone;
    pnlGrupos.Color := $00121212;
    pnlGrupos.Cursor := crDefault;
    ImageGrupos.Picture.LoadFromFile(ExtractFilePath(Application.ExeName) + 'Pictures\LogoGruposRoxa.png');
  end;
end;

procedure TFMain.pnlConfiguracaoMouseEnter(Sender: TObject);
begin
  if PainelPressionado <> pnlConfiguracao then
  begin
    pnlConfiguracao.BevelOuter := bvRaised;
    pnlConfiguracao.Color := $00D6498F;
    pnlConfiguracao.Cursor := crHandPoint;
    ImgConfig.Picture.LoadFromFile(ExtractFilePath(Application.ExeName) + 'Pictures\ConfiguracaoPreta.png');
  end;
end;

procedure TFMain.pnlConfiguracaoMouseLeave(Sender: TObject);
begin
  if PainelPressionado <> pnlConfiguracao then
  begin
    pnlConfiguracao.BevelOuter := bvNone;
    pnlConfiguracao.Color := $00121212;
    pnlConfiguracao.Cursor := crDefault;
    ImgConfig.Picture.LoadFromFile(ExtractFilePath(Application.ExeName) + 'Pictures\ConfiguracaoRoxa.png');
  end;
end;

{$ENDREGION}

{$REGION 'Eventos de clique - Contatos'}

procedure TFMain.SpdAdicionarClick(Sender: TObject);
var
  NovoContato: Contatos;
  mensagem : string;
begin
  if not ValidarFormulario then Exit;

  NovoContato := Contatos.Create;
  try
    NovoContato.Nome := Edit1.Text;
    NovoContato.Telefone := Numero.Text;
    NovoContato.Email := Edit2.Text;
    NovoContato.Empresa := Edit3.Text;
    NovoContato.Endereco := txtLogradouro.Text;
    NovoContato.Observacoes := Edit4.Text;
    NovoContato.Favorito := False;
    NovoContato.Ativo := True;

    if ContatosController.AdicionarContato(NovoContato, Mensagem) then
    begin
      ContatosLista.Add(NovoContato);
      AtualizarDBGrid;
      LimparFormulario;
      ShowMessage('Contato adicionado!');
    end
    else
    begin
      NovoContato.Free;
      ShowMessage('Email ou Telefone ja cadastrados');
    end;
  except
    on E: Exception do
    begin
      NovoContato.Free;
      ShowMessage('Erro: ' + E.Message);
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

procedure TFMain.SpdEditarClick(Sender: TObject);
var
Mensagem: String;

begin
  if Editando and (ContatoAtual <> nil) then
  begin
    // Se estamos editando, salva as alterações
    if not ValidarFormulario then Exit;

    ContatoAtual.Nome := Edit1.Text;
    ContatoAtual.Telefone := Numero.Text;
    ContatoAtual.Email := Edit2.Text;
    ContatoAtual.Empresa := Edit3.Text;
    ContatoAtual.Endereco := txtLogradouro.Text;
    ContatoAtual.Observacoes := Edit4.Text;

    if ContatosController.AtualizarContato(ContatoAtual, Mensagem) then
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
  if cdsContatos.State in [dsEdit, dsInsert] then
  begin
    try
      cdsContatos.Post; // dispara AfterPost que você já ligou a SalvarEdicaoGridView
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

procedure TFMain.SpdExcluirClick(Sender: TObject);
var
  Contato: Contatos;
  Mensagem:String;
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
    if ContatosController.AtualizarContato(Contato, Mensagem) then
    begin
      ShowMessage('Contato excluído com sucesso!');
      CarregarContatosDB; // atualiza o grid
    end
    else
      ShowMessage('Erro ao excluir o contato!');
  end;
end;

procedure TFMain.SpdListarClick(Sender: TObject);
begin
  LimparFormulario;
  Editando := False;
  ContatoAtual := nil;
  SpdAdicionar.Enabled := True;

  // FORÇA A ABA DE LISTA
  pgcContatos.ActivePage := tbsContatosList;

  // --- ESTA LINHA QUE CARREGA OS DADOS!
  CarregarContatosDB;

  if dbgContatos.CanFocus then
    dbgContatos.SetFocus;
end;

procedure TFMain.DBGrid2DblClick(Sender: TObject);
begin
  SpdEditarContatosGridClick(Sender);
end;

{$ENDREGION}

{$REGION 'Eventos de clique - Favoritos'}

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

{$ENDREGION}

{$REGION 'Eventos de clique - Empresas'}

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
      pgcEmpresas.ActivePage := tbsEmpresasList;
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
    pgcEmpresas.ActivePage := tbsEmpresasList;
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

procedure TFMain.SpdListarEmpresaClick(Sender: TObject);
begin
  LimparFormularioEmpresa;
  EditandoEmpresa := False;
  SpdAdicionarEmpresa.Enabled := True;
  SpdEditarEmpresa.Caption := 'Editar';

  // FORÇA IR PARA A ABA DO GRID
  pgcEmpresas.ActivePage := tbsEmpresasList;

  // ATUALIZA O GRID AUTOMATICAMENTE
  CarregarEmpresas;
end;


procedure TFMain.DBGrid1DblClick(Sender: TObject);
begin
  if not ClientDataSetEmpresas.IsEmpty then
    SpdEditarEmpresaClick(Sender);
end;

{$ENDREGION}

{$REGION 'Eventos de clique - Grupos'}

procedure TFMain.SpdAdicionarGrupoClick(Sender: TObject);
var
  Grupo: TGrupos;
begin
  // VALIDA NOME (Edit8)
  if Trim(Edit8.Text) = '' then
  begin
    ShowMessage('Digite o nome do grupo!');
    Edit8.SetFocus;
    Exit;
  end;

  Grupo := TGrupos.Create;
  try
    Grupo.setNome(Trim(Edit8.Text));           // NOME
    Grupo.setIdPermissao(GruposController.NivelUsuarioLogado);

    if GruposController.AdicionarGrupo(Grupo) then
    begin
      ShowMessage('Grupo adicionado com sucesso!');
      LimparFormularioGrupo;
      CarregarGrupos;
    end
    else
      ShowMessage('Erro ao adicionar grupo.');
  finally
    Grupo.Free;
  end;
end;


procedure TFMain.SpdEditarGrupoClick(Sender: TObject);
var
  Grupo: TGrupos;
begin
  if not EditandoGrupo then
  begin
    if ClientDataSetGrupos.IsEmpty then
    begin
      ShowMessage('Selecione um grupo para editar!');
      Exit;
    end;

    Edit7.Text := ClientDataSetGrupos.FieldByName('ID').AsString;
    Edit8.Text := ClientDataSetGrupos.FieldByName('NOME').AsString;
    GrupoAtualId := ClientDataSetGrupos.FieldByName('ID').AsInteger;

    EditandoGrupo := True;
    SpdAdicionarGrupo.Enabled := False;
    SpdEditarGrupo.Caption := 'Salvar';
    Exit;
  end;

  // SALVAR
  if Trim(Edit8.Text) = '' then
  begin
    ShowMessage('Nome do grupo obrigatório!');
    Edit8.SetFocus;
    Exit;
  end;

  Grupo := TGrupos.Create;
  try
    Grupo.setId(GrupoAtualId);
    Grupo.setNome(Trim(Edit8.Text));
    Grupo.setIdPermissao(GruposController.NivelUsuarioLogado);

    if GruposController.AtualizarGrupo(Grupo) then
    begin
      ShowMessage('Grupo atualizado!');
      LimparFormularioGrupo;
      CarregarGrupos;
      EditandoGrupo := False;
      SpdAdicionarGrupo.Enabled := True;
      SpdEditarGrupo.Caption := 'Editar';
    end
    else
      ShowMessage('Erro ao atualizar.');
  finally
    Grupo.Free;
  end;
end;


procedure TFMain.SpdExcluirGrupoClick(Sender: TObject);
var
  IdGrupo: Integer;
  NomeGrupo: string;
begin
  if ClientDataSetGrupos.IsEmpty then
  begin
    ShowMessage('Selecione um grupo para excluir!');
    Exit;
  end;

  IdGrupo := ClientDataSetGrupos.FieldByName('ID').AsInteger;
  NomeGrupo := ClientDataSetGrupos.FieldByName('NOME').AsString;

  if MessageDlg(Format('Excluir o grupo "%s"?', [NomeGrupo]),
                mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    if GruposController.ExcluirGrupo(IdGrupo) then
    begin
      ShowMessage('Grupo excluído com sucesso!');
      CarregarGrupos;
    end
    else
      ShowMessage('Erro ao excluir grupo.');
  end;
end;


procedure TFMain.SpdRestaurarGruposClick(Sender: TObject);
var
  IdDigitado: Integer;
  Grupo: TGrupos;
  NomeGrupo: string;
begin
  // 1. SE O EDIT TEM ALGO → RESTAURA POR ID
  if Trim(Edit7.Text) <> '' then
  begin
    // Valida número
    if not TryStrToInt(Edit7.Text, IdDigitado) then
    begin
      ShowMessage('ID inválido! Digite apenas números.');
      Edit7.Color := clRed;
      Edit7.SetFocus;
      Exit;
    end;

    // Valida permissão
    if GruposController.NivelUsuarioLogado < 3 then
    begin
      ShowMessage('Apenas administradores podem restaurar grupos.');
      Exit;
    end;

    // Tenta restaurar
    if not GruposController.RestaurarGrupo(IdDigitado) then
    begin
      ShowMessage('Erro ao restaurar grupo. Verifique o ID.');
      Exit;
    end;

    // Busca o grupo restaurado
    Grupo := GruposController.BuscarGrupoPorId(IdDigitado);
    if Grupo = nil then
    begin
      ShowMessage('Grupo restaurado, mas não encontrado.');
      Exit;
    end;

    // Adiciona no grid
    try
      ClientDataSetGrupos.Append;
      ClientDataSetGrupos.FieldByName('ID').AsInteger := Grupo.getId;
      ClientDataSetGrupos.FieldByName('NOME').AsString := Grupo.getNome;
      ClientDataSetGrupos.Post;

      ShowMessage(Format('Grupo "%s" (ID: %d) restaurado com sucesso!', [Grupo.getNome, Grupo.getId]));
    finally
      Grupo.Free;
    end;

    // Limpa o campo
    Edit7.Clear;
    Edit7.Color := clWindow;
    Exit; // ← SAI AQUI, NÃO FAZ O RESTAURAR DO GRID
  end;

  // 2. SE NÃO TEM ID → RESTAURA O GRUPO SELECIONADO NO GRID (COMPORTAMENTO ORIGINAL)
  if ClientDataSetGrupos.IsEmpty then
  begin
    ShowMessage('Nenhum grupo selecionado para restaurar!');
    Exit;
  end;

  IdDigitado := ClientDataSetGrupos.FieldByName('ID').AsInteger;
  NomeGrupo := ClientDataSetGrupos.FieldByName('NOME').AsString;

  if MessageDlg(Format('Restaurar o grupo "%s" (ID: %d)?', [NomeGrupo, IdDigitado]),
                mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    if GruposController.RestaurarGrupo(IdDigitado) then
    begin
      ShowMessage(Format('Grupo "%s" restaurado com sucesso!', [NomeGrupo]));
      CarregarGrupos; // atualiza tudo
    end
    else
      ShowMessage('Erro ao restaurar grupo.');
  end;
end;

{$ENDREGION}

{$REGION 'Eventos de clique - Permissões '}
procedure TFMain.SpdAdicionarPermClick(Sender: TObject);
begin
  ClientDataSetPermissoes.Append;
  ClientDataSetPermissoes.FieldByName('ID').AsInteger := 0;
  ClientDataSetPermissoes.FieldByName('NOME').AsString := '';
  ClientDataSetPermissoes.FieldByName('DESCRICAO').AsString := '';
  ClientDataSetPermissoes.Post;

  ClientDataSetPermissoes.Edit;
  DBGridPerm.SetFocus;
  DBGridPerm.SelectedField := ClientDataSetPermissoes.FieldByName('NOME');
end;

procedure TFMain.SpdExcluirPermClick(Sender: TObject);
var
  Id: Integer;
  Controller: TPermissoesController;
begin
  if ClientDataSetPermissoes.IsEmpty then
  begin
    ShowMessage('Nenhuma permissão selecionada.');
    Exit;
  end;

  Id := ClientDataSetPermissoes.FieldByName('ID').AsInteger;
  if Id <= 0 then
  begin
    ShowMessage('Não é possível excluir uma permissão não salva.');
    Exit;
  end;

  if MessageDlg('Deseja realmente excluir esta permissão?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    Controller := TPermissoesController.Create;
    try
      if Controller.ExcluirPermissao(Id) then
      begin
        ClientDataSetPermissoes.Delete;
        ShowMessage('Permissão excluída com sucesso!');
      end
      else
        ShowMessage('Erro ao excluir permissão.');
    finally
      Controller.Free;
    end;
  end;
end;

procedure TFMain.SpdEditarPermClick(Sender: TObject);
var
  Perm: TPermissao;
  Ctrl: TPermissoesController;
  Id, NovoId: Integer;
begin
  // VALIDA SE ESTÁ EM EDIÇÃO
  if not (ClientDataSetPermissoes.State in [dsEdit, dsInsert]) then
  begin
    ShowMessage('Nenhuma linha em edição. Clique em Adicionar ou selecione uma linha.');
    Exit;
  end;

  // VALIDA CAMPOS
  if Trim(ClientDataSetPermissoes.FieldByName('NOME').AsString) = '' then
  begin
    ShowMessage('Nome da permissão é obrigatório!');
    DBGridPerm.SelectedField := ClientDataSetPermissoes.FieldByName('NOME');
    Exit;
  end;

  Id := ClientDataSetPermissoes.FieldByName('id_permissao').AsInteger;
  Ctrl := TPermissoesController.Create;
  try
    if Id = 0 then
    begin
      // === NOVO ===
      Perm := TPermissao.Create;
      try
        Perm.setNome(ClientDataSetPermissoes.FieldByName('NOME').AsString);
        Perm.setDescricao(ClientDataSetPermissoes.FieldByName('DESCRICAO').AsString);
        Perm.setNivelRequerido(1);
        Perm.setAtivo(True);

        if Ctrl.AdicionarPermissao(Perm.getNome, Perm.getDescricao, Perm.getNivelRequerido) then
        begin
          NovoId := Ctrl.BuscarPermissaoPorOperacao(Perm.getNome).getId;
          ClientDataSetPermissoes.Edit;
          ClientDataSetPermissoes.FieldByName('id_permissao').AsInteger := NovoId;
          ClientDataSetPermissoes.Post;
          ShowMessage('Permissão adicionada!');
        end
        else
          ShowMessage('Erro ao adicionar.');
      finally
        Perm.Free;
      end;
    end
    else
    begin
      // === EDIÇÃO ===
      if Ctrl.AtualizarPermissao(
        Id,
        ClientDataSetPermissoes.FieldByName('NOME').AsString,
        ClientDataSetPermissoes.FieldByName('DESCRICAO').AsString,
        1,
        True
      ) then
      begin
        ClientDataSetPermissoes.Post;
        ShowMessage('Permissão atualizada!');
      end
      else
        ShowMessage('Erro ao atualizar.');
    end;
  finally
    Ctrl.Free;
  end;


  SpdEditarPerm.Caption := 'Editar';
end;
procedure TFMain.SpdListarPermClick(Sender: TObject);
begin
  CarregarPermissoes;
  EditandoPermissao := False;
  PermissaoAtual := 0;
  ConfigurarDBgridPerm;
end;


{$ENDREGION}

{$REGION 'Busca de CEP (SpeedButton5)'}

procedure TFMain.SpeedButton5Click(Sender: TObject);
var
  cep, url: string;                 // Variáveis para CEP e URL da API
  http: THTTPClient;                // Cliente HTTP usado na requisição
  resp: IHTTPResponse;              // Resposta da API
  json: string;                     // Texto JSON obtido da resposta
  jo: TJSONObject;                  // Objeto JSON para leitura
  logradouro, bairro, cidade, uf: string;
begin
  // ---------------------------------------------------------
  // 0) LIMPAR TODOS OS CAMPOS ANTES DE UMA NOVA PESQUISA
  // ---------------------------------------------------------
  txtLogradouro.Clear;
  txtBairro.Clear;
  txtLocalidade.Clear;
  txtUF.Clear;
  txtComplemento.Clear;  // também limpar!
  txtNumero.Clear;       // também limpar!

  // ---------------------------------------------------------
  // 1) LER O CEP DIGITADO PELO USUÁRIO
  // ---------------------------------------------------------
  cep := Trim(txtCEP.Text);         // Remove espaços extras

  // Padronizar removendo caracteres inválidos
  cep := StringReplace(cep, '-', '', [rfReplaceAll]);
  cep := StringReplace(cep, '.', '', [rfReplaceAll]);
  cep := StringReplace(cep, ' ', '', [rfReplaceAll]);

  // Verificar se o campo ficou vazio
  if cep = '' then
  begin
    ShowMessage('Digite um CEP.');
    Exit;
  end;

  // ---------------------------------------------------------
  // 2) MONTAR A URL PARA CONSULTAR A API
  // ---------------------------------------------------------
  url := Format('https://viacep.com.br/ws/%s/json/', [cep]);

  // Criar o cliente HTTP
  http := THTTPClient.Create;
  try
    try
      // -----------------------------------------------------
      // 3) FAZER A REQUISIÇÃO PARA A API
      // -----------------------------------------------------
      resp := http.Get(url);

      // Conferir se retornou HTTP 200 (OK)
      if resp.StatusCode <> 200 then
      begin
        ShowMessage('Erro ao consultar CEP. Código HTTP: ' +
                    resp.StatusCode.ToString);
        Exit;
      end;

      // Converter conteúdo retornado para JSON string
      json := resp.ContentAsString(TEncoding.UTF8);

      // -----------------------------------------------------
      // 4) PARSE DO JSON → TJSONObject
      // -----------------------------------------------------
      jo := TJSONObject.ParseJSONValue(json) as TJSONObject;
      try
        // Verificar se o CEP existe (API traz "erro": true)
        if (jo = nil) or (jo.GetValue('erro') <> nil) then
        begin
          ShowMessage('CEP não encontrado.');
          Exit;
        end;

        // ---------------------------------------------------
        // 5) EXTRAIR OS CAMPOS DO JSON
        // ---------------------------------------------------
        logradouro := jo.GetValue<string>('logradouro', '');
        bairro     := jo.GetValue<string>('bairro', '');
        cidade     := jo.GetValue<string>('localidade', '');
        uf         := jo.GetValue<string>('uf', '');

        // ---------------------------------------------------
        // 6) PREENCHER OS EDITS DO FORMULÁRIO
        // ---------------------------------------------------
        txtlogradouro.Text := logradouro;
        txtBairro.Text     := bairro;
        txtLocalidade.Text := cidade;
        txtUF.Text         := uf;

        // IMPORTANTE:
        // txtComplemento e txtNumero continuam vazios,
        // pois devem ser preenchidos MANUALMENTE pelo usuário.

      finally
        jo.Free; // liberar memória
      end;

    except
      on E: Exception do
        ShowMessage('Erro ao consultar CEP: ' + E.Message);
    end;

  finally
    http.Free; // liberar cliente HTTP
  end;
end;

{$ENDREGION}

{$REGION 'Importação de contatos .VCF (MemTable e Grid4)'}

// ----- Importacao VCF
procedure TFMain.PrepareMemTable;
begin
  mtbImportCont.Active := False;
  mtbImportCont.FieldDefs.Clear;
  mtbImportCont.FieldDefs.Add('NOME',     ftString, 200);
  mtbImportCont.FieldDefs.Add('EMAIL',    ftString, 200);
  mtbImportCont.FieldDefs.Add('TELEFONE', ftString, 50);
  mtbImportCont.CreateDataSet;
end;

procedure TFMain.ConfigurarGrid;
begin
  // ligações
  dsImportCont.DataSet := mtbImportCont;
  dbgImportCont.DataSource  := dsImportCont;

  // edição habilitada
  dsImportCont.AutoEdit := True;
  mtbImportCont.ReadOnly := False;
  dbgImportCont.Options := DBGrid1.Options + [dgEditing, dgTitles, dgColLines, dgRowLines, dgIndicator];

  // colunas
  dbgImportCont.Columns.BeginUpdate;
  try
    dbgImportCont.Columns.Clear;

    with dbgImportCont.Columns.Add do
    begin
      FieldName := 'NOME';
      Title.Caption := 'Nome';
      Width := 200;
    end;

    with dbgImportCont.Columns.Add do
    begin
      FieldName := 'EMAIL';
      Title.Caption := 'E-mail';
      Width := 250;
    end;

    with dbgImportCont.Columns.Add do
    begin
      FieldName := 'TELEFONE';
      Title.Caption := 'Telefone';
      Width := 120;
    end;
  finally
    dbgImportCont.Columns.EndUpdate;
  end;
end;

procedure TFMain.spdImpContatosClick(Sender: TObject);
var
  Total: Integer;
begin
  if not OpenDialog1.Execute then
    Exit;

  memImportCont.Clear;
  Total := 0;

  if not mtbImportCont.Active then
    PrepareMemTable
  else
    mtbImportCont.EmptyDataSet;

  mtbImportCont.DisableControls;
  try
    ImportarVCardSimples(OpenDialog1.FileName,
      procedure(const C: TContato)
      begin
        Inc(Total);
        memImportCont.Lines.Add('Nome: ' + C.Nome);
        if C.Email <> '' then memImportCont.Lines.Add('Email: ' + C.Email);
        if C.Telefone <> '' then memImportCont.Lines.Add('Telefone: ' + C.Telefone);
        memImportCont.Lines.Add('-----------------------------');
        mtbImportCont.AppendRecord([C.Nome, C.Email, C.Telefone]);
      end);
  finally
    mtbImportCont.EnableControls;
  end;

  memImportCont.Lines.Add('');
  memImportCont.Lines.Add('Total de contatos importados do arquivo: ' + Total.ToString);
end;

procedure TFMain.sdbImpNovoClick(Sender: TObject);
begin
  mtbImportCont.Append;
  DBGrid1.SelectedIndex := 0;
  DBGrid1.SetFocus;
end;

procedure TFMain.spdImpExcluirClick(Sender: TObject);
begin
  if (mtbImportCont.Active) and (not mtbImportCont.IsEmpty) then
    if MessageDlg('Excluir o contato selecionado?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
      mtbImportCont.Delete;
end;

procedure TFMain.spdImprimirClick(Sender: TObject);
begin
  // 1. Garante que a conexão está aberta
  if not FDConnRel.Connected then
    FDConnRel.Connected := True;

  // ---------- Relatório de Contatos - Ordenado por Nome ----------
  if RadioButton1.Checked then
  begin
    qryRelContatos.Close;
    qryRelContatos.SQL.Text :=
      'SELECT id_contato, nome, telefone, email ' +
      'FROM "Contato" ' +
      'ORDER BY nome ASC';
    qryRelContatos.Open;

    // Dataset usado pelo FastReport deste relatório
    frxDBDados.DataSet := qryRelContatos;

    frxReportContatosNome.PrepareReport;
    frxReportContatosNome.ShowReport;
    Exit;
  end;

  // ---------- Relatório de Contatos - Ordenado por Número Telefônico ----------
  if RadioButton2.Checked then
  begin
    qryRelContatos.Close;
    qryRelContatos.SQL.Text :=
      'SELECT id_contato, nome, telefone, email ' +
      'FROM "Contato" ' +
      'ORDER BY telefone ASC';
    qryRelContatos.Open;

    // Continua usando o mesmo frxDBDados (contatos)
    frxDBDados.DataSet := qryRelContatos;

    frxReportContatosTelefone.PrepareReport;
    frxReportContatosTelefone.ShowReport;
    Exit;
  end;

// ---------- Relatório de Usuários - Ordenado por Nome ----------
if RadioButton3.Checked then
begin
  if not FDConnRel.Connected then
    FDConnRel.Connected := True;

  qryRelUsuarios.Close;
  qryRelUsuarios.SQL.Text :=
    'SELECT  id_usuario, '  +
    '        nome, '        +
    '        email, '       +
    '        criado_em, '   +
    '        atualizado_em, '+
    '        ativo, '       +
    '        telefone '     +
    'FROM "Usuario" '       +
    'ORDER BY nome ASC';
  qryRelUsuarios.Open;

  frxReportUsuariosNome.PrepareReport;
  frxReportUsuariosNome.ShowReport;
  Exit;
end;


  // Nenhum marcado
  ShowMessage('Selecione um relatório para imprimir!');
end;







procedure TFMain.spdImpSalvarDBClick(Sender: TObject);
var
  Controller: TVCardController;
begin
  if mtbImportCont.IsEmpty then
  begin
    ShowMessage('Nenhum contato para salvar.');
    Exit;
  end;

  Controller := TVCardController.Create;
  try
    try
      // Agora é procedure → não retorna nada
      Controller.SalvarNoBanco(mtbImportCont, DataModule1.FDConnection1);

      // A mensagem já é exibida DENTRO do controller
      memImportCont.Lines.Add('Contatos salvos com sucesso (ver mensagem acima).');
    except
      on E: Exception do
      begin
        ShowMessage('ERRO ao salvar: ' + E.Message);
        memImportCont.Lines.Add('ERRO: ' + E.Message);
      end;
    end;
  finally
    Controller.Free;
  end;
end;

{$ENDREGION}

end.

