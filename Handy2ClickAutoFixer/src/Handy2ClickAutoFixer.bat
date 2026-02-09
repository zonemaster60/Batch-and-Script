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
REM BFCPEVERVERSION=1.1.3.4
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
Set winupdate=False
Set version=v1.1.3.4

rem ******************
rem set initial values
rem ******************
Set analyze=False
Set repair=False
Set skipped=False

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
Title {Handy2ClickAutoFixer :: %version%}
Set title1={Handy2ClickAutoFixer::%version%}

rem *******************
rem windows repair logs
rem *******************
Set "CBSlog=C:\Windows\Logs\CBS\CBS.log"
Set "DISMlog=C:\Windows\Logs\DISM\DISM.log"

rem **********************
rem *calculate # of addons
rem **********************
Set "addondir=addons"
Set "addonfile=addons.txt"
Set "readme=readme.1st.txt"
Set "viewer=viewer.exe"

If exist "%addonfile%" (
Set /a count=0
for /f "usebackq delims=" %%A in ("%addonfile%") do (
    Set /a count+=1
    Set "addon!count!=%%A"
)
Set max=16
) else (
Set count=0
Set max=16
)

rem make folder if 'addons.txt' exists
If exist %addonfile% mkdir %addondir% >nul 2>&1

rem ********************
rem check for powershell
rem ********************
rem CursorHide
rem PaintScreen 0
rem PrintColorAt "{ Checking for Java versions... }" 2 2 %yellow14% %black0%
where java >nul 2>&1
if %errorlevel% EQU 0 (
rem PrintColorAt "{ Java Is Installed. }" 3 6 %green10% %black0%
) else (
rem PrintColorAt "{ Java Is NOT Installed. }" 3 6 %yellow14% %red4%
)
timeout /t %ct1% /nobreak >nul
rem PrintColorAt "{ Checking for PowerShell versions... }" 5 2 %yellow14% %black0%
where powershell >nul 2>&1
If %errorlevel% EQU 0 (
rem PrintColorAt "{ PowerShell Is Installed. }" 6 6 %green10% %black0%
) else (
rem PrintColorAt "{ PowerShell Is NOT Installed. }" 6 6 %yellow14% %red4%
)
timeout /t %ct1% /nobreak >nul
where pwsh >nul 2>&1
If %errorlevel% EQU 0 (
rem PrintColorAt "{ PowerShell Core Is Installed. }" 7 6 %green10% %black0%
) else (
rem PrintColorAt "{ PowerShell Core Is NOT Installed. }" 7 6 %yellow14% %red4%
)
timeout /t %ct1% /nobreak >nul
rem PrintColorAt "{ Checking for Python versions... }" 9 2 %yellow14% %black0%
where python >nul 2>&1
if %errorlevel% EQU 0 (
rem PrintColorAt "{ Python Is Installed. }" 10 6 %green10% %black0%
) else (
rem PrintColorAt "{ Python Is NOT Installed. }" 10 6 %yellow14% %red4%
)
timeout /t %ct1% /nobreak >nul

rem *********
rem main menu
rem *********

:MAIN
Set lmenu=MAIN
Call :show_me %black0% 1
rem PrintColorAt "{%lmenu%MENU}" 3 5 %gray7% %black0%
rem PrintColorAt "[ ANALYZE]" 4 5 %yellow14% %black0%
rem PrintColorAt "[ REPAIR ]" 5 5 %green10% %black0%
rem PrintColorAt "[  INFO  ]" 6 5 %magenta13% %black0%
If exist %viewer% (
rem PrintColorAt "[VIEWLOGS]" 7 5 %cyan3% %black0%
) else (
rem PrintColorAt "[VIEWLOGS]" 7 5 %yellow14% %black0%
)
rem PrintColorAt "[WINTOOLS]" 8 5 %cyan11% %black0%
rem PrintColorAt "[  EXIT  ]" 9 5 %red12% %black0%
rem PrintCenter "{ To Access The 'CHKDSK' Menu, Press '0' key }" 14 %result% %black0%

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
Set /a avl=%max%-%count%
If exist %addonfile% (
rem PrintColorAt "[ ADDONS ]" 7 66 %cyan3% %black0%
rem PrintColorAt "{U:%count%|A:%avl%}" 8 66 %cyan3% %black0%
) else (
rem PrintColorAt "[ ADDONS ]" 7 66 %yellow14% %black0%
rem PrintColorAt "{U:%count%|A:%avl%}" 8 66 %yellow14% %black0%
)
rem viewer or notepad
If exist %viewer% (
rem PrintColorAt "[ README ]" 9 66 %cyan3% %black0%
) else (
rem PrintColorAt "[ README ]" 9 66 %yellow14% %black0%
)

rem *************
rem button matrix
rem *************

rem MouseCmd 5,4,14,4 5,5,14,5 5,6,14,6 5,7,14,7 5,8,14,8 5,9,14,9 66,7,75,7 66,9,75,9

rem run chkdsk
If %result% EQU 0 GoTo CHKDSK

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
If exist %viewer% (
rem PrintColorAt "{View the repair 'LOGS' CBS/DISM.}" 7 16 %cyan3% %black0%
Call :make_button "[VIEWLOGS]" 7 5 1 10 %cyan3% %btntime% %black0%
Goto VIEWLOGS
) else (
rem PrintColorAt "{View the repair 'LOGS' CBS/DISM.}" 7 16 %yellow14% %black0%
Call :make_button "[VIEWLOGS]" 7 5 1 10 %yellow14% %btntime% %black0%
Goto VIEWLOGS
)
)

If %result% EQU 5 (
rem PrintColorAt "{Go to the 'WINTOOLS' menu.}" 8 16 %cyan11% %black0%
Call :make_button "[WINTOOLS]" 8 5 1 10 %cyan11% %btntime% %black0%
GoTo WINTOOLS
)

