unit Data.ManageContacts;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TDataModuleManageContacts = class(TDataModule)
    dsContacts: TFDQuery;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DataModuleManageContacts: TDataModuleManageContacts;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses Data.Main;

{$R *.dfm}

end.
