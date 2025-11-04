unit uMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Imaging.jpeg,
  Vcl.Imaging.pngimage, Vcl.StdCtrls, Vcl.ComCtrls, Vcl.WinXPanels, Vcl.Mask,
  Vcl.Buttons, Vcl.Grids, Data.DB, Vcl.DBGrids, ContatosController, TContatosModel,
  ContatosRepository, System.Generics.Collections, Data.FMTBcd, Data.SqlExpr, Datasnap.DBClient,
  FireDAC.Phys.PGDef, FireDAC.Phys.PG, FireDAC.Comp.Client,ConexaoBanco,FavoritosModel,FavoritosController,FavoritosRepository,
  EmpresaModel, EmpresaController;

type
  TFMain = class(TForm)
    Fundo: TImage;
    Panel1: TPanel;
    Logo: TImage;
    PanelContatos: TPanel;
    ImageContato: TImage;
    PanelImportExport: TPanel;
    PanelEmpresa: TPanel;
    PanelMensagens: TPanel;
    PanelFavoritos: TPanel;
    PanelConfiguracao: TPanel;
    ContactHub: TPanel;
    ImageFavoritos: TImage;
    ImageMensagens: TImage;
    ImageEmpresa: TImage;
    ImageImpExp: TImage;
    ImageConfig: TImage;
    PanelForm: TPanel;
    CardPanel1: TCardPanel;
    Card1: TCard;
    Card2: TCard;
    Card3: TCard;
    Card5: TCard;
    Card4: TCard;
    Card6: TCard;
    Card7: TCard;
    PageControl: TPageControl;
    Principal: TTabSheet;
    Cadastro: TTabSheet;
    Card8: TCard;
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
    SpdListarEmpresa: TSpeedButton;
    TabSheet3: TTabSheet;
    Panel10: TPanel;
    Label13: TLabel;
    Label14: TLabel;
    DBGrid1: TDBGrid;
    SpdEditarEmpresa: TSpeedButton;
    SpdRestaurarEmpresa: TSpeedButton;
    SpdExcluirEmpresa: TSpeedButton;
    SpdAdicionarEmpresa: TSpeedButton;

    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure LogoClick(Sender: TObject);
    procedure PanelContatosClick(Sender: TObject);
    procedure PanelFavoritosClick(Sender: TObject);
    procedure PanelMensagensClick(Sender: TObject);
    procedure PanelEmpresaClick(Sender: TObject);
    procedure PanelImportExportClick(Sender: TObject);
    procedure PanelConfigClick(Sender: TObject);
    procedure PanelConfiguracaoClick(Sender: TObject);
    procedure PanelContatosMouseEnter(Sender: TObject);
    procedure PanelContatosMouseLeave(Sender: TObject);
    procedure PanelFavoritosMouseEnter(Sender: TObject);
    procedure PanelFavoritosMouseLeave(Sender: TObject);
    procedure PanelMensagensMouseEnter(Sender: TObject);
    procedure PanelMensagensMouseLeave(Sender: TObject);
    procedure PanelEmpresaMouseEnter(Sender: TObject);
    procedure PanelEmpresaMouseLeave(Sender: TObject);
    procedure PanelImportExportMouseEnter(Sender: TObject);
    procedure PanelImportExportMouseLeave(Sender: TObject);
    procedure PanelConfigMouseEnter(Sender: TObject);
    procedure PanelConfigMouseLeave(Sender: TObject);
    procedure SpdAdicionarClick(Sender: TObject);
    procedure SpdRemoverClick(Sender: TObject);
    procedure SpdEditarClick(Sender: TObject);
    procedure SpdEditarContatosGridClick(Sender: TObject);
    procedure SpdListarClick(Sender: TObject);
    procedure DBGrid2DblClick(Sender: TObject);
    procedure SpdExcluirClick(Sender: TObject);
    procedure SpdAdicionarFavoritoClick(Sender: TObject);
    procedure SpdRemoverFavoritoClick(Sender: TObject);
<<<<<<< HEAD

=======
    procedure SpdAdicionarEmpresaClick(Sender: TObject);
    procedure SpdEditarEmpresaClick(Sender: TObject);
    procedure SpdExcluirEmpresaClick(Sender: TObject);
    procedure SpdRestaurarEmpresaClick(Sender: TObject);
>>>>>>> f2a73bb (Terminando crud de empresa)

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
<<<<<<< HEAD
  procedure SpdAdicionarEmpresaClick(Sender: TObject);
  procedure SpdEditarEmpresaClick(Sender: TObject);
  procedure SpdExcluirEmpresaClick(Sender: TObject);
