﻿unit uLogin;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Skia, Vcl.StdCtrls,
  Vcl.Imaging.jpeg, Vcl.Imaging.pngimage, uMain,TUsuarioRepository,LoginUsuarioController,TUsuarioModel,firedac.DApt;

type
  TFLogin = class(TForm)
    Logo: TImage;
    PanelLogin: TPanel;
    Contact: TLabel;
    Clique: TLabel;
    Image2: TImage;
    EditEmail: TEdit;
    EditSenha: TEdit;
    Panel1: TPanel;
    Panel2: TPanel;
    BtnMostrarSenha: TButton;
    procedure CliqueMouseEnter(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure Panel1Click(Sender: TObject);
    procedure CliqueClick(Sender: TObject);
    procedure Panel1MouseEnter(Sender: TObject);
    procedure Panel1MouseLeave(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure BtnMostrarSenhaClick(Sender: TObject);
    procedure CliqueMouseLeave(Sender: TObject);
  private

  LoginUsuarioController : TLoginUsuarioController;
  public



  end;

var
  FLogin: TFLogin;

implementation

  uses uCadastroUsuariosView,System.Hash;

{$R *.dfm}

procedure TFLogin.FormCreate(Sender: TObject);
begin

LoginUsuarioController := TLoginUsuarioController.Create;
end;

procedure TFLogin.FormDestroy(Sender: TObject);
begin

LoginUsuarioController.Free;
end;

procedure TFLogin.FormResize(Sender: TObject);
begin
  if(windowstate = wsMaximized) then begin
    clique.Margins.Bottom :=330;
    contact.Margins.Top := 130;
    Image2.width := 240;
    Image2.Height := 130;
  end else  begin
    clique.Margins.Bottom := 130;
    contact.Margins.Top := 30;
    Image2.Width := 128;
    Image2.Height := 105;
  end;




end;



procedure TFLogin.Panel1Click(Sender: TObject);

 var Usuario :TUsuario;
     Mensagem : String;

begin

if (Trim(EditEmail.Text) = '') or  (Trim(EditSenha.Text) = '') then begin
  if Trim(EditEmail.Text) = '' then  begin
   ShowMessage('Preencha os campos, Corretamente');
  EditEmail.SetFocus;







  end else  begin


    EditSenha.SetFocus;

  end;

  Exit;


end;



Usuario := LoginUsuarioController.Login(EditEmail.Text, EditSenha.Text,Mensagem);

  if Assigned(Usuario) then begin

    ShowMessage('Login realizado com sucesso! Bem-vindo, ' + Usuario.Nome);
    EditEmail.Clear;
    EditSenha.Clear;


    Self.Hide;


    if WindowState = wsMaximized then

      FMain.WindowState := wsMaximized
    else
      FMain.WindowState := wsNormal;

    FMain.Show;

  end else begin

    ShowMessage(Mensagem);
    EditSenha.Clear;
    EditSenha.SetFocus;
  end;
end;



procedure TFLogin.Panel1MouseEnter(Sender: TObject);
  begin
    Panel1.Color := $00DB5B9B;
    Panel1.font.style := [fsUnderline];
  end;

procedure TFLogin.Panel1MouseLeave(Sender: TObject);
  begin
    Panel1.Color := $00D6498F;
    Panel1.font.style := [];

  end;

procedure TFLogin.BtnMostrarSenhaClick(Sender: TObject);
begin
  if EditSenha.PasswordChar = '*' then begin

    EditSenha.PasswordChar := #0;
    BtnMostrarSenha.Caption := '🙈';
  end else begin

    EditSenha.PasswordChar := '*';
    BtnMostrarSenha.Caption := '👁';
end;
end;

procedure TFLogin.CliqueClick(Sender: TObject);
begin
if (windowstate = wsMaximized) then begin

Self.Hide;

FormCadastroUsuario.WindowState := wsMaximized;

FormCadastroUsuario.Show;




end else begin



Self.hide;

FormCadastroUsuario.WindowState := wsNormal;

FormCadastroUsuario.Show;

end;
end;

procedure TFLogin.CliqueMouseEnter(Sender: TObject);
begin
  Clique.font.style := [fsUnderline];
end;

procedure TFLogin.CliqueMouseLeave(Sender: TObject);
begin
  Clique.font.style := [];
end;

end.
