@echo off
setlocal enabledelayedexpansion

:: Example usage
call :RunAndCheck "ping 127.0.0.1 -n 1" "Pinging localhost"
call :RunAndCheck "ping 256.256.256.256 -n 1" "Pinging invalid host"

exit /b

:: -------------------------------
:: Function: RunAndCheck
:: %1 = Command to run
:: %2 = Description for logging
:: -------------------------------

:RunAndCheck
set "cmdToRun=%~1"
set "description=%~2"

echo [INFO] %description%...
%cmdToRun%
set "exitCode=%ERRORLEVEL%"

:: Log with timestamp
for /f "tokens=1-3 delims=/: " %%a in ("%date% %time%") do (
    set "logTime=%%a-%%b-%%c"
)
echo [%logTime%] Command: %cmdToRun% | exit code: %exitCode% >> errorlog.txt

:: Handle exit codes
if %exitCode%==0 (
    echo [SUCCESS] %description% completed successfully.
) else if %exitCode%==1 (
    echo [WARNING] Minor issue occurred.
) else if %exitCode% GEQ 2 (
    echo [ERROR] Critical failure detected! Code: %exitCode%
) else (
    echo [UNKNOWN] Exit code: %exitCode%
)

exit /b %exitCode%
