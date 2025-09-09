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
    ImageEmprsea: TImage;
    ImageImpExp: TImage;
    ImageConfig: TImage;
    PanelForm: TPanel;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    PanelAdicionar: TPanel;
    procedure FormResize(Sender: TObject);
    procedure LogoClick(Sender: TObject);
    procedure PanelContatosMouseEnter(Sender: TObject);
    procedure PanelContatosMouseLeave(Sender: TObject);
    procedure PanelFavoritosMouseEnter(Sender: TObject);
    procedure PanelFavoritosMouseLeave(Sender: TObject);
    procedure PanelContatosClick(Sender: TObject);
    procedure ContactHubClick(Sender: TObject); // 👈 adicionei aqui
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

procedure TFMain.PanelContatosClick(Sender: TObject);
begin

PageControl1.Show;

end;

procedure TFMain.PanelContatosMouseEnter(Sender: TObject);
begin
   PanelContatos.BevelOuter := bvRaised;
   PanelContatos.Color := $00D6498F;
   PanelContatos.Cursor := crHandPoint;
   imageContato.picture.LoadFromFile('C:\Users\Arthur Folly\Downloads\Pictures\iconcontatos2.png');
end;

procedure TFMain.PanelContatosMouseLeave(Sender: TObject);
begin
  PanelContatos.BevelOuter := BvNone;
  PanelContatos.Color := $00121212;
  PanelContatos.Cursor := crDefault;
  imageContato.Picture.LoadFromFile('C:\Users\Arthur Folly\Downloads\Pictures\iconcontatos.png');
end;



procedure TFMain.PanelFavoritosMouseEnter(Sender: TObject);
begin

   PanelFavoritos.BevelOuter := bvRaised;
   PanelFavoritos.Color := $00D6498F;
   PanelFavoritos.Cursor := crHandPoint;
   ImageFavoritos.picture.LoadFromFile('C:\Users\Arthur Folly\Downloads\Pictures\favoritospreto.png');


end;

procedure TFMain.PanelFavoritosMouseLeave(Sender: TObject);
begin
  PanelFavoritos.BevelOuter := BvNone;
  PanelFavoritos.Color := $00121212;
  PanelFavoritos.Cursor := crDefault;
  ImageFavoritos.Picture.LoadFromFile('C:\Users\Arthur Folly\Downloads\Pictures\favoritosoriginal.png');
end;




end.

