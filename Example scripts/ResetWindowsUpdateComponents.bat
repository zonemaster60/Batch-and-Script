@echo off
setlocal EnableExtensions
pushd "%~dp0" >nul 2>&1

rem Created by: Shawn Brink
rem Created on: October 1, 2015
rem Updated on: March 24, 2026
rem Tutorial: https://www.tenforums.com/tutorials/24742-reset-windows-update-windows-10-a.html

set "ELEVATION_MARKER=__elevated__"
set "ELEVATION_SCRIPT=%temp%\getadmin.vbs"
set "LOG_FILE="
set "NATIVE_SYSTEM_DIR=%SystemRoot%\System32"
if exist "%SystemRoot%\Sysnative\cmd.exe" set "NATIVE_SYSTEM_DIR=%SystemRoot%\Sysnative"
set "WMIC_EXE=%NATIVE_SYSTEM_DIR%\wbem\wmic.exe"
set "CATROOT2_DIR=%NATIVE_SYSTEM_DIR%\Catroot2"
set "PENDING_XML_BACKED_UP=0"
set "SOFTWARE_DISTRIBUTION_BACKED_UP=0"
set "CATROOT2_BACKED_UP=0"
set "VALIDATION_WARNINGS=0"

if exist "%ELEVATION_SCRIPT%" del /q "%ELEVATION_SCRIPT%" >nul 2>&1

rem Prompt to run as administrator.
"%NATIVE_SYSTEM_DIR%\fsutil.exe" dirty query %systemdrive% >nul 2>&1
if not errorlevel 1 goto PrivilegesGot

if /I "%~1"=="%ELEVATION_MARKER%" (
    echo.
    echo Please right-click this file and select "Run as administrator".
    echo.
    echo Press any key to exit.
    pause >nul
    goto ExitFailure
)

> "%ELEVATION_SCRIPT%" (
    echo Set UAC = CreateObject^("Shell.Application"^)
    echo UAC.ShellExecute "%~f0", "%ELEVATION_MARKER%", "", "runas", 1
)

"%NATIVE_SYSTEM_DIR%\cscript.exe" //nologo "%ELEVATION_SCRIPT%" >nul 2>&1
del /q "%ELEVATION_SCRIPT%" >nul 2>&1
goto ExitSuccess

:PrivilegesGot
if exist "%ELEVATION_SCRIPT%" del /q "%ELEVATION_SCRIPT%" >nul 2>&1

call :InitLog
call :Log "Running with administrative privileges."
call :Log "Script path: %~f0"
call :Log "Native system directory: %NATIVE_SYSTEM_DIR%"

call :RunStartupChecks

echo Stopping Windows Update related services...
call :Log "Stopping Windows Update related services."
call :StopService bits "Background Intelligent Transfer Service" || goto ResetFailed
call :StopService wuauserv "Windows Update" || goto ResetFailed
call :StopService appidsvc "Application Identity" || goto ResetFailed
call :StopService cryptsvc "Cryptographic Services" || goto ResetFailed

echo.
echo Resetting Windows Update components...
call :Log "Resetting Windows Update components."
call :ResetWindowsUpdate || goto ResetFailed

echo.
echo Starting Windows Update related services...
call :Log "Starting Windows Update related services."
call :StartService cryptsvc "Cryptographic Services"
call :StartService appidsvc "Application Identity"
call :StartService wuauserv "Windows Update"
call :StartService bits "Background Intelligent Transfer Service"

echo.
echo Running post-reset validation checks...
call :Log "Running post-reset validation checks."
call :ValidatePostReset

goto Finish

:ResetWindowsUpdate
call :Log "Flushing DNS cache."
"%NATIVE_SYSTEM_DIR%\ipconfig.exe" /flushdns >>"%LOG_FILE%" 2>&1
if errorlevel 1 call :Log "Warning: DNS cache flush reported an error."

