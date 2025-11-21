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
  frCoreClasses, frxDBSet, TUsuarioModel,UsuarioController;

type
  TFMain = class(TForm)
    Fundo: TImage;
    Panel1: TPanel;
    Logo: TImage;
    pnlContatos: TPanel;
    ImageContato: TImage;
    pnlUsuarios: TPanel;
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
    crdUsuarios: TCard;
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
    SpdAdicionar: TSpeedButton;
    Bevel3: TBevel;
    Panel7: TPanel;
    SpdEditarContatosGrid: TSpeedButton;
    SpdExcluir: TSpeedButton;
    SpdListar: TSpeedButton;
    dbgContatos: TDBGrid;
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
    SpdAdicionarGrupo: TSpeedButton;
    SpdExcluirGrupo: TSpeedButton;
    SpdEditarGrupo: TSpeedButton;
    SpdRestaurarGrupos: TSpeedButton;
    Bevel9: TBevel;
    Bevel7: TBevel;
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
    pgcUsuarios: TPageControl;
    tbsUsuarios: TTabSheet;
    Panel11: TPanel;
    Panel12: TPanel;
    Label18: TLabel;
    Bevel8: TBevel;
    Bevel10: TBevel;
    spdUsuarioAdicionar: TSpeedButton;
    spdExcluirUsuario: TSpeedButton;
    spdEditarUsuario: TSpeedButton;
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
    qryRelUsuarios: TFDQuery;
    frxDBUsuarios: TfrxDBDataset;
    edtIdUsuario: TEdit;
    pgcFavoritos: TPageControl;
    tbsFavoritosCad: TTabSheet;
    Panel5: TPanel;
    Panel6: TPanel;
    Label5: TLabel;
    SpdAdicionarFavorito: TSpeedButton;
    SpdRemoverFavorito: TSpeedButton;
    ComboBoxContatos: TComboBox;
    DBGridFavoritos: TDBGrid;
    Label19: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    edtNomeUsuario: TEdit;
    edtUsuarioEmail: TEdit;
    edtCriadoEm: TEdit;
    edtAtualizadoEm: TEdit;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    rdbUsuarioN1: TRadioButton;
    rdbUsuarioN2: TRadioButton;
    rdbUsuarioN3: TRadioButton;
    rdbUsuarioAtivo: TRadioButton;
    rdbUsuarioInativo: TRadioButton;
    qryUsuarioCRUD: TFDQuery;
    edtUsuarioSenha: TEdit;
    Label25: TLabel;
    Label26: TLabel;
    ComboBox: TComboBox;
    Cadastrar: TGroupBox;
    Edit7: TEdit;
    Label17: TLabel;
    Edit8: TEdit;
    Label16: TLabel;
    GroupBox3: TGroupBox;
    rdbGrupoAtivo: TRadioButton;
    rdbGrupoInativo: TRadioButton;
    DBGridPerm: TDBGrid;
    edmUsuarioTelefone: TMaskEdit;

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
    procedure pnlUsuariosMouseEnter(Sender: TObject);
    procedure pnlUsuariosMouseLeave(Sender: TObject);
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
    procedure spdUsuarioAdicionarClick(Sender: TObject);
    procedure ComboBoxChange(Sender: TObject);
    procedure SpdExcluirGrupoClick(Sender: TObject);
    procedure spdExcluirUsuarioClick(Sender: TObject);
    procedure spdEditarUsuarioClick(Sender: TObject);

  private
    Editando: Boolean;
    ContatoAtual: Contatos;
    ContatosLista: TObjectList<Contatos>;
    ContatosController: TContatosController;
    FavoritosController: TFavoritosController;
    ClientDataSetFavoritos: TClientDataSet;
    DataSourceFavoritos: TDataSource;
    LoadingDataset: Boolean;

    // === USUÁRIOS - VARIÁVEIS OBRIGATÓRIAS ===
    UsuariosController: TUsuarioController;
    LoadingUsuarios: Boolean;
    EditandoUsuario: Boolean;
    UsuarioAtual: TUsuario;
    DataSourceUsuarios: TDataSource;
    ClientDataSetUsuarios: TClientDataSet;

    // === EMPRESAS ===
    EditandoEmpresa: Boolean;
    EmpresaAtual: TEmpresa;
    EmpresasController: TEmpresaController;
    ClientDataSetEmpresas: TClientDataSet;
    DataSourceEmpresas: TDataSource;
    LoadingDatasetEmpresas: Boolean;
    EmpresaSelecionadaId: Integer;

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
    procedure LimparFormularioGrupo;
    function  ValidarFormularioGrupo: Boolean;

    // Métodos privados do CRUD de usuários
    procedure ConfigurarDBGridUsuarios;
    procedure CarregarUsuariosNoGrid;
    procedure LimparCamposUsuario;
    procedure PreencherCamposUsuario(AUsuario: TUsuario);
    function UsuarioSelecionado: TUsuario;

    procedure CarregarEmpresasNoComboBox;

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

  // --- Desarma o qryUsuarioCRUD para não dar erro de comando vazio ---
  qryUsuarioCRUD.Close;
  qryUsuarioCRUD.SQL.Clear;
  qryUsuarioCRUD.SQL.Text := 'SELECT 1';  // comando simples só pra evitar erro
  // deixamos Active = False; ele só será usado se você configurar depois

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

  // ===== USUÁRIOS =====
  UsuariosController := TUsuarioController.Create(DataModule1.FDConnection1);

  ClientDataSetUsuarios := TClientDataSet.Create(Self);
  DataSourceUsuarios    := TDataSource.Create(Self);
  DataSourceUsuarios.DataSet := ClientDataSetUsuarios;
  DBGridPerm.DataSource := DataSourceUsuarios;

  ConfigurarDBGridUsuarios;  // define campos e colunas
  CarregarUsuariosNoGrid;    // traz os dados do banco

  EmpresasController := TEmpresaController.Create;
  ClientDataSetEmpresas := TClientDataSet.Create(Self);
  DataSourceEmpresas := TDataSource.Create(Self);
  DBGrid1.DataSource := DataSourceEmpresas;
  ConfigurarDBGridEmpresas;
  CarregarEmpresasNoComboBox;

  // --- GRUPOS ---
  GruposController := TGruposController.Create(3); // 3 = Admin (seu padrão)

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
  FreeAndNil(UsuarioAtual);
  FreeAndNil(UsuariosController);
  FreeAndNil(ClientDataSetUsuarios);
  FreeAndNil(DataSourceUsuarios);

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

    pnlUsuarios.Margins.Top := 20;
    pnlUsuarios.Font.Size := 18;
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

