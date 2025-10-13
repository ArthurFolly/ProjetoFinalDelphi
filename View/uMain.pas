unit uMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Imaging.jpeg,
  Vcl.Imaging.pngimage, Vcl.StdCtrls, Vcl.ComCtrls, Vcl.WinXPanels, Vcl.Mask,
  Vcl.Buttons, Vcl.Grids, Data.DB, Vcl.DBGrids;

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
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
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
    SpeedButton5: TSpeedButton;
    SpeedButton6: TSpeedButton;
    procedure FormResize(Sender: TObject);
    procedure LogoClick(Sender: TObject);
    procedure PanelContatosClick(Sender: TObject);
    procedure PanelGruposMouseEnter(Sender: TObject);
    procedure PanelGruposMouseLeave(Sender: TObject);
    procedure PanelGruposClick(Sender: TObject);
    procedure PanelMensagensMouseEnter(Sender: TObject);
    procedure PanelMensagensMouseLeave(Sender: TObject);
    procedure PanelMensagensClick(Sender: TObject);
    procedure PanelEmpresaMouseEnter(Sender: TObject);
    procedure PanelEmpresaMouseLeave(Sender: TObject);
    procedure PanelEmpresaClick(Sender: TObject);
    procedure PanelImportExportMouseLeave(Sender: TObject);
    procedure PanelImportExportMouseEnter(Sender: TObject);
    procedure PanelImportExportClick(Sender: TObject);
    procedure PanelConfiguracaoMouseLeave(Sender: TObject);
    procedure PanelConfiguracaoMouseEnter(Sender: TObject);
    procedure PanelConfiguracaoClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure PanelFavoritosClick(Sender: TObject);
    procedure PanelFavoritosMouseEnter(Sender: TObject);
    procedure PanelFavoritosMouseLeave(Sender: TObject);
    procedure PanelContatosMouseEnter(Sender: TObject);
    procedure PanelContatosMouseLeave(Sender: TObject);
//    procedure Shape1ContextPopup(Sender: TObject; MousePos: TPoint;
//      var Handled: Boolean);
//    procedure PanelMensagensDblClick(Sender: TObject);
  private
    procedure AtivarPainel(Panel: TPanel);
    procedure ResetarPainelAnterior;
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
  PainelPressionado := nil;
  PageControl1.Visible := false;
  PageControl.Visible := False;
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

    // Ativar o novo painel
    Panel.Color := $6B0C44;           // Roxo escuro
    Panel.BevelOuter := bvNone;       // Sem bevel externo
    Panel.BevelInner := bvLowered;    // Bevel interno afundado
    Panel.Cursor := crDefault;        // Cursor normal
    PainelPressionado := Panel;       // Marcar como ativo
  end;
end;

procedure TFMain.ResetarPainelAnterior;
begin
  if Assigned(PainelPressionado) then
  begin
    PainelPressionado.Color := $00121212;   // Cor escura normal
    PainelPressionado.BevelOuter := bvNone; // Sem bevel
    PainelPressionado.BevelInner := bvNone; // Sem bevel
    PainelPressionado.Cursor := crDefault;  // Cursor normal
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
  PageControl.Visible := true;
end;

procedure TFMain.PanelFavoritosClick(Sender: TObject);
begin
  AtivarPainel(PanelFavoritos);
  CardPanel1.ActiveCard := Card3;
  PageControl1.Visible := true;
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
