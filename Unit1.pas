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
    FontDialog1: TFontDialog;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    GroupBox2: TGroupBox;
    ComboBox6: TComboBox;
    UpDown: TUpDown;
    Button5: TButton;
    Button7: TButton;
    Button10: TButton;
    Button6: TButton;
    Button8: TButton;
    GroupBox3: TGroupBox;
    ComboBox1: TComboBox;
    UpDown6: TUpDown;
    Button1: TButton;
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
    GroupBox5: TGroupBox;
    Image1: TImage;
    Memo1: TMemo;
    GroupBox6: TGroupBox;
    MeisiPanel: TPanel;
    setCompIMG: TImage;
    MeisiForm: TQRImage;
    GroupBox8: TGroupBox;
    ListBox1: TListBox;
    Button4: TButton;
    Panel5: TPanel;
    GroupBox4: TGroupBox;
    GroupBox7: TGroupBox;
    Edit1: TEdit;
    Panel6: TPanel;
    Button2: TButton;
    Button9: TButton;
    Button12: TButton;
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
  private
    { Private 宣言 }
    QRMemo1 : TQRRichText;
    savedir:string;
    crentDir,SearchDir:String;
  public
    { Public 宣言 }
    comp,qrcomp:TCompList;
    setprjdir:String;
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





function create_memo(savefile:string;i:integer;memo,m:TMemo):boolean;
begin
  with form1 do begin
    m.Text := memo.Text;
    m.Font := memo.Font;
    m.Lines.SaveToFile( savefile);
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
    comp.Items[i].hint := savefile + ';' + m.Font.Name + ';' + inttostr(m.Font.Size);
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
      J.LoadFromFile(opendialog1.FileName);
      J.SaveToFile( savefile);
      B.Assign(J);
      img.Picture.Assign(B);
      B.Free;
      J.Free;
    end;
  end;

  with form1.comp.Items[i] do begin
      Hint := form1.setprjdir + '\' + savefile;
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


function select_comp(s,dir:string;tp,lf,ht,dt:integer):boolean;
begin
  if s = '写真' then begin
    create_comp(TImage.Create(form1),form1.MeisiForm,1,tp,lf,dt,ht);
    create_pic(dir + inttostr(form1.comp.count-1),form1.comp.Count -1,TImage.Create(form1),true);
  end else if s = 'メモ' then begin
   create_comp(TMemo.Create(form1),form1.MeisiForm,2,tp,lf,dt,ht);
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
        B := TBitmap.Create;
        J :=TJpegImage.Create;
        J.LoadFromFile(st[0]);
        B.Assign(J);
        img.Picture.Assign(B);
        create_pic(hint,form1.comp.Count-1,img,false);
        B.Free;
        J.Free;
      end else if cmpname = 'メモ' then begin
        m.Lines.LoadFromFile(st[0]);
        m.Font.Name := st[1];
        m.Font.Size := strtoint(st[2]);
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
          create_qrcomp(qri,form2.QuickRep1,tag,tp + top,lf + left,height,width);
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
  form1.crentdir := ExtractFilePath( Paramstr(0) );
  SearchDir := ExtractFilePath( Paramstr(0) );
  EnumFileFromDir(SearchDir);
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
  savedir := form1.setprjdir;
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

procedure TForm1.Button8Click(Sender: TObject);
begin
  if not fontdialog1.Execute then
    exit;
  memo1.Font := fontdialog1.Font;
end;






























procedure TForm1.Button2Click(Sender: TObject);
begin
  if -1 = form1.ListBox1.Items.IndexOf(edit1.Text) then begin
    CreateDir( ExtractFilePath( Paramstr(0) ) + edit1.Text);
    form1.setprjdir := ExtractFilePath( Paramstr(0) ) + edit1.Text + '\';
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
  loadfile := ExtractFilePath( Paramstr(0) ) + listbox1.Items[listbox1.itemindex] +'\Meisi.mpr';
   form1.setprjdir := ExtractFilePath( Paramstr(0) ) + listbox1.Items[listbox1.itemindex] + '\';
  loadSeting(loadfile);
end;









end.
