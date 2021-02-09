unit main;

{$ifdef FPC}{$mode objfpc}{$h+}{$endif}
interface

uses
  msetypes,
  mseglob,
  mseguiglob,
  mseguiintf,
  mseapplication,
  msestat,
  msemenus,
  msegui,
  msegraphics,
  msegraphutils,
  mseevent,
  mseclasses,
  msewidgets,
  mseforms,
  uos_mseaudio,
  uos_msesigaudio,
  msestrings,
  msesignal,
  msesignoise,
  msechartedit,
  msedataedits,
  mseedit,
  mseificomp,
  mseificompglob,
  mseifiglob,
  msesiggui,
  msestatfile,
  msesigfft,
  msesigfftgui,
  msegraphedits,
  msescrollbar,
  msedispwidgets,
  mserichstring,
  msesplitter,
  msesimplewidgets,
  msefilter,
  mseact,
  msestream,
  SysUtils,
  msebitmap,
  msedropdownlist,
  msefiledialogx;

type
  tmainfo = class(tmainform)
    cont: tsigcontroller;
    out: tsigoutaudio;
    noise: tsignoise;
    sta: tstatfile;
    tlayouter2: tlayouter;
    tsplitter1: tsplitter;
    fft: tsigscopefft;
    scope: tsigscope;
    tfacecomp1: tfacecomp;
    tframecomp1: tframecomp;
    tframecomp2: tframecomp;
    timagelist3: timagelist;
    tsplitter2: tsplitter;
    tsigoutaudio1: tsigoutaudio;
    tsigfilter1: tsigfilter;
    tsignoise1: tsignoise;
    tsigcontroller1: tsigcontroller;
    tenvelopeedit1: tenvelopeedit;
    tlabel1: tlabel;
    tlabel2: tlabel;
    tlabel3: tlabel;
    sampcountdi: tintegerdisp;
    tsigoutaudio2: tsigoutaudio;
    tsigcontroller2: tsigcontroller;
    tsigkeyboard1: tsigkeyboard;
    tsigslider3: tsigslider;
    averagecount: tintegerdisp;
    average: tbooleanedit;
    tsigslider1: tsigslider;
    sampcount: tslider;
    kinded: tenumtypeedit;
    tfilenameeditx1: tfilenameeditx;
    tgroupbox1: tgroupbox;
    viewnoise: tbooleaneditradio;
    viewfile: tbooleaneditradio;
    viewpiano: tbooleaneditradio;
    onoiseon: tbooleanedit;
    onpianoon: tbooleanedit;
    tsignoise2: tsignoise;
    bstart: TButton;
    tbutton2: TButton;
    tsignoise3: tsignoise;
    tsigoutaudio3: tsigoutaudio;
    tsigcontroller3: tsigcontroller;
    viewinput: tbooleaneditradio;
    oninputon: tbooleanedit;
    procedure onclosexe(const Sender: TObject);
    procedure samcountsetexe(const Sender: TObject; var avalue: realty; var accept: Boolean);
    procedure typinitexe(const Sender: tenumtypeedit);
    procedure kindsetexe(const Sender: TObject; var avalue: integer; var accept: Boolean);
    procedure averagesetev(const Sender: TObject; var avalue: Boolean; var accept: Boolean);
    procedure buffullev(const Sender: tsigsampler; const abuffer: samplerbufferty);
    procedure onnoiseview(const Sender: TObject; var avalue: Boolean; var accept: Boolean);
    procedure onpianoview(const Sender: TObject; var avalue: Boolean; var accept: Boolean);
    procedure oncreated(const Sender: TObject);
    procedure onfileactivate(const Sender: TObject; var avalue: Boolean; var accept: Boolean);
    procedure onnoiseactivate(const Sender: TObject; var avalue: Boolean; var accept: Boolean);
    procedure onpianoactivate(const Sender: TObject; var avalue: Boolean; var accept: Boolean);
    procedure onfileview(const Sender: TObject; var avalue: Boolean; var accept: Boolean);
    procedure onstart(const Sender: TObject);
    procedure onstop(const Sender: TObject);
    procedure oninputview(const Sender: TObject; var avalue: Boolean; var accept: Boolean);
    procedure oninputactivate(const Sender: TObject; var avalue: Boolean; var accept: Boolean);
  end;

var
  mainfo: tmainfo;
  hasinit: Boolean = False;

implementation

uses
  main_mfm;

procedure tmainfo.onclosexe(const Sender: TObject);
begin
  out.audio.active           := False;
  tsigoutaudio1.audio.active := False;
  tsigoutaudio2.audio.active := False;
  tsigoutaudio3.audio.active := False;
  uos_mseUnLoadLib();
