@ECHO OFF
REM BFCPEOPTIONSTART
REM Advanced BAT to EXE Converter www.BatToExeConverter.com
REM BFCPEEXE=C:\Users\zonem\Documents\Batch-and-Script\Handy2ClickAutoFixer\Handy2ClickAutoFixer.exe
REM BFCPEICON=D:\Develop\Advanced BAT to EXE Converter PRO\ab2econv461pro\icons\icon3.ico
REM BFCPEICONINDEX=1
REM BFCPEEMBEDDISPLAY=0
REM BFCPEEMBEDDELETE=1
REM BFCPEADMINEXE=1
REM BFCPEINVISEXE=0
REM BFCPEVERINCLUDE=1
REM BFCPEVERVERSION=1.1.2.4
REM BFCPEVERPRODUCT=Handy 2Click AutoFixer
REM BFCPEVERDESC=Handy 2Click AutoFixer
REM BFCPEVERCOMPANY=ZoneSoft
REM BFCPEVERCOPYRIGHT=David Scouten (c2024-26)
REM BFCPEWINDOWCENTER=1
REM BFCPEDISABLEQE=0
REM BFCPEWINDOWHEIGHT=25
REM BFCPEWINDOWWIDTH=80
REM BFCPEWTITLE=
REM BFCPEOPTIONEND
@Echo off
SETLOCAL EnableExtensions EnableDelayedExpansion
pushd "%~dp0"

rem CenterSelf
rem CursorHide
rem DisableQuickEdit

rem ***********************************************
rem David Scouten (c2024-26) zonemaster60@gmail.com
rem ***********************************************

rem ********************
rem variables start here
rem ********************
Set chkhealth=False
Set resetbase=False
Set version=v1.1.2.4

rem ******************
rem set initial values
rem ******************
Set analyze=False
Set repair=False
Set skipped=False
Set setchkdsk=0

rem ***********
rem time values
rem ***********
Set btntime=250
Set wshutdown=10
Set ct1=1
Set ct2=4

rem ***********
rem text colors
rem ***********
Set black0=0
Set blue1=1
Set green2=2
Set cyan3=3
Set red4=4
Set magenta5=5
Set yellow6=6
Set gray7=7
Set gray8=8
Set blue9=9
Set green10=10
Set cyan11=11
Set red12=12
Set magenta13=13
Set yellow14=14
Set white15=15

rem *************
rem display title
rem *************
Set title1={Handy2ClickAutoFixer}
Title {Handy2ClickAutoFixer :: %version%}

rem **********************
rem *calculate # of addons
rem **********************
Set "addondir=addons"
Set "addonfile=addons.txt"

If exist "%addonfile%" (
Set /a count=0
for /f "usebackq delims=" %%A in ("%addonfile%") do (
    Set /a count+=1
    Set "addon!count!=%%A"
)
)

rem make the 'addons.exe' folder, if 'addons.exe.txt' exists
If exist "%addonfile%" mkdir "%addondir%" >nul 2>&1

rem ********************
rem check for powershell
rem ********************
rem CursorHide
rem PaintScreen 0
rem PrintColorAt "Checking..." 2 2 %yellow14% %black0%
where powershell >nul 2>&1
If %errorlevel% EQU 0 (
rem PrintColorAt "{ PowerShell Is Installed. }" 3 6 %green10% %black0%
) else (
rem PrintColorAt "{ PowerShell Is NOT Installed. }" 3 6 %yellow14% %red4%
)
timeout /t %ct1% /nobreak >nul
rem PrintColorAt "Checking..." 4 2 %yellow14% %black0%
where pwsh >nul 2>&1
if %errorlevel% EQU 0 (
rem PrintColorAt "{ PowerShell Core Is Installed. }" 5 6 %green10% %black0%
) else (
rem PrintColorAt "{ PowerShell Core Is NOT Installed. }" 5 6 %yellow14% %red4%
)
rem CursorHide
timeout /t %ct1% /nobreak >nul

rem *********
rem main menu
rem *********

:MAIN
Set lmenu=MAIN
Call :show_me %black0% 1 1
rem PrintColorAt "{%lmenu%MENU}" 3 5 %gray7% %black0%
rem PrintColorAt "[ ANALYZE]" 4 5 %yellow14% %black0%
rem PrintColorAt "[ REPAIR ]" 5 5 %green10% %black0%
rem PrintColorAt "[  INFO  ]" 6 5 %magenta13% %black0%
rem PrintColorAt "[WINTOOLS]" 7 5 %cyan11% %black0%
rem PrintColorAt "[  EXIT  ]" 8 5 %red12% %black0%

rem ************************
rem display status / options
rem ************************

