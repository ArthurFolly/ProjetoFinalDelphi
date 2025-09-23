unit uCadastro;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Imaging.pngimage,
  Vcl.StdCtrls, Vcl.Mask;

type
  TFCadastro = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Label1: TLabel;
    Edit1: TEdit;
    Label2: TLabel;
    Edit2: TEdit;
    Label3: TLabel;
    MaskEdit1: TMaskEdit;
    Label4: TLabel;
    MaskEdit2: TMaskEdit;
    Label5: TLabel;
    Panel3: TPanel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FCadastro: TFCadastro;

implementation

{$R *.dfm}

end.
