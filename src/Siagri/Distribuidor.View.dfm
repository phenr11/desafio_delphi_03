object frmDistribuidor: TfrmDistribuidor
  Left = 0
  Top = 0
  Caption = 'Distribuidor'
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
  object shapeDistribuidores: TShape
    Left = 0
    Top = 41
    Width = 624
    Height = 1
    Align = alTop
    ExplicitLeft = 8
    ExplicitTop = 49
    ExplicitWidth = 616
  end
  object pnlDistribuidor: TPanel
    Left = 0
    Top = 0
    Width = 624
    Height = 41
    Align = alTop
    TabOrder = 0
    object lblNome: TLabel
      Left = 4
      Top = 11
      Width = 33
      Height = 15
      Caption = 'Nome'
      Enabled = False
    end
    object lblCNPJ: TLabel
      Left = 393
      Top = 11
      Width = 27
      Height = 15
      Caption = 'CNPJ'
      Enabled = False
    end
    object btCadastrarSalvar: TButton
      Left = 556
      Top = 8
      Width = 64
      Height = 23
      Caption = 'Cadastrar'
      TabOrder = 2
      OnClick = btCadastrarSalvarClick
    end
    object EditNome: TEdit
      Left = 41
      Top = 8
      Width = 346
      Height = 23
      Enabled = False
      MaxLength = 40
      TabOrder = 0
    end
    object EditCNPJ: TEdit
      Left = 424
      Top = 8
      Width = 126
      Height = 23
      Enabled = False
      MaxLength = 14
      NumbersOnly = True
      TabOrder = 1
    end
  end
  object pcPrincipal: TPageControl
    Left = 0
    Top = 42
    Width = 624
    Height = 399
    ActivePage = tsDistribuidores
    Align = alClient
    TabOrder = 1
    object tsDistribuidores: TTabSheet
      Caption = 'Distribuidores'
      object gridCadastro: TDBGrid
        Left = 0
        Top = 0
        Width = 616
        Height = 344
        Align = alClient
        DataSource = dsDistribuidor
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = 'Segoe UI'
        TitleFont.Style = []
        Columns = <
          item
            Expanded = False
            FieldName = 'DISTRIBUIDOR_ID'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'NOME'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'CNPJ'
            Visible = True
          end>
      end
      object DBNavigator: TDBNavigator
        Left = 0
        Top = 344
        Width = 616
        Height = 25
        DataSource = dsDistribuidor
        VisibleButtons = [nbFirst, nbPrior, nbNext, nbLast, nbEdit, nbPost, nbCancel, nbRefresh]
        Align = alBottom
        TabOrder = 1
      end
    end
  end
  object dsDistribuidor: TDataSource
    DataSet = qryDistribuidor
    Left = 556
    Top = 290
  end
  object qryDistribuidor: TFDQuery
    Connection = dmConexao.FDConnection
    SQL.Strings = (
      'SELECT'
      '    DISTRIBUIDOR_ID,'
      '    NOME,'
      '    CNPJ'
      'FROM'
      '    DISTRIBUIDOR'
      'ORDER BY'
      '    DISTRIBUIDOR_ID    ')
    Left = 500
    Top = 290
    object qryDistribuidorDISTRIBUIDOR_ID: TIntegerField
      DisplayLabel = 'IDENTIFICADOR'
      FieldName = 'DISTRIBUIDOR_ID'
      Origin = 'DISTRIBUIDOR_ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      ReadOnly = True
      Required = True
    end
    object qryDistribuidorNOME: TStringField
      FieldName = 'NOME'
      Origin = 'NOME'
      Size = 40
    end
    object qryDistribuidorCNPJ: TStringField
      FieldName = 'CNPJ'
      Origin = 'CNPJ'
      ReadOnly = True
      OnGetText = qryDistribuidorCNPJGetText
      Size = 14
    end
  end
end
