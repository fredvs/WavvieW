program wavview;
{$ifdef FPC}{$mode objfpc}{$h+}{$endif}
{$ifdef FPC}
 {$ifdef mswindows}{$apptype gui}{$endif}
{$endif}
uses
 {$ifdef FPC}{$ifdef unix}cthreads,{$endif}{$endif} 
 msegui,about, main;
begin
 application.createform(tmainfo,mainfo);
 application.createform(taboutfo,aboutfo);
 application.run;
end.
