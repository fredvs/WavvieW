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
 classes,mclasses,mseclasses,msethread,msetypes, uos_portaudio, uos_libsndfile,
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
   HandlePA:pointer;
   HandleSF:pointer;
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
 
function uos_mseLoadLib(PA_FileName, SF_FileName : string): integer;
function uos_mseUnLoadLib(): integer;

   
implementation
uses
 sysutils,msesysintf,mseapplication;
 
function uos_mseLoadLib(PA_FileName, SF_FileName : string): integer;
begin
 if Pa_Load(pchar(PA_FileName)) then
 begin
  Pa_Initialize();
 end;
 
 Sf_Load(SF_FileName); 
end; 

function uos_mseUnLoadLib(): integer;
begin
sf_Unload();
pa_unload; 
end;

{ tcustomaudioout }

constructor tcustomaudioout.create(aowner: tcomponent);
begin
// syserror(sys_mutexcreate(fmutex),self);
 fchannels:= defaultsamplechannels;
 fformat:= defaultsampleformat;
 frate:= defaultsamplerate;
 flatency:= defaultlatency;
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
  Pa_StopStream(HandlePA);
  Pa_CloseStream(HandlePA);
  sf_close(HandleSF); 
  end;
 factive:= false;
end;

procedure tcustomaudioout.run;
var
 PAParam: PaStreamParameters;
 err: integer;
 sfInfo: TSF_INFO;
 SoundFilename, ordir : string;
 parate : single;
 
begin
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
   
   if assigned(HandlePA) then
   Pa_WriteStream(HandlePA,
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
