unit uMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Imaging.jpeg,
  Vcl.Imaging.pngimage, Vcl.StdCtrls, Vcl.ComCtrls, Vcl.WinXPanels;

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
    procedure FormResize(Sender: TObject);
    procedure LogoClick(Sender: TObject);
    procedure PanelContatosClick(Sender: TObject);
    procedure PanelGruposMouseEnter(Sender: TObject);
    procedure PanelGruposMouseLeave(Sender: TObject);
    procedure PanelMensagensMouseEnter(Sender: TObject);
    procedure PanelMensagensMouseLeave(Sender: TObject);
    procedure PanelEmpresaMouseEnter(Sender: TObject);
    procedure PanelEmpresaMouseLeave(Sender: TObject);
    procedure PanelImportExportMouseLeave(Sender: TObject);
    procedure PanelImportExportMouseEnter(Sender: TObject);
    procedure PanelConfiguracaoMouseLeave(Sender: TObject);
    procedure PanelConfiguracaoMouseEnter(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure PanelFavoritosClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FMain: TFMain;

implementation

{$R *.dfm}

var
  PainelPressionado: TPanel;  // Variável para armazenar o painel pressionado

procedure TFMain.FormCreate(Sender: TObject);
begin
  // Qualquer inicialização necessária no FormCreate
end;

procedure TFMain.FormResize(Sender: TObject);
begin
  if (WindowState = wsMaximized) then
  begin
    // Responsividade Panel ContactHub
    Logo.Width := 100;
    Logo.Height := 90;
    ContactHub.Font.Size := 20;
    ContactHub.Alignment := taCenter;

    // Responsividade Panel Contatos
    ImageConfig.Width := 32;
    ImageConfig.Height := 32;
    ImageConfig.Margins.Top := 10;
    ImageConfig.Align := alLeft;

    PanelContatos.Margins.Top := 45;
    PanelContatos.Height := 70;
    PanelContatos.Width := 100;
    PanelContatos.Font.Size := 18;

    // Responsividade Panel Favoritos
    PanelFavoritos.Margins.Top := 20;
    PanelFavoritos.Font.Size := 18;

    // Responsividade Panel Grupos
    PanelGrupos.Margins.Top := 20;
    PanelGrupos.Font.Size := 18;

    // Responsividade Panel Mensagens
    PanelMensagens.Margins.Top := 20;
    PanelMensagens.Font.Size := 19;

    // Responsividade Panel Empresa
    PanelEmpresa.Margins.Top := 20;
    PanelEmpresa.Font.Size := 18;

    // Responsividade Panel Importar e Exportar
    PanelImportExport.Margins.Top := 20;
    PanelImportExport.Font.Size := 18;

    // Responsividade Panel Configuração
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

procedure TFMain.PanelConfiguracaoMouseEnter(Sender: TObject);
begin
  PanelConfiguracao.BevelOuter := bvRaised;
  PanelConfiguracao.Color := $00D6498F;
  PanelConfiguracao.Cursor := crHandPoint;
  ImageConfig.Picture.LoadFromFile(ExtractFilePath(Application.ExeName) + 'Pictures\ConfiguracaoPreta.png');
end;

procedure TFMain.PanelConfiguracaoMouseLeave(Sender: TObject);
begin
  PanelConfiguracao.BevelOuter := bvNone;
  PanelConfiguracao.Color := $00121212;
  PanelConfiguracao.Cursor := crHandPoint;
  ImageConfig.Picture.LoadFromFile(ExtractFilePath(Application.ExeName) + 'Pictures\ConfiguracaoRoxa.png');
end;

procedure TFMain.PanelContatosClick(Sender: TObject);
begin

  if Assigned(PainelPressionado) and (PainelPressionado <> Sender) then
  begin
    PainelPressionado.Color := clBtnFace;
    PainelPressionado.BevelOuter := bvRaised;
    PainelPressionado.BevelInner := bvNone;
  end;


  if PanelContatos.Color = $6B0C44 then
  begin

    PanelContatos.Color := clBtnFace;
    PanelContatos.BevelOuter := bvRaised;
    PanelContatos.BevelInner := bvNone;
    PainelPressionado := nil;
  end
  else
  begin

    PanelContatos.Color := $6B0C44;
    PanelContatos.BevelOuter := bvNone;
    PanelContatos.BevelInner := bvLowered;
    PainelPressionado := PanelContatos;
  end;
end;

procedure TFMain.PanelEmpresaMouseEnter(Sender: TObject);
begin
  PanelEmpresa.BevelOuter := bvRaised;
  PanelEmpresa.Color := $00D6498F;
  PanelEmpresa.Cursor := crHandPoint;
  ImageEmpresa.Picture.LoadFromFile(ExtractFilePath(Application.ExeName) + 'Pictures\LogoEmpresaRoxa.png');
end;

procedure TFMain.PanelEmpresaMouseLeave(Sender: TObject);
begin
  PanelEmpresa.BevelOuter := bvNone;
  PanelEmpresa.Color := $00121212;
  PanelEmpresa.Cursor := crHandPoint;
  ImageEmpresa.Picture.LoadFromFile(ExtractFilePath(Application.ExeName) + 'Pictures\LogoEmpresaPreta.png');
end;

procedure TFMain.PanelFavoritosClick(Sender: TObject);
begin
begin

  if Assigned(PainelPressionado) and (PainelPressionado <> Sender) then
  begin
    PainelPressionado.Color := clBtnFace;
    PainelPressionado.BevelOuter := bvRaised;
    PainelPressionado.BevelInner := bvNone;
  end;


  if PanelFavoritos.Color = $6B0C44 then
  begin

    PanelFavoritos.Color := clBtnFace;
    PanelFavoritos.BevelOuter := bvRaised;
    PanelFavoritos.BevelInner := bvNone;
    PainelPressionado := nil;
  end
  else
  begin

    PanelFavoritos.Color := $6B0C44;
    PanelFavoritos.BevelOuter := bvNone;
    PanelFavoritos.BevelInner := bvLowered;
    PainelPressionado := PanelFavoritos;
  end;
end;

end;



procedure TFMain.PanelGruposMouseEnter(Sender: TObject);
begin
  PanelGrupos.BevelOuter := bvRaised;
  PanelGrupos.Color := $00D6498F;
  PanelGrupos.Cursor := crHandPoint;
  ImageGrupos.Picture.LoadFromFile(ExtractFilePath(Application.ExeName) + 'Pictures\LogoGruposPreta.png');
end;

procedure TFMain.PanelGruposMouseLeave(Sender: TObject);
begin
  PanelGrupos.BevelOuter := bvNone;
  PanelGrupos.Color := $00121212;
  PanelGrupos.Cursor := crDefault;
  ImageGrupos.Picture.LoadFromFile(ExtractFilePath(Application.ExeName) + 'Pictures\LogoGruposRoxa.png');
end;

procedure TFMain.PanelImportExportMouseEnter(Sender: TObject);
begin
  PanelImportExport.BevelOuter := bvRaised;
  PanelImportExport.Color := $00D6498F;
  PanelImportExport.Cursor := crDefault;
  ImageImpExp.Picture.LoadFromFile(ExtractFilePath(Application.ExeName) + 'Pictures\ImpPreta.png');
end;

procedure TFMain.PanelImportExportMouseLeave(Sender: TObject);
begin
  PanelImportExport.BevelOuter := bvNone;
  PanelImportExport.Color := $00121212;
  PanelImportExport.Cursor := crDefault;
  ImageImpExp.Picture.LoadFromFile(ExtractFilePath(Application.ExeName) + 'Pictures\ImpRoxa.png');
end;

procedure TFMain.PanelMensagensMouseEnter(Sender: TObject);
begin
  PanelMensagens.BevelOuter := bvRaised;
  PanelMensagens.Color := $00D6498F;
  PanelMensagens.Cursor := crHandPoint;
  ImageMensagens.Picture.LoadFromFile(ExtractFilePath(Application.ExeName) + 'Pictures\LogoMensagensPreta.png');
end;

procedure TFMain.PanelMensagensMouseLeave(Sender: TObject);
begin
  PanelMensagens.BevelOuter := bvNone;
  PanelMensagens.Color := $00121212;
  PanelMensagens.Cursor := crDefault;
  ImageMensagens.Picture.LoadFromFile(ExtractFilePath(Application.ExeName) + 'Pictures\LogoMensagensRoxa.png');
end;

end.

