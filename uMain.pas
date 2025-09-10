unit uMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Imaging.jpeg,
  Vcl.Imaging.pngimage, Vcl.StdCtrls, Vcl.ComCtrls;

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
    PageControl1: TPageControl;
    AbaContatos: TTabSheet;
    AbaFavoritos: TTabSheet;
    Panel2: TPanel;
    Image1: TImage;
    Panel3: TPanel;
    Image2: TImage;
    AbaGrupos: TTabSheet;
    AbaMensagens: TTabSheet;
    TabSheet3: TTabSheet;
    AbaImpExp: TTabSheet;
    AbaConfigurações: TTabSheet;
    Panel4: TPanel;
    procedure FormResize(Sender: TObject);
    procedure LogoClick(Sender: TObject);
    procedure PanelContatosMouseEnter(Sender: TObject);
    procedure PanelContatosMouseLeave(Sender: TObject);
    procedure PanelFavoritosMouseEnter(Sender: TObject);
    procedure PanelFavoritosMouseLeave(Sender: TObject);
    procedure PanelContatosClick(Sender: TObject);
    procedure ContactHubClick(Sender: TObject);
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
    procedure PanelFavoritosClick(Sender: TObject);
    procedure PanelGruposClick(Sender: TObject);
    procedure PanelMensagensClick(Sender: TObject);
    procedure PanelEmpresaClick(Sender: TObject);
    procedure PanelImportExportClick(Sender: TObject);
    procedure PanelConfiguracaoClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FMain: TFMain;

implementation

{$R *.dfm}

procedure TFMain.ContactHubClick(Sender: TObject);
begin
  PageControl1.Visible := False;
  PanelForm.Visible := True;
end;

procedure TFMain.FormResize(Sender: TObject);
begin
  if (WindowState = wsMaximized) then begin


    // Responsividade Panel ContactHub
    Logo.Width := 100;
    Logo.Height := 90;
    ContactHub.Font.Size := 20;
    ContactHub.alignment := taCenter;


    // Responsividade Panel Contatos
    ImageConfig.Width := 32;
    ImageConfig.Height := 32;
    ImageConfig.Margins.Top := 10;
    imageConfig.Align := alLeft;

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

    //Responsividade Panel Mensagens
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
  else begin
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


procedure TFMain.PanelConfiguracaoClick(Sender: TObject);
begin
PageControl1.ActivePageIndex := 6;
PageControl1.Show;
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
PageControl1.ActivePageIndex := 0;
PageControl1.Show;


end;

procedure TFMain.PanelContatosMouseEnter(Sender: TObject);
begin
   PanelContatos.BevelOuter := bvRaised;
   PanelContatos.Color := $00D6498F;
   PanelContatos.Cursor := crHandPoint;
   // Carrega a imagem alternativa do ícone de contatos
   ImageContato.Picture.LoadFromFile(ExtractFilePath(Application.ExeName) + 'Pictures\iconcontatos2.png');
end;

procedure TFMain.PanelContatosMouseLeave(Sender: TObject);
begin
  PanelContatos.BevelOuter := bvNone;
  PanelContatos.Color := $00121212;
  PanelContatos.Cursor := crDefault;
  // Carrega a imagem padrão do ícone de contatos
  ImageContato.Picture.LoadFromFile(ExtractFilePath(Application.ExeName) + 'Pictures\iconcontatos.png');
end;

procedure TFMain.PanelEmpresaClick(Sender: TObject);
begin
PageControl1.ActivePageIndex := 4;
PageControl1.Show;
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
PageControl1.ActivePageIndex := 1;
PageControl1.Show;
end;

procedure TFMain.PanelFavoritosMouseEnter(Sender: TObject);
begin
   PanelFavoritos.BevelOuter := bvRaised;
   PanelFavoritos.Color := $00D6498F;
   PanelFavoritos.Cursor := crHandPoint;
   ImageFavoritos.Picture.LoadFromFile(ExtractFilePath(Application.ExeName) + 'Pictures\favoritospreto.png');
end;

procedure TFMain.PanelFavoritosMouseLeave(Sender: TObject);
begin
  PanelFavoritos.BevelOuter := bvNone;
  PanelFavoritos.Color := $00121212;
  PanelFavoritos.Cursor := crDefault;
  ImageFavoritos.Picture.LoadFromFile(ExtractFilePath(Application.ExeName) + 'Pictures\favoritosoriginal.png');
end;

procedure TFMain.PanelGruposClick(Sender: TObject);
begin
PageControl1.ActivePageIndex := 2;
PageControl1.Show;
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

procedure TFMain.PanelImportExportClick(Sender: TObject);
begin
PageControl1.ActivePageIndex := 5;
PageControl1.Show;
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

procedure TFMain.PanelMensagensClick(Sender: TObject);
begin
PageControl1.ActivePageIndex := 3;
PageControl1.Show;
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
