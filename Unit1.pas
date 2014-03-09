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
    MeisiPanel: TPanel;
    Button9: TButton;
    Button1: TButton;
    MeisiForm: TQRImage;
    ComboBox1: TComboBox;
    ComboBox2: TComboBox;
    UpDown1: TUpDown;
    UpDown: TUpDown;
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
    UpDown2: TUpDown;
    UpDown6: TUpDown;
    ComboBox3: TComboBox;
    ComboBox5: TComboBox;
    Button6: TButton;
    Button7: TButton;
    Button8: TButton;
    setCompIMG: TImage;
    Panel5: TPanel;
    Image1: TImage;
    Memo1: TMemo;
    Button10: TButton;
    procedure Button2Click(Sender: TObject);
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
    procedure UpDown2Changing(Sender: TObject; var AllowChange: Boolean);
    procedure TrackBar1Change(Sender: TObject);
    procedure Button10Click(Sender: TObject);
  private
    { Private 宣言 }
    QRMemo1 : TQRRichText;
    savedir:string;
  public
    { Public 宣言 }
    comp,qrcomp:TCompList;
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

    form1.UpDown1.Max := Height;
    form1.UpDown2.Max := Width;
    form1.UpDown3.Max := Height;
    form1.UpDown4.Max := Width;
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

function changupdown:boolean;
begin
  with form1 do begin
    TrackBar1.Position := updown1.Position;
    TrackBar2.Position := updown2.Position;
    TrackBar3.Position := updown3.Position;
    combobox4.Text := inttostr(trackbar3.position);
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
      updown3.Position := strtoint(combobox4.text);
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

function set_editcomp(i:integer;cmp:Tcontrol):boolean;
var
  c:Tcontrol;
begin
    with form1.comp.Items[i] do begin
      c := form1.comp.Items[i];
      cmp.Width := c.Width;
      cmp.Height := c.Height;
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


function create_Qmemo(savefile:string;i:integer;memo,m:TQrMemo):boolean;
begin
  with form1 do begin
    m.Lines.Text := memo.Lines.Text;
    m.Font := memo.Font;
    m.Lines.SaveToFile(ExtractFilePath( Paramstr(0) ) + savefile);
    with comp.Items[i] do begin
      Hint := savefile;
      m.top := form1.UpDown1.Position;
      m.Left := form1.UpDown2.Position;
      m.Height := form1.UpDown3.Position;
      m.Width := form1.UpDown4.Position;
      m.Visible := true;
      m.Parent := Parent;
    end;
    try
      comp.Items[i].free;
    except end;
    comp.Items[i] := m;
    comp.Items[i].Tag := 2;
    comp.Items[i].hint := savefile;
    //showmessage(comp.Items[i].Hint + ' ' +savefile);
  end;
end;

function create_Qpic(savefile:string;i:integer;img:TQrImage;loadPIC:boolean):boolean;
var
  J:TJPegImage;
  B:TBitmap;
begin
  with form1 do begin
    if loadPIC then begin
      if not opendialog1.Execute then
        exit;
    end;
      B := TBitmap.Create;
      J :=TJpegImage.Create;
      J.LoadFromFile(opendialog1.FileName);
      J.SaveToFile( savefile);
      B.Assign(J);
      img.Picture.Assign(B);
      B.Free;
      J.Free;
  end;

  with form1.comp.Items[i] do begin
      Hint := savefile;
      img.top := form1.TrackBar1.Position;
      img.Left := form1.TrackBar2.Position;
      img.Width := form1.TrackBar4.Position;
      img.Height := form1.TrackBar3.Position;
      img.Visible := true;
      img.Parent := Parent;
      img.Stretch := true;
  end;
  //if loadPIC then begin
    try
      form1.comp.Items[i].free;
    except end;
    form1.comp.Items[i] := img;
    form1.comp.Items[i].hint := savefile;
    form1.comp.Items[i].Tag := 1;
 // end;
end;



function create_memo(savefile:string;i:integer;memo,m:TMemo):boolean;
begin
  with form1 do begin
    m.Text := memo.Text;
    m.Font := memo.Font;
    m.Lines.SaveToFile(savefile);
    with comp.Items[i] do begin
      Hint := savefile;
      m.top := form1.UpDown1.Position;
      m.Left := form1.UpDown2.Position;
      m.Height := form1.UpDown3.Position;
      m.Width := form1.UpDown4.Position;
      m.Visible := true;
      m.Parent := Parent;
    end;
    try
      comp.Items[i].free;
    except end;
    comp.Items[i] := m;
    comp.Items[i].Tag := 2;
    comp.Items[i].hint := savefile;
    //showmessage(comp.Items[i].Hint + ' ' +savefile);
  end;