call :DeleteMatching "%ALLUSERSPROFILE%\Application Data\Microsoft\Network\Downloader\qmgr*.dat"
call :DeleteMatching "%ALLUSERSPROFILE%\Microsoft\Network\Downloader\qmgr*.dat"
call :DeleteMatching "%SYSTEMROOT%\Logs\WindowsUpdate\*"

if exist "%SYSTEMROOT%\winsxs\pending.xml.bak" (
    call :Log "Removing existing pending.xml backup."
    del /f /q "%SYSTEMROOT%\winsxs\pending.xml.bak" >>"%LOG_FILE%" 2>&1
)
if exist "%SYSTEMROOT%\winsxs\pending.xml" (
    call :Log "Backing up pending.xml."
    "%NATIVE_SYSTEM_DIR%\takeown.exe" /f "%SYSTEMROOT%\winsxs\pending.xml" >>"%LOG_FILE%" 2>&1
    attrib -r -s -h "%SYSTEMROOT%\winsxs\pending.xml" >>"%LOG_FILE%" 2>&1
    ren "%SYSTEMROOT%\winsxs\pending.xml" pending.xml.bak >>"%LOG_FILE%" 2>&1
    if not errorlevel 1 set "PENDING_XML_BACKED_UP=1"
)

if exist "%SYSTEMROOT%\SoftwareDistribution.bak" (
    call :Log "Removing existing SoftwareDistribution backup."
    rmdir /s /q "%SYSTEMROOT%\SoftwareDistribution.bak" >>"%LOG_FILE%" 2>&1
)
if exist "%SYSTEMROOT%\SoftwareDistribution" (
    call :Log "Backing up SoftwareDistribution."
    attrib -r -s -h /s /d "%SYSTEMROOT%\SoftwareDistribution" >>"%LOG_FILE%" 2>&1
    ren "%SYSTEMROOT%\SoftwareDistribution" SoftwareDistribution.bak >>"%LOG_FILE%" 2>&1
    if not errorlevel 1 set "SOFTWARE_DISTRIBUTION_BACKED_UP=1"
)

if exist "%CATROOT2_DIR%.bak" (
    call :Log "Removing existing Catroot2 backup."
    rmdir /s /q "%CATROOT2_DIR%.bak" >>"%LOG_FILE%" 2>&1
)
if exist "%CATROOT2_DIR%" (
    call :Log "Backing up Catroot2."
    attrib -r -s -h /s /d "%CATROOT2_DIR%" >>"%LOG_FILE%" 2>&1
    ren "%CATROOT2_DIR%" Catroot2.bak >>"%LOG_FILE%" 2>&1
    if not errorlevel 1 set "CATROOT2_BACKED_UP=1"
)

rem Reset Windows Update policies.
call :Log "Removing Windows Update policy keys."
"%NATIVE_SYSTEM_DIR%\reg.exe" delete "HKCU\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /f >>"%LOG_FILE%" 2>&1
"%NATIVE_SYSTEM_DIR%\reg.exe" delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\WindowsUpdate" /f >>"%LOG_FILE%" 2>&1
"%NATIVE_SYSTEM_DIR%\reg.exe" delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /f >>"%LOG_FILE%" 2>&1
"%NATIVE_SYSTEM_DIR%\reg.exe" delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\WindowsUpdate" /f >>"%LOG_FILE%" 2>&1
"%NATIVE_SYSTEM_DIR%\gpupdate.exe" /force >>"%LOG_FILE%" 2>&1
if errorlevel 1 call :Log "Warning: Group Policy refresh reported an error."

rem Reset the BITS and Windows Update security descriptors.
call :Log "Resetting BITS security descriptor."
"%NATIVE_SYSTEM_DIR%\sc.exe" sdset bits D:(A;;CCLCSWRPWPDTLOCRRC;;;SY)(A;;CCDCLCSWRPWPDTLOCRSDRCWDWO;;;BA)(A;;CCLCSWLOCRRC;;;AU)(A;;CCLCSWRPWPDTLOCRRC;;;PU) >>"%LOG_FILE%" 2>&1
if errorlevel 1 exit /b 1