procedure TFMain.ComboBoxChange(Sender: TObject);
begin
  if ComboBox.ItemIndex = -1 then
    Exit;

  EmpresaSelecionadaId :=
    Integer(ComboBox.Items.Objects[ComboBox.ItemIndex]);
end;

procedure TFMain.ConfigurarDBGrid;
begin
  cdsContatos.Close;
  cdsContatos.FieldDefs.Clear;

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

  dsContatos.DataSet := cdsContatos;
  dbgContatos.DataSource := dsContatos;

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

  cdsContatos.AfterPost := SalvarEdicaoGridView;
  cdsContatos.AfterDelete := ConfirmarExclusaoGrid;

  if not cdsContatos.Active then
    cdsContatos.Open;
end;

procedure TFMain.ConfigurarDBGridEmpresas;
begin
  DataSourceEmpresas.DataSet := ClientDataSetEmpresas;
  DBGrid1.DataSource := DataSourceEmpresas;

  ClientDataSetEmpresas.Close;
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

  ClientDataSetEmpresas.AfterPost := SalvarEdicaoEmpresaGrid;

  DBGrid1.Options := DBGrid1.Options + [dgEditing, dgAlwaysShowEditor];
  DBGrid1.Visible := True;
end;

procedure TFMain.ConfigurarDBGridFavoritos;
begin
  DataSourceFavoritos.DataSet := ClientDataSetFavoritos;
  DBGridFavoritos.DataSource := DataSourceFavoritos;
  ClientDataSetFavoritos.Close;
  ClientDataSetFavoritos.FieldDefs.Clear;

  ClientDataSetFavoritos.FieldDefs.Add('ID_FAVORITO', ftInteger);
  ClientDataSetFavoritos.FieldDefs.Add('ID', ftInteger);
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
    Visible := False;
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
  DBGridFavoritos.ReadOnly := True;
end;

procedure TFMain.ConfigurarDBGridGrupos;
begin
  DataSourceGrupos.DataSet := ClientDataSetGrupos;
  DBGridGrupos.DataSource := DataSourceGrupos;

  ClientDataSetGrupos.Close;
  ClientDataSetGrupos.FieldDefs.Clear;
  ClientDataSetGrupos.FieldDefs.Add('id_grupo', ftInteger);
  ClientDataSetGrupos.FieldDefs.Add('nome', ftString, 100);
  ClientDataSetGrupos.FieldDefs.Add('ativo', ftBoolean);
  ClientDataSetGrupos.CreateDataSet;
  ClientDataSetGrupos.Open;

  DBGridGrupos.Columns.Clear;

  with DBGridGrupos.Columns.Add do
  begin
    FieldName := 'id_grupo';
    Title.Caption := 'ID';
    Width := 60;
  end;

  with DBGridGrupos.Columns.Add do
  begin
    FieldName := 'nome';
    Title.Caption := 'NOME DO GRUPO';
    Width := 300;
  end;

  with DBGridGrupos.Columns.Add do
  begin
    FieldName := 'ativo';
    Title.Caption := 'Ativo';
    Width := 60;
  end;

  DBGridGrupos.Options := [
    dgTitles, dgIndicator, dgColumnResize,
    dgColLines, dgRowLines, dgTabs, dgRowSelect
  ];
  DBGridGrupos.ReadOnly := True;
end;

