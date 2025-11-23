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
    Left = 802
    Top = 90
  end
  object FDPhysPgDriverLink1: TFDPhysPgDriverLink
    Left = 810
    Top = 10
  end
  object frxDBContatosUF: TfrxDBDataset
    UserName = 'frxDBContatosUF'
    CloseDataSource = False
    DataSet = qryContatosUF
    BCDToCurrency = False
    DataSetOptions = []
    Left = 424
    Top = 304
  end
  object qryContatosUF: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'SELECT uf,'
      '       COUNT(*) AS total'
      'FROM contatos'
      'GROUP BY uf'
      'ORDER BY uf ASC;')
    Left = 304
    Top = 304
  end
  object frxReportContatosUF: TfrxReport
    Version = '2026.1.1'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick, pbCopy, pbSelection, pbWatermarks]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 45984.845415844910000000
    ReportOptions.LastChange = 45984.845415844910000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    Left = 568
    Top = 304
    Datasets = <>
    Variables = <>
    Style = <>
    Watermarks = <>
  end
end
