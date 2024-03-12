@ECHO OFF
REM BFCPEOPTIONSTART
REM Advanced BAT to EXE Converter www.BatToExeConverter.com
REM BFCPEEXE=C:\Users\zonem\Documents\BatchScript Projects\2caf\Lite\2CAF_Lite.exe
REM BFCPEICON=D:\Develop\Advanced BAT to EXE Converter PRO\ab2econv461pro\icons\icon3.ico
REM BFCPEICONINDEX=-1
REM BFCPEEMBEDDISPLAY=0
REM BFCPEEMBEDDELETE=1
REM BFCPEADMINEXE=1
REM BFCPEINVISEXE=0
REM BFCPEVERINCLUDE=1
REM BFCPEVERVERSION=0.4.3.8
REM BFCPEVERPRODUCT=2Click Auto Fixer Lite
REM BFCPEVERDESC=Uses Dism/Sfc to fix file corruption
REM BFCPEVERCOMPANY=ZoneSoft
REM BFCPEVERCOPYRIGHT=David Scouten (2023)
REM BFCPEWINDOWCENTER=1
REM BFCPEDISABLEQE=0
REM BFCPEWINDOWHEIGHT=25
REM BFCPEWINDOWWIDTH=80
REM BFCPEWTITLE=
REM BFCPEOPTIONEND
@echo off
SETLOCAL
rem mode con:cols=80 lines=25
mode con:cols=120 lines=30

rem ******************************************
rem David Scouten (c2023) zonemaster@yahoo.com
rem ******************************************

Set version=0.4.3.8
Title 2Click Auto Fixer Lite v%version%

:wMenu
Call :_title

echo: --- Menu ---
Echo:
echo: 1) Scan
echo: 2) Fix
echo: 3) Exit
echo:
echo: ------------
echo:
Choice /C 123 /T 10 /D 1 /M "Please Select:"
If %ErrorLevel%==1 GoTo wScan
If %ErrorLevel%==2 GoTo wFix
If %ErrorLevel%==3 GoTo wExit
GoTo wMenu

:wScan
Call :_chkdsk
Call :_title

echo: Scan: Stage-1
echo:
Call :_run_command "dism /online /cleanup-image /analyzecomponentstore"

Call :_title

echo: Scan: Stage-2
echo:
Call :_run_command "dism /online /cleanup-image /scanhealth"

Call :_title

echo: Scan: Stage-3
echo:
Call :_run_command "sfc /verifyonly"

Choice /C yn /T 10 /D y /M "Fix System Now:"
If %ErrorLevel%==1 GoTo wFix
If %ErrorLevel%==2 GoTo wMenu
GoTo wMenu

:wFix
Call :_chkdsk
Call :_title

echo: Fix: Stage-1
echo:
Call :_run_command "dism /online /cleanup-image /startcomponentcleanup"

Call :_title

echo: Fix: Stage-2
echo:
Call :_run_command "dism /online /cleanup-image /restorehealth"

Call :_title

echo: Fix: Stage-3
echo:
Call :_run_command "sfc /scannow"

Choice /C yn /T 10 /D y /M "Reboot System Now:"
If %ErrorLevel%==1 GoTo wReboot
If %ErrorLevel%==2 GoTo wMenu
GoTo wMenu

:wReboot
Call :_title

echo: Please Wait...
echo:
echo: Rebooting System in 10 Seconds

ENDLOCAL

Call :_run_command "shutdown /r /t 10"
GoTo wExit

:wExit
Call :_title
echo: Good Bye!
Timeout /T 5
ENDLOCAL
Exit /B %ErrorLevel%

:_chkdsk
Call :_title
echo: ChkDsk - Online Scan
echo:
Call :_run_command "chkdsk %systemdrive% /scan"
GoTo :EOF

:_title
Cls
echo: 2Click Auto Fixer Lite v%version%
echo:
GoTo :EOF

:_run_command
echo: %1
echo:
Cmd /c %1 && (
  echo:
  echo: %1 Success
) || (
  echo:
  echo: %1 Fail
)
Timeout /t 5
GoTo :EOF