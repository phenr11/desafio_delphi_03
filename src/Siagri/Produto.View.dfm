object frmProduto: TfrmProduto
  Left = 0
  Top = 0
  Caption = 'Produto'
  ClientHeight = 441
  ClientWidth = 624
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  TextHeight = 15
  object pcPrincipal: TPageControl
    Left = 0
    Top = 0
    Width = 624
    Height = 441
    ActivePage = tsProdutos
    Align = alClient
    TabOrder = 0
    object tsProdutos: TTabSheet
      Caption = 'Produtos'
      object shapeProdutos: TShape
        Left = 0
        Top = 41
        Width = 616
        Height = 1
        Align = alTop
        ExplicitWidth = 650
      end
      object gridCadastro: TDBGrid
        Left = 0
        Top = 42
        Width = 616
        Height = 344
        Align = alClient
        DataSource = dsProduto
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = 'Segoe UI'
        TitleFont.Style = []
        Columns = <
          item
            Expanded = False
            FieldName = 'PRODUTO_ID'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'NOME'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'PRECO_VENDA'
            Visible = True
          end>
      end
      object DBNavigator: TDBNavigator
        Left = 0
        Top = 386
        Width = 616
        Height = 25
        DataSource = dsProduto
        VisibleButtons = [nbFirst, nbPrior, nbNext, nbLast, nbEdit, nbPost, nbCancel, nbRefresh]
        Align = alBottom
        TabOrder = 1
      end
      object pnlCadastro: TPanel
        Left = 0
        Top = 0
        Width = 616
        Height = 41
        Align = alTop
        TabOrder = 2
        object lblNome: TLabel
          Left = 4
          Top = 11
          Width = 33
          Height = 15
          Caption = 'Nome'
          Enabled = False
        end
        object lblPrecoVenda: TLabel
          Left = 381
          Top = 11
          Width = 30
          Height = 15
          AutoSize = False
          Caption = 'Pre'#231'o'
          Enabled = False
        end
        object btCadastrarSalvarProdutos: TButton
          Left = 549
          Top = 8
          Width = 64
          Height = 23
          Caption = 'Cadastrar'
          TabOrder = 2
          OnClick = btCadastrarSalvarProdutosClick
        end
        object editNome: TEdit
          Left = 41
          Top = 8
          Width = 334
          Height = 23
          Enabled = False
          MaxLength = 40
          TabOrder = 0
        end
        object editPrecoVenda: TEdit
          Left = 415
          Top = 8
          Width = 128
          Height = 23
          Enabled = False
          MaxLength = 14
          TabOrder = 1
          Text = 'Ex.: 1239,00'
        end
      end
    end
  end
  object dsProduto: TDataSource
    DataSet = qryProduto
    Left = 556
    Top = 290
  end
  object qryProduto: TFDQuery
    Connection = dmConexao.FDConnection
    SQL.Strings = (
      'SELECT'
      '    PRODUTO_ID,'
      '    NOME,'
      '    PRECO_VENDA'
      'FROM'
      '    PRODUTO'
      'ORDER BY'
      '    PRODUTO_ID    ')
    Left = 500
    Top = 290
    object qryProdutoPRODUTO_ID: TIntegerField
      DisplayLabel = 'IDENTIFICADOR'
      FieldName = 'PRODUTO_ID'
      Origin = 'PRODUTO_ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      ReadOnly = True
      Required = True
    end
    object qryProdutoNOME: TStringField
      FieldName = 'NOME'
      Origin = 'NOME'
      Size = 40
    end
    object qryProdutoPRECO_VENDA: TFMTBCDField
      DisplayLabel = 'PRE'#199'O'
      FieldName = 'PRECO_VENDA'
      Origin = 'PRECO_VENDA'
      Precision = 18
      Size = 2
    end
  end
end
