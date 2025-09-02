unit uMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Imaging.jpeg,
  Vcl.Imaging.pngimage, Vcl.StdCtrls;

type
  TFMain = class(TForm)
    Fundo: TImage;
    Panel1: TPanel;
    Logo: TImage;
    Label1: TLabel;
    Panel2: TPanel;
    Image1: TImage;
    procedure LogoClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FMain: TFMain;

implementation

{$R *.dfm}

procedure TFMain.FormCreate(Sender: TObject);
begin

if (windowstate = wsMaximized) then begin

Logo.Width := 120


end else begin

Logo.Width := 80


end;



end;

procedure TFMain.LogoClick(Sender: TObject);
begin
Logo.Stretch := True;
Logo.Proportional := True;
Logo.Center := True;
end;

end.
