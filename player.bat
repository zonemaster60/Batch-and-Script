@echo off
SETLOCAL
if "%~1" equ "" goto :usage
if "%~2" equ "" goto :usage

rem set variables here
Set pfad=D:\Apps\cmdplayer\cmdplayer.exe
Set path=D:\Music
Set volume=100

rem adjust for input
if "%~1" neq "" Set path=%1
if "%~2" neq "" Set volume=%2

rem run the player
Start %pfad% %path% /r /v%volume%
ENDLOCAL
exit /b 0

:usage
rem shows some help
Echo USAGE: %0 [Full_Path] [Volume 0-100]
Echo USAGE: %0 D:\Music\Nirvana 75
goto:eof