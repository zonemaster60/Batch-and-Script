@ECHO OFF
REM BFCPEOPTIONSTART
REM Advanced BAT to EXE Converter www.BatToExeConverter.com
REM BFCPEEXE=C:\Users\zonem\Downloads\MountLatestShadowCopy.exe
REM BFCPEICON=D:\Develop\Advanced BAT to EXE Converter PRO v4.59\ab2econv459pro\icons\icon11.ico
REM BFCPEICONINDEX=1
REM BFCPEEMBEDDISPLAY=0
REM BFCPEEMBEDDELETE=1
REM BFCPEADMINEXE=1
REM BFCPEINVISEXE=0
REM BFCPEVERINCLUDE=1
REM BFCPEVERVERSION=1.0.0.0
REM BFCPEVERPRODUCT=MountLatestShadowCopy.exe
REM BFCPEVERDESC=Jason Faulkners MountLatestShadowCopy
REM BFCPEVERCOMPANY=Jason Faulkner
REM BFCPEVERCOPYRIGHT=Copyright (2012) Jason Faulkner
REM BFCPEWINDOWCENTER=1
REM BFCPEDISABLEQE=0
REM BFCPEWINDOWHEIGHT=25
REM BFCPEWINDOWWIDTH=80
REM BFCPEWTITLE=Mount Latest Shadow Copy
REM BFCPEOPTIONEND
@ECHO OFF
IF NOT "%~1" == "/?" GOTO Main

ECHO Mount Latest Shadow Copy [v1.0]
ECHO Locates the most recent Windows file shadow copy and mounts it to the
ECHO specified directory.
ECHO Copyright (c) 2012, Jason Faulkner - All rights reserved.
ECHO.
ECHO %~n0 MountToFolder [SearchDrive]
ECHO.
ECHO  MountToFolder  Folder location where the shadow copy contents will be made
ECHO                 available. This folder should NOT exist; it will be created
ECHO                 as a mount point and accessible after the operation completes.
ECHO                 Important Note: The target specified should end with 
ECHO                 a \ character to ensure it is properly read as a directory.
ECHO                 For example: C:\MyShadowCopy\
ECHO  SearchDrive    Specifies the local drive for which you want to mount the
ECHO                 latest shadow copy. Enter with a colon following the drive
ECHO                 letter. Default value is C:.
ECHO.
ECHO Note: This script MUST be run as Administrator (with highest priviledges in a
ECHO       scheduled task) in order to work properly.
ECHO.
ECHO Requirements:
ECHO.
ECHO  Windows Vista or later with System Restore enabled.
ECHO.
ECHO ____________________________________________________
ECHO.
ECHO Visit my website for additional information, examples and updates.
ECHO http://www.jasonfaulkner.com
GOTO :EOF

:Main
SETLOCAL EnableExtensions

CALL :Initialize
CALL :Configuration %*
CALL :CheckRequirements
IF %ERRORLEVEL% GTR 0 GOTO Finish
CALL :PrepSettings 
IF %ERRORLEVEL% GTR 0 GOTO Finish

REM Pull the shadow copy listing.
VSSAdmin List Shadows %SearchDrive% > %TempFile%

SET ShadowPath=
REM Pull the latest shadow copy from the listing.
FOR /F "usebackq tokens=1,2* delims=:" %%A IN (`FINDSTR /I /C:"Shadow Copy Volume:" %TempFile%`) DO SET ShadowPath=%%B

IF NOT "%ShadowPath%" == "" (
	REM A shadow copy was found, mount it.
	MKLINK /D "%MountFolder%" %ShadowPath%\
) ELSE (
	ECHO No Shadow Copies found.
)

:Finish
IF EXIST %TempFile% DEL %TempFile%
ENDLOCAL
GOTO :EOF

:Initialize
SET MountFolder=
SET SearchDrive=C:
SET TempFile="%TEMP%\%~n0_%RANDOM%.txt"
GOTO :EOF

:Configuration
IF /I "%~1" == "" GOTO InvalidParams
SET MountFolder=%~dp1
IF NOT "%~2" == "" SET SearchDrive=%~2
GOTO :EOF

:PrepSettings
IF EXIST "%MountFolder%" (
	ECHO Mount Folder: %MountFolder%
	ECHO The specified folder already exists. Enter a new folder for the mount target.
	GOTO InvalidParams
)
IF NOT "%SearchDrive%" == "" SET SearchDrive=/FOR=%SearchDrive%
GOTO :EOF

:CheckRequirements
CALL :VerifyRequirement "vssadmin.exe"
GOTO :EOF

:VerifyRequirement
IF EXIST "%~1" GOTO :EOF
IF NOT "%~$PATH:1" == "" GOTO :EOF
ECHO Missing requirement: [%~1] Use /? to view the help information.
EXIT /B 2

:InvalidParams
ECHO Invalid parameters. Use /? to view the help information.
EXIT /B 1