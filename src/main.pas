unit main;

{$ifdef FPC}{$mode objfpc}{$h+}{$endif}
interface

uses
 msetypes,mseglob,mseguiglob,mseguiintf,mseapplication,msestat,msemenus,msegui,
 mseeditglob,
 msegraphics,msegraphutils,mseevent,mseclasses,msewidgets,mseforms,uos_mseaudio,
 uos_msesigaudio,msesignal,msestrings,msesignoise,msechartedit,msedataedits,
 mseedit,mseificomp,mseificompglob,mseifiglob,msesiggui,msestatfile,msesigfft,
 msesigfftgui,msegraphedits,msescrollbar,msedispwidgets,mserichstring,
 msesplitter,msesimplewidgets,msefilter,mseact,msestream,SysUtils,msebitmap,
 msedropdownlist,msefiledialogx,Math,msefftw;

const
  versiontext = '1.8';

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
    tsigoutaudio1: tsigoutaudio;
    tsigfilter1: tsigfilter;
    tsignoise1: tsignoise;
    tsigcontroller1: tsigcontroller;
    tsigoutaudio2: tsigoutaudio;
    tsigcontroller2: tsigcontroller;
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
    tlayouter1: tlayouter;
    tgroupbox2: tgroupbox;
    bstop: TButton;
    bstart: TButton;
    tfilenameeditx1: tfilenameeditx;
    sliderfile: tslider;
    oninputon: tbooleanedit;
    tgroupbox5: tgroupbox;
    slidermic: tslider;
    onnoiseon: tbooleanedit;
    tgroupbox3: tgroupbox;
    sampcountR: tslider;
    tsigslider1: tsigslider;
    kinded: tenumtypeedit;
    sampcountdiR: tintegerdisp;
    noiseampR: tintegerdisp;
    tgroupbox4: tgroupbox;
    wavetypeL: tenumtypeedit;
    sliderwaveL: tslider;
    freqwavL: tintegeredit;
    sliderfreqwaveL: tslider;
    harmonwaveL: tintegeredit;
    OddwaveL: tbooleanedit;
    tgroupbox1: tgroupbox;
    onpianoon: tbooleanedit;
    tsigkeyboard1: tsigkeyboard;
    tenvelopeedit1: tenvelopeedit;
    tlabel2: tlabel;
    tlabel3: tlabel;
    tlabel4: tlabel;
    onwavon: tbooleanedit;
    tfacecomp5: tfacecomp;
    bquit: TButton;
   tfacecomp6: tfacecomp;
   tgroupbox6: tgroupbox;
   tsigslider3: tsigslider;
   volpiano: tintegerdisp;
   volfile: tintegerdisp;
   volmic: tintegerdisp;
   tfacecomp7: tfacecomp;
   volwavL: tintegerdisp;
   noise2: tsignoise;
   tsignoise42: tsignoise;
   tsignoise22: tsignoise;
   tsignoise32: tsignoise;
   wavetypeR: tenumtypeedit;
   harmonwaveR: tintegeredit;
   sliderfreqwaveR: tslider;
   volwavR: tintegerdisp;
   sliderwaveR: tslider;
   freqwavR: tintegeredit;
   volpianoR: tintegerdisp;
   tsigslider32: tsigslider;
   sampcountdiL: tintegerdisp;
   sampcountL: tslider;
   noiseampL: tintegerdisp;
   tsigslider1L: tsigslider;
   leftosci: tbooleanedit;
   rightosci: tbooleanedit;
   kindedR: tenumtypeedit;
   volfileR: tintegerdisp;
   sliderfileR: tslider;
   volmicR: tintegerdisp;
   slidermicR: tslider;
   scaleosci: tbooleanedit;
   tgroupbox7: tgroupbox;
   viewpiano: tbooleaneditradio;
   viewnoise: tbooleaneditradio;
   viewwave: tbooleaneditradio;
   viewinput: tbooleaneditradio;
   viewfile: tbooleaneditradio;
   tsigfilter2: tsigfilter;
   tgroupbox8: tgroupbox;
   averagecount: tintegerdisp;
   average: tbooleanedit;
   rightspectrum: tbooleanedit;
   leftspectrum: tbooleanedit;
   oscion: tbooleanedit;
   spectrumon: tbooleanedit;
   linkwavchan: tbooleanedit;
   linkpianochan: tbooleanedit;
   linknoisechan: tbooleanedit;
   linkmicchan: tbooleanedit;
   OddwaveR: tbooleanedit;
   linkfilechan: tbooleanedit;
    procedure onclosexe(const Sender: TObject);
    procedure samcountsetexeR(const Sender: TObject; var avalue: realty;
                   var accept: Boolean);
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
    procedure onvolwaveL(const Sender: TObject; var avalue: realty;
                   var accept: Boolean);
    procedure onfreqwaveL(const Sender: TObject; var avalue: realty;
                   var accept: Boolean);
    procedure onchangewave(const Sender: TObject);
    procedure onwaveview(const Sender: TObject; var avalue: Boolean; var accept: Boolean);
    procedure onfilevol(const Sender: TObject; var avalue: realty; var accept: Boolean);
    procedure onchangefile(const Sender: TObject);
    procedure onmicvol(const Sender: TObject; var avalue: realty; var accept: Boolean);
    procedure onchangemic(const Sender: TObject);
    procedure onsetampnoiseR(const Sender: TObject; var avalue: realty;
                   var accept: Boolean);
    procedure onresizeform(const Sender: TObject);
    procedure onshowoscilloscope(const Sender: TObject; var avalue: Boolean; var accept: Boolean);
    procedure onshowspectrum(const Sender: TObject; var avalue: Boolean; var accept: Boolean);
    procedure onscale(const Sender: TObject; var avalue: Boolean; var accept: Boolean);
    procedure onquit(const Sender: TObject);
    procedure evonfft(const Sender: tsigsamplerfft; const abuffer: samplerbufferty);
    procedure evonshowhint(const Sender: TObject; var info: hintinfoty);
    procedure evonmouseclient(const Sender: twidget; var ainfo: mouseeventinfoty);
   procedure onsetsliderpiano(const sender: TObject; var avalue: realty;
                   var accept: Boolean);
   procedure osetleftspectrum(const sender: TObject; var avalue: Boolean;
                   var accept: Boolean);
   procedure onrightspectrum(const sender: TObject; var avalue: Boolean;
                   var accept: Boolean);
   procedure onleftosci(const sender: TObject; var avalue: Boolean;
                   var accept: Boolean);
   procedure onsetrightosci(const sender: TObject; var avalue: Boolean;
                   var accept: Boolean);
   procedure onvolwaveR(const sender: TObject; var avalue: realty;
                   var accept: Boolean);
   procedure onfreqwaveR(const sender: TObject; var avalue: realty;
                   var accept: Boolean);
   procedure kindsetexeR(const sender: TObject; var avalue: Integer;
                   var accept: Boolean);
   procedure onsetampnoiseL(const sender: TObject; var avalue: realty;
                   var accept: Boolean);
   procedure samcountsetexeL(const sender: TObject; var avalue: realty;
                   var accept: Boolean);
   procedure onsetsliderpianoR(const sender: TObject; var avalue: realty;
                   var accept: Boolean);
   procedure onfilevolR(const sender: TObject; var avalue: realty;
                   var accept: Boolean);
   procedure onvolmicR(const sender: TObject; var avalue: realty;
                   var accept: Boolean);
   procedure onvaluefreqL(const sender: TObject; var avalue: Integer;
                   var accept: Boolean);
   procedure onvaluefreqR(const sender: TObject; var avalue: Integer;
                   var accept: Boolean);
   procedure onsetharmL(const sender: TObject; var avalue: Integer;
                   var accept: Boolean);
   procedure onsetharmR(const sender: TObject; var avalue: Integer;
                   var accept: Boolean);
   procedure onsetwavekindL(const sender: TObject; var avalue: Integer;
                   var accept: Boolean);
   procedure onsetwavekindR(const sender: TObject; var avalue: Integer;
                   var accept: Boolean);
   procedure onsetoddL(const sender: TObject; var avalue: Boolean;
                   var accept: Boolean);
   procedure onsetoddR(const sender: TObject; var avalue: Boolean;
                   var accept: Boolean);
   procedure onkey(const sender: twidget; var ainfo: keyeventinfoty);
   procedure onmousev(const sender: twidget; var ainfo: mouseeventinfoty);
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

