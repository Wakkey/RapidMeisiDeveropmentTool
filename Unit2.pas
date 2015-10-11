unit Unit2;

{$MODE Delphi}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls;

type
  TForm2 = class(TForm)
    ScrollBox1: TScrollBox;
    Image1: TImage;
    Panel1: TPanel;
    Button2: TButton;
    SaveDialog1: TSaveDialog;
    procedure Button2Click(Sender: TObject);
  private
    { Private 宣言 }
  public
    { Public 宣言 }
  end;

var
  Form2: TForm2;

implementation

{$R *.lfm}

procedure TForm2.Button2Click(Sender: TObject);
var
  J:TJPegImage;
  B:TBitmap;
begin
  if not savedialog1.Execute then
    exit;
  try
  B := TBitmap.Create;
  J :=TJpegImage.Create;
  B := form2.Image1.Picture.Bitmap;
  J.Assign(B);
  J.SaveToFile(savedialog1.FileName);
  B.Free;
  J.Free;
  except

  end;
end;

end.