call :Log "Resetting Windows Update security descriptor."
"%NATIVE_SYSTEM_DIR%\sc.exe" sdset wuauserv D:(A;;CCLCSWRPWPDTLOCRRC;;;SY)(A;;CCDCLCSWRPWPDTLOCRSDRCWDWO;;;BA)(A;;CCLCSWLOCRRC;;;AU)(A;;CCLCSWRPWPDTLOCRRC;;;PU) >>"%LOG_FILE%" 2>&1
if errorlevel 1 exit /b 1

rem Reregister the BITS and Windows Update files.
call :RegisterDll atl.dll
call :RegisterDll urlmon.dll
call :RegisterDll mshtml.dll
call :RegisterDll shdocvw.dll
call :RegisterDll browseui.dll
call :RegisterDll jscript.dll
call :RegisterDll vbscript.dll
call :RegisterDll scrrun.dll
call :RegisterDll msxml.dll
call :RegisterDll msxml3.dll
call :RegisterDll msxml6.dll
call :RegisterDll actxprxy.dll
call :RegisterDll softpub.dll
call :RegisterDll wintrust.dll
call :RegisterDll dssenh.dll
call :RegisterDll rsaenh.dll
call :RegisterDll gpkcsp.dll
call :RegisterDll sccbase.dll
call :RegisterDll slbcsp.dll
call :RegisterDll cryptdlg.dll
call :RegisterDll oleaut32.dll
call :RegisterDll ole32.dll
call :RegisterDll shell32.dll
call :RegisterDll initpki.dll
call :RegisterDll wuapi.dll
call :RegisterDll wuaueng.dll
call :RegisterDll wuaueng1.dll
call :RegisterDll wucltui.dll
call :RegisterDll wups.dll
call :RegisterDll wups2.dll
call :RegisterDll wuweb.dll
call :RegisterDll qmgr.dll
call :RegisterDll qmgrprxy.dll
call :RegisterDll wucltux.dll
call :RegisterDll muweb.dll
call :RegisterDll wuwebv.dll
call :RegisterDll wudriver.dll

call :Log "Resetting Winsock catalog."
"%NATIVE_SYSTEM_DIR%\netsh.exe" winsock reset >>"%LOG_FILE%" 2>&1
if errorlevel 1 exit /b 1

call :Log "Resetting Winsock proxy configuration."
"%NATIVE_SYSTEM_DIR%\netsh.exe" winsock reset proxy >>"%LOG_FILE%" 2>&1
if errorlevel 1 call :Log "Warning: Winsock proxy reset is unavailable or failed on this system."
exit /b 0

:StopService
setlocal
set "SERVICE_NAME=%~1"
set "DISPLAY_NAME=%~2"

call :ServiceExists "%SERVICE_NAME%"
if errorlevel 1 (
    call :Log "Skipping missing service %SERVICE_NAME%."
    echo Note: "%DISPLAY_NAME%" (%SERVICE_NAME%) is not present on this system.
    endlocal & exit /b 0
)

for /l %%I in (1,1,3) do (
    call :Log "Stopping %SERVICE_NAME% (attempt %%I of 3)."
    net stop "%SERVICE_NAME%" >>"%LOG_FILE%" 2>&1
    "%NATIVE_SYSTEM_DIR%\sc.exe" query "%SERVICE_NAME%" | "%NATIVE_SYSTEM_DIR%\findstr.exe" /I /C:"STOPPED" >nul 2>&1
    if not errorlevel 1 (
        call :Log "%SERVICE_NAME% stopped successfully."
        endlocal & exit /b 0
    )

    call :WaitSeconds 2
)