rem PrintColorAt "{ STATUS }" 3 66 %gray7% %black0%
If %analyze% EQU True (
rem PrintColorAt "{  DONE  }" 4 66 %green10% %black0%
) else (
rem PrintColorAt "{ ------ }" 4 66 %yellow14% %black0%
)
If %skipped% EQU True (
rem PrintColorAt "{  SKIP  }" 4 66 %yellow14% %red4%
)
If %repair% EQU True (
rem PrintColorAt "{  DONE  }" 5 66 %green10% %black0%
) else (
rem PrintColorAt "{ ------ }" 5 66 %yellow14% %black0%
)
rem PrintColorAt "{ OPTION }" 6 66 %gray7% %black0%
rem .addons.txt exist?
If exist %addonfile% (
rem PrintColorAt "[ ADDONS ]" 7 66 %cyan3% %black0%
) else (
rem PrintColorAt "[ ADDONS ]" 7 66 %yellow14% %black0%
)

rem *************
rem button matrix
rem *************

rem MouseCmd 5,4,14,4 5,5,14,5 5,6,14,6 5,7,14,7 5,8,14,8 66,7,75,7

rem run chkdsk
If %result% EQU 0 Call :chkdsk-scan

If %result% EQU 1 (
rem PrintColorAt "{Go to the 'ANALYZE' menu.}" 4 16 %yellow14% %black0%
Call :make_button "[ ANALYZE]" 4 5 1 10 %yellow14% %btntime% %black0%
GoTo ANALYZE
)

If %result% EQU 2 (
rem PrintColorAt "{Go to the 'REPAIR' menu.}" 5 16 %green10% %black0%
Call :make_button "[ REPAIR ]" 5 5 1 10 %green10% %btntime% %black0%
Goto REPAIR
)

If %result% EQU 3 (
rem PrintColorAt "{Get 'INFO' about your system.}" 6 16 %magenta13% %black0%
Call :make_button "[  INFO  ]" 6 5 1 10 %magenta13% %btntime% %black0%
Goto INFO1
)

If %result% EQU 4 (
rem PrintColorAt "{Go to the 'WINTOOLS' menu.}" 7 16 %cyan11% %black0%
Call :make_button "[WINTOOLS]" 7 5 1 10 %cyan11% %btntime% %black0%
GoTo WINTOOLS
)

If %result% EQU 5 (
rem PrintColorAt "{Go to the 'EXIT' menu.}" 8 16 %red12% %black0%
Call :make_button "[  EXIT  ]" 8 5 1 10 %red12% %btntime% %black0%
Goto EXIT
)

If %result% EQU 6 (
If exist %addonfile% (
rem PrintColorAt "{Go to the 'ADDONS' menu.}" 7 39 %cyan3% %black0%
Call :make_button "[ ADDONS ]" 7 66 1 10 %cyan3% %btntime% %black0%
GoTo ADDONS
) else (
rem PrintColorAt "{'%addonfile%' not found.}" 7 39 %yellow14% %black0%
Call :make_button "[ ADDONS ]" 7 66 1 10 %yellow14% %btntime% %black0%
GoTo MAIN
)
)
GoTo MAIN

rem ************
rem analyze menu
rem ************

:ANALYZE
Set lmenu=ANALYZE
Call :show_me %black0% 1 0
rem PrintColorAt "{ %lmenu%}" 3 5 %gray7% %black0%
rem PrintColorAt "[  SCAN  ]" 4 5 %cyan11% %black0%
rem PrintColorAt "[  CHECK ]" 5 5 %cyan11% %black0%
rem PrintColorAt "[ <BACK< ]" 6 5 %yellow14% %black0%

rem *************
rem button matrix
rem *************

rem MouseCmd 5,4,14,4 5,5,14,5 5,6,14,6

If %result% EQU 1 (
rem PrintColorAt "{'SCAN' the image health-slow.}" 4 16 %cyan11% %black0%
Call :make_button "[  SCAN  ]" 4 5 1 10 %cyan11% %btntime% %black0%
Call :show_me %black0% 0 0
Set chkhealth=False
GoTo ANALYZE1
)

If %result% EQU 2 (
rem PrintColorAt "{'CHECK' the image health-fast.}" 5 16 %cyan11% %black0%
Call :make_button "[  CHECK ]" 5 5 1 10 %cyan11% %btntime% %black0%
Call :show_me %black0% 0 0
Set chkhealth=True
GoTo ANALYZE1
)

If %result% EQU 3 (
rem PrintColorAt "{Go 'BACK' to the 'MAIN' menu.}" 6 16 %yellow14% %black0%
Call :make_button "[ <BACK< ]" 6 5 1 10 %yellow14% %btntime% %black0%
GoTo MAIN
)
GoTo ANALYZE

:ANALYZE1
rem ***********
rem analyze now
rem *********************
rem check component store
rem *********************

Call :show_me %black0% 0 0
rem PrintCenter "{ %lmenu% > 1/3 > Analyzes the system component store for errors. }" 2 %blue9% %black0%
Call :run_command "dism /online /cleanup-image /analyzecomponentstore" 4
timeout /t %ct2% /nobreak >nul

rem ********************
rem check or scan health
rem ********************