If %result% EQU 6 (
rem PrintColorAt "{Go to the 'EXIT' menu.}" 9 16 %red12% %black0%
Call :make_button "[  EXIT  ]" 9 5 1 10 %red12% %btntime% %black0%
Goto EXIT
)

If %result% EQU 7 (
If exist %addonfile% (
rem PrintColorAt "{Go to the 'ADDONS' menu.}" 7 39 %cyan3% %black0%
Call :make_button "[ ADDONS ]" 7 66 1 10 %cyan3% %btntime% %black0%
GoTo ADDONS
) else (
rem PrintColorAt "{'%addonfile%' not found.}" 7 40 %yellow14% %black0%
Call :make_button "[ ADDONS ]" 7 66 1 10 %yellow14% %btntime% %black0%
GoTo MAIN
)
)

If %result% EQU 8 (
If exist %viewer% (
rem PrintColorAt "{View the 'readme' with %viewer%.}" 9 29 %cyan3% %black0%
Call :make_button "[ README ]" 9 66 1 10 %cyan3% %btntime% %black0%
Call :run_command "start %viewer% %readme%" "" >nul
) else (
rem PrintColorAt "{View the 'readme' with notepad.exe.}" 9 28 %yellow14% %black0%
Call :make_button "[ README ]" 9 66 1 10 %yellow14% %btntime% %black0%
Call :run_command "start notepad.exe %readme%" "" >nul
GoTo MAIN
)
)
GoTo MAIN

rem ************
rem analyze menu
rem ************

:ANALYZE
Set lmenu=ANALYZE
Call :show_me %black0% 1
rem PrintColorAt "{ %lmenu%}" 3 5 %gray7% %black0%
rem PrintColorAt "[  SCAN  ]" 4 5 %cyan11% %black0%
rem PrintColorAt "[  CHECK ]" 5 5 %cyan11% %black0%
rem PrintColorAt "[ <BACK< ]" 6 5 %yellow14% %gray8%

rem *************
rem button matrix
rem *************

rem MouseCmd 5,4,14,4 5,5,14,5 5,6,14,6

If %result% EQU 1 (
rem PrintColorAt "{'SCAN' the image health-slow.}" 4 16 %cyan11% %black0%
Call :make_button "[  SCAN  ]" 4 5 1 10 %cyan11% %btntime% %black0%
Call :show_me %black0% 0
Set chkhealth=False
GoTo ANALYZE1
)

If %result% EQU 2 (
rem PrintColorAt "{'CHECK' the image health-fast.}" 5 16 %cyan11% %black0%
Call :make_button "[  CHECK ]" 5 5 1 10 %cyan11% %btntime% %black0%
Call :show_me %black0% 0
Set chkhealth=True
GoTo ANALYZE1
)

If %result% EQU 3 (
rem PrintColorAt "{Go 'BACK' to the 'MAIN' menu.}" 6 16 %yellow14% %black0%
Call :make_button "[ <BACK< ]" 6 5 1 10 %yellow14% %btntime% %gray8%
GoTo MAIN
)
GoTo ANALYZE

:ANALYZE1
rem ***********
rem analyze now
rem *********************
rem check component store
rem *********************

Call :show_me %black0% 0
rem PrintCenter "{ %lmenu% > 1/3 > Analyzes the system component store for errors. }" 2 %blue9% %black0%
Call :run_command "dism /online /cleanup-image /analyzecomponentstore" ""
timeout /t %ct2% /nobreak >nul
Call :CONTINUE

rem ********************
rem check or scan health
rem ********************

Call :show_me %black0% 0
If %chkhealth% EQU True (
rem PrintCenter "{ %lmenu% > 2/3 > CheckHealth is faster, but not as thorough. }" 2 %blue9% %black0%
Call :run_command "dism /online /cleanup-image /checkhealth" ""
) else (
rem PrintCenter "{ %lmenu% > 2/3 > ScanHealth is slower, but performs a better test. }" 2 %blue9% %black0%
Call :run_command "dism /online /cleanup-image /scanhealth" ""
timeout /t %ct2% /nobreak >nul
)
Call :CONTINUE

rem ************
rem verify files
rem ************

Call :show_me %black0% 0
rem PrintCenter "{ %lmenu% > 3/3 > Verifies, but does not replace any system files. }" 2 %blue9% %black0%
Call :run_command "sfc /verifyonly" ""
timeout /t %ct2% /nobreak >nul
Set analyze=True
Set skipped=False
Call :CONTINUE
GoTo MAIN

rem ***********
rem repair menu
rem ***********

:REPAIR
Set lmenu=REPAIR
Call :show_me %black0% 1
rem PrintColorAt "{ %lmenu% }" 3 5 %gray7% %black0%
rem PrintColorAt "[ REPAIR ]" 4 5 %cyan11% %black0%
rem PrintColorAt "[ REPAIR+]" 5 5 %cyan11% %black0%
rem PrintColorAt "[BASELINE]" 6 5 %cyan11% %black0%
rem PrintColorAt "[ <BACK< ]" 7 5 %yellow14% %gray8%

rem *************
rem button matrix
rem *************

rem MouseCmd 5,4,14,4 5,5,14,5 5,6,14,6 5,7,14,7

If %result% EQU 1 (
rem PrintColorAt "{'REPAIR' the system image.}" 4 16 %cyan11% %black0%
Call :make_button "[ REPAIR ]" 4 5 1 10 %cyan11% %btntime% %black0%
Call :show_me %black0% 0
Set resetbase=False
GoTo REPAIR1
)

If %result% EQU 2 (
rem PrintColorAt "{'REPAIR+' the image using Windows Update.}" 5 16 %cyan11% %black0%
Call :make_button "[ REPAIR+]" 5 5 1 10 %cyan11% %btntime% %black0%
Call :show_me %black0% 0
Set winupdate=True
GoTo REPAIR1
)