procedure TFMain.ConfigurarDBGridUsuarios;
begin
  ClientDataSetUsuarios.Close;
  ClientDataSetUsuarios.FieldDefs.Clear;

  ClientDataSetUsuarios.FieldDefs.Add('id_usuario',    ftInteger);
  ClientDataSetUsuarios.FieldDefs.Add('nome',          ftString, 100);
  ClientDataSetUsuarios.FieldDefs.Add('email',         ftString, 150);
  ClientDataSetUsuarios.FieldDefs.Add('telefone',      ftString, 20);
  ClientDataSetUsuarios.FieldDefs.Add('nivel_usuario', ftInteger);
  ClientDataSetUsuarios.FieldDefs.Add('ativo',         ftBoolean);
  ClientDataSetUsuarios.FieldDefs.Add('criado_em',     ftDateTime);
  ClientDataSetUsuarios.FieldDefs.Add('atualizado_em', ftDateTime);

  ClientDataSetUsuarios.CreateDataSet;
  ClientDataSetUsuarios.Open;

  DataSourceUsuarios.DataSet := ClientDataSetUsuarios;
  DBGridPerm.DataSource      := DataSourceUsuarios;

  DBGridPerm.Columns.Clear;

  with DBGridPerm.Columns.Add do
  begin
    FieldName := 'id_usuario';
    Title.Caption := 'ID';
    Width := 50;
  end;

  with DBGridPerm.Columns.Add do
  begin
    FieldName := 'nome';
    Title.Caption := 'Nome';
    Width := 180;
  end;

  with DBGridPerm.Columns.Add do
  begin
    FieldName := 'email';
    Title.Caption := 'E-mail';
    Width := 180;
  end;

  with DBGridPerm.Columns.Add do
  begin
    FieldName := 'telefone';
    Title.Caption := 'Telefone';
    Width := 100;
  end;

  with DBGridPerm.Columns.Add do
  begin
    FieldName := 'nivel_usuario';
    Title.Caption := 'Nível';
    Width := 60;
  end;

  with DBGridPerm.Columns.Add do
  begin
    FieldName := 'ativo';
    Title.Caption := 'Ativo';
    Width := 50;
  end;

  DBGridPerm.Options :=
    [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines,
     dgTabs, dgRowSelect];
  DBGridPerm.ReadOnly := True;
end;

{$ENDREGION}

{$REGION 'Carregamento e atualização de dados (Contatos, Empresas, Favoritos, Grupos)'}

procedure TFMain.CarregarContatosDB;
begin
  ContatosLista.Clear;
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
      if ClientDataSetEmpresas.Active then
        ClientDataSetEmpresas.EmptyDataSet
      else
        ClientDataSetEmpresas.Open;

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
  FavoritosController.CarregarFavoritos(ClientDataSetFavoritos);
  DBGridFavoritos.Refresh;
end;

procedure TFMain.CarregarGrupos;
var
  Lista: TObjectList<TGrupos>;
  G: TGrupos;
begin
  if LoadingGrupos then
    Exit;

  LoadingGrupos := True;
  ClientDataSetGrupos.DisableControls;
  try
    ClientDataSetGrupos.EmptyDataSet;

    Lista := GruposController.ListarGrupos;
    try
      for G in Lista do
      begin
        ClientDataSetGrupos.Append;
        ClientDataSetGrupos.FieldByName('id_grupo').AsInteger := G.getId;
        ClientDataSetGrupos.FieldByName('nome').AsString      := G.getNome;
        ClientDataSetGrupos.FieldByName('ativo').AsBoolean    := G.getAtivo;
        ClientDataSetGrupos.Post;
      end;
    finally
      Lista.Free;
    end;
  finally
    ClientDataSetGrupos.EnableControls;
    LoadingGrupos := False;
  end;
end;

procedure TFMain.AtualizarDBGrid;
begin
  if not cdsContatos.Active then
    cdsContatos.Open;

  LoadingDataset := True;
  cdsContatos.DisableControls;
  try
    cdsContatos.EmptyDataSet;

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

procedure TFMain.CarregarEmpresasNoComboBox;
var
  Lista: TObjectList<TEmpresa>;
  Emp: TEmpresa;
begin
  ComboBox.Clear;

  Lista := EmpresasController.ListarEmpresas;
  try
    for Emp in Lista do
    begin
      ComboBox.Items.AddObject(
        Emp.getNome,
        TObject(Emp.getCodigo)
      );
    end;
  finally
    Lista.Free;
  end;
end;

procedure TFMain.CarregarUsuariosNoGrid;
var
  Q: TFDQuery;
