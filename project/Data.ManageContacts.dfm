object DataModuleManageContacts: TDataModuleManageContacts
  OldCreateOrder = False
  Height = 326
  Width = 302
  object dsContacts: TFDQuery
    Connection = DataModuleMain.FDConnection1
    SQL.Strings = (
      'select * from contacts')
    Left = 40
    Top = 24
  end
end
