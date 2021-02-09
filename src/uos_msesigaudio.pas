{ MSEgui Copyright (c) 2010-2013 by Martin Schreiber

    See the file COPYING.MSE, included in this distribution,
    for details about the copyright.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
}
unit uos_msesigaudio;

{$ifdef FPC}{$mode objfpc}{$h+}{$endif}
interface

{$ifndef mse_allwarnings}
 {$if fpc_fullversion >= 030100}
  {$warn 5089 off}
  {$warn 5090 off}
  {$warn 5093 off}
  {$warn 6058 off}
 {$endif}
 {$if fpc_fullversion >= 030300}
  {$warn 6018 off}
 {$endif}
{$endif}
uses
  uos_mseaudio,
  uos_portaudio,
  msesignal,
  uos_libsndfile,
  Classes,
  mclasses,
  msethread,
  msetypes,
  msestrings;

const
  defaultblocksize = 1000;


type
  tsigoutaudio = class;

  tsigaudioout = class(tcustomaudioout)
  private
  protected
    fsigout: tsigoutaudio;
    fblocksize: integer;
    fbuffer: bytearty;
    fbuffer2: array of single;
    function threadproc(Sender: tmsethread): integer; override;
    procedure run; override;
    procedure stop; override;
    procedure initnames; override;
  public
    constructor Create(const aowner: tsigoutaudio); reintroduce;
  published
    property blocksize: integer read fblocksize write fblocksize default defaultblocksize;
    property active;
    property server;
    property dev;
    property appname;
    property streamname;
    //   property channels;
    property format;
    property rate;
    property latency;
    property stacksizekb;
    //   property onsend;
    //   property onerror;

  end;

  tsigoutaudio = class(tsigmultiinp)
  private
    faudio: tsigaudioout;
    fbuffer: doublearty;
    fbufpo: pdouble;
    procedure setaudio(const avalue: tsigaudioout);
  protected
    //isigclient
    function gethandler: sighandlerprocty; override;
    procedure sighandler(const ainfo: psighandlerinfoty);
  public
    constructor Create(aowner: TComponent); override;
    destructor Destroy; override;
  published
    property audio: tsigaudioout read faudio write setaudio;
  end;

var
  fbuffer3: array of single;
// fbuffer2: bytearty; 


implementation

uses
  msesysintf,
  SysUtils{$ifndef FPC},classes_del{$endif};

{$ifndef mse_allwarnings}
 {$if fpc_fullversion >= 030100}
  {$warn 5089 off}
  {$warn 5090 off}
  {$warn 5093 off}
  {$warn 6058 off}
 {$endif}
 {$if fpc_fullversion >= 030300}
  {$warn 6018 off}
 {$endif}
{$endif}

{ tsigaudioout }

constructor tsigaudioout.Create(const aowner: tsigoutaudio);
begin
  fblocksize := defaultblocksize;
  fsigout    := aowner;
  inherited Create(aowner);
  setsubcomponent(True);
end;

type
  convertinfoty = record
    Source: pdouble;
    dest: Pointer;
    valuehigh: integer;
  end;
  convertprocty = procedure(var info: convertinfoty);

procedure convert8(var info: convertinfoty);
var
  int1: integer;
  do1: double;
begin
  with info do
    for int1 := valuehigh downto 0 do
    begin
      do1   := Source^;
      if do1 > 1 then
        do1 := 1;
      if do1 < -1 then
        do1 := -1;
      pbyte(dest)^ := $80 + round(do1 * $7f);
      Inc(Source);
      Inc(pbyte(dest));
    end;
end;

procedure convert16(var info: convertinfoty);
var
  int1: integer;
  do1: double;
begin
  with info do
    for int1 := valuehigh downto 0 do
    begin
      do1   := Source^;
      if do1 > 1 then
        do1 := 1;
      if do1 < -1 then
        do1 := -1;
      psmallint(dest)^ := round(do1 * $7fff);
      psmallint(dest)^ := round(do1);
      Inc(Source);
      Inc(psmallint(dest));
    end;
end;

procedure convert24(var info: convertinfoty);
var
  int1: integer;
  do1: double;
  int2: integer;
begin
  with info do
    for int1 := valuehigh downto 0 do
    begin
      do1   := Source^;
      if do1 > 1 then
        do1 := 1;
      if do1 < -1 then
        do1 := -1;
      int2 := round(do1 * $7fffff);
  {$ifdef FPC}
      pbyte(dest)[0] := pbyte(@int2)[0];
      pbyte(dest)[1] := pbyte(@int2)[1];
      pbyte(dest)[2] := pbyte(@int2)[2];
  {$else}
   pchar(dest)[0]:= pchar(@int2)[0];
   pchar(dest)[1]:= pchar(@int2)[1];
   pchar(dest)[2]:= pchar(@int2)[2];
  {$endif}
      Inc(Source);
      Inc(pbyte(dest), 3);
    end;
end;

procedure convert32(var info: convertinfoty);
var
  int1: integer;
  do1: double;