procedure tmainfo.samcountsetexeR(const Sender: TObject; var avalue: realty;
               var accept: Boolean);
begin
  noise.samplecount := round(19 * avalue) + 1;
  sampcountdiR.Value := noise.samplecount;
  
  if linknoisechan.value then  begin
   noise2.samplecount := noise.samplecount;
   sampcountdiL.Value := sampcountdiR.Value;
   sampcountL.value := avalue;
   end; 
end;

procedure tmainfo.typinitexe(const Sender: tenumtypeedit);
begin
  Sender.typeinfopo := typeinfo(noisekindty);
end;

procedure tmainfo.kindsetexe(const Sender: TObject; var avalue: integer; var accept: Boolean);
begin
  noise.kind := noisekindty(avalue);
  
  if linknoisechan.value then
    begin
    kindedR.value := avalue;    
    noise2.kind := noise.kind;    end;
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
    scope.sampler.inputs[1].Source := noise2.output;
    fft.sampler.controller         := cont;
    fft.sampler.inputs[0].Source   := noise.output;
    fft.sampler.inputs[1].Source := noise2.output;
   
  end;
end;

procedure tmainfo.onpianoview(const Sender: TObject; var avalue: Boolean; var accept: Boolean);
begin
  if avalue then
  begin
    scope.sampler.controller       := tsigcontroller1;
    scope.sampler.inputs[0].Source := tsigfilter1.output;
    scope.sampler.inputs[1].Source := tsigfilter1.output;
  
    fft.sampler.controller         := tsigcontroller1;
    fft.sampler.inputs[0].Source   := tsigfilter1.output;
    fft.sampler.inputs[1].Source := tsigfilter1.output;
  
  end;