begin
  if UsuariosController = nil then
    Exit;

  LoadingUsuarios := True;
  ClientDataSetUsuarios.DisableControls;
  try
    ClientDataSetUsuarios.EmptyDataSet;

    Q := UsuariosController.ListarUsuarios;
    try
      while not Q.Eof do
      begin
        ClientDataSetUsuarios.Append;
        ClientDataSetUsuarios.FieldByName('id_usuario').AsInteger    := Q.FieldByName('id_usuario').AsInteger;
        ClientDataSetUsuarios.FieldByName('nome').AsString           := Q.FieldByName('nome').AsString;
        ClientDataSetUsuarios.FieldByName('email').AsString          := Q.FieldByName('email').AsString;
        ClientDataSetUsuarios.FieldByName('telefone').AsString       := Q.FieldByName('telefone').AsString;
        ClientDataSetUsuarios.FieldByName('nivel_usuario').AsInteger := Q.FieldByName('nivel_usuario').AsInteger;
        ClientDataSetUsuarios.FieldByName('ativo').AsBoolean         := Q.FieldByName('ativo').AsBoolean;

        if Q.FieldByName('criado_em').IsNull then
          ClientDataSetUsuarios.FieldByName('criado_em').Clear
        else
          ClientDataSetUsuarios.FieldByName('criado_em').AsDateTime :=
            Q.FieldByName('criado_em').AsDateTime;

        if Q.FieldByName('atualizado_em').IsNull then
          ClientDataSetUsuarios.FieldByName('atualizado_em').Clear
        else
          ClientDataSetUsuarios.FieldByName('atualizado_em').AsDateTime :=
            Q.FieldByName('atualizado_em').AsDateTime;

        ClientDataSetUsuarios.Post;
        Q.Next;
      end;
    finally
      Q.Free;
    end;
  finally
    ClientDataSetUsuarios.EnableControls;
    LoadingUsuarios := False;
  end;
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
      CarregarEmpresas;
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

    if not ContatosController.AtualizarContato(Contato, Mensagem) then
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

{$ENDREGION}

{$REGION 'CRUD - Usuarios'}

procedure TFMain.spdUsuarioAdicionarClick(Sender: TObject);
var
  Nivel: Integer;
  Ativo: Boolean;
  Permissoes: TList<Integer>;
  IdChamada: Integer;
  DataHoraAtual: string;
begin
  // ======= VALIDAÇÕES =======
  if Trim(edtNomeUsuario.Text) = '' then
  begin
    ShowMessage('Informe o nome do usuário.');
    edtNomeUsuario.SetFocus;
    Exit;
  end;

  if Trim(edtUsuarioEmail.Text) = '' then
  begin
    ShowMessage('Informe o e-mail.');
    edtUsuarioEmail.SetFocus;
    Exit;
  end;

  // Senha obrigatória APENAS para novo usuário
  if (not EditandoUsuario) and (Trim(edtUsuarioSenha.Text) = '') then
  begin
    ShowMessage('Informe a senha.');
    edtUsuarioSenha.SetFocus;
    Exit;
  end;

  // Nível
  if rdbUsuarioN1.Checked then
    Nivel := 1
  else if rdbUsuarioN2.Checked then
    Nivel := 2
  else if rdbUsuarioN3.Checked then
    Nivel := 3
  else
  begin
    ShowMessage('Selecione o nível do usuário.');
    Exit;
  end;

  // Status
  Ativo := rdbUsuarioAtivo.Checked;

  // ======= DATA/HORA VISUAL =======
  DataHoraAtual := FormatDateTime('dd/mm/yyyy HH:nn', Now);

  if not EditandoUsuario then
  begin
    // Novo usuário: criado_em e atualizado_em iguais
    edtCriadoEm.Text     := DataHoraAtual;
    edtAtualizadoEm.Text := DataHoraAtual;
  end
  else
  begin
    // Edição: só atualizamos o "atualizado_em" visual
    edtAtualizadoEm.Text := DataHoraAtual;
  end;

  // ======= DEFINE SE É INSERT (0) OU UPDATE (ID) =======
  if EditandoUsuario then
    IdChamada := StrToIntDef(edtIdUsuario.Text, 0)
  else
    IdChamada := 0;

  // (por enquanto não usamos permissões)
  Permissoes := TList<Integer>.Create;
  try
    if UsuariosController.SalvarUsuario(
         IdChamada,
         Trim(edtNomeUsuario.Text),
         Trim(edtUsuarioEmail.Text),
         Trim(edtUsuarioSenha.Text),
         Trim(edmUsuarioTelefone.Text),
         Nivel,
         Ativo,
         Permissoes
       ) then
    begin
      ShowMessage('Usuário salvo com sucesso!');
      LimparCamposUsuario;
      CarregarUsuariosNoGrid;
    end
    else
      ShowMessage('Erro ao salvar usuário.');
  finally
    Permissoes.Free;
  end;
end;



procedure TFMain.LimparCamposUsuario;
begin
  edtIdUsuario.Clear;
  edtNomeUsuario.Clear;
  edtUsuarioEmail.Clear;
  edtUsuarioSenha.Clear;
  edmUsuarioTelefone.Clear;

  edtCriadoEm.Clear;
  edtAtualizadoEm.Clear;

  rdbUsuarioN1.Checked := False;
  rdbUsuarioN2.Checked := False;
  rdbUsuarioN3.Checked := False;

  rdbUsuarioAtivo.Checked   := True;
  rdbUsuarioInativo.Checked := False;

  EditandoUsuario := False;

  spdEditarUsuario.Caption := 'Editar';
  spdUsuarioAdicionar.Enabled := True;
