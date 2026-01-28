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
REM BFCPEVERVERSION=1.1.2.0
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
Set version=v1.1.2.0

rem ******************
rem set initial values
rem ******************
Set analyze=False
Set repair=False
Set skipped=False

rem ***********
rem time values
rem ***********
Set btntime=150
Set wshutdown=10

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

rem **********************
rem Set registry hive keys
rem **********************
Set HK1=HKEY_LOCAL_MACHINE
Set HK2=HKEY_CURRENT_USER
Set HK3=HKEY_USERS
Set HK4=HKEY_CLASSES_ROOT
Set HK5=HKEY_CURRENT_CONFIG

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
Set "default0=backups"
Set "pathfile=backups.txt"
Set "SFCFile=SFCFix.exe"

If exist "%addonfile%" (
Set /a count=0
for /f "usebackq delims=" %%A in ("%addonfile%") do (
    Set /a count+=1
    Set "addon!count!=%%A"
)
)

rem make the 'addons.exe' folder, if 'addons.exe.txt' exists
If exist "%addonfile%" mkdir "%addondir%" >nul 2>&1

If not exist "%pathfile%" (
mkdir "%default0%" >nul 2>&1
Set "backupDir=%default0%"
GoTo wStart
)

rem load and make the backups folder
Set "filepath1="
for /f "usebackq delims=" %%A in ("%pathfile%") do (
    Set "filepath1=%%A"
)
mkdir "%filepath1%" >nul 2>&1
Set "backupDir=%filepath1%"

rem ********************
rem check for powershell
rem ********************
:wStart
rem CursorHide
rem PaintScreen 0
rem PrintColorAt "Checking..." 2 2 %yellow14% %black0%
where powershell >nul 2>&1
If %errorlevel% EQU 0 (
rem PrintColorAt "{ PowerShell Is Installed. }" 3 6 %green10% %black0%
) else (
rem PrintColorAt "{ PowerShell Is NOT Installed. }" 3 6 %yellow14% %red4%
)
timeout /t 2 /nobreak >nul
rem PrintColorAt "Checking..." 4 2 %yellow14% %black0%
where pwsh >nul 2>&1
if %errorlevel% EQU 0 (
rem PrintColorAt "{ PowerShell Core Is Installed. }" 5 6 %green10% %black0%
) else (
rem PrintColorAt "{ PowerShell Core Is NOT Installed. }" 5 6 %yellow14% %red4%
)
rem CursorHide
timeout /t 2 /nobreak >nul

rem *********
rem main menu
rem *********

:wMainMenu
Set lmenu=MAIN
Call :show_me %black0% 1
rem PrintColorAt "{%lmenu%MENU}" 3 5 %gray7% %black0%
rem PrintColorAt "[ ANALYZE]" 4 5 %yellow14% %black0%
rem PrintColorAt "[ REPAIR ]" 5 5 %green10% %black0%
rem PrintColorAt "[ SYSINT ]" 6 5 %magenta5% %black0%
rem PrintColorAt "[  INFO  ]" 7 5 %cyan3% %black0%
rem PrintColorAt "[WINTOOLS]" 8 5 %green10% %black0%
rem PrintColorAt "[  EXIT  ]" 9 5 %red12% %black0%

rem ************************
rem display status / options
rem ************************

rem PrintColorAt "{ STATUS }" 3 66 %gray7% %black0%
If %analyze% EQU True (
rem PrintColorAt "{  DONE  }" 4 66 %green10% %black0%
) else (
rem PrintColorAt "{ ------ }" 4 66 %gray7% %black0%
)
If %skipped% EQU True (
rem PrintColorAt "{  SKIP  }" 4 66 %yellow14% %red4%
)
If %repair% EQU True (
rem PrintColorAt "{  DONE  }" 5 66 %green10% %black0%
) else (
rem PrintColorAt "{ ------ }" 5 66 %gray7% %black0%
)
rem PrintColorAt "{ OPTION }" 6 66 %gray7% %black0%
rem PrintColorAt "[ CHKDSK ]" 7 66 %cyan3% %black0%
rem PrintColorAt "[ REGBAK ]" 8 66 %cyan3% %black0%
rem *addons.txt check
If exist %addonfile% (
rem PrintColorAt "[ ADDONS ]" 9 66 %cyan3% %black0%
) else (
rem PrintColorAt "[ ADDONS ]" 9 66 %gray7% %black0%
)

rem *************
rem button matrix
rem *************

rem MouseCmd 5,4,14,4 5,5,14,5 5,6,14,6 5,7,14,7 5,8,14,8 5,9,14,9 66,7,75,7 66,8,75,8 66,9,75,9

If %result% EQU 1 (
Call :make_button "[ ANALYZE]" 4 5 1 10 %yellow14% %btntime% %black0%
rem PrintColorAt "{Go to the 'ANALYZE' menu.}" 4 16 %yellow14% %black0%
timeout /t 2 /nobreak >nul
GoTo wAnalyze
)

If %result% EQU 2 (
Call :make_button "[ REPAIR ]" 5 5 1 10 %green10% %btntime% %black0%
rem PrintColorAt "{Go to the 'REPAIR' menu.}" 5 16 %green10% %black0%
timeout /t 2 /nobreak >nul
Goto wRepair
)