end;

procedure tmainfo.oncreated(const Sender: TObject);
var
  PA_FileName, SF_FileName, MP_FileName, ordir: string;
  ara, arb: msestringarty;
begin
  setlength(ara, 6);
  setlength(arb, 6);

  ara[0] := 'All sound files';
  ara[1] := 'wav';
  ara[2] := 'ogg';
  ara[3] := 'flac';
  ara[4] := 'mp3';
  ara[5] := 'All';

  arb[0] := '"*.wav" "*.ogg" "*.flac" "*.mp3" "*.WAV" "*.OGG" "*.FLAC" "*.MP3"';
  arb[1] := '"*.wav" "*.WAV"';
  arb[2] := '"*.ogg" "*.OGG"';
  arb[3] := '"*.flac" "*.FLAC"';
  arb[4] := '"*.mp3" "*.MP3"';
  arb[5] := '"*.*"';
  
   tfilenameeditx1.controller.captionopen := 'Choose a wav, ogg, mp3 or flac audio file';

  tfilenameeditx1.controller.filterlist.asarraya := ara;
  tfilenameeditx1.controller.filterlist.asarrayb := arb;
  tfilenameeditx1.controller.filter :=
   '"*.wav" "*.ogg" "*.flac" "*.mp3" "*.WAV" "*.OGG" "*.FLAC" "*.MP3"';

  ordir := IncludeTrailingBackslash(ExtractFilePath(ParamStr(0)));

