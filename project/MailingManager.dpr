program MailingManager;







{$R *.dres}

uses
  Vcl.Forms,
  Form.Main in 'Form.Main.pas' {FormMain},
  Data.Main in 'Data.Main.pas' {DataModuleMain: TDataModule},
  Data.ManageContacts in 'Data.ManageContacts.pas' {DataModuleManageContacts: TDataModule},
  Frame.ImportContacts in 'Frame.ImportContacts.pas' {FrameImport: TFrame},
  Consts.ContactsJson in 'Consts.ContactsJson.pas',
  Dialog.ResolveImportConflicts in 'Dialog.ResolveImportConflicts.pas' {DialogResolveConflicts},
  Frame.ManageContacts in 'Frame.ManageContacts.pas' {FrameManageContacts: TFrame},
  Frame.Welcome in 'Frame.Welcome.pas' {FrameWelcome: TFrame},
  Dialog.CreateDatabaseStructure in 'database-build\Dialog.CreateDatabaseStructure.pas' {FormDBScript},
  Consts.DDL.Interbase in 'database-build\Consts.DDL.Interbase.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormMain, FormMain);
  Application.CreateForm(TDataModuleMain, DataModuleMain);
  Application.CreateForm(TDataModuleManageContacts, DataModuleManageContacts);
  Application.Run;
end.
