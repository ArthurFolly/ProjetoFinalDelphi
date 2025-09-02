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
    Panel2: TPanel;
    Image1: TImage;
    Panel6: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    Panel7: TPanel;
    Panel8: TPanel;
    ContactHub: TPanel;
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

Logo.Width := 120;

Panel2.Margins.Top := 20;


end else begin

Logo.Width := 80;

Panel2.Margins.Top := 8;


end;



end;

procedure TFMain.LogoClick(Sender: TObject);
begin
Logo.Stretch := True;
Logo.Proportional := True;
Logo.Center := True;
end;

end.
