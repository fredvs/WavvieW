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
  msesignal,
  msestrings,
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
  msefiledialogx,
  Math,
  msefftw;

const
  versiontext = '1.2';

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
    tsigoutaudio1: tsigoutaudio;
    tsigfilter1: tsigfilter;
    tsignoise1: tsignoise;
    tsigcontroller1: tsigcontroller;
    tsigoutaudio2: tsigoutaudio;
    tsigcontroller2: tsigcontroller;
    averagecount: tintegerdisp;
    average: tbooleanedit;
    tsignoise2: tsignoise;
    tfacecomp2: tfacecomp;
    tfacecomp3: tfacecomp;
    tfacecomp4: tfacecomp;
    babout: TButton;
    tsignoise3: tsignoise;
    tsigoutaudio3: tsigoutaudio;
    tsigcontroller3: tsigcontroller;
    tsignoise4: tsignoise;
    tsigoutaudio4: tsigoutaudio;
    tsigcontroller4: tsigcontroller;
    oscion: tbooleanedit;
    spectrumon: tbooleanedit;
    tlayouter1: tlayouter;
    tgroupbox2: tgroupbox;
    bstop: TButton;
    bstart: TButton;
    tfilenameeditx1: tfilenameeditx;
    sliderfile: tslider;
    volfile: tintegeredit;
    oninputon: tbooleanedit;
    tgroupbox5: tgroupbox;
    slidermic: tslider;
    volmic: tintegeredit;
    onoiseon: tbooleanedit;
    tgroupbox3: tgroupbox;
    sampcount: tslider;
    tsigslider1: tsigslider;
    kinded: tenumtypeedit;
    sampcountdi: tintegerdisp;
    noiseamp: tintegerdisp;
    tgroupbox4: tgroupbox;
    wavetype: tenumtypeedit;
    sliderwave: tslider;
    freqwav: tintegeredit;
    sliderfreqwave: tslider;
    volwav: tintegeredit;
    harmonwave: tintegeredit;
    Oddwave: tbooleanedit;
    tgroupbox1: tgroupbox;
    viewnoise: tbooleaneditradio;
    viewfile: tbooleaneditradio;
    viewpiano: tbooleaneditradio;
    viewinput: tbooleaneditradio;
    viewwave: tbooleaneditradio;
    tsigslider3: tsigslider;
    onpianoon: tbooleanedit;
    tsigkeyboard1: tsigkeyboard;
    tenvelopeedit1: tenvelopeedit;
    tlabel2: tlabel;
    tlabel3: tlabel;
    tlabel4: tlabel;
    onwavon: tbooleanedit;
    scaleosci: tbooleanedit;
    tfacecomp5: tfacecomp;
    bquit: TButton;
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
    procedure onabout(const Sender: TObject);
    procedure oninit(const Sender: TObject);
    procedure onwaveactivate(const Sender: TObject; var avalue: Boolean; var accept: Boolean);
    procedure onvolwave(const Sender: TObject; var avalue: realty; var accept: Boolean);
    procedure onfreqwave(const Sender: TObject; var avalue: realty; var accept: Boolean);
    procedure onchangewave(const Sender: TObject);
    procedure onwaveview(const Sender: TObject; var avalue: Boolean; var accept: Boolean);
    procedure onfilevol(const Sender: TObject; var avalue: realty; var accept: Boolean);
    procedure onchangefile(const Sender: TObject);
    procedure onmicvol(const Sender: TObject; var avalue: realty; var accept: Boolean);
    procedure onchangemic(const Sender: TObject);
    procedure onsetampnoise(const Sender: TObject; var avalue: realty; var accept: Boolean);
    procedure onresizeform(const Sender: TObject);
    procedure onshowoscilloscope(const Sender: TObject; var avalue: Boolean; var accept: Boolean);
    procedure onshowspectrum(const Sender: TObject; var avalue: Boolean; var accept: Boolean);
    procedure onscale(const Sender: TObject; var avalue: Boolean; var accept: Boolean);
    procedure onquit(const Sender: TObject);
    procedure evonfft(const Sender: tsigsamplerfft; const abuffer: samplerbufferty);
    procedure evonshowhint(const Sender: TObject; var info: hintinfoty);
    procedure evonmouseclient(const Sender: twidget; var ainfo: mouseeventinfoty);
  end;

