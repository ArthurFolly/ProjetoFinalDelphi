program Project2;

uses
  Vcl.Forms,
  uLogin in 'uLogin.pas' {FLogin},
  uMain in 'uMain.pas' {FMain},
  uCadastro in 'uCadastro.pas' {FCadastro};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFLogin, FLogin);
  Application.CreateForm(TFMain, FMain);
  Application.CreateForm(TFCadastro, FCadastro);
  Application.Run;
end.
