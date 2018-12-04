unit Form.Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, ChromeTabs,
  ChromeTabsClasses, ChromeTabsTypes;

type
  TFrameClass = class of TFrame;

  TFormMain = class(TForm)
    tmrIdle: TTimer;
    grboxCommands: TGroupBox;
    ChromeTabs1: TChromeTabs;
    pnMain: TPanel;
    btnManageContacts: TButton;
    btnImportContacts: TButton;
    btnListManager: TButton;
    btnImportUnregistered: TButton;
    grboxAutoOpen: TGroupBox;
    rbtnFrameImportContacts: TRadioButton;
    rbtFrameManageContacts: TRadioButton;
    rbtnWelcome: TRadioButton;
    grboxConfiguration: TGroupBox;
    edtAppVersion: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    edtDBVersion: TEdit;
    btnCreateDatabase: TButton;
    Bevel1: TBevel;
    tmrAppReady: TTimer;
    procedure btnManageContactsClick(Sender: TObject);
    procedure btnImportContactsClick(Sender: TObject);
    procedure ChromeTabs1ButtonCloseTabClick(Sender: TObject; ATab: TChromeTab;
      var Close: Boolean);
    procedure ChromeTabs1Change(Sender: TObject; ATab: TChromeTab;
      TabChangeType: TTabChangeType);
    procedure FormCreate(Sender: TObject);
    procedure tmrIdleTimer(Sender: TObject);
    procedure btnCreateDatabaseClick(Sender: TObject);
    procedure btnImportUnregisteredClick(Sender: TObject);
    procedure btnListManagerClick(Sender: TObject);
    procedure tmrAppReadyTimer(Sender: TObject);
  private
    isDeveloperMode: Boolean;
    procedure HideAllChildFrames(AParenControl: TWinControl);
    function OpenFrameAsChromeTab(FrameClass: TFrameClass;
      const TabCaption: String): TChromeTab;
    procedure OpenDatabaseConnection;
    procedure verifyDatabaseVersion(expectedVersionNr: Integer);
    procedure AutoOpenFrameInDeveloperMode;
    { Private declarations }
  public
    isChanged: Boolean;
    // Lista kontaktów powinna zostać odświeżona (Contact List Need Be Refreshed)
  end;

var
  FormMain: TFormMain;

implementation

{$R *.dfm}

uses
  FireDAC.Stan.Error,
  Data.Main, Frame.ImportContacts, Frame.Welcome,
  Frame.ManageContacts, Dialog.CreateDatabaseStructure, Frame.ListManager;

const
  SQL_SELECT_DatabaseVersion = 'SELECT versionnr FROM DBInfo';

resourcestring
  SWelcomeScreen = 'Ekran powitalny';
  SDatabaseRequireUpgrade =
    'Proszę najpierw uruchomić skrypt budujący struktury bazy danych.';

procedure TFormMain.HideAllChildFrames(AParenControl: TWinControl);
var
  i: Integer;
begin
  for i := AParenControl.ControlCount - 1 downto 0 do
    if AParenControl.Controls[i] is TFrame then
      (AParenControl.Controls[i] as TFrame).Visible := False;
end;

function TFormMain.OpenFrameAsChromeTab(FrameClass: TFrameClass;
  const TabCaption: String): TChromeTab;
var
  frm: TFrame;
  tab: TChromeTab;
begin
  HideAllChildFrames(pnMain);
  frm := FrameClass.Create(pnMain);
  frm.Parent := pnMain;
  frm.Visible := True;
  frm.Align := alClient;
  tab := ChromeTabs1.Tabs.Add;
  tab.Data := frm;
  tab.Caption := TabCaption;
end;

procedure TFormMain.OpenDatabaseConnection;
begin
  try
    DataModuleMain.FDConnection1.Open;
  except
    on E: EFDDBEngineException do
    begin
      if E.kind = ekObjNotExists then
      begin
        { TODO: Zamienić [ShowMessage] na informacje na ekranie powitalnym }
        ShowMessage(SDatabaseRequireUpgrade);
      end;
    end;
  end;
end;

procedure TFormMain.verifyDatabaseVersion(expectedVersionNr: Integer);
var
  res: Variant;
  currentVersionNr: Integer;
  msg1: string;
