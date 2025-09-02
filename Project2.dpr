program Project2;

uses
  Vcl.Forms,
  uLogin in 'uLogin.pas' {FLogin},
  uMain in 'uMain.pas' {FMain};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFLogin, FLogin);
  Application.CreateForm(TFMain, FMain);
  Application.Run;
end.