end;

procedure tmainfo.samcountsetexe(const Sender: TObject; var avalue: realty; var accept: Boolean);
begin
  noise.samplecount := round(19 * avalue) + 1;
  sampcountdi.Value := noise.samplecount;
end;

procedure tmainfo.typinitexe(const Sender: tenumtypeedit);
begin
  Sender.typeinfopo := typeinfo(noisekindty);
end;

procedure tmainfo.kindsetexe(const Sender: TObject; var avalue: integer; var accept: Boolean);
begin
  noise.kind := noisekindty(avalue);
end;

procedure tmainfo.averagesetev(const Sender: TObject; var avalue: Boolean; var accept: Boolean);
begin
  if avalue then
    fft.sampler.options := fft.sampler.options + [sso_average]
  else
    fft.sampler.options := fft.sampler.options - [sso_average];
end;

procedure tmainfo.buffullev(const Sender: tsigsampler; const abuffer: samplerbufferty);
begin
  Sender.lockapplication();
  averagecount.Value := tsigsamplerfft(Sender).averagecount;
  Sender.unlockapplication();
end;

procedure tmainfo.onnoiseview(const Sender: TObject; var avalue: Boolean; var accept: Boolean);
begin
  if avalue then
  begin
    scope.sampler.controller       := cont;
    scope.sampler.inputs[0].Source := noise.output;
    fft.sampler.controller         := cont;
    fft.sampler.inputs[0].Source   := noise.output;
  end;
end;

procedure tmainfo.onpianoview(const Sender: TObject; var avalue: Boolean; var accept: Boolean);
begin
  if avalue then
  begin
    scope.sampler.controller       := tsigcontroller1;
    scope.sampler.inputs[0].Source := tsigfilter1.output;
    fft.sampler.controller         := tsigcontroller1;
    fft.sampler.inputs[0].Source   := tsigfilter1.output;
  end;
end;

procedure tmainfo.oncreated(const Sender: TObject);
var
  PA_FileName, SF_FileName, ordir: string;
  xx: float;
begin

  ordir := IncludeTrailingBackslash(ExtractFilePath(ParamStr(0)));

{$IFDEF Windows}
     {$if defined(cpu64)}
    PA_FileName := ordir + 'lib\Windows\64bit\LibPortaudio-64.dll';
    SF_FileName := ordir + 'lib\Windows\64bit\LibSndFile-64.dll';
     {$else}
    PA_FileName := ordir + 'lib\Windows\32bit\LibPortaudio-32.dll';
    SF_FileName := ordir + 'lib\Windows\32bit\LibSndFile-32.dll';
     {$endif}
 {$ENDIF}

     {$if defined(CPUAMD64) and defined(linux) }
  SF_FileName := ordir + 'lib/Linux/64bit/LibSndFile-64.so';
  PA_FileName := ordir + 'lib/Linux/64bit/LibPortaudio-64.so';   {$ENDIF}

   {$if defined(cpu86) and defined(linux)}
    PA_FileName := ordir + 'lib/Linux/32bit/LibPortaudio-32.so';
    SF_FileName := ordir + 'lib/Linux/32bit/LibSndFile-32.so';    {$ENDIF}

  {$if defined(linux) and defined(cpuaarch64)}
  PA_FileName := ordir + 'lib/Linux/aarch64_raspberrypi/libportaudio_aarch64.so';
  SF_FileName := ordir + 'lib/Linux/aarch64_raspberrypi/libsndfile_aarch64.so';
  {$ENDIF}

  {$if defined(linux) and defined(cpuarm)}
    PA_FileName := ordir + 'lib/Linux/arm_raspberrypi/libportaudio-arm.so';
    SF_FileName := ordir + ordir + 'lib/Linux/arm_raspberrypi/libsndfile-arm.so';   {$ENDIF}

 {$IFDEF freebsd}
    {$if defined(cpu64)}
    PA_FileName := ordir + 'lib/FreeBSD/64bit/libportaudio-64.so';
    SF_FileName := ordir + 'lib/FreeBSD/64bit/libsndfile-64.so';
    {$else}
    PA_FileName := ordir + 'lib/FreeBSD/32bit/libportaudio-32.so';
    SF_FileName := ordir + 'lib/FreeBSD/32bit/libsndfile-32.so';
    {$endif} {$ENDIF}

 {$IFDEF Darwin}
  {$IFDEF CPU32}
    opath := ordir;
    opath := copy(opath, 1, Pos('/UOS', opath) - 1);
    PA_FileName := opath + '/lib/Mac/32bit/LibPortaudio-32.dylib';
    SF_FileName := opath + '/lib/Mac/32bit/LibSndFile-32.dylib';
       {$ENDIF}
  
   {$IFDEF CPU64}
    opath := ordir;
    opath := copy(opath, 1, Pos('/UOS', opath) - 1);
    PA_FileName := opath + '/lib/Mac/64bit/LibPortaudio-64.dylib';
    SF_FileName := opath + '/lib/Mac/64bit/LibSndFile-64.dylib'; 
      {$ENDIF}  
 {$ENDIF}

  uos_mseLoadLib(PA_FileName, SF_FileName);

  cont.inputtype := 0;            // from synth/noise
  tsigcontroller1.inputtype := 0; // from synth/piano
  tsigcontroller2.inputtype := 1; // from file
  tsigcontroller3.inputtype := 2; // from input/mic

  if viewinput.Value then
  begin
    scope.sampler.controller       := tsigcontroller3;
    scope.sampler.inputs[0].Source := tsignoise3.output;
    fft.sampler.controller         := tsigcontroller3;
    fft.sampler.inputs[0].Source   := tsignoise3.output;
  end;

  if viewfile.Value then
  begin
    scope.sampler.controller       := tsigcontroller2;
    scope.sampler.inputs[0].Source := tsignoise2.output;
    fft.sampler.controller         := tsigcontroller2;
    fft.sampler.inputs[0].Source   := tsignoise2.output;
  end;

  if viewnoise.Value then
  begin
    scope.sampler.controller       := cont;
    scope.sampler.inputs[0].Source := noise.output;
    fft.sampler.controller         := cont;
    fft.sampler.inputs[0].Source   := noise.output;
  end;

  if viewpiano.Value then
  begin
    scope.sampler.controller       := tsigcontroller1;
    scope.sampler.inputs[0].Source := tsigfilter1.output;
    fft.sampler.controller         := tsigcontroller1;
    fft.sampler.inputs[0].Source   := tsigfilter1.output;
  end;

  hasinit := True;
