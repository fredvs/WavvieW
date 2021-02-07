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
  msedropdownlist;

type
  tmainfo = class(tmainform)
    cont: tsigcontroller;
    out: tsigoutaudio;
    noise: tsignoise;
    sta: tstatfile;
    tlayouter1: tlayouter;
    average: tbooleanedit;
    tlayouter2: tlayouter;
    tsplitter1: tsplitter;
    fft: tsigscopefft;
    scope: tsigscope;
    sampcount: tslider;
    tsigslider1: tsigslider;
    kinded: tenumtypeedit;
    averagecount: tintegerdisp;
    tfacecomp1: tfacecomp;
    tframecomp1: tframecomp;
    tframecomp2: tframecomp;
    timagelist3: timagelist;
    tsplitter2: tsplitter;
    tsigoutaudio1: tsigoutaudio;
    tsigfilter1: tsigfilter;
    tsignoise1: tsignoise;
    tsigcontroller1: tsigcontroller;
    tsigkeyboard1: tsigkeyboard;
    tsigslider3: tsigslider;
    noiseactive: tbooleanedit;
    pianoactive: tbooleanedit;
    tenvelopeedit1: tenvelopeedit;
    tlabel1: tlabel;
    tlabel2: tlabel;
    tlabel3: tlabel;
    tsigwavetable1: tsigwavetable;
    tsigin1: tsigin;
    tsigcontroller2: tsigcontroller;
    tsigoutaudio2: tsigoutaudio;
    sampcountdi: tintegerdisp;
    tsimplewidget1: tsimplewidget;
    procedure onclosexe(const Sender: TObject);
    procedure samcountsetexe(const Sender: TObject; var avalue: realty; var accept: Boolean);
    procedure typinitexe(const Sender: tenumtypeedit);
    procedure kindsetexe(const Sender: TObject; var avalue: integer; var accept: Boolean);
    procedure averagesetev(const Sender: TObject; var avalue: Boolean; var accept: Boolean);
    procedure buffullev(const Sender: tsigsampler; const abuffer: samplerbufferty);
    procedure onnoiseactiv(const Sender: TObject; var avalue: Boolean; var accept: Boolean);
    procedure onpianoactiv(const Sender: TObject; var avalue: Boolean; var accept: Boolean);
  end;

var
  mainfo: tmainfo;

implementation

uses
  main_mfm;

procedure tmainfo.onclosexe(const Sender: TObject);
begin
  out.audio.active := False;
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

procedure tmainfo.onnoiseactiv(const Sender: TObject; var avalue: Boolean; var accept: Boolean);
begin
  if avalue then
  begin
    pianoactive.Value        := False;
    scope.sampler.controller := cont;
    scope.sampler.inputs[0].Source := noise.output;
    fft.sampler.controller   := cont;
    fft.sampler.inputs[0].Source := noise.output;
  end
  else
  begin
    scope.sampler.controller       := tsigcontroller1;
    scope.sampler.inputs[0].Source := tsigfilter1.output;
    fft.sampler.controller         := tsigcontroller1;
    fft.sampler.inputs[0].Source   := tsigfilter1.output;
  end;

end;

procedure tmainfo.onpianoactiv(const Sender: TObject; var avalue: Boolean; var accept: Boolean);
begin
  if avalue then
  begin
    noiseactive.Value        := False;
    scope.sampler.controller := tsigcontroller1;
    scope.sampler.inputs[0].Source := tsigfilter1.output;
    fft.sampler.controller   := tsigcontroller1;
    fft.sampler.inputs[0].Source := tsigfilter1.output;
  end
  else
  begin
    scope.sampler.controller       := cont;
    scope.sampler.inputs[0].Source := noise.output;
    fft.sampler.controller         := cont;
    fft.sampler.inputs[0].Source   := noise.output;
  end;

end;

end.