If %result% EQU 3 (
Call :make_button "[ SYSINT ]" 6 5 1 10 %magenta5% %btntime% %black0%
Call :run_command "start https://live.sysinternals.com/" 6 >nul
rem PrintColorAt "{Visit live.sysinternals.com.}" 6 16 %magenta5% %black0%
timeout /t 2 /nobreak >nul
Goto wMainMenu
)

If %result% EQU 4 (
Call :make_button "[  INFO  ]" 7 5 1 10 %cyan3% %btntime% %black0%
rem PrintColorAt "{Get 'INFO' about your system.}" 7 16 %cyan3% %black0%
timeout /t 2 /nobreak >nul
Goto wInfo1
)

If %result% EQU 5 (
Call :make_button "[WINTOOLS]" 8 5 1 10 %green10% %btntime% %black0%
rem PrintColorAt "{Go to the 'WINTOOLS' menu.}" 8 16 %green10% %black0%
timeout /t 2 /nobreak >nul
GoTo wTools
)

If %result% EQU 6 (
Call :make_button "[  EXIT  ]" 9 5 1 10 %red12% %btntime% %black0%
rem PrintColorAt "{Go to the 'EXIT' menu.}" 9 16 %red12% %black0%
timeout /t 2 /nobreak >nul
Goto wExit
)

If %result% EQU 7 (
Call :make_button "[ CHKDSK ]" 7 66 1 10 %cyan3% %btntime% %black0%
rem PrintColorAt "{Go to the 'CHKDSK' menu.}" 7 39 %cyan3% %black0%
timeout /t 2 /nobreak >nul
Goto wCheckDisk
)

If %result% EQU 8 (
Call :make_button "[ REGBAK ]" 8 66 1 10 %cyan3% %btntime% %black0%
rem PrintColorAt "{Go to the 'REGBAK' menu.}" 8 39 %cyan3% %black0%
timeout /t 2 /nobreak >nul
Goto wRegBackup
)

If %result% EQU 9 (
If exist %addonfile% (
Call :make_button "[ ADDONS ]" 9 66 1 10 %cyan3% %btntime% %black0%
rem PrintColorAt "{Go to the 'ADDONS' menu.}" 9 39 %cyan3% %black0%
timeout /t 2 /nobreak >nul
GoTo wAddons
) else (
Call :make_button "[ ADDONS ]" 8 66 1 10 %gray7% %btntime% %black0%
rem PrintColorAt "{'%addonfile%' not found.}" 8 39 %gray7% %black0%
timeout /t 2 /nobreak >nul
GoTo wMainMenu
)
)
GoTo wMainMenu

rem ************
rem analyze menu
rem ************

:wAnalyze
Set lmenu=ANALYZE
Call :show_me %black0% 1
rem PrintColorAt "{ %lmenu%}" 3 5 %gray7% %black0%
rem PrintColorAt "[  SCAN  ]" 4 5 %cyan11% %black0%
rem PrintColorAt "[  CHECK ]" 5 5 %cyan11% %black0%
rem PrintColorAt "[ <BACK< ]" 6 5 %yellow14% %black0%

rem *************
rem button matrix
rem *************

rem MouseCmd 5,4,14,4 5,5,14,5 5,6,14,6

If %result% EQU 1 (
Call :make_button "[  SCAN  ]" 4 5 1 10 %cyan11% %btntime% %black0%
rem PrintColorAt "{'SCAN' the image health-slow.}" 4 16 %cyan11% %black0%
timeout /t 2 /nobreak >nul
Set chkhealth=False
GoTo wAnalyzeNow
)

If %result% EQU 2 (
Call :make_button "[  CHECK ]" 5 5 1 10 %cyan11% %btntime% %black0%
rem PrintColorAt "{'CHECK' the image health-fast.}" 5 16 %cyan11% %black0%
timeout /t 2 /nobreak >nul
Set chkhealth=True
GoTo wAnalyzeNow
)

If %result% EQU 3 (
Call :make_button "[ <BACK< ]" 6 5 1 10 %yellow14% %btntime% %black0%
rem PrintColorAt "{Go 'BACK' to the 'MAIN' menu.}" 6 16 %yellow14% %black0%
timeout /t 2 /nobreak >nul
GoTo wMainMenu
)
GoTo wAnalyze

:wAnalyzeNow
rem ***********
rem analyze now
rem *********************
rem check component store
rem *********************

Call :show_me %black0% 0
rem PrintCenter "{ TASK > 1/3 > Analyzes the system component store for errors. }" 2 %blue9% %black0%
Call :run_command "dism /online /cleanup-image /analyzecomponentstore" 4

rem ********************
rem check or scan health
rem ********************

Call :show_me %black0% 0
If %chkhealth% EQU True (
rem PrintCenter "{ TASK > 2/3 > CheckHealth is faster, but not as thorough. }" 2 %blue9% %black0%
Call :run_command "dism /online /cleanup-image /checkhealth" 4
) else (
rem PrintCenter "{ TASK > 2/3 > ScanHealth is slower, but performs a better test. }" 2 %blue9% %black0%
Call :run_command "dism /online /cleanup-image /scanhealth" 4
)

rem ************
rem verify files
rem ************

