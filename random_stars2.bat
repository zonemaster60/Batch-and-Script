@ECHO OFF
REM BFCPEOPTIONSTART
REM Advanced BAT to EXE Converter www.BatToExeConverter.com
REM BFCPEEXE=C:\Users\zonem\Documents\BatchScript Projects\random_stars2.exe
REM BFCPEICON=
REM BFCPEICONINDEX=0
REM BFCPEEMBEDDISPLAY=0
REM BFCPEEMBEDDELETE=1
REM BFCPEADMINEXE=1
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
REM BFCPEWTITLE=Why not enjoy the colorful little stars while you wait! :)
REM BFCPEOPTIONEND
@Echo off
SETLOCAL EnableDelayedExpansion
mode con:cols=120 lines=30

If "%~1"=="" GoTo PreSet
If "%~2"=="" GoTo PreSet
Set numStars=%~1
Set waitTM=%~2
GoTo Start

:PreSet
Set numStars=999
Set waitTM=100

:Start
rem ClearColor
rem MakeInteger %numStars%
Set myNumStarsVar=%numStars%
REM Keep variable in proper range (199 to 1999)
REM This will return a 1 if entered number is greater than
REM or equal to 1999
rem GreaterThan %myNumStarsVar% 1999
If %result% EQU 1 Set myNumStarsVar=1999
rem LessThan %myNumStarsVar% 199
REM This returns a 1 if entered number is less than or equal to 199
If %result% EQU 1 Set myNumStarsVar=199
rem ClearColor
Set myAddVar=0
rem CursorHide

:StarLoop
rem Add %myAddVar% 1
Set myAddVar=%result%

:Color1
REM Set a random color
rem GenRandom 15
Set myColor=%result%
If %myColor% EQU 0 GoTo Color1

:YVar1
REM Batch file windows are 25 by 80 spaces
rem GenRandom 30
Set myYVar=%result%
If %myYVar% EQU 0 GoTo YVar1

:XVar1
rem GenRandom 120
Set myXVar=%result%
If %myXVar% EQU 0 GoTo XVar1
REM Print the X with white background and wait 20 milliseconds
REM then print black background for twinkle effect
rem PrintColorAt * %myYVar% %myXVar% %myColor% 15
rem Wait %waitTM%
rem PrintColorAt * %myYVar% %myXVar% %myColor% 0
rem PrintColorAt S:%myAddVar% of %myNumStarsVar% T:%waitTM% 2 2 10 8
rem GetPercent %myAddVar% %myNumStarsVar%
Set mPercent=%result%
rem ChangeColor 10 8
rem LocateAt 2 23
Echo %mPercent%%%
If %myAddVar% EQU %myNumStarsVar% GoTo Finish
GoTo StarLoop

:Finish
rem CursorShow
rem Locate 30 1
Pause
REM Clear screen and close window
rem ClearColor
Exit /B %ErrorLevel%