end;



procedure TFMain.spdEditarUsuarioClick(Sender: TObject);
var
  Nivel: Integer;
begin
  // ===== PRIMEIRO CLIQUE: ENTRAR EM MODO EDIÇÃO =====
  if not EditandoUsuario then
  begin
    if (not ClientDataSetUsuarios.Active) or ClientDataSetUsuarios.IsEmpty then
    begin
      ShowMessage('Nenhum usuário selecionado para editar.');
      Exit;
    end;

    // Carrega dados nos campos
    edtIdUsuario.Text       := ClientDataSetUsuarios.FieldByName('id_usuario').AsString;
    edtNomeUsuario.Text     := ClientDataSetUsuarios.FieldByName('nome').AsString;
    edtUsuarioEmail.Text    := ClientDataSetUsuarios.FieldByName('email').AsString;

    edmUsuarioTelefone.Text :=
      ClientDataSetUsuarios.FieldByName('telefone').AsString;

    // Datas
    if ClientDataSetUsuarios.FindField('criado_em') <> nil then
      edtCriadoEm.Text := ClientDataSetUsuarios.FieldByName('criado_em').AsString;

    if ClientDataSetUsuarios.FindField('atualizado_em') <> nil then
      edtAtualizadoEm.Text := ClientDataSetUsuarios.FieldByName('atualizado_em').AsString;

    // Nunca traz a senha (senha_hash)
    edtUsuarioSenha.Clear;

    // Nível
    Nivel := ClientDataSetUsuarios.FieldByName('nivel_usuario').AsInteger;
    rdbUsuarioN1.Checked := (Nivel = 1);
    rdbUsuarioN2.Checked := (Nivel = 2);
    rdbUsuarioN3.Checked := (Nivel = 3);

    // Ativo
    if ClientDataSetUsuarios.FieldByName('ativo').AsBoolean then
      rdbUsuarioAtivo.Checked := True
    else
      rdbUsuarioInativo.Checked := True;

    // Marca edição
    EditandoUsuario := True;

    // Ajusta botões
    spdEditarUsuario.Caption := 'Salvar';
    spdUsuarioAdicionar.Enabled := False;

    Exit; // Para aqui — ainda não salva
  end;

  // ===== SEGUNDO CLIQUE: SALVAR =====
  spdUsuarioAdicionarClick(Sender);
end;


procedure TFMain.spdExcluirUsuarioClick(Sender: TObject);
var
  Id: Integer;
  Msg: string;
  Nome: string;
begin
  if (not ClientDataSetUsuarios.Active) or ClientDataSetUsuarios.IsEmpty then
  begin
    ShowMessage('Nenhum usuário selecionado para excluir.');
    Exit;
  end;

  Id   := ClientDataSetUsuarios.FieldByName('id_usuario').AsInteger;
  Nome := ClientDataSetUsuarios.FieldByName('nome').AsString;

  Msg := Format('Deseja realmente excluir o usuário %d - %s?', [Id, Nome]);
  if MessageDlg(Msg, mtConfirmation, [mbYes, mbNo], 0) <> mrYes then
    Exit;

  try
    if UsuariosController.ExcluirUsuario(Id) then
    begin
      ShowMessage('Usuário excluído com sucesso.');
      LimparCamposUsuario;
      CarregarUsuariosNoGrid;
    end
    else
      ShowMessage('Não foi possível excluir o usuário.');
  except
    on E: Exception do
      ShowMessage('Erro ao excluir usuário: ' + E.Message);
  end;
end;

{$ENDREGION}

{$REGION 'Validação e helpers de formulário'}

function TFMain.ValidarFormulario: Boolean;
begin
  Result := False;

  if Trim(Edit1.Text) = '' then
  begin
    ShowMessage('Digite o nome!');
    Exit;
  end;

  if Trim(Numero.Text) = '' then
  begin
    ShowMessage('Digite o telefone!');
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

procedure TFMain.PreencherCamposUsuario(AUsuario: TUsuario);
begin
  if AUsuario = nil then
    Exit;

  edtIdUsuario.Text       := AUsuario.Id.ToString;
  edtNomeUsuario.Text     := AUsuario.Nome;
  edtUsuarioEmail.Text    := AUsuario.Email;
  edmUsuarioTelefone.Text := AUsuario.Telefone;

  edtUsuarioSenha.Clear;

  rdbUsuarioN1.Checked := AUsuario.NivelUsuario = 1;
  rdbUsuarioN2.Checked := AUsuario.NivelUsuario = 2;
  rdbUsuarioN3.Checked := AUsuario.NivelUsuario = 3;

  rdbUsuarioAtivo.Checked   := AUsuario.Ativo;
  rdbUsuarioInativo.Checked := not AUsuario.Ativo;

  if AUsuario.CriadoEm <> 0 then
    edtCriadoEm.Text := DateTimeToStr(AUsuario.CriadoEm)
  else
    edtCriadoEm.Clear;

  if AUsuario.AtualizadoEm <> 0 then
    edtAtualizadoEm.Text := DateTimeToStr(AUsuario.AtualizadoEm)
  else
    edtAtualizadoEm.Clear;