Call :show_me %black0% 0 0
If %chkhealth% EQU True (
rem PrintCenter "{ %lmenu% > 2/3 > CheckHealth is faster, but not as thorough. }" 2 %blue9% %black0%
Call :run_command "dism /online /cleanup-image /checkhealth" 4
timeout /t %ct2% /nobreak >nul
) else (
rem PrintCenter "{ %lmenu% > 2/3 > ScanHealth is slower, but performs a better test. }" 2 %blue9% %black0%
Call :run_command "dism /online /cleanup-image /scanhealth" 4
timeout /t %ct2% /nobreak >nul
)

rem ************
rem verify files
rem ************

Call :show_me %black0% 0 0
rem PrintCenter "{ %lmenu% > 3/3 > Verifies, but does not replace any system files. }" 2 %blue9% %black0%
Call :run_command "sfc /verifyonly" 4
timeout /t %ct2% /nobreak >nul
Set analyze=True
Set skipped=False
GoTo MAIN

rem ***********
rem repair menu
rem ***********

:REPAIR
Set lmenu=REPAIR
Call :show_me %black0% 1 1
rem PrintColorAt "{ %lmenu% }" 3 5 %gray7% %black0%
rem PrintColorAt "[ REPAIR ]" 4 5 %cyan11% %black0%
rem PrintColorAt "[BASELINE]" 5 5 %cyan11% %black0%
rem PrintColorAt "[ <BACK< ]" 6 5 %yellow14% %black0%

rem *************
rem button matrix
rem *************

rem MouseCmd 5,4,14,4 5,5,14,5 5,6,14,6

rem run chkdsk
If %result% EQU 0 Call :chkdsk-scan

If %result% EQU 1 (
rem PrintColorAt "{'REPAIR' the system image.}" 4 16 %cyan11% %black0%
Call :make_button "[ REPAIR ]" 4 5 1 10 %cyan11% %btntime% %black0%
Call :show_me %black0% 0 0
Set resetbase=False
GoTo REPAIR1
)

If %result% EQU 2 (
rem PrintColorAt "{'REPAIR' system image, reset to 'BASELINE'.}" 5 16 %cyan11% %black0%
Call :make_button "[BASELINE]" 5 5 1 10 %cyan11% %btntime% %black0%
Set resetbase=True
GoTo REPAIR1
)

If %result% EQU 3 (
rem PrintColorAt "{Go 'BACK' to the 'MAIN' menu.}" 6 16 %yellow14% %black0%
Call :make_button "[ <BACK< ]" 6 5 1 10 %yellow14% %btntime% %black0%
GoTo MAIN
)
GoTo REPAIR

:REPAIR1
rem **********
rem repair now
rem **************************
rem resetbase / normal cleanup
rem **************************

Call :show_me %black0% 0 0
If %resetbase% EQU True (
rem PrintCenter "{ %lmenu% > 1/3 > Reset the entire system component store to baseline. }" 2 %blue9% %black0%
Call :run_command "dism /online /cleanup-image /startcomponentcleanup /resetbase" 4
timeout /t %ct2% /nobreak >nul
) else (
rem PrintCenter "{ %lmenu% > 1/3 > Perform a normal system component store cleanup. }" 2 %blue9% %black0%
Call :run_command "dism /online /cleanup-image /startcomponentcleanup" 4
timeout /t %ct2% /nobreak >nul
)

rem **************
rem restore health
rem **************

Call :show_me %black0% 0 0
rem PrintCenter "{ %lmenu% > 2/3 > Clean, update, and restore the system image health. }" 2 %blue9% %black0%
Call :run_command "dism /online /cleanup-image /restorehealth" 4
timeout /t %ct2% /nobreak >nul

rem ********
rem scan now
rem ********

Call :show_me %black0% 0 0
rem PrintCenter "{ %lmenu% > 3/3 > Scans, and replaces any corrupted system files. }" 2 %blue9% %black0%
Call :run_command "sfc /scannow" 4
timeout /t %ct2% /nobreak >nul
If %analyze% EQU False (
Set skipped=True
) else (
Set skipped=False
Set analyze=True
)
Set repair=True
GoTo RESTART

rem ***********
rem info part 1
rem ***********

:INFO1
Call :show_me %black0% 0 0
Set lmenu=INFO1
rem PrintCenter "{%title1%::%lmenu%}" 1 %cyan3% %black0%
rem PrintCenter "{ Use The Mouse to Navigate or the Number 0-9 Keys }" 3 %yellow14% %black0%
rem PrintCenter "[ ANALYZE ] This uses DISM and SFC to [ ANALYZE ] for" 5 %yellow14% %black0%
rem PrintCenter "corrupted system files. This option DOES NOT make any repairs." 6 %yellow14% %black0%
rem PrintCenter "[ REPAIR ] This also uses DISM and SFC" 8 %green10% %black0%
rem PrintCenter "to [ ANALYZE ] and [ REPAIR ] any corrupted system files." 9 %green10% %black0%
rem PrintCenter "[ INFO ] You are reading it now." 11 %magenta13% %black0%
rem PrintCenter "[WINTOOLS] Access the windows built in tools." 13 %cyan11% %black0%
rem PrintCenter "[ EXIT ] Exit the program." 15 %red12% %black0%
Call :next_page

