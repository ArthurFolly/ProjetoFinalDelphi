unit uMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Imaging.jpeg,
  Vcl.Imaging.pngimage, Vcl.StdCtrls, Vcl.ComCtrls, Vcl.WinXPanels, Vcl.Mask,
  Vcl.Buttons, Vcl.Grids, Data.DB, Vcl.DBGrids, ContatosController, TContatosModel,
  ContatosRepository, System.Generics.Collections, Data.FMTBcd, Data.SqlExpr, Datasnap.DBClient,
   FireDAC.Phys.PGDef, FireDAC.Phys.PG, FireDAC.Comp.Client;

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
    SpdRemover: TSpeedButton;
    SpdEditar: TSpeedButton;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    Panel5: TPanel;
    Panel6: TPanel;
    Label5: TLabel;
    StringGrid1: TStringGrid;
    Bevel3: TBevel;
    SpeedButton4: TSpeedButton;
    DBGrid2: TDBGrid;
    Panel7: TPanel;
    SpdEditarContatosGrid: TSpeedButton;
    SpdExcluir: TSpeedButton;
    SpdAtualizar: TSpeedButton;
    DataSource1: TDataSource;
    ClientDataSet1: TClientDataSet;
    SQLConnection1: TSQLConnection;
    SQLQuery1: TSQLQuery;

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
    procedure SpdExcluirClick(Sender: TObject);
    procedure SpdAtualizarClick(Sender: TObject);
    procedure DBGrid2DblClick(Sender: TObject);

  private
    Editando: Boolean;
    ContatoAtual: Contatos;
    ContatosLista: TObjectList<Contatos>;
    ContatosController: TContatosController;

    procedure AtivarPainel(Panel: TPanel);
    procedure ResetarPainelAnterior;
    procedure AtualizarDBGrid;
    procedure LimparFormulario;
    function ValidarFormulario: Boolean;
    function ContatoSelecionado: Contatos;
    procedure PreencherFormulario(Contato: Contatos);
    procedure ConfigurarDBGrid;
    procedure CarregarContatosDB;

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
  ClientDataSet1.DisableControls;
  try
    ClientDataSet1.Close;
    ClientDataSet1.CreateDataSet;

    for I := 0 to ContatosLista.Count - 1 do
    begin
      Contato := ContatosLista[I];

      ClientDataSet1.Append;
      ClientDataSet1.FieldByName('ID').Value := Contato.Id;
      ClientDataSet1.FieldByName('NOME').Value := Contato.Nome;
      ClientDataSet1.FieldByName('TELEFONE').Value := Contato.Telefone;
      ClientDataSet1.FieldByName('EMAIL').Value := Contato.Email;
      ClientDataSet1.FieldByName('EMPRESA').Value := Contato.Empresa;
      ClientDataSet1.FieldByName('ENDERECO').Value := Contato.Endereco;
      ClientDataSet1.Post;
    end;

    ClientDataSet1.First;
  finally
    ClientDataSet1.EnableControls;
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
  SpdEditar.Caption := 'Editar';
end;

procedure TFMain.SpdEditarClick(Sender: TObject);
begin
  if Editando and (ContatoAtual <> nil) then
  begin
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
      SpdEditar.Caption := 'Editar';
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
  Contato := ContatoSelecionado;
  if Contato <> nil then
  begin
    ContatoAtual := Contato;
    PreencherFormulario(ContatoAtual);
    Editando := True;
    SpdAdicionar.Enabled := False;
    SpdEditar.Caption := 'Salvar';
    Edit1.SetFocus;
  end
  else
    ShowMessage('Selecione um contato no grid!');
end;

procedure TFMain.SpdExcluirClick(Sender: TObject);
var
  Contato: Contatos;
begin
  Contato := ContatoSelecionado;
  if Contato <> nil then
  begin
    if MessageDlg('Excluir ' + Contato.Nome + '?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    begin
      if ContatosController.ExcluirContato(Contato.Id) then
      begin
        ContatosLista.Remove(Contato);
        AtualizarDBGrid;
        ShowMessage('Contato excluído!');
      end
      else
        ShowMessage('Erro ao excluir!');
    end;
  end
  else
    ShowMessage('Selecione um contato!');
end;

procedure TFMain.SpdAtualizarClick(Sender: TObject);
begin
  CarregarContatosDB;
  ShowMessage('Contatos atualizados: ' + IntToStr(ContatosLista.Count));
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
    Edit1.SetFocus;
    Exit;
  end;

  if Trim(Numero.Text) = '' then
  begin
    ShowMessage('Digite o telefone!');
    Numero.SetFocus;
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
      // Ignora erro
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
  Edit1.SetFocus;
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
