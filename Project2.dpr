program Project2;

uses
  Vcl.Forms,
  uLogin in 'View\uLogin.pas' {FLogin},
  uMain in 'View\uMain.pas' {FMain},
  TUsuarioModel in 'Model\TUsuarioModel.pas',
  CadastroUsuarioController in 'Controller\CadastroUsuarioController.pas',
  CadastroUsuarioRepository in 'Repository\CadastroUsuarioRepository.pas',
  uCadastroUsuarios in 'View\uCadastroUsuarios.pas' {FormCadastroUsuario},
  ConexaoBanco in 'Repository\ConexaoBanco.pas' {DataModule1: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFMain, FMain);
  Application.CreateForm(TFormCadastroUsuario, FormCadastroUsuario);
  Application.CreateForm(TFLogin, FLogin);
  Application.CreateForm(TDataModule1, DataModule1);
  Application.Run;
end.