end;

procedure TFMain.PreencherFormulario(Contato: Contatos);
begin
  if Contato <> nil then
  begin
    Edit1.Text := Contato.Nome;
    Numero.Text := Contato.Telefone;
    Edit2.Text := Contato.Email;
    txtLogradouro.Text := Contato.Endereco;
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
  txtLogradouro.Text := '';
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
  Edit7.Clear;
  Edit8.Clear;

  rdbGrupoAtivo.Checked := True;
  rdbGrupoInativo.Checked := False;

  GrupoAtualId := 0;
  EditandoGrupo := False;

  SpdEditarGrupo.Caption := 'Editar Grupo';
end;

function TFMain.ValidarFormularioGrupo: Boolean;
begin
  Result := False;

  if Trim(Edit8.Text) = '' then
  begin
    ShowMessage('Informe o nome do grupo.');
    Edit8.SetFocus;
    Exit;
  end;

  Result := True;
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
  pgcImpExp.Visible := True;
  pgcImpExp.ActivePage := tbsImport;
end;

procedure TFMain.PanelConfiguraçaoClick(Sender: TObject);
begin
  AtivarPainel(pnlUsuarios);
  CardPanel1.ActiveCard := crdUsuarios;
  crdUsuarios.Visible := True;
  pgcUsuarios.Visible := True;
  pgcUsuarios.ActivePage := tbsUsuarios;
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
  crdUsuarios.Visible := True;

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

procedure TFMain.pnlUsuariosMouseEnter(Sender: TObject);
begin
  if PainelPressionado <> pnlUsuarios then
  begin
    pnlUsuarios.BevelOuter := bvRaised;
    pnlUsuarios.Color := $00D6498F;
    pnlUsuarios.Cursor := crHandPoint;
    ImgConfig.Picture.LoadFromFile(ExtractFilePath(Application.ExeName) + 'Pictures\icon_usuario_2.png');
  end;
end;

procedure TFMain.pnlUsuariosMouseLeave(Sender: TObject);
begin
  if PainelPressionado <> pnlUsuarios then
  begin
    pnlUsuarios.BevelOuter := bvNone;
    pnlUsuarios.Color := $00121212;
    pnlUsuarios.Cursor := crDefault;
    ImgConfig.Picture.LoadFromFile(ExtractFilePath(Application.ExeName) + 'Pictures\icon_usuario_2.png');
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
    NovoContato.Endereco := txtLogradouro.Text;
    NovoContato.Favorito := False;
    NovoContato.Ativo := True;

    if ComboBox.ItemIndex = -1 then
    begin
      NovoContato.IdEmpresa := 0;
      NovoContato.Empresa := '';
    end
    else
    begin
      NovoContato.IdEmpresa := Integer(ComboBox.Items.Objects[ComboBox.ItemIndex]);
      NovoContato.Empresa := ComboBox.Text;
    end;

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
      ShowMessage('Erro ao salvar: ' + Mensagem);
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
    if not ValidarFormulario then Exit;

    ContatoAtual.Nome := Edit1.Text;
    ContatoAtual.Telefone := Numero.Text;
    ContatoAtual.Email := Edit2.Text;
    ContatoAtual.Endereco := txtLogradouro.Text;

    if ContatosController.AtualizarContato(ContatoAtual, Mensagem) then
    begin
      AtualizarDBGrid;
      LimparFormulario;
      Editando := False;
      ContatoAtual := nil;
      SpdAdicionar.Enabled := True;
      ShowMessage('Contato atualizado!');
    end
    else
      ShowMessage('Erro ao atualizar!');
  end
  else
  begin
    ShowMessage('Selecione um contato no grid primeiro!');
  end;
end;

procedure TFMain.SpdEditarContatosGridClick(Sender: TObject);
var
  Contato: Contatos;
begin
  if cdsContatos.State in [dsEdit, dsInsert] then
  begin
    try
      cdsContatos.Post;
      ShowMessage('Alterações do grid salvas.');
    except
      on E: Exception do
        ShowMessage('Erro ao salvar edição no grid: ' + E.Message);
    end;
    Exit;
  end;

  Contato := ContatoSelecionado;
  if Contato <> nil then
  begin
    ContatoAtual := Contato;
    PreencherFormulario(ContatoAtual);
    Editando := True;
    SpdAdicionar.Enabled := False;
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
    Contato.Ativo := False;
    if ContatosController.AtualizarContato(Contato, Mensagem) then
    begin
      ShowMessage('Contato excluído com sucesso!');
      CarregarContatosDB;
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

  pgcContatos.ActivePage := tbsContatosList;
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
    CarregarContatosNoComboBox;
    ComboBoxContatos.ItemIndex := -1;
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
  begin
    EmpresaTemp := EmpresaSelecionada;
    if EmpresaTemp = nil then
    begin
      ShowMessage('Selecione uma empresa no grid primeiro!');
      Exit;
    end;

    EmpresaAtual := TEmpresa.Create;
    EmpresaAtual.setCodigo(EmpresaTemp.getCodigo);
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