If %result% EQU 3 (
rem PrintColorAt "{'REPAIR' system image, reset to 'BASELINE'.}" 6 16 %cyan11% %black0%
Call :make_button "[BASELINE]" 6 5 1 10 %cyan11% %btntime% %black0%
Set resetbase=True
GoTo REPAIR1
)

If %result% EQU 4 (
rem PrintColorAt "{Go 'BACK' to the 'MAIN' menu.}" 7 16 %yellow14% %black0%
Call :make_button "[ <BACK< ]" 7 5 1 10 %yellow14% %btntime% %gray8%
GoTo MAIN
)
GoTo REPAIR

:REPAIR1
rem **********
rem repair now
rem **************************
rem resetbase / normal cleanup
rem **************************

Call :show_me %black0% 0
If %resetbase% EQU True (
rem PrintCenter "{ %lmenu% > 1/3 > Reset the entire system component store to baseline. }" 2 %blue9% %black0%
Call :run_command "dism /online /cleanup-image /startcomponentcleanup /resetbase" ""
timeout /t %ct2% /nobreak >nul
) else (
rem PrintCenter "{ %lmenu% > 1/3 > Perform a normal system component store cleanup. }" 2 %blue9% %black0%
Call :run_command "dism /online /cleanup-image /startcomponentcleanup" ""
timeout /t %ct2% /nobreak >nul
)
Call :CONTINUE

rem **************
rem restore health
rem **************

Call :show_me %black0% 0
If %winupdate% EQU False (
rem PrintCenter "{ %lmenu% > 2/3 > Clean, update, and restore the system image health. }" 2 %blue9% %black0%
Call :run_command "dism /online /cleanup-image /restorehealth" ""
timeout /t %ct2% /nobreak >nul
) else (
rem PrintCenter "{ %lmenu% > 2/3 > Clean, update, and restore using Windows Update. }" 2 %blue9% %black0%
Call :run_command "dism /online /cleanup-image /restorehealth /source:windowsupdate" ""
timeout /t %ct2% /nobreak >nul
)
Call :CONTINUE

rem ********
rem scan now
rem ********

Call :show_me %black0% 0
rem PrintCenter "{ %lmenu% > 3/3 > Scans, and replaces any corrupted system files. }" 2 %blue9% %black0%
Call :run_command "sfc /scannow" ""
timeout /t %ct2% /nobreak >nul
If %analyze% EQU False (
Set skipped=True
) else (
Set skipped=False
Set analyze=True
)
Set repair=True
Call :CONTINUE
GoTo RESTART

rem ***********
rem info part 1
rem ***********

:INFO1
Call :show_me %black0% 0
Set lmenu=INFO1
rem PrintCenter "%title1%" 1 %cyan3% %black0%
rem PrintCenter "{%lmenu%}" 2 %cyan3% %black0%
rem PrintCenter "{ Use The Mouse to Navigate or the Number 0-9 Keys }" 4 %yellow14% %black0%
rem PrintCenter "[ ANALYZE ] This uses DISM and SFC to analyze" 6 %yellow14% %black0%
rem PrintCenter "any corrupted system files. [SCAN] and [CHECK] are options." 7 %yellow14% %black0%
rem PrintCenter "[ REPAIR ] This uses DISM and SFC to repair" 9 %green10% %black0%
rem PrintCenter "any corrupted system files. [REPAIR], [REPAIR+] and [BASELINE] are options." 10 %green10% %black0%
rem PrintCenter "[ INFO ] You are reading it now. {3 pages}" 12 %magenta13% %black0%
If exist %viewer% (
rem PrintCenter "[VIEWLOGS] View the CBS and DISM system logs." 14 %cyan3% %black0%
) else (
rem PrintCenter "[VIEWLOGS] View the CBS and DISM system logs." 14 %yellow14% %black0%
)
rem PrintCenter "[WINTOOLS] Access the windows built in tools." 16 %cyan11% %black0%
rem PrintCenter "[ EXIT ] Exit the program." 18 %red12% %black0%
Call :next_page

rem ***********
rem info part 2
rem ***********

:INFO2
Call :show_me %black0% 0
Set lmenu=INFO2
rem PrintCenter "%title1%" 1 %cyan3% %black0%
rem PrintCenter "{%lmenu%}" 2 %cyan3% %black0%
rem PrintCenter "{ Use The Mouse to Navigate or the Number 0-9 Keys }" 4 %yellow14% %black0%
rem PrintCenter "{ STATUS } The status of [ ANALYZE ] and [ REPAIR ] system image tasks." 6 %gray7% %black0%
rem PrintCenter "{ ------ } ------/ DONE [ ANALYZE ] system image task." 8 %gray7% %black0%
rem PrintCenter "{ ------ } ------/ DONE [ REPAIR ] system image task." 10 %gray7% %black0%
rem PrintCenter "{ OPTION } Options are [ ADDONS ]." 12 %gray7% %black0%
If exist %addonfile% (
rem PrintCenter "[ ADDONS ] If you have (portable .exe's) you can access them from here." 14 %cyan3% %black0%
rem PrintCenter "{U:XX|A:XX} U:XX = USED addon slots, A:XX = AVAILABLE addon slots." 16 %cyan3% %black0%
) else (
rem PrintCenter "[ ADDONS ] If you have (portable .exe's) you can access them from here." 14 %yellow14% %black0%
rem PrintCenter "{U:XX|A:XX} U:XX = USED addon slots, A:XX = AVAILABLE addon slots." 16 %yellow14% %black0%
)
If exist %viewer%% (
rem PrintCenter "[ README ] View the readme using 'Notepad' or your own viewer." 18 %cyan3% %black0% 
) else (
rem PrintCenter "[ README ] View the readme using 'Notepad' or your own viewer." 18 %yellow14% %black0% 
)
Call :next_page

rem ***********
rem info part 3
rem ***********

