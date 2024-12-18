object dmConexao: TdmConexao
  Height = 480
  Width = 640
  object FDPhysFBDriverLink1: TFDPhysFBDriverLink
    Left = 560
    Top = 152
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 568
    Top = 208
  end
  object FDConnection: TFDConnection
    ConnectionName = 'FDConnection'
    Params.Strings = (
      'Database=D:\Estudos\Delphi\Bancos\SIAGRI.fdb'
      'User_Name=sysdba'
      'Password=masterkey'
      'CharacterSet=ISO8859_1'
      'DriverID=FB')
    Connected = True
    LoginPrompt = False
    Left = 576
    Top = 272
  end
end