{$IFDEF Windows}
     {$if defined(cpu64)}
    PA_FileName := ordir + 'lib\Windows\64bit\LibPortaudio-64.dll';
    SF_FileName := ordir + 'lib\Windows\64bit\LibSndFile-64.dll';
    MP_FileName := ordir + 'lib\Windows\64bit\LibMpg123-64.dll';
    fftw_init(ordir + 'lib\Windows\64bit\');
      {$else}
    PA_FileName := ordir + 'lib\Windows\32bit\LibPortaudio-32.dll';
    SF_FileName := ordir + 'lib\Windows\32bit\LibSndFile-32.dll';
    MP_FileName := ordir + 'lib\Windows\32bit\LibMpg123-32.dll';
      fftw_init(ordir + 'lib\Windows\32bit\');
     {$endif}
 {$ENDIF}

     {$if defined(CPUAMD64) and defined(linux) }
  SF_FileName := ordir + 'lib/Linux/64bit/LibSndFile-64.so';
  PA_FileName := ordir + 'lib/Linux/64bit/LibPortaudio-64.so'; 
  MP_FileName := ordir + 'lib/Linux/64bit/LibMpg123-64.so';
  fftw_init(ordir + 'lib/Linux/64bit/');
     {$ENDIF}

   {$if defined(cpu86) and defined(linux)}
    PA_FileName := ordir + 'lib/Linux/32bit/LibPortaudio-32.so';
    SF_FileName := ordir + 'lib/Linux/32bit/LibSndFile-32.so'; 
    MP_FileName := ordir + 'lib/Linux/32bit/LibMpg123-32.so';
    fftw_init(ordir + 'lib/Linux/32bit/');
     {$ENDIF}

  {$if defined(linux) and defined(cpuaarch64)}
  PA_FileName := ordir + 'lib/Linux/aarch64_raspberrypi/libportaudio_aarch64.so';
  SF_FileName := ordir + 'lib/Linux/aarch64_raspberrypi/libsndfile_aarch64.so';
  MP_FileName := ordir + 'lib/Linux/aarch64_raspberrypi/libmpg123_aarch64.so';
  fftw_init(ordir + 'lib/Linux/aarch64_raspberrypi/');
  {$ENDIF}

  {$if defined(linux) and defined(cpuarm)}
    PA_FileName := ordir + 'lib/Linux/arm_raspberrypi/libportaudio-arm.so';
    SF_FileName := ordir + 'lib/Linux/arm_raspberrypi/libsndfile-arm.so'; 
    MP_FileName := ordir + 'lib/Linux/arm_raspberrypi/libmpg123-arm.so';
    fftw_init(ordir + 'lib/Linux/arm_raspberrypi/'); 
    {$ENDIF}

 {$IFDEF freebsd}
    {$if defined(cpu64)}
    PA_FileName := ordir + 'lib/FreeBSD/64bit/libportaudio-64.so';
    SF_FileName := ordir + 'lib/FreeBSD/64bit/libsndfile-64.so';
    MP_FileName := ordir + 'lib/FreeBSD/64bit/libmpg123-64.so';
    fftw_init(ordir + 'lib/FreeBSD/64bit/'); 
    {$else}
    PA_FileName := ordir + 'lib/FreeBSD/32bit/libportaudio-32.so';
    SF_FileName := ordir + 'lib/FreeBSD/32bit/libsndfile-32.so';
    MP_FileName := ordir + 'lib/FreeBSD/32bit/libmpg123-32.so';
     fftw_init(ordir + 'lib/FreeBSD/32bit/'); 
    {$endif} {$ENDIF}

  uos_mseLoadLib(PA_FileName, SF_FileName, MP_FileName);

  cont.inputtype := 0;            // from synth/noise
  tsigcontroller1.inputtype := 0; // from synth/piano
  tsigcontroller2.inputtype := 1; // from file
  tsigcontroller3.inputtype := 2; // from input/mic
  tsigcontroller4.inputtype := 3; // from waveform

  if viewinput.Value then
  begin
    scope.sampler.controller       := tsigcontroller3;
    scope.sampler.inputs[0].Source := tsignoise3.output;
    scope.sampler.inputs[1].Source := tsignoise32.output;
    fft.sampler.controller         := tsigcontroller3;
    fft.sampler.inputs[0].Source   := tsignoise3.output;
    fft.sampler.inputs[1].Source := tsignoise32.output;
  end;

  if viewfile.Value then
  begin
    scope.sampler.controller       := tsigcontroller2;
    scope.sampler.inputs[0].Source := tsignoise2.output;
    scope.sampler.inputs[1].Source := tsignoise22.output;
    fft.sampler.controller         := tsigcontroller2;
    fft.sampler.inputs[0].Source   := tsignoise2.output;
    fft.sampler.inputs[1].Source   := tsignoise22.output;
  end;

  if viewnoise.Value then
  begin
    scope.sampler.controller       := cont;
    scope.sampler.inputs[0].Source := noise.output;
    scope.sampler.inputs[1].Source := noise2.output;
    fft.sampler.controller         := cont;
    fft.sampler.inputs[0].Source   := noise.output;
    fft.sampler.inputs[1].Source   := noise2.output;
  end;

  if viewpiano.Value then
  begin
    scope.sampler.controller       := tsigcontroller1;
    scope.sampler.inputs[0].Source := tsigfilter1.output;
    scope.sampler.inputs[1].Source := tsigfilter1.output;
    fft.sampler.controller         := tsigcontroller1;
    fft.sampler.inputs[0].Source   := tsigfilter1.output;
    fft.sampler.inputs[1].Source   := tsigfilter1.output;
  end;

  if viewwave.Value then
  begin
    scope.sampler.controller       := tsigcontroller4;
    scope.sampler.inputs[0].Source := tsignoise4.output;
    scope.sampler.inputs[1].Source := tsignoise42.output;
    fft.sampler.controller         := tsigcontroller4;
    fft.sampler.inputs[0].Source   := tsignoise4.output;
    fft.sampler.inputs[1].Source   := tsignoise42.output;
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
    begin
      onnoiseon.color := $3B4F00;
  
      out.audio.active := True;
      end
    else
     begin
      onnoiseon.color := cl_transparent;
      out.audio.active := False;
     end; 
end;

procedure tmainfo.onpianoactivate(const Sender: TObject; var avalue: Boolean; var accept: Boolean);
begin
//application.processmessages;
  if hasinit then
    if avalue then
    begin
      onpianoon.color := $3B4F00;
      tsigoutaudio1.audio.active := True;
      end
    else
    begin
      onpianoon.color := cl_transparent;
      tsigoutaudio1.audio.active := False;
  // application.processmessages; 
  end;
end;

procedure tmainfo.onfileview(const Sender: TObject; var avalue: Boolean; var accept: Boolean);
begin
  if avalue then
  begin
    scope.sampler.controller       := tsigcontroller2;
    scope.sampler.inputs[0].Source := tsignoise2.output;
    scope.sampler.inputs[1].Source := tsignoise22.output;
     fft.sampler.controller         := tsigcontroller2;
    fft.sampler.inputs[0].Source   := tsignoise2.output;
    fft.sampler.inputs[1].Source   := tsignoise22.output;
  end;
end;

procedure tmainfo.onstart(const Sender: TObject);
begin
  if hasinit then
  begin
  if fileexists(tfilenameeditx1.controller.filename) then
     begin
    tsigoutaudio2.audio.active    := False;
    tsigcontroller2.SoundFilename := tfilenameeditx1.controller.filename;
    tsigoutaudio2.audio.active    := True;
    sleep(10);
    onchangefile(Sender);
    end else
       showerror('File does not exist: ' + tfilenameeditx1.controller.filename,'Error');
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
    scope.sampler.inputs[1].Source := tsignoise32.output;
    fft.sampler.controller         := tsigcontroller3;
    fft.sampler.inputs[0].Source   := tsignoise3.output;
    fft.sampler.inputs[1].Source   := tsignoise32.output;
  end;
end;

procedure tmainfo.oninputactivate(const Sender: TObject; var avalue: Boolean; var accept: Boolean);
begin
  if avalue then
  begin
    oninputon.color := $3B4F00;
    tsigoutaudio3.audio.active := True;
    sleep(10);
    onchangemic(Sender);
  end
  else
  begin
    oninputon.color := cl_transparent;
    tsigoutaudio3.audio.active := False;
  end;  
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
      onwavon.color := $3B4F00;
      tsigoutaudio4.audio.active := True;
      sleep(10);
      onchangewave(Sender);
    end
    else
     begin
      onwavon.color := cl_transparent;
      tsigoutaudio4.audio.active := False;
     end; 

end;

procedure tmainfo.onvolwaveL(const Sender: TObject; var avalue: realty;
               var accept: Boolean);
begin
  volwavL.Value := round(100 * avalue);
   if linkwavchan.value then
    begin
   volwavR.Value := volwavL.Value;
   sliderwaveR.value := avalue;
   end;
end;

procedure tmainfo.onfreqwaveL(const Sender: TObject; var avalue: realty;
               var accept: Boolean);
var
  bvalue: integer;
begin
  bvalue   := round(avalue * avalue * 10000);
  if bvalue > 10000 then
    bvalue := 10000;
  if bvalue < 100 then
    bvalue := 100;
  freqwavL.Value := bvalue;

if linkwavchan.value then
    begin
   freqwavR.Value := freqwavL.Value;
   sliderfreqwaveR.value := avalue;
   end;  
  
end;


procedure tmainfo.onchangewave(const Sender: TObject);
var
  isoddL, isoddR: integer;
begin
  if hasinit then
  begin
  
  
  if linkwavchan.value then
    begin
   //oddwaveR.Value := oddwaveL.Value;
   //harmonwaveR.Value := harmonwaveL.Value;
  // freqwavR.value := freqwavL.value;
   end;
   
  
    if oddwaveL.Value then
      isoddL := 1
    else
      isoddL := 0;
      
      if oddwaveR.Value then
      isoddR := 1
    else
      isoddR := 0;
      
      tsigcontroller4.SetWaveForm(wavetypeL.Value, wavetypeR.Value,
      harmonwaveL.Value, harmonwaveR.Value,
      isoddL, isoddR,
      freqwavL.Value, freqwavR.Value,
      volwavL.Value / 100, volwavR.Value / 100);
    {  
       bvalue   := round(avalue * avalue * 10000);
  if bvalue > 10000 then
    bvalue := 10000;
  if bvalue < 100 then
    bvalue := 100;
  freqwav.Value := bvalue;
     }
      
   //  sliderfreqwaveL.value := sqrt(freqwavL.Value) / 100;
   //  sliderfreqwaveR.value := sqrt(freqwavR.Value) / 100;
  
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
      scope.sampler.inputs[1].Source := tsignoise42.output;
      fft.sampler.controller         := tsigcontroller4;
      fft.sampler.inputs[0].Source   := tsignoise4.output;
      fft.sampler.inputs[1].Source   := tsignoise42.output;
 
    end;
end;

procedure tmainfo.onfilevol(const Sender: TObject; var avalue: realty; var accept: Boolean);
begin
  volfile.Value := round(100 * avalue);
  if linkfilechan.value then
  begin
   volfileR.Value := volfile.Value;
   sliderfileR.value := avalue;
   end;
end;

procedure tmainfo.onchangefile(const Sender: TObject);
begin
  if hasinit then
    tsigcontroller2.SetVolume(volfile.Value / 100, volfileR.Value / 100);
end;

procedure tmainfo.onmicvol(const Sender: TObject; var avalue: realty; var accept: Boolean);
begin
  volmic.Value := round(100 * avalue);
   if linkmicchan.value then
    begin
   volmicR.Value := volmic.Value;
   slidermicR.value := avalue;
   end;
end;

procedure tmainfo.onchangemic(const Sender: TObject);
begin
  if hasinit then
    tsigcontroller3.SetVolume(volmic.Value / 100, volmicR.Value / 100);
end;

procedure tmainfo.onsetampnoiseR(const Sender: TObject; var avalue: realty;
               var accept: Boolean);
begin
  noiseampR.Value := round(avalue * 100);
    if linknoisechan.value then  begin
   noiseampL.Value := noiseampR.Value;
   tsigslider1L.value := avalue;
   end;
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
    scaleosci.Visible  := false;
    leftosci.Visible  := false;
    rightosci.Visible  := false;
  end
  else
  begin
    tsplitter1.left    := Width div 2;
    tsplitter1.Visible := True;
    scope.Visible      := True;
    scaleosci.Visible  := true;
    leftosci.Visible  := true;
    rightosci.Visible  := true;
  end;
end;


procedure tmainfo.onshowspectrum(const Sender: TObject; var avalue: Boolean; var accept: Boolean);
begin

  if not avalue then
  begin
    fft.Visible        := False;
    tsplitter1.left    := Width - tsplitter1.Width;
    tsplitter1.Visible := False;
    average.Visible  := false;
    averagecount.Visible  := false;
    leftspectrum.Visible  := false;
    rightspectrum.Visible  := false;
  end
  else
  begin
    tsplitter1.left    := Width div 2;
    tsplitter1.Visible := True;
    fft.Visible        := True;
    average.Visible  := True;
    averagecount.Visible  := True;
    leftspectrum.Visible  := True;
    rightspectrum.Visible  := True;
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
//  if Sender is tsigscopefft then
{
writeln('===================');
writeln('x,y = ' + inttostr(ainfo.pos.x) + ',' +inttostr( ainfo.pos.y));
writeln('log x = ' + floattostr(ln(ainfo.pos.x)));
};

end;

procedure tmainfo.onsetsliderpiano(const sender: TObject; var avalue: realty;
               var accept: Boolean);
begin
  volpiano.Value := round(100 * avalue);
   if linkpianochan.value then
    begin
   volpianoR.Value := volpiano.Value;
   tsigslider32.value := avalue;
   end;
end;

procedure tmainfo.osetleftspectrum(const sender: TObject; var avalue: Boolean;
               var accept: Boolean);
begin
if avalue then fft.traces[0].color := cl_green else
fft.traces[0].color := cl_transparent;
end;

procedure tmainfo.onrightspectrum(const sender: TObject; var avalue: Boolean;
               var accept: Boolean);
begin
if avalue then fft.traces[1].color := cl_ltred else
fft.traces[1].color := cl_transparent;

end;

procedure tmainfo.onleftosci(const sender: TObject; var avalue: Boolean;
               var accept: Boolean);
begin
if avalue then scope.traces[0].color := cl_green else
scope.traces[0].color := cl_transparent;
end;

procedure tmainfo.onsetrightosci(const sender: TObject; var avalue: Boolean;
               var accept: Boolean);
begin
if avalue then scope.traces[1].color := cl_ltred else
scope.traces[1].color := cl_transparent;

end;

procedure tmainfo.onvolwaveR(const sender: TObject; var avalue: realty;
               var accept: Boolean);

begin
    volwavR.Value := round(100 * avalue);
    if linkwavchan.value then
    begin
   volwavL.Value := volwavR.Value;
   sliderwaveL.value := avalue;
   end;
end;

procedure tmainfo.onfreqwaveR(const sender: TObject; var avalue: realty;
               var accept: Boolean);
var
  bvalue: integer;
begin
  bvalue   := round(avalue * avalue * 10000);
  if bvalue > 10000 then
    bvalue := 10000;
  if bvalue < 100 then
    bvalue := 100;
  freqwavR.Value := bvalue;
  
  if linkwavchan.value then
    begin
   freqwavL.Value := freqwavR.Value;
   sliderfreqwaveL.value := avalue;
   end;
end;

procedure tmainfo.kindsetexeR(const sender: TObject; var avalue: Integer;
               var accept: Boolean);
begin
 noise2.kind := noisekindty(avalue);
   
 if linknoisechan.value then
    begin
    kinded.value := avalue;    
    noise.kind := noise2.kind; 
     end;
end;

procedure tmainfo.onsetampnoiseL(const sender: TObject; var avalue: realty;
               var accept: Boolean);
begin
 noiseampL.Value := round(avalue * 100);
  if linknoisechan.value then  begin
   noiseampR.Value := noiseampL.Value;
   tsigslider1.value := avalue;
   end;
end;

procedure tmainfo.samcountsetexeL(const sender: TObject; var avalue: realty;
               var accept: Boolean);
begin
 noise2.samplecount := trunc(19 * avalue) + 1;
  sampcountdiL.Value := noise2.samplecount;
  
 if linknoisechan.value then  begin
   noise.samplecount := noise2.samplecount;
   sampcountdiR.Value := sampcountdiL.Value;
   sampcountR.value := avalue;
   end;  
end;

procedure tmainfo.onsetsliderpianoR(const sender: TObject; var avalue: realty;
               var accept: Boolean);
begin
 volpianoR.Value := round(100 * avalue);
    if linkpianochan.value then  begin
   volpiano.Value := volpianoR.Value;
   tsigslider3.value := avalue;
   end;
end;

procedure tmainfo.onfilevolR(const sender: TObject; var avalue: realty;
               var accept: Boolean);
begin
 volfileR.Value := round(100 * avalue);
   if linkfilechan.value then   
    begin
   volfile.Value := volfileR.Value;
   sliderfile.value := avalue;
   end;
end;

procedure tmainfo.onvolmicR(const sender: TObject; var avalue: realty;
               var accept: Boolean);
begin
 volmicR.Value := round(100 * avalue);
   if linkmicchan.value then 
    begin
   volmic.Value := volmicR.Value;
   slidermic.value := avalue;
   end;
end;

procedure tmainfo.onvaluefreqL(const sender: TObject; var avalue: Integer;
               var accept: Boolean);
begin
if linkwavchan.value then
    begin
     sliderfreqwaveL.value := sqrt(avalue) / 100;
     sliderfreqwaveR.value := sliderfreqwaveL.value;
     freqwavR.Value := avalue;
    end;  
end;

procedure tmainfo.onvaluefreqR(const sender: TObject; var avalue: Integer;
               var accept: Boolean);
begin
if linkwavchan.value then
    begin
     sliderfreqwaveR.value := sqrt(avalue) / 100;
     sliderfreqwaveL.value := sliderfreqwaveR.value;
     freqwavL.Value := avalue;
    end;  
end;

procedure tmainfo.onsetharmL(const sender: TObject; var avalue: Integer;
               var accept: Boolean);
begin
if linkwavchan.value then
    begin
     harmonwaveR.Value := avalue;
    end;  
end;

procedure tmainfo.onsetharmR(const sender: TObject; var avalue: Integer;
               var accept: Boolean);
begin
if linkwavchan.value then
    begin
     harmonwaveL.Value := avalue;
    end;  
end;

procedure tmainfo.onsetwavekindL(const sender: TObject; var avalue: Integer;
               var accept: Boolean);
begin
if linkwavchan.value then
    begin
     wavetypeR.Value := avalue;
    end;  
end;

procedure tmainfo.onsetwavekindR(const sender: TObject; var avalue: Integer;
               var accept: Boolean);
begin
if linkwavchan.value then
    begin
     wavetypeL.Value := avalue;
    end;  
end;

procedure tmainfo.onsetoddL(const sender: TObject; var avalue: Boolean;
               var accept: Boolean);
begin
if linkwavchan.value then
    begin
     oddwaveR.Value := avalue;
    end;  
end;

procedure tmainfo.onsetoddR(const sender: TObject; var avalue: Boolean;
               var accept: Boolean);
begin
if linkwavchan.value then
    begin
     oddwaveL.Value := avalue;
    end;  
end;

procedure tmainfo.onkey(const sender: twidget; var ainfo: keyeventinfoty);
begin
{
if (ainfo.eventkind =   ek_keypress)  then
      begin
    wavetypeL.optionsedit := wavetypeL.optionsedit + [oe_readonly];
    end;
    
if (ainfo.eventkind =  ek_keyrelease)  then
      begin
    wavetypeL.optionsedit := wavetypeL.optionsedit - [oe_readonly];
    end;   
    } 
end;

procedure tmainfo.onmousev(const sender: twidget; var ainfo: mouseeventinfoty);
begin

 if (ainfo.eventkind = ek_buttonrelease)  then
      begin
      wavetypeL.optionsedit := wavetypeL.optionsedit - [oe_readonly];
     end; 
     
 if (ainfo.eventkind = ek_buttonpress)  then
      begin
      wavetypeL.optionsedit := wavetypeL.optionsedit + [oe_readonly];
     end; 
        
end;

end.

