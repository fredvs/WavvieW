unit main;
{$ifdef FPC}{$mode objfpc}{$h+}{$endif}
interface
uses
 msetypes,mseglob,mseguiglob,mseguiintf,mseapplication,msestat,msemenus,msegui,
 msegraphics,msegraphutils,mseevent,mseclasses,msewidgets,mseforms,uos_mseaudio,
 uos_msesigaudio,msestrings,msesignal,msesignoise,msechartedit,msedataedits,
 mseedit,mseificomp,mseificompglob,mseifiglob,msesiggui,msestatfile,msesigfft,
 msesigfftgui,msegraphedits,msescrollbar,msedispwidgets,mserichstring,
 msesplitter,msesimplewidgets,msefilter,mseact,msestream,sysutils, msebitmap,
 msedropdownlist, msesigaudio;

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
   procedure onclosexe(const sender: TObject);
   procedure samcountsetexe(const sender: TObject; var avalue: realty;
                   var accept: Boolean);
   procedure typinitexe(const sender: tenumtypeedit);
   procedure kindsetexe(const sender: TObject; var avalue: Integer;
                   var accept: Boolean);
   procedure averagesetev(const sender: TObject; var avalue: Boolean;
                   var accept: Boolean);
   procedure buffullev(const sender: tsigsampler;
                   const abuffer: samplerbufferty);
   procedure onnoiseactiv(const sender: TObject; var avalue: Boolean;
                   var accept: Boolean);
   procedure onpianoactiv(const sender: TObject; var avalue: Boolean;
                   var accept: Boolean);
 end;
var
 mainfo: tmainfo;
implementation
uses
 main_mfm;

procedure tmainfo.onclosexe(const sender: TObject);
begin
 out.audio.active:= false;
end;

procedure tmainfo.samcountsetexe(const sender: TObject; var avalue: realty;
               var accept: Boolean);
begin
 noise.samplecount:= round(19*avalue)+1;
 sampcountdi.value:= noise.samplecount;
end;

procedure tmainfo.typinitexe(const sender: tenumtypeedit);
begin
 sender.typeinfopo:= typeinfo(noisekindty);
end;

procedure tmainfo.kindsetexe(const sender: TObject; var avalue: Integer;
               var accept: Boolean);
begin
 noise.kind:= noisekindty(avalue);
end;

procedure tmainfo.averagesetev(const sender: TObject; var avalue: Boolean;
               var accept: Boolean);
begin
 if avalue then begin
  fft.sampler.options:= fft.sampler.options + [sso_average];
 end
 else begin
  fft.sampler.options:= fft.sampler.options - [sso_average];
 end;
end;

procedure tmainfo.buffullev(const sender: tsigsampler;
               const abuffer: samplerbufferty);
begin
 sender.lockapplication();
 averagecount.value:= tsigsamplerfft(sender).averagecount;
 sender.unlockapplication();
end;

procedure tmainfo.onnoiseactiv(const sender: TObject; var avalue: Boolean;
               var accept: Boolean);
begin
  out.audio.active := avalue;
if avalue then 
begin
tsigoutaudio1.audio.active := false;
pianoactive.value:= false;
scope.sampler.controller := cont;
scope.sampler.inputs[0].source := noise.output;
fft.sampler.controller := cont;
fft.sampler.inputs[0].source := noise.output;
end;
 

end;

procedure tmainfo.onpianoactiv(const sender: TObject; var avalue: Boolean;
               var accept: Boolean);
begin
tsigoutaudio1.audio.active := avalue;
if avalue then
begin
 out.audio.active := false;
 noiseactive.value:= false;
 scope.sampler.controller := tsigcontroller1;
 scope.sampler.inputs[0].source := tsigfilter1.output;
 fft.sampler.controller := tsigcontroller1;
 fft.sampler.inputs[0].source := tsigfilter1.output;
end;

end;

end.