end;

function create_pic(savefile:string;i:integer;img:TImage;loadPIC:boolean):boolean;
var
  J:TJPegImage;
  B:TBitmap;
begin
  with form1 do begin
    if loadPIC then begin
      if not opendialog1.Execute then
        exit;
    end;
      B := TBitmap.Create;
      J :=TJpegImage.Create;
      J.LoadFromFile(opendialog1.FileName);
      J.SaveToFile(savefile);
      B.Assign(J);
      img.Picture.Assign(B);
      B.Free;
      J.Free;
  end;

  with form1.comp.Items[i] do begin
      Hint := savefile;
      img.top := form1.TrackBar1.Position;
      img.Left := form1.TrackBar2.Position;
      img.Width := form1.TrackBar4.Position;
      img.Height := form1.TrackBar3.Position;
      img.Visible := true;
      img.Parent := Parent;
      img.Stretch := true;
  end;
  //if loadPIC then begin
    try
      form1.comp.Items[i].free;
    except end;
    form1.comp.Items[i] := img;
    form1.comp.Items[i].hint := savefile;
    form1.comp.Items[i].Tag := 1;
 // end;
end;

function create_comp(cmp:TControl;p:TWinControl;i,tp,lf,dt,ht:integer):boolean;
begin
  with cmp do begin;
    Parent := p;
    top    := tp;
    Left   := lf;
    width  := dt;
    height := ht;
    Hint := '';
    Tag := i;
    Enabled := true;
    Visible:= true;
  end;
  form1.comp.Add(cmp);
end;

function create_qrcomp(cmp:TControl;p:TWinControl;i,tp,lf,dt,ht:integer):boolean;
begin
  with cmp do begin;
    Parent := p;
    top    := tp;
    Left   := lf;
    width  := dt;
    height := ht;
    Hint := '';
    Tag := i;
    Enabled := true;
    Visible:= true;
  end;
  form1.qrcomp.Add(cmp);
end;


function select_comp(s:string;tp,lf,ht,dt:integer):boolean;
begin
  if s = '写真' then begin
    create_comp(TImage.Create(form1),form1.MeisiForm,1,tp,lf,dt,ht);
    create_pic(inttostr(form1.comp.count-1),form1.comp.Count -1,TImage.Create(form1),true);
  end else if s = 'メモ' then begin
   create_comp(TMemo.Create(form1),form1.MeisiForm,2,tp,lf,dt,ht);
  end else if s = 'お絵描き領域' then begin
    create_comp(TImage.Create(form1),form1.MeisiForm,1,tp,lf,dt,ht);
    create_pic(inttostr(form1.comp.count-1),form1.comp.Count -1,TImage.Create(form1),true);
  end;
  form1.ComboBox6.Items.Add(
    inttostr(form1.comp.count-1) + form1.ComboBox1.Text
  );
end;


function loadSeting(s:string):boolean;
var
  i,i1:integer;
  SL:TStringList;
  cmpname:string;
  M:TMemo;
  s1:string;
begin
  SL := TStringList.Create;
  SL.Clear;
  SL.LoadFromFile(s);
  M := Tmemo.Create(form1);
  m.Parent := form1;
  m.visible := false;
  m.Clear;
  i := 0;
  i1 := 0;
  while i < SL.Count -1 do begin
    if SL[i] = '2' then begin
      create_comp(TMemo.Create(form1),form1.MeisiPanel,1,0,0,10,10);
      cmpname := 'メモ';
    end else if SL[i] = '1' then begin
      create_comp(TImage.Create(form1),form1.MeisiForm,2,0,0,10,10);
      cmpname := '写真';
    end;

    form1.ComboBox6.Items.Add(
      inttostr(form1.comp.Count -1) + cmpname
    );
    with form1.comp.Items[i1] do begin
      s1 := sl[i];
