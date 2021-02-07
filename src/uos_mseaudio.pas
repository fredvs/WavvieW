{ MSEgui Copyright (c) 2010-2014 by Martin Schreiber

    See the file COPYING.MSE, included in this distribution,
    for details about the copyright.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
}
unit uos_mseaudio;
{$ifdef FPC}{$mode objfpc}{$h+}{$endif}
interface
uses
 classes,mclasses,mseclasses,msethread,msetypes, uos_portaudio,
 msesys,msestrings;

type

pa_sample_spec = record
  format: shortint; //**< The sample format */
  rate: integer;             //**< The sample rate. (e.g. 44100) */
  channels: shortint;          //**< Audio channels. (1 for mono, 2 for stereo, ...) */
 end;
 ppa_sample_spec = ^pa_sample_spec;


 sampleformatty = (sfm_u8,sfm_8alaw,sfm_8ulaw,
                   sfm_s16,sfm_s24,sfm_s32,sfm_f32,smf_s2432,
                   sfm_s16le,sfm_s24le,sfm_s32le,sfm_f32le,smf_s2432le,
                   sfm_s16be,sfm_s24be,sfm_s32be,sfm_f32be,smf_s2432be);
const
 defaultsampleformat = sfm_f32;
 defaultsamplechannels = 2;
 defaultsamplerate = 44100;
 defaultlatency = 0.1;

type

 toutstreamthread = class(tmsethread)
 end;

 sendeventty = procedure(var data: pointer) of object;
                  //data =
                  //bytearty       (sfm_u8,sfm_8alaw,sfm_8ulaw,
                  //                sfm_s24,sfm_s24le,sfm_s24be)
                  //smallintarty   (sfm_s16,sfm_s16le,sfm_s16be)
                  //integerarty    (sfm_s32,smf_s2432,sfm_s32le,smf_s2432le,
                  //                sfm_s32be,smf_s2432be)
                  //or singlearty  (sfm_f32,sfm_f32le,sfm_f32be)

 erroreventty = procedure(const sender: tobject; const errorcode: integer;
                  const errortext: msestring) of object;

 tcustomaudioout = class(tmsecomponent)
  private
   fthread: toutstreamthread;
   fstacksizekb: integer;
   fonsend: sendeventty;
   fonerror: erroreventty;
   fserver: msestring;
   fdev: msestring;
   //fchannels: integer;
   frate: integer;
   flatency: real;
   procedure setactive(const avalue: boolean);
  protected
   factive: boolean;
   fformat: sampleformatty;
   fappname: msestring;
   fstreamname: msestring;
  //fpulsestream: ppa_simple;
   HandleSt:pointer;
   
   procedure initnames; virtual;
   procedure loaded; override;
   procedure run; virtual;
   procedure stop; virtual;
   function threadproc(sender: tmsethread): integer; virtual;
   procedure raiseerror(const aerror: integer);
   procedure doerror(const aerror: integer);
  public
   fchannels: integer;
   constructor create(aowner: tcomponent); override;
   destructor destroy; override;
//   function lock: boolean;
//   procedure unlock;
   procedure flush();
   procedure drain();

   property active: boolean read factive write setactive default false;
   property server: msestring read fserver write fserver;
   property dev: msestring read fdev write fdev;
   property appname: msestring read fappname write fappname;
   property streamname: msestring read fstreamname write fstreamname;
   property channels: integer read fchannels write fchannels
                                                 default defaultsamplechannels;
   property format: sampleformatty read fformat write fformat
                                              default defaultsampleformat;
   property rate: integer read frate write frate default defaultsamplerate;
   property stacksizekb: integer read fstacksizekb write fstacksizekb default 0;
   property latency: real read flatency write flatency;
           //seconds, 0 -> server default
   property onsend: sendeventty read fonsend write fonsend;
   property onerror: erroreventty read fonerror write fonerror;
 end;

 taudioout = class(tcustomaudioout)
  published
   property active;
   property server;
   property dev;
   property appname;
   property streamname;
   property channels;
   property format;
   property rate;
   property latency;
   property stacksizekb;
   property onsend;
   property onerror;
 end;
 
 var
 HandleSt: pointer; 
  
implementation
uses
 sysutils,msesysintf,mseapplication;

{ tcustomaudioout }

constructor tcustomaudioout.create(aowner: tcomponent);
var
PA_FileName, ordir, opath : string;
begin
// syserror(sys_mutexcreate(fmutex),self);
 fchannels:= defaultsamplechannels;
 fformat:= defaultsampleformat;
 frate:= defaultsamplerate;
 flatency:= defaultlatency;
 
    ordir := IncludeTrailingBackslash(ExtractFilePath(ParamStr(0)));

 {$IFDEF Windows}
     {$if defined(cpu64)}
    PA_FileName := ordir + 'lib\Windows\64bit\LibPortaudio-64.dll';
     {$else}
    PA_FileName := ordir + 'lib\Windows\32bit\LibPortaudio-32.dll';
     {$endif}
 {$ENDIF}

  {$if defined(CPUAMD64) and  defined(linux) }
    PA_FileName := ordir + 'lib/Linux/64bit/LibPortaudio-64.so';
  {$ENDIF}

  {$if defined(cpu86) and defined(linux)}
    PA_FileName := ordir + 'lib/Linux/32bit/LibPortaudio-32.so';
  {$ENDIF}

  {$if defined(linux) and defined(cpuarm)}
    PA_FileName := ordir + 'lib/Linux/arm_raspberrypi/libportaudio-arm.so';
  {$ENDIF}

  {$if defined(linux) and defined(cpuaarch64)}
  PA_FileName := ordir + 'lib/Linux/aarch64_raspberrypi/libportaudio_aarch64.so';
  {$ENDIF}

 {$IFDEF freebsd}
    {$if defined(cpu64)}
    PA_FileName := ordir + 'lib/FreeBSD/64bit/libportaudio-64.so';
    {$else}
    PA_FileName := ordir + 'lib/FreeBSD/32bit/libportaudio-32.so';
    {$endif}
  {$ENDIF}

 {$IFDEF Darwin}
  {$IFDEF CPU32}
    opath := ordir;
    opath := copy(opath, 1, Pos('/UOS', opath) - 1);
    PA_FileName := opath + '/lib/Mac/32bit/LibPortaudio-32.dylib';
    {$ENDIF}
  
   {$IFDEF CPU64}
    opath := ordir;
    opath := copy(opath, 1, Pos('/UOS', opath) - 1);
    PA_FileName := opath + '/lib/Mac/64bit/LibPortaudio-64.dylib';
    {$ENDIF}  
 {$ENDIF}
   
 if Pa_Load(pchar(PA_FileName)) then
 begin
  //sleep(10);
  Pa_Initialize();
  
 end;
 //writeln('OK Portaudio loaded') else 
 // writeln('OK Portaudio NOT loaded');
   
 inherited;
end;

destructor tcustomaudioout.destroy;
begin
 active:= false;
 inherited;
// sys_mutexdestroy(fmutex);
end;

procedure tcustomaudioout.flush();
begin
{
 if fpulsestream <> nil then begin
  pa_simple_flush(fpulsestream,nil);
 end;
 }
end;

procedure tcustomaudioout.drain();
begin
{
 if fpulsestream <> nil then begin
  pa_simple_drain(fpulsestream,nil);
 end;
 }
end;

procedure tcustomaudioout.setactive(const avalue: boolean);
begin
 if factive <> avalue then begin
  if componentstate * [csloading,csdesigning] = [] then begin
   if not avalue then begin
    stop;
   end
   else begin
    run;
   end;
  end
  else begin
   factive:= avalue;
  end;
 end;
end;

procedure tcustomaudioout.stop;
begin
 if fthread <> nil then begin
  fthread.terminate;
  application.waitforthread(fthread);
  freeandnil(fthread);
  Pa_StopStream(HandleSt);
  Pa_CloseStream(HandleSt);
  pa_unload;  
 end;
 factive:= false;
end;

procedure tcustomaudioout.run;
var
 PAParam: PaStreamParameters;
 err: integer;
 
begin
 PAParam.hostApiSpecificStreamInfo := nil;
 PAParam.device := Pa_GetDefaultOutputDevice();
 PAParam.SuggestedLatency :=  
     ((Pa_GetDeviceInfo(PAParam.device)^.   defaultHighOutputLatency)) * 1;
   
 flatency := PAParam.SuggestedLatency;
 
  //paFloat32;
  //paInt32;
  //paInt16;
  
   PAParam.channelCount := fchannels; 
   
    if fformat = sfm_s16 then
   PAParam.SampleFormat := paInt16
   else
   if fformat = sfm_s32 then
   PAParam.SampleFormat := paInt32
   else
   if fformat = sfm_f32 then
   PAParam.SampleFormat := paFloat32
   else
   PAParam.SampleFormat := paFloat32;
 
 //err := Pa_OpenStream(@HandleSt, nil, @PAParam,
 // 44100, 512, paClipOff, nil, nil);
     
 // err := Pa_OpenDefaultStream(@HandleSt, 2, 1, paFloat32,44100, 1024, nil, nil);
  
  err := Pa_OpenStream(@HandleSt, nil, @PAParam,
   44100, 512, paClipOff, nil, nil);
   
  application.processmessages;
   sleep(10);
 
    if HandleSt <> nil then Pa_StartStream(HandleSt)
   else  raiseerror(err);
  
  application.processmessages;
  sleep(10);
 
  fthread:= toutstreamthread.create({$ifdef FPC}@{$endif}threadproc,false,fstacksizekb);
  factive:= true;
end;

procedure tcustomaudioout.initnames;
begin
 //
end;

procedure tcustomaudioout.loaded;
begin
 inherited;
 if not (csdesigning in componentstate) then begin
  initnames;
  if factive and (fthread = nil) then begin
   run;
  end;
 end;
end;
{
function tcustomaudioout.lock: boolean;
begin
 result:= sys_mutexlock(fmutex) = sye_ok;
end;

procedure tcustomaudioout.unlock;
begin
 sys_mutexunlock(fmutex);
end;
}
function tcustomaudioout.threadproc(sender: tmsethread): integer;
var
 data: pointer;
 datasize: integer;
begin
 result:= 0;
 if canevent(tmethod(fonsend)) then begin
  factive:= true;
  datasize:= 4; // (float 32 bit)
  
  while not sender.terminated do begin
   data:= nil;
    fonsend(data);

   if data <> nil then begin
   
   if assigned(HandleSt) then
   Pa_WriteStream(HandleSt,
  @data, length(bytearty(data))*datasize);
  
   end;
  end;
 end;
end;

procedure tcustomaudioout.raiseerror(const aerror: integer);
begin
raise exception.create('Error');
end;

procedure tcustomaudioout.doerror(const aerror: integer);
begin
 application.lock;
 try
  if canevent(tmethod(fonerror)) then begin
   // fonerror(self,aerror,pa_strerror(aerror));
  end;
 finally
  application.unlock;
 end;
end;

end.