echo.
echo Cannot reset Windows Update because "%DISPLAY_NAME%" (%SERVICE_NAME%) failed to stop.
echo Restart the computer and try again.
echo.
call :Log "Error: %SERVICE_NAME% failed to stop."
endlocal & exit /b 1

:StartService
setlocal
set "SERVICE_NAME=%~1"
set "DISPLAY_NAME=%~2"

call :ServiceExists "%SERVICE_NAME%"
if errorlevel 1 (
    call :Log "Skipping start for missing service %SERVICE_NAME%."
    endlocal & exit /b 0
)

"%NATIVE_SYSTEM_DIR%\sc.exe" query "%SERVICE_NAME%" | "%NATIVE_SYSTEM_DIR%\findstr.exe" /I /C:"RUNNING" >nul 2>&1
if not errorlevel 1 (
    call :Log "%SERVICE_NAME% is already running."
    endlocal & exit /b 0
)

call :Log "Starting %SERVICE_NAME%."
net start "%SERVICE_NAME%" >>"%LOG_FILE%" 2>&1
if errorlevel 1 (
    echo Warning: Unable to start "%DISPLAY_NAME%" (%SERVICE_NAME%).
    call :Log "Warning: Unable to start %SERVICE_NAME%."
    endlocal & exit /b 0
)

call :Log "%SERVICE_NAME% started successfully."
endlocal & exit /b 0

:DeleteMatching
call :Log "Deleting %~1"
del /f /q /s "%~1" >>"%LOG_FILE%" 2>&1
exit /b 0

:RegisterDll
if exist "%SystemRoot%\System32\%~1" (
    call :Log "Registering %~1"
    "%NATIVE_SYSTEM_DIR%\regsvr32.exe" /s "%NATIVE_SYSTEM_DIR%\%~1" >>"%LOG_FILE%" 2>&1
) else (
    call :Log "Skipping missing DLL %~1"
)
exit /b 0

:ServiceExists
"%NATIVE_SYSTEM_DIR%\sc.exe" query "%~1" >nul 2>&1
if errorlevel 1 exit /b 1
exit /b 0

:InitLog
if defined LOG_FILE exit /b 0
set "LOG_STAMP="
if exist "%WMIC_EXE%" (
    for /f "tokens=2 delims==" %%I in ('"%WMIC_EXE%" os get LocalDateTime /value 2^>nul ^| "%NATIVE_SYSTEM_DIR%\findstr.exe" /R /C:"^LocalDateTime="') do if not defined LOG_STAMP set "LOG_STAMP=%%I"
)
if defined LOG_STAMP set "LOG_STAMP=%LOG_STAMP:~0,4%-%LOG_STAMP:~4,2%-%LOG_STAMP:~6,2%_%LOG_STAMP:~8,2%-%LOG_STAMP:~10,2%-%LOG_STAMP:~12,2%-%LOG_STAMP:~15,3%"
if not defined LOG_STAMP set "LOG_STAMP=%date%_%time%"
set "LOG_STAMP=%LOG_STAMP: =0%"
set "LOG_STAMP=%LOG_STAMP:/=-%"
set "LOG_STAMP=%LOG_STAMP:\=-%"
set "LOG_STAMP=%LOG_STAMP::=-%"
set "LOG_STAMP=%LOG_STAMP:,=-%"
set "LOG_STAMP=%LOG_STAMP:.=-%"
set "LOG_FILE=%temp%\ResetWindowsUpdateComponents_%LOG_STAMP%.log"
> "%LOG_FILE%" echo ResetWindowsUpdateComponents log started on %date% %time%
>> "%LOG_FILE%" ver
>> "%LOG_FILE%" echo Processor architecture: %PROCESSOR_ARCHITECTURE%
exit /b 0

:Log
if not defined LOG_FILE exit /b 0
>> "%LOG_FILE%" echo [%date% %time%] %~1
exit /b 0