rem ***********
rem info part 2
rem ***********

:INFO2
Call :show_me %black0% 0 0
Set lmenu=INFO2
rem PrintCenter "{%title1%::%lmenu%}" 1 %cyan3% %black0%
rem PrintCenter "{ Use The Mouse to Navigate or the Number 0-9 Keys }" 3 %yellow14% %black0%
rem PrintCenter "{ STATUS } The status of [ ANALYZE ] and [ REPAIR ] system image tasks." 5 %gray7% %black0%
rem PrintCenter "{ ------ } ------/ DONE [ ANALYZE ] system image task." 7 %gray7% %black0%
rem PrintCenter "{ ------ } ------/ DONE [ REPAIR ] system image task." 9 %gray7% %black0%
rem PrintCenter "{ OPTION } Options are [ ADDONS ]." 11 %gray7% %black0%
rem PrintCenter "[ ADDONS ] If you have them you can access them from this menu." 13 %cyan3% %black0%
Call :next_page

rem ***********
rem info part 3
rem ***********

:INFO3
Call :show_me %black0% 0 0
Set lmenu=INFO3
rem PrintCenter "{%title1%::%lmenu%}" 1 %cyan3% %black0%
rem PrintCenter "{ Use The Mouse to Navigate or the Number 0-9 Keys }" 3 %yellow14% %black0%
rem PrintColorAt "Architecture: %PROCESSOR_ARCHITECTURE%" 5 10 %gray7% %black0%
rem PrintColorAt "ComputerName: %computername%" 6 10 %cyan3% %black0%
rem PrintColorAt "HomeDrive: %homedrive%" 7 10 %cyan3% %black0%
rem PrintColorAt "HomePath: %homepath%" 8 10 %cyan3% %black0%
rem PrintColorAt "OneDrive: %homedrive%%homepath%\OneDrive" 9 10 %cyan3% %black0%
rem PrintColorAt "Operating System: %os%" 10 10 %magenta13% %black0%
rem PrintColorAt "Processor ID: %PROCESSOR_IDENTIFIER%" 11 10 %magenta13% %black0%
rem PrintColorAt "# of Processors: %NUMBER_OF_PROCESSORS%" 12 10 %magenta13% %black0%
rem PrintColorAt "UserName: %username%" 13 10 %cyan11% %black0%
rem PrintColorAt "Windows: %POWERSHELL_DISTRIBUTION_CHANNEL%" 14 10 %cyan11% %black0%
rem PrintColorAt "Windows Directory: %windir%" 15 10 %cyan11% %black0%
rem PrintCenter "{ Thank you for taking the time to try this program. }" 17 %green10% %black0%
Call :next_page
GoTo MAIN

rem *********
rem exit menu
rem *********

:EXIT
Set lmenu=EXIT
Call :show_me %black0% 1 0
rem PrintColorAt "{  %lmenu%  }" 3 5 %gray7% %black0%
rem PrintColorAt "[  EXIT  ]" 4 5 %red12% %black0%
rem PrintColorAt "[ <BACK< ]" 5 5 %yellow14% %black0%

rem *************
rem button matrix
rem *************

rem MouseCmd 5,4,14,4 5,5,14,5
If %result% EQU 1 (
rem PrintColorAt "{'EXIT' to the OS.}" 4 16 %red12% %black0%
Call :make_button "[  EXIT  ]" 4 5 1 10 %red12% %btntime% %black0%
Call :show_me %black0% 0 0
:redo2
rem GenRandom 15
If %result% EQU 0 GoTo redo2
rem PrintCenter "{ Thank you for using this FREE Software. }" 13 %result% %black0%
timeout /t %ct2% /nobreak >nul
ENDLOCAL
Exit /B %ErrorLevel%
)

If %result% EQU 2 (
rem PrintColorAt "{Go 'BACK' to the 'MAIN' menu.}" 5 16 %yellow14% %black0%
Call :make_button "[ <BACK< ]" 5 5 1 10 %yellow14% %btntime% %black0%
GoTo MAIN
)
GoTo EXIT

