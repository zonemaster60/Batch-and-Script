@ECHO OFF
REM BFCPEOPTIONSTART
REM Advanced BAT to EXE Converter www.BatToExeConverter.com
REM BFCPEEXE=
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
setlocal
set pathreg=%~dp0

if not exist "%pathreg%regbackup\nul" mkdir "%pathreg%regbackup"
for %%k in (lm cu cr u cc) do call :ExpReg %%k
Exit /B 0

:ExpReg
reg.exe export hk%1 "%pathreg%regbackup\hk%1.reg" /y
if "%errorlevel%"=="1" (
  echo ^>^> Export --hk%1-- Failed.
) else (
  echo ^>^> Export --hk%1-- Succeeded.
)
Exit /B 0

if not exist "%pathreg%regbackup\nul" mkdir "%pathreg%regbackup"
for %%k in (lm cu cr u cc) do call :ImpReg %%k
Exit /B 0

:ImpReg
reg.exe import "%pathreg%regbackup\hk%1.reg"
if "%errorlevel%"=="1" (
  echo ^>^> Export --hk%1-- Failed.
) else (
  echo ^>^> Export --hk%1-- Succeeded.
)
Exit /B 0

endlocal
