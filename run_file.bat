@echo off
If %1=="" exit
set program=%1
tasklist|find /i "%1" >NUL
if errorlevel 1 (
	start "" %1
) else (
	echo "%1 is already running."
)
pause
exit