Call :show_me %black0% 0
rem PrintCenter "{ TASK > 3/3 > Verifies, but does not replace any system files. }" 2 %blue9% %black0%
Call :run_command "sfc /verifyonly" 4
Set analyze=True
Set skipped=False
GoTo wMainMenu

rem ***********
rem repair menu
rem ***********

:wRepair
Set lmenu=REPAIR
Call :show_me %black0% 1
rem PrintColorAt "{ %lmenu% }" 3 5 %gray7% %black0%
rem PrintColorAt "[ REPAIR ]" 4 5 %cyan11% %black0%
rem PrintColorAt "[RESETBAS]" 5 5 %cyan11% %black0%
rem PrintColorAt "[ <BACK< ]" 6 5 %yellow14% %black0%

rem *************
rem button matrix
rem *************

rem MouseCmd 5,4,14,4 5,5,14,5 5,6,14,6

If %result% EQU 1 (
Call :make_button "[ REPAIR ]" 4 5 1 10 %cyan11% %btntime% %black0%
rem PrintColorAt "{'REPAIR' the system image.}" 4 16 %cyan11% %black0%
timeout /t 2 /nobreak >nul
Set resetbase=False
GoTo wRepairNow
)

If %result% EQU 2 (
Call :make_button "[RESETBAS]" 5 5 1 10 %cyan11% %btntime% %black0%
rem PrintColorAt "{Repair the system image, then 'RESETBAS'.}" 5 16 %cyan11% %black0%
timeout /t 2 /nobreak >nul
Set resetbase=True
GoTo wRepairNow
)

If %result% EQU 3 (
Call :make_button "[ <BACK< ]" 6 5 1 10 %yellow14% %btntime% %black0%
rem PrintColorAt "{Go 'BACK' to the 'MAIN' menu.}" 6 16 %yellow14% %black0%
timeout /t 2 /nobreak >nul
GoTo wMainMenu
)
GoTo wRepair

:wRepairNow
rem **********
rem repair now
rem **************************
rem resetbase / normal cleanup
rem **************************

Call :show_me %black0% 0
If %resetbase% EQU True (
rem PrintCenter "{ TASK > 1/3 > Reset the entire system component store to baseline. }" 2 %blue9% %black0%
Call :run_command "dism /online /cleanup-image /startcomponentcleanup /resetbase" 4
) else (
rem PrintCenter "{ TASK > 1/3 > Perform a normal system component store cleanup. }" 2 %blue9% %black0%
Call :run_command "dism /online /cleanup-image /startcomponentcleanup" 4
)

rem **************
rem restore health
rem **************

Call :show_me %black0% 0
rem PrintCenter "{ TASK > 2/3 > Clean, update, and restore the system image health. }" 2 %blue9% %black0%
Call :run_command "dism /online /cleanup-image /restorehealth" 4

rem ********
rem scan now
rem ********

Call :show_me %black0% 0
rem PrintCenter "{ TASK > 3/3 > Scans, and replaces any corrupted system files. }" 2 %blue9% %black0%
Call :run_command "sfc /scannow" 4
If %analyze% EQU False (
Set skipped=True
) else (
Set skipped=False
Set analyze=True
)
Set repair=True
GoTo restart

rem ***********
rem info part 1
rem ***********

:wInfo1
Call :show_me %black0% 0
Set lmenu=INFO1
rem PrintCenter "{%title1%::%lmenu%}" 1 %cyan3% %black0%
rem PrintCenter "{ Use The Mouse to Navigate or the Number 0-9 Keys }" 3 %yellow14% %black0%
rem PrintCenter "[ ANALYZE ] This uses DISM and SFC to [ ANALYZE ] for" 5 %yellow14% %black0%
rem PrintCenter "corrupted system files. This option DOES NOT make any repairs." 6 %yellow14% %black0%
rem PrintCenter "[ REPAIR ] This also uses DISM and SFC" 8 %green10% %black0%
rem PrintCenter "to [ ANALYZE ] and [ REPAIR ] any corrupted system files." 9 %green10% %black0%
rem PrintCenter "[ SYSINT ] Open/Loads the 'live.sysinternals.com' Web Page." 11 %magenta5% %black0%
rem PrintCenter "[ INFO ] You are reading it now." 13 %cyan3% %black0%
rem PrintCenter "[WINTOOLS] Access the windows built in tools." 15 %green10% %black0%
rem PrintCenter "[ EXIT ] Exit the program." 17 %red12% %black0%
Call :next_page

rem ***********
rem info part 2
rem ***********

:wInfo2
Call :show_me %black0% 0
Set lmenu=INFO2
rem PrintCenter "{%title1%::%lmenu%}" 1 %cyan3% %black0%
rem PrintCenter "{ Use The Mouse to Navigate or the Number 0-9 Keys }" 3 %yellow14% %black0%
rem PrintCenter "{ STATUS } The status of [ ANALYZE ] and [ REPAIR ] system image tasks." 5 %gray7% %black0%
rem PrintCenter "{ ------ } ------/ DONE [ ANALYZE ] system image task." 7 %gray7% %black0%
rem PrintCenter "{ ------ } ------/ DONE [ REPAIR ] system image task." 9 %gray7% %black0%
rem PrintCenter "{ OPTION } Options are [ CHKDSK ], [ REGBAK ], or [ ADDONS ]." 11 %gray7% %black0%
rem PrintCenter "[ CHKDSK ] Go to the [ CHKDSK ] menu." 13 %cyan3% %black0%
rem PrintCenter "[ REGBAK ] Go to the [ REGBAK ] (registry backup) menu." 15 %cyan3% %black0%
rem PrintCenter "[ ADDONS ] If you have them you can access them from this menu." 17 %cyan3% %black0%
Call :next_page

