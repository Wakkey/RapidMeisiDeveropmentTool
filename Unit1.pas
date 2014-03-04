unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  quickrpt, Qrctrls, ExtCtrls, StdCtrls,Jpeg, ComCtrls;

type
  TCompList = class(TList)
  private
    function Get(Index: Integer): TControl;
    procedure Put(Index: Integer; const Value: TControl);
  public
    property Items[Index: Integer]: TControl read Get write Put; default;
  end;

  TForm1 = class(TForm)
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    OpenDialog2: TOpenDialog;
    OpenDialog3: TOpenDialog;
    FontDialog1: TFontDialog;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button11: TButton;
    Button12: TButton;
    Panel4: TPanel;
    MeisiForm: TPanel;
    Button9: TButton;
    Button1: TButton;
    MeisiForm1: TQRImage;
    ComboBox1: TComboBox;
    ComboBox2: TComboBox;
    UpDown1: TUpDown;
    UpDown2: TUpDown;
    ComboBox4: TComboBox;
    UpDown3: TUpDown;
    UpDown4: TUpDown;
    TrackBar1: TTrackBar;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    TrackBar2: TTrackBar;
    TrackBar3: TTrackBar;
    TrackBar4: TTrackBar;
    Button5: TButton;
    ComboBox6: TComboBox;
    UpDown5: TUpDown;
    UpDown6: TUpDown;
    ComboBox3: TComboBox;
    ComboBox5: TComboBox;
    Button6: TButton;
    Memo1: TMemo;
    Button7: TButton;
    Button8: TButton;
    Image1: TImage;
    setCompIMG: TImage;
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button12Click(Sender: TObject);
    procedure Button11Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure ComboBox6Change(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure ComboBox2Change(Sender: TObject);
    procedure UpDown5Changing(Sender: TObject; var AllowChange: Boolean);
    procedure TrackBar1Change(Sender: TObject);
  private
    { Private �錾 }
    QRMemo1 : TQRRichText;
  public
    { Public �錾 }
    comp:TCompList;
    qrimg:array [0..30] of Tqrimage;
    QRLabel:array [0..30] of TQRMemo;
    QRMemo:array [0..30] of TQRMemo;
    QRImg2:array [0..30] of Tqrimage;
    function resetprot:boolean;
  end;

var
  Form1: TForm1;

implementation

uses Unit2;

{$R *.DFM}

{ TMyClassList }

function TCompList.Get(Index: Integer): TControl;
begin
  Result :=  TControl( inherited Get(Index) );
end;

procedure TCompList.Put(Index: Integer; const Value: TControl);
begin
  inherited Put( Index, Value );
end;




function TForm1.resetprot:boolean;
var
  i:integer;
begin
 with form1 do begin

  for i := 0 to 30 do begin
    qrimg[i].free;
    QRLabel[i].free;
    QRMemo[i].free;
    QRImg2[i].free;
  end;
 end;
end;

{function prot(i,i1,i2:integer):boolean;
begin
 with form1 do begin
  //for i := 0 to
  form2.QRImage2.Parent := form2.QuickRep1;
  form2.QRImage2.Picture := form1.Image1.Picture;
  //i := 0; i1:= -208; i2 := 344;

  qrimg2[i]:=Tqrimage.Create(form2.QRImage2);
  qrimg2[i].parent := form2.QuickRep1;
  //qrimg2[].setBounds( form2.QRImage2.Left ,form2.QRImage2.Top, form2.QRImage2.Width , form2.QRImage2.Height );

  qrimg2[i].Top := i1 + 249;
  qrimg2[i].Left := i2 + 54;
  qrimg2[i].Height :=209;
  qrimg2[i].Width :=  345;
  qrimg2[i].Picture := form1.Image1.Picture;
  qrimg2[i].Stretch := true;
  qrimg2[i].Visible := true;

  qrimg[i]:=Tqrimage.Create(form2.QRImage2);
  qrimg[i].parent := form2.QuickRep1;
  qrimg[i].setBounds( form2.QRImage1.Left ,form2.QRImage1.Top, form2.QRImage1.Width , form2.QRImage1.Height );

  qrimg[i].Top := i1 + 276;
  qrimg[i].Left := i2 + 83;
  qrimg[i].Picture := form2.QRImage1.Picture;
  qrimg[i].Stretch := true;
  qrimg[i].Visible := true;
   //i := 30;
  QRLabel[i] := TQRMemo.Create(form1.Memo2);
  QRLabel[i].parent := form2.QuickRep1;
  QRLabel[i].setBounds( form2.QRLabel1.Left, form2.QRLabel1.Top,form2.QRLabel1.Width,form2.QRLabel1.Height);
  QRLabel[i].AutoSize := false;
  QRLabel[i].Top := i1 +  256;
  QRLabel[i].Left := i2 +  135;
  QRLabel[i].Height := form2.QRLabel1.Height;
  QRLabel[i].Font := form2.QRLabel1.Font;
  QRLabel[i].Lines.Text := form2.QRLabel1.Lines.Text;
  QRLabel[i].Visible := true;
  QRLabel[i].Transparent := true;
  QRLabel[i].Font.Color := form2.QRLabel1.Font.Color;

  //i := 29;
  QRLabel[i+1]:= TQRMemo.Create(form1.memo2);
  QRLabel[i+1].parent := form2.QuickRep1;
  QRLabel[i+1].setBounds( form2.QRLabel2.left, form2.QRLabel2.Top,form2.QRLabel2.Width,form2.QRLabel2.Height);
  QRLabel[i+1].AutoSize := false;
  QRLabel[i+1].Top :=  i1 + 275;
  QRLabel[i+1].Left := i2 +  135;
  QRLabel[i+1].Height := form2.QRLabel2.Height;
  QRLabel[i+1].Font := form2.QRLabel2.Font;
  QRLabel[i+1].Lines.Text := form2.QRLabel2.Lines.Text;

  QRLabel[i+1].Visible := true;
  QRLabel[i+1].Transparent := true;
  QRLabel[i+1].WordWrap := true;
  QRLabel[i+1].Font.Color := form2.QRLabel2.Font.Color;
  //
 // i := 28;
  QRLabel[i+2] := TQRMemo.Create(form1.memo2);
  QRLabel[i+2].parent := form2.QuickRep1;
  QRLabel[i+2].setBounds( form2.QRLabel4.Left, form2.QRLabel4.Top,form2.QRLabel4.Width,form2.QRLabel4.Height);
  QRLabel[i+2].AutoSize := false;
  QRLabel[i+2].Top := i1 + 305;
  QRLabel[i+2].Left := i2 +  135;
  QRLabel[i+2].Font := form2.QRLabel4.Font;
  QRLabel[i+2].Lines.Text := form2.QRLabel4.Lines.Text;
  QRLabel[i+2].Visible := true;
  QRLabel[i+2].Transparent := true;
  QRLabel[i+2].Font.Color := form2.QRLabel4.Font.Color;
  //QRLabel[i].AutoSize := true;
 // i := 27;
  QRLabel[i+3] := TQRMemo.Create(form1.memo2);
  QRLabel[i+3].parent := form2.QuickRep1;
  QRLabel[i+3].setBounds( form2.QRLabel4.Left, form2.QRLabel4.Top,form2.QRLabel4.Width,form2.QRLabel4.Height);
  QRLabel[i+3].AutoSize := false;
  QRLabel[i+3].Top := i1 +  305;
  QRLabel[i+3].Left := i2 +  135;
  QRLabel[i+3].Font := form2.QRLabel4.Font;
  QRLabel[i+3].Lines.Text := form2.QRLabel4.Lines.Text;
  QRLabel[i+3].Visible := true;
  QRLabel[i+3].Transparent := true;
  QRLabel[i+3].Font.Color := form2.QRLabel4.Font.Color;
  //QRLabel[i].AutoSize := true;
  //i := 26;
  QRLabel[i+4] := TQRMemo.Create(form1.memo2);
  QRLabel[i+4].parent := form2.QuickRep1;
  QRLabel[i+4].setBounds( form2.QRLabel4.Left, form2.QRLabel4.Top,form2.QRLabel4.Width,form2.QRLabel4.Height);
  QRLabel[i+4].AutoSize := false;
  QRLabel[i+4].Top :=  i1 + 305;
  QRLabel[i+4].Left := i2 +  135;
  QRLabel[i+4].Font := form2.QRLabel4.Font;
  QRLabel[i+4].Lines.Text := form2.QRLabel4.Lines.Text;
  QRLabel[i+4].Visible := true;
  QRLabel[i+4].Transparent := true;
  QRLabel[i+4].Font.Color := form2.QRLabel4.Font.Color;
  //QRLabel[i].AutoSize := true;
  //i := 25;
  QRLabel[i+5] := TQRMemo.Create(form1.memo2);
  QRLabel[i+5].parent := form2.QuickRep1;
  //QRLabel[i].setBounds( form2.QRLabel5.Left, form2.QRLabel5.Top,form2.QRLabel5.Width,form2.QRLabel5.Height);

  QRLabel[i+5].Top :=  i1 + 427;
  QRLabel[i+5].Left := i2 +  64;
  //QRLabel[i].Font := form2.QRLabel5.Font;
  //QRLabel[i].Lines.Text := form2.QRLabel5.Caption;
  QRLabel[i+5].Visible := true;
  QRLabel[i+5].Transparent := true;
  //QRLabel[i].Font.Color := form2.QRLabel5.Font.Color;
  QRLabel[i+5].AutoSize := true;

 // i := 24;
  QRLabel[i+6] := TQRMemo.Create(form1.memo2);
  QRLabel[i+6].parent := form2.QuickRep1;
  //QRLabel[i].setBounds( form2.QRLabel6.Left, form2.QRLabel6.Top,form2.QRLabel6.Width,form2.QRLabel6.Height);

  QRLabel[i+6].Top := i1 +  440;
  QRLabel[i+6].Left := i2 +  64;
  //QRLabel[i].Font := form2.QRLabel[i]6.Font;
  //QRLabel[i].Lines.Text := form2.QRLabel6.Caption;
  QRLabel[i+6].Visible := true;
  QRLabel[i+6].Transparent := true;
  //QRLabel[i].Font.Color := form2.QRLabel6.Font.Color;
  QRLabel[i+6].AutoSize := true;

 // i := 23;
  QRMemo[i+7] := TQRMemo.Create(form1.memo2);
  QRMemo[i+7].parent := form2.QuickRep1;
  QRMemo[i+7].setBounds( form2.QRMemo1.Left, form2.QRMemo1.Top,form2.QRMemo1.Width,form2.QRMemo1.Height);

  QRMemo[i+7].Top :=  i1 + 339;
  QRMemo[i+7].Left := i2 +  64;
  QRMemo[i+7].Font := form2.QRMemo1.Font;
  QRMemo[i+7].Lines.Text := form2.qrmemo1.Lines.Text;
  QRMemo[i+7].AutoSize := true;
  QRMemo[i+7].Height := 88;
  QRMemo[i+7].Visible := true;
  QRMemo[i+7].Transparent := true;
  QRMemo[i+7].Font.Color := form2.QRMemo1.Font.Color;
 end;
end;
}



function createmeomo:boolean;
begin
  with form1 do begin
    QRMemo1 := TQRRichText.Create(form1);
    QRMemo1.Parent := form1.MeisiForm;
    QRMemo1.Left := 8;
    QRMemo1.Top := 92;
    //QRMemo1.WordWrap := true;
    //QRMemo1.AutoSize := true;
    QRMemo1.Height := 120;
    QRMemo1.Width := MeisiForm.Width -10;
  end;
end;


procedure TForm1.Button2Click(Sender: TObject);
begin
  {QRLabel1.Lines.Text := edit1.Lines.Text;
  QRLabel1.Font := edit1.Font;
  QRLabel2.Lines.Text := edit2.Lines.Text;
  QRLabel2.Font := edit2.Font;
  QRLabel4.Lines.Text := edit3.Lines.Text;
  QRLabel4.Font := edit3.Font;
  //QRLabel5.Caption := edit4.Text;

  //QRLabel6.Caption := edit5.Text;

  QRMemo1.Free;
  createmeomo;


  QRMemo1.Lines.Text := Memo1.Lines.Text;
  QRMemo1.Font := memo1.Font;
  //QRMemo1.AutoSize := True;
  edit6.Visible := false;
  edit6.Visible := true;
  edit6.Visible := false;

  form2.QRLabel1.Lines.Text := form1.QRLabel1.Lines.Text;
  form2.QRLabel1.Font := form1.QRLabel1.Font;
  form2.QRLabel2.Lines.Text := form1.QRLabel2.Lines.Text;
  form2.QRLabel2.Font := form1.QRLabel2.Font;
  form2.QRLabel4.Lines.Text := form1.QRLabel4.Lines.Text;
  form2.QRLabel4.Font := form1.QRLabel4.Font;
  //form2.QRLabel5.Caption := form1.QRLabel5.Caption;
  //form2.QRLabel5.Font.Color := form1.QRLabel5.Font.Color;
  //form2.QRLabel6.Caption := form1.QRLabel6.Caption ;
  //form2.QRLabel6.Font.Color := form1.QRLabel6.Font.Color;
  form2.QRMemo1.Lines.Text := form1.QRMemo1.Lines.Text;
  //form2.QRLabel1.Transparent := true;
  //form2.QRLabel2.Transparent := true;
  //form2.QRLabel4.Transparent := true;
  //form2.QRLabel5.Transparent := true;
  //form2.QRLabel6.Transparent := true;
  //form2.QRMemo1.Transparent := true;
  form2.QRMemo1.Font := form1.QRMemo1.Font;
  //form2.QRMemo1.AutoSize := True;
  form2.QRImage1.Picture := form1.QRImage1.Picture;
  //form2.QRImage2.Picture := form1.Image1.Picture;
  }
end;

procedure TForm1.Button3Click(Sender: TObject);
Var
  Jpeg :TJpegImage;
  bmp:tbitmap;
begin
  {if not opendialog1.Execute then
    exit;
     //JPEG �C���[�W�I�u�W�F�N�g���C���X�^���X������
    Jpeg :=TJpegImage.Create ;
    //�r�b�g�}�b�v������
    BMP:=TBitmap.Create;
    //Jpeg�C���[�W�̓ǂݍ���
    Jpeg.LoadFromFile(opendialog1.filename);
    //BMP�ɓ]���A�ϊ�
    BMP.Assign(Jpeg);
    //Image1�֓]��
    QRImage1.Picture.Bitmap := bmp;


    //�I�u�W�F�N�g��j��
    Jpeg.Free;
    Bmp.Free;}
end;

procedure TForm1.Button4Click(Sender: TObject);
Var
  Jpeg :TJpegImage;
  bmp:tbitmap;
begin
 { if not opendialog1.Execute then
    exit;
     //JPEG �C���[�W�I�u�W�F�N�g���C���X�^���X������
    Jpeg :=TJpegImage.Create ;
    //�r�b�g�}�b�v������
    BMP:=TBitmap.Create;
    //Jpeg�C���[�W�̓ǂݍ���
    Jpeg.LoadFromFile(opendialog1.filename);
    //BMP�ɓ]���A�ϊ�
    BMP.Assign(Jpeg);
    //Image1�֓]��
    Image1.Picture.Bitmap := bmp;


    //�I�u�W�F�N�g��j��
    Jpeg.Free;
    Bmp.Free;}
end;

procedure TForm1.Button8Click(Sender: TObject);
begin
  if not FontDialog1.Execute then
    exit;
  memo1.Font := FontDialog1.Font;
end;

procedure TForm1.Button12Click(Sender: TObject);
Var
  Jpeg :TJpegImage;
  bmp:tbitmap;
  s:string;
  s1,s2:string;
  i :integer;
begin
{  if not opendialog3.Execute then
    exit;
  i := 1;
  s1 := '';
  s := opendialog3.FileName;
  while i < length(opendialog3.FileName)-3 do begin
   s1 := s1 + s[i];
   inc(i)
  end;

    try
      image1.Picture.LoadFromFile( s1 + '2.bmp' );
    except
    end;
    try
      QRimage1.Picture.LoadFromFile( s1 + '1.bmp' );
    except
    end;
  memo2.Lines.Clear;

  memo2.Lines.LoadFromFile(s1 + '1.txt');
  edit1.Text :=  memo2.Lines.Text;

  memo2.Lines.LoadFromFile(s1 + '2.txt');
  edit2.Text :=  memo2.Lines.Text;

  memo2.Lines.LoadFromFile(s1 + '3.txt');
  edit3.Text :=  memo2.Lines.Text;
  memo1.Lines.LoadFromFile( s1 + '4.txt' );
  Memo2.Lines.LoadFromFile(s1 + 'c.txt');
  QRLabel1.Font.Color := stringtocolor(memo2.Lines[0]);
  QRLabel2.Font.Color := stringtocolor(memo2.Lines[1]);
  QRLabel4.Font.Color := stringtocolor(memo2.Lines[2]);

  QRMemo1.Font.Color := stringtocolor(memo2.Lines[3]);

  QRLabel1.Font.Size := strtoint(memo2.Lines[4]);
  QRLabel2.Font.Size := strtoint(memo2.Lines[5]);
  QRLabel4.Font.Size := strtoint(memo2.Lines[6]);

  QRMemo1.Font.Size := strtoint(memo2.Lines[7]);
  Memo2.Lines.Clear;}
end;

procedure TForm1.Button11Click(Sender: TObject);
Var
  Jpeg,jpeg2 :TJpegImage;
  bmp,bmp2:tbitmap;
begin
  {
  if not savedialog1.Execute then
    exit;
  memo2.Lines.Clear;

     Memo2.Lines.SaveToFile(savedialog1.filename + '.set');
    image1.Picture.SaveToFile(savedialog1.FileName + '2.bmp');
    QRimage1.Picture.SaveToFile(savedialog1.FileName + '1.bmp');
  memo2.Text := edit1.Text;
  memo2.Lines.SaveToFile(savedialog1.filename + '1.txt');
  memo2.Text := edit2.Text;
  memo2.Lines.SaveToFile(savedialog1.filename + '2.txt');

  memo2.Text := edit3.Text;
  memo2.Lines.SaveToFile(savedialog1.filename + '3.txt');
  memo1.Lines.SaveToFile( savedialog1.FileName + '4.txt' );
  memo2.Lines.Clear;
  memo2.Lines.Add(colortostring(qrlabel1.Font.color));
  memo2.Lines.Add(colortostring(qrlabel2.Font.color));
  memo2.Lines.Add(colortostring(qrlabel4.Font.color));

  memo2.Lines.Add(colortostring(qrmemo1.Font.color));

  memo2.Lines.Add(inttostr(qrlabel1.Font.size));
  memo2.Lines.Add(inttostr(qrlabel2.Font.size));
  memo2.Lines.Add(inttostr(qrlabel4.Font.size));

  memo2.Lines.Add(inttostr(qrmemo1.Font.size));
  Memo2.Lines.SaveToFile(savedialog1.filename + 'c.txt');

  }

end;

function setcomb(Top,Left,Height,Width:integer):boolean;
var
  i,Max:integer;
  function setMax(i,i2:integer):integer;
  begin
    if i < i2 then
      i := i2;
    setMax := i
  end;
begin
  Max := Top;
  Max := setMax(Max,Left);
  Max := setMax(Max,Height);
  Max := setMax(Max,Width);
  with form1 do begin
    for i := 0 to Max do begin
      if i <= Top then
        combobox2.Items.Add(inttostr(i));
      if i <= Left then
        combobox3.Items.Add(inttostr(i));
      if i <= Height then
        combobox4.Items.Add(inttostr(i));
      if i <= Width then
        combobox5.Items.Add(inttostr(i));
    end;
  end;
end;


function setMeisiSize:boolean;
begin
  with form1.MeisiForm do begin
    form1.TrackBar1.Max := Height;
    form1.TrackBar2.Max := Width;
    form1.TrackBar3.Max := Height;
    form1.TrackBar4.Max := Width;

    form1.UpDown2.Max := Height;
    form1.UpDown3.Max := Width;
    form1.UpDown4.Max := Height;
    form1.UpDown5.Max := Width;
    setcomb(Top,Left,Height,Width);
  end;
end;

function setMoveCompSet(tp,lf,ht,wd:integer):boolean;
var
  i,i1:integer;
  R:TRect;
  B:TBitmap;
begin
  {B := TBitMap.Create;
  B.Width := wd;
  B.Height := ht;
  R := Rect(10,10,20, 30);
  B.Canvas.Pen.Color := clBlack;
  //B.Canvas; //(10,10,20,20,40,40,50,50);
  //B.Canvas.Pen.Style := pssolid;
  //B.Canvas.Brush.Style:= bssolid;
  //B.Canvas.Brush.Color := clblack;
  //B.Canvas.Rectangle(R.Left,R.Top,R.Right,R.Bottom);
  form1.setcompIMG.Picture.Bitmap := (B);
  }
  with form1.setcompIMG do begin
    top := tp;
    Left := lf;
    Width := wd+ 2;
    Height := ht + 2;
  end;
  //B.Free;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  //createmeomo;
  comp := TCompList.Create;
  comp.clear;
  setMeisiSize;
  //form1.setcompIMG := Timage.Create(form1);
  with form1.setcompIMG do begin
    parent := form1.MeisiForm;
    visible := true;
  end;
  setMoveCompSet(
    strtoint(combobox2.text),
    strtoint(combobox3.text),
    strtoint(combobox4.text),
    strtoint(combobox5.text)
  );
end;







procedure TForm1.Button9Click(Sender: TObject);
var
  i,i1,i2,i3:integer;
begin
  {i := 0; i1 := -208; i3 :=0;
  resetprot;
  for i2 := 0 to 9 do begin
    prot(i + 0, i1,344 + i3);
    i := i + 1;
    i1 := i1 + 209;
    if i2 = 4 then begin
      i3 := -275 - 67;
      i1 :=-208;
    end;
  end;

  form2.QuickRep1.Preview;
  }
end;

function changupdown:boolean;
begin
  with form1 do begin
    TrackBar1.Position := updown1.Position;
    TrackBar2.Position := updown2.Position;
    TrackBar3.Position := updown3.Position;
    TrackBar4.Position := updown4.Position;
    setMoveCompSet(
      updown1.Position,
      updown2.Position,
      updown3.Position,
      updown4.Position
    );

  end;
end;

function changtrackbar:boolean;
begin
  with form1 do begin
    updown1.Position := TrackBar1.Position;
    updown2.Position := TrackBar2.Position;
    combobox3.Text := inttostr(TrackBar2.Position);
    updown3.Position := TrackBar3.Position;
    updown4.Position := TrackBar4.Position;
    setMoveCompSet(
        TrackBar1.Position,
        TrackBar2.Position,
        TrackBar3.Position,
        TrackBar4.Position
    );
  end;
end;

function changcombobox:boolean;
begin
  with form1 do begin
    try
      TrackBar1.Position := strtoint(combobox2.text);
    except
    end;
    try
      TrackBar2.Position := strtoint(combobox3.text);
    except
    end;
    try
      TrackBar3.Position := strtoint(combobox4.text);
    except
    end;
    try
      TrackBar4.Position := strtoint(combobox5.text);
    except
    end;
    setMoveCompSet(
       strtoint(combobox2.text),
       strtoint(combobox3.text),
       strtoint(combobox4.text),
       strtoint(combobox5.text)
    );
  end;
end;

function set_compSize:boolean;
begin
  changcombobox;
  changupdown;
  changtrackbar;
end;

function set_editcomp(i:integer;cmp:TControl):boolean;
begin
    with form1.comp.Items[i] do begin
      cmp.Width := Width;
      cmp.Height := Height;
      form1.ComboBox2.Text := inttostr(Top);
      form1.ComboBox3.Text := InttoStr(left);
      form1.ComboBox4.Text := IntToStr(Height);
      form1.ComboBox5.Text := IntToStr(Width);
      changcombobox;
      with form1 do
        setMoveCompSet(
          strtoint(combobox2.text),
          strtoint(combobox3.text),
          strtoint(combobox4.text),
          strtoint(combobox5.text)
        );
    end;
end;



function create_memo(i:integer;memo,m:TMemo):boolean;
begin
  with form1 do begin
    m := memo;
    with comp.Items[i] do begin
      m.top := Top;
      m.Left := Left;
      m.Width := Width;
      m.Height := Height;
      m.Visible := true;
      m.Parent := Parent;
    end;
    try
      comp.Items[i].free;
    except end;
    comp.Items[i] := m;
  end;
end;

function create_pic(i:integer;img:TImage):boolean;
begin
  with form1 do begin
    if not opendialog1.Execute then
      exit;
    img.Picture.LoadFromFile(opendialog1.FileName);
  end;
  with form1.comp.Items[i] do begin
      img.top := Top;
      img.Left := Left;
      img.Width := Width;
      img.Height := Height;
      img.Visible := true;
      img.Parent := Parent;
      img.Stretch := true;
  end;
  try
    form1.comp.Items[i].free;
  except end;
  form1.comp.Items[i] := img;
end;

function create_comp(cmp:TControl;p:TWinControl;tp,lf,dt,ht:integer):boolean;
begin
  with cmp do begin;
    Parent := p;
    top    := tp;
    Left   := lf;
    width  := dt;
    height := ht;
    Enabled := true;
    Visible:= true;
  end;
  form1.comp.Add(cmp);
end;

function select_comp(s:string;tp,lf,ht,dt:integer):boolean;
begin
  if s = '�ʐ^' then begin
    create_comp(TImage.Create(form1),form1.MeisiForm,tp,lf,dt,ht);
    create_pic(form1.comp.Count -1,TImage.Create(form1));
  end else if s = '����' then begin
   create_comp(TMemo.Create(form1),form1.MeisiForm,tp,lf,dt,ht);
  end else if s = '���G�`���̈�' then begin
    create_comp(TImage.Create(form1),form1.MeisiForm,tp,lf,dt,ht);
    create_pic(form1.comp.Count -1,TImage.Create(form1));
  end;
  form1.ComboBox6.Items.Add(
    inttostr(form1.comp.count-1) + form1.ComboBox1.Text
  );
end;


procedure TForm1.Button1Click(Sender: TObject);
begin
  select_comp(combobox1.Text,
              strtoint(combobox2.Text),
              strtoint(combobox3.Text),
              strtoint(combobox4.Text),
              strtoint(combobox5.Text));
end;


procedure TForm1.Button5Click(Sender: TObject);
var
  i:integer;
begin
   i := combobox6.ItemIndex;
   try
     comp.Items[i].free;
   except end;
   try
    comp.Delete(i);
   except end;
   combobox6.Items.delete(i);
   combobox6.text := '';
end;


procedure TForm1.Button6Click(Sender: TObject);
begin
  try
    create_pic(form1.ComboBox6.ItemIndex,TImage.Create(form1));
  except
    showmessage('�u�ʐ^�v���I������Ă��܂���B');
  end;
end;

procedure TForm1.ComboBox6Change(Sender: TObject);
begin
  if 0 < ansipos('�ʐ^',combobox6.Text) then begin
    try
      set_editcomp(combobox6.itemIndex,image1);
      image1.Visible := true;
      memo1.Visible := not true;
    except

    end;
  end else if 0 < ansipos('����',combobox6.Text) then begin
    try
      set_editcomp(combobox6.itemIndex,memo1);
      image1.Visible := not true;
      memo1.Visible := true;
    except

    end;
  end;
end;


procedure TForm1.Button7Click(Sender: TObject);
begin
  try
    create_memo(combobox6.ItemIndex,Memo1,Tmemo.Create(form1));
  except end;
end;

procedure TForm1.ComboBox2Change(Sender: TObject);
begin
  changcombobox;
end;

procedure TForm1.UpDown5Changing(Sender: TObject;
  var AllowChange: Boolean);
begin
  changupdown;
end;

procedure TForm1.TrackBar1Change(Sender: TObject);
begin
  changtrackbar;
end;


end.