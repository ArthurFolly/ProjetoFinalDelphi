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
    procedure EdtNomeKeyPress(Sender: TObject; var Key: Char);
    procedure EdtEmailKeyPress(Sender: TObject; var Key: Char);
    procedure EdtNumeroKeyPress(Sender: TObject; var Key: Char);
    procedure EdtCPFKeyPress(Sender: TObject; var Key: Char);

  private
    { Private declarations }
  public
    function ValidarCampos: Boolean;
    function ValidarNumero: Boolean;
    function ValidarCPF: Boolean;
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

  // Agora aplica a m�scara
  EdtCPF.EditMask := '000\.000\.000\-00;1;_';
  EdtNumero.EditMask := '(00) 00000-0000;1;_';

  // Define a ordem de tabula��o
  EdtNome.TabOrder := 0;
  EdtEmail.TabOrder := 1;
  EdtNumero.TabOrder := 2;
  EdtCPF.TabOrder := 3;
  Panel3.TabOrder := 4;
end;



// Eventos KeyPress para navega��o com Enter
procedure TForm1.EdtNomeKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then // Enter
  begin
    Key := #0; // Impede o beep
    EdtEmail.SetFocus;
  end;
end;

procedure TForm1.EdtEmailKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then // Enter
  begin
    Key := #0; // Impede o beep
    EdtNumero.SetFocus;
  end;
end;

procedure TForm1.EdtNumeroKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then // Enter
  begin
    Key := #0; // Impede o beep
    EdtCPF.SetFocus;
  end;
end;

procedure TForm1.EdtCPFKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then // Enter
  begin
    Key := #0; // Impede o beep
    Panel3Click(nil); // Executa a valida��o
  end;
end;

procedure TForm1.Panel3Click(Sender: TObject);
begin
  // Ao clicar no painel, validar os campos
  if ValidarCampos then
    ShowMessage('Todos os campos est�o corretos. Cadastro realizado com sucesso!');
end;

function TForm1.ValidarNumero: Boolean;
var
  NumeroLimpo: string;
begin
  Result := False;

  // Remove a m�scara para validar
  NumeroLimpo := StringReplace(EdtNumero.Text, '(', '', [rfReplaceAll]);
  NumeroLimpo := StringReplace(NumeroLimpo, ')', '', [rfReplaceAll]);
  NumeroLimpo := StringReplace(NumeroLimpo, ' ', '', [rfReplaceAll]);
  NumeroLimpo := StringReplace(NumeroLimpo, '-', '', [rfReplaceAll]);
  NumeroLimpo := StringReplace(NumeroLimpo, '_', '', [rfReplaceAll]);

  // Verifica se tem 11 d�gitos (celular) ou 10 d�gitos (fixo)
  if (Length(NumeroLimpo) = 11) or (Length(NumeroLimpo) = 10) then
    Result := True;
end;

function TForm1.ValidarCPF: Boolean;
var
  CPFLimpo: string;
begin
  Result := False;

  // Remove a m�scara para validar
  CPFLimpo := StringReplace(EdtCPF.Text, '.', '', [rfReplaceAll]);
  CPFLimpo := StringReplace(CPFLimpo, '-', '', [rfReplaceAll]);
  CPFLimpo := StringReplace(CPFLimpo, '_', '', [rfReplaceAll]);

  // Verifica se tem 11 d�gitos
  if Length(CPFLimpo) = 11 then
    Result := True;
end;

function TForm1.ValidarCampos: Boolean;
begin
  Result := False;

  // Valida��o do nome
  if Trim(EdtNome.Text) = '' then
  begin
    ShowMessage('O campo Nome n�o pode estar vazio.');
    EdtNome.SetFocus;
    Exit;
  end;

  // Valida��o do e-mail
  if Trim(EdtEmail.Text) = '' then
  begin
    ShowMessage('O campo E-mail n�o pode estar vazio.');
    EdtEmail.SetFocus;
    Exit;
  end;

  // Valida��o b�sica do formato do e-mail
  if Pos('@', EdtEmail.Text) = 0 then
  begin
    ShowMessage('O e-mail deve conter o s�mbolo @.');
    EdtEmail.SetFocus;
    Exit;
  end;

  // Valida��o do n�mero usando a nova fun��o
  if not ValidarNumero then
  begin
    ShowMessage('O campo N�mero est� vazio ou incompleto.');
    EdtNumero.SetFocus;
    Exit;
  end;

  // Valida��o do CPF usando a nova fun��o
  if not ValidarCPF then
  begin
    ShowMessage('O campo CPF est� vazio ou incompleto.');
    EdtCPF.SetFocus;
    Exit;
  end;

  Result := True;
end;

end.