rem ***********
rem info part 3
rem ***********

:wInfo3
Call :show_me %black0% 0
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
GoTo wMainMenu

rem *********
rem exit menu
rem *********

:wExit
Set lmenu=EXIT
Call :show_me %black0% 1
rem PrintColorAt "{  %lmenu%  }" 3 5 %gray7% %black0%
rem PrintColorAt "[  EXIT  ]" 4 5 %red12% %black0%
rem PrintColorAt "[ <BACK< ]" 5 5 %yellow14% %black0%

rem *************
rem button matrix
rem *************

rem MouseCmd 5,4,14,4 5,5,14,5
If %result% EQU 1 (
Call :make_button "[  EXIT  ]" 4 5 1 10 %red12% %btntime% %black0%
rem PrintColorAt "{'EXIT' to the OS.}" 4 16 %red12% %black0%
timeout /t 2 /nobreak >nul
Call :show_me %black0% 0
rem PrintCenter "{ Thank you for using this FREE Software. }" 13 %cyan11% %black0%
timeout /t 4 /nobreak >nul
ENDLOCAL
Exit /B %ErrorLevel%
)

If %result% EQU 2 (
Call :make_button "[ <BACK< ]" 5 5 1 10 %yellow14% %btntime% %black0%
rem PrintColorAt "{Go 'BACK' to the 'MAIN' menu.}" 5 16 %yellow14% %black0%
timeout /t 2 /nobreak >nul
GoTo wMainMenu
)
GoTo wExit

:wAddons
Set lmenu=ADDONS
Call :show_me %black0% 1
rem PrintColorAt "{ %lmenu% }" 3 5 %gray7% %black0%
If exist %addondir%\%addon1%.exe (
rem PrintColorAt "[ ADDON1 ] = {%addon1%.exe}" 4 5 %cyan11% %black0%
) else (
rem PrintColorAt "[ ADDON1 ] = {'filename1'}" 4 5 %gray7% %black0%
)
If exist %addondir%\%addon2%.exe (
rem PrintColorAt "[ ADDON2 ] = {%addon2%.exe}" 5 5 %cyan11% %black0%
) else (
rem PrintColorAt "[ ADDON2 ] = {'filename2'}" 5 5 %gray7% %black0%
)
If exist %addondir%\%addon3%.exe (
rem PrintColorAt "[ ADDON3 ] = {%addon3%.exe}" 6 5 %cyan11% %black0%
) else (
rem PrintColorAt "[ ADDON3 ] = {'filename3'}" 6 5 %gray7% %black0%
)
If exist %addondir%\%addon4%.exe (
rem PrintColorAt "[ ADDON4 ] = {%addon4%.exe}" 7 5 %cyan11% %black0%
) else (
rem PrintColorAt "[ ADDON4 ] = {'filename4'}" 7 5 %gray7% %black0%
)
If exist %addondir%\%addon5%.exe (
rem PrintColorAt "[ ADDON5 ] = {%addon5%.exe}" 8 5 %cyan11% %black0%
) else (  
rem PrintColorAt "[ ADDON5 ] = {'filename5'}" 8 5 %gray7% %black0%
)
If exist %addondir%\%addon6%.exe (
rem PrintColorAt "[ ADDON6 ] = {%addon6%.exe}" 9 5 %cyan11% %black0%
) else (  
rem PrintColorAt "[ ADDON6 ] = {'filename6'}" 9 5 %gray7% %black0%
)
rem PrintColorAt "[ <BACK< ]" 10 5 %yellow14% %black0%

rem *************
rem button matrix
rem *************

rem MouseCmd 5,4,14,4 5,5,14,5 5,6,14,6 5,7,14,7 5,8,14,8 5,9,14,9 5,10,14,10

If %result% EQU 1 (
If exist %addondir%\%addon1%.exe (
Call :make_button "[ ADDON1 ] = {%addon1%.exe}" 4 5 1 10 %cyan11% %btntime% %black0%
start %addondir%\%addon1%.exe
) else (
Call :make_button "[ ADDON1 ] = {'filename1' not found.}" 4 5 1 10 %gray7% %btntime% %black0%
)
)

If %result% EQU 2 (
If exist %addondir%\%addon2%.exe (
Call :make_button "[ ADDON2 ] = {%addon2%.exe}" 5 5 1 10 %cyan11% %btntime% %black0%
start %addondir%\%addon2%.exe
) else (
Call :make_button "[ ADDON2 ] = {'filename2' not found.}" 5 5 1 10 %gray7% %btntime% %black0%
)
)

If %result% EQU 3 (
If exist %addondir%\%addon3%.exe (
Call :make_button "[ ADDON3 ] = {%addon3%.exe}" 6 5 1 10 %cyan11% %btntime% %black0%
start %addondir%\%addon3%.exe
) else (
Call :make_button "[ ADDON3 ] = {'filename3' not found.}" 6 5 1 10 %gray7% %btntime% %black0%
)
)

