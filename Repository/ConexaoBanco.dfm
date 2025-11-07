object DataModule1: TDataModule1
  Height = 648
  Width = 891
  PixelsPerInch = 120
  object FDConnection1: TFDConnection
    Params.Strings = (
      'DriverID=PG'
      'Server=localhost'
      'Port=5432'
      'Database=ContactHub'
      'User=postgres'
      'Password=root'
      'User_Name=postgres')
    Left = 570
    Top = 210
  end
  object FDPhysPgDriverLink1: TFDPhysPgDriverLink
    VendorLib = 'C:\Users\ARTHUR\Documents\ProjetoFinalDelphi\lib\libpq.dll'
    Left = 410
    Top = 210
  end
end