begin
  res := DataModuleMain.FDConnection1.ExecSQLScalar(SQL_SELECT_DatabaseVersion);
  currentVersionNr := res;
  if currentVersionNr <> expectedVersionNr then
  begin
    { TODO: Wyłącz jako stała resourcestring }
    { TODO: Zamienić ShowMessage na informacje na ekranie powitalnym }
    msg1 := 'Błędna wersja bazy danych. Proszę zaktualizować strukturę ' +
      'bazy. Oczekiwana wersja bazy: %d, aktualna wersja bazy: %d';
    ShowMessage(Format(msg1, [expectedVersionNr, currentVersionNr]));
  end;
end;

procedure TFormMain.AutoOpenFrameInDeveloperMode;
begin
  begin
    if rbtnFrameImportContacts.Checked then
      btnImportContacts.Click;
    if rbtFrameManageContacts.Checked then
      btnManageContacts.Click;
  end;
end;

procedure TFormMain.FormCreate(Sender: TObject);
var
  sProjFileName: string;
  ext: string;
begin
  pnMain.Caption := '';
  pnMain.Align := alClient;
  { TODO: Powtórka: COPY-PASTE - Find in files `$IFDEF DEBUG` }
  { TODO: Poprawić rozpoznawanie projektu: dpr w bieżącym folderze }
{$IFDEF DEBUG}
  ext := '.dpr'; // do not localize
  sProjFileName := ChangeFileExt(ExtractFileName(Application.ExeName), ext);
  isDeveloperMode := FileExists('..\..\' + sProjFileName);
{$ELSE}
  isDeveloperMode := False;
{$ENDIF}
end;

procedure TFormMain.tmrIdleTimer(Sender: TObject);
var
  i: Integer;
  obj: TObject;
begin
  tmrIdle.Tag := tmrIdle.Tag + 1;
  if isChanged then
  begin
    isChanged := False;
    for i := 0 to ChromeTabs1.Tabs.Count - 1 do
    begin
      obj := TObject(ChromeTabs1.Tabs[i].Data);
      if obj is TFrameManageContacts then
        (obj as TFrameManageContacts).RefreshContactsData;
    end;
  end;
end;

procedure TFormMain.btnManageContactsClick(Sender: TObject);
var
  TabCaption: String;
begin
  TabCaption := (Sender as TButton).Caption;
  OpenFrameAsChromeTab(TFrameManageContacts, TabCaption);
end;

procedure TFormMain.btnListManagerClick(Sender: TObject);
var
  TabCaption: String;
begin
  TabCaption := (Sender as TButton).Caption;
  OpenFrameAsChromeTab(TFrameListManager, TabCaption);
end;

procedure TFormMain.btnImportUnregisteredClick(Sender: TObject);
begin
  // TODO: Not Implemented
end;

procedure TFormMain.btnImportContactsClick(Sender: TObject);
var
  TabCaption: String;
begin
  TabCaption := (Sender as TButton).Caption;
  OpenFrameAsChromeTab(TFrameImport, TabCaption);
end;

procedure TFormMain.btnCreateDatabaseClick(Sender: TObject);
begin
  Dialog.CreateDatabaseStructure.TFormDBScript.Execute;
end;

procedure TFormMain.ChromeTabs1ButtonCloseTabClick(Sender: TObject;
  ATab: TChromeTab; var Close: Boolean);
var
  obj: TObject;
begin
  obj := TObject(ATab.Data);
  (obj as TFrame).Free;
end;

procedure TFormMain.ChromeTabs1Change(Sender: TObject; ATab: TChromeTab;
  TabChangeType: TTabChangeType);
var
  obj: TObject;
begin
  if Assigned(ATab) then
  begin
    obj := TObject(ATab.Data);
    if (TabChangeType = tcActivated) and Assigned(obj) then
    begin
      HideAllChildFrames(pnMain);
      (obj as TFrame).Visible := True;
    end;
  end;
end;

procedure TFormMain.tmrAppReadyTimer(Sender: TObject);
var
  DatabaseNumber: Integer;
begin
  tmrAppReady.Enabled := False;
  OpenFrameAsChromeTab(TFrameWelcome, SWelcomeScreen);
  OpenDatabaseConnection;
  DatabaseNumber := StrToInt(edtDBVersion.Text);
  verifyDatabaseVersion(DatabaseNumber);
  self.Caption := self.Caption + ' - ' + edtAppVersion.Text;
  if isDeveloperMode then
    AutoOpenFrameInDeveloperMode;
end;

end.