:ADDONS
Set lmenu=ADDONS
Call :show_me %black0% 1 0
rem PrintColorAt "{ %lmenu% }" 3 5 %gray7% %black0%
If exist %addondir%\%addon1%.exe (
rem PrintColorAt "[ ADDON1 ] {%addon1%.exe}" 4 5 %cyan11% %black0%
) else (
rem PrintColorAt "[ ADDON1 ] {'filename1'}" 4 5 %yellow14% %black0%
)
If exist %addondir%\%addon2%.exe (
rem PrintColorAt "[ ADDON2 ] {%addon2%.exe}" 5 5 %cyan11% %black0%
) else (
rem PrintColorAt "[ ADDON2 ] {'filename2'}" 5 5 %yellow14% %black0%
)
If exist %addondir%\%addon3%.exe (
rem PrintColorAt "[ ADDON3 ] {%addon3%.exe}" 6 5 %cyan11% %black0%
) else (
rem PrintColorAt "[ ADDON3 ] {'filename3'}" 6 5 %yellow14% %black0%
)
If exist %addondir%\%addon4%.exe (
rem PrintColorAt "[ ADDON4 ] {%addon4%.exe}" 7 5 %cyan11% %black0%
) else (
rem PrintColorAt "[ ADDON4 ] {'filename4'}" 7 5 %yellow14% %black0%
)
If exist %addondir%\%addon5%.exe (
rem PrintColorAt "[ ADDON5 ] {%addon5%.exe}" 8 5 %cyan11% %black0%
) else (  
rem PrintColorAt "[ ADDON5 ] {'filename5'}" 8 5 %yellow14% %black0%
)
If exist %addondir%\%addon6%.exe (
rem PrintColorAt "[ ADDON6 ] {%addon6%.exe}" 9 5 %cyan11% %black0%
) else (  
rem PrintColorAt "[ ADDON6 ] {'filename6'}" 9 5 %yellow14% %black0%
)
If exist %addondir%\%addon7%.exe (
rem PrintColorAt "[ ADDON7 ] {%addon7%.exe}" 10 5 %cyan11% %black0%
) else (  
rem PrintColorAt "[ ADDON7 ] {'filename7'}" 10 5 %yellow14% %black0%
)
If exist %addondir%\%addon8%.exe (
rem PrintColorAt "[ ADDON8 ] {%addon8%.exe}" 11 5 %cyan11% %black0%
) else (  
rem PrintColorAt "[ ADDON8 ] {'filename8'}" 11 5 %yellow14% %black0%
)
If exist %addondir%\%addon9%.exe (
rem PrintColorAt "[ ADDON9 ] {%addon9%.exe}" 15 5 %cyan11% %black0%
) else (  
rem PrintColorAt "[ ADDON9 ] {'filename9'}" 15 5 %yellow14% %black0%
)
If exist %addondir%\%addon10%.exe (
rem PrintColorAt "[ ADDON10] {%addon10%.exe}" 16 5 %cyan11% %black0%
) else (  
rem PrintColorAt "[ ADDON10] {'filename10'}" 16 5 %yellow14% %black0%
)
If exist %addondir%\%addon11%.exe (
rem PrintColorAt "[ ADDON11] {%addon11%.exe}" 17 5 %cyan11% %black0%
) else (  
rem PrintColorAt "[ ADDON11] {'filename11'}" 17 5 %yellow14% %black0%
)
If exist %addondir%\%addon12%.exe (
rem PrintColorAt "[ ADDON12] {%addon12%.exe}" 18 5 %cyan11% %black0%
) else (  
rem PrintColorAt "[ ADDON12] {'filename12'}" 18 5 %yellow14% %black0%
)
If exist %addondir%\%addon13%.exe (
rem PrintColorAt "[ ADDON13] {%addon13%.exe}" 19 5 %cyan11% %black0%
) else (  
rem PrintColorAt "[ ADDON13] {'filename13'}" 19 5 %yellow14% %black0%
)
If exist %addondir%\%addon14%.exe (
rem PrintColorAt "[ ADDON14] {%addon14%.exe}" 20 5 %cyan11% %black0%
) else (  
rem PrintColorAt "[ ADDON14] {'filename14'}" 20 5 %yellow14% %black0%
)
If exist %addondir%\%addon15%.exe (
rem PrintColorAt "[ ADDON15] {%addon15%.exe}" 21 5 %cyan11% %black0%
) else (  
rem PrintColorAt "[ ADDON15] {'filename15'}" 21 5 %yellow14% %black0%
)
If exist %addondir%\%addon16%.exe (
rem PrintColorAt "[ ADDON16] {%addon16%.exe}" 22 5 %cyan11% %black0%
) else (  
rem PrintColorAt "[ ADDON16] {'filename16'}" 22 5 %yellow14% %black0%
)
rem PrintColorAt "[ <BACK< ]" 23 5 %yellow14% %black0%

rem *************
rem button matrix
rem *************

rem MouseCmd 5,4,14,4 5,5,14,5 5,6,14,6 5,7,14,7 5,8,14,8 5,9,14,9 5,10,14,10 5,11,14,11 5,15,14,15 5,16,14,16 5,17,14,17 5,18,14,18 5,19,14,19 5,20,14,20 5,21,14,21 5,22,14,22 5,23,14,23

