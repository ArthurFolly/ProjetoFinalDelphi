object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 681
  ClientWidth = 1248
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnCreate = FormCreate
  TextHeight = 15
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 1264
    Height = 720
    Caption = 'Panel1'
    TabOrder = 0
    object Panel2: TPanel
      Left = -16
      Top = 0
      Width = 1248
      Height = 681
      Color = 2561564
      ParentBackground = False
      TabOrder = 0
      object Label1: TLabel
        Left = 272
        Top = 56
        Width = 122
        Height = 40
        Caption = 'Cadastro'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -29
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label2: TLabel
        Left = 104
        Top = 131
        Width = 115
        Height = 21
        Caption = 'Nome Completo'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -16
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
      end
      object Label3: TLabel
        Left = 104
        Top = 220
        Width = 44
        Height = 21
        Caption = 'E-mail'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -16
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
      end
      object Label4: TLabel
        Left = 104
        Top = 332
        Width = 131
        Height = 21
        Caption = 'Numero Telefonico'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -16
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
      end
      object Label5: TLabel
        Left = 104
        Top = 424
        Width = 27
        Height = 21
        Caption = 'CPF'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -16
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
      end
      object EdtNome: TEdit
        Left = 104
        Top = 166
        Width = 377
        Height = 23
        TabOrder = 0
        TextHint = 'Escreva seu nome completo'
      end
      object EdtEmail: TEdit
        Left = 104
        Top = 255
        Width = 377
        Height = 23
        TabOrder = 1
        TextHint = 'Escreva seu e-mail'
      end
      object EdtNumero: TMaskEdit
        Left = 104
        Top = 368
        Width = 131
        Height = 23
        EditMask = '!\(99\)0000-0000;1;_'
        MaxLength = 13
        TabOrder = 2
        Text = '(  )    -    '
      end
      object EdtCPF: TMaskEdit
        Left = 104
        Top = 464
        Width = 131
        Height = 23
        EditMask = '___.___.___-__;1;_'
        MaxLength = 14
        TabOrder = 3
        Text = '___.___.___-__'
      end
      object Panel3: TPanel
        Left = 152
        Top = 544
        Width = 337
        Height = 49
        Caption = 'Cadastrar'
        Color = 14043535
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -16
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentBackground = False
        ParentFont = False
        TabOrder = 4
        OnClick = Panel3Click
      end
    end
  end
end
