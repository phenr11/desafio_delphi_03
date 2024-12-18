object frmProdutor: TfrmProdutor
  Left = 0
  Top = 0
  Caption = 'Produtor'
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
    ActivePage = tsProdutores
    Align = alClient
    TabOrder = 0
    OnChange = pcPrincipalChange
    OnChanging = pcPrincipalChanging
    object tsProdutores: TTabSheet
      Caption = 'Produtores'
      object shapeProdutores: TShape
        Left = 0
        Top = 41
        Width = 616
        Height = 1
        Align = alTop
        ExplicitTop = 49
      end
      object gridCadastro: TDBGrid
        Left = 0
        Top = 42
        Width = 616
        Height = 344
        Align = alClient
        DataSource = dsProdutor
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = 'Segoe UI'
        TitleFont.Style = []
        Columns = <
          item
            Expanded = False
            FieldName = 'PRODUTOR_ID'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'NOME'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'CPF_CNPJ'
            Visible = True
          end>
      end
      object DBNavigator: TDBNavigator
        Left = 0
        Top = 386
        Width = 616
        Height = 25
        DataSource = dsProdutor
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
        object lblCPFCNPJ: TLabel
          Left = 358
          Top = 11
          Width = 53
          Height = 15
          Caption = 'CPF/CNPJ'
          Enabled = False
        end
        object btCadastrarSalvarProdutores: TButton
          Left = 549
          Top = 8
          Width = 64
          Height = 23
          Caption = 'Cadastrar'
          TabOrder = 2
          OnClick = btCadastrarSalvarProdutoresClick
        end
        object EditNome: TEdit
          Left = 41
          Top = 8
          Width = 311
          Height = 23
          Enabled = False
          MaxLength = 40
          TabOrder = 0
        end
        object EditCPFCNPJ: TEdit
          Left = 415
          Top = 8
          Width = 128
          Height = 23
          MaxLength = 14
          NumbersOnly = True
          TabOrder = 1
        end
      end
    end
    object tsLimiteCredito: TTabSheet
      Caption = 'Limite de Cr'#233'dito'
      ImageIndex = 1
      object shapeLimiteCredito: TShape
        Left = 0
        Top = 65
        Width = 616
        Height = 1
        Align = alTop
        ExplicitTop = 41
      end
      object pnlLimiteCredito: TPanel
        Left = 0
        Top = 0
        Width = 616
        Height = 65
        Align = alTop
        TabOrder = 0
        object lblProdutor: TLabel
          Left = 4
          Top = 11
          Width = 47
          Height = 15
          Caption = 'Produtor'
          Enabled = False
        end
        object lblDistribuidor: TLabel
          Left = 265
          Top = 11
          Width = 62
          Height = 15
          Caption = 'Distribuidor'
          Enabled = False
        end
        object lblLimiteCredito: TLabel
          Left = 4
          Top = 40
          Width = 91
          Height = 15
          Caption = 'Limite de Cr'#233'dito'
          Enabled = False
        end
        object btCadastrarSalvarLimiteCredito: TButton
          Left = 548
          Top = 8
          Width = 64
          Height = 23
          Caption = 'Cadastrar'
          TabOrder = 0
          OnClick = btCadastrarSalvarLimiteCreditoClick
        end
        object lcbDistribuidor: TDBLookupComboBox
          Left = 330
          Top = 8
          Width = 212
          Height = 23
          Enabled = False
          KeyField = 'DISTRIBUIDOR_ID'
          ListField = 'NOME'
          ListSource = dsLookupDistribuidor
          TabOrder = 1
        end
        object lcbProdutor: TDBLookupComboBox
          Left = 55
          Top = 8
          Width = 204
          Height = 23
          Enabled = False
          KeyField = 'PRODUTOR_ID'
          ListField = 'NOME'
          ListSource = dsLookupProdutor
          TabOrder = 2
        end
        object editLimiteCredito: TEdit
          Left = 99
          Top = 37
          Width = 160
          Height = 23
          Enabled = False
          TabOrder = 3
          Text = 'Ex.: 1239,00'
        end
      end
      object gridLimiteCredito: TDBGrid
        Left = 0
        Top = 66
        Width = 616
        Height = 345
        Align = alClient
        DataSource = dsLimiteCredito
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
            FieldName = 'LIMITE_CREDITO_ID'
            Title.Caption = 'IDENTIFICADOR'
            Width = 80
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'PRODUTOR'
            Width = 140
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'CPF_CNPJ'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'DISTRIBUIDOR'
            Width = 140
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'LIMITE_CREDITO'
            Visible = True
          end>
      end
    end
  end
  object dsProdutor: TDataSource
    DataSet = qryProdutor
    Left = 556
    Top = 290
  end
  object qryProdutor: TFDQuery
    Connection = dmConexao.FDConnection
    SQL.Strings = (
      'SELECT'
      '    PRODUTOR_ID,'
      '    NOME,'
      '    CPF_CNPJ'
      'FROM'
      '    PRODUTOR'
      'ORDER BY'
      '    PRODUTOR_ID    ')
    Left = 500
    Top = 290
    object qryProdutorPRODUTOR_ID: TIntegerField
      DisplayLabel = 'IDENTIFICADOR'
      FieldName = 'PRODUTOR_ID'
      Origin = 'PRODUTOR_ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      ReadOnly = True
      Required = True
    end
    object qryProdutorNOME: TStringField
      FieldName = 'NOME'
      Origin = 'NOME'
      Size = 40
    end
    object qryProdutorCPF_CNPJ: TStringField
      DisplayLabel = 'CPF/CNPJ'
      FieldName = 'CPF_CNPJ'
      Origin = 'CPF_CNPJ'
      ReadOnly = True
      OnGetText = qryProdutorCPF_CNPJGetText
      Size = 14
    end
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
      DisplayLabel = 'IDENTIFICADOR'
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
    object IntegerField1: TIntegerField
      DisplayLabel = 'IDENTIFICADOR'
      FieldName = 'PRODUTOR_ID'
      Origin = 'PRODUTOR_ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object StringField1: TStringField
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
  object qryLimiteCredito: TFDQuery
    Connection = dmConexao.FDConnection
    SQL.Strings = (
      'SELECT'
      '    P.PRODUTOR_ID,'
      '    P.NOME AS PRODUTOR,'
      '    P.CPF_CNPJ,'
      '    D.DISTRIBUIDOR_ID,'
      '    D.NOME AS DISTRIBUIDOR,'
      '    L.LIMITE_CREDITO_ID,'
      '    L.LIMITE_CREDITO    '
      'FROM'
      '    LIMITE_CREDITO L'
      'INNER JOIN    '
      '    PRODUTOR P ON P.PRODUTOR_ID = L.PRODUTOR_ID'
      'INNER JOIN    '
      '    DISTRIBUIDOR D ON D.DISTRIBUIDOR_ID = L.DISTRIBUIDOR_ID    '
      'ORDER BY'
      '    PRODUTOR_ID    ')
    Left = 348
    Top = 290
    object qryLimiteCreditoPRODUTOR_ID: TIntegerField
      FieldName = 'PRODUTOR_ID'
      Origin = 'PRODUTOR_ID'
      ReadOnly = True
      Required = True
    end
    object qryLimiteCreditoPRODUTOR: TStringField
      FieldName = 'PRODUTOR'
      Origin = 'PRODUTOR'
      ReadOnly = True
      Size = 40
    end
    object qryLimiteCreditoCPF_CNPJ: TStringField
      DisplayLabel = 'CPF/CNPJ'
      FieldName = 'CPF_CNPJ'
      Origin = 'CPF_CNPJ'
      ReadOnly = True
      OnGetText = qryLimiteCreditoCPF_CNPJGetText
      Size = 14
    end
    object qryLimiteCreditoDISTRIBUIDOR_ID: TIntegerField
      FieldName = 'DISTRIBUIDOR_ID'
      Origin = 'DISTRIBUIDOR_ID'
      ReadOnly = True
      Required = True
    end
    object qryLimiteCreditoDISTRIBUIDOR: TStringField
      FieldName = 'DISTRIBUIDOR'
      Origin = 'DISTRIBUIDOR'
      ReadOnly = True
      Size = 40
    end
    object qryLimiteCreditoLIMITE_CREDITO_ID: TIntegerField
      FieldName = 'LIMITE_CREDITO_ID'
      Origin = 'LIMITE_CREDITO_ID'
      ReadOnly = True
      Required = True
    end
    object qryLimiteCreditoLIMITE_CREDITO: TFMTBCDField
      DisplayLabel = 'LIMITE CR'#201'DITO'
      FieldName = 'LIMITE_CREDITO'
      Origin = 'LIMITE_CREDITO'
      ReadOnly = True
      Precision = 18
      Size = 2
    end
  end
  object dsLimiteCredito: TDataSource
    DataSet = qryLimiteCredito
    Left = 404
    Top = 290
  end
end
