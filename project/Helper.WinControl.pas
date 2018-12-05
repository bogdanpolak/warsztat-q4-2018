unit Helper.WinControl;

interface

uses
  Vcl.Controls;

type
  THelperWinControl = class helper for TWinControl
    procedure HideAllChildFrames;
  end;

implementation

uses
  Vcl.Forms;

procedure THelperWinControl.HideAllChildFrames();
var
  i: Integer;
begin
  for i := self.ControlCount - 1 downto 0 do
    if self.Controls[i] is TFrame then
      (self.Controls[i] as TFrame).Visible := False;
end;

end.
