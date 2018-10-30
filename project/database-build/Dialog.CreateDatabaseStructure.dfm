object FormDBScript: TFormDBScript
  Left = 0
  Top = 0
  Caption = 'FormDBScript'
  ClientHeight = 370
  ClientWidth = 592
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  DesignSize = (
    592
    370)
  PixelsPerInch = 96
  TextHeight = 13
  object BitBtn1: TBitBtn
    Left = 8
    Top = 8
    Width = 129
    Height = 25
    Caption = '&Uruchom skrypt'
    Default = True
    Glyph.Data = {
      DE010000424DDE01000000000000760000002800000024000000120000000100
      0400000000006801000000000000000000001000000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      3333333333333333333333330000333333333333333333333333F33333333333
      00003333344333333333333333388F3333333333000033334224333333333333
      338338F3333333330000333422224333333333333833338F3333333300003342
      222224333333333383333338F3333333000034222A22224333333338F338F333
      8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
      33333338F83338F338F33333000033A33333A222433333338333338F338F3333
      0000333333333A222433333333333338F338F33300003333333333A222433333
      333333338F338F33000033333333333A222433333333333338F338F300003333
      33333333A222433333333333338F338F00003333333333333A22433333333333
      3338F38F000033333333333333A223333333333333338F830000333333333333
      333A333333333333333338330000333333333333333333333333333333333333
      0000}
    NumGlyphs = 2
    ParentShowHint = False
    ShowHint = False
    TabOrder = 0
    OnClick = BitBtn1Click
  end
  object memScript: TMemo
    Left = 8
    Top = 39
    Width = 386
    Height = 323
    Anchors = [akLeft, akTop, akBottom]
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Consolas'
    Font.Style = []
    Lines.Strings = (
      'memScript')
    ParentFont = False
    ScrollBars = ssBoth
    TabOrder = 1
  end
  object Memo1: TMemo
    Left = 400
    Top = 39
    Width = 185
    Height = 323
    Anchors = [akLeft, akTop, akRight, akBottom]
    Lines.Strings = (
      'Memo1')
    ScrollBars = ssVertical
    TabOrder = 2
  end
  object FDScript1: TFDScript
    SQLScripts = <>
    Connection = DataModuleMain.FDConnection1
    Params = <>
    Macros = <>
    FetchOptions.AssignedValues = [evItems, evAutoClose, evAutoFetchAll]
    FetchOptions.AutoClose = False
    FetchOptions.Items = [fiBlobs, fiDetails]
    ResourceOptions.AssignedValues = [rvMacroCreate, rvMacroExpand, rvDirectExecute, rvPersistent]
    ResourceOptions.MacroCreate = False
    ResourceOptions.DirectExecute = True
    OnConsolePut = FDScript1ConsolePut
    Left = 248
    Top = 48
  end
  object FDQuery1: TFDQuery
    Connection = DataModuleMain.FDConnection1
    Left = 248
    Top = 96
  end
  object FDQuery2: TFDQuery
    Connection = DataModuleMain.FDConnection1
    Left = 248
    Top = 144
  end
end
