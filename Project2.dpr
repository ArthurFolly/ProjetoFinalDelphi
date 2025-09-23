program Project2;

uses
  Vcl.Forms,
  uLogin in 'View\uLogin.pas' {FLogin},
  uMain in 'View\uMain.pas' {FMain},
  TUsuarioModel in 'Model\TUsuarioModel.pas',
  CadastroUsuarioController in 'Controller\CadastroUsuarioController.pas',
  CadastroUsuarioService in 'Service\CadastroUsuarioService.pas',
  CadastroUsuarioRepository in 'Repository\CadastroUsuarioRepository.pas',
  uCadastroUsuarios in 'View\uCadastroUsuarios.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TFLogin, FLogin);
  Application.CreateForm(TFMain, FMain);
  Application.Run;
end.
