object frmNegociacao: TfrmNegociacao
  Left = 0
  Top = 0
  Caption = 'Negocia'#231#227'o'
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
    ActivePage = tsManutencao
    Align = alClient
    TabOrder = 0
    OnChange = pcPrincipalChange
    OnChanging = pcPrincipalChanging
    object tsGeracao: TTabSheet
      Caption = 'Gera'#231#227'o'
      ImageIndex = 1
      object shapeLimiteCredito: TShape
        Left = 0
        Top = 68
        Width = 616
        Height = 1
        Align = alTop
        ExplicitTop = 41
      end
      object pnlLimiteCredito: TPanel
        Left = 0
        Top = 0
        Width = 616
        Height = 68
        Align = alTop
        TabOrder = 0
        object lblProdutor: TLabel
          Left = 4
          Top = 8
          Width = 47
          Height = 15
          Caption = 'Produtor'
          Enabled = False
        end
        object lblDistribuidor: TLabel
          Left = 265
          Top = 8
          Width = 62
          Height = 15
          Caption = 'Distribuidor'
          Enabled = False
        end
        object lblProduto: TLabel
          Left = 4
          Top = 44
          Width = 43
          Height = 15
          Caption = 'Produto'
          Enabled = False
        end
        object lblQuantidade: TLabel
          Left = 265
          Top = 45
          Width = 62
          Height = 15
          Caption = 'Quantidade'
          Enabled = False
        end
        object Shape2: TShape
          Left = 1
          Top = 34
          Width = 614
          Height = 1
          Pen.Style = psDot
        end
        object lblPreco: TLabel
          Left = 151
          Top = 44
          Width = 30
          Height = 15
          Caption = 'Pre'#231'o'
          Enabled = False
        end
        object lcbDistribuidor: TDBLookupComboBox
          Left = 331
          Top = 5
          Width = 212
          Height = 23
          Enabled = False
          KeyField = 'DISTRIBUIDOR_ID'
          ListField = 'NOME'
          ListSource = dsLookupDistribuidor
          TabOrder = 0
        end
        object lcbProdutor: TDBLookupComboBox
          Left = 55
          Top = 5
          Width = 204
          Height = 23
          Enabled = False
          KeyField = 'PRODUTOR_ID'
          ListField = 'NOME'
          ListSource = dsLookupProdutor
          TabOrder = 1
        end
        object btCadastrarSalvarNegociacao: TButton
          Left = 547
          Top = 5
          Width = 64
          Height = 23
          Caption = 'Cadastrar'
          TabOrder = 2
          OnClick = btCadastrarSalvarNegociacaoClick
        end
        object lcbProduto: TDBLookupComboBox
          Left = 55
          Top = 41
          Width = 90
          Height = 23
          Enabled = False
          KeyField = 'PRODUTO_ID'
          ListField = 'NOME;PRECO_VENDA'
          ListSource = dsLookupProduto
          TabOrder = 3
        end
        object editQuantidade: TEdit
          Left = 331
          Top = 41
          Width = 101
          Height = 23
          Enabled = False
          NumbersOnly = True
          TabOrder = 4
          Text = 'Ex.: 1239'
        end
        object btAdicionarProduto: TButton
          Left = 438
          Top = 41
          Width = 105
          Height = 23
          Hint = 
            'Necess'#225'rio incluir o produtor e distribuidor na negocia'#231#227'o para ' +
            'adicionar produto'
          Caption = 'Adicionar Produto'
          Enabled = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 5
          OnClick = btAdicionarProdutoClick
        end
        object dbEditPreco: TDBEdit
          Left = 185
          Top = 41
          Width = 74
          Height = 23
          DataField = 'PRECO_VENDA'
          DataSource = dsLookupProduto
          TabOrder = 6
        end
        object btConcluir: TButton
          Left = 549
          Top = 40
          Width = 64
          Height = 23
          Hint = 'Clique para concluir a negocia'#231#227'o, ap'#243's adicionar os produtos'
          Caption = 'Concluir'
          Enabled = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 7
          OnClick = btConcluirClick
        end
      end
      object gridLimiteCredito: TDBGrid
        Left = 0
        Top = 69
        Width = 616
        Height = 342
        Align = alClient
        DataSource = dsNegociacaoItem
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
        TabOrder = 1
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = 'Segoe UI'
        TitleFont.Style = []
        Columns = <
          item
            Expanded = False
            FieldName = 'CODIGO'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'NOME_PRODUTO'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'PRECO'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'QUANTIDADE'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'PRECO_TOTAL'
            Visible = True
          end>
      end
    end
    object tsManutencao: TTabSheet
      Caption = 'Manuten'#231#227'o'
      ImageIndex = 2
      object Shape1: TShape
        Left = 0
        Top = 0
        Width = 616
        Height = 1
        Align = alTop
        ExplicitTop = 73
      end
      object gridManutencao: TDBGrid
        Left = 0
        Top = 1
        Width = 616
        Height = 410
        Align = alClient
        DataSource = dsManutencao
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = 'Segoe UI'
        TitleFont.Style = []
        Columns = <
          item
            Expanded = False
            FieldName = 'NEGOCIACAO_ID'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'NOME_PRODUTOR'
            Width = 120
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'NOME_DISTRIBUIDOR'
            Width = 120
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'STATUS'
            Width = 60
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'DATA_CADASTRO'
            Width = 100
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'VALOR_TOTAL'
            Width = 100
            Visible = True
          end>
      end
    end
  end
  object qryLookupProdutor: TFDQuery
    Connection = dmConexao.FDConnection
    SQL.Strings = (
      'SELECT'
      '    PRODUTOR_ID,'
      '    NOME    '
      'FROM'
      '    PRODUTOR'
      'ORDER BY'
      '    PRODUTOR_ID    ')
    Left = 356
    Top = 362
    object qryLookupProdutorPRODUTOR_ID: TIntegerField
      FieldName = 'PRODUTOR_ID'
      Origin = 'PRODUTOR_ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object qryLookupProdutorNOME: TStringField
      FieldName = 'NOME'
      Origin = 'NOME'
      Size = 40
    end
  end
  object dsLookupProdutor: TDataSource
    DataSet = qryLookupProdutor
    Left = 404
    Top = 362
  end
  object qryLookupDistribuidor: TFDQuery
    Connection = dmConexao.FDConnection
    SQL.Strings = (
      'SELECT'
      '    DISTRIBUIDOR_ID,'
      '    NOME'
      'FROM'
      '    DISTRIBUIDOR'
      'ORDER BY'
      '    DISTRIBUIDOR_ID    ')
    Left = 508
    Top = 362
    object qryLookupDistribuidorDISTRIBUIDOR_ID: TIntegerField
      FieldName = 'DISTRIBUIDOR_ID'
      Origin = 'DISTRIBUIDOR_ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object qryLookupDistribuidorNOME: TStringField
      FieldName = 'NOME'
      Origin = 'NOME'
      Size = 40
    end
  end
  object dsLookupDistribuidor: TDataSource
    DataSet = qryLookupDistribuidor
    Left = 564
    Top = 362
  end
  object qryNegociacaoItem: TFDQuery
    Connection = dmConexao.FDConnection
    SQL.Strings = (
      'SELECT'
      '    NI.NEGOCIACAO_ITEM_ID AS CODIGO,'
      '    P.NOME AS NOME_PRODUTO,'
      '    P.PRECO_VENDA AS PRECO,'
      '    NI.QUANTIDADE,'
      '    NI.PRECO_TOTAL    '
      'FROM'
      '    NEGOCIACAO N'
      'INNER JOIN'
      '    NEGOCIACAO_ITEM NI ON NI.NEGOCIACAO_ID = N.NEGOCIACAO_ID'
      'INNER JOIN'
      '    PRODUTO P ON P.PRODUTO_ID = NI.PRODUTO_ID'
      'WHERE'
      '    N.NEGOCIACAO_ID = :P_NEGOCIACAO_ID'
      'ORDER BY'
      '    NI.NEGOCIACAO_ITEM_ID  ')
    Left = 356
    Top = 290
    ParamData = <
      item
        Name = 'P_NEGOCIACAO_ID'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
    object qryNegociacaoItemCODIGO: TIntegerField
      DisplayLabel = 'C'#211'DIGO'
      FieldName = 'CODIGO'
      Origin = 'CODIGO'
      Required = True
    end
    object qryNegociacaoItemNOME_PRODUTO: TStringField
      DisplayLabel = 'PRODUTO'
      FieldName = 'NOME_PRODUTO'
      Origin = 'NOME_PRODUTO'
      Size = 40
    end
    object qryNegociacaoItemPRECO: TFMTBCDField
      DisplayLabel = 'PRE'#199'O UND'
      FieldName = 'PRECO'
      Origin = 'PRECO'
      Precision = 18
      Size = 2
    end
    object qryNegociacaoItemQUANTIDADE: TIntegerField
      FieldName = 'QUANTIDADE'
      Origin = 'QUANTIDADE'
    end
    object qryNegociacaoItemPRECO_TOTAL: TIntegerField
      DisplayLabel = 'PRE'#199'O TOTAL'
      FieldName = 'PRECO_TOTAL'
      Origin = 'PRECO_TOTAL'
    end
  end
  object dsNegociacaoItem: TDataSource
    DataSet = qryNegociacaoItem
    Left = 404
    Top = 290
  end
  object qryLookupProduto: TFDQuery
    Connection = dmConexao.FDConnection
    SQL.Strings = (
      'SELECT'
      '    PRODUTO_ID,'
      '    NOME,'
      '    PRECO_VENDA    '
      'FROM'
      '    PRODUTO'
      'ORDER BY'
      '    PRODUTO_ID    ')
    Left = 212
    Top = 362
    object qryLookupProdutoPRODUTO_ID: TIntegerField
      FieldName = 'PRODUTO_ID'
      Origin = 'PRODUTO_ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object qryLookupProdutoNOME: TStringField
      FieldName = 'NOME'
      Origin = 'NOME'
      Size = 40
    end
    object qryLookupProdutoPRECO_VENDA: TFMTBCDField
      FieldName = 'PRECO_VENDA'
      Origin = 'PRECO_VENDA'
      Precision = 18
      Size = 2
    end
  end
  object dsLookupProduto: TDataSource
    DataSet = qryLookupProduto
    Left = 260
    Top = 362
  end
  object qryManutencao: TFDQuery
    Connection = dmConexao.FDConnection
    SQL.Strings = (
      'SELECT'
      '    N.NEGOCIACAO_ID,'
      '    P.NOME AS NOME_PRODUTOR,'
      '    D.NOME AS NOME_DISTRIBUIDOR,'
      '    N.STATUS,'
      '    N.DATA_CADASTRO,'
      '    N.VALOR_TOTAL'
      'FROM'
      '    NEGOCIACAO N'
      'INNER JOIN'
      '    PRODUTOR P ON P.PRODUTOR_ID = N.PRODUTOR_ID'
      'INNER JOIN'
      '    DISTRIBUIDOR D ON D.DISTRIBUIDOR_ID = N.DISTRIBUIDOR_ID')
    Left = 228
    Top = 282
    object qryManutencaoNEGOCIACAO_ID: TIntegerField
      DisplayLabel = 'IDENTIFICADOR'
      FieldName = 'NEGOCIACAO_ID'
      Origin = 'NEGOCIACAO_ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      ReadOnly = True
      Required = True
    end
    object qryManutencaoNOME_PRODUTOR: TStringField
      AutoGenerateValue = arDefault
      DisplayLabel = 'PRODUTOR'
      FieldName = 'NOME_PRODUTOR'
      Origin = 'NOME'
      ProviderFlags = []
      ReadOnly = True
      Size = 40
    end
    object qryManutencaoNOME_DISTRIBUIDOR: TStringField
      AutoGenerateValue = arDefault
      DisplayLabel = 'DISTRIBUIDOR'
      FieldName = 'NOME_DISTRIBUIDOR'
      Origin = 'NOME'
      ProviderFlags = []
      ReadOnly = True
      Size = 40
    end
    object qryManutencaoDATA_CADASTRO: TSQLTimeStampField
      DisplayLabel = 'DATA CADASTRO'
      FieldName = 'DATA_CADASTRO'
      Origin = 'DATA_CADASTRO'
      ReadOnly = True
    end
    object qryManutencaoVALOR_TOTAL: TFMTBCDField
      DisplayLabel = 'VALOR TOTAL'
      FieldName = 'VALOR_TOTAL'
      Origin = 'VALOR_TOTAL'
      ReadOnly = True
      Precision = 18
      Size = 2
    end
    object qryManutencaoSTATUS: TStringField
      FieldName = 'STATUS'
      Origin = 'STATUS'
      Size = 14
    end
  end
  object dsManutencao: TDataSource
    DataSet = qryManutencao
    Left = 276
    Top = 282
  end
end
