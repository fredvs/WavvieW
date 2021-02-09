unit about;
{$ifdef FPC}{$mode objfpc}{$h+}{$endif}
interface
uses
 msetypes, mseglob, mseguiglob, mseguiintf, mseapplication, msestat, msemenus,
  msegui,msegraphics, msegraphutils, mseevent, mseclasses, msewidgets, mseforms,
  mseact, msedataedits, msedropdownlist, mseedit, mseificomp, mseificompglob,
  mseifiglob, msestatfile, msestream, sysutils;
type
 taboutfo = class(tmseform)
   about_text: tmemoedit;
 end;
var
 aboutfo: taboutfo;
implementation
uses
 about_mfm;
end.