If %result% EQU 1 (
If exist %addondir%\%addon1%.exe (
Call :make_button "[ ADDON1 ] {%addon1%.exe}" 4 5 1 10 %cyan11% %btntime% %black0%
start %addondir%\%addon1%.exe
) else (
Call :make_button "[ ADDON1 ] {'filename1' not found.}" 4 5 1 10 %yellow14% %btntime% %black0%
)
)

If %result% EQU 2 (
If exist %addondir%\%addon2%.exe (
Call :make_button "[ ADDON2 ] {%addon2%.exe}" 5 5 1 10 %cyan11% %btntime% %black0%
start %addondir%\%addon2%.exe
) else (
Call :make_button "[ ADDON2 ] {'filename2' not found.}" 5 5 1 10 %yellow14% %btntime% %black0%
)
)

If %result% EQU 3 (
If exist %addondir%\%addon3%.exe (
Call :make_button "[ ADDON3 ] {%addon3%.exe}" 6 5 1 10 %cyan11% %btntime% %black0%
start %addondir%\%addon3%.exe
) else (
Call :make_button "[ ADDON3 ] {'filename3' not found.}" 6 5 1 10 %yellow14% %btntime% %black0%
)
)

If %result% EQU 4 (
If exist %addondir%\%addon4%.exe (
Call :make_button "[ ADDON4 ] {%addon4%.exe}" 7 5 1 10 %cyan11% %btntime% %black0%
start %addondir%\%addon4%.exe
) else (
Call :make_button "[ ADDON4 ] {'filename4' not found.}" 7 5 1 10 %yellow14% %btntime% %black0%
)
)

If %result% EQU 5 (
If exist %addondir%\%addon5%.exe (
Call :make_button "[ ADDON5 ] {%addon5%.exe}" 8 5 1 10 %cyan11% %btntime% %black0%
start %addondir%\%addon5%.exe
) else (
Call :make_button "[ ADDON5 ] {'filename5' not found.}" 8 5 1 10 %yellow14% %btntime% %black0%
)
)

If %result% EQU 6 (
If exist %addondir%\%addon6%.exe (
Call :make_button "[ ADDON6 ] {%addon6%.exe}" 9 5 1 10 %cyan11% %btntime% %black0%
start %addondir%\%addon6%.exe
) else (
Call :make_button "[ ADDON6 ] {'filename6' not found.}" 9 5 1 10 %yellow14% %btntime% %black0%
)
timeout /t %ct1% /nobreak >nul
GoTo ADDONS
)

If %result% EQU 7 (
If exist %addondir%\%addon7%.exe (
Call :make_button "[ ADDON7 ] {%addon7%.exe}" 10 5 1 10 %cyan11% %btntime% %black0%
start %addondir%\%addon7%.exe
) else (
Call :make_button "[ ADDON7 ] {'filename7' not found.}" 10 5 1 10 %yellow14% %btntime% %black0%
)
timeout /t %ct1% /nobreak >nul
GoTo ADDONS
)

If %result% EQU 8 (
If exist %addondir%\%addon8%.exe (
Call :make_button "[ ADDON8 ] {%addon8%.exe}" 11 5 1 10 %cyan11% %btntime% %black0%
start %addondir%\%addon8%.exe
) else (
Call :make_button "[ ADDON8 ] {'filename8' not found.}" 11 5 1 10 %yellow14% %btntime% %black0%
)
timeout /t %ct1% /nobreak >nul
GoTo ADDONS
)

If %result% EQU 9 (
If exist %addondir%\%addon9%.exe (
Call :make_button "[ ADDON9 ] {%addon9%.exe}" 15 5 1 10 %cyan11% %btntime% %black0%
start %addondir%\%addon9%.exe
) else (
Call :make_button "[ ADDON9 ] {'filename9' not found.}" 15 5 1 10 %yellow14% %btntime% %black0%
)
timeout /t %ct1% /nobreak >nul
GoTo ADDONS
)

If %result% EQU 10 (
If exist %addondir%\%addon10%.exe (
Call :make_button "[ ADDON10] {%addon10%.exe}" 16 5 1 10 %cyan11% %btntime% %black0%
start %addondir%\%addon10%.exe
) else (
Call :make_button "[ ADDON10] {'filename10' not found.}" 16 5 1 10 %yellow14% %btntime% %black0%
)
timeout /t %ct1% /nobreak >nul
GoTo ADDONS
)

If %result% EQU 11 (
If exist %addondir%\%addon11%.exe (
Call :make_button "[ ADDON11] {%addon11%.exe}" 17 5 1 10 %cyan11% %btntime% %black0%
start %addondir%\%addon11%.exe
) else (
Call :make_button "[ ADDON11] {'filename11' not found.}" 17 5 1 10 %yellow14% %btntime% %black0%
)
timeout /t %ct1% /nobreak >nul
GoTo ADDONS
)