procedure TFMain.SpdExcluirGrupoClick(Sender: TObject);
var
  IdGrupo: Integer;
  NomeGrupo: string;
begin
  if ClientDataSetGrupos.IsEmpty then
  begin
    ShowMessage('Selecione um grupo no grid para excluir.');
    Exit;
  end;

  IdGrupo   := ClientDataSetGrupos.FieldByName('id_grupo').AsInteger;
  NomeGrupo := ClientDataSetGrupos.FieldByName('nome').AsString;

  if MessageDlg(
       Format('Excluir DEFINITIVAMENTE o grupo "%s" (ID %d)?' + sLineBreak +
              'Esta ação não poderá ser desfeita.', [NomeGrupo, IdGrupo]),
       mtConfirmation, [mbYes, mbNo], 0) <> mrYes then
    Exit;

  if GruposController.ExcluirGrupo(IdGrupo) then
  begin
    ShowMessage('Grupo excluído com sucesso.');
    CarregarGrupos;
    LimparFormularioGrupo;
  end
  else
    ShowMessage('Erro ao excluir grupo. Verifique se ele não está sendo usado em outros cadastros.');
end;

procedure TFMain.SpdRestaurarEmpresaClick(Sender: TObject);
var
  Query: TFDQuery;
  TotalRestauradas: Integer;
  Msg: string;
begin
  if MessageDlg('Deseja restaurar TODAS as empresas excluídas?',
                mtConfirmation, [mbYes, mbNo], 0) = mrNo then
    Exit;

  Query := TFDQuery.Create(nil);
  TotalRestauradas := 0;
  try
    Query.Connection := DataModule1.FDConnection1;
    Query.SQL.Text := 'SELECT id_empresa FROM empresa WHERE ativo = FALSE';
    Query.Open;

    while not Query.Eof do
    begin
      if EmpresasController.Restaurar(Query.FieldByName('id_empresa').AsInteger, Msg) then
        Inc(TotalRestauradas);
      Query.Next;
    end;

    if TotalRestauradas > 0 then
      ShowMessage(Format('Restauradas %d empresa(s) com sucesso!', [TotalRestauradas]))
    else
      ShowMessage('Nenhuma empresa inativa para restaurar.');

    CarregarEmpresas;
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

  pgcEmpresas.ActivePage := tbsEmpresasList;
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
  if not ValidarFormularioGrupo then
    Exit;

  Grupo := TGrupos.Create;
  try
    Grupo.setNome(Trim(Edit8.Text));
    Grupo.setAtivo(rdbGrupoAtivo.Checked);

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
      ShowMessage('Selecione um grupo no grid para editar.');
      Exit;
    end;

    GrupoAtualId := ClientDataSetGrupos.FieldByName('id_grupo').AsInteger;
    Edit7.Text   := IntToStr(GrupoAtualId);
    Edit8.Text   := ClientDataSetGrupos.FieldByName('nome').AsString;

    if ClientDataSetGrupos.FieldByName('ativo').AsBoolean then
      rdbGrupoAtivo.Checked := True
    else
      rdbGrupoInativo.Checked := True;

    EditandoGrupo := True;
    SpdEditarGrupo.Caption := 'Salvar';
    Exit;
  end;

  if not ValidarFormularioGrupo then
    Exit;

  Grupo := TGrupos.Create;
  try
    Grupo.setId(GrupoAtualId);
    Grupo.setNome(Trim(Edit8.Text));
    Grupo.setAtivo(rdbGrupoAtivo.Checked);

    if GruposController.AtualizarGrupo(Grupo) then
    begin
      ShowMessage('Grupo atualizado com sucesso!');
      LimparFormularioGrupo;
      CarregarGrupos;
    end
    else
      ShowMessage('Erro ao atualizar grupo.');
  finally
    Grupo.Free;
  end;
end;

procedure TFMain.SpdRestaurarGruposClick(Sender: TObject);
var
  IdGrupo: Integer;
  NomeGrupo: string;
begin
  if ClientDataSetGrupos.IsEmpty then
  begin
    ShowMessage('Selecione um grupo no grid para restaurar (ativar).');
    Exit;
  end;

  IdGrupo   := ClientDataSetGrupos.FieldByName('id_grupo').AsInteger;
  NomeGrupo := ClientDataSetGrupos.FieldByName('nome').AsString;

  if MessageDlg(
       Format('Marcar o grupo "%s" (ID %d) como ATIVO?', [NomeGrupo, IdGrupo]),
       mtConfirmation, [mbYes, mbNo], 0) <> mrYes then
    Exit;

  if GruposController.RestaurarGrupo(IdGrupo) then
  begin
    ShowMessage('Grupo restaurado com sucesso.');
    CarregarGrupos;
    LimparFormularioGrupo;
  end
  else
    ShowMessage('Erro ao restaurar grupo.');
