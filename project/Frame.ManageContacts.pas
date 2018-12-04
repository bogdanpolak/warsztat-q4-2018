unit Frame.ManageContacts;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  Data.DB, Vcl.Grids, Vcl.DBGrids;

type
  TFrameManageContacts = class(TFrame)
    Panel1: TPanel;
    btnConfirmContact: TButton;
    btnUnregisterContact: TButton;
    DBGrid1: TDBGrid;
    btnShowUnregistred: TButton;
    btnRegisterAgain: TButton;
    tmrFrameReady: TTimer;
    DataSource1: TDataSource;
    procedure btnConfirmContactClick(Sender: TObject);
    procedure btnUnregisterContactClick(Sender: TObject);
    procedure tmrFrameReadyTimer(Sender: TObject);
  private
  public
    constructor Create(AOwner: TComponent); override;
    procedure RefreshContactsData;
  end;

implementation

{$R *.dfm}

uses Data.ManageContacts, Helper.DBGrid;

{ TFrameManageContacts }

constructor TFrameManageContacts.Create(AOwner: TComponent);
begin
  inherited;
  Panel1.Caption := '';
end;

procedure TFrameManageContacts.btnConfirmContactClick(Sender: TObject);
begin
  { TODO: Implementacja powtwierdzania kontaktu }
end;

procedure TFrameManageContacts.btnUnregisterContactClick(Sender: TObject);
begin
  { TODO: Wyrejestrowanie kontaktu }
end;


procedure TFrameManageContacts.RefreshContactsData();
begin
  DataSource1.DataSet.Close;
  DataSource1.DataSet.Open;
  DBGrid1.AutoSizeColumns();
end;

procedure TFrameManageContacts.tmrFrameReadyTimer(Sender: TObject);
var
  dm: TDataModuleManageContacts;
begin
  tmrFrameReady.Enabled := false;
  dm := TDataModuleManageContacts.GetDataModule;
  DataSource1.DataSet := dm.dsContacts;
  dm.dsContacts.Close();
  dm.dsContacts.Open();
  DBGrid1.AutoSizeColumns();
end;

end.
