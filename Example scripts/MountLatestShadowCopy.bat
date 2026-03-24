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
REM Maintenance notes:
REM - v1.0.0.1 tightened quoting, validation, and error handling.
REM - v1.0.0.2 simplified shadow copy parsing for better cmd.exe compatibility.
REM - v1.0.0.3 adds a validation-only mode and keeps runtime-only checks separate.
IF /I NOT "%~1"=="/?" GOTO Main

ECHO Mount Latest Shadow Copy [v1.0.0.3]
ECHO Locates the most recent Windows file shadow copy and mounts it to the
ECHO specified directory.
ECHO Copyright (c) 2012, Jason Faulkner - All rights reserved.
ECHO.
ECHO %~n0 MountToFolder [SearchDrive]
ECHO %~n0 /TEST MountToFolder [SearchDrive]
ECHO.
ECHO  MountToFolder  Folder location where the shadow copy contents will be made
ECHO                 available. This folder should NOT exist; it will be created
ECHO                 as a symbolic link and accessible after the operation completes.
ECHO                 A trailing \ is optional.
ECHO                 For example: C:\MyShadowCopy
ECHO  SearchDrive    Specifies the local drive for which you want to mount the
ECHO                 latest shadow copy. Enter with a colon following the drive
ECHO                 letter. Default value is C:.
ECHO  /TEST          Validates parameters and environment assumptions without
ECHO                 calling VSSAdmin or creating the symbolic link.
ECHO.
ECHO Note: This script MUST be run as Administrator (with highest privileges in a
ECHO       scheduled task) in order to work properly.
ECHO.
ECHO Requirements:
ECHO.
ECHO  Windows Vista or later with System Restore enabled.
ECHO ____________________________________________________
ECHO.
ECHO Visit my website for additional information, examples and updates.
ECHO http://www.jasonfaulkner.com
GOTO :EOF

:Main
SETLOCAL EnableExtensions DisableDelayedExpansion
SET "ExitCode=0"

CALL :Initialize
CALL :Configuration "%~1" "%~2" "%~3" "%~4"
IF ERRORLEVEL 1 (
	SET "ExitCode=1"
	GOTO Finish
)

CALL :PrepSettings
IF ERRORLEVEL 1 (
	SET "ExitCode=1"
	GOTO Finish
)


IF "%ValidateOnly%"=="1" (
	ECHO Validation successful for mount target "%MountFolder%" on drive %SearchDrive%.
	GOTO Finish
)

CALL :CheckRequirements
IF ERRORLEVEL 1 (
	SET "ExitCode=1"
	GOTO Finish
)

REM Pull the shadow copy listing.
VSSAdmin List Shadows /FOR=%SearchDrive% > "%TempFile%" 2>&1
IF ERRORLEVEL 1 (
	ECHO Failed to retrieve shadow copy information for drive %SearchDrive%.
	SET "ExitCode=1"
	GOTO Finish
)

SET "ShadowPath="
REM Pull the latest shadow copy path from the listing.
FOR /F "usebackq delims=" %%A IN (`FINDSTR /I /L /C:"\\?\GLOBALROOT\Device\HarddiskVolumeShadowCopy" "%TempFile%"`) DO SET "ShadowPath=%%A"

IF DEFINED ShadowPath SET "ShadowPath=%ShadowPath:*\\?\GLOBALROOT\Device\HarddiskVolumeShadowCopy=\\?\GLOBALROOT\Device\HarddiskVolumeShadowCopy%"

IF DEFINED ShadowPath (
	REM A shadow copy was found, mount it.
	MKLINK /D "%MountFolder%" "%ShadowPath%\"
	IF ERRORLEVEL 1 (
		ECHO Failed to mount the latest shadow copy to "%MountFolder%".
		SET "ExitCode=1"
		GOTO Finish
	)
	ECHO Mounted "%MountFolder%" to "%ShadowPath%\".
) ELSE (
	ECHO No Shadow Copies found.
	SET "ExitCode=1"
)

:Finish
IF DEFINED TempFile IF EXIST "%TempFile%" DEL /Q "%TempFile%" >NUL 2>&1
ENDLOCAL & EXIT /B %ExitCode%

:Initialize
SET "MountFolder="
SET "MountParent="
SET "SearchDrive=C:"
SET "TempFile=%TEMP%\%~n0_%RANDOM%.txt"
SET "ValidateOnly=0"
SET "ArgMountFolder="
SET "ArgSearchDrive="
SET "ModeArg="
EXIT /B 0

:Configuration
SET "ModeArg=%~1"

IF /I "%ModeArg%"=="/TEST" (
	SET "ValidateOnly=1"
	SET "ArgMountFolder=%~2"
	SET "ArgSearchDrive=%~3"
	IF NOT "%~4"=="" GOTO InvalidParams
)

IF "%ValidateOnly%"=="0" (
	IF /I "%~1"=="" GOTO InvalidParams
	IF NOT "%~3"=="" GOTO InvalidParams
	SET "ArgMountFolder=%~1"
	SET "ArgSearchDrive=%~2"
)

IF /I "%ArgMountFolder%"=="" GOTO InvalidParams

FOR %%A IN ("%ArgMountFolder%") DO SET "MountFolder=%%~fA"
IF "%MountFolder:~-1%"=="\" IF NOT "%MountFolder:~3%"=="" SET "MountFolder=%MountFolder:~0,-1%"

IF NOT "%ArgSearchDrive%"=="" SET "SearchDrive=%ArgSearchDrive%"
IF /I "%SearchDrive:~0,5%"=="/FOR=" SET "SearchDrive=%SearchDrive:~5%"

EXIT /B 0

:PrepSettings
IF EXIST "%MountFolder%" (
	ECHO Mount Folder: %MountFolder%
	ECHO The specified folder already exists. Enter a new folder for the mount target.
	GOTO InvalidParams
)

FOR %%A IN ("%MountFolder%") DO SET "MountParent=%%~dpA"
IF NOT EXIST "%MountParent%" (
	ECHO The parent folder for "%MountFolder%" does not exist.
	EXIT /B 1
)

IF "%SearchDrive:~1,1%" NEQ ":" GOTO InvalidParams
IF NOT "%SearchDrive:~2%"=="" GOTO InvalidParams
IF NOT EXIST "%SearchDrive%\" (
	ECHO Search drive "%SearchDrive%" does not exist.
	EXIT /B 1
)

EXIT /B 0

:CheckRequirements
CALL :VerifyRequirement "vssadmin.exe"
IF ERRORLEVEL 1 EXIT /B 1

NET SESSION >NUL 2>&1
IF ERRORLEVEL 1 (
	ECHO Administrative privileges are required. Use /? to view the help information.
	EXIT /B 1
)

EXIT /B 0

:VerifyRequirement
IF EXIST "%~1" EXIT /B 0
IF NOT "%~$PATH:1"=="" EXIT /B 0
ECHO Missing requirement: [%~1] Use /? to view the help information.
EXIT /B 1

:InvalidParams
ECHO Invalid parameters. Use /? to view the help information.
EXIT /B 1
