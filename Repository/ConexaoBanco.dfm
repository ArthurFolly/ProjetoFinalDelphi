object DataModule1: TDataModule1
  Height = 518
  Width = 713
  object FDConnection1: TFDConnection
    Params.Strings = (
      'DriverID=PG'
      'Server=localhost'
      'Port=5432'
      'Database=ContactHub'
      'User=postgres'
      'Password=root'
      'User_Name=postgres')
    Left = 456
    Top = 168
  end
  object FDPhysPgDriverLink1: TFDPhysPgDriverLink
    VendorLib = 
      'C:\Users\leo mendes\OneDrive\Documents\Projeto_Delphi\ProjetoFin' +
      'alDelphi\lib\libpq.dll'
    Left = 328
    Top = 168
  end
end
