@ECHO OFF
REM BFCPEOPTIONSTART
REM Advanced BAT to EXE Converter www.BatToExeConverter.com
REM BFCPEEXE=C:\Users\zonem\Documents\BatchScript Projects\random_stars.exe
REM BFCPEICON=
REM BFCPEICONINDEX=1
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
REM BFCPEWTITLE=Random Stars
REM BFCPEOPTIONEND
@echo off
mode con:cols=120 lines=30
rem CenterSelf
rem ClearColor
REM ADVANCED batch file: Random Stars Example 
REM This example requires a Window Size of 80x25 to look correct
rem PrintColorAt Enter a Number (99 to 999): 1 2 10 9
rem GetInput
rem MakeInteger %result%
Set myNumStarsVar=%result%
REM Keep variable in proper range (99 to 999)
REM This will return a 1 if entered number is greater than
REM or equal to 999
rem GreaterThan %myNumStarsVar% 999
If %result%==1 Set myNumStarsVar=999
rem LessThan %myNumStarsVar% 99
REM This returns a 1 if entered number is less than or equal to 99
If %result%==1 Set myNumStarsVar=99
rem ClearColor
Set myAddVar=0
rem CursorHide
:TestLoop
rem Add %myAddVar% 1
Set myAddVar=%result%
:Color1
REM Set a random color
rem GenRandom 15
Set myColor=%result%
If %myColor%==0 GoTo Color1
:YVar1
REM Batch file windows are 25 by 80 spaces
rem GenRandom 30
Set myYVar=%result%
If %myYVar%==0 GoTo YVar1
:XVar1
rem GenRandom 120
Set myXVar=%result%
If %myXVar%==0 GoTo XVar1
REM Print the X with white background and wait 20 milliseconds
REM then print black background for twinkle effect
rem PrintColorAt * %myYVar% %myXVar% %myColor% 15
rem Wait 20
rem PrintColorAt * %myYVar% %myXVar% %myColor% 0
rem PrintColorAt %myAddVar% of %myNumStarsVar% 2 2 10 9
rem GetPercent %myAddVar% %myNumStarsVar%
Set mPercent=%result%
rem LocateAt 2 12
rem ChangeColor 12 0
Echo %mPercent%%%
If %myAddVar%==%myNumStarsVar% goto Finish
goto TestLoop
:Finish
rem CursorShow
rem Locate 30 1
Pause
REM Clear screen and close window
rem ClearColor
Exit /B 0