end;

{$ENDREGION}

{$REGION 'Busca de CEP (SpeedButton5)'}

procedure TFMain.SpeedButton5Click(Sender: TObject);
var
  cep, url: string;
  http: THTTPClient;
  resp: IHTTPResponse;
  json: string;
  jo: TJSONObject;
  logradouro, bairro, cidade, uf: string;
begin
  txtLogradouro.Clear;
  txtBairro.Clear;
  txtLocalidade.Clear;
  txtUF.Clear;
  txtComplemento.Clear;
  txtNumero.Clear;

  cep := Trim(txtCEP.Text);

  cep := StringReplace(cep, '-', '', [rfReplaceAll]);
  cep := StringReplace(cep, '.', '', [rfReplaceAll]);
  cep := StringReplace(cep, ' ', '', [rfReplaceAll]);

  if cep = '' then
  begin
    ShowMessage('Digite um CEP.');
    Exit;
  end;

  url := Format('https://viacep.com.br/ws/%s/json/', [cep]);

  http := THTTPClient.Create;
  try
    try
      resp := http.Get(url);

      if resp.StatusCode <> 200 then
      begin
        ShowMessage('Erro ao consultar CEP. Código HTTP: ' +
                    resp.StatusCode.ToString);
        Exit;
      end;

      json := resp.ContentAsString(TEncoding.UTF8);

      jo := TJSONObject.ParseJSONValue(json) as TJSONObject;
      try
        if (jo = nil) or (jo.GetValue('erro') <> nil) then
        begin
          ShowMessage('CEP não encontrado.');
          Exit;
        end;

        logradouro := jo.GetValue<string>('logradouro', '');
        bairro     := jo.GetValue<string>('bairro', '');
        cidade     := jo.GetValue<string>('localidade', '');
        uf         := jo.GetValue<string>('uf', '');

        txtlogradouro.Text := logradouro;
        txtBairro.Text     := bairro;
        txtLocalidade.Text := cidade;
        txtUF.Text         := uf;

      finally
        jo.Free;
      end;

    except
      on E: Exception do
        ShowMessage('Erro ao consultar CEP: ' + E.Message);
    end;

  finally
    http.Free;
  end;
end;

function TFMain.UsuarioSelecionado: TUsuario;
var
  Id: Integer;
begin
  Result := nil;

  if (not ClientDataSetUsuarios.Active) or ClientDataSetUsuarios.IsEmpty then
    Exit;

  Id := ClientDataSetUsuarios.FieldByName('id_usuario').AsInteger;

  try
    Result := UsuariosController.BuscarPorId(Id);
  except
    on E: Exception do
      ShowMessage('Erro ao buscar usuário selecionado: ' + E.Message);
  end;
end;

{$ENDREGION}

{$REGION 'Importação de contatos .VCF (MemTable e Grid4)'}

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
  dsImportCont.DataSet := mtbImportCont;
  dbgImportCont.DataSource  := dsImportCont;

  dsImportCont.AutoEdit := True;
  mtbImportCont.ReadOnly := False;
  dbgImportCont.Options := DBGrid1.Options + [dgEditing, dgTitles, dgColLines, dgRowLines, dgIndicator];

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
  dbgImportCont.SelectedIndex := 0;
  dbgImportCont.SetFocus;
end;

procedure TFMain.spdImpExcluirClick(Sender: TObject);
begin
  if (mtbImportCont.Active) and (not mtbImportCont.IsEmpty) then
    if MessageDlg('Excluir o contato selecionado?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
      mtbImportCont.Delete;
end;

procedure TFMain.spdImprimirClick(Sender: TObject);
begin
  if not FDConnRel.Connected then
    FDConnRel.Connected := True;

  if RadioButton1.Checked then
  begin
    qryRelContatos.Close;
    qryRelContatos.SQL.Text :=
      'SELECT id_contato, nome, telefone, email ' +
      'FROM "Contato" ' +
      'ORDER BY nome ASC';
    qryRelContatos.Open;

    frxDBDados.DataSet := qryRelContatos;

    frxReportContatosNome.PrepareReport;
    frxReportContatosNome.ShowReport;
    Exit;
  end;

  if RadioButton2.Checked then
  begin
    qryRelContatos.Close;
    qryRelContatos.SQL.Text :=
      'SELECT id_contato, nome, telefone, email ' +
      'FROM "Contato" ' +
      'ORDER BY telefone ASC';
    qryRelContatos.Open;

    frxDBDados.DataSet := qryRelContatos;

    frxReportContatosTelefone.PrepareReport;
    frxReportContatosTelefone.ShowReport;
    Exit;
  end;

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
      Controller.SalvarNoBanco(mtbImportCont, DataModule1.FDConnection1);
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