:INFO3
Call :show_me %black0% 0
Set lmenu=INFO3
rem PrintCenter "%title1%" 1 %cyan3% %black0%
rem PrintCenter "{%lmenu%}" 2 %cyan3% %black0%
rem PrintCenter "{ Use The Mouse to Navigate or the Number 0-9 Keys }" 4 %yellow14% %black0%
rem PrintColorAt "Architecture: %PROCESSOR_ARCHITECTURE%" 6 10 %gray7% %black0%
rem PrintColorAt "ComputerName: %computername%" 7 10 %cyan3% %black0%
rem PrintColorAt "HomeDrive: %homedrive%" 8 10 %cyan3% %black0%
rem PrintColorAt "HomePath: %homepath%" 9 10 %cyan3% %black0%
rem PrintColorAt "OneDrive: %homedrive%%homepath%\OneDrive" 10 10 %cyan3% %black0%
rem PrintColorAt "Operating System: %os%" 11 10 %magenta13% %black0%
rem PrintColorAt "Processor ID: %PROCESSOR_IDENTIFIER%" 12 10 %magenta13% %black0%
rem PrintColorAt "# of Processors: %NUMBER_OF_PROCESSORS%" 13 10 %magenta13% %black0%
rem PrintColorAt "UserName: %username%" 14 10 %cyan11% %black0%
rem PrintColorAt "Windows: %POWERSHELL_DISTRIBUTION_CHANNEL%" 15 10 %cyan11% %black0%
rem PrintColorAt "Windows Directory: %windir%" 16 10 %cyan11% %black0%
rem PrintCenter "{ Thank you for taking the time to try this program. }" 18 %green10% %black0%
Call :next_page
GoTo MAIN

rem ********************
rem view the repair logs
rem ********************
:VIEWLOGS
Set lmenu=VIEWLOGS
Call :show_me %black0% 1
rem PrintColorAt "{%lmenu%}" 3 5 %gray7% %black0%
If exist %viewer% (
rem PrintColorAt "[   CBS  ]" 4 5 %cyan11% %black0%
rem PrintColorAt "[  DISM  ]" 5 5 %cyan11% %black0%
) else (
rem PrintColorAt "[   CBS  ]" 4 5 %yellow14% %black0%
rem PrintColorAt "[  DISM  ]" 5 5 %yellow14% %black0%
)
rem PrintColorAt "[ <BACK< ]" 6 5 %yellow14% %gray8%

rem *************
rem button matrix
rem *************

rem MouseCmd 5,4,14,4 5,5,14,5 5,6,14,6

If %result% EQU 1 (
If exist %viewer% (
rem PrintColorAt "{View the 'CBS' logs with %viewer%.}" 4 16 %cyan11% %black0%
Call :make_button "[   CBS  ]" 4 5 1 10 %cyan11% %btntime% %black0%
Call :run_command "start %viewer% %CBSlog%" "" >nul
) else (
rem PrintColorAt "{View the 'CBS' logs with notepad.exe.}" 4 16 %yellow14% %black0%
Call :make_button "[   CBS  ]" 4 5 1 10 %yellow14% %btntime% %black0%
Call :run_command "start notepad.exe %CBSlog%" "" >nul
GoTo MAIN
)
)

If %result% EQU 2 (
If exist %viewer% (
rem PrintColorAt "{View the 'DISM' logs with %viewer%.}" 5 16 %cyan11% %black0%
Call :make_button "[  DISM  ]" 5 5 1 10 %cyan11% %btntime% %black0%
Call :run_command "start %viewer% %DISMlog%" "" >nul
) else (
rem PrintColorAt "{View the 'DISM' logs with notepad.exe.}" 5 16 %yellow14% %black0%
Call :make_button "[  DISM  ]" 5 5 1 10 %yellow14% %btntime% %black0%
Call :run_command "start notepad.exe %DISMlog%" "" >nul
GoTo MAIN
)
)

If %result% EQU 3 (
rem PrintColorAt "{Go 'BACK' to the 'MAIN' menu.}" 6 16 %yellow14% %black0%
Call :make_button "[ <BACK< ]" 6 5 1 10 %yellow14% %btntime% %gray8%
GoTo MAIN
)
GoTo VIEWLOGS

rem *********
rem exit menu
rem *********

:EXIT
Set lmenu=EXIT
Call :show_me %black0% 1
rem PrintColorAt "{  %lmenu%  }" 3 5 %gray7% %black0%
rem PrintColorAt "[  EXIT  ]" 4 5 %red12% %black0%
rem PrintColorAt "[ <BACK< ]" 5 5 %yellow14% %gray8%

rem *************
rem button matrix
rem *************

rem MouseCmd 5,4,14,4 5,5,14,5

If %result% EQU 1 (
rem PrintColorAt "{'EXIT' to the OS.}" 4 16 %red12% %black0%
Call :make_button "[  EXIT  ]" 4 5 1 10 %red12% %btntime% %black0%
Call :show_me %black0% 0
rem PrintCenter "{ Thank you for using this FREE Software. }" 13 %green10% %black0%
timeout /t %ct2% /nobreak >nul
ENDLOCAL
Exit /B %ErrorLevel%
)

If %result% EQU 2 (
rem PrintColorAt "{Go 'BACK' to the 'MAIN' menu.}" 5 16 %yellow14% %black0%
Call :make_button "[ <BACK< ]" 5 5 1 10 %yellow14% %btntime% %gray8%
GoTo MAIN
)
GoTo EXIT