If %result% EQU 12 (
If exist %addondir%\%addon12%.exe (
Call :make_button "[ ADDON12] {%addon11%.exe}" 18 5 1 10 %cyan11% %btntime% %black0%
start %addondir%\%addon12%.exe
) else (
Call :make_button "[ ADDON12] {'filename12' not found.}" 18 5 1 10 %yellow14% %btntime% %black0%
)
timeout /t %ct1% /nobreak >nul
GoTo ADDONS
)

If %result% EQU 13 (
If exist %addondir%\%addon13%.exe (
Call :make_button "[ ADDON13] {%addon13%.exe}" 19 5 1 10 %cyan11% %btntime% %black0%
start %addondir%\%addon13%.exe
) else (
Call :make_button "[ ADDON13] {'filename13' not found.}" 19 5 1 10 %yellow14% %btntime% %black0%
)
timeout /t %ct1% /nobreak >nul
GoTo ADDONS
)

If %result% EQU 14 (
If exist %addondir%\%addon14%.exe (
Call :make_button "[ ADDON14] {%addon14%.exe}" 20 5 1 10 %cyan11% %btntime% %black0%
start %addondir%\%addon14%.exe
) else (
Call :make_button "[ ADDON14] {'filename14' not found.}" 20 5 1 10 %yellow14% %btntime% %black0%
)
timeout /t %ct1% /nobreak >nul
GoTo ADDONS
)

If %result% EQU 15 (
If exist %addondir%\%addon15%.exe (
Call :make_button "[ ADDON15] {%addon15%.exe}" 21 5 1 10 %cyan11% %btntime% %black0%
start %addondir%\%addon15%.exe
) else (
Call :make_button "[ ADDON15] {'filename15' not found.}" 21 5 1 10 %yellow14% %btntime% %black0%
)
timeout /t %ct1% /nobreak >nul
GoTo ADDONS
)

If %result% EQU 16 (
If exist %addondir%\%addon16%.exe (
Call :make_button "[ ADDON16] {%addon16%.exe}" 22 5 1 10 %cyan11% %btntime% %black0%
start %addondir%\%addon16%.exe
) else (
Call :make_button "[ ADDON16] {'filename16' not found.}" 22 5 1 10 %yellow14% %btntime% %black0%
)
timeout /t %ct1% /nobreak >nul
GoTo ADDONS
)

If %result% EQU 17 (
rem PrintColorAt "{Go 'BACK' to the 'MAIN' menu.}" 23 16 %yellow14% %black0%
Call :make_button "[ <BACK< ]" 23 5 1 10 %yellow14% %btntime% %black0%
GoTo MAIN
)

rem *************
rem wintools menu
rem *************

:WINTOOLS
Set lmenu=WINTOOLS
Call :show_me %black0% 1 1
rem PrintColorAt "{%lmenu%}" 3 5 %gray7% %black0%
rem PrintColorAt "[CLEANMGR]" 4 5 %cyan11% %black0%
rem PrintColorAt "[MSCONFIG]" 5 5 %cyan11% %black0%
rem PrintColorAt "[ NOTEPAD]" 6 5 %cyan11% %black0%
rem PrintColorAt "[ REGEDIT]" 7 5 %cyan11% %black0%
rem PrintColorAt "[SERVICES]" 8 5 %cyan11% %black0%
rem PrintColorAt "[ TASKMGR]" 9 5 %cyan11% %black0%
rem PrintColorAt "[TASKSCHD]" 10 5 %cyan11% %black0%
rem PrintColorAt "[ <BACK< ]" 11 5 %yellow14% %black0%

rem *************
rem button matrix
rem *************

rem MouseCmd 5,4,14,4 5,5,14,5 5,6,14,6 5,7,14,7 5,8,14,8 5,9,14,9 5,10,14,10 5,11,14,11

rem run chkdsk
If %result% EQU 0 Call :chkdsk-scan

If %result% EQU 1 (
rem PrintColorAt "{Run the 'CLEANMGR' tool.}" 4 16 %cyan11% %black0%
Call :make_button "[CLEANMGR]" 4 5 1 10 %cyan11% %btntime% %black0%
Call :run_command "cleanmgr.exe" 20 >nul
)

If %result% EQU 2 (
rem PrintColorAt "{Run the 'MSCONFIG' tool.}" 5 16 %cyan11% %black0%
Call :make_button "[MSCONFIG]" 5 5 1 10 %cyan11% %btntime% %black0%
Call :run_command "msconfig.exe" 20 >nul
)

If %result% EQU 3 (
rem PrintColorAt "{Run the 'NOTEPAD' tool.}" 6 16 %cyan11% %black0%
Call :make_button "[ NOTEPAD]" 6 5 1 10 %cyan11% %btntime% %black0%
Call :run_command "notepad.exe" 20 >nul
)

If %result% EQU 4 (
rem PrintColorAt "{Run the 'REGEDIT' tool.}" 7 16 %cyan11% %black0%
Call :make_button "[ REGEDIT]" 7 5 1 10 %cyan11% %btntime% %black0%
Call :run_command "regedit.exe" 20 >nul
)