:WaitSeconds
setlocal
set /a WAIT_COUNT=%~1+1
if exist "%NATIVE_SYSTEM_DIR%\timeout.exe" (
    "%NATIVE_SYSTEM_DIR%\timeout.exe" /t %~1 /nobreak >nul
) else (
    "%NATIVE_SYSTEM_DIR%\ping.exe" 127.0.0.1 -n %WAIT_COUNT% >nul
)
endlocal & exit /b 0

:RunStartupChecks
set "COMPAT_WARNING_COUNT=0"
cls
echo ResetWindowsUpdateComponents.bat
echo.
for /f "delims=" %%I in ('ver') do set "OS_BANNER=%%I"
echo Detected OS: %OS_BANNER%
echo Native tools: %NATIVE_SYSTEM_DIR%
call :Log "Detected OS: %OS_BANNER%"

call :CheckTool "%NATIVE_SYSTEM_DIR%\fsutil.exe" "fsutil"
call :CheckTool "%NATIVE_SYSTEM_DIR%\sc.exe" "sc"
call :CheckTool "%NATIVE_SYSTEM_DIR%\reg.exe" "reg"
call :CheckTool "%NATIVE_SYSTEM_DIR%\netsh.exe" "netsh"
call :CheckTool "%NATIVE_SYSTEM_DIR%\ipconfig.exe" "ipconfig"
call :CheckTool "%NATIVE_SYSTEM_DIR%\findstr.exe" "findstr"
call :CheckTool "%NATIVE_SYSTEM_DIR%\regsvr32.exe" "regsvr32"

if exist "%NATIVE_SYSTEM_DIR%\choice.exe" (
    echo Prompt mode: `choice`
    call :Log "Prompt mode: choice.exe available."
) else (
    echo Prompt mode: fallback `set /p`
    call :Log "Prompt mode: choice.exe unavailable; using set /p fallback."
)

if exist "%NATIVE_SYSTEM_DIR%\timeout.exe" (
    echo Wait mode: `timeout`
    call :Log "Wait mode: timeout.exe available."
) else (
    echo Wait mode: fallback `ping`
    call :Log "Wait mode: timeout.exe unavailable; using ping fallback."
)

if exist "%WMIC_EXE%" (
    echo Timestamp mode: `wmic`
    call :Log "Timestamp mode: WMIC available."
) else (
    echo Timestamp mode: locale fallback
    call :Log "Timestamp mode: WMIC unavailable; using locale date/time fallback."
)

if "%COMPAT_WARNING_COUNT%"=="0" (
    echo Startup checks: passed
    call :Log "Startup checks passed."
) else (
    echo Startup checks: %COMPAT_WARNING_COUNT% warning^(s^)
    call :Log "Startup checks completed with %COMPAT_WARNING_COUNT% warning(s)."
)

echo.
exit /b 0

:CheckTool
if exist "%~1" (
    echo Tool check: %~2 ok
    call :Log "Tool check passed: %~2 at %~1"
    exit /b 0
)

echo Warning: %~2 not found at %~1
call :Log "Tool check warning: %~2 missing at %~1"
set /a COMPAT_WARNING_COUNT+=1
exit /b 0

:ResetFailed
cls
echo Windows Update reset did not complete.
echo.
echo Review the message above, restart the computer, and run the script again.
if defined LOG_FILE echo Log file: "%LOG_FILE%"
echo.
call :Log "Reset failed."
pause
goto ExitFailure

:ValidatePostReset
set "VALIDATION_WARNINGS=0"

call :ValidateServiceRunning bits
call :ValidateServiceRunning wuauserv
call :ValidateServiceRunning cryptsvc

call :ValidateOptionalService appidsvc

if "%SOFTWARE_DISTRIBUTION_BACKED_UP%"=="1" call :ValidatePathPresent "%SYSTEMROOT%\SoftwareDistribution.bak" "SoftwareDistribution backup"
if "%CATROOT2_BACKED_UP%"=="1" call :ValidatePathPresent "%CATROOT2_DIR%.bak" "Catroot2 backup"
if "%PENDING_XML_BACKED_UP%"=="1" call :ValidatePathPresent "%SYSTEMROOT%\winsxs\pending.xml.bak" "pending.xml backup"

