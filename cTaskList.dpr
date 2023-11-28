program cTaskList;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,JclSysInfo,system.Classes;

var PList:Tstringlist;
    Exepath:string;
    find:boolean;
    Listar:boolean;
    kILL:BOOLEAN;
    Pid:LongInt;
    v:boolean;


procedure InfoHelp;
Begin
  WriteLn('CTaskList V1.0 By Greison');
  WriteLn('--------------------------');
  writeln('Ussage:');
  WriteLn('CTaskList IMAGENAME <EXEPATH> [options]');
  WriteLn('[options]');
  WriteLn('/F -> Find Process');
  WriteLn('/L -> List Process');
  WriteLn('/K -> Kill Process');
  WriteLn('/V -> Verbose');

end;


procedure ShowParams;
var i:integer;
Begin
  For i := 1 to ParamCount do begin
    Writeln(ParamStr(i));
  end;
end;


Function DoSearchProceess:LongInt;
var x:integer;
    sal:boolean;
Begin
  result:=0;
  sal:=false;
  x:=0;
  if V then Writeln('Finding process '+Exepath);
  RunningProcessesList(Plist,true);
  while (x<Plist.Count) and (not sal) do begin
    if uppercase(plist[x])=Uppercase(Exepath) then Begin
        Result:=LongInt(Plist.Objects[x]);
        if V then Writeln('Process running');
        Sal:=true;
    end;
    inc(x);
  end;
  if (not sal) then
    if V then Writeln('Process not found');
End;


Procedure DoListProceess;
var x:integer;
Begin
  x:=0;
  if V then Writeln('Listing process ');
  RunningProcessesList(Plist,true);
  while (x<Plist.Count)  do begin
    Writeln('['+inttostr(LongInt(Plist.Objects[x]))+'] ' +PList[x]);
    inc(x);
  end;
  if V then Writeln('End Listing process ');

End;


procedure CheckParams;
var i:integer;
Begin
  i:=1;
  find:=false;
  while (i<=Paramcount) do Begin

    if UpperCase(ParamStr(i))='IMAGENAME' Then Begin
        inc(i);
        exepath:=UpperCase(ParamStr(i));
        inc(i);
    End
    else
    if UpperCase(ParamStr(i))='/V' Then Begin
      V:=true;
      inc(i);
    End
    Else
    if UpperCase(ParamStr(i))='/F' Then Begin
      find:=true;
      inc(i);
    End
    else
    if UpperCase(ParamStr(i))='/L' Then Begin
      Listar:=true;
      inc(i);
    End
    else
    if UpperCase(ParamStr(i))='/K' Then Begin
      kILL:=true;
      inc(i);
    End
    else
    inc(i);
  end;
end;


begin

  try
    { TODO -oUser -cConsole Main : Insert code here }
    Plist:=TStringList.Create;
    //Writeln('Parameters count '+inttostr(ParamCount));
    //ShowParams;
    if ParamCount>=1 then Begin
      CheckParams;
      if (find) OR (kILL) or (Listar) then bEGIN
          if (Find) then Begin
             If (DoSearchProceess<>0) then
               System.ExitCode:=0
             Else
               System.ExitCode:=1;
          End
          else
          if (Listar) then Begin
              DoListProceess;
              System.ExitCode:=0;
          End
          else
          if (kill) then Begin
              Pid:=DoSearchProceess;
              if (Pid<>0) then Begin
                    if V then Writeln('Killing process PID ['+INTTOSTR(PID)+']');
                    TerminateApp(pid,1000);
                    if V then Writeln('Process Terminated');
                    System.ExitCode:=0;
              End
              else Begin
                System.ExitCode:=0;
              End;
          End;
      End
      Else
        System.ExitCode:=1;
    End
    else Begin
      InfoHelp;
      System.ExitCode:=1;
    End;



  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
  PList.Free;
end.