If %result% EQU 4 (
If exist %addondir%\%addon4%.exe (
Call :make_button "[ ADDON4 ] = {%addon4%.exe}" 7 5 1 10 %cyan11% %btntime% %black0%
start %addondir%\%addon4%.exe
) else (
Call :make_button "[ ADDON4 ] = {'filename4' not found.}" 7 5 1 10 %gray7% %btntime% %black0%
)
)

If %result% EQU 5 (
If exist %addondir%\%addon5%.exe (
Call :make_button "[ ADDON5 ] = {%addon5%.exe}" 8 5 1 10 %cyan11% %btntime% %black0%
start %addondir%\%addon5%.exe
) else (
Call :make_button "[ ADDON5 ] = {'filename5' not found.}" 8 5 1 10 %gray7% %btntime% %black0%
)
)

If %result% EQU 6 (
If exist %addondir%\%addon6%.exe (
Call :make_button "[ ADDON6 ] = {%addon6%.exe}" 9 5 1 10 %cyan11% %btntime% %black0%
start %addondir%\%addon6%.exe
) else (
Call :make_button "[ ADDON6 ] = {'filename6' not found.}" 9 5 1 10 %gray7% %btntime% %black0%
)
)

If %result% EQU 7 (
Call :make_button "[ <BACK< ]" 10 5 1 10 %yellow14% %btntime% %black0%
rem PrintColorAt "{Go 'BACK' to the 'MAIN' menu.}" 10 16 %yellow14% %black0%
timeout /t 2 /nobreak >nul
GoTo wMainMenu
)
timeout /t 2 /nobreak >nul
GoTo wAddons

rem *************
rem wintools menu
rem *************

:wTools
Set lmenu=WINTOOLS
Call :show_me %black0% 1
rem PrintColorAt "{%lmenu%}" 3 5 %gray7% %black0%
rem PrintColorAt "[CLEANMGR]" 4 5 %cyan11% %black0%
rem PrintColorAt "[MSCONFIG]" 5 5 %cyan11% %black0%
rem PrintColorAt "[ NOTEPAD]" 6 5 %cyan11% %black0%
rem PrintColorAt "[SERVICES]" 7 5 %cyan11% %black0%
rem PrintColorAt "[ TASKMGR]" 8 5 %cyan11% %black0%
rem PrintColorAt "[WINUPFIX]" 9 5 %cyan11% %black0%
rem PrintColorAt "[ <BACK< ]" 10 5 %yellow14% %black0%

rem *************
rem button matrix
rem *************

rem MouseCmd 5,4,14,4 5,5,14,5 5,6,14,6 5,7,14,7 5,8,14,8 5,9,14,9 5,10,14,10

If %result% EQU 1 (
Call :make_button "[CLEANMGR]" 4 5 1 10 %cyan11% %btntime% %black0%
rem PrintColorAt "{Run the 'CLEANMGR' tool.}" 4 16 %cyan11% %black0%
Call :run_command "cleanmgr.exe" 20 >nul
)

If %result% EQU 2 (
Call :make_button "[MSCONFIG]" 5 5 1 10 %cyan11% %btntime% %black0%
rem PrintColorAt "{Run the 'MSCONFIG' tool.}" 5 16 %cyan11% %black0%
Call :run_command "msconfig.exe" 20 >nul
)

If %result% EQU 3 (
Call :make_button "[ NOTEPAD]" 6 5 1 10 %cyan11% %btntime% %black0%
rem PrintColorAt "{Run the 'NOTEPAD' tool.}" 6 16 %cyan11% %black0%
Call :run_command "notepad.exe" 20 >nul
)

If %result% EQU 4 (
Call :make_button "[SERVICES]" 7 5 1 10 %cyan11% %btntime% %black0%
rem PrintColorAt "{Run the 'SERVICES' tool.}" 7 16 %cyan11% %black0%
Call :run_command "services.msc" 20 >nul
)

If %result% EQU 5 (
Call :make_button "[ TASKMGR]" 8 5 1 10 %cyan11% %btntime% %black0%
rem PrintColorAt "{Run the 'TASKMGR' tool.}" 8 16 %cyan11% %black0%
Call :run_command "taskmgr.exe /7" 20 >nul
)

If %result% EQU 6 (
Call :make_button "[WINUPFIX]" 9 5 1 10 %cyan11% %btntime% %black0%
rem PrintColorAt "{Go to the 'WINUPFIX' menu.}" 9 16 %cyan11% %black0%
timeout /t 2 /nobreak >nul
GoTo WinUpdateFix
)

If %result% EQU 7 (
Call :make_button "[ <BACK< ]" 10 5 1 10 %yellow14% %btntime% %black0%
rem PrintColorAt "{Go 'BACK' to the 'MAIN' menu.}" 10 16 %yellow14% %black0%
timeout /t 2 /nobreak >nul
GoTo wMainMenu
)
GoTo wTools

rem **************
rem checkdisk menu
rem **************

