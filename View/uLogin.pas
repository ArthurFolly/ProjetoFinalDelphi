unit uLogin;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Skia, Vcl.StdCtrls,
  Vcl.Imaging.jpeg, Vcl.Imaging.pngimage, uMain, uCadastro;

type
  TFLogin = class(TForm)
    Logo: TImage;
    PanelLogin: TPanel;
    Contact: TLabel;
    Clique: TLabel;
    Image2: TImage;
    EditLogin: TEdit;
    EditSenha: TEdit;
    Panel1: TPanel;
    Panel2: TPanel;
    procedure CliqueMouseEnter(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure Panel1Click(Sender: TObject);
    procedure CliqueClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FLogin: TFLogin;

implementation

{$R *.dfm}

procedure TFLogin.FormResize(Sender: TObject);
begin
  if(windowstate = wsMaximized) then begin
    clique.Margins.Bottom :=330;
    contact.Margins.Top := 130;
    Image2.width := 240;
    Image2.Height := 130;
  end else  begin
    clique.Margins.Bottom := 130;
    contact.Margins.Top := 30;
    Image2.Width := 128;
    Image2.Height := 105;
  end;




end;

procedure TFLogin.Panel1Click(Sender: TObject);
begin

if (windowstate = wsMaximized) then begin

Self.Hide;

FMain.WindowState := wsMaximized;

FMain.Show;

end else begin

Self.hide;

FMain.WindowState := wsNormal;

FMain.Show;

end;

end;

procedure TFLogin.CliqueClick(Sender: TObject);
begin
if (windowstate = wsMaximized) then begin

Self.Hide;

FMain.WindowState := wsMaximized;

FCadastro.Show;




end else begin
Self.hide;

FMain.WindowState := wsNormal;

FCadastro.Show;

end;
end;

procedure TFLogin.CliqueMouseEnter(Sender: TObject);
begin
  Clique.font.style := [fsUnderline];
end;

end.