=======
>>>>>>> f2a73bb (Terminando crud de empresa)
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
  FavoritosController := TFavoritosController.Create(1);

  ClientDataSetFavoritos := TClientDataSet.Create(Self);
  DataSourceFavoritos := TDataSource.Create(Self);

  Editando := False;
  ContatoAtual := nil;

  DBGridFavoritos.DataSource := DataSourceFavoritos;
  ConfigurarDBGrid;
  ConfigurarDBGridFavoritos;
  CarregarContatosDB;
  CarregarFavoritos;

  EmpresasController := TEmpresaController.Create(1);
  ClientDataSetEmpresas := TClientDataSet.Create(Self);
  DataSourceEmpresas := TDataSource.Create(Self);
  EditandoEmpresa := False;
  EmpresaAtual := nil;
  LoadingDatasetEmpresas := False;

  DBGrid1.DataSource := DataSourceEmpresas;
  ConfigurarDBGridEmpresas;
<<<<<<< HEAD
  CarregarEmpresas;
=======

  Card5.visible := false;
  PageControl2.Visible := false;
>>>>>>> f2a73bb (Terminando crud de empresa)
end;

procedure TFMain.FormDestroy(Sender: TObject);
begin
  ContatosLista.Free;
  ContatosController.Free;

  FavoritosController.Free;
  ClientDataSetFavoritos.Free;
  DataSourceFavoritos.Free;

  EmpresasController.Free;
  ClientDataSetEmpresas.Free;
  DataSourceEmpresas.Free;
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


  ClientDataSetEmpresas.AfterPost := SalvarEdicaoEmpresaGrid;
  ClientDataSetEmpresas.AfterDelete := ConfirmarExclusaoEmpresaGrid;
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

procedure TFMain.ConfirmarExclusaoEmpresaGrid(DataSet: TDataSet);
var
  IdEmpresa: Integer;
<<<<<<< HEAD
  Msg: string;
=======
  Mensagem: string;