var
  mainfo: tmainfo;
  hasinit: Boolean = False;

implementation

uses
  about,
  main_mfm;

procedure tmainfo.onclosexe(const Sender: TObject);
begin
  out.audio.active           := False;
  tsigoutaudio1.audio.active := False;
  tsigoutaudio2.audio.active := False;
  tsigoutaudio3.audio.active := False;
  tsigoutaudio4.audio.active := False;
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
{
var
i, i2  : integer;
freq: double;
}
begin
  Sender.lockapplication();
 {
  //writeln(inttostr(length(abuffer)));
  //writeln(inttostr(length(abuffer[0])));
  //for i := 0 to length(abuffer[0]) -1
  for i := 0 to 1000  
  do if abuffer[0][i] > freq then
  begin
   abuffer[0][i] := freq;
  //  writeln(floattostr(abuffer[0][i]));
    i2 := i;
   end;
  
 // writeln('freq pos = ' + inttostr(i2));
 }
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
  ara, arb: msestringarty;
begin
  setlength(ara, 5);
  setlength(arb, 5);

  ara[0] := 'All sound files';
  ara[1] := 'wav';
  ara[2] := 'ogg';
  ara[3] := 'flac';
  ara[4] := 'All';

  arb[0] := '"*.wav" "*.ogg" "*.flac" "*.WAV" "*.OGG" "*.FLAC"';
  arb[1] := '"*.wav" "*.WAV"';
  arb[2] := '"*.ogg" "*.OGG"';
  arb[3] := '"*.flac" "*.FLAC"';
  arb[4] := '"*.*"';

  tfilenameeditx1.controller.filterlist.asarraya := ara;
  tfilenameeditx1.controller.filterlist.asarrayb := arb;
  tfilenameeditx1.controller.filter := '"*.wav" "*.ogg" "*.flac" "*.WAV" "*.OGG" "*.FLAC"';

  ordir := IncludeTrailingBackslash(ExtractFilePath(ParamStr(0)));

