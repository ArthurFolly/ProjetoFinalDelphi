program ContactHub;

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
  ContatosRepository in 'Repository\ContatosRepository.pas',
  FavoritosRepository in 'Repository\FavoritosRepository.pas',
  FavoritosController in 'Controller\FavoritosController.pas',
  FavoritosModel in 'Model\FavoritosModel.pas',
  EmpresaRepository in 'Repository\EmpresaRepository.pas',
  EmpresaModel in 'Model\EmpresaModel.pas',
  EmpresaController in 'Controller\EmpresaController.pas',
  MensagensRepository in 'Repository\MensagensRepository.pas',
  MensagensController in 'Controller\MensagensController.pas',
  MensagensModel in 'Model\MensagensModel.pas',
  GruposRepository in 'Repository\GruposRepository.pas',
  GruposController in 'Controller\GruposController.pas',
  GruposModel in 'Model\GruposModel.pas',
  PermissoesModel in 'Model\PermissoesModel.pas',
  PermissoesController in 'Controller\PermissoesController.pas',
  PermissoesRepository in 'Repository\PermissoesRepository.pas',
  VCardImportController in 'Controller\VCardImportController.pas',
  VCardImportRepository in 'Repository\VCardImportRepository.pas',
  UsuarioController in 'Controller\UsuarioController.pas';

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
