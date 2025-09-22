program Project2;

uses
  Vcl.Forms,
  uLogin in 'uLogin.pas' {FLogin},
  uMain in 'uMain.pas' {FMain},
  uCadastro in 'uCadastro.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFLogin, FLogin);
  Application.CreateForm(TFMain, FMain);
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