{$IFDEF Windows}
     {$if defined(cpu64)}
    PA_FileName := ordir + 'lib\Windows\64bit\LibPortaudio-64.dll';
    SF_FileName := ordir + 'lib\Windows\64bit\LibSndFile-64.dll';
    fftw_init(ordir + 'lib\Windows\64bit\');
    
     {$else}
    PA_FileName := ordir + 'lib\Windows\32bit\LibPortaudio-32.dll';
    SF_FileName := ordir + 'lib\Windows\32bit\LibSndFile-32.dll';
    fftw_init(ordir + 'lib\Windows\32bit\');
     {$endif}
 {$ENDIF}

     {$if defined(CPUAMD64) and defined(linux) }
  SF_FileName := ordir + 'lib/Linux/64bit/LibSndFile-64.so';
  PA_FileName := ordir + 'lib/Linux/64bit/LibPortaudio-64.so'; 
  fftw_init(ordir + 'lib/Linux/64bit/');
     {$ENDIF}

   {$if defined(cpu86) and defined(linux)}
    PA_FileName := ordir + 'lib/Linux/32bit/LibPortaudio-32.so';
    SF_FileName := ordir + 'lib/Linux/32bit/LibSndFile-32.so';   
    fftw_init(ordir + 'lib/Linux/32bit/');
     {$ENDIF}

  {$if defined(linux) and defined(cpuaarch64)}
  PA_FileName := ordir + 'lib/Linux/aarch64_raspberrypi/libportaudio_aarch64.so';
  SF_FileName := ordir + 'lib/Linux/aarch64_raspberrypi/libsndfile_aarch64.so';
   fftw_init(ordir + 'lib/Linux/aarch64_raspberrypi/');
  {$ENDIF}

  {$if defined(linux) and defined(cpuarm)}
    PA_FileName := ordir + 'lib/Linux/arm_raspberrypi/libportaudio-arm.so';
    SF_FileName := ordir + 'lib/Linux/arm_raspberrypi/libsndfile-arm.so'; 
    fftw_init(ordir + 'lib/Linux/arm_raspberrypi/'); 
    {$ENDIF}

 {$IFDEF freebsd}
    {$if defined(cpu64)}
    PA_FileName := ordir + 'lib/FreeBSD/64bit/libportaudio-64.so';
    SF_FileName := ordir + 'lib/FreeBSD/64bit/libsndfile-64.so';
    fftw_init(ordir + 'lib/FreeBSD/64bit/'); 
    {$else}
    PA_FileName := ordir + 'lib/FreeBSD/32bit/libportaudio-32.so';
    SF_FileName := ordir + 'lib/FreeBSD/32bit/libsndfile-32.so';
    fftw_init(ordir + 'lib/FreeBSD/32bit/'); 
    {$endif} {$ENDIF}

  uos_mseLoadLib(PA_FileName, SF_FileName);

  cont.inputtype := 0;            // from synth/noise
  tsigcontroller1.inputtype := 0; // from synth/piano
  tsigcontroller2.inputtype := 1; // from file
  tsigcontroller3.inputtype := 2; // from input/mic
  tsigcontroller4.inputtype := 3; // from waveform

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

  if viewwave.Value then
  begin
    scope.sampler.controller       := tsigcontroller4;
    scope.sampler.inputs[0].Source := tsignoise4.output;
    fft.sampler.controller         := tsigcontroller4;
    fft.sampler.inputs[0].Source   := tsignoise4.output;
  end;

  if scaleosci.Value then
    scope.xrange := 0.2
  else
    scope.xrange := 0.1;

  Caption := 'WavvieW ' + versiontext + ' for ' + platformtext;

  hasinit := True;
  tsigkeyboard1.keywidth := tsigkeyboard1.Width div 32;

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
  if hasinit then
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
    sleep(10);
    onchangefile(Sender);
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
  begin
    tsigoutaudio3.audio.active := True;
    sleep(10);
    onchangemic(Sender);
  end
  else
    tsigoutaudio3.audio.active := False;
end;

procedure tmainfo.onabout(const Sender: TObject);
begin
  aboutfo.Caption          := 'About WavvieW';
  aboutfo.about_text.frame.colorclient := $DFFFB2;
  aboutfo.about_text.Value := c_linefeed + c_linefeed + 'WavvieW ' + versiontext + ' for ' + platformtext +
    c_linefeed +
    'https://github.com/fredvs/WavvieW/releases/' + c_linefeed +
    c_linefeed + 'Compiled with FPC 3.2.0.' +
    c_linefeed + 'http://www.freepascal.org' + c_linefeed + c_linefeed +
    'Graphic widget: MSEgui ' + mseguiversiontext +
    '.' + c_linefeed + 'https://github.com/mse-org/mseide-msegui' +
    c_linefeed + c_linefeed +
    'Audio library: uos 1.8. (United Openlib of Sound)' + c_linefeed +
    'https://github.com/fredvs/uos' + c_linefeed +
    c_linefeed + 'Copyright 2021' + c_linefeed +
    'Fred van Stappen <fiens@hotmail.com>';
  aboutfo.Show(True);
end;

procedure tmainfo.oninit(const Sender: TObject);
begin
  SetExceptionMask(GetExceptionMask + [exZeroDivide] + [exInvalidOp] +
    [exDenormalized] + [exOverflow] + [exUnderflow] + [exPrecision]);

  sta.filename := IncludeTrailingBackslash(ExtractFilePath(ParamStr(0))) +
    'ini' + directoryseparator + 'stat.ini';
end;

procedure tmainfo.onwaveactivate(const Sender: TObject; var avalue: Boolean; var accept: Boolean);
begin
  if hasinit then
    if avalue then
    begin
      tsigoutaudio4.audio.active := True;
      sleep(10);
      onchangewave(Sender);
    end
    else
      tsigoutaudio4.audio.active := False;

end;

procedure tmainfo.onvolwave(const Sender: TObject; var avalue: realty; var accept: Boolean);
begin
  volwav.Value := round(100 * avalue);
end;

procedure tmainfo.onfreqwave(const Sender: TObject; var avalue: realty; var accept: Boolean);
var
  bvalue: integer;
begin
  bvalue   := round(avalue * avalue * 10000);
  if bvalue > 10000 then
    bvalue := 10000;
  if bvalue < 100 then
    bvalue := 100;
  freqwav.Value := bvalue;
end;


procedure tmainfo.onchangewave(const Sender: TObject);
var
  isodd: integer;
begin
  if hasinit then
  begin
    if oddwave.Value then
      isodd := 1
    else
      isodd := 0;

    tsigcontroller4.SetWaveForm(wavetype.Value, wavetype.Value,
      harmonwave.Value, harmonwave.Value,
      isodd, isodd,
      freqwav.Value, freqwav.Value,
      volwav.Value / 100, volwav.Value / 100);

{TypeWaveL, TypeWaveR,
AHarmonicsL,AHarmonicsR : Integer;
EvenHarmonicsL, EvenHarmonicsR : Shortint;
FreqL, FreqR, VolL, VolR: single);  
}
  end;
end;

procedure tmainfo.onwaveview(const Sender: TObject; var avalue: Boolean; var accept: Boolean);
begin
  if hasinit then
    if avalue then
    begin
      scope.sampler.controller       := tsigcontroller4;
      scope.sampler.inputs[0].Source := tsignoise4.output;
      fft.sampler.controller         := tsigcontroller4;
      fft.sampler.inputs[0].Source   := tsignoise4.output;
    end;
end;

procedure tmainfo.onfilevol(const Sender: TObject; var avalue: realty; var accept: Boolean);
begin
  volfile.Value := round(100 * avalue);
end;

procedure tmainfo.onchangefile(const Sender: TObject);
begin
  if hasinit then
    tsigcontroller2.SetVolume(volfile.Value / 100, volfile.Value / 100);
end;

procedure tmainfo.onmicvol(const Sender: TObject; var avalue: realty; var accept: Boolean);
begin
  volmic.Value := round(100 * avalue);
end;

procedure tmainfo.onchangemic(const Sender: TObject);
begin
  if hasinit then
    tsigcontroller3.SetVolume(volmic.Value / 100, volmic.Value / 100);
end;

procedure tmainfo.onsetampnoise(const Sender: TObject; var avalue: realty; var accept: Boolean);
begin
  noiseamp.Value := round(avalue * 100);
end;

procedure tmainfo.onresizeform(const Sender: TObject);
begin
  if hasinit then
    tsigkeyboard1.keywidth := round(tsigkeyboard1.Width / 32);
end;

procedure tmainfo.onshowoscilloscope(const Sender: TObject; var avalue: Boolean; var accept: Boolean);
begin
  if not avalue then
  begin
    scope.Visible      := False;
    tsplitter1.left    := 0;
    tsplitter1.Visible := False;
  end
  else
  begin
    tsplitter1.left    := Width div 2;
    tsplitter1.Visible := True;
    scope.Visible      := True;
  end;
end;


procedure tmainfo.onshowspectrum(const Sender: TObject; var avalue: Boolean; var accept: Boolean);
begin

  if not avalue then
  begin
    fft.Visible        := False;
    tsplitter1.left    := Width - tsplitter1.Width;
    tsplitter1.Visible := False;
  end
  else
  begin
    tsplitter1.left    := Width div 2;
    tsplitter1.Visible := True;
    fft.Visible        := True;
  end;
end;

procedure tmainfo.onscale(const Sender: TObject; var avalue: Boolean; var accept: Boolean);
begin
  if avalue then
    scope.xrange := 0.2
  else
    scope.xrange := 0.1;

end;

procedure tmainfo.onquit(const Sender: TObject);
begin
  application.terminate;
end;

procedure tmainfo.evonfft(const Sender: tsigsamplerfft; const abuffer: samplerbufferty);
begin

end;

procedure tmainfo.evonshowhint(const Sender: TObject; var info: hintinfoty);
begin
  //info.caption := 'Hello';
end;

procedure tmainfo.evonmouseclient(const Sender: twidget; var ainfo: mouseeventinfoty);
begin
  if Sender is tsigscopefft then
{
writeln('===================');
writeln('x,y = ' + inttostr(ainfo.pos.x) + ',' +inttostr( ainfo.pos.y));
writeln('log x = ' + floattostr(ln(ainfo.pos.x)));
};

end;

end.

