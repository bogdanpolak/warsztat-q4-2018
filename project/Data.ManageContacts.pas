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
    class var Module: TDataModuleManageContacts;
    { Private declarations }
  public
    { Public declarations }
    class function GetDataModule: TDataModuleManageContacts;
  end;


implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses
  Vcl.Forms,
  Data.Main;

{$R *.dfm}

{ TDataModuleManageContacts }

class function TDataModuleManageContacts.GetDataModule: TDataModuleManageContacts;
begin
  if not Assigned (Module) then
    Module := TDataModuleManageContacts.Create(Application);
  Result := Module

end;

end.
