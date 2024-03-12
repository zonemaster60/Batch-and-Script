@ECHO OFF
REM BFCPEOPTIONSTART
REM Advanced BAT to EXE Converter www.BatToExeConverter.com
REM BFCPEEXE=C:\Users\zonem\Documents\BatchScript Projects\Game\Game.exe
REM BFCPEICON=
REM BFCPEICONINDEX=-1
REM BFCPEEMBEDDISPLAY=0
REM BFCPEEMBEDDELETE=1
REM BFCPEADMINEXE=0
REM BFCPEINVISEXE=0
REM BFCPEVERINCLUDE=0
REM BFCPEVERVERSION=1.0.0.0
REM BFCPEVERPRODUCT=Product Name
REM BFCPEVERDESC=Product Description
REM BFCPEVERCOMPANY=Your Company
REM BFCPEVERCOPYRIGHT=Copyright Info
REM BFCPEWINDOWCENTER=1
REM BFCPEDISABLEQE=0
REM BFCPEWINDOWHEIGHT=25
REM BFCPEWINDOWWIDTH=80
REM BFCPEWTITLE=Window Title
REM BFCPEOPTIONEND
@echo off
SETLOCAL EnableExtensions

Set version=0.0.0.1
Set schcol1=3
Set schcol2=11
Set txtbg=8
Set btntime=200
Set waittime=5000

Call :show_title 0 0
rem PaintBoxAt 5 5 1 6 10
Call :wait_time
Exit /B %ErrorLevel%

rem display the title section
rem *************************
:show_title
rem ClearColor
rem PaintScreen %1
rem PrintColorAt "Game v%version%]=-" 1 23 7 8
If %2 EQU 1 ( 
rem PrintColorAt "David Scouten (c2023) zonemaster@yahoo.com" 25 20 7 8
)
rem CursorHide
GOTO:EOF

rem time out for menus
rem ******************
:wait_time
Set wtime=5
:Loop1
rem PrintColorAt "[Please wait for %wtime% seconds]" 25 27 %schcol2% 8
rem Wait %newtime2%
rem PrintColorAt "[Please wait for %wtime% seconds]" 25 27 %schcol1% 8
rem Wait %newtime2%
Set /a wtime-=1
If %wtime% LSS 1 GoTo wFin1
GoTo Loop1
:wFin1
GOTO:EOF

:do_the_math
rem datatime = btntime / 2
rem **********************
Set /a datatime=btntime / 2

rem newtime = waittime / 5
rem **********************
Set /a newtime=waittime / 5

rem newtime2 = newtime / 2
rem **********************
Set /a newtime2=newtime / 2

rem wshutdown = (waittime * 2) / 1000
rem *********************************
Set /a wshutdown=(waittime * 2) / 1000
GOTO:EOF