If %result% EQU 5 (
rem PrintColorAt "{Run the 'SERVICES' tool.}" 8 16 %cyan11% %black0%
Call :make_button "[SERVICES]" 8 5 1 10 %cyan11% %btntime% %black0%
Call :run_command "services.msc" 20 >nul
)

If %result% EQU 6 (
rem PrintColorAt "{Run the 'TASKMGR' tool.}" 9 16 %cyan11% %black0%
Call :make_button "[ TASKMGR]" 9 5 1 10 %cyan11% %btntime% %black0%
Call :run_command "taskmgr.exe /7" 20 >nul
)

If %result% EQU 7 (
rem PrintColorAt "{Run the 'TASKSCHD' tool.}" 10 16 %cyan11% %black0%
Call :make_button "[TASKSCHD]" 10 5 1 10 %cyan11% %btntime% %black0%
Call :run_command "taskschd.msc /s" 20 >nul
)

If %result% EQU 8 (
rem PrintColorAt "{Go 'BACK' to the 'MAIN' menu.}" 11 16 %yellow14% %black0%
Call :make_button "[ <BACK< ]" 11 5 1 10 %yellow14% %btntime% %black0%
GoTo MAIN
)
GoTo WINTOOLS

rem *****************
rem begin subroutines
rem *****************
rem *******
rem restart
rem *******

:RESTART
Call :show_me %black0% 0 0
rem PrintCenter "{ Restarting System In %wshutdown% Second(s). }" 12 %yellow14% %red4%
timeout /t %ct2% /nobreak >nul
Call :run_command "shutdown /R /T %wshutdown%" 20 >nul
ENDLOCAL
Exit /B %errorlevel%

:show_me
mode con:cols=80 lines=25
rem CursorHide
rem ClearColor
rem PaintScreen %1
:redo1
rem GenRandom 15
If %result% EQU 0 GoTo redo1
If %2 EQU 1 (
rem PrintCenter "%title1%::{%lmenu%} Menu" 1 %result% %black0%
If %3 EQU 1 (
rem PrintCenter "{ Choose An Option From The '%lmenu%' Menu }" 13 %result% %black0%
rem PrintCenter "{ CHKDSK=num0 }" 14 %result% %black0%
) else (
rem PrintCenter "{ Choose An Option From The '%lmenu%' Menu }" 13 %result% %black0%
)
rem PrintColorAt "{ ZoneSoft (c2024-26) zonemaster60@gmail.com }" 25 18 %result% %black0%
)
rem CursorHide
GOTO:EOF

rem *********************************
rem run a command with error checking
rem *********************************

:run_command
rem CursorHide
rem PrintColorAt "> %TIME%" 4 2 %green10% %black0%
rem PrintColorAt ">> %1" 5 2 %result% %black0%
rem PrintReturn
rem PrintReturn
rem PrintCenter "{ Do Not Close This Window, It Will Close When ALL Tasks Are Done. }" 7 %yellow14% %red4%
rem PrintReturn
rem ChangeColor %result% %black0%
Cmd /c %1
If %errorlevel% EQU 0 (
rem PrintReturn
rem PrintColorAt "> %TIME%                   { Success }" 24 2 %green10% %black0%
rem PrintColorAt "{ Please Wait... }" 25 30 %green10% %black0%
)
If %errorlevel% EQU 1 (
rem PrintReturn
rem PrintColorAt "> %TIME%                   { Failure }" 24 2 %yellow14% %red4%
rem PrintColorAt "{ Please Wait... }" 25 30 %yellow14% %red4%
echo %1:error:%errorlevel%>>errors.log
)
rem CursorHide
GOTO:EOF

rem ****************
rem next_page button
rem ****************

:next_page
rem CursorHide
rem PrintColorAt "[ >>>>>> ]" 25 35 %green10% %black0%
rem MouseCmd 35,25,44,25

If %result% EQU 1 (
rem PrintColorAt "{next item.}" 25 46 %green10% %black0%
Call :make_button "[ >>>>>> ]" 25 35 1 10 %green10% %btntime% %black0%
)
rem CursorHide
GOTO:EOF

rem *******************
rem makes a menu button
rem *******************

:make_button
rem CursorHide
rem ************************************************************
rem Call :make_button "btnname" line col hgt wid cfg btntime cbg
rem ************************************************************
rem PaintBoxAt %2 %3 %4 %5 %6
rem Wait %7
rem PrintColorAt %1 %2 %3 %6 %8
rem Wait %7
rem ********************
rem len1 = (%3 + %5) - 1
rem ********************
rem Add %3 %5
rem Subtract %result% 1
Set len1=%result%
rem CursorHide
GOTO:EOF

:chkdsk-scan
rem run chkdsk
Call :show_me %black0% 0 0
Call :run_command "chkdsk c: /scan" 2
timeout /t %ct2% /nobreak >nul
Set setchkdsk=0
GOTO:EOF

rem ***************
rem end subroutines
rem ***************