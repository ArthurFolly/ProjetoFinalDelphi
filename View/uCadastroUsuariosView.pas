unit uCadastroUsuariosView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Mask, Vcl.StdCtrls, Vcl.ExtCtrls, uMain,CadastroUsuarioController,
  Vcl.Imaging.jpeg,TUsuarioRepository, TUsuarioModel,uLogin;

type
  TFormCadastroUsuario = class(TForm)
    PanelFundo: TPanel;
    Panel2: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    EdtNome: TEdit;
    EdtEmail: TEdit;
    EdtNumero: TMaskEdit;
    EdtCPF: TMaskEdit;
    Panel3: TPanel;
    EdtSenha: TEdit;
    Image1: TImage;
    Label6: TLabel;
    Label7: TLabel;
    procedure Panel3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure EdtNomeKeyPress(Sender: TObject; var Key: Char);
    procedure EdtEmailKeyPress(Sender: TObject; var Key: Char);
    procedure EdtNumeroKeyPress(Sender: TObject; var Key: Char);
    procedure EdtCPFKeyPress(Sender: TObject; var Key: Char);
     procedure FormDestroy(Sender: TObject);
    procedure EdtSenhaKeyPress(Sender: TObject; var Key: Char);
    procedure Label7Click(Sender: TObject);
    procedure Panel3MouseEnter(Sender: TObject);
    procedure Panel3MouseLeave(Sender: TObject);
  private
  controller: UsuarioController;
   procedure  LimparCampos;
  public

    function ValidarCampos: Boolean;
    function ValidarNumero: Boolean;
    function ValidarCPF: Boolean;

  end;

var
  FormCadastroUsuario: TFormCadastroUsuario;

implementation

{$R *.dfm}

{ TForm1 }

procedure TFormCadastroUsuario.FormCreate(Sender: TObject);
begin



  // Inicializa o texto vazio
  EdtCPF.Text := '';
  EdtNumero.Text := '';

  // Agora aplica a máscara
  EdtCPF.EditMask := '000\.000\.000\-00;1;_';
  EdtNumero.EditMask := '(00) 00000-0000;1;_';

  // Define a ordem de tabulação
  EdtNome.TabOrder := 0;
  EdtEmail.TabOrder := 1;
  EdtNumero.TabOrder := 2;
  EdtCPF.TabOrder := 3;
  Panel3.TabOrder := 4;

  controller := UsuarioController.Create;
  FLogin := TFLogin.Create(Application);
end;




procedure TFormCadastroUsuario.FormDestroy(Sender: TObject);
begin
  controller.Free;
end;

procedure TFormCadastroUsuario.Label7Click(Sender: TObject);
begin


Self.Hide;

FLogin.WindowState := wsMaximized;

FLogin.Show;


end;

procedure TFormCadastroUsuario.LimparCampos;
begin
  EdtNome.Clear;
  EdtEmail.Clear;
  EdtNumero.Text := '';
  EdtCPF.Text := '';
  EdtSenha.Clear;
  EdtNome.SetFocus;

end;


procedure TFormCadastroUsuario.EdtNomeKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then // Enter
  begin
    Key := #0; // Impede o beep
    EdtEmail.SetFocus;
  end;
end;

procedure TFormCadastroUsuario.EdtEmailKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then // Enter
  begin
    Key := #0; // Impede o beep
    EdtNumero.SetFocus;
  end;
end;


procedure TFormCadastroUsuario.EdtNumeroKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    EdtCPF.SetFocus;
  end;
end;



procedure TFormCadastroUsuario.EdtSenhaKeyPress(Sender: TObject; var Key: Char);
begin
if Key = #13 then
  begin
    Key := #0;
    Panel3Click(nil);
  end;


end;

procedure TFormCadastroUsuario.EdtCPFKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    Panel3Click(nil);
  end;
end;

procedure TFormCadastroUsuario.Panel3Click(Sender: TObject);

var email,nome,CPF,senha,numero,msgErro : String;
var id :Integer;

begin
  if not ValidarCampos then begin
    exit;
  end;
  email := EdtEmail.Text;
  nome := EdtNome.Text;
  numero := EdtNumero.Text;
  CPF := EdtCPF.Text;
  senha := EdtSenha.Text;




  if controller.CadastrarUsuario(id, senha, email, CPF, nome, numero, msgErro) then
  begin
    ShowMessage('Usuário cadastrado com sucesso!');
    LimparCampos;
  end
  else
  begin
    ShowMessage('Erro ao cadastrar usuário: ' + msgErro);
  end;





end;
procedure TFormCadastroUsuario.Panel3MouseEnter(Sender: TObject);
begin
Panel3.Color := $00DB5B9B;
end;

procedure TFormCadastroUsuario.Panel3MouseLeave(Sender: TObject);
begin
Panel3.Color := $00D6498F;
end;

function TFormCadastroUsuario.ValidarNumero: Boolean;
var
  NumeroLimpo: string;
begin
  Result := False;

  // Remove a máscara para validar
  NumeroLimpo := StringReplace(EdtNumero.Text, '(', '', [rfReplaceAll]);
  NumeroLimpo := StringReplace(NumeroLimpo, ')', '', [rfReplaceAll]);
  NumeroLimpo := StringReplace(NumeroLimpo, ' ', '', [rfReplaceAll]);
  NumeroLimpo := StringReplace(NumeroLimpo, '-', '', [rfReplaceAll]);
  NumeroLimpo := StringReplace(NumeroLimpo, '_', '', [rfReplaceAll]);

  // Verifica se tem 11 dígitos (celular) ou 10 dígitos (fixo)
  if (Length(NumeroLimpo) = 11) or (Length(NumeroLimpo) = 10) then
    Result := True;
end;

function TFormCadastroUsuario.ValidarCPF: Boolean;
var
  CPFLimpo: string;
begin
  Result := False;

  // Remove a máscara para validar
  CPFLimpo := StringReplace(EdtCPF.Text, '.', '', [rfReplaceAll]);
  CPFLimpo := StringReplace(CPFLimpo, '-', '', [rfReplaceAll]);
  CPFLimpo := StringReplace(CPFLimpo, '_', '', [rfReplaceAll]);

  // Verifica se tem 11 dígitos
  if Length(CPFLimpo) = 11 then
    Result := True;
end;

function TFormCadastroUsuario.ValidarCampos: Boolean;
begin
  Result := False;

  // Validação do nome
  if Trim(EdtNome.Text) = '' then
  begin
    ShowMessage('O campo Nome não pode estar vazio.');
    EdtNome.SetFocus;
    Exit;
  end;

  // Validação do e-mail
  if Trim(EdtEmail.Text) = '' then
  begin
    ShowMessage('O campo E-mail não pode estar vazio.');
    EdtEmail.SetFocus;
    Exit;
  end;

  // Validação básica do formato do e-mail
  if Pos('@', EdtEmail.Text) = 0 then
  begin
    ShowMessage('O e-mail deve conter o símbolo @.');
    EdtEmail.SetFocus;
    Exit;
  end;

  // Validação do número usando a nova função
  if not ValidarNumero then
  begin
    ShowMessage('O campo Número está vazio ou incompleto.');
    EdtNumero.SetFocus;
    Exit;
  end;

  // Validação do CPF usando a nova função
  if not ValidarCPF then
  begin
    ShowMessage('O campo CPF está vazio ou incompleto.');
    EdtCPF.SetFocus;
    Exit;
  end;
  if Trim(EdtSenha.Text) = ''  then
  begin
    ShowMessage(' O campo senha  não pode estar vazio');
    EdtSenha.SetFocus;
  end;


  Result := True;
end;

end.
