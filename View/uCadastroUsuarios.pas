unit uCadastroUsuarios;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Mask, Vcl.StdCtrls, Vcl.ExtCtrls, uMain;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
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
    procedure Panel3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    function ValidarCampos: Boolean;
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
begin
  // Inicializa o texto vazio
  EdtCPF.Text := '';
  EdtNumero.Text := '';

  // Agora aplica a máscara
  EdtCPF.EditMask := '000\.000\.000\-00;1;_';
  EdtNumero.EditMask := '(00) 00000-0000;1;_';
end;



procedure TForm1.Panel3Click(Sender: TObject);
begin
  // Ao clicar no painel, validar os campos
  if ValidarCampos then
    ShowMessage('Todos os campos estão corretos. Cadastro realizado com sucesso!');
end;

function TForm1.ValidarCampos: Boolean;
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

  // Validação do número (MaskEdit)
  if Pos('_', EdtNumero.Text) > 0 then
  begin
    ShowMessage('O campo Número está vazio ou incompleto.');
    EdtNumero.SetFocus;
    Exit;
  end;

  // Validação do CPF (MaskEdit)
  if Pos('_', EdtCPF.Text) > 0 then
  begin
    ShowMessage('O campo CPF está vazio ou incompleto.');
    EdtCPF.SetFocus;
    Exit;
  end;

  Result := True;
end;

end.