call :ValidatePathPresent "%LOG_FILE%" "reset log file"

if "%VALIDATION_WARNINGS%"=="0" (
    echo Validation checks passed.
    call :Log "Validation checks passed."
) else (
    echo Validation completed with warnings. Review the log for details.
    call :Log "Validation completed with warnings."
)
exit /b 0

:ValidateServiceRunning
setlocal
set "SERVICE_NAME=%~1"

call :ServiceExists "%SERVICE_NAME%"
if errorlevel 1 (
    echo Warning: Service %SERVICE_NAME% is not present on this system.
    call :Log "Validation warning: Service %SERVICE_NAME% is missing."
    endlocal & set /a VALIDATION_WARNINGS+=1 & exit /b 0
)

"%NATIVE_SYSTEM_DIR%\sc.exe" query "%SERVICE_NAME%" | "%NATIVE_SYSTEM_DIR%\findstr.exe" /I /C:"RUNNING" >nul 2>&1
if not errorlevel 1 (
    call :Log "Validation passed: %SERVICE_NAME% is running."
    endlocal & exit /b 0
)

echo Warning: Service %SERVICE_NAME% is not running.
call :Log "Validation warning: %SERVICE_NAME% is not running."
endlocal & set /a VALIDATION_WARNINGS+=1 & exit /b 0

:ValidateOptionalService
setlocal
set "SERVICE_NAME=%~1"

call :ServiceExists "%SERVICE_NAME%"
if errorlevel 1 (
    call :Log "Validation note: Optional service %SERVICE_NAME% is missing."
    endlocal & exit /b 0
)

"%NATIVE_SYSTEM_DIR%\sc.exe" query "%SERVICE_NAME%" | "%NATIVE_SYSTEM_DIR%\findstr.exe" /I /C:"RUNNING" >nul 2>&1
if not errorlevel 1 (
    call :Log "Validation passed: optional service %SERVICE_NAME% is running."
    endlocal & exit /b 0
)

echo Note: Optional service %SERVICE_NAME% is not running.
call :Log "Validation note: Optional service %SERVICE_NAME% is not running."
endlocal & exit /b 0

:ValidatePathPresent
if exist "%~1" (
    call :Log "Validation passed: %~2 present at %~1"
    exit /b 0
)

echo Warning: %~2 was not found.
call :Log "Validation warning: %~2 missing at %~1"
set /a VALIDATION_WARNINGS+=1
exit /b 0

:Finish
cls
echo Windows Update components have been reset.
echo.
echo A restart is recommended to finish the repair.
if defined LOG_FILE echo Log file: "%LOG_FILE%"
if not "%VALIDATION_WARNINGS%"=="0" echo Validation warnings: %VALIDATION_WARNINGS%
echo.
call :Log "Reset completed successfully."
call :PromptRestart
if errorlevel 1 goto ExitSuccess

shutdown /r /f /t 0
goto ExitSuccess

:PromptRestart
setlocal
if exist "%NATIVE_SYSTEM_DIR%\choice.exe" (
    "%NATIVE_SYSTEM_DIR%\choice.exe" /c YN /n /m "Restart now? [Y,N]: "
    if errorlevel 2 endlocal & exit /b 1
    endlocal & exit /b 0
)

set "RESTART_ANSWER="
set /p RESTART_ANSWER=Restart now? [Y/N]: 
if /I "%RESTART_ANSWER%"=="Y" endlocal & exit /b 0
endlocal & exit /b 1

:ExitSuccess
popd >nul 2>&1
endlocal
exit /b 0

:ExitFailure
popd >nul 2>&1
endlocal
exit /b 1
