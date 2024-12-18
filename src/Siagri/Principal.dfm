object frmPrincipal: TfrmPrincipal
  Left = 0
  Top = 0
  Caption = 'SIAGRI'
  ClientHeight = 441
  ClientWidth = 624
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  TextHeight = 15
  object pnlCadastro: TPanel
    Left = 0
    Top = 0
    Width = 624
    Height = 441
    Align = alClient
    TabOrder = 0
    object btProdutores: TButton
      Left = 120
      Top = 104
      Width = 400
      Height = 25
      Caption = 'Produtores'
      TabOrder = 0
      OnClick = btProdutoresClick
    end
    object btDistribuidores: TButton
      Left = 120
      Top = 137
      Width = 400
      Height = 25
      Caption = 'Distribuidores'
      TabOrder = 1
      OnClick = btDistribuidoresClick
    end
    object btNegociacoes: TButton
      Left = 120
      Top = 168
      Width = 400
      Height = 25
      Caption = 'Negocia'#231#245'es'
      TabOrder = 2
      OnClick = btNegociacoesClick
    end
    object btRelatorio: TButton
      Left = 120
      Top = 200
      Width = 400
      Height = 25
      Caption = 'Relat'#243'rio'
      TabOrder = 3
    end
    object btProdutos: TButton
      Left = 120
      Top = 72
      Width = 400
      Height = 25
      Caption = 'Produtos'
      TabOrder = 4
      OnClick = btProdutosClick
    end
  end
end
