unit uMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Imaging.jpeg,
  Vcl.Imaging.pngimage, Vcl.StdCtrls, Vcl.ComCtrls, Vcl.WinXPanels, Vcl.Mask,
  Vcl.Buttons, Vcl.Grids, Data.DB, Vcl.DBGrids, ContatosController, TContatosModel,
  ContatosRepository, System.Generics.Collections, Data.FMTBcd, Data.SqlExpr, Datasnap.DBClient,
   FireDAC.Phys.PGDef, FireDAC.Phys.PG, FireDAC.Comp.Client,ConexaoBanco;

type
  TFMain = class(TForm)
    Fundo: TImage;
    Panel1: TPanel;
    Logo: TImage;
    PanelContatos: TPanel;
    ImageContato: TImage;
    PanelEmpresa: TPanel;
    PanelConfiguracao: TPanel;
    PanelMensagens: TPanel;
    PanelGrupos: TPanel;
    PanelFavoritos: TPanel;
    PanelImportExport: TPanel;
    ContactHub: TPanel;
    ImageFavoritos: TImage;
    ImageGrupos: TImage;
    ImageMensagens: TImage;
    ImageEmpresa: TImage;
    ImageImpExp: TImage;
    ImageConfig: TImage;
    PanelForm: TPanel;
    CardPanel1: TCardPanel;
    Card1: TCard;
    Card2: TCard;
    Card3: TCard;
    Card4: TCard;
    Card5: TCard;
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
    StringGrid1: TStringGrid;
    Bevel3: TBevel;
    SpeedButton4: TSpeedButton;
    Panel7: TPanel;
    SpdEditarContatosGrid: TSpeedButton;
    SpdExcluir: TSpeedButton;
    SpdListar: TSpeedButton;
    DataSource1: TDataSource;
    ClientDataSet1: TClientDataSet;
    SQLConnection1: TSQLConnection;
    SQLQuery1: TSQLQuery;
    DBGrid2: TDBGrid;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;

    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure LogoClick(Sender: TObject);
    procedure PanelContatosClick(Sender: TObject);
    procedure PanelFavoritosClick(Sender: TObject);
    procedure PanelGruposClick(Sender: TObject);
    procedure PanelMensagensClick(Sender: TObject);
    procedure PanelEmpresaClick(Sender: TObject);
    procedure PanelImportExportClick(Sender: TObject);
    procedure PanelConfiguracaoClick(Sender: TObject);
    procedure PanelContatosMouseEnter(Sender: TObject);
    procedure PanelContatosMouseLeave(Sender: TObject);
    procedure PanelFavoritosMouseEnter(Sender: TObject);
    procedure PanelFavoritosMouseLeave(Sender: TObject);
    procedure PanelGruposMouseEnter(Sender: TObject);
    procedure PanelGruposMouseLeave(Sender: TObject);
    procedure PanelMensagensMouseEnter(Sender: TObject);
    procedure PanelMensagensMouseLeave(Sender: TObject);
    procedure PanelEmpresaMouseEnter(Sender: TObject);
    procedure PanelEmpresaMouseLeave(Sender: TObject);
    procedure PanelImportExportMouseEnter(Sender: TObject);
    procedure PanelImportExportMouseLeave(Sender: TObject);
    procedure PanelConfiguracaoMouseEnter(Sender: TObject);
    procedure PanelConfiguracaoMouseLeave(Sender: TObject);
    procedure SpdAdicionarClick(Sender: TObject);
    procedure SpdRemoverClick(Sender: TObject);
    procedure SpdEditarClick(Sender: TObject);
    procedure SpdEditarContatosGridClick(Sender: TObject);
    procedure SpdListarClick(Sender: TObject);
    procedure DBGrid2DblClick(Sender: TObject);
    procedure SpdExcluirClick(Sender: TObject);

  private
    Editando: Boolean;
    ContatoAtual: Contatos;
    ContatosLista: TObjectList<Contatos>;
    ContatosController: TContatosController;
    LoadingDataset: Boolean;

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

  public
    { Public declarations }
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
  Editando := False;
  ContatoAtual := nil;

  ConfigurarDBGrid;
  CarregarContatosDB;
end;

procedure TFMain.FormDestroy(Sender: TObject);
begin
  ContatosLista.Free;
  ContatosController.Free;
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

procedure TFMain.AtualizarDBGrid;
var
  I: Integer;
  Contato: Contatos;
begin
  LoadingDataset := True; // <- ADICIONE AQUI
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

procedure TFMain.SpdRemoverClick(Sender: TObject);
begin
  LimparFormulario;
  Editando := False;
  ContatoAtual := nil;
  SpdAdicionar.Enabled := True;
  SpdEditarContatosGrid.Caption := 'Editar';
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

procedure TFMain.SpdListarClick(Sender: TObject);
begin
  LimparFormulario;
  CarregarContatosDB;
//  ShowMessage('Lista de contatos atualizada!');
end;


procedure TFMain.DBGrid2DblClick(Sender: TObject);
begin
  SpdEditarContatosGridClick(Sender);
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
    PanelGrupos.Font.Size := 18;

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
end;

procedure TFMain.PanelGruposClick(Sender: TObject);
begin
  AtivarPainel(PanelGrupos);
end;

procedure TFMain.PanelMensagensClick(Sender: TObject);
begin
  AtivarPainel(PanelMensagens);
end;

procedure TFMain.PanelEmpresaClick(Sender: TObject);
begin
  AtivarPainel(PanelEmpresa);
end;

procedure TFMain.PanelImportExportClick(Sender: TObject);
begin
  AtivarPainel(PanelImportExport);
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