>>>>>>> f2a73bb (Terminando crud de empresa)
begin
  if ClientDataSetEmpresas.IsEmpty then Exit;

  IdEmpresa := ClientDataSetEmpresas.FieldByName('ID').AsInteger;

  if MessageDlg('Deseja realmente excluir esta empresa?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
<<<<<<< HEAD
    if Assigned(EmpresasController) then
    begin
      if EmpresasController.Remover(IdEmpresa, Msg) then
      begin
        ShowMessage('Empresa excluída com sucesso!');
        CarregarEmpresas;
      end
      else
        ShowMessage('Erro ao excluir empresa: ' + Msg);
    end
    else
      DataSet.Cancel;
=======
    if EmpresasController.Remover(IdEmpresa, Mensagem) then
    begin
      ShowMessage(Mensagem);
      CarregarEmpresas;
    end
    else
    begin
      ShowMessage(Mensagem);
      DataSet.Cancel;
    end;
>>>>>>> f2a73bb (Terminando crud de empresa)
  end
  else
    DataSet.Cancel;
end;

procedure TFMain.ConfirmarExclusaoFavorito(DataSet: TDataSet);
begin
  // A exclusão de favoritos é tratada no evento SpdRemoverFavoritoClick
  ShowMessage('Use o botão "Remover Favorito" para excluir favoritos.');
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
<<<<<<< HEAD
  if Assigned(EmpresasController) then
  begin
    if EmpresasController.CarregarEmpresas(ClientDataSetEmpresas) then
    begin
      DBGrid1.Refresh;
      if not ClientDataSetEmpresas.IsEmpty then
        ClientDataSetEmpresas.First;
    end
    else
      ShowMessage('Erro ao carregar empresas!');
  end;
=======
  if LoadingDatasetEmpresas then Exit;
  LoadingDatasetEmpresas := True;
  try
    ClientDataSetEmpresas.DisableControls;
    try
      ClientDataSetEmpresas.EmptyDataSet;
      EmpresasController.CarregarEmpresas(ClientDataSetEmpresas);
    finally
      ClientDataSetEmpresas.EnableControls;
    end;
  finally
    LoadingDatasetEmpresas := False;
  end;
  DBGrid1.Refresh;
>>>>>>> f2a73bb (Terminando crud de empresa)
end;

procedure TFMain.CarregarFavoritos;
begin
  // DEIXA O CONTROLLER FAZER TUDO
  FavoritosController.CarregarFavoritos(ClientDataSetFavoritos);
  DBGridFavoritos.Refresh;  // só atualiza o visual
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
<<<<<<< HEAD
  CarregarEmpresas;
=======
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
>>>>>>> f2a73bb (Terminando crud de empresa)
end;

procedure TFMain.SalvarEdicaoEmpresaGrid(DataSet: TDataSet);
var
  Empresa: TEmpresa;
<<<<<<< HEAD
  Msg: string;
begin
  if LoadingDatasetEmpresas then Exit;

  try
    if Assigned(EmpresasController) then
    begin
      Empresa := EmpresaSelecionada;
      if Empresa <> nil then
      begin
        Empresa.setCNPJ(DataSet.FieldByName('CNPJ').AsString);
        Empresa.setNome(DataSet.FieldByName('NOME').AsString);
        Empresa.setTelefone(DataSet.FieldByName('TELEFONE').AsString);
        Empresa.setEmail(DataSet.FieldByName('EMAIL').AsString);
        Empresa.setEndereco(DataSet.FieldByName('ENDERECO').AsString);
        Empresa.setUF(DataSet.FieldByName('UF').AsString);

        if EmpresasController.Atualizar(Empresa, Msg) then
          ShowMessage('Empresa atualizada com sucesso!')
        else
          ShowMessage('Erro ao atualizar empresa: ' + Msg);
      end;
    end;
  except
    on E: Exception do
      ShowMessage('Erro ao salvar edição: ' + E.Message);
=======
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
>>>>>>> f2a73bb (Terminando crud de empresa)
  end;
end;

procedure TFMain.SalvarEdicaoFavorito(DataSet: TDataSet);
begin
  // Favoritos não são editáveis diretamente no grid
  ShowMessage('Favoritos não podem ser editados diretamente. Use os botões Adicionar/Remover.');
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
<<<<<<< HEAD
  Msg: string;
begin
  if not ValidarFormularioEmpresa then Exit;
=======
  Mensagem: string;
begin
  if not ValidarFormularioEmpresa then
    Exit;
>>>>>>> f2a73bb (Terminando crud de empresa)

  NovaEmpresa := TEmpresa.Create;
  try
    NovaEmpresa.setCNPJ(CodigoEmpresa.Text);
    NovaEmpresa.setNome(NomeDaEmpresa.Text);
    NovaEmpresa.setTelefone(MaskEdit1.Text);
    NovaEmpresa.setEmail(Edit5.Text);
    NovaEmpresa.setEndereco(Edit6.Text);
    NovaEmpresa.setUF(MaskEdit2.Text);

<<<<<<< HEAD
    if EmpresasController.Adicionar(NovaEmpresa, Msg) then
    begin
      ShowMessage('Empresa adicionada com sucesso!');
=======
    if EmpresasController.Adicionar(NovaEmpresa, Mensagem) then
    begin
      ShowMessage(Mensagem);
>>>>>>> f2a73bb (Terminando crud de empresa)
      LimparFormularioEmpresa;
      CarregarEmpresas;
    end
    else
<<<<<<< HEAD
      ShowMessage('Erro ao adicionar empresa: ' + Msg);
  except
    on E: Exception do
    begin
      NovaEmpresa.Free;
      ShowMessage('Erro: ' + E.Message);
    end;
=======
      ShowMessage(Mensagem);
  finally
    NovaEmpresa.Free;
>>>>>>> f2a73bb (Terminando crud de empresa)
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

<<<<<<< HEAD
procedure TFMain.SpdEditarEmpresaClick(Sender: TObject);
var
  Empresa: TEmpresa;
  Msg: string;
begin
  if EditandoEmpresa and (EmpresaAtual <> nil) then
  begin
    // Salvar alterações
    if not ValidarFormularioEmpresa then Exit;

=======

procedure TFMain.SpdEditarEmpresaClick(Sender: TObject);
var
  EmpresaTemp: TEmpresa;
  Mensagem: string;
begin
  // === SALVAR EDIÇÃO ===
  if EditandoEmpresa and (EmpresaAtual <> nil) then
  begin
    if not ValidarFormularioEmpresa then Exit;

>>>>>>> f2a73bb (Terminando crud de empresa)
    EmpresaAtual.setCNPJ(CodigoEmpresa.Text);
    EmpresaAtual.setNome(NomeDaEmpresa.Text);
    EmpresaAtual.setTelefone(MaskEdit1.Text);
    EmpresaAtual.setEmail(Edit5.Text);
    EmpresaAtual.setEndereco(Edit6.Text);
    EmpresaAtual.setUF(MaskEdit2.Text);

<<<<<<< HEAD
    if EmpresasController.Atualizar(EmpresaAtual, Msg) then
    begin
      ShowMessage('Empresa atualizada com sucesso!');
      LimparFormularioEmpresa;
      EditandoEmpresa := False;
      EmpresaAtual := nil;
      CarregarEmpresas;
    end
    else
      ShowMessage('Erro ao atualizar empresa: ' + Msg);
  end
  else
  begin
    // Carregar empresa para edição
    Empresa := EmpresaSelecionada;
    if Empresa <> nil then
    begin
      EmpresaAtual := Empresa;
      PreencherFormularioEmpresa(EmpresaAtual);
      EditandoEmpresa := True;
=======
    if EmpresasController.Atualizar(EmpresaAtual, Mensagem) then
    begin
      ShowMessage(Mensagem);
      LimparFormularioEmpresa;
      EditandoEmpresa := False;
      EmpresaAtual := nil;
      SpdAdicionarEmpresa.Enabled := True;
      PageControl2.ActivePage := TabSheet3;  // ← VOLTA PRO GRID
      CarregarEmpresas;
    end
    else
      ShowMessage(Mensagem);
  end
  else
  // === INICIAR EDIÇÃO ===
  begin
    EmpresaTemp := EmpresaSelecionada;
    if EmpresaTemp <> nil then
    begin
      EmpresaAtual := EmpresaTemp;
      PreencherFormularioEmpresa(EmpresaAtual);
      EditandoEmpresa := True;
      SpdAdicionarEmpresa.Enabled := False;
      PageControl2.ActivePage := TabSheet2;  // ← VAI PRO FORMULÁRIO
>>>>>>> f2a73bb (Terminando crud de empresa)
    end
    else
      ShowMessage('Selecione uma empresa no grid primeiro!');
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
<<<<<<< HEAD
  Empresa: TEmpresa;
  Msg: string;
begin
  Empresa := EmpresaSelecionada;
  if Empresa = nil then
=======
  IdEmpresa: Integer;
  Mensagem: string;
begin
  if ClientDataSetEmpresas.IsEmpty then
>>>>>>> f2a73bb (Terminando crud de empresa)
  begin
    ShowMessage('Nenhuma empresa selecionada para excluir!');
    Exit;
  end;

<<<<<<< HEAD
  if MessageDlg('Deseja realmente excluir esta empresa?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    if EmpresasController.Remover(Empresa.getCodigo, Msg) then
    begin
      ShowMessage('Empresa excluída com sucesso!');
      CarregarEmpresas;
      LimparFormularioEmpresa;
      EditandoEmpresa := False;
      EmpresaAtual := nil;
    end
    else
      ShowMessage('Erro ao excluir empresa: ' + Msg);
=======
  IdEmpresa := ClientDataSetEmpresas.FieldByName('ID').AsInteger;

  if MessageDlg('Deseja realmente excluir esta empresa?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    if EmpresasController.Remover(IdEmpresa, Mensagem) then
    begin
      ShowMessage(Mensagem);
      CarregarEmpresas;
    end
    else
      ShowMessage(Mensagem);
  end;
end;

procedure TFMain.SpdRestaurarEmpresaClick(Sender: TObject);
var
  Mensagem: string;
  IdEmpresa: Integer;
begin
  if ClientDataSetEmpresas.IsEmpty then
  begin
    ShowMessage('Nenhuma empresa selecionada para restaurar!');
    Exit;
  end;

  IdEmpresa := ClientDataSetEmpresas.FieldByName('ID').AsInteger;

  if MessageDlg('Deseja realmente restaurar esta empresa?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    if EmpresasController.Restaurar(IdEmpresa, Mensagem) then
    begin
      ShowMessage(Mensagem);
      CarregarEmpresas;
    end
    else
      ShowMessage(Mensagem);
>>>>>>> f2a73bb (Terminando crud de empresa)
  end;
end;

procedure TFMain.SpdListarClick(Sender: TObject);
begin
  LimparFormulario;
  CarregarContatosDB;
//  ShowMessage('Lista de contatos atualizada!');
end;


procedure TFMain.DBGrid1DblClick(Sender: TObject);
begin
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
<<<<<<< HEAD

      if EmpresasController.BuscarPorId(IdSelecionado, Result) then
        // Empresa encontrada e carregada em Result
      else
        ShowMessage('Empresa não encontrada!');
    except
      on E: Exception do
        ShowMessage('Erro ao selecionar empresa: ' + E.Message);
=======
      EmpresasController.BuscarPorId(IdSelecionado, Result);
    except
      on E: Exception do
        ShowMessage('Erro ao buscar empresa: ' + E.Message);
>>>>>>> f2a73bb (Terminando crud de empresa)
    end;
  end;
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
<<<<<<< HEAD
    CodigoEmpresa.SetFocus;
=======
>>>>>>> f2a73bb (Terminando crud de empresa)
    Exit;
  end;

  if Trim(NomeDaEmpresa.Text) = '' then
  begin
    ShowMessage('Digite o nome da empresa!');
<<<<<<< HEAD
    NomeDaEmpresa.SetFocus;
=======
>>>>>>> f2a73bb (Terminando crud de empresa)
    Exit;
  end;

  if Trim(MaskEdit1.Text) = '' then
  begin
    ShowMessage('Digite o telefone!');
<<<<<<< HEAD
    MaskEdit1.SetFocus;
=======
>>>>>>> f2a73bb (Terminando crud de empresa)
    Exit;
  end;

  if Trim(Edit5.Text) = '' then
  begin
    ShowMessage('Digite o email!');
<<<<<<< HEAD
    Edit5.SetFocus;
=======
>>>>>>> f2a73bb (Terminando crud de empresa)
    Exit;
  end;

  if Trim(Edit6.Text) = '' then
  begin
    ShowMessage('Digite o endereço!');
<<<<<<< HEAD
    Edit6.SetFocus;
=======
>>>>>>> f2a73bb (Terminando crud de empresa)
    Exit;
  end;

  if Trim(MaskEdit2.Text) = '' then
  begin
    ShowMessage('Digite a UF!');
<<<<<<< HEAD
    MaskEdit2.SetFocus;
=======
>>>>>>> f2a73bb (Terminando crud de empresa)
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
<<<<<<< HEAD
  if Empresa <> nil then
=======
  if TEmpresa <> nil then
>>>>>>> f2a73bb (Terminando crud de empresa)
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
<<<<<<< HEAD
  CodigoEmpresa.SetFocus;
=======
>>>>>>> f2a73bb (Terminando crud de empresa)
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



    PanelMensagens.Margins.Top := 20;
    PanelMensagens.Font.Size := 19;

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

procedure TFMain.PanelMensagensClick(Sender: TObject);
begin
  AtivarPainel(PanelMensagens);
end;

procedure TFMain.PanelEmpresaClick(Sender: TObject);
begin
 AtivarPainel(PanelEmpresa);
  CardPanel1.ActiveCard := Card5;
  PageControl2.Visible := True;
  Card5.Visible := True;
  CarregarEmpresas;
  PageControl2.ActivePage := TabSheet3;
  //CarregarContatosNoComboBox;
end;

procedure TFMain.PanelImportExportClick(Sender: TObject);
begin
  AtivarPainel(PanelImportExport);
  CardPanel1.ActiveCard := Card8;
  PageControl2.Visible := True;
  Card5.Visible := True;
  CarregarEmpresas;
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

procedure TFMain.PanelMensagensMouseEnter(Sender: TObject);
begin
  if PainelPressionado <> PanelMensagens then
  begin
    PanelMensagens.BevelOuter := bvRaised;
    PanelMensagens.Color := $00D6498F;
    PanelMensagens.Cursor := crHandPoint;
    ImageMensagens.Picture.LoadFromFile(ExtractFilePath(Application.ExeName) + 'Pictures\LogoMensagensPreta.png');
  end;
end;

procedure TFMain.PanelMensagensMouseLeave(Sender: TObject);
begin
  if PainelPressionado <> PanelMensagens then
  begin
    PanelMensagens.BevelOuter := bvNone;
    PanelMensagens.Color := $00121212;
    PanelMensagens.Cursor := crDefault;
    ImageMensagens.Picture.LoadFromFile(ExtractFilePath(Application.ExeName) + 'Pictures\LogoMensagensRoxa.png');
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

procedure TFMain.PanelConfigMouseEnter(Sender: TObject);
begin
  if PainelPressionado <>  PanelConfiguracao then
  begin
    PanelImportExport.BevelOuter := bvRaised;
    PanelImportExport.Color := $00D6498F;
    PanelImportExport.Cursor := crHandPoint;
    ImageImpExp.Picture.LoadFromFile(ExtractFilePath(Application.ExeName) + 'Pictures\ConfiguracaoPreta.png');
  end;
end;

procedure TFMain.PanelConfigMouseLeave(Sender: TObject);
begin
  if PainelPressionado <> PanelConfiguracao then
  begin
    PanelImportExport.BevelOuter := bvNone;
    PanelImportExport.Color := $00121212;
    PanelImportExport.Cursor := crDefault;
    ImageImpExp.Picture.LoadFromFile(ExtractFilePath(Application.ExeName) + 'Pictures\ConfiguracaoRoxa.png');
  end;
end;



end.