:wCheckDisk
Set lmenu=CHKDSK
Call :show_me %black0% 1
rem PrintColorAt "{ %lmenu% }" 3 5 %gray7% %black0%
rem PrintColorAt "[READONLY]" 4 5 %cyan11% %black0%
rem PrintColorAt "[  SCAN  ]" 5 5 %cyan11% %black0%
rem PrintColorAt "[ REPAIR ]" 6 5 %cyan11% %black0%
rem PrintColorAt "[ SPOTFIX]" 7 5 %cyan11% %black0%
rem PrintColorAt "[ <BACK< ]" 8 5 %yellow14% %black0%

rem *************
rem button matrix
rem *************

rem MouseCmd 5,4,14,4 5,5,14,5 5,6,14,6 5,7,14,7 5,8,14,8

If %result% EQU 1 (
Call :make_button "[READONLY]" 4 5 1 10 %cyan11% %btntime% %black0%
rem PrintColorAt "{Run CHKDSK 'READONLY' mode.}" 4 16 %cyan11% %black0%
timeout /t 2 /nobreak >nul
Call :show_me %black0% 0
rem PrintCenter "{ WINTOOLS > CHKDSK > Read Only Mode }" 2 %blue9% %black0%
Call :run_command "chkdsk %SystemDrive%" 4
GoTo wCheckDisk
)

If %result% EQU 2 (
Call :make_button "[  SCAN  ]" 5 5 1 10 %cyan11% %btntime% %black0%
rem PrintColorAt "{Run CHKDSK online 'SCAN' mode.}" 5 16 %cyan11% %black0%
timeout /t 2 /nobreak >nul
Call :show_me %black0% 0
rem PrintCenter "{ WINTOOLS > CHKDSK > Online Scan mode }" 2 %blue9% %black0%
Call :run_command "chkdsk %SystemDrive% /scan" 4
GoTo wCheckDisk
)

If %result% EQU 3 (
Call :make_button "[ REPAIR ]" 6 5 1 10 %cyan11% %btntime% %black0%
rem PrintColorAt "{Run CHKDSK boot 'REPAIR' mode.}" 6 16 %cyan11% %black0%
timeout /t 2 /nobreak >nul
Call :show_me %black0% 0
rem PrintCenter "{ WINTOOLS > CHKDSK > Boot Repair mode }" 2 %blue9% %black0%
Call :run_command "chkdsk %SystemDrive% /F" 4
GoTo restart
)

If %result% EQU 4 (
Call :make_button "[ SPOTFIX]" 7 5 1 10 %cyan11% %btntime% %black0%
rem PrintColorAt "{Run CHKDSK online 'SPOTFIX' mode.}" 7 16 %cyan11% %black0%
timeout /t 2 /nobreak >nul
Call :show_me %black0% 0
rem PrintCenter "{ WINTOOLS > CHKDSK > Online Spotfix mode }" 2 %blue9% %black0%
Call :run_command "chkdsk %SystemDrive% /spotfix" 4
GoTo restart
)

If %result% EQU 5 (
Call :make_button "[ <BACK< ]" 8 5 1 10 %yellow14% %btntime% %black0%
rem PrintColorAt "{Go 'BACK' to the 'MAIN' menu.}" 8 16 %yellow14% %black0%
timeout /t 2 /nobreak >nul
GoTo wMainMenu
)
GoTo wCheckDisk

rem *****************
rem begin subroutines
rem *****************
rem *******
rem restart
rem *******

:restart
Call :show_me %black0% 0
rem ChangeColor %cyan11% %black0%
rem Locate 2 2
choice /C YN /T 5 /D N /M "Are you sure you want to 'restart' "

If %errorlevel% EQU 1 GoTo next2
If %errorlevel% EQU 2 GoTo wMainMenu

:next2
rem PrintCenter "{ Restarting System In %wshutdown% Second(s). }" 12 %cyan11% %black0%
timeout /t 4 /nobreak >nul
Call :run_command "shutdown /R /T %wshutdown%" 20 >nul
GoTo wMainMenu

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
rem PrintCenter "{ Choose An Option From The '%lmenu%' Menu }" 13 %result% %black0%
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
rem PrintColorAt ">> %1" 5 2 %green10% %black0%
rem PrintReturn
rem ***********
rem t1 = %2 + 2
rem ***********
rem Add %2 3
Set t1=%result%
rem PrintReturn
rem PrintCenter "{ Do Not Close This Window, It Will Close When ALL Tasks Are Done. }" %t1% %yellow14% %red4%
rem PrintReturn
rem ChangeColor %gray7% %black0%
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
timeout /t 4 /nobreak >nul
GOTO:EOF

rem ****************
rem next_page button
rem ****************

:next_page
rem CursorHide
rem PrintColorAt "[ >>>>>> ]" 25 35 %green10% %black0%
rem MouseCmd 35,25,44,25

