unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Qrctrls, quickrpt, ExtCtrls;

type
  TForm2 = class(TForm)
    QuickRep1: TQuickRep;
    MeisiForm: TQRImage;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private �錾 }
  public
    { Public �錾 }
  end;

var
  Form2: TForm2;

implementation

uses Unit1;

{$R *.DFM}








































procedure TForm2.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  form1.resetprot;
end;

end.