//      showmessage(s1);
      tag := strtoint(SL[i]);
      hint := SL[i+1];
      if cmpname = '写真' then
        create_pic(hint,form1.comp.Count-1,TImage.Create(form1),false);
      if cmpname = 'メモ' then begin
        m.Lines.LoadFromFile(hint);
        create_memo(hint,form1.comp.Count-1,M,Tmemo.Create(form1));
      end;
      i := i + 6;
      inc(i1);
      //showmessage(s1);
    end;
  end;
  i := 0;
  i1 := 0;
  while i < SL.Count -1 do begin
    with form1.comp.Items[i1] do begin
      tag := strtoint(SL[i]);
      hint := SL[i+1];
      TOP := strtoint(SL[i+2]);
      LEFT := strtoint(SL[i+3]);
      Height := strtoint(SL[i+4]);
      Width := strtoint(SL[i+5]);
      i := i + 6;
      inc(i1);
    end;
  end;
  M.free;
  SL.Free;
end;

function saveSeting(s:string):boolean;
var
  i:integer;
  SL:TStringList;
begin
  SL := TStringList.Create;
  SL.Clear;
  i := 0;
  while i < form1.comp.Count do begin
    with form1.comp.Items[i] do begin
      SL.add(inttostr(tag));
      SL.add( form1.savedir + hint);
      SL.add(inttostr(TOP));
      SL.add(inttostr(LEFT));
      SL.add(inttostr(Height));
      SL.add(inttostr(Width));
      inc(i);
    end;
  end;
  SL.SaveToFile(s);
  SL.Free;
end;

function prtSeting(s:string):boolean;
var
  i,i1:integer;
  SL:TStringList;
  cmpname:string;
  M:TQrMemo;
begin
  SL := TStringList.Create;
  SL.Clear;
  SL.LoadFromFile(s);
  M := TQrmemo.Create(form2);
  m.Parent := form2;
  m.Lines.Clear;
  i := 0;
  i1 := 0;
  while i < SL.Count -1 do begin
    if SL[i] = '2' then begin
      create_comp(TQrMemo.Create(form2),form2.QuickRep1,1,0,0,10,10);
      cmpname := 'メモ';
    end else if SL[i] = '1' then begin
      create_comp(TQrImage.Create(form2),form2.QuickRep1,2,0,0,10,10);
      cmpname := '写真';
    end;


    with form1.comp.Items[i1] do begin
      tag := strtoint(SL[i]);
      hint := SL[i+1];
      if cmpname = '写真' then
        create_Qpic(hint,form1.comp.Count-1,TQrImage.Create(form2),false);
      if cmpname = 'メモ' then
        create_Qmemo(hint,form1.comp.Count-1,M,TQrmemo.Create(form2));
      i := i + 6;
      inc(i1);

    end;
  end;
  i := 0;
  i1 := 0;
  while i < SL.Count -1 do begin
    with form1.comp.Items[i1] do begin
      tag := strtoint(SL[i]);
      hint := SL[i+1];
      TOP := strtoint(SL[i+2]);
      LEFT := strtoint(SL[i+3]);
      Height := strtoint(SL[i+4]);
      Width := strtoint(SL[i+5]);
      visible := true;
      i := i + 6;
      inc(i1);
    end;
  end;
  M.free;
  SL.Free;
end;


function setPrint:boolean;
begin
  if not form1.opendialog1.Execute then
    exit;
  form2.QuickRep1.Preview;
  prtseting(form1.OpenDialog1.FileName);

  //saveSeting(ExtractFilePath( Paramstr(0) )+ 'aa');
  //prtSeting(ExtractFilePath( Paramstr(0) ) +'aa');

end;
function output(tp,lf:integer):boolean;
var
  i:integer;
  function outputSet(i,tp,lf:integer):boolean;
  var
    qrm:TQRMemo;
  begin
    with form1.comp.items[i] do begin
      qrm := TQrMemo.Create(form2);
      qrm.Lines.LoadFromFile(hint);
      create_qrcomp(qrm,form2.QuickRep1,tag,tp + top,lf + left,height,width);
    end;
  end;
begin
  for i := 0 to form1.comp.Count -1 do begin
    outputset(i,tp,lf);
  end;
end;

function prot(i,i1,i2:integer):boolean;
begin
 with form1 do begin
   output(i1+ 249,i2+54);


  //for i := 0 to
  form2.MeisiForm.Parent := form2.QuickRep1;
  form2.MeisiForm.Picture := form1.Image1.Picture;
  //i := 0; i1:= -208; i2 := 344;

  qrimg2[i]:=Tqrimage.Create(form2.MeisiForm);
  qrimg2[i].parent := form2.QuickRep1;
  //qrimg2[].setBounds( form2.QRImage2.Left ,form2.QRImage2.Top, form2.QRImage2.Width , form2.QRImage2.Height );

  qrimg2[i].Top := i1 + 249;
  qrimg2[i].Left := i2 + 54;
  qrimg2[i].Height :=209;
  qrimg2[i].Width :=  345;
  qrimg2[i].Picture := form1.Image1.Picture;
  qrimg2[i].Stretch := true;
  qrimg2[i].Visible := true;

  qrimg[i]:=Tqrimage.Create(form2.MeisiForm);
  qrimg[i].parent := form2.QuickRep1;
  //qrimg[i].setBounds( form2.QRImage1.Left ,form2.QRImage1.Top, form2.QRImage1.Width , form2.QRImage1.Height );

  qrimg[i].Top := i1 + 276;
  qrimg[i].Left := i2 + 83;
  //qrimg[i].Picture := form2.QRImage1.Picture;
  qrimg[i].Stretch := true;
  qrimg[i].Visible := true;
   //i := 30;
  QRLabel[i] := TQRMemo.Create(form1.Memo1);
  QRLabel[i].parent := form2.QuickRep1;
  //QRLabel[i].setBounds( form2.QRLabel1.Left, form2.QRLabel1.Top,form2.QRLabel1.Width,form2.QRLabel1.Height);
  QRLabel[i].AutoSize := false;
  QRLabel[i].Top := i1 +  256;
  QRLabel[i].Left := i2 +  135;
  //QRLabel[i].Height := form2.QRLabel1.Height;
  //QRLabel[i].Font := form2.QRLabel1.Font;
  //QRLabel[i].Lines.Text := form2.QRLabel1.Lines.Text;
  QRLabel[i].Visible := true;
  QRLabel[i].Transparent := true;
  //QRLabel[i].Font.Color := form2.QRLabel1.Font.Color;

  //i := 29;
  QRLabel[i+1]:= TQRMemo.Create(form1.memo1);
  QRLabel[i+1].parent := form2.QuickRep1;
  //QRLabel[i+1].setBounds( form2.QRLabel2.left, form2.QRLabel2.Top,form2.QRLabel2.Width,form2.QRLabel2.Height);
  QRLabel[i+1].AutoSize := false;
  QRLabel[i+1].Top :=  i1 + 275;
  QRLabel[i+1].Left := i2 +  135;
  //QRLabel[i+1].Height := form2.QRLabel2.Height;
  //QRLabel[i+1].Font := form2.QRLabel2.Font;
  //QRLabel[i+1].Lines.Text := form2.QRLabel2.Lines.Text;

  QRLabel[i+1].Visible := true;
  QRLabel[i+1].Transparent := true;
  QRLabel[i+1].WordWrap := true;
  //QRLabel[i+1].Font.Color := form2.QRLabel2.Font.Color;
  //
 // i := 28;
  QRLabel[i+2] := TQRMemo.Create(form1.memo1);
  QRLabel[i+2].parent := form2.QuickRep1;
  //QRLabel[i+2].setBounds( form2.QRLabel4.Left, form2.QRLabel4.Top,form2.QRLabel4.Width,form2.QRLabel4.Height);
  QRLabel[i+2].AutoSize := false;
  QRLabel[i+2].Top := i1 + 305;
  QRLabel[i+2].Left := i2 +  135;
  //QRLabel[i+2].Font := form2.QRLabel4.Font;
  //QRLabel[i+2].Lines.Text := form2.QRLabel4.Lines.Text;
  QRLabel[i+2].Visible := true;
  QRLabel[i+2].Transparent := true;
  //QRLabel[i+2].Font.Color := form2.QRLabel4.Font.Color;
  //QRLabel[i].AutoSize := true;
 // i := 27;
  QRLabel[i+3] := TQRMemo.Create(form1.memo1);
  QRLabel[i+3].parent := form2.QuickRep1;
  //QRLabel[i+3].setBounds( form2.QRLabel4.Left, form2.QRLabel4.Top,form2.QRLabel4.Width,form2.QRLabel4.Height);
  QRLabel[i+3].AutoSize := false;
  QRLabel[i+3].Top := i1 +  305;
  QRLabel[i+3].Left := i2 +  135;
  //QRLabel[i+3].Font := form2.QRLabel4.Font;
  //QRLabel[i+3].Lines.Text := form2.QRLabel4.Lines.Text;
  QRLabel[i+3].Visible := true;
  QRLabel[i+3].Transparent := true;
  //QRLabel[i+3].Font.Color := form2.QRLabel4.Font.Color;
  //QRLabel[i].AutoSize := true;
  //i := 26;
  QRLabel[i+4] := TQRMemo.Create(form1.memo1);
  QRLabel[i+4].parent := form2.QuickRep1;
  //QRLabel[i+4].setBounds( form2.QRLabel4.Left, form2.QRLabel4.Top,form2.QRLabel4.Width,form2.QRLabel4.Height);
  QRLabel[i+4].AutoSize := false;
  QRLabel[i+4].Top :=  i1 + 305;
  QRLabel[i+4].Left := i2 +  135;
  //QRLabel[i+4].Font := form2.QRLabel4.Font;
  //QRLabel[i+4].Lines.Text := form2.QRLabel4.Lines.Text;
  QRLabel[i+4].Visible := true;
  QRLabel[i+4].Transparent := true;
  //QRLabel[i+4].Font.Color := form2.QRLabel4.Font.Color;
  //QRLabel[i].AutoSize := true;
  //i := 25;
  QRLabel[i+5] := TQRMemo.Create(form1.memo1);
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
  QRLabel[i+6] := TQRMemo.Create(form1.memo1);
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
  QRMemo[i+7] := TQRMemo.Create(form1.memo1);
  QRMemo[i+7].parent := form2.QuickRep1;
  //QRMemo[i+7].setBounds( form2.QRMemo1.Left, form2.QRMemo1.Top,form2.QRMemo1.Width,form2.QRMemo1.Height);

  QRMemo[i+7].Top :=  i1 + 339;
  QRMemo[i+7].Left := i2 +  64;
  //QRMemo[i+7].Font := form2.QRMemo1.Font;
  //QRMemo[i+7].Lines.Text := form2.qrmemo1.Lines.Text;
  QRMemo[i+7].AutoSize := true;
  QRMemo[i+7].Height := 88;
  QRMemo[i+7].Visible := true;
  QRMemo[i+7].Transparent := true;
  //QRMemo[i+7].Font.Color := form2.QRMemo1.Font.Color;
 end;