If %result% EQU 1 (
Call :make_button "[ >>>>>> ]" 25 35 1 10 %green10% %btntime% %black0%
rem PrintColorAt "{Go to the '>>>>>>' item.}" 25 46 %green10% %black0%
timeout /t 2 /nobreak >nul
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

rem *****************************
rem reset windows update services
rem *****************************

:WinUpdateFix
Set lmenu=WINFIXUP
Call :show_me %black0% 1
rem PrintColorAt "{%lmenu%}" 3 5 %gray7% %black0%
rem PrintColorAt "[ FIXNOW ]" 4 5 %cyan11% %black0%
rem PrintColorAt "[ <BACK< ]" 5 5 %yellow14% %black0%

rem *************
rem button matrix
rem *************

rem MouseCmd 5,4,14,4 5,5,14,5
If %result% EQU 1 (
Call :make_button "[ FIXNOW ]" 4 5 1 10 %cyan11% %btntime% %black0%
rem PrintColorAt "{FIX windows update NOW.}" 4 16 %cyan11% %black0%
timeout /t 2 /nobreak >nul
Call :resetwindowsupdate
GoTo wTools
)

If %result% EQU 2 (
Call :make_button "[ <BACK< ]" 5 5 1 10 %yellow14% %btntime% %black0%
rem PrintColorAt "{Go 'BACK' to the 'WINTOOLS' menu.}" 5 16 %yellow14% %black0%
timeout /t 2 /nobreak >nul
GoTo wTools
)
GoTo WinUpdateFix

:resetwindowsupdate
rem CursorHide
Call :show_me %black0% 0
rem PrintColor "{ Checking Drive Health Status... }" %yellow14% %black0%
rem PrintReturn
fsutil dirty query %SystemDrive%
rem PrintReturn
rem PrintColor "{ Stopping update services... }" %yellow14% %red4%
rem PrintReturn
net stop wuauserv
net stop bits
net stop appidsvc
net stop cryptsvc
rem PrintColor "{ Flushing DNS Configuration... }" %yellow14% %black0%
rem PrintReturn
ipconfig /flushdns
rem PrintReturn
If exist %ALLUSERSPROFILE%\Application Data\Microsoft\Network\Downloader\qmgr*.dat del /s /q /f %ALLUSERSPROFILE%\Application Data\Microsoft\Network\Downloader\qmgr*.dat 
If exist %ALLUSERSPROFILE%\Microsoft\Network\Downloader\qmgr*.dat del /s /q /f %ALLUSERSPROFILE%\Microsoft\Network\Downloader\qmgr*.dat
If exist %SYSTEMROOT%\Logs\WindowsUpdate\* del /s /q /f %SYSTEMROOT%\Logs\WindowsUpdate\*
rem PrintColor "{ Reseting Windows Update Policies... }" %yellow14% %black0%
rem PrintReturn
reg query "HKCU\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v >nul 2>&1
If %errorlevel%==0 (
rem PrintColor "{ Registry Object Deleted. }" %green10% %black0%
rem Printreturn
reg delete "HKCU\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /f
) else (
rem PrintColor "{ Registry Object Not Found. }" %yellow14% %red4%
rem Printreturn
)
reg query "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\WindowsUpdate" /v >nul 2>&1
If %errorlevel%==0 (
rem PrintColor "{ Registry Object Deleted. }" %green10% %black0%
rem Printreturn
reg delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\WindowsUpdate" /f
) else (
rem PrintColor "{ Registry Object Not Found. }" %yellow14% %red4%
rem Printreturn
)
reg query "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v >nul 2>&1
If %errorlevel%==0 (
rem PrintColor "{ Registry Object Deleted. }" %green10% %black0%
rem Printreturn
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /f
) else (
rem PrintColor "{ Registry Object Not Found. }" %yellow14% %red4%
rem Printreturn
)
reg query "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\WindowsUpdate" /v >nul 2>&1
If %errorlevel%==0 (
rem PrintColor "{ Registry Object Deleted. }" %green10% %black0%
rem Printreturn
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\WindowsUpdate" /f
) else (
rem PrintColor "{ Registry Object Not Found. }" %yellow14% %red4%
rem Printreturn
)
gpupdate /force
rem PrintReturn
rem PrintColor "{ Removing Old 'SoftwareDistribution' Folder... }" %red12% %black0%
rem PrintReturn
If exist %systemroot%\SoftwareDistribution.old rmdir /s /q %systemroot%\SoftwareDistribution.old
rem PrintColor "{ Renaming New 'SoftwareDistribution' Folder... }" %yellow14% %black0%
rem PrintReturn
If exist %systemroot%\SoftwareDistribution ren %systemroot%\SoftwareDistribution SoftwareDistribution.old
rem PrintColor "{ Removing Old 'catroot2' Folder... }" %red12% %black0%
rem PrintReturn
If exist %systemroot%\system32\catroot2.old rmdir /s /q %systemroot%\system32\catroot2.old
rem PrintColor "{ Renaming New 'catroot2' Folder... }" %yellow14% %black0%
rem PrintReturn
If exist %systemroot%\system32\catroot2 ren %systemroot%\system32\catroot2 catroot2.old
rem PrintColor "{ Resetting WinSock Configuration... }" %yellow14% %black0%
rem PrintReturn
netsh winsock reset
netsh winsock reset proxy
rem PrintReturn
rem PrintColor "{ Starting update services... }" %green10% %black0%
rem PrintReturn
net start cryptsvc
net start appidsvc
net start bits
net start wuauserv
rem PrintColor "{ Finished, Rebooting your computer... }" %yellow14% %black0%
rem PrintReturn
rem CursorHide
timeout /t 4 /nobreak >nul
GoTo restart
GOTO:EOF

rem ***************************
rem backup and restore registry
rem ***************************

:wRegBackup
Set lmenu=REGBAK
Call :show_me %black0% 1
rem PrintColorAt "{ %lmenu% }" 3 5 %gray7% %black0%
rem PrintColorAt "[ BACKUP ]" 4 5 %cyan11% %black0%
rem PrintColorAt "[ RESTORE]" 5 5 %cyan11% %black0%
rem PrintColorAt "[ <BACK< ]" 6 5 %yellow14% %black0%

If exist "%pathfile%" (
rem PrintCenter "{ Using '%pathfile%'. }" 15 %green10% %black0%
rem PrintCenter "{ Backup Folder: '%backupDir%'. }" 16 %green10% %black0%
) else (
rem PrintCenter "{ '%pathfile%' not found. }" 15 %yellow14% %black0%
rem PrintCenter "{ Using Default Folder: '%default0%'. }" 16 %yellow14% %black0%
)

rem *************
rem button matrix
rem *************

rem MouseCmd 5,4,14,4 5,5,14,5 5,6,14,6

If %result% EQU 1 (
Call :make_button "[ BACKUP ]" 4 5 1 10 %cyan11% %btntime% %black0%
rem PrintColorAt "{'BACKUP' the system registry.}" 4 16 %cyan11% %black0%
timeout /t 2 /nobreak >nul
Call :backup_registry
GoTo wRegBackup
)

If %result% EQU 2 (
Call :make_button "[ RESTORE]" 5 5 1 10 %cyan11% %btntime% %black0%
rem PrintColorAt "{'RESTORE' the system registry.}" 5 16 %cyan11% %black0%
timeout /t 2 /nobreak >nul
Call :restore_registry
GoTo wRegBackup
)

If %result% EQU 3 (
Call :make_button "[ <BACK< ]" 6 5 1 10 %yellow14% %btntime% %black0%
rem PrintColorAt "{Go 'BACK' to the 'MAIN' menu.}" 6 16 %yellow14% %black0%
timeout /t 2 /nobreak >nul
GoTo wMainMenu
)
GoTo wRegBackup

rem backup the registry
:backup_registry
Call :show_me %black0% 0
If exist %backupDir%\*.reg del %backupDir%\*.reg >nul 2>&1

rem PrintColorAt "Backing up registry hives..." 2 2 %yellow14% %black0%
rem PrintColorAt "Backing up %HK1%..." 3 2 %cyan11% %black0%
rem PrintReturn
reg export %HK1% %backupDir%\%HK1%.reg /y
rem PrintColorAt "Backing up %HK2%..." 5 2 %cyan11% %black0%
rem PrintReturn
reg export %HK2% %backupDir%\%HK2%.reg /y
rem PrintColorAt "Backing up %HK3%..." 7 2 %cyan11% %black0%
rem PrintReturn
reg export %HK3% %backupDir%\%HK3%.reg /y
rem PrintColorAt "Backing up %HK4%..." 9 2 %cyan11% %black0%
rem PrintReturn
reg export %HK4% %backupDir%\%HK4%.reg /y
rem PrintColorAt "Backing up %HK5%..." 11 2 %cyan11% %black0%
rem PrintReturn
reg export %HK5% %backupDir%\%HK5%.reg /y
rem PrintReturn
rem PrintColorAt "{ All Hives Backed Up To '%backupDir%'. }" 13 2 %green10% %black0%
timeout /t 4 /nobreak >nul
GOTO:EOF

rem restore the registry
:restore_registry
Call :show_me %black0% 0
If not exist %backupDir%\*.reg (
rem PrintCenter "{ Please Create A Backup First. }" 2 %yellow14% %red4%
timeout /t 2 /nobreak >nul
GoTo wRegBackup
)

rem ChangeColor %cyan11% %black0%
rem Locate 2 2
choice /C YN /T 5 /D N /M "Are you sure you want to 'RESTORE' "

If %errorlevel% EQU 1 GoTo next1
If %errorlevel% EQU 2 GOTO wRegBackup

:next1
rem PaintScreen 0
rem PrintColorAt "Restoring registry hives..." 2 2 %yellow14% %black0%
rem PrintColorAt "Restoring %HK1%..." 3 2 %cyan11% %black0%
rem PrintReturn
reg import %backupDir%\%HK1%.reg
rem PrintColorAt "Restoring %HK2%..." 5 2 %cyan11% %black0%
rem PrintReturn
reg import %backupDir%\%HK2%.reg
rem PrintColorAt "Restoring %HK3%..." 7 2 %cyan11% %black0%
rem PrintReturn
reg import %backupDir%\%HK3%.reg
rem PrintColorAt "Restoring %HK4%..." 9 2 %cyan11% %black0%
rem PrintReturn
reg import %backupDir%\%HK4%.reg
rem PrintColorAt "Restoring %HK5%..." 11 2 %cyan11% %black0%
rem PrintReturn
reg import %backupDir%\%HK5%.reg
rem PrintReturn
rem PrintColorAt "{ Restore From '%backupDir%' Completed. }" 13 2 %green10% %black0%
timeout /t 4 /nobreak >nul
GoTo restart
GOTO:EOF

rem ***************
rem end subroutines
rem ***************