:ADDONS
Set lmenu=ADDONS
Call :show_me %black0% 1
rem PrintColorAt "{ %lmenu% }" 3 5 %gray7% %black0%
If exist %addondir%\%addon1%.exe (
rem PrintColorAt "[ADDON-01] {%addon1%.exe}" 4 5 %cyan11% %black0%
) else (
rem PrintColorAt "[ADDON-01] {'filename01'}" 4 5 %yellow14% %black0%
)
If exist %addondir%\%addon2%.exe (
rem PrintColorAt "[ADDON-02] {%addon2%.exe}" 5 5 %cyan11% %black0%
) else (
rem PrintColorAt "[ADDON-02] {'filename02'}" 5 5 %yellow14% %black0%
)
If exist %addondir%\%addon3%.exe (
rem PrintColorAt "[ADDON-03] {%addon3%.exe}" 6 5 %cyan11% %black0%
) else (
rem PrintColorAt "[ADDON-03] {'filename03'}" 6 5 %yellow14% %black0%
)
If exist %addondir%\%addon4%.exe (
rem PrintColorAt "[ADDON-04] {%addon4%.exe}" 7 5 %cyan11% %black0%
) else (
rem PrintColorAt "[ADDON-04] {'filename04'}" 7 5 %yellow14% %black0%
)
If exist %addondir%\%addon5%.exe (
rem PrintColorAt "[ADDON-05] {%addon5%.exe}" 8 5 %cyan11% %black0%
) else (  
rem PrintColorAt "[ADDON-05] {'filename05'}" 8 5 %yellow14% %black0%
)
If exist %addondir%\%addon6%.exe (
rem PrintColorAt "[ADDON-06] {%addon6%.exe}" 9 5 %cyan11% %black0%
) else (  
rem PrintColorAt "[ADDON-06] {'filename06'}" 9 5 %yellow14% %black0%
)
If exist %addondir%\%addon7%.exe (
rem PrintColorAt "[ADDON-07] {%addon7%.exe}" 10 5 %cyan11% %black0%
) else (  
rem PrintColorAt "[ADDON-07] {'filename07'}" 10 5 %yellow14% %black0%
)
If exist %addondir%\%addon8%.exe (
rem PrintColorAt "[ADDON-08] {%addon8%.exe}" 11 5 %cyan11% %black0%
) else (  
rem PrintColorAt "[ADDON-08] {'filename08'}" 11 5 %yellow14% %black0%
)
If exist %addondir%\%addon9%.exe (
rem PrintColorAt "[ADDON-09] {%addon9%.exe}" 15 5 %cyan11% %black0%
) else (  
rem PrintColorAt "[ADDON-09] {'filename09'}" 15 5 %yellow14% %black0%
)
If exist %addondir%\%addon10%.exe (
rem PrintColorAt "[ADDON-10] {%addon10%.exe}" 16 5 %cyan11% %black0%
) else (  
rem PrintColorAt "[ADDON-10] {'filename10'}" 16 5 %yellow14% %black0%
)
If exist %addondir%\%addon11%.exe (
rem PrintColorAt "[ADDON-11] {%addon11%.exe}" 17 5 %cyan11% %black0%
) else (  
rem PrintColorAt "[ADDON-11] {'filename11'}" 17 5 %yellow14% %black0%
)
If exist %addondir%\%addon12%.exe (
rem PrintColorAt "[ADDON-12] {%addon12%.exe}" 18 5 %cyan11% %black0%
) else (  
rem PrintColorAt "[ADDON-12] {'filename12'}" 18 5 %yellow14% %black0%
)
If exist %addondir%\%addon13%.exe (
rem PrintColorAt "[ADDON-13] {%addon13%.exe}" 19 5 %cyan11% %black0%
) else (  
rem PrintColorAt "[ADDON-13] {'filename13'}" 19 5 %yellow14% %black0%
)
If exist %addondir%\%addon14%.exe (
rem PrintColorAt "[ADDON-14] {%addon14%.exe}" 20 5 %cyan11% %black0%
) else (  
rem PrintColorAt "[ADDON-14] {'filename14'}" 20 5 %yellow14% %black0%
)
If exist %addondir%\%addon15%.exe (
rem PrintColorAt "[ADDON-15] {%addon15%.exe}" 21 5 %cyan11% %black0%
) else (  
rem PrintColorAt "[ADDON-15] {'filename15'}" 21 5 %yellow14% %black0%
)
If exist %addondir%\%addon16%.exe (
rem PrintColorAt "[ADDON-16] {%addon16%.exe}" 22 5 %cyan11% %black0%
) else (  
rem PrintColorAt "[ADDON-16] {'filename16'}" 22 5 %yellow14% %black0%
)
rem PrintColorAt "[ <BACK< ]" 23 5 %yellow14% %gray8%

rem *************
rem button matrix
rem *************

rem MouseCmd 5,4,14,4 5,5,14,5 5,6,14,6 5,7,14,7 5,8,14,8 5,9,14,9 5,10,14,10 5,11,14,11 5,15,14,15 5,16,14,16 5,17,14,17 5,18,14,18 5,19,14,19 5,20,14,20 5,21,14,21 5,22,14,22 5,23,14,23

If %result% EQU 1 (
If exist %addondir%\%addon1%.exe (
Call :make_button "[ADDON-01] {%addon1%.exe}" 4 5 1 10 %cyan11% %btntime% %black0%
Call :run_command "start %addondir%\%addon1%.exe" "" >nul
) else (
Call :make_button "[ADDON-01] {'filename01' not found.}" 4 5 1 10 %yellow14% %btntime% %black0%
)
GoTo ADDONS
)

If %result% EQU 2 (
If exist %addondir%\%addon2%.exe (
Call :make_button "[ADDON-02] {%addon2%.exe}" 5 5 1 10 %cyan11% %btntime% %black0%
Call :run_command "start %addondir%\%addon2%.exe" "" >nul
) else (
Call :make_button "[ADDON-02] {'filename02' not found.}" 5 5 1 10 %yellow14% %btntime% %black0%
)
GoTo ADDONS
)

If %result% EQU 3 (
If exist %addondir%\%addon3%.exe (
Call :make_button "[ADDON-03] {%addon3%.exe}" 6 5 1 10 %cyan11% %btntime% %black0%
Call :run_command "start %addondir%\%addon3%.exe" "" >nul
) else (
Call :make_button "[ADDON-03] {'filename03' not found.}" 6 5 1 10 %yellow14% %btntime% %black0%
)
GoTo ADDONS
)

If %result% EQU 4 (
If exist %addondir%\%addon4%.exe (
Call :make_button "[ADDON-04] {%addon4%.exe}" 7 5 1 10 %cyan11% %btntime% %black0%
Call :run_command "start %addondir%\%addon4%.exe" "" >nul
) else (
Call :make_button "[ADDON-04] {'filename04' not found.}" 7 5 1 10 %yellow14% %btntime% %black0%
)
GoTo ADDONS
)

If %result% EQU 5 (
If exist %addondir%\%addon5%.exe (
Call :make_button "[ADDON-05] {%addon5%.exe}" 8 5 1 10 %cyan11% %btntime% %black0%
Call :run_command "start %addondir%\%addon5%.exe" "" >nul
) else (
Call :make_button "[ADDON-05] {'filename05' not found.}" 8 5 1 10 %yellow14% %btntime% %black0%
)
GoTo ADDONS
)

If %result% EQU 6 (
If exist %addondir%\%addon6%.exe (
Call :make_button "[ADDON-06] {%addon6%.exe}" 9 5 1 10 %cyan11% %btntime% %black0%
Call :run_command "start %addondir%\%addon6%.exe" "" >nul
) else (
Call :make_button "[ADDON-06] {'filename06' not found.}" 9 5 1 10 %yellow14% %btntime% %black0%
)
GoTo ADDONS
)

If %result% EQU 7 (
If exist %addondir%\%addon7%.exe (
Call :make_button "[ADDON-07] {%addon7%.exe}" 10 5 1 10 %cyan11% %btntime% %black0%
Call :run_command "start %addondir%\%addon7%.exe" "" >nul
) else (
Call :make_button "[ADDON-07] {'filename07' not found.}" 10 5 1 10 %yellow14% %btntime% %black0%
)
GoTo ADDONS
)

If %result% EQU 8 (
If exist %addondir%\%addon8%.exe (
Call :make_button "[ADDON-08] {%addon8%.exe}" 11 5 1 10 %cyan11% %btntime% %black0%
Call :run_command "start %addondir%\%addon8%.exe" "" >nul
) else (
Call :make_button "[ADDON-08] {'filename08' not found.}" 11 5 1 10 %yellow14% %btntime% %black0%
)
GoTo ADDONS
)

If %result% EQU 9 (
If exist %addondir%\%addon9%.exe (
Call :make_button "[ADDON-09] {%addon9%.exe}" 15 5 1 10 %cyan11% %btntime% %black0%
Call :run_command "start %addondir%\%addon9%.exe" "" >nul
) else (
Call :make_button "[ADDON-09] {'filename09' not found.}" 15 5 1 10 %yellow14% %btntime% %black0%
)
GoTo ADDONS
)

If %result% EQU 10 (
If exist %addondir%\%addon10%.exe (
Call :make_button "[ADDON-10] {%addon10%.exe}" 16 5 1 10 %cyan11% %btntime% %black0%
Call :run_command "start %addondir%\%addon10%.exe" "" >nul
) else (
Call :make_button "[ADDON-10] {'filename10' not found.}" 16 5 1 10 %yellow14% %btntime% %black0%
)
GoTo ADDONS
)

If %result% EQU 11 (
If exist %addondir%\%addon11%.exe (
Call :make_button "[ADDON-11] {%addon11%.exe}" 17 5 1 10 %cyan11% %btntime% %black0%
Call :run_command "start %addondir%\%addon11%.exe" "" >nul
) else (
Call :make_button "[ADDON-11] {'filename11' not found.}" 17 5 1 10 %yellow14% %btntime% %black0%
)
GoTo ADDONS
)

If %result% EQU 12 (
If exist %addondir%\%addon12%.exe (
Call :make_button "[ADDON-12] {%addon11%.exe}" 18 5 1 10 %cyan11% %btntime% %black0%
Call :run_command "start %addondir%\%addon12%.exe" "" >nul
) else (
Call :make_button "[ADDON-12] {'filename12' not found.}" 18 5 1 10 %yellow14% %btntime% %black0%
)
GoTo ADDONS
)

If %result% EQU 13 (
If exist %addondir%\%addon13%.exe (
Call :make_button "[ADDON-13] {%addon13%.exe}" 19 5 1 10 %cyan11% %btntime% %black0%
Call :run_command "start %addondir%\%addon13%.exe" "" >nul
) else (
Call :make_button "[ADDON-13] {'filename13' not found.}" 19 5 1 10 %yellow14% %btntime% %black0%
)
GoTo ADDONS
)

If %result% EQU 14 (
If exist %addondir%\%addon14%.exe (
Call :make_button "[ADDON-14] {%addon14%.exe}" 20 5 1 10 %cyan11% %btntime% %black0%
Call :run_command "start %addondir%\%addon14%.exe" "" >nul
) else (
Call :make_button "[ADDON-14] {'filename14' not found.}" 20 5 1 10 %yellow14% %btntime% %black0%
)
GoTo ADDONS
)

If %result% EQU 15 (
If exist %addondir%\%addon15%.exe (
Call :make_button "[ADDON-15] {%addon15%.exe}" 21 5 1 10 %cyan11% %btntime% %black0%
Call :run_command "start %addondir%\%addon15%.exe" "" >nul
) else (
Call :make_button "[ADDON-15] {'filename15' not found.}" 21 5 1 10 %yellow14% %btntime% %black0%
)
GoTo ADDONS
)

If %result% EQU 16 (
If exist %addondir%\%addon16%.exe (
Call :make_button "[ADDON-16] {%addon16%.exe}" 22 5 1 10 %cyan11% %btntime% %black0%
Call :run_command "start %addondir%\%addon16%.exe" "" >nul
) else (
Call :make_button "[ADDON-16] {'filename16' not found.}" 22 5 1 10 %yellow14% %btntime% %black0%
)
GoTo ADDONS
)

If %result% EQU 17 (
rem PrintColorAt "{Go 'BACK' to the 'MAIN' menu.}" 23 16 %yellow14% %black0%
Call :make_button "[ <BACK< ]" 23 5 1 10 %yellow14% %btntime% %gray8%
GoTo MAIN
)
GoTo ADDONS

rem *************
rem wintools menu
rem *************

:WINTOOLS
Set lmenu=WINTOOLS
Call :show_me %black0% 1
rem PrintColorAt "{%lmenu%}" 3 5 %gray7% %black0%
rem PrintColorAt "[CLEANMGR]" 4 5 %cyan11% %black0%
rem PrintColorAt "[EVNTVIEW]" 5 5 %cyan11% %black0%
rem PrintColorAt "[ GPEDIT ]" 6 5 %cyan11% %black0%
rem PrintColorAt "[MSCONFIG]" 7 5 %cyan11% %black0%
rem PrintColorAt "[ REGEDIT]" 8 5 %cyan11% %black0%
rem PrintColorAt "[SERVICES]" 9 5 %cyan11% %black0%
rem PrintColorAt "[ TASKMGR]" 10 5 %cyan11% %black0%
rem PrintColorAt "[TASKSCHD]" 11 5 %cyan11% %black0%
rem PrintColorAt "[ <BACK< ]" 12 5 %yellow14% %gray8%

rem *************
rem button matrix
rem *************

rem MouseCmd 5,4,14,4 5,5,14,5 5,6,14,6 5,7,14,7 5,8,14,8 5,9,14,9 5,10,14,10 5,11,14,11 5,12,14,12

If %result% EQU 1 (
rem PrintColorAt "{Run the 'CLEANMGR' tool.}" 4 16 %cyan11% %black0%
Call :make_button "[CLEANMGR]" 4 5 1 10 %cyan11% %btntime% %black0%
Call :run_command "cleanmgr.exe" "" >nul
GoTo WINTOOLS
)

If %result% EQU 2 (
rem PrintColorAt "{Run the 'EVNTVIEW' tool.}" 5 16 %cyan11% %black0%
Call :make_button "[EVNTVIEW]" 5 5 1 10 %cyan11% %btntime% %black0%
Call :run_command "eventvwr.msc /s" "" >nul
GoTo WINTOOLS
)

If %result% EQU 3 (
rem PrintColorAt "{Run the 'GPEDIT' tool.}" 6 16 %cyan11% %black0%
Call :make_button "[ GPEDIT ]" 6 5 1 10 %cyan11% %btntime% %black0%
Call :run_command "gpedit.msc /s" "" >nul
GoTo WINTOOLS
)

If %result% EQU 4 (
rem PrintColorAt "{Run the 'MSCONFIG' tool.}" 7 16 %cyan11% %black0%
Call :make_button "[MSCONFIG]" 7 5 1 10 %cyan11% %btntime% %black0%
Call :run_command "msconfig.exe" "" >nul
GoTo WINTOOLS
)

If %result% EQU 5 (
rem PrintColorAt "{Run the 'REGEDIT' tool.}" 8 16 %cyan11% %black0%
Call :make_button "[ REGEDIT]" 8 5 1 10 %cyan11% %btntime% %black0%
Call :run_command "regedit.exe" "" >nul
GoTo WINTOOLS
)

If %result% EQU 6 (
rem PrintColorAt "{Run the 'SERVICES' tool.}" 9 16 %cyan11% %black0%
Call :make_button "[SERVICES]" 9 5 1 10 %cyan11% %btntime% %black0%
Call :run_command "services.msc" "" >nul
GoTo WINTOOLS
)

If %result% EQU 7 (
rem PrintColorAt "{Run the 'TASKMGR' tool.}" 10 16 %cyan11% %black0%
Call :make_button "[ TASKMGR]" 10 5 1 10 %cyan11% %btntime% %black0%
Call :run_command "taskmgr.exe /7" "" >nul
GoTo WINTOOLS
)

If %result% EQU 8 (
rem PrintColorAt "{Run the 'TASKSCHD' tool.}" 11 16 %cyan11% %black0%
Call :make_button "[TASKSCHD]" 11 5 1 10 %cyan11% %btntime% %black0%
Call :run_command "taskschd.msc /s" "" >nul
GoTo WINTOOLS
)

If %result% EQU 9 (
rem PrintColorAt "{Go 'BACK' to the 'MAIN' menu.}" 12 16 %yellow14% %black0%
Call :make_button "[ <BACK< ]" 12 5 1 10 %yellow14% %btntime% %gray8%
GoTo MAIN
)
GoTo WINTOOLS

rem *****************
rem begin subroutines
rem *****************
rem *******
rem restart
rem *******

:CONTINUE
rem PrintReturn
rem ChangeColor %cyan11% %black0%
choice /C yn /T 5 /D y /M ">>>> Continue? "
If %errorlevel% EQU 1 GoTo end1
If %errorlevel% EQU 2 GoTo MAIN
:end1
GOTO:EOF

:RESTART
Call :show_me %black0% 0
rem Locate 2 2
rem ChangeColor %cyan11% %black0%
choice /C yn /T 5 /D y /M ">>>> Restart? "
If %errorlevel% EQU 1 GoTo yes1
If %errorlevel% EQU 2 GoTo MAIN
GoTo RESTART

:yes1
Call :show_me %black0% 0
rem PrintCenter "{ Restarting System In %wshutdown% Second(s). }" 12 %yellow14% %red4%
timeout /t %ct2% /nobreak >nul
Call :run_command "shutdown /R /T %wshutdown%" "" >nul
ENDLOCAL
Exit /B %errorlevel%
GoTo MAIN

:show_me
mode con:cols=80 lines=25
rem CursorHide
rem ClearColor
rem PaintScreen %1
:redo1
rem GenRandom 15
If %result% EQU 0 GoTo redo1
If %2 EQU 1 (
rem PrintCenter "%title1%" 1 %result% %black0%
rem PrintCenter "{%lmenu% Menu}" 2 %result% %black0%
rem PrintCenter "{ Choose An Option From The '%lmenu%' Menu }" 13 %result% %black0%
rem PrintColorAt "{ ZoneSoft (c2024-26) zonemaster60@gmail.com }" 25 18 %result% %black0%
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
rem PrintColorAt "{ >next> }" 25 46 %green10% %black0%
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
rem CursorHide
GOTO:EOF

:CHKDSK
rem run chkdsk
Set lmenu=CHKDSK
Call :show_me %black0% 1
rem PrintColorAt "{ %lmenu% }" 3 5 %gray7% %black0%
rem PrintColorAt "[READONLY]" 4 5 %cyan11% %black0%
rem PrintColorAt "[  SCAN  ]" 5 5 %cyan11% %black0%
rem PrintColorAt "[ REPAIR ]" 6 5 %cyan11% %black0%
rem PrintColorAt "[ SPOTFIX]" 7 5 %cyan11% %black0%
rem PrintColorAt "[ RECLAIM]" 8 5 %cyan11% %black0%
rem PrintColorAt "[ <BACK< ]" 9 5 %yellow14% %gray8%

rem *************
rem button matrix
rem *************

rem MouseCmd 5,4,14,4 5,5,14,5 5,6,14,6 5,7,14,7 5,8,14,8 5,9,14,9

If %result% EQU 1 (
rem PrintColorAt "{Run 'CHKDSK' 'READONLY' mode.}" 4 16 %cyan11% %black0%
Call :make_button "[READONLY]" 4 5 1 10 %cyan11% %btntime% %black0%
Call :show_me %black0% 0
rem PrintCenter "{Run 'CHKDSK' 'READONLY' mode.}" 2 %cyan3% %black0%
Call :run_command "chkdsk c:" ""
timeout /t %ct2% /nobreak >nul
GoTo CHKDSK
)

If %result% EQU 2 (
rem PrintColorAt "{Run 'CHKDSK' online 'SCAN' mode.}" 5 16 %cyan11% %black0%
Call :make_button "[  SCAN  ]" 5 5 1 10 %cyan11% %btntime% %black0%
Call :show_me %black0% 0
rem PrintCenter "{Run 'CHKDSK' online 'SCAN' mode.}" 2 %cyan3% %black0%
Call :run_command "chkdsk c: /scan" ""
timeout /t %ct2% /nobreak >nul
GoTo CHKDSK
)

If %result% EQU 3 (
rem PrintColorAt "{Run 'CHKDSK' 'REPAIR' mode.}" 6 16 %cyan11% %black0%
Call :make_button "[ REPAIR ]" 6 5 1 10 %cyan11% %btntime% %black0%
Call :show_me %black0% 0
rem PrintCenter "{Run 'CHKDSK' 'REPAIR' mode.}" 2 %cyan3% %black0%
Call :run_command "chkdsk c: /f" ""
timeout /t %ct2% /nobreak >nul
GoTo RESTART
)

If %result% EQU 4 (
rem PrintColorAt "{Run 'CHKDSK' 'SPOTFIX' mode.}" 7 16 %cyan11% %black0%
Call :make_button "[ SPOTFIX]" 7 5 1 10 %cyan11% %btntime% %black0%
Call :show_me %black0% 0
rem PrintCenter "{Run 'CHKDSK' 'SPOTFIX' mode.}" 2 %cyan3% %black0%
Call :run_command "chkdsk c: /spotfix" ""
timeout /t %ct2% /nobreak >nul
GoTo RESTART
)

If %result% EQU 5 (
rem PrintColorAt "{Run 'CHKDSK' 'RECLAIM' mode.}" 8 16 %cyan11% %black0%
Call :make_button "[ SPOTFIX]" 8 5 1 10 %cyan11% %btntime% %black0%
Call :show_me %black0% 0
rem PrintCenter "{Run 'CHKDSK' 'RECLAIM' mode.}" 2 %cyan3% %black0%
Call :run_command "chkdsk c: /f /r" ""
timeout /t %ct2% /nobreak >nul
GoTo RESTART
)

If %result% EQU 6 (
rem PrintColorAt "{Go 'BACK' to the 'MAIN' menu.}" 9 16 %yellow14% %black0%
Call :make_button "[ <BACK< ]" 9 5 1 10 %yellow14% %btntime% %gray8%
GoTo MAIN
)
GoTo CHKDSK

rem *********************************
rem run a command with error checking
rem *********************************

:run_command
rem CursorHide
Set "cmdToRun=%~1"
Set "description=%~2"
If not defined description Set "description=%cmdToRun%"

rem PrintReturn
rem PrintColorAt "> %TIME%" 4 2 %green10% %black0%
rem PrintColorAt ">> [INFO] %description%" 5 2 %result% %black0%
rem PrintCenter "{ Do Not Close This Window, It Will Close When ALL Tasks Are Done. }" 7 %yellow14% %red4%
rem PrintReturn
rem PrintReturn
rem ChangeColor %result% %black0%
%cmdToRun%

Set "LOGFILE=errorlog.txt"
Set "exitCode=%ERRORLEVEL%"

rem PrintReturn
rem PrintColorAt "> %TIME%" 24 2 %red12% %black0%
rem Handle exit codes
If %exitCode% EQU 0 (
rem PrintColorAt ">> [SUCCESS] %description% completed successfully." 25 2 %green10% %black0%
) else If %exitCode% EQU 1 (
rem PrintColorAt ">> [WARNING] Minor issue occurred." 25 2 %yellow14% %black0%
) else If %exitCode% GEQ 2 (
rem PrintColorAt ">> [ERROR] Critical failure detected! Code: %exitCode%" 25 2 %red12% %black0%
) else (
rem PrintColorAt ">> [UNKNOWN] Exit code: %exitCode%" 25 2 %cyan11% %black0%
)
echo ExitCode: %exitCode%>>%LOGFILE% >nul 2>&1
exit /b %exitCode%
rem CursorHide
GOTO:EOF

rem ***************
rem end subroutines
rem ***************