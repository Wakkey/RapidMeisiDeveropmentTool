unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  quickrpt, Qrctrls, ExtCtrls, StdCtrls,Jpeg, ComCtrls, Spin;

type
  TCompList = class(TList)
  private
    function Get(Index: Integer): TControl;
    procedure Put(Index: Integer; const Value: TControl);
  public
    property Items[Index: Integer]: TControl read Get write Put; default;
     destructor Destroy; override;
  end;

  TForm1 = class(TForm)
    OpenDialog1: TOpenDialog;
    FontDialog1: TFontDialog;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel7: TPanel;
    GroupBox5: TGroupBox;
    Image1: TImage;
    Memo1: TMemo;
    GroupBox6: TGroupBox;
    MeisiForm: TPanel;
    Panel1: TPanel;
    GroupBox2: TGroupBox;
    ComboBox6: TComboBox;
    UpDown: TUpDown;
    Button5: TButton;
    Button7: TButton;
    Button10: TButton;
    Button6: TButton;
    Button8: TButton;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    TrackBar1: TTrackBar;
    TrackBar2: TTrackBar;
    TrackBar4: TTrackBar;
    TrackBar3: TTrackBar;
    UpDown1: TUpDown;
    ComboBox2: TComboBox;
    ComboBox3: TComboBox;
    UpDown2: TUpDown;
    ComboBox5: TComboBox;
    UpDown4: TUpDown;
    ComboBox4: TComboBox;
    UpDown3: TUpDown;
    GroupBox3: TGroupBox;
    ComboBox1: TComboBox;
    UpDown6: TUpDown;
    Panel8: TPanel;
    Panel4: TPanel;
    GroupBox8: TGroupBox;
    ListBox1: TListBox;
    GroupBox4: TGroupBox;
    Button9: TButton;
    Panel5: TPanel;
    Panel6: TPanel;
    Button2: TButton;
    Button12: TButton;
    Edit1: TEdit;
    setCompIMG: TGroupBox;
    MeisiPIc: TImage;
    waku: TPanel;
    procedure Button12Click(Sender: TObject);
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
    procedure Button8Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure ListBox1DblClick(Sender: TObject);
    procedure wakuMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure wakuMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure wakuMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure setCompIMGMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure setCompIMGMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure setCompIMGMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure ComboBox2KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ComboBox2KeyPress(Sender: TObject; var Key: Char);
    procedure Memo1Change(Sender: TObject);
  private
    { Private 宣言 }
    QRMemo1 : TQRRichText;
    savedir:string;
    crentDir,SearchDir:String;
    waku_move_sw:boolean;
    waku_sizeY_sw,waku_sizeX_sw:boolean;
    dwncount:integer;
    ptX,ptY:integer;
  public
    { Public 宣言 }
    compset:TMemo;
    tempmemo:string;
    comp,qrcomp:TCompList;
    setprjdir,setdir:String;
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

destructor TCompList.Destroy;
var
  i: Integer;
begin
  for i := 0 to Self.Count - 1 do
    Self.Items[i].Free;
  inherited Destroy;
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

function resetcomp:boolean;
var
  i:integer;
begin
 with form1 do begin
  combobox6.Items.Clear;
  combobox6.Text := '';
  for i := 0 to comp.Count -1 do begin
     try
       comp.Items[0].free;
     except end;
     try
       comp.Delete(0);
     except end;
  end;
 end;
end;

function EnumFileFromDir(SearchDir: string): boolean;
var
  Rec: TSearchRec;
begin
  begin
    //指定ディレクトリのすべての種類のファイルを列挙
    if FindFirst(SearchDir + '*.*', faAnyFile, Rec) = 0 then
    try
      repeat
         if ((Rec.Attr and faDirectory > 0)) and
               (Rec.Name <> '.') and (Rec.Name <> '..') then
           begin
             //見つかったフォルダを追加
             form1.ListBox1.Items.Add(Rec.Name);
           end;
       until (FindNext(Rec) <> 0);
       Result :=true;
    finally
      FindClose(Rec);
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

function setSizeCombo:boolean;
begin
  with form1 do begin
    updown1.Position := 50;
    updown2.Position := 50;
    updown3.Position := 50;
    updown4.Position := 50;
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
    top := tp -8;
    Left := lf -2;
    Width := wd+ 4;
    Height := ht +8;
  end;
  with form1.waku do begin
    Width := wd-6;
    Height := ht-8;
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
      cmp.Tag := c.Tag;
      cmp.Hint := c.Hint;
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





function create_memo(savefile:string;i:integer;memo,m:TMemo;sw:boolean):boolean;
begin
  with form1 do begin
    m.Text := memo.Text;
    m.Font := memo.Font;
    //showmessage(m.Lines.text);
    if sw then
      m.Lines.SaveToFile( {ExtractFileName}( savefile) );
    with comp.Items[i] do begin
      Hint := savefile;
      m.top := form1.UpDown1.Position;
      m.Left := form1.UpDown2.Position;
      m.Height := form1.UpDown3.Position;
      m.Width := form1.UpDown4.Position;
      m.Visible := true;
      m.Parent := Parent;
      m.onChange := Form1.Memo1Change;
    end;
    try
      comp.Items[i].free;
    except end;
    comp.Items[i] := m;
    comp.Items[i].Tag := 2;
    comp.Items[i].hint := form1.setdir + ExtractFileName(savefile) + ';' + m.Font.Name + ';' + inttostr(m.Font.Size);
    //showmessage(comp.Items[i].Hint);
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
      B := TBitmap.Create;
      J :=TJpegImage.Create;
      J.LoadFromFile(opendialog1.filename);
      J.SaveToFile( savefile );
      B.Assign(J);
      img.Picture.Assign(B);
      B.Free;
      J.Free;
    end;
  end;

  with form1.comp.Items[i] do begin
      Hint := form1.setdir + '\' + savefile;
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
    form1.comp.Items[i].hint := form1.setdir +ExtractFileName(savefile);
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
    if cmp = TMemo.Create(form1) then
      Name := 'm' + inttostr(i);
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


function select_comp(s,dir:string;tp,lf,ht,dt:integer):boolean;
begin
  if s = '写真' then begin
    create_comp(TImage.Create(form1),form1.MeisiForm,1,tp,lf,dt,ht);
    create_pic(dir + inttostr(form1.comp.count-1),form1.comp.Count -1,TImage.Create(form1),true);
  end else if s = 'メモ' then begin
   form1.compset := TMemo.Create(form1);
   create_comp(form1.compset,form1.MeisiForm,2,tp,lf,dt,ht);
  end else if s = 'お絵描き領域' then begin
    create_comp(TImage.Create(form1),form1.MeisiForm,1,tp,lf,dt,ht);
    create_pic(dir + inttostr(form1.comp.count-1),form1.comp.Count -1,TImage.Create(form1),true);
  end;
  form1.ComboBox6.Items.Add(
    inttostr(form1.comp.count-1) + form1.ComboBox1.Text
  );
end;


function loadSeting(s:string):boolean;
var
  i,i1,i2,i3,i4:integer;
  SL:TStringList;
  cmpname:string;
  M:TMemo;
  s1,s2,s3:string;
  st:TStringList;
  img:TImage;
  J:TJPegImage;
  B:TBitmap;
begin
  SL := TStringList.Create;
  SL.Clear;
  SL.LoadFromFile(s);
  M := Tmemo.Create(form1);
  m.Parent := form1;
  m.visible := false;
  m.Clear;
  st := TStringList.Create;
  st.Clear;
  i := 0;
  i1 := 0;
  while i < SL.Count -1 do begin
    if SL[i] = '2' then begin
      try
        create_comp(TMemo.Create(form1),form1.MeisiForm,1,0,0,10,10);
      except end;
      cmpname := 'メモ';
    end else if SL[i] = '1' then begin
      try
        create_comp(TImage.Create(form1),form1.MeisiForm,2,0,0,10,10);
      except end;
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
      s2 := hint;
      i2 := 1;
      i4 := 0;
      s3 := '';
      if 0 = ansipos(';',s2) then begin
        st.Text := s2;
      end else begin
        s2 := s2 + ';';
        while i2 > 0 do begin
          i2 := ansipos(';',s2);
          for i3 := i4 to i2 -1 do begin
            s3 := s3 + s2[i3];
          end;
          s2[i2] := chr(13);
          i4 := i2 -1;
          st.Add(s3);
          s3 := '';
        end;
        st.Text := s2;
      end;
      if cmpname = '写真' then begin
        img := TImage.Create(form1);
        if st.Count > 0 then begin
          B := TBitmap.Create;
          J :=TJpegImage.Create;
          try
            J.LoadFromFile(st[0]);
            B.Assign(J);
          except end;   
          img.Picture.Assign(B);
        end;
        create_pic(hint,form1.comp.Count-1,img,false);
        B.Free;
        J.Free;
      end else if cmpname = 'メモ' then begin
        if st.Count > 0 then begin
          try
            //if st[0] = null then
            m.Lines.LoadFromFile(st[0]);
            //showmessage(st[0]);
          except end;
          m.Font.Name := st[1];
          m.Font.Size := strtoint(st[2]);
        end;
        //showmessage(hint);
        create_memo(st[0],form1.comp.Count-1,M,Tmemo.Create(form1),false);
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
      //showmessage(hint);
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
      SL.add( {form1.savedir +} hint);
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

function output(tp,lf:integer):boolean;
var
  i:integer;
  function outputSet(i,tp,lf:integer):boolean;
  var
    qrm:TQRMemo;
    qri:TQRImage;
    J:TJPegImage;
    B:TBitmap;
    i2,i3,i4:integer;
    s2,s3:String;
    st:TStringList;
  begin
    ST := TStringList.Create;
    st.Clear;
    with form1.comp.items[i] do begin
      s2 := hint;
      i2 := 1;
      i4 := 0;
      s3 := '';
      if 0 = ansipos(';',s2) then begin
        st.Text := s2;
      end else begin
        s2 := s2 + ';';
        while i2 > 0 do begin
          i2 := ansipos(';',s2);
          for i3 := i4 to i2 -1 do begin
            s3 := s3 + s2[i3];
          end;
          s2[i2] := chr(13);
          i4 := i2 -1;
          st.Add(s3);
          s3 := '';
        end;
        st.Text := s2;
      end;
      if tag = 2 then begin
        try
          qrm := TQrMemo.Create(form2);
          qrm.Lines.LoadFromFile(st[0]);
          qrm.Font.Name := st[1];
          qrm.Font.Size := strtoint(st[2]);
          qrm.AutoStretch := true;
          create_qrcomp(qrm,form2.QuickRep1,tag,tp + top,lf + left,height,width);
        except end;
      end else if tag = 1 then begin
        try
          qri := TQRImage.Create(form2);
          B := TBitmap.Create;
          J :=TJpegImage.Create;
          J.LoadFromFile(st[0]);
          //showmessage(st[0]);
          B.Assign(J);
          qri.Picture.Assign(B);
          qri.Stretch := true;
          create_qrcomp(qri,form2.QuickRep1,tag,tp + top,lf + left,width,height);
          B.Free;
          J.Free;
        except end;
     end;
     st.Free;
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
 end;
end;

function Priset1:boolean;
var
  st:TStringList;
  searchdir:string;
begin
  if form1.ListBox1.Items.Count = 0 then begin
    CreateDir( ExtractFilePath( Paramstr(0) ) + '名刺サンプル');
    st := TStringList.Create;
    st.Text :=
    '2' + chr(13)
    + '0;ＭＳ Ｐゴシック;9' + chr(13)
    + '20' + chr(13)
    + '68' + chr(13)
    + '36' + chr(13)
    + '261' + chr(13)
    + '2' + chr(13)
    + '0;ＭＳ Ｐゴシック;14' + chr(13)
    + '63' + chr(13)
    + '68' + chr(13)
    + '36' + chr(13)
    + '261' + chr(13)
    + '2' + chr(13)
    + '0;ＭＳ Ｐゴシック;10' + chr(13)
    + '108' + chr(13)
    + '9' + chr(13)
    + '94' + chr(13)
    + '321' + chr(13)
    + '1' + chr(13)
    + '0' + chr(13)
    + '27' + chr(13)
    + '9' + chr(13)
    + '62' + chr(13)
    + '53' + chr(13);
    st.SaveToFile(ExtractFilePath( Paramstr(0) ) + '名刺サンプル' + '\Meisi.mpr');
    st.Free;
    {form1.setprjdir := ExtractFilePath( Paramstr(0) ) + '名刺サンプル' + '\';
    loadseting(ExtractFilePath( Paramstr(0) ) + '名刺サンプル' + '\Meisi.mpr');}
    SearchDir := ExtractFilePath( Paramstr(0) );
    EnumFileFromDir(SearchDir);
    form1.ListBox1.ItemIndex := 0;
    Form1.ListBox1DblClick(Form1.ListBox1);
  end;
end;

procedure TForm1.Button12Click(Sender: TObject);
var
  s:string;
begin
  s := ( form1.setprjdir + 'Meisi.mpr');
  saveSeting(s);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  //createmeomo;
  dwncount := 0;
  comp := TCompList.Create;
  comp.clear;
  QrComp := TCompList.Create;
  QrComp.clear;
  setMeisiSize;
  setSizeCombo;
  //form1.setcompIMG := Timage.Create(form1);
  with form1.setcompIMG do begin
    parent := form1.MeisiForm;
    visible := true;
  end;
  setMoveCompSet(
    50,
    50,
    50,
    50
  );
  form1.crentdir := ExtractFilePath( Paramstr(0) );
  SearchDir := ExtractFilePath( Paramstr(0) );
  EnumFileFromDir(SearchDir);
  Priset1;
end;







procedure TForm1.Button9Click(Sender: TObject);
var
  i,i1,i2,i3:integer;
begin
  i := 0; i1 := -208; i3 :=0;
  //resetprot;
  try
    for i2 := 0 to 9 do begin
      prot(i + 0, i1,344 + i3);
      i := i + 1;
      i1 := i1 + 209;
      if i2 = 4 then begin
        i3 := -275 - 67;
        i1 :=-208;
      end;
    end;
  except

  end;
  try
    form2.QuickRep1.Preview;
  except end;
end;



procedure TForm1.Button1Click(Sender: TObject);
begin
  select_comp(combobox1.Text,
              form1.setprjdir,
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
    create_pic(form1.setprjdir + inttostr(form1.ComboBox6.ItemIndex),form1.ComboBox6.ItemIndex,TImage.Create(form1),true);
  except
    showmessage('項目が選択されていません。');
  end;
end;

procedure TForm1.ComboBox6Change(Sender: TObject);
var
  J:TJPegImage;
  B:TBitmap;
  ST:TStringList;
  function setfilename(st:TStringList;c:TControl):boolean;
  var
    s2,s3:String;
    i2,i3,i4:integer;
  begin
    st.Clear;
    s2 := c.hint;
    i2 := 1;
    i4 := 0;
    s3 := '';
    if 0 = ansipos(';',s2) then begin
      st.Text := s2;
    end else begin
      s2 := s2 + ';';
      while i2 > 0 do begin
        i2 := ansipos(';',s2);
      for i3 := i4 to i2 -1 do begin
        s3 := s3 + s2[i3];
      end;
      s2[i2] := chr(13);
      i4 := i2 -1;
      st.Add(s3);
      s3 := '';
    end;
    st.Text := s2;
    end;
  end;
begin
  if 0 < ansipos('写真',combobox6.Text) then begin
    try
      set_editcomp(combobox6.itemIndex,image1);
      B := TBitmap.Create;
      J :=TJpegImage.Create;
      ST := TStringList.Create;
        setfilename(st,Image1);
      if st.Count > 0 then begin
        try
          J.LoadFromFile(st[0]);
          B.Assign(J);
        except end;
        image1.Picture.Assign(B);
      end;
      b.Free;
      j.Free;
      image1.Stretch := true;
      image1.Visible := true;
      memo1.Visible := not true;
    except

    end;
  end else if 0 < ansipos('メモ',combobox6.Text) then begin
    try
      set_editcomp(combobox6.itemIndex,memo1);
      image1.Visible := not true;
      ST := TStringList.Create;
      setfilename(st,memo1);
      if st.Count > 0 then begin
        try
          //showmessage(st[0]);
          memo1.Lines.LoadFromFile(st[0]);
        except end;
        memo1.Font.Name := st[1];
        memo1.Font.Size := strtoint(st[2]);
      end;
      memo1.Visible := true;
    except

    end;
  end;
  st.Free;
end;


procedure TForm1.Button7Click(Sender: TObject);
begin
  savedir := form1.setprjdir;
  if 0 < ansipos('メモ',combobox6.Text) then begin
    try
      create_memo( form1.setprjdir + inttostr(combobox6.ItemIndex),combobox6.ItemIndex,Memo1,Tmemo.Create(form1),true);
    except end;
  end else if 0 < ansipos('写真',combobox6.Text) then begin
    try
      create_PIC( form1.setprjdir + inttostr(combobox6.ItemIndex),combobox6.ItemIndex,Image1,false);
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
  MeisiPIC.Picture.Assign(B);
  B.Free;
  J.Free;
end;

procedure TForm1.Button8Click(Sender: TObject);
begin
  if not fontdialog1.Execute then
    exit;
  memo1.Font := fontdialog1.Font;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  resetcomp;
  if -1 = form1.ListBox1.Items.IndexOf(edit1.Text) then begin
    CreateDir( ExtractFilePath( Paramstr(0) ) + edit1.Text);
    form1.setprjdir := ExtractFilePath( Paramstr(0) ) + edit1.Text + '\';
    form1.setdir := {ExtractFilePath( Paramstr(0) ) +} edit1.Text + '\';
    SearchDir := ExtractFilePath( Paramstr(0) );
    listbox1.Items.Clear;
    EnumFileFromDir(SearchDir);
    form1.comp.Free;
    form1.comp := TcompList.Create;
    form1.comp.Clear;
    form1.qrcomp.Free;
    form1.qrcomp := TcompList.Create;
    form1.qrcomp.Clear;
    saveseting(form1.setprjdir + 'Meisi.mpr')
  end;
end;

procedure TForm1.ListBox1DblClick(Sender: TObject);
var
  loadfile:string;
begin
  resetcomp;
  loadfile := ExtractFilePath( Paramstr(0) ) + listbox1.Items[listbox1.itemindex] +'\Meisi.mpr';
   form1.setprjdir := ExtractFilePath( Paramstr(0) ) + listbox1.Items[listbox1.itemindex] + '\';
   form1.setdir := {ExtractFilePath( Paramstr(0) ) +} listbox1.Items[listbox1.itemindex] + '\';
  loadSeting(loadfile);
end;

















procedure TForm1.wakuMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  waku_move_sw := true;
  ptY := Y;
  ptX := X;
end;

procedure TForm1.wakuMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  waku_move_sw := not true;
  changtrackbar;
end;

procedure TForm1.wakuMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
var
  setx,sety:integer;
begin
  if waku_move_sw then begin
    with form1.setCompIMG do begin
      setY := top + Y - ptY +8;//form1.SpinEdit1.Value;
      setX := left + x - ptX +2;//form1.SpinEdit2.Value;
      top := setY;
      left := setX;
    end;
    form1.TrackBar1.Position := setY;
    form1.TrackBar2.Position := setX;
    form1.ComboBox2.Text := inttostr(setY);
    form1.ComboBox3.Text := inttostr(setX);
    form1.UpDown1.Position := setY;
    form1.UpDown2.Position := setX;
  end;
end;

procedure TForm1.setCompIMGMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if ( Y > 12 ) and ( X > 4 ) then begin
    if ( X > form1.setcompimg.width -10 ) and ( Y > form1.setcompimg.Height -10 ) then begin
      waku_sizeY_sw := true;
      waku_sizeX_sw := true;
    end else if X > form1.setcompimg.width -10 then begin
      waku_sizeY_sw := true;
    end else if Y > form1.setcompimg.Height -10 then begin
      waku_sizeX_sw := true;
    end;
    {waku_move_sw := true;
    ptY := Y;
    ptX := X;}
  end
end;

procedure TForm1.setCompIMGMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  waku_sizeY_sw := not true;
  waku_sizeX_sw := not true;
  changtrackbar;
end;

procedure TForm1.setCompIMGMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
var
  setX,setY:integer;
begin
  if waku_sizeY_sw then begin
    if form1.setCompIMG.Width > 10 then begin
      with form1.setCompIMG do begin
        setX :=  X;
        width := setX
      end;
      with form1.waku do begin
        setX :=  X -8;
        width := setX
      end;
      form1.TrackBar4.Position := setX;
      form1.ComboBox5.Text := inttostr(setX);
      form1.UpDown4.Position := setX;
    end else form1.setCompIMG.Width := 10 + 2;
  end;
  if waku_sizeX_sw then begin
    if form1.setCompIMG.Height > 10 then begin
      with form1.setCompIMG do begin
        setY :=  Y;
        Height := setY
      end;
      with form1.waku do begin
        setY := Y -8;
        Height := setY
      end;
      form1.TrackBar3.Position := setY;
      form1.ComboBox4.Text := inttostr(setY);
      form1.UpDown3.Position := setY;
    end else form1.setCompIMG.Height := 10 + 2;
  end;
end;

procedure TForm1.ComboBox2KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  //if (key <> null)   then begin
   // key := word(0);
    //showmessage('aa');
 // end
end;

procedure TForm1.ComboBox2KeyPress(Sender: TObject; var Key: Char);
var
  i,i1:integer;
begin
  //showmessage(inttostr(dwncount));
  {if key = char(dwncount) then begin
    dwncount := word(key) * 10;
  end else begin
    dwncount := word(key);
  end;
  for i := 0 to TComboBox(Form1.ActiveControl).items.count -1 do begin
    i1 := ansipos(inttostr(dwncount),TComboBox(Form1.ActiveControl).items[i]);
    if 0 < i1 then begin
      dwncount := i1;

      break
    end;
  end;}
  TComboBox(Form1.ActiveControl).itemIndex := i;
  key := chr(0);
  PostMessage(TComboBox(Form1.ActiveControl).Handle, CB_SHOWDROPDOWN, 1, 0);
end;


procedure TForm1.Memo1Change(Sender: TObject);
var
  i:integer;
  cmpmemo:TComponent;
begin
  //ここに、メモ保存処理を記述する。
  for i := 0 to comp.Count -1 do begin
    if sender = comp.Items[i] then begin
      //cmpmemo := FindComponent('m' + inttostr(i));
      
      create_memo( form1.setprjdir + inttostr(i),i,compset,Tmemo.Create(form1),true);
    end;
  end;

end;

end.