end;




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
  setPrint;
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

procedure TForm1.Button12Click(Sender: TObject);
Var
  Jpeg :TJpegImage;
  bmp:tbitmap;
  s:string;
  s1,s2:string;
  i :integer;
begin
  if not savedialog1.Execute then
    exit;
  savedir := ExtractFilePath(savedialog1.FileName);
  saveSeting(savedialog1.FileName);

  {i := 1;
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
  if not opendialog1.Execute then
    exit;
  loadSeting(opendialog1.FileName);


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



procedure TForm1.FormCreate(Sender: TObject);
begin
  //createmeomo;
  comp := TCompList.Create;
  comp.clear;
  QrComp := TCompList.Create;
  QrComp.clear;
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
  i := 0; i1 := -208; i3 :=0;
  //resetprot;
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
    create_pic(inttostr(form1.ComboBox6.ItemIndex),form1.ComboBox6.ItemIndex,TImage.Create(form1),true);
  except
    showmessage('「写真」が選択されていません。');
  end;
end;

procedure TForm1.ComboBox6Change(Sender: TObject);
begin
  if 0 < ansipos('写真',combobox6.Text) then begin
    try
      set_editcomp(combobox6.itemIndex,image1);
      image1.Visible := true;
      memo1.Visible := not true;
    except

    end;
  end else if 0 < ansipos('メモ',combobox6.Text) then begin
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
  savedir := ExtractFilePath(savedialog1.FileName);
  if 0 < ansipos('メモ',combobox6.Text) then begin
    try
      create_memo( inttostr(combobox6.ItemIndex),combobox6.ItemIndex,Memo1,Tmemo.Create(form1));
    except end;
  end else if 0 < ansipos('写真',combobox6.Text) then begin
    try
      create_PIC(inttostr(combobox6.ItemIndex),combobox6.ItemIndex,Image1,false);
    except end;
  end;


end;

procedure TForm1.ComboBox2Change(Sender: TObject);
begin
  changcombobox;
end;

procedure TForm1.UpDown2Changing(Sender: TObject;
  var AllowChange: Boolean);
begin
  changupdown;
end;

procedure TForm1.TrackBar1Change(Sender: TObject);
begin
  changtrackbar;
end;



procedure TForm1.Button10Click(Sender: TObject);
var
  J:TJPegImage;
  B:TBitmap;
begin
  if not opendialog1.Execute then
    exit;
  B := TBitmap.Create;
  J :=TJpegImage.Create;
  J.LoadFromFile(opendialog1.FileName);
  B.Assign(J);
  MeisiForm.Picture.Assign(B);
  B.Free;
  J.Free;
end;

end.
