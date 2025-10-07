program Project2;

uses
  Vcl.Forms,
  uLogin in 'View\uLogin.pas' {FLogin},
  uMain in 'View\uMain.pas' {FMain},
  TUsuarioModel in 'Model\TUsuarioModel.pas',
  CadastroUsuarioController in 'Controller\CadastroUsuarioController.pas',
  TUsuarioRepository in 'Repository\TUsuarioRepository.pas',
  uCadastroUsuariosView in 'View\uCadastroUsuariosView.pas' {FormCadastroUsuario},
  ConexaoBanco in 'Repository\ConexaoBanco.pas' {DataModule1: TDataModule},
  LoginUsuarioController in 'Controller\LoginUsuarioController.pas',
  TContatosModel in 'Model\TContatosModel.pas',
  ContatosController in 'Controller\ContatosController.pas',
  ContatosRepository in 'Repository\ContatosRepository.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TDataModule1, DataModule1);
  Application.CreateForm(TFLogin, FLogin);
  Application.CreateForm(TFormCadastroUsuario, FormCadastroUsuario);
  Application.CreateForm(TFMain, FMain);
  Application.Run;
end.
