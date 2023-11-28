# ctasklist
cmd tool, allow list / find a running process, or kill them.
Use it in your custom bat files.

Usage: 
<code>
CTaskList IMAGENAME [EXEPATH] [options]
EXEPATH = Process file name including path.
[options]
/F -> Find Process
/L -> List Process
/K -> Kill Process
/V -> Verbose
</code>


**Example1 in batch file.**
<code>
@echo off
:start
ctasklist.exe IMAGENAME "C:\windows\system32\NOTEPAD.EXE" /F
echo ERROR LEVEL = %ERRORLEVEL%
if "%ERRORLEVEL%"=="0" (
Echo PROCESS FINDED
timeout /T 10 /nobreak > nul
goto :start
)
Echo PROCESS NOT FINDED
Echo SEARCHING AGAIN
timeout /T 10 /nobreak > nul
goto :start
</code>

**Example2 in batch file, search and kill process**
<code>
@echo off
:start
ctasklist.exe IMAGENAME "C:\windows\system32\NOTEPAD.EXE" /F
echo ERROR LEVEL = %ERRORLEVEL%
if "%ERRORLEVEL%"=="0" (
Echo PROCESS FINDED
goto :kill
)
Echo PROCESS NOT FINDED
Echo SEARCHING AGAIN
timeout /T 10 /nobreak > nul
goto :start
:kill
ctasklist.exe IMAGENAME "C:\windows\system32\NOTEPAD.EXE" /K
Echo PROCESS KILLED
</code>


