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
  private
    isDeveloperMode: Boolean;
    procedure HideAllChildFrames(AParenControl: TWinControl);
    { Private declarations }
  public
    isChanged: Boolean; // Lista kontaktów powinna zostać odświeżona (Contact List Need Be Refreshed)
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

procedure TFormMain.FormCreate(Sender: TObject);
var
  sProjFileName: string;
  ext: string;
begin
  pnMain.Caption := '';
  pnMain.Align := alClient;
  { TODO: Powtórka: COPY-PASTE }
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
  tmr1: TTimer;
  DatabaseNumber: Integer;
  res: Variant;
  VersionNr: Integer;
  kind: TFDCommandExceptionKind;
  isFirstTime: Boolean;
  tab: TChromeTab;
  frm: TFrameWelcome;
  msg1: string;
  i: Integer;
  obj: TObject;
begin
  { TODO: Przebudować logikę metody. Jest zbyt skomplikowana i mało czytelna }
  tmr1 := (Sender as TTimer);
  isFirstTime := (tmr1.Tag = 0);
  tmr1.Tag := tmr1.Tag + 1;
  // TODO: Użyć osobny timier tmrFormReady na cały kod z `if isFirstTime then`
  if isFirstTime then
  begin
    // TODO: Już gdzieś widziałem takie kod ... do refaktoringu xD
    HideAllChildFrames(pnMain);
    frm := TFrameWelcome.Create(pnMain);
    frm.Parent := pnMain;
    frm.Visible := True;
    frm.Align := alClient;
    tab := ChromeTabs1.Tabs.Add;
    tab.Data := frm;
    tab.Caption := SWelcomeScreen;
    // --
    self.Caption := self.Caption + ' - ' + edtAppVersion.Text;
    DatabaseNumber := StrToInt(edtDBVersion.Text);
    { TODO: Wydziel metodę: verifyDatabaseVersion(expectedVersionNr) }
    // Połączenie z bazą i porównanie DatabaseNumber z VersionNr
    try
      DataModuleMain.FDConnection1.Open();
    except
      on E: EFDDBEngineException do
      begin
        if E.kind = ekObjNotExists then
        begin
          tmr1.Enabled := False;
          { TODO: Zamieć [ShowMessage] na informacje na ekranie powitalnym }
          ShowMessage(SDatabaseRequireUpgrade);
          tmr1.Enabled := True;
        end;
      end;
    end;
    res := DataModuleMain.FDConnection1.ExecSQLScalar
      (SQL_SELECT_DatabaseVersion);
    VersionNr := res;
    if VersionNr <> DatabaseNumber then
    begin
      tmr1.Enabled := False;
      { TODO: Wyłącz jako stała resourcestring }
      { TODO: Zamieć ShowMessage na informacje na ekranie powitalnym }
      msg1 := 'Błędna wersja bazy danych. Proszę zaktualizować strukturę ' +
        'bazy. Oczekiwana wersja bazy: %d, aktualna wersja bazy: %d';
      ShowMessage(Format(msg1, [DatabaseNumber, VersionNr]));
      tmr1.Enabled := True;
    end;
  end;
  if isDeveloperMode and isFirstTime then
  begin
    if rbtnFrameImportContacts.Checked then
      btnImportContacts.Click;
    if rbtFrameManageContacts.Checked then
      btnManageContacts.Click;
  end;
  if isChanged then
  begin
    isChanged := false;
    for i := 0 to ChromeTabs1.Tabs.Count-1 do
    begin
      obj := TObject(ChromeTabs1.Tabs[i].Data);
      if obj is TFrameManageContacts then
        (obj as TFrameManageContacts).RefreshContactsData;
    end;
  end;
end;

procedure TFormMain.btnManageContactsClick(Sender: TObject);
var
  frm: TFrameManageContacts;
  tab: TChromeTab;
begin
  // TODO: Znajdź powtórzenia
  // extract: OpenFrameAsChromeTab(FrameClass: TFrameClass; const TabCaption: String): TChromeTab;
  HideAllChildFrames(pnMain);
  frm := TFrameManageContacts.Create(pnMain);
  frm.Parent := pnMain;
  frm.Visible := True;
  frm.Align := alClient;
  tab := ChromeTabs1.Tabs.Add;
  tab.Data := frm;
  tab.Caption := (Sender as TButton).Caption;
end;

procedure TFormMain.btnListManagerClick(Sender: TObject);
var
  frm: TFrameListManager;
  tab: TChromeTab;
begin
  HideAllChildFrames(pnMain);
  frm := TFrameListManager.Create(pnMain);
  frm.Parent := pnMain;
  frm.Visible := True;
  frm.Align := alClient;
  tab := ChromeTabs1.Tabs.Add;
  tab.Data := frm;
  tab.Caption := (Sender as TButton).Caption;
end;

procedure TFormMain.btnImportUnregisteredClick(Sender: TObject);
begin
  // TODO: Not Implemented
end;

procedure TFormMain.btnImportContactsClick(Sender: TObject);
var
  frm: TFrameImport;
  tab: TChromeTab;
begin
  HideAllChildFrames(pnMain);
  frm := TFrameImport.Create(pnMain);
  frm.Parent := pnMain;
  frm.Visible := True;
  frm.Align := alClient;
  tab := ChromeTabs1.Tabs.Add;
  tab.Data := frm;
  tab.Caption := (Sender as TButton).Caption;
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

end.