begin
  with info do
    for int1 := valuehigh downto 0 do
    begin
      do1   := Source^;
      if do1 > 1 then
        do1 := 1;
      if do1 < -1 then
        do1 := -1;
      pinteger(dest)^ := round(do1 * $7fffffff);
      Inc(Source);
      Inc(pinteger(dest));
    end;
end;

procedure convert32f(var info: convertinfoty);
var
  int1: integer;
begin
  with info do
    for int1 := valuehigh downto 0 do
    begin
      psingle(dest)^ := Source^;
      Inc(Source);
      Inc(psingle(dest));
    end;
end;

procedure convert2432(var info: convertinfoty);
var
  int1: integer;
  do1: double;
begin
  with info do
    for int1 := valuehigh downto 0 do
    begin
      do1   := Source^;
      if do1 > 1 then
        do1 := 1;
      if do1 < -1 then
        do1 := -1;
      pinteger(dest)^ := round(do1 * $7fffff);
      Inc(Source);
      Inc(pinteger(dest));
    end;
end;

procedure convert16swap(var info: convertinfoty);
var
  int1: integer;
  do1: double;
begin
  with info do
    for int1 := valuehigh downto 0 do
    begin
      do1   := Source^;
      if do1 > 1 then
        do1 := 1;
      if do1 < -1 then
        do1 := -1;
      psmallint(dest)^ := swapendian(smallint(round(do1 * $7fff)));
      Inc(Source);
      Inc(psmallint(dest));
    end;
end;

procedure convert24swap(var info: convertinfoty);
var
  int1: integer;
  do1: double;
  int2: integer;
begin
  with info do
    for int1 := valuehigh downto 0 do
    begin
      do1   := Source^;
      if do1 > 1 then
        do1 := 1;
      if do1 < -1 then
        do1 := -1;
      int2 := round(do1 * $7fffff);
  {$ifdef FPC}
      pbyte(dest)[0] := pbyte(@int2)[2];
      pbyte(dest)[1] := pbyte(@int2)[1];
      pbyte(dest)[2] := pbyte(@int2)[0];
  {$else}
   pchar(dest)[0]:= pchar(@int2)[2];
   pchar(dest)[1]:= pchar(@int2)[1];
   pchar(dest)[2]:= pchar(@int2)[0];
  {$endif}
      Inc(Source);
      Inc(pbyte(dest), 3);
    end;
end;

procedure convert32swap(var info: convertinfoty);
var
  int1: integer;
  do1: double;
begin
  with info do
    for int1 := valuehigh downto 0 do
    begin
      do1   := Source^;
      if do1 > 1 then
        do1 := 1;
      if do1 < -1 then
        do1 := -1;
      pinteger(dest)^ := swapendian(integer(round(do1 * $7fffffff)));
      Inc(Source);
      Inc(pinteger(dest));
    end;
end;

procedure convert32fswap(var info: convertinfoty);
var
  int1: integer;
  si1: single;
begin
  with info do
    for int1 := valuehigh downto 0 do
    begin
 {$ifdef FPC}
      si1 := single(Source^);
 {$else}
   si1:= source^;
 {$endif}
      plongword(dest)^ := swapendian(longword(plongword(@si1)^));
      Inc(Source);
      Inc(psingle(dest));
    end;
end;

procedure convert2432swap(var info: convertinfoty);
var
  int1: integer;
  do1: double;
begin
  with info do
    for int1 := valuehigh downto 0 do
    begin
      do1   := Source^;
      if do1 > 1 then
        do1 := 1;
      if do1 < -1 then
        do1 := -1;
      pinteger(dest)^ := swapendian(integer(round(do1 * $7fffff)));
      Inc(Source);
      Inc(pinteger(dest));
    end;
end;

function tsigaudioout.threadproc(Sender: tmsethread): integer;
var
  // data: pointer;
  int1, i: integer;
  datasize1, blocksize1, bufferlength1, valuehigh1: integer;
  controller1: tsigcontroller;
  // po1: pointer;
  // po2: pdouble;
  // do1: double;
  convert: convertprocty;
  info: convertinfoty;
  sfInfo: TSF_INFO;
  aarray: array of single;