end;

procedure tmainfo.onfileactivate(const Sender: TObject; var avalue: Boolean; var accept: Boolean);
begin
  if hasinit then
    if avalue then
    begin
      tsigcontroller2.SoundFilename := tfilenameeditx1.controller.filename;
      tsigoutaudio2.audio.active    := True;
    end
    else
      tsigoutaudio2.audio.active    := False;
end;

procedure tmainfo.onnoiseactivate(const Sender: TObject; var avalue: Boolean; var accept: Boolean);
begin
  if hasinit then
    if avalue then
      out.audio.active := True
    else
      out.audio.active := False;
end;

procedure tmainfo.onpianoactivate(const Sender: TObject; var avalue: Boolean; var accept: Boolean);
begin
  if avalue then
    tsigoutaudio1.audio.active := True
  else
    tsigoutaudio1.audio.active := False;
end;

procedure tmainfo.onfileview(const Sender: TObject; var avalue: Boolean; var accept: Boolean);
begin
  if avalue then
  begin
    scope.sampler.controller       := tsigcontroller2;
    scope.sampler.inputs[0].Source := tsignoise2.output;
    fft.sampler.controller         := tsigcontroller2;
    fft.sampler.inputs[0].Source   := tsignoise2.output;
  end;
end;

procedure tmainfo.onstart(const Sender: TObject);
begin
  if hasinit then
  begin
    tsigoutaudio2.audio.active    := False;
    tsigcontroller2.SoundFilename := tfilenameeditx1.controller.filename;
    tsigoutaudio2.audio.active    := True;
  end;
end;

procedure tmainfo.onstop(const Sender: TObject);
begin
  if hasinit then
    tsigoutaudio2.audio.active := False;
end;

procedure tmainfo.oninputview(const Sender: TObject; var avalue: Boolean; var accept: Boolean);
begin
  if avalue then
  begin
    scope.sampler.controller       := tsigcontroller3;
    scope.sampler.inputs[0].Source := tsignoise3.output;
    fft.sampler.controller         := tsigcontroller3;
    fft.sampler.inputs[0].Source   := tsignoise3.output;
  end;
end;

procedure tmainfo.oninputactivate(const Sender: TObject; var avalue: Boolean; var accept: Boolean);
begin
  if avalue then
    tsigoutaudio3.audio.active := True
  else
    tsigoutaudio3.audio.active := False;
end;

end.

