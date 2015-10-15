unit Unit1;

{$MODE Delphi}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, ExtCtrls, FileUtil, shellapi,comobj, Process,
  lclintf;

type
  TCompList = class(TList)
  private
    function Get(Index: Integer): TControl;
    procedure Put(Index: Integer; const Value: TControl);
  public
    property Items[Index: Integer]: TControl read Get write Put; default;
     destructor Destroy; override;
  end;

  { TForm1 }

  TForm1 = class(TForm)
   Button1: TButton;
   Button3: TButton;
   Image2: TImage;
   Label5: TLabel;
   MeisiForm: TPanel;
   MeisiPIc: TImage;
    Panel4: TPanel;
    GroupBox8: TGroupBox;
    ListBox1: TListBox;
    Panel5: TPanel;
    Panel6: TPanel;
    Button2: TButton;
    Button12: TButton;
    Edit1: TEdit;
    GroupBox4: TGroupBox;
    print2: TButton;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel7: TPanel;
    GroupBox5: TGroupBox;
    Image1: TImage;
    Memo1: TMemo;
    GroupBox6: TGroupBox;
    Panel1: TPanel;
    GroupBox2: TGroupBox;
    ComboBox6: TComboBox;
    setCompIMG: TGroupBox;
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
    OpenDialog1: TOpenDialog;
    FontDialog1: TFontDialog;
    waku: TPanel;
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure ListBox1Click(Sender: TObject);
    procedure Memo1Change(Sender: TObject);
    procedure ListBox1DblClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button12Click(Sender: TObject);
    procedure ComboBox1Click(Sender: TObject);
    procedure ComboBox6Change(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button10Click(Sender: TObject);
    procedure ComboBox2KeyPress(Sender: TObject; var Key: Char);
    procedure ComboBox2Change(Sender: TObject);
    procedure ComboBox3Change(Sender: TObject);
    procedure ComboBox5Change(Sender: TObject);
    procedure ComboBox4Change(Sender: TObject);
    procedure TrackBar1Change(Sender: TObject);
    procedure TrackBar2Change(Sender: TObject);
    procedure TrackBar4Change(Sender: TObject);
    procedure TrackBar3Change(Sender: TObject);
    procedure UpDown1Changing(Sender: TObject; var AllowChange: Boolean);
    procedure UpDown2Changing(Sender: TObject; var AllowChange: Boolean);
    procedure UpDown4Changing(Sender: TObject; var AllowChange: Boolean);
    procedure UpDown3Changing(Sender: TObject; var AllowChange: Boolean);
    procedure setCompIMGMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure setCompIMGMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure setCompIMGMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure wakuMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure wakuMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure wakuMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormCreate(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure print2Click(Sender: TObject);
 private
    { Private 宣言 }
    QRMemo1 : TMemo;
    savedir:string;
    crentDir,SearchDir:String;
    waku_move_sw:boolean;
    waku_sizeY_sw,waku_sizeX_sw:boolean;
    dwncount:integer;
    ptX,ptY:integer;
    count:integer;
    bmp_base,meisi_base:TBitmap;
  public
    { Public 宣言 }
    compset:TLabel;
    tempmemo:string;
    comp,qrcomp:TCompList;
    setprjdir,setdir:String;
    qrimg:array [0..30] of Timage;
    QRLabel:array [0..30] of TMemo;
    QRMemo:array [0..30] of TMemo;
    QRImg2:array [0..30] of Timage;

    imgtext:array[0..15] of TMemo;
    img2:array[0..15] of TImage;
    Edit14:Tedit;
    loadprj:boolean;
    nmlsize_W,nmlsize_H:integer;
    prtimg:TImage;
    imgset:integer;
    setwidth,setheight:integer;
    //function printPIC(pagenum:integer;filename:string):boolean;
    function resetprot:boolean;
  end;

var
  Form1: TForm1;

implementation

uses Unit2;

{$R *.lfm}

function TCompList.Get(Index: Integer): TControl;
begin
  Result :=  TControl( inherited Get(Index) );
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
    if FindFirstUTF8(SearchDir + '*.*',faAnyFile,Rec) { *Converted from FindFirst* } = 0 then
    try
      repeat
         if ((Rec.Attr and faDirectory > 0)) and
               (Rec.Name <> '.') and (Rec.Name <> '..') then
           begin
             //見つかったフォルダを追加
             if (ExtractFIleExt(Rec.Name) = '.Meisi') or (ExtractFIleExt(Rec.Name) = '.Label') then begin
               form1.ListBox1.Items.Add(Rec.Name);
             end;
           end;
       until (FindNextUTF8(Rec) { *Converted from FindNext* } <> 0);
       Result :=true;
    finally
      FindCloseUTF8(Rec); { *Converted from FindClose* }
    end;
  end;
end;

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
        //showmessage(st.Text);
      end else begin
        //s2 := s2 + ';';
        while i2 >= 1 do begin
          i2 := ansipos(';',s2);
          //showmessage(s2);
          st.Text:= s2;
          for i3 := i4 to i2 -1 do begin
            s3 := s3 + s2[i3];
          end;
          //showmessage(s2);
          s2[i2] := chr(13);

          i4 := i2 -1;
          //showmessage('aaa' + st.Text);
          st.Add(s3);

          s3 := '';

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
    top := tp;
    Left := lf ;
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
  s1,s2,s3,s4:string;
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
      s1 := (form1.ComboBox2.Text);
      s2 := (form1.ComboBox3.Text);
      s3 := (form1.ComboBox4.Text);
      s4 := (form1.ComboBox5.Text);
      //showmessage(s);
      changcombobox;
      with form1 do begin
        setMoveCompSet(
          strtoint(s1),
          strtoint(s2),
          strtoint(s3),
          strtoint(s4)
        );
        form1.TrackBar1.Position := strtoint(s1);
        form1.TrackBar2.Position := strtoint(s2);
        form1.TrackBar3.Position := strtoint(s3);
        form1.TrackBar4.Position := strtoint(s4);
    end;
  end;
end;





function create_memo(savefile:string;i:integer;memo,m:TLabel;sw:boolean):boolean;
var
  s:string;
  t:TfontStyles;
  i1:integer;
  st:TStringList;
begin
  with form1 do begin
    {for i1 := 0 to memo.Lines.Count -1 do begin
      memo.Lines[i1] := memo.Lines[i1] + ' ';
    end;}
    m.Caption := memo.Caption;
    m.Font := memo.Font;
    m.WordWrap:= true;
    m.AutoSize := false;
    //showmessage(m.Lines.text);
    if sw then begin
      st := TStringList.Create;
      st.Text:= memo.Caption;
      st.SaveToFile( {ExtractFileName}utf8toansi( savefile) );
      st.Free;
    end;
    with comp.Items[i] do begin
      Hint := savefile;
      m.top := form1.UpDown1.Position;
      m.Left := form1.UpDown2.Position;
      m.Height := form1.UpDown3.Position;
      m.Width := form1.UpDown4.Position;
      m.Visible := true;
      m.Parent := Parent;
      //m.ReadOnly:= true;
      //m.BorderStyle:= bsnone;
      //m.onChange := Form1.Memo1Change;
    end;
    try
      comp.Items[i].free;
    except end;
    comp.Items[i] := m;
    comp.Items[i].Tag := 2;
    //t := m.Font.Style;
    //showmessage(t);
    if m.Font.Style = [fsBold] then begin
     // s := styletostr();//'fsBold';
    end;
    if m.Font.Style = [fsItalic] then begin
      s :=  s + ';fsItalic';
    end;

    if m.Font.Style = [fsUnderline] then begin
      s := s + ';fsUnderline';
    end;
    if m.Font.Style = [fsStrikeOut] then begin
      s := s + ';fsStrikeOut';
    end;
    comp.Items[i].hint := form1.setdir + ExtractFileName(savefile) + ';' + m.Font.Name + ';' + inttostr(m.Font.Size) + ';' + inttostr(m.Font.Color) + ';' + s;
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

    end else begin
      B := TBitmap.Create;
      J :=TJpegImage.Create;
      J.LoadFromFile(savefile);
      //J.SaveToFile( savefile );
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
    if cmp = TLabel.Create(form1) then
      Name := 'm' + inttostr(i);
    Hint := '';
    Tag := i;
    Enabled := true;
    Visible:= true;
  end;
  form1.comp.Add(cmp);
end;

function create_qrcomp1(bmp:Tbitmap;cmp:TMemo;p:TControl;i,tp,lf,dt,ht:integer):boolean;
var
  Rect1:TRect;
begin
  with bmp.Canvas do begin;
    with Rect1 do begin
      begin//ここでコピー先の位置を決める
        Top:=tp;Left:=lf;
        Right:=dt;Bottom:=ht;
      end;
      font := cmp.Font;
      pen.Color := cmp.Font.Color;

      //TextRect(Rect1,lf,tp,'aaaaaa');
      Rectangle(Rect1);
      TextRect(Rect1,lf,tp,cmp.Lines.Text);
         // stretchDraw(Rect1,);
    end;
  end;
end;

function create_qrcomp2(bmp:Tbitmap;cmp:TImage;p:TControl;i,tp,lf,dt,ht:integer):boolean;
var
  Rect1:TRect;
begin
  with bmp.Canvas do begin;
    with Rect1 do begin
      begin//ここでコピー先の位置を決める
        Top:=tp;Left:=lf;
        Right:=dt;Bottom:=ht;
      end;
      Rectangle(Rect1);
      stretchDraw(Rect1,cmp.Picture.Bitmap);
    end;
  end;

end;

function select_comp(s,dir:string;tp,lf,ht,dt:integer):boolean;
begin
  if s = '写真' then begin
    create_comp(TImage.Create(form1),form1.MeisiForm,1,tp,lf,dt,ht);
    create_pic(dir + inttostr(form1.comp.count-1),form1.comp.Count -1,TImage.Create(form1),true);
  end else if s = 'メモ' then begin
   form1.compset := TLabel.Create(form1);
   form1.Memo1.Lines.Clear;
   //form1.compset.ReadOnly:= true;
   //form1.compset.BorderStyle:= bsnone;
   form1.compset.AutoSize:= false;
   form1.compset.WordWrap:= true;
   form1.compset.Caption:= form1.Memo1.Text;
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
  i,i1,i2,i3,i4,i5:integer;
  SL:TStringList;
  cmpname:string;
  M:Tlabel;
  s1,s2,s3:string;
  st,st2:TStringList;
  img:TImage;
  J:TJPegImage;
  B:TBitmap;
begin
  SL := TStringList.Create;
  SL.Clear;
  SL.LoadFromFile(utf8toansi(s));
  //showmessage(sl.Text);
  sl.Text:= ansitoutf8(sl.Text);
  M := TLabel.Create(form1);
  m.Parent := form1;
  m.visible := false;
  m.Caption:= '';
  st := TStringList.Create;
  st.Clear;
  //showmessage(sl.Text);

  B := TBitmap.Create;
  J :=TJpegImage.Create;
  try
    J.LoadFromFile(form1.setdir + 'haikei');
    B.Assign(J);
    form1.MeisiPIC.Picture.Assign(B);
  except
    B.Canvas.Create;
    B.Width := form1.MeisiPIc.Width;
    B.Height := form1.MeisiPIc.Height;
    B.Canvas.Brush.Color:= clWhite;
    B.Canvas.Rectangle(0,0,B.Width,B.Height);
    form1.MeisiPIC.Picture.Assign(B);
    J.Assign( form1.MeisiPIC.Picture.Bitmap );
    J.SaveToFile(form1.setdir + 'haikei');
  end;
  B.Free;
  J.Free;

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
      //showmessage(s2);
      if 0 = ansipos(';',s2) then begin
        st.Text := s2;
        //showmessage(st.Text);
      end else begin
        //s2 := s2 + ';';
        while i2 >= 1 do begin
          i2 := ansipos(';',s2);
          //showmessage(s2);
          st.Text:= s2;
          for i3 := i4 to i2 -1 do begin
            s3 := s3 + s2[i3];
          end;
          //showmessage(s2);
          s2[i2] := chr(13);

          i4 := i2 -1;
          //showmessage('aaa' + st.Text);
          st.Add(s3);

          s3 := '';

        end;
      end;
      //showmessage(st.Text + ' ' + s2);
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
      end;
      if cmpname = 'メモ' then begin
        if st.Count > 0 then begin
          try
            //if st[0] = null then
            //showmessage(ansitoutf8(st[0]));
            //showmessage(utf8toansi(st[0]));
            st2 := TStringLIst.Create;
            st2.LoadFromFile(utf8toansi(st[0]));
            m.Caption:= st2.Text;
            st2.Free;
          except end;
          m.Font.Name := st[1];
          m.Font.Size := strtoint(st[2]);
          m.Font.Color := strtoint(st[3]);
          if st.Count >= 5 then begin
            i5 := 1;
          end else begin
            i5 := 0;
          end;
          if st[3] = 'fsBold' then begin
            m.Font.Style := [fsBold];
            i5 := i5 + 1;
          end;
          if st[3 + i5] = 'fsItalic' then begin
            m.Font.Style := [fsItalic];
            i5 := i5 + 1;
          end;
          if st[3 + i5] = 'fsUnderline' then begin
            m.Font.Style := [fsUnderline];
            i5 := i5 + 1;
          end;
          if st[3 + i5] = 'fsStrikeOut' then begin
            m.Font.Style := [fsStrikeOut];
          end;
        end;
        //showmessage(hint);
        //showmessage(st.Text);
        create_memo(st[0],form1.comp.Count-1,M,TLabel.Create(form1),false);
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
  B:Tbitmap;
  J:TJPegImage;
begin
  SL := TStringList.Create;
  SL.Clear;
  i := 0;
  while i < form1.comp.Count do begin
    with form1.comp.Items[i] do begin
      SL.add(inttostr(tag));
      SL.add( {form1.savedir +} utf8toansi(hint));
      SL.add(inttostr(TOP));
      SL.add(inttostr(LEFT));
      SL.add(inttostr(Height));
      SL.add(inttostr(Width));
      inc(i);
    end;
  end;
  B := TBitmap.Create;
  J := TJpegImage.Create;
  B.Canvas.Create;
  B.Width := form1.MeisiPIc.Width;
  B.Height := form1.MeisiPIc.Height;
  B.Canvas.Brush.Color:= clWhite;
  B.Canvas.Rectangle(0,0,B.Width,B.Height);
  form1.MeisiPIC.Picture.Assign(B);
  J.Assign( form1.MeisiPIC.Picture.Bitmap );
  J.SaveToFile(form1.setdir + 'haikei');
  B.Free;
  J.Free;

  SL.SaveToFile((s));
  SL.Free;
end;

function output(tp,lf:integer):boolean;
var
  i,i1:integer;
  function outputSet(i,tp,lf:integer):boolean;
  var
    qrm:TMemo;
    qri:TImage;
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
          qrm := TMemo.Create(form1);
          qrm.parent := form1;
          qrm.Visible := false;
          qrm.Name := '_memo'+inttostr(form1.count);
          inc(form1.count);
          qrm.Lines.LoadFromFile(st[0]);
          {for i := 0 to qrm.Lines.Count -1 do begin
            qrm.Lines[i1] := qrm.Lines[i1];// + ' ';
          end;}
          qrm.Font.Name := st[1];
          qrm.WordWrap := true;
          //qrm.Transparent := true;
          qrm.Font.Size := strtoint(st[2]);
          qrm.Font.color := strtoint(st[3]);
         // qrm.AutoStretch := true;
          //create_qrcomp1(form1.bmp_base,qrm,form2.Image1,tag,tp + top,lf + left,height,width);
        except end;
      end else if tag = 1 then begin
        try
          qri := TImage.Create(form1);
          qri.Name := '_image'+ inttostr(form1.count);
          inc(form1.count);
          B := TBitmap.Create;
          J :=TJpegImage.Create;
          J.LoadFromFile(st[0]);
          //showmessage(st[0]);
          B.Assign(J);
          qri.Picture.Assign(B);
          qri.Stretch := true;
          create_qrcomp2(form1.bmp_base,qri,form2.Image1,tag,tp + top,lf + left,width,height);
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
    output(i1+ 247,i2+50);
  end;
end;

function Priset1:boolean;
var
  st:TStringList;
  searchdir:string;
begin
  if form1.ListBox1.Items.Count = 0 then begin
    //CreateDirUTF8(ansitoutf8(ExtractFilePath( Paramstr(0) )) + 'サンプル.Label'); { *Converted from CreateDir* }
    {st := TStringList.Create;
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
    //showmessage(ansitoutf8(ExtractFilePath( Paramstr(0) )) + '名刺サンプル' + '\Meisi.mpr');
    st.SaveToFile((ExtractFilePath( Paramstr(0)) + utf8toansi('サンプル.Label' + '\Meisi.mpr')));
    st.Free;
    {form1.setprjdir := ExtractFilePath( Paramstr(0) ) + '名刺サンプル' + '\';
    loadseting(ExtractFilePath( Paramstr(0) ) + '名刺サンプル' + '\Meisi.mpr');}
    SearchDir := ansitoutf8(ExtractFilePath( Paramstr(0) ));
    EnumFileFromDir(SearchDir);
    //form1.ListBox1.ItemIndex := 0;
    //Form1.ListBox1DblClick(Form1.ListBox1);
  end;
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
  MeisiPIC.Picture.SaveToFile(form1.setdir + 'haikei');
  B.Free;
  J.Free;
end;

procedure TForm1.Button12Click(Sender: TObject);
var
  s:string;
begin
  s := ( form1.setprjdir + 'Meisi.mpr');
  saveSeting(utf8toansi(s));
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  s1:string;
begin
  resetcomp;
  form1.MeisiForm.Visible := true;
  if -1 = form1.ListBox1.Items.IndexOf(edit1.Text) then begin
    s1 := ansitoutf8(ExtractFilePath( Paramstr(0) )) + edit1.Text + '.Label';
    CreateDirUTF8((s1));{ *Converted from CreateDir* }
    Form1.MeisiForm.Width:= 266;
    Form1.MeisiForm.Height:=142;
    setMeisiSize;
    form1.setprjdir := (s1 + '\');
    form1.setdir := ExtractFileName( s1 ) + '\';
    SearchDir := ansitoutf8(ExtractFilePath( Paramstr(0) ));
    listbox1.Items.Clear;
    EnumFileFromDir(SearchDir);
    form1.comp.Free;
    form1.comp := TcompList.Create;
    form1.comp.Clear;
    form1.qrcomp.Free;
    form1.qrcomp := TcompList.Create;
    form1.qrcomp.Clear;
    saveseting(utf8toansi(form1.setprjdir + 'Meisi.mpr'))
  end;
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
  SetCurrentDirUTF8(ExtractFilePath( Paramstr(0) )); { *Converted from SetCurrentDir* }
end;

procedure TForm1.Button7Click(Sender: TObject);
var
  l:TLabel;
begin
    savedir := form1.setprjdir;
  if 0 < ansipos('メモ',combobox6.Text) then begin
    try
      l := TLabel.Create(form1);
      l.Visible:= false;
      l.WordWrap:=true;
      l.AutoSize:=false;
      l.Caption:= memo1.Text;
      l.Font := memo1.Font;
      form1.Label5 := l;
      form1.Label5.Visible:= true;
      create_memo( form1.setprjdir + inttostr(combobox6.ItemIndex),combobox6.ItemIndex,l,TLabel.Create(form1),true);
      l.Free;
    except end;
  end else if 0 < ansipos('写真',combobox6.Text) then begin
    try
      create_PIC( form1.setprjdir + inttostr(combobox6.ItemIndex),combobox6.ItemIndex,Image1,false);
    except end;
  end;
end;

procedure TForm1.Button8Click(Sender: TObject);
begin
  if not fontdialog1.Execute then
    exit;
  memo1.Font := fontdialog1.Font;
end;

function print_meisi(size:real):TBitmap;
var
  i,i1,i2,x,y,w,h:integer;
  s:string;
  st,st2:TStringList;
  b,b1:Tbitmap;
  J:TJpegImage;
  Rect,Rect1:Trect;

  function set_editcomp(i:integer;cmp:Tcontrol):TRect;
  var
    c:Tcontrol;
  begin
    with form1.comp.Items[i] do begin
      c := form1.comp.Items[i];
      cmp.Width := c.Width;
      cmp.Height := c.Height;
      cmp.Tag := c.Tag;
      cmp.Hint := c.Hint;
      set_editcomp.Top := Top;
      set_editcomp.left := left;
      set_editcomp.Bottom := top + Height;
      set_editcomp.Right := left + Width;
    end;
  end;
begin

  B := TBitmap.Create;
  J := TJpegImage.Create;
  st := TStringList.Create;
  st.Clear;
  st2 := TStringList.Create;
  st2.Clear;
  form1.meisi_base:= TBitmap.Create;
  rect.Top := 0;
  rect.Left := 0;
  rect.Right := trunc(form1.MeisiPic.Width * (size));
  rect.Bottom := trunc(form1.MeisiPic.Height * (size));

  form1.meisi_base := form1.MeisiPic.Picture.Bitmap;

  form1.meisi_base.Width := rect.Right;
  form1.meisi_base.Height := rect.Bottom;

  //form1.meisi_base.Canvas.StretchDraw(rect, form1.MeisiPIc.Picture.Bitmap);


  for i := 0 to form1.comp.count - 1 do begin

    y := trunc(form1.comp.Items[i].Top * size);
    x := trunc(form1.comp.Items[i].Left * size);
    h := trunc(form1.comp.Items[i].Height * size);
    w := trunc(form1.comp.Items[i].Width * size);

    //Y := y *2;
   // x := x * 2;
    //h := h * 2;
    //w := w * 2;

    setfilename(st,form1.comp.Items[i]);
    Rect1 := set_editcomp(i,form1.comp.Items[i]);

    rect := rect1;

    Rect1.Top := trunc(Rect1.Top * size);
    Rect1.Left := trunc(Rect1.Left * size);
    rect1.Right := trunc(rect1.Right* size);
    Rect1.Bottom := trunc(Rect1.Bottom * size);

    Rect.Top := trunc(Rect1.Top * size-0.5);
    Rect.Left := trunc(Rect1.Left * size-0.5);
    rect.Right := trunc(rect1.Right* size-0.5);
    Rect.Bottom := trunc(Rect1.Bottom * size-0.5);

    SetCurrentDirUTF8(ansitoutf8(ExtractFilePath( Paramstr(0) ))); { *Converted from SetCurrentDir* }


    if form1.comp.Items[i].Tag = 2 then begin
      with form1.meisi_base.Canvas do begin
        st2.LoadFromFile(st[0]);
        font.Name := st[1];
        font.Size := trunc(strtoint(st[2])*size);
        pen.Color := strtoint(st[3]);
        brush.Style := bsClear;
        i2 :=0;
        for I1 := 0 to st2.Count - 1 do begin
          TextRect(Rect1,x,y+ i2 ,st2[i1]);
          i2 := i2 + TextHeight(st2[i1]);
        end;
      end;
    end;
    if form1.comp.Items[i].Tag = 1 then begin
      j.LoadFromFile(form1.comp.Items[i].hint);
      b.Assign(j);
      B1 := TBitmap.Create;
      b1.Width := rect1.Right;
      b1.Height := rect1.Bottom;
      b1.Canvas.StretchDraw(rect1,b);


      //form1.meisi_base.Canvas.Rectangle(Rect1);
      form1.meisi_base.Canvas.StretchDraw(Rect1,b);
      b1.Free;
    end;
  end;
  print_meisi := form1.meisi_base;

end;


function view_meisi():boolean;
var
  i,i1,i2,x,y,w,h:integer;
  s,set_name:string;
  st,st2:TStringList;
  b:Tbitmap;
  J:TJpegImage;
  Rect1:Trect;

  function set_editcomp(i:integer;cmp:Tcontrol):TRect;
  var
    c:Tcontrol;
  begin
    with form1.comp.Items[i] do begin
      c := form1.comp.Items[i];
      cmp.Width := c.Width;
      cmp.Height := c.Height;
      cmp.Tag := c.Tag;
      //showmessage(inttostr(cmp.Tag));
      cmp.Hint := c.Hint;
      set_editcomp.Top := Top;
      set_editcomp.left := left;
      set_editcomp.Bottom := top + Height;
      set_editcomp.Right := left + Width;
    end;
  end;
begin
  Form1.bmp_base := TBitmap.Create;
  Form1.bmp_base.Canvas.Brush.Color := clBlack;
  Form1.bmp_base.Width := form1.MeisiPIc.Width*4;
  Form1.bmp_base.Height := form1.MeisiPIc.Height*4;
  Form1.bmp_base.Canvas.Create;
  Form1.bmp_base.Canvas.Brush.Color := clwhite;
  Form1.bmp_base.Canvas.pen.Color := clBlack;

  B := TBitmap.Create;
  J := TJpegImage.Create;
  st := TStringList.Create;
  st.Clear;
  st2 := TStringList.Create;
  st2.Clear;
  form1.meisi_base:= TBitmap.Create;
  form1.meisi_base := form1.MeisiPIc.Picture.Bitmap;


  for i := 0 to form1.comp.count - 1 do begin

    y := form1.comp.Items[i].Top;
    x := form1.comp.Items[i].Left;
    h := form1.comp.Items[i].Height * 4;
    w := form1.comp.Items[i].Width * 4;
    //showmessage(st.Text);
    setfilename(st,form1.comp.Items[i]);
    Rect1 := set_editcomp(i,form1.comp.Items[i]);
    //st.Text:= utf8toansi(st.Text);
    //showmessage(st.Text);
    SetCurrentDirUTF8(utf8toansi(ExtractFilePath( Paramstr(0) ))); { *Converted from SetCurrentDir* }
    //showmessage(inttostr(form1.comp.Items[i].Tag));
    if form1.comp.Items[i].Tag = 2 then begin
      with form1.meisi_base.Canvas do begin
        set_name := {ansitoutf8(ExtractFilePath( Paramstr(0) )) +} (utf8toansi(st[0]));
        //showmessage(utf8toansi(set_name));
        //showmessage(ansitoutf8(set_name));
        //showmessage(ansitoutf8(ExtractFilePath( Paramstr(0) ) + (utf8toansi(st[0]))));
        //showmessage((ExtractFilePath( Paramstr(0) ) + utf8toansi(st[0])));
        //showmessage((ExtractFilePath( Paramstr(0) ) + utf8toansi(st[0])));


        st2.LoadFromFile(utf8toansi(set_name));
        //showmessage(st2.Text + st[0]);
        font.Name := st[1];
        font.Size := strtoint(st[2]);
        pen.Color := strtoint(st[3]);
        brush.Style := bsClear;
        i2 :=0;
        for I1 := 0 to st2.Count - 1 do begin
          TextRect(Rect1,x,y+ i2 ,st2[i1]);
          i2 := i2 + TextHeight(st2[i1]);
        end;
      end;
    end else if form1.comp.Items[i].Tag = 1 then begin
      j.LoadFromFile(utf8toansi(form1.comp.Items[i].hint));
      b.Assign(j);
      form1.meisi_base.Canvas.Rectangle(Rect1);
      form1.meisi_base.Canvas.StretchDraw(Rect1,b);
    end;
  end;
  form1.bmp_base.Canvas.Draw(0,0,form1.meisi_base);
end;

procedure TForm1.Button9Click(Sender: TObject);
var
  i,i1,i2,i3:integer;
  B:TBitMap;
  Rect1:Trect;
  h,w,h_count,w_count:integer;
begin
  i := 0; i1 := -206; i3 :=0;
  //resetprot;
  form1.count := 0;
  Form1.bmp_base := TBitmap.Create;
  Form1.bmp_base.Canvas.Brush.Color := clwhite;
  Form1.bmp_base.Width := 7480;
  Form1.bmp_base.Height := 10800;
  form2.Image1.Height := form1.bmp_base.Height;
  form2.Image1.Width := form1.bmp_base.Width;
  Form1.bmp_base.Canvas.Create;
  Form1.bmp_base.Canvas.Pen.Color := clBlack;
  //Form1.bmp_base.Canvas.Pen.Color := clBlack;
  //Form1.bmp_base.Canvas.Ellipse(0,0,100,100);
  //Form1.bmp_base.Canvas.; /
  B := TBitmap.Create;
  B := print_meisi(2);
  h_count := 244;//39*10;//47;39;32
  w_count := 275;//39*10;//57;39
  w := b.Width *4;
  h := b.Height*4;

  w := trunc(w *1.25);//1.21
  h := trunc(h *1.25);//1.21

  rect1.Top := h_count; rect1.Left := W_count; Rect1.Right := w_count+w; Rect1.Bottom := H_count+h;
  for I1 := 0 to 1 do begin
    h_count := 250;//39*10;//47;
    rect1.Top := H_count;
    rect1.Bottom := H_count + h;
    for i := 0 to 4 do begin
      Form1.bmp_base.Canvas.StretchDraw(rect1,B);
      h_count := h_count + h;
      rect1.Top := h_count;
      rect1.Bottom := H_count + h -3;
    end;
    w_count := w_count+ w;
    rect1.Left := w_count;
    rect1.Right := w_count + w-10;
  end;
  form2.Image1.Picture.Graphic := Form1.bmp_base;
  try
    form2.Show;
    //B.Free;
  except

  end;
end;

procedure TForm1.ComboBox1Click(Sender: TObject);
begin
  select_comp(combobox1.Text,
              form1.setprjdir,
              strtoint(combobox2.Text),
              strtoint(combobox3.Text),
              strtoint(combobox4.Text),
              strtoint(combobox5.Text));

  form1.ComboBox6.ItemIndex := form1.ComboBox6.Items.Count -1;
  Form1.ComboBox6Change(Sender);
end;

procedure TForm1.ComboBox2Change(Sender: TObject);
begin
  changcombobox;
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

procedure TForm1.ComboBox3Change(Sender: TObject);
begin
  changcombobox;
end;

procedure TForm1.ComboBox4Change(Sender: TObject);
begin
  changcombobox;
end;

procedure TForm1.ComboBox5Change(Sender: TObject);
begin
  changcombobox;
end;

procedure TForm1.ComboBox6Change(Sender: TObject);
var
  J:TJPegImage;
  B:TBitmap;
  ST:TStringList;
begin
  if 0 < ansipos('写真',combobox6.Text) then begin
    try
      memo1.Visible := false;
      form1.Label5.Visible:= false;
      set_editcomp(combobox6.itemIndex,image1);
      B := TBitmap.Create;
      J :=TJpegImage.Create;
      ST := TStringList.Create;
        setfilename(st,Image1);
      if st.Count > 0 then begin
        try
          SetCurrentDirUTF8(ansitoutf8(ExtractFilePath( Paramstr(0) ))); { *Converted from SetCurrentDir* }
          showmessage(st.Text);
          J.LoadFromFile(st[0]);
          B.Assign(J);
        except end;

        image1.Picture.Assign(B);
        image2.Picture.Assign(B);
      end;
      b.Free;
      j.Free;
      image1.Stretch := true;
      image2.Stretch := true;
      image1.Visible := true;
      image2.Visible := true;

    except

    end;
  end else if 0 < ansipos('メモ',combobox6.Text) then begin
    try
      set_editcomp(combobox6.itemIndex,memo1);
      try
      image1.Visible := not true;
      image2.Visible := not true;
      except

      end;
      ST := TStringList.Create;

      setfilename(st,memo1);
      if st.Count > 0 then begin
        try
          //showmessage(st[0]);
          //showmessage(ansitoutf8(st[0]));
          //showmessage(utf8toansi(st[0]));
          //showmessage(utf8decode(st[0]));

          memo1.Lines.LoadFromFile((st[0]));
          //memo1.Text:= (memo1.Text);
        except end;
        memo1.Font.Name := st[1];
        //memo1.ReadOnly:= not true;
        //showmessage(st[0]+st[1]+st[2]);
        memo1.Font.Size := strtoint(st[2]);
      end;
      memo1.Visible := true;
      form1.Label5.Visible:= true;
      form1.Label5.Font := form1.Memo1.Font;
      form1.Label5.AutoSize:= false;
      form1.Label5.WordWrap:=true;
      form1.Label5.Caption:= form1.Memo1.Lines.Text;

    except

    end;
  end;
  st.Free;

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

procedure TForm1.ListBox1DblClick(Sender: TObject);
var
  s,s1,loadfile:string;
  i:integer;
begin
  if form1.ListBox1.ItemIndex = -1 then
    exit;
  resetcomp;
  form1.MeisiForm.Visible := true;
  loadfile := ansitoutf8(ExtractFilePath( Paramstr(0) )) + listbox1.Items[listbox1.itemindex] +'\Meisi.mpr';
   form1.setprjdir := ansitoutf8(ExtractFilePath( Paramstr(0) )) + listbox1.Items[listbox1.itemindex] + '\';
   s := form1.setprjdir;
     s1 := '';
     for i := 0 to length(s)-1 do begin
       s1 := s1 + s[i]
     end;
     //showmessage(s1);
    s := ExtractFileExt(s1);
   if s = '.Label' then begin
     Form1.MeisiForm.Width:= 266;
     Form1.MeisiForm.Height:=142;
   end else if s = '.Meisi' then begin
     Form1.MeisiForm.Width:= 347;
     Form1.MeisiForm.Height:=208;
   end;
   setMeisiSize;
   form1.setdir := {ExtractFilePath( Paramstr(0) ) +} listbox1.Items[listbox1.itemindex] + '\';
   loadSeting(loadfile);
   //view_meisi();
  //showmessage('aaa');
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

      create_memo( form1.setprjdir + inttostr(i),i,compset,TLabel.Create(form1),true);
    end;
  end;
end;

procedure TForm1.ComboBox1Change(Sender: TObject);
begin

end;

procedure TForm1.ListBox1Click(Sender: TObject);
begin

end;


function  print():boolean;
var
  i,i1,i2,x,y,w,h:integer;
  s,set_name:string;
  st,st2:TStringList;
  b:Tbitmap;
  J:TJpegImage;
  Rect1,rect2:Trect;

  function set_editcomp(i:integer;cmp:Tcontrol):TRect;
  var
    c:Tcontrol;
  begin
    with form1.comp.Items[i] do begin
      //showmessage(form1.comp.Items[i].Hint);
      //showmessage(utf8toansi(form1.comp.Items[i].Hint));
      //showmessage(ansitoutf8(form1.comp.Items[i].Hint));

      c := form1.comp.Items[i];
      cmp.Width := c.Width;
      cmp.Height := c.Height;
      cmp.Tag := c.Tag;
      //showmessage(inttostr(cmp.Tag));
      cmp.Hint := (c.Hint);
      set_editcomp.Top := Top * 4;
      set_editcomp.left := left * 4;
      set_editcomp.Bottom := (top * 4) + (Height * 4);
      set_editcomp.Right := (left * 4) + (Width * 4);
    end;
  end;
begin
  Form1.bmp_base := TBitmap.Create;
  Form1.bmp_base.Canvas.Brush.Color := clBlack;
  Form1.bmp_base.Width := form1.MeisiPIc.Width*16;
  Form1.bmp_base.Height := form1.MeisiPIc.Height*16;
  Form1.bmp_base.Canvas.Create;
  Form1.bmp_base.Canvas.Brush.Color:= clWhite;
  Form1.bmp_base.Canvas.Rectangle(0,0,Form1.bmp_base.Width,Form1.bmp_base.Height);
  Form1.bmp_base.Canvas.Brush.Color := clwhite;
  Form1.bmp_base.Canvas.pen.Color := clBlack;

  B := TBitmap.Create;
  J := TJpegImage.Create;
  st := TStringList.Create;
  st.Clear;
  st2 := TStringList.Create;
  st2.Clear;
  form1.meisi_base:= TBitmap.Create;
  form1.meisi_base := form1.MeisiPIc.Picture.Bitmap;


  for i := 0 to form1.comp.count - 1 do begin

    y := form1.comp.Items[i].Top;
    x := form1.comp.Items[i].Left;
    h := form1.comp.Items[i].Height;
    w := form1.comp.Items[i].Width;
    //showmessage(st.Text);
    setfilename(st,form1.comp.Items[i]);
    Rect1 := set_editcomp(i,form1.comp.Items[i]);
    rect2 := rect1;
    rect2.Top:= rect2.Top * 4;
    rect2.Left:= rect2.Left * 4;
    rect2.Right:= rect2.Right * 4;
    rect2.Bottom:= rect2.Bottom * 4;

    //st.Text:= utf8toansi(st.Text);
    //showmessage(st.Text);
    SetCurrentDirUTF8(utf8toansi(ExtractFilePath( Paramstr(0) ))); { *Converted from SetCurrentDir* }
    //showmessage(inttostr(form1.comp.Items[i].Tag));
    if form1.comp.Items[i].Tag = 2 then begin
      with Form1.bmp_base.Canvas do begin
       //showmessage(st.Text);
       set_name :=  (utf8toansi(st[0]));
       //showmessage(utf8toansi(set_name));
        st2.LoadFromFile(utf8toansi(set_name));

        font.Name := st[1];
        font.Size := strtoint(st[2]) * 16;
        pen.Color := strtoint(st[3]);
        brush.Style := bsClear;
        i2 :=0;
        for I1 := 0 to st2.Count - 1 do begin
          TextRect(Rect2,x*16,y*16+ i2 ,st2[i1]);
          i2 := i2 + TextHeight(st2[i1]);
        end;
      end;
    end else if form1.comp.Items[i].Tag = 1 then begin
      j.LoadFromFile((form1.comp.Items[i].hint));
      b.Assign(j);
      form1.meisi_base.Canvas.Rectangle(Rect1);
      form1.meisi_base.Canvas.StretchDraw(Rect1,b);
      Form1.bmp_base.Canvas.StretchDraw(rect2,b);
    end;
  end;
  //form1.bmp_base.Canvas.Draw(0,0,form1.meisi_base);
  form2.Image1.Width:= form1.bmp_base.Width;
  form2.Image1.Height:=form1.bmp_base.Height;
  form2.Image1.Picture.Graphic := Form1.bmp_base;
end;

function pross(set_name,set_name2:string):boolean;
var
  sd,prss,sv: TProcess;
  ps:String;
begin
  sd := TProcess.Create(nil);
  sv := TProcess.Create(nil);
   { prss := TProcess.Create(nil);
    prss.CommandLine := 'sh -c "cat ' + set_name + ' > ' +
    extractfilepath(Paramstr(0))
    + set_name2 + '"';
    prss.Options := [poWaitOnExit, poUsePipes, poStderrToOutPut];
   }

    sd.CommandLine := 'sudo';
    sd.Execute;
    sd.Options := [poWaitOnExit, poUsePipes];
    sd.CommandLine := set_name + ' ' + extractfilepath(Paramstr(0))  +set_name2;
    //prss.Execute;
    sd.Execute;

  {
    ps := form1.password;

    sv.Executable:= '/bin/sh';
    sv.Parameters.Add('-c');
    sv.Parameters.Add('echo ' +ps+ ' | sudo -S cp -f ' + ExtractFilePath(Paramstr(0)) + set_name2 + ' ' + set_name);
    sv.Execute;
  }

  sd.Free;
  prss.Free;
  sv.Free;
end;



procedure TForm1.Button1Click(Sender: TObject);
var
  Server     : Variant;
  Desktop    : Variant;
  LoadParams : Variant;
  Document   : Variant;
  TextCursor : Variant;
  set_s1 :TStringList;
  url,s,s1 :string;
  i:integer;
  J:TJPegImage;
  B:TBitmap;
  function setname(st:TStringList;s:string):boolean;
  var
    s2,s3:String;
    i2,i3,i4:integer;
  begin
    st.Clear;
    s2 := s;
    i2 := 1;
    i4 := 0;
    s3 := '';
    if 0 = ansipos('\',s2) then begin
        st.Text := s2;
        //showmessage(st.Text);
      end else begin
        //s2 := s2 + ';';
        while i2 >= 1 do begin
          i2 := ansipos('\',s2);
          //showmessage(s2);
          st.Text:= s2;
          for i3 := i4 to i2 -1 do begin
            s3 := s3 + s2[i3];
          end;
          //showmessage(s2);
          s2[i2] := '/';

          i4 := i2 -1;
          //showmessage('aaa' + st.Text);
          st.Add(s3);

          s3 := '';

        end;
      end;
  end;
const
  ServerName = 'com.sun.star.ServiceManager';
begin
  print();
  //showmessage('aaa');
  try
    try
      B := TBitmap.Create;
      J :=TJpegImage.Create;
      B := form2.Image1.Picture.Bitmap;
      J.Assign(B);
      J.SaveToFile(ansitoutf8(ExtractFilePath( Paramstr(0) ) + 'temp.jpg'));

    except
      showmessage(ansitoutf8(ExtractFilePath( Paramstr(0) ) + 'temp.jpg'));
    end;
  finally
    B.Free;
    J.Free;
  end;
  try
  set_s1 := TStringlIST.Create;

  //setname(set_s1,url);
  showmessage('OpenOfficeの設定で、マクロを有効にしてください' + char(13) +
  '印刷時にオープンオフィスのマクロを使います');
  s := form1.setprjdir;
  s1 := '';
  for i := 0 to length(s)-1 do begin
    s1 := s1 + s[i]
  end;
  //showmessage(s1);
 s := ExtractFileExt(s1);
   if s = '.Label' then begin
     url := ansitoutf8(ExtractFilePath( Paramstr(0) ) + 'LabelPrint.ods');
   end else if s = '.Meisi' then begin
     url := ansitoutf8(ExtractFilePath( Paramstr(0) ) + 'MeisiPrint.ods');
   end;
  OpenDocument(url);
  //ShellExecute(Handle, 'OPEN', pchar(url), '', '', SW_SHOW);
  except

    showmessage(url);
  end;
  {if Assigned(InitProc) then
    TProcedure(InitProc);

  try
    Server := CreateOleObject(ServerName);
  except
    WriteLn('Unable to start OO.');
    Exit;
  end;

  Desktop := Server.CreateInstance('com.sun.star.frame.Desktop');

  LoadParams := VarArrayCreate([0, -1], varVariant);

  Document := Desktop.LoadComponentFromURL(set_s1.Text, '_blank', 0, LoadParams);}
end;

procedure TForm1.Button3Click(Sender: TObject);
var
  s1:string;
begin
  resetcomp;
  form1.MeisiForm.Visible := true;
  if -1 = form1.ListBox1.Items.IndexOf(edit1.Text) then begin
    s1 := ansitoutf8(ExtractFilePath( Paramstr(0) )) + edit1.Text + '.Meisi';
    CreateDirUTF8((s1));{ *Converted from CreateDir* }
    Form1.MeisiForm.Width:= 347;
    Form1.MeisiForm.Height:=208;
    setMeisiSize;
    form1.setprjdir := (s1 + '\');
    form1.setdir := ExtractFileName( s1 ) + '\';
    SearchDir := ansitoutf8(ExtractFilePath( Paramstr(0) ));
    listbox1.Items.Clear;
    EnumFileFromDir(SearchDir);
    form1.comp.Free;
    form1.comp := TcompList.Create;
    form1.comp.Clear;
    form1.qrcomp.Free;
    form1.qrcomp := TcompList.Create;
    form1.qrcomp.Clear;
    saveseting(utf8toansi(form1.setprjdir + 'Meisi.mpr'))
  end;
end;

procedure TForm1.print2Click(Sender: TObject);
begin
  print();
  form2.Show;
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




procedure TForm1.setCompIMGMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  //if ( Y > 12 ) and ( X > 4 ) then begin
    form1.setCompIMG.ShowHint := true;
    if ( X > form1.setcompimg.width -15 ) and ( Y > form1.setcompimg.Height -25 ) then begin
      waku_sizeY_sw := true;
      waku_sizeX_sw := true;
    end else if X > form1.setcompimg.width -15 then begin
      waku_sizeY_sw := true;
    end else if Y > form1.setcompimg.Height -25 then begin
      waku_sizeX_sw := true;
    end;
    {waku_move_sw := true;
    ptY := Y;
    ptX := X;}
  //end
end;

procedure TForm1.setCompIMGMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
var
  setX,setY:integer;
begin
  if waku_sizeY_sw then begin
    form1.setCompIMG.Hint := 'SizeX:' + inttostr(form1.setCompIMG.Width) + ' SizeY:' + inttostr(form1.setCompIMG.Height);
    if form1.setCompIMG.Width > 20 then begin
      with form1.setCompIMG do begin
        setX :=  X;
        width := setX
      end;
      with form1.waku do begin
        setX :=  X -10;
        width := setX
      end;
      form1.TrackBar4.Position := setX;
      form1.ComboBox5.Text := inttostr(setX);
      form1.UpDown4.Position := setX;
      if form1.setCompIMG.Width < 20 then begin
        form1.setCompIMG.Width := 30;
        form1.waku.Width:= 20;
        form1.TrackBar4.Position := 30;
        form1.ComboBox5.Text := inttostr(30);
        form1.UpDown4.Position := 30
      end;
    end else begin
     form1.setCompIMG.Width := 30;
     form1.waku.Width:= 20;
     form1.TrackBar4.Position := 30;
     form1.ComboBox5.Text := inttostr(30);
     form1.UpDown4.Position := 30
    end;
  end;
  if waku_sizeX_sw then begin
    if form1.setCompIMG.Height > 20 then begin
      with form1.setCompIMG do begin
        setY :=  Y;
        Height := setY
      end;
      with form1.waku do begin
        setY := Y-10;
        Height := setY
      end;
      form1.TrackBar3.Position := setY;
      form1.ComboBox4.Text := inttostr(setY);
      form1.UpDown3.Position := setY;
      if form1.setCompIMG.Height < 20 then begin
        form1.setCompIMG.Height := 30;
        form1.waku.Height:= 20;
        form1.TrackBar3.Position := 30;
        form1.ComboBox4.Text := inttostr(30);
        form1.UpDown3.Position := 30
      end;
    end else begin
     form1.setCompIMG.Height := 30;
     form1.waku.Height:= 20;
     form1.TrackBar3.Position := 30;
     form1.ComboBox4.Text := inttostr(30);
     form1.UpDown3.Position := 30
    end;
  end;
end;

procedure TForm1.setCompIMGMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  waku_sizeY_sw := not true;
  waku_sizeX_sw := not true;
  changtrackbar;
  form1.setCompIMG.ShowHint := not true;
end;

procedure TForm1.TrackBar1Change(Sender: TObject);
begin
  changtrackbar;
end;

procedure TForm1.TrackBar2Change(Sender: TObject);
begin
  changtrackbar;
end;

procedure TForm1.TrackBar3Change(Sender: TObject);
begin
  changtrackbar;
end;

procedure TForm1.TrackBar4Change(Sender: TObject);
begin
  changtrackbar;
end;

procedure TForm1.UpDown1Changing(Sender: TObject; var AllowChange: Boolean);
begin
  changupdown;
end;

procedure TForm1.UpDown2Changing(Sender: TObject; var AllowChange: Boolean);
begin
  changupdown;
end;

procedure TForm1.UpDown3Changing(Sender: TObject; var AllowChange: Boolean);
begin
  changupdown;
end;

procedure TForm1.UpDown4Changing(Sender: TObject; var AllowChange: Boolean);
begin
  changupdown;
end;

procedure TForm1.wakuMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  waku_move_sw := true;
  form1.waku.ShowHint := true;
  ptY := Y;
  ptX := X;
end;

procedure TForm1.wakuMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
var
  setx,sety:integer;
begin
  if waku_move_sw then begin
    form1.waku.Hint := 'X:' + inttostr(form1.waku.Top) + ' Y:' + inttostr(form1.waku.Left);
    with form1.setCompIMG do begin
      setY := top + Y - ptY ;//form1.SpinEdit1.Value;
      setX := left + x - ptX ;//form1.SpinEdit2.Value;
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

procedure TForm1.wakuMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  waku_move_sw := not true;
  form1.waku.ShowHint := not true;
  changtrackbar;
end;

end.
