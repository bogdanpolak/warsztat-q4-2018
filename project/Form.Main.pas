﻿unit Form.Main;

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
    ButtonCreateDatabase: TButton;
    procedure btnImportContactsClick(Sender: TObject);
    procedure btnManageContactsClick(Sender: TObject);
    procedure ChromeTabs1ButtonCloseTabClick(Sender: TObject; ATab: TChromeTab;
      var Close: Boolean);
    procedure ChromeTabs1Change(Sender: TObject; ATab: TChromeTab;
      TabChangeType: TTabChangeType);
    procedure FormCreate(Sender: TObject);
    procedure tmrIdleTimer(Sender: TObject);
    procedure ButtonCreateDatabaseClick(Sender: TObject);
  private
    isDeveloperMode: Boolean;
    procedure HideAllChildFrames(AParenControl: TWinControl);
    function OpenFrameAsChromeTab(Frame: TFrameClass): TChromeTab;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormMain: TFormMain;

implementation

{$R *.dfm}

uses
  FireDAC.Stan.Error,
  Data.Main, Frame.ImportContacts, Frame.Welcome,
  Frame.ManageContacts, Dialog.CreateDatabaseStructure;

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

function TFormMain.OpenFrameAsChromeTab(Frame: TFrameClass): TChromeTab;
var
  frm: TFrame;
begin
  Result := nil;
  { TODO: Dodać kontrolę otwierania tej samej zakładki po raz drugi }
  // Błąd zgłoszony. github #2
  { DONE: Powtórka: COPY-PASTE }
  { DONE : Wydziel metodę OpenFrameAsChromeTab (TFrame) }

  HideAllChildFrames(pnMain);

  frm := Frame.Create(pnMain);
  frm.Parent := pnMain;
  frm.Visible := True;
  frm.Align := alClient;

  Result := ChromeTabs1.Tabs.Add;
  Result.Data := frm;
end;

procedure TFormMain.btnImportContactsClick(Sender: TObject);
var
  frm: TChromeTab;
begin
  { DONE: Powtórka: COPY-PASTE }
  frm := OpenFrameAsChromeTab(TFrameImport);
  frm.Caption := (Sender as TButton).Caption;
end;

procedure TFormMain.btnManageContactsClick(Sender: TObject);
var
  frm: TChromeTab;
begin
  { DONE: Powtórka: COPY-PASTE }
  frm := OpenFrameAsChromeTab(TFrameManageContacts);
  frm.Caption := (Sender as TButton).Caption;
end;

procedure TFormMain.ButtonCreateDatabaseClick(Sender: TObject);
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

procedure TFormMain.FormCreate(Sender: TObject);
var
  sProjFileName: string;
  ext: string;
begin
  pnMain.Caption := '';
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
begin
  { TODO: Przebudować logikę metody. Jest zbyt skomplikowana i mało czytelna }
  tmr1 := (Sender as TTimer);
  isFirstTime := (tmr1.Tag = 0);
  tmr1.Tag := tmr1.Tag + 1;
  if isFirstTime then
  begin
    { DONE: Powtórka: COPY-PASTE }
    tab := OpenFrameAsChromeTab(TFrameWelcome);
    tab.Caption := SWelcomeScreen;
    // -- koniec bloku powtórki
    self.Caption := self.Caption + ' - ' + edtAppVersion.Text;
    { DONE: Sprawdź wersję bazy danych czy pasuje do aplikacji }
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
end;

end.