begin
  Result      := 0;
  controller1 := fsigout.controller;


  if controller1 <> nil then
  begin
    factive    := True;
    if controller1.inputtype = 1 then
      HandleSF := sf_open(controller1.SoundFilename, SFM_READ, sfInfo)//writeln(' name ' +controller1.SoundFilename);
      //  channels := SFinfo.channels;
      // Length := sfInfo.frames;
      //  frames := SFinfo.frames;
      // samplerate := SFinfo.samplerate;
      //controller1.FRate := SFinfo.samplerate ;   
    ;

    //datasize1:= samplebuffersizematrix[fformat];
    if fformat = sfm_s16 then
      datasize1 := 2
    else if fformat = sfm_s32 then
      datasize1 := 4
    else if fformat = sfm_f32 then
      datasize1 := 4
    else
      datasize1 := 4;

    blocksize1     := fblocksize;
    valuehigh1     := fsigout.inputs.Count * blocksize1;
    bufferlength1  := datasize1 * valuehigh1;
    Dec(valuehigh1);
    info.valuehigh := valuehigh1;
    setlength(fbuffer, bufferlength1);
    setlength(fbuffer2, bufferlength1 * datasize1);
    setlength(fbuffer3, bufferlength1 * datasize1);
    setlength(aarray, bufferlength1 * datasize1);

    case fformat of
      sfm_u8, sfm_8alaw, sfm_8ulaw: convert := @convert8;
      sfm_s16
{$ifdef endian_little},sfm_s16le{$else}
        , sfm_s16be
{$endif}
        : convert          := @convert16;
      sfm_s24
{$ifdef endian_little},sfm_s24le{$else}
        , sfm_s24be
{$endif}
        : convert          := @convert24;
      sfm_s32
{$ifdef endian_little},sfm_s32le{$else}
        , sfm_s32be
{$endif}
        : convert          := @convert32;
      sfm_f32
{$ifdef endian_little},sfm_f32le{$else}
        , sfm_f32be
{$endif}
        : convert          := @convert32f;
      smf_s2432
{$ifdef endian_little},smf_s2432le{$else}
        , smf_s2432be
{$endif}
        : convert          := @convert2432;
 {$ifdef endian_little}
   sfm_s16be: begin
    convert:= @convert16swap;
   end;
   sfm_s24be: begin
    convert:= @convert24swap;
   end;
   sfm_s32be: begin
    convert:= @convert32swap;
   end;
   sfm_f32be: begin
    convert:= @convert32fswap;
   end;
   smf_s2432be: begin
    convert:= @convert2432swap;
   end;
 {$else}
      sfm_s16le: convert   := @convert16swap;
      sfm_s24le: convert   := @convert24swap;
      sfm_s32le: convert   := @convert32swap;
      sfm_f32le: convert   := @convert32fswap;
      smf_s2432le: convert := @convert2432swap;
 {$endif}
      else Exit;
    end;

    while not Sender.terminated do
    begin

      //  writeln(' name ' +controller1.SoundFilename);  

      controller1.lock;
      try
        //{

        if (controller1.inputtype = 1) and (HandleSF <> nil) then
        begin
          if fformat = sfm_s16 then
            sf_read_short(HandleSF, @fsigout.fbuffer[0], length(fsigout.fbuffer) div fchannels div datasize1)
          else if fformat = sfm_s32 then
            sf_read_int(HandleSF, @fbuffer2[0], length(fbuffer2) div datasize1 div fchannels div datasize1)
          else if fformat = sfm_f32 then
          begin
            if HandleSF <> nil then
              sf_read_float(HandleSF, @fbuffer2[0], length(fbuffer2) div fchannels div datasize1);
          end
          else
            sf_read_float(HandleSF, @fbuffer2[0], length(fbuffer2) div fchannels div datasize1);

          fbuffer3 := fbuffer2;
        end;

        fsigout.fbufpo := Pointer(fsigout.fbuffer);
        controller1.step(blocksize1);

        info.Source := Pointer(fsigout.fbuffer);
        info.dest   := Pointer(fbuffer);
        convert(info);
      finally
        controller1.unlock;
      end;

      //  writeln(inttostr(controller1.inputtype));

      if Assigned(HandlePA) then
      begin
        if controller1.inputtype = 0 then
          Pa_WriteStream(HandlePA, @fBuffer[0], length(fbuffer) div datasize1 div fchannels);

        if controller1.inputtype = 1 then
          Pa_WriteStream(HandlePA, @fbuffer2[0], length(fbuffer2) div datasize1 div fchannels);

      end
      else
        break;

    end;
  end;
end;

procedure tsigaudioout.run;
var
  int1: integer;
begin
  int1     := fsigout.inputs.Count;
  channels := int1;
  setlength(fsigout.fbuffer, int1 * fblocksize);
  setlength(fbuffer2, int1 * fblocksize);
  inherited;
end;

procedure tsigaudioout.stop;
begin
  inherited;
  fsigout.fbufpo := nil;
end;

procedure tsigaudioout.initnames;
begin
  inherited;
  if fstreamname = '' then
    fstreamname := msestring(fsigout.Name);
end;

{ tsigoutaudio }

constructor tsigoutaudio.Create(aowner: TComponent);
begin
  faudio := tsigaudioout.Create(self);
  inherited;
  // finputs:= taudioinpconnarrayprop.create(self);
end;

destructor tsigoutaudio.Destroy;
begin
  faudio.Free;
  inherited;
  // finputs.free;
end;

{
procedure tsigoutaudio.setinputs(const avalue: taudioinpconnarrayprop);
begin
 finputs.assign(avalue);
end;
}
procedure tsigoutaudio.setaudio(const avalue: tsigaudioout);
begin
  faudio.Assign(avalue);
end;

function tsigoutaudio.gethandler: sighandlerprocty;
begin
  Result :=
{$ifdef FPC}
    @
{$endif}
    sighandler;
end;

procedure tsigoutaudio.sighandler(const ainfo: psighandlerinfoty);
var
  int1: integer;
begin
  if fbufpo <> nil then
    for int1 := 0 to finphigh do
    begin
      fbufpo^ := finps[int1]^.Value;
      Inc(fbufpo);
    end;
end;

end.

