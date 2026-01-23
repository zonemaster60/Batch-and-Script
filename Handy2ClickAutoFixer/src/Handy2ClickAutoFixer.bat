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
REM BFCPEVERVERSION=1.1.0.7
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
rem DisableQuickEdit

rem ***********************************************
rem David Scouten (c2024-26) zonemaster60@gmail.com
rem ***********************************************

rem ********************
rem variables start here
rem ********************
Set chkflag=False
Set chkhealth=False
Set resetbase=False
Set shutdown=False
Set version=v1.1.0.7

rem ******************
rem set initial values
rem ******************
Set analyze=False
Set repair=False
Set skipped=False

rem ***********
rem time values
rem ***********
Set misstime=1500
Set waittime=5000
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

rem *************
rem math routines
rem *************************
rem btntime = waittime - 4800
rem *************************
rem Subtract %waittime% 4800
Set btntime=%result%

rem **********************
rem newtime = waittime / 5
rem **********************
rem Divide %waittime% 5
Set newtime=%result%

rem **********************
rem newtime2 = newtime / 2
rem **********************
rem Divide %newtime% 2
Set newtime2=%result%

rem *************
rem display title
rem *************
Title {Handy2ClickAutoFixer - %version%}

rem **********************
rem *calculate # of addons
rem **********************
Set "addondir=addons"
Set "addonfile=addons.txt"
Set "SFCFile=SFCFix.exe"

If exist %addonfile% (
Set /a count=0
for /f "usebackq delims=" %%A in ("%addonfile%") do (
    Set /a count+=1
    Set "addon!count!=%%A"
)
)

rem make this folder if the addons.txt file is present
If exist %addonfile% (
If not exist %addondir% mkdir %addondir%
)

rem **************************
rem set registry backup folder
rem **************************
set backupDir=regbackups

rem ********************
rem check for powershell
rem ********************

rem PrintColorAt "Checking..." 2 2 %yellow14% %black0%
where powershell >nul 2>&1
If %errorlevel%==0 (
rem PrintColorAt "PowerShell is installed." 3 6 %green10% %black0%
) else (
rem PrintColorAt "PowerShell is NOT installed." 3 6 %red12% %black0%
)
rem Wait 1000
rem PrintColorAt "Checking..." 4 2 %yellow14% %black0%
where pwsh >nul 2>&1
if %errorlevel%==0 (
rem PrintColorAt "PowerShell Core is installed." 5 6 %green10% %black0%
) else (
rem PrintColorAt "PowerShell Core is NOT installed." 5 6 %red12% %black0%
)
rem Wait 1000

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
rem PrintColorAt "{  SKIP  }" 4 66 %yellow14% %black0%
)
If %repair% EQU True (
rem PrintColorAt "{  DONE  }" 5 66 %green10% %black0%
) else (
rem PrintColorAt "{ ------ }" 5 66 %gray7% %black0%
)
rem PrintColorAt "{ OPTION }" 6 66 %gray7% %black0%
If %repair% EQU True (
rem PrintColorAt "[ SYSTEM ]" 7 66 %yellow14% %black0%
) else (
rem PrintColorAt "[ SYSTEM ]" 7 66 %green10% %black0%
)

rem *addons.txt check
If exist %addonfile% (
rem PrintColorAt "[ ADDONS ]" 8 66 %cyan3% %black0%
) else (
rem PrintColorAt "[ ADDONS ]" 8 66 %gray7% %black0%
)

rem *************
rem button matrix
rem *************

rem MouseCmd 5,4,14,4 5,5,14,5 5,6,14,6 5,7,14,7 5,8,14,8 5,9,14,9 66,7,75,7 66,8,75,8

If %result% EQU 1 (
Call :make_button "[ ANALYZE]" 4 5 1 10 %yellow14% %btntime% %black0%
rem PrintColorAt "(Go to the ANALYZE menu.)" 4 16 %yellow14% %black0%
rem Wait %misstime%
GoTo wAnalyze
)

If %result% EQU 2 (
Call :make_button "[ REPAIR ]" 5 5 1 10 %green10% %btntime% %black0%
rem PrintColorAt "(Go to the REPAIR menu.)" 5 16 %green10% %black0%
rem Wait %misstime%
Goto wRepair
)

If %result% EQU 3 (
Call :make_button "[ SYSINT ]" 6 5 1 10 %magenta5% %btntime% %black0%
Call :run_command "start https://live.sysinternals.com/" 6 >nul
rem PrintColorAt "(Visit live.sysinternals.com.)" 6 16 %magenta5% %black0%
rem Wait %misstime%
Goto wMainMenu
)

If %result% EQU 4 (
Call :make_button "[  INFO  ]" 7 5 1 10 %cyan3% %btntime% %black0%
rem PrintColorAt "(Get info about your system.)" 7 16 %cyan3% %black0%
rem Wait %misstime%
Goto wInfo1
)

If %result% EQU 5 (
Call :make_button "[WINTOOLS]" 8 5 1 10 %green10% %btntime% %black0%
rem PrintColorAt "(Go to the WINTOOLS menu.)" 8 16 %green10% %black0%
rem Wait %misstime%
GoTo wTools
)

If %result% EQU 6 (
Call :make_button "[  EXIT  ]" 9 5 1 10 %red12% %btntime% %black0%
rem PrintColorAt "(Go to the EXIT menu.)" 9 16 %red12% %black0%
rem Wait %misstime%
Goto wExit
)

If %result% EQU 7 (
If %repair% EQU True (
Call :make_button "[ SYSTEM ]" 7 66 1 10 %yellow14% %btntime% %black0%
rem PrintColorAt "(Go to the SYSTEM menu.)" 7 41 %yellow14% %black0%
rem Wait %misstime%
Goto wSystem
) else (
Call :make_button "[ SYSTEM ]" 7 66 1 10 %green10% %btntime% %black0%
rem PrintColorAt "(Go to the SYSTEM menu.)" 7 41 %green10% %black0%
rem Wait %misstime%
Goto wSystem
)
)

If %result% EQU 8 (
If exist %addonfile% (
Call :make_button "[ ADDONS ]" 8 66 1 10 %cyan3% %btntime% %black0%
rem PrintColorAt "(Go to the ADDONS menu.)" 8 41 %cyan3% %black0%
rem Wait %misstime%
GoTo wAddons
) else (
Call :make_button "[ ADDONS ]" 8 66 1 10 %gray7% %btntime% %black0%
rem PrintColorAt "('%addonfile%' is missing.)" 8 39 %gray7% %black0%
rem Wait %misstime%
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
rem PrintColorAt "(SCAN image health-slow.)" 4 16 %cyan11% %black0%
rem Wait %misstime%
Set chkhealth=False
GoTo wAnalyzeNow
)

If %result% EQU 2 (
Call :make_button "[  CHECK ]" 5 5 1 10 %cyan11% %btntime% %black0%
rem PrintColorAt "(CHECK image health-fast.)" 5 16 %cyan11% %black0%
rem Wait %misstime%
Set chkhealth=True
GoTo wAnalyzeNow
)

If %result% EQU 3 (
Call :make_button "[ <BACK< ]" 6 5 1 10 %yellow14% %btntime% %black0%
rem PrintColorAt "(Go BACK to the MAIN menu.)" 6 16 %yellow14% %black0%
rem Wait %misstime%
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
Call :count_num 1 "Analyzes the system component store for errors."
Call :run_command "dism /online /cleanup-image /analyzecomponentstore" 4
Call :wait_time

rem ********************
rem check or scan health
rem ********************

Call :show_me %black0% 0
If %chkhealth% EQU True (
Call :count_num 2 "CheckHealth is faster, but not a thorough test."
Call :run_command "dism /online /cleanup-image /checkhealth" 4
) else (
Call :count_num 2 "ScanHealth is slower, but performs a much better test."
Call :run_command "dism /online /cleanup-image /scanhealth" 4
)
Call :wait_time

rem ************
rem verify files
rem ************

Call :show_me %black0% 0
Call :count_num 3 "Verifies, but doesn't replace any system files."
Call :run_command "sfc /verifyonly" 4
Set analyze=True
Set skipped=False
Call :next_page
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
rem PrintColorAt "(REPAIR the image.)" 4 16 %cyan11% %black0%
rem Wait %misstime%
Set resetbase=False
GoTo wRepairNow
)

If %result% EQU 2 (
Call :make_button "[RESETBAS]" 5 5 1 10 %cyan11% %btntime% %black0%
rem PrintColorAt "(REPAIR the image, RESET BASeline.)" 5 16 %cyan11% %black0%
rem Wait %misstime%
Set resetbase=True
GoTo wRepairNow
)

If %result% EQU 3 (
Call :make_button "[ <BACK< ]" 6 5 1 10 %yellow14% %btntime% %black0%
rem PrintColorAt "(Go BACK to the MAIN menu.)" 6 16 %yellow14% %black0%
rem Wait %misstime%
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
Call :count_num 1 "Reset the entire system component store to baseline."
Call :run_command "dism /online /cleanup-image /startcomponentcleanup /resetbase" 4
) else (
Call :count_num 1 "Perform a normal system component store cleanup."
Call :run_command "dism /online /cleanup-image /startcomponentcleanup" 4
)
Call :wait_time

rem **************
rem restore health
rem **************

Call :show_me %black0% 0
Call :count_num 2 "Clean, update, and restore the system image health."
Call :run_command "dism /online /cleanup-image /restorehealth" 4
Call :wait_time

rem ********
rem scan now
rem ********

Call :show_me %black0% 0
Call :count_num 3 "Scans, and replaces any corrupted system files."
Call :run_command "sfc /scannow" 4
If %analyze% EQU False (
Set skipped=True
) else (
Set skipped=False
Set analyze=True
)
Set repair=True
If exist %addondir% (
If exist %addondir%\%SFCFile% (
start %addondir%\%SFCFile%
) else (
rem PrintCenter "{ If You Have '%SFCFile%', Place It In The '%addonsdir%' folder. }" 20 %cyan3% %black0%
)
)
Call :next_page
GoTo wSystem

rem ***********
rem info part 1
rem ***********

:wInfo1
Call :show_me %black0% 0
Set lmenu=INFO1
rem PrintCenter "{%lmenu%} Menu" 1 %cyan3% %black0%
rem PrintCenter "{ Use The Mouse to Navigate or the Number 0-9 Keys }" 4 %yellow14% %black0%
rem PrintCenter "[ ANALYZE ] This uses DISM and SFC to [ ANALYZE ] for" 6 %yellow14% %black0%
rem PrintCenter "corrupted system files. This option DOES NOT make any repairs." 7 %yellow14% %black0%
rem PrintCenter "[ REPAIR ] This also uses DISM and SFC." 9 %green10% %black0%
rem PrintCenter "to [ ANALYZE ] and [ REPAIR ] any corrupted system files." 10 %green10% %black0%
rem PrintCenter "[ SYSINT ] Open/Loads the Sysinternals Tools Web Page." 12 %magenta5% %black0%
rem PrintCenter "[ INFO ] You are reading it now." 14 %cyan3% %black0%
rem PrintCenter "[WINTOOLS] Access the windows built in tools." 16 %green10% %black0%
rem PrintCenter "[ EXIT ] Exit the program." 18 %red12% %black0%
Call :next_page

rem ***********
rem info part 2
rem ***********

:wInfo2
Call :show_me %black0% 0
Set lmenu=INFO2
rem PrintCenter "{%lmenu%} Menu" 1 %cyan3% %black0%
rem PrintCenter "{ Use The Mouse to Navigate or the Number 0-9 Keys }" 4 %yellow14% %black0%
rem PrintCenter "{ STATUS } The status of [ ANALYZE ] and [ REPAIR ] system image tasks." 6 %gray7% %black0%
rem PrintCenter "{ ------ } ------/ DONE [ ANALYZE ] system image task." 8 %gray7% %black0%
rem PrintCenter "{ ------ } ------/ DONE [ REPAIR ] system image task." 10 %gray7% %black0%
rem PrintCenter "{ OPTION } Options are [ RESTART ], [ SHUTDOWN ], or [ WINTOOLS ]." 12 %gray7% %black0%
rem PrintCenter "[ SYSTEM ] [ RESTART ] and [ SHUTDOWN ] the system." 14 %green10% %black0%
rem PrintCenter "[ ADDONS ] If you have them you can access them from this menu." 16 %cyan3% %black0%
Call :next_page

rem ***********
rem info part 3
rem ***********

:wInfo3
Call :show_me %black0% 0
Set lmenu=INFO3
rem PrintCenter "{%lmenu%} Menu" 1 %cyan3% %black0%
rem PrintCenter "{ Use The Mouse to Navigate or the Number 0-9 Keys }" 4 %yellow14% %black0%
rem PrintColorAt "ComputerName: %computername%" 6 15 %cyan3% %black0%
rem PrintColorAt "HomeDrive: %homedrive%" 8 15 %gray7% %black0%
rem PrintColorAt "HomePath: %homepath%" 10 15 %cyan3% %black0%
rem PrintColorAt "Operating System: %os%" 12 15 %cyan11% %black0%
rem PrintColorAt "Architecture: %PROCESSOR_ARCHITECTURE%" 14 15 %gray7% %black0%
rem PrintColorAt "UserName: %username%" 16 15 %cyan3% %black0%
rem PrintColorAt "Windows Directory: %windir%" 18 15 %cyan11% %black0%
rem PrintCenter "{ Thank you for taking the time to try this program }" 20 %green10% %black0%
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
rem PrintColorAt "(EXIT to the OS.)" 4 16 %red12% %black0%
rem Wait %misstime%
GoTo wExitNow
)

If %result% EQU 2 (
Call :make_button "[ <BACK< ]" 5 5 1 10 %yellow14% %btntime% %black0%
rem PrintColorAt "(Go BACK to the MAIN menu.)" 5 16 %yellow14% %black0%
rem Wait %misstime%
GoTo wMainMenu
)
GoTo wExit

:wExitNow
rem ********
rem exit now
rem ********

Call :show_me %black0% 0
rem PrintCenter "{ Thank you for using this FREE Software }" 12 %cyan11% %black0%
Call :wait_time >nul
ENDLOCAL
Exit /B %ErrorLevel%

rem ***********
rem system menu
rem ***********

:wSystem
Set lmenu=SYSTEM
Call :show_me %black0% 1
rem PrintColorAt "{ %lmenu% }" 3 5 %gray7% %black0%
rem PrintColorAt "[ RESTART]" 4 5 %cyan11% %black0%
rem PrintColorAt "[SHUTDOWN]" 5 5 %cyan11% %black0%
rem PrintColorAt "[ <BACK< ]" 6 5 %yellow14% %black0%

rem *************
rem button matrix
rem *************

rem MouseCmd 5,4,14,4 5,5,14,5 5,6,14,6

If %result% EQU 1 (
Call :make_button "[ RESTART]" 4 5 1 10 %cyan11% %btntime% %black0%
rem PrintColorAt "(RESTART the system.)" 4 16 %cyan11% %black0%
rem Wait %misstime%
Set shutdown=False
GoTo wRestartNow
)

If %result% EQU 2 (
Call :make_button "[SHUTDOWN]" 5 5 1 10 %cyan11% %btntime% %black0%
rem PrintColorAt "(SHUTDOWN the system.)" 5 16 %cyan11% %black0%
rem Wait %misstime%
Set shutdown=True
GoTo wRestartNow
)

If %result% EQU 3 (
Call :make_button "[ <BACK< ]" 6 5 1 10 %yellow14% %btntime% %black0%
rem PrintColorAt "(Go BACK to the MAIN menu.)" 6 16 %yellow14% %black0%
rem Wait %misstime%
GoTo wMainMenu
)
GoTo wSystem

rem *******
rem restart
rem *******

:wRestartNow
Set lmenu=SHUTDOWN
Call :show_me %black0% 1
If %shutdown% EQU False (
rem PrintCenter "{ Restarting system in %wshutdown% second(s) }" 12 %cyan11% %black0%
Call :wait_time >nul
Call :run_command "shutdown /R /T %wshutdown%" 20 >nul
)

rem ********
rem shutdown
rem ********

If %shutdown% EQU True (
rem PrintCenter "{ Shutting down system in %wshutdown% second(s) }" 12 %cyan11% %black0%
Call :wait_time >nul
Call :run_command "shutdown /S /T %wshutdown%" 20 >nul
)

rem ****
rem exit
rem ****

ENDLOCAL
Exit /B %ErrorLevel%

:wAddons
Set lmenu=ADDONS
Call :show_me %black0% 1
rem PrintColorAt "{ %lmenu% }" 3 5 %gray7% %black0%
If exist %addondir%\%addon1%.exe (
rem PrintColorAt "[ ADDON1 ] = (%addon1%.exe)" 4 5 %cyan11% %black0%
) else (
rem PrintColorAt "[ ADDON1 ] = (%addon1%)" 4 5 %gray7% %black0%
)
If exist %addondir%\%addon2%.exe (
rem PrintColorAt "[ ADDON2 ] = (%addon2%.exe)" 5 5 %cyan11% %black0%
) else (
rem PrintColorAt "[ ADDON2 ] = (%addon2%)" 5 5 %gray7% %black0%
)
If exist %addondir%\%addon3%.exe (
rem PrintColorAt "[ ADDON3 ] = (%addon3%.exe)" 6 5 %cyan11% %black0%
) else (
rem PrintColorAt "[ ADDON3 ] = (%addon3%)" 6 5 %gray7% %black0%
)
If exist %addondir%\%addon4%.exe (
rem PrintColorAt "[ ADDON4 ] = (%addon4%.exe)" 7 5 %cyan11% %black0%
) else (
rem PrintColorAt "[ ADDON4 ] = (%addon4%)" 7 5 %gray7% %black0%
)
If exist %addondir%\%addon5%.exe (
rem PrintColorAt "[ ADDON5 ] = (%addon5%.exe)" 8 5 %cyan11% %black0%
) else (  
rem PrintColorAt "[ ADDON5 ] = (%addon5%)" 8 5 %gray7% %black0%
)
If exist %addondir%\%addon6%.exe (
rem PrintColorAt "[ ADDON6 ] = (%addon6%.exe)" 9 5 %cyan11% %black0%
) else (  
rem PrintColorAt "[ ADDON6 ] = (%addon6%)" 9 5 %gray7% %black0%
)
rem PrintColorAt "[ <BACK< ]" 10 5 %yellow14% %black0%

rem *************
rem button matrix
rem *************

rem MouseCmd 5,4,14,4 5,5,14,5 5,6,14,6 5,7,14,7 5,8,14,8 5,9,14,9 5,10,14,10

If %result% EQU 1 (
If exist %addondir%\%addon1%.exe (
Call :make_button "[ ADDON1 ] = (%addon1%.exe)" 4 5 1 10 %cyan11% %btntime% %black0%
start %addondir%\%addon1%.exe
) else (
Call :make_button "[ ADDON1 ] = (%addon1%)" 4 5 1 10 %gray7% %btntime% %black0%
rem PrintColorAt "(%addon1% is missing.)" 4 18 %yellow14% %black0%
rem Wait %misstime%
)
)

If %result% EQU 2 (
If exist %addondir%\%addon2%.exe (
Call :make_button "[ ADDON2 ] = (%addon2%.exe)" 5 5 1 10 %cyan11% %btntime% %black0%
start %addondir%\%addon2%.exe
) else (
Call :make_button "[ ADDON2 ] = (%addon2%)" 5 5 1 10 %gray7% %btntime% %black0%
rem PrintColorAt "(%addon2% is missing.)" 5 18 %yellow14% %black0%
rem Wait %misstime%
)
)

If %result% EQU 3 (
If exist %addondir%\%addon3%.exe (
Call :make_button "[ ADDON3 ] = (%addon3%.exe)" 6 5 1 10 %cyan11% %btntime% %black0%
start %addondir%\%addon3%.exe
) else (
Call :make_button "[ ADDON3 ] = (%addon3%)" 6 5 1 10 %gray7% %btntime% %black0%
rem PrintColorAt "(%addon3% is missing.)" 6 18 %yellow14% %black0%
rem Wait %misstime%
)
)

If %result% EQU 4 (
If exist %addondir%\%addon4%.exe (
Call :make_button "[ ADDON4 ] = (%addon4%.exe)" 7 5 1 10 %cyan11% %btntime% %black0%
start %addondir%\%addon4%.exe
) else (
Call :make_button "[ ADDON4 ] = (%addon4%)" 7 5 1 10 %gray7% %btntime% %black0%
rem PrintColorAt "(%addon4% is missing.)" 7 18 %yellow14% %black0%
rem Wait %misstime%
)
)

If %result% EQU 5 (
If exist %addondir%\%addon5%.exe (
Call :make_button "[ ADDON5 ] = (%addon5%.exe)" 8 5 1 10 %cyan11% %btntime% %black0%
start %addondir%\%addon5%.exe
) else (
Call :make_button "[ ADDON5 ] = (%addon5%)" 8 5 1 10 %gray7% %btntime% %black0%
rem PrintColorAt "(%addon5% is missing.)" 8 18 %yellow14% %black0%
rem Wait %misstime%
)
)

If %result% EQU 6 (
If exist %addondir%\%addon6%.exe (
Call :make_button "[ ADDON6 ] = (%addon6%.exe)" 9 5 1 10 %cyan11% %btntime% %black0%
start %addondir%\%addon6%.exe
) else (
Call :make_button "[ ADDON6 ] = (%addon6%)" 9 5 1 10 %gray7% %btntime% %black0%
rem PrintColorAt "(%addon6% is missing.)" 9 18 %yellow14% %black0%
rem Wait %misstime%
)
)

If %result% EQU 7 (
Call :make_button "[ <BACK< ]" 10 5 1 10 %yellow14% %btntime% %black0%
rem PrintColorAt "(Go BACK to the MAIN menu.)" 10 16 %yellow14% %black0%
rem Wait %misstime%
GoTo wMainMenu
)
GoTo wAddons

rem *************
rem wintools menu
rem *************

:wTools
Set lmenu=WINTOOLS
Call :show_me %black0% 1
rem PrintColorAt "{%lmenu%}" 3 5 %gray7% %black0%
rem PrintColorAt "[ CHKDSK ]" 4 5 %cyan11% %black0%
rem PrintColorAt "[CLEANMGR]" 5 5 %cyan11% %black0%
rem PrintColorAt "[MSCONFIG]" 6 5 %cyan11% %black0%
rem PrintColorAt "[REG-BACK]" 7 5 %cyan11% %black0%
rem PrintColorAt "[SERVICES]" 8 5 %cyan11% %black0%
rem PrintColorAt "[ TASKMGR]" 9 5 %cyan11% %black0%
rem PrintColorAt "[WINUPFIX]" 10 5 %cyan11% %black0%
rem PrintColorAt "[ <BACK< ]" 11 5 %yellow14% %black0%

rem *************
rem button matrix
rem *************

rem MouseCmd 5,4,14,4 5,5,14,5 5,6,14,6 5,7,14,7 5,8,14,8 5,9,14,9 5,10,14,10 5,11,14,11

If %result% EQU 1 (
Call :make_button "[ CHKDSK ]" 4 5 1 10 %cyan11% %btntime% %black0%
rem PrintColorAt "(Run the CHKDSK tool.)" 4 16 %cyan11% %black0%
rem Wait %misstime%
GoTo wCheckDisk
)

If %result% EQU 2 (
Call :make_button "[CLEANMGR]" 5 5 1 10 %cyan11% %btntime% %black0%
rem PrintColorAt "(Run the CLEANMGR tool.)" 5 16 %cyan11% %black0%
rem Wait %misstime%
Call :run_command "cleanmgr.exe" 20 >nul
)

If %result% EQU 3 (
Call :make_button "[MSCONFIG]" 6 5 1 10 %cyan11% %btntime% %black0%
rem PrintColorAt "(Run the MSCONFIG tool.)" 6 16 %cyan11% %black0%
rem Wait %misstime%
Call :run_command "msconfig.exe" 20 >nul
)

If %result% EQU 4 (
Call :make_button "[REG-BACK]" 7 5 1 10 %cyan11% %btntime% %black0%
rem PrintColorAt "(Run the REGistry BACKup.)" 7 16 %cyan11% %black0%
rem Wait %misstime%
GoTo wRegBackup
)

If %result% EQU 5 (
Call :make_button "[SERVICES]" 8 5 1 10 %cyan11% %btntime% %black0%
rem PrintColorAt "(Run the SERVICES tool.)" 8 16 %cyan11% %black0%
rem Wait %misstime%
Call :run_command "services.msc" 20 >nul
)

If %result% EQU 6 (
Call :make_button "[ TASKMGR]" 9 5 1 10 %cyan11% %btntime% %black0%
rem PrintColorAt "(Run the TASKMGR tool.)" 9 16 %cyan11% %black0%
rem Wait %misstime%
Call :run_command "taskmgr.exe /7" 20 >nul
)

If %result% EQU 7 (
Call :make_button "[WINUPFIX]" 10 5 1 10 %cyan11% %btntime% %black0%
rem PrintColorAt "(Go to the WINUPFIX menu.)" 10 16 %cyan11% %black0%
rem Wait %misstime%
GoTo WinUpdateFix
)

If %result% EQU 8 (
Call :make_button "[ <BACK< ]" 11 5 1 10 %yellow14% %btntime% %black0%
rem PrintColorAt "(Go BACK to the MAIN menu.)" 11 16 %yellow14% %black0%
rem Wait %misstime%
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
rem PrintColorAt "(CHKDSK READONLY mode.)" 4 16 %cyan11% %black0%
rem Wait %misstime%
Call :show_me %black0% 0
Call :check_num "Read Only mode"
Set chkflag=True
Call :run_command "chkdsk %SystemDrive%" 4
Call :next_page
GoTo wCheckDisk
)

If %result% EQU 2 (
Call :make_button "[  SCAN  ]" 5 5 1 10 %cyan11% %btntime% %black0%
rem PrintColorAt "(CHKDSK online SCAN mode.)" 5 16 %cyan11% %black0%
rem Wait %misstime%
Call :show_me %black0% 0
Call :check_num "Online Scan mode"
Set chkflag=True
Call :run_command "chkdsk %SystemDrive% /scan" 4
Call :next_page
GoTo wCheckDisk
)

If %result% EQU 3 (
Call :make_button "[ REPAIR ]" 6 5 1 10 %cyan11% %btntime% %black0%
rem PrintColorAt "(CHKDSK boot REPAIR mode.)" 6 16 %cyan11% %black0%
rem Wait %misstime%
Call :show_me %black0% 0
Call :check_num "Boot Repair mode"
Set chkflag=True
Call :run_command "chkdsk %SystemDrive% /F" 4
Call :next_page
GoTo wSystem
)

If %result% EQU 4 (
Call :make_button "[ SPOTFIX]" 7 5 1 10 %cyan11% %btntime% %black0%
rem PrintColorAt "(CHKDSK SPOTFIX mode.)" 7 16 %cyan11% %black0%
rem Wait %misstime%
Call :show_me %black0% 0
Call :check_num "Online Spotfix mode"
Set chkflag=True
Call :run_command "chkdsk %SystemDrive% /spotfix" 4
Call :next_page
GoTo wSystem
)

If %result% EQU 5 (
Call :make_button "[ <BACK< ]" 8 5 1 10 %yellow14% %btntime% %black0%
rem PrintColorAt "(Go BACK to the WINTOOLS menu.)" 8 16 %yellow14% %black0%
rem Wait %misstime%
GoTo wTools
)
GoTo wCheckDisk

rem *****************
rem begin subroutines
rem *************************
rem display the title section
rem *************************

:show_me
mode con:cols=80 lines=25
rem ClearColor
rem PaintScreen %1
:redo1
rem GenRandom 15
If %result% EQU 0 GoTo redo1
If %2 EQU 1 (
rem PrintCenter "{%lmenu%} Menu" 1 %result% %black0%
rem PrintCenter "{ Choose An Option From The '%lmenu%' Menu }" 12 %result% %black0%
rem PrintColorAt "{ ZoneSoft (c2024-26) zonemaster60@gmail.com }" 25 18 %result% %black0%
)
rem CursorHide
GOTO:EOF

rem *********************************
rem run a command with error checking
rem *********************************

:run_command
rem PrintColorAt "> %TIME%" 4 2 %green10% %black0%
rem PrintColorAt ">> %1" 5 2 %green10% %black0%
rem PrintReturn
rem ***********
rem t1 = %2 + 2
rem ***********
rem Add %2 3
Set t1=%result%
rem PrintReturn
rem PrintCenter "{ Please Do Not Close This Window Until ALL Tasks Are Done }" %t1% %yellow14% %black0%
rem PrintReturn
If %chkflag% EQU True (
Set chkflag=False
)
rem ChangeColor %gray7% %black0%
Cmd /c %1
If %ErrorLevel% LSS 1 (
rem PrintReturn
rem PrintColorAt "> %TIME%                   { Success }" 24 2 %green10% %black0%
) else (
rem PrintReturn
rem PrintColorAt "> %TIME%                   { Failed }" 24 2 %red12% %black0%
)
GOTO:EOF

rem ******************
rem shows current task
rem ******************

:count_num
rem PrintColorAt "Task %1/3 > %2" 2 2 %blue9% %black0%
GOTO:EOF

rem ********************
rem shows checkdisk info
rem ********************

:check_num
rem PrintColorAt "WINTOOLS > CheckDisk - %1" 2 2 %blue9% %black0%
GOTO:EOF

rem ****************
rem next_page button
rem ****************

:next_page
rem PrintColorAt "[ >>>>>> ]" 25 35 %green10% %black0%
rem MouseCmd 35,25,44,25

If %result% EQU 1 (
Call :make_button "[ >>>>>> ]" 25 35 1 10 %green10% %btntime% %black0%
)
GOTO:EOF

rem ******************
rem time out for menus
rem ********************
rem * wait for 4 seconds
rem ********************

:wait_time
Set wtime=4
:Loop1
rem PrintColorAt "{ Continue in %wtime% }" 25 32 %cyan11% %black0%
rem Wait %newtime2%
rem PrintColorAt "{ Continue in %wtime% }" 25 32 %cyan3% %black0%
rem Wait %newtime2%
Set /a wtime-=1
If %wtime% LSS 1 GoTo wFin1
GoTo Loop1
:wFin1
GOTO:EOF

rem *******************
rem makes a menu button
rem *******************

:make_button
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
rem PrintColorAt "(FIX windows update NOW.)" 4 16 %cyan11% %black0%
rem Wait %misstime%
Call :resetwindowsupdate
set shutdown=False
GoTo wRestartNow
)

If %result% EQU 2 (
Call :make_button "[ <BACK< ]" 5 5 1 10 %yellow14% %btntime% %black0%
rem PrintColorAt "(Go BACK to the WINTOOLS menu.)" 5 16 %yellow14% %black0%
rem Wait %misstime%
GoTo wTools
)
GoTo WinUpdateFix

:resetwindowsupdate
Call :show_me %black0% 0
rem PrintColor "Checking Drive Health Status..." %yellow14% %black0%
rem PrintReturn
fsutil dirty query %SystemDrive%
rem PrintReturn
rem PrintColor "Stopping update services..." %red12% %black0%
rem PrintReturn
net stop wuauserv
net stop bits
net stop appidsvc
net stop cryptsvc
rem PrintColor "Flushing DNS Configuration..." %yellow14% %black0%
rem PrintReturn
ipconfig /flushdns
rem PrintReturn
If exist %ALLUSERSPROFILE%\Application Data\Microsoft\Network\Downloader\qmgr*.dat del /s /q /f %ALLUSERSPROFILE%\Application Data\Microsoft\Network\Downloader\qmgr*.dat 
If exist %ALLUSERSPROFILE%\Microsoft\Network\Downloader\qmgr*.dat del /s /q /f %ALLUSERSPROFILE%\Microsoft\Network\Downloader\qmgr*.dat
If exist %SYSTEMROOT%\Logs\WindowsUpdate\* del /s /q /f %SYSTEMROOT%\Logs\WindowsUpdate\*
rem PrintColor "Reseting Windows Update Policies..." %yellow14% %black0%
rem PrintReturn
reg query "HKCU\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v >nul 2>&1
If %errorlevel%==0 (
rem PrintColor "Registry Object Deleted." %green10% %black0%
rem Printreturn
reg delete "HKCU\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /f
) else (
rem PrintColor "Registry Object Not Found." %red12% %black0%
rem Printreturn
)
reg query "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\WindowsUpdate" /v >nul 2>&1
If %errorlevel%==0 (
rem PrintColor "Registry Object Deleted." %green10% %black0%
rem Printreturn
reg delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\WindowsUpdate" /f
) else (
rem PrintColor "Registry Object Not Found." %red12% %black0%
rem Printreturn
)
reg query "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v >nul 2>&1
If %errorlevel%==0 (
rem PrintColor "Registry Object Deleted." %green10% %black0%
rem Printreturn
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /f
) else (
rem PrintColor "Registry Object Not Found." %red12% %black0%
rem Printreturn
)
reg query "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\WindowsUpdate" /v >nul 2>&1
If %errorlevel%==0 (
rem PrintColor "Registry Object Deleted." %green10% %black0%
rem Printreturn
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\WindowsUpdate" /f
) else (
rem PrintColor "Registry Object Not Found." %red12% %black0%
rem Printreturn
)
gpupdate /force
rem PrintReturn
rem PrintColor "Removing old 'SoftwareDistribution' folder..." %red12% %black0%
rem PrintReturn
If exist %systemroot%\SoftwareDistribution.old rmdir /s /q %systemroot%\SoftwareDistribution.old
rem PrintColor "Renaming new 'SoftwareDistribution' folder..." %yellow14% %black0%
rem PrintReturn
If exist %systemroot%\SoftwareDistribution ren %systemroot%\SoftwareDistribution SoftwareDistribution.old
rem PrintColor "Removing old 'catroot2' folder..." %red12% %black0%
rem PrintReturn
If exist %systemroot%\system32\catroot2.old rmdir /s /q %systemroot%\system32\catroot2.old
rem PrintColor "Renaming new 'catroot2' folder..." %yellow14% %black0%
rem PrintReturn
If exist %systemroot%\system32\catroot2 ren %systemroot%\system32\catroot2 catroot2.old
rem PrintColor "Resetting WinSock Configuration..." %yellow14% %black0%
rem PrintReturn
netsh winsock reset
netsh winsock reset proxy
rem PrintReturn
rem PrintColor "Starting update services..." %green10% %black0%
rem PrintReturn
net start cryptsvc
net start appidsvc
net start bits
net start wuauserv
rem PrintColor "Finished, Rebooting your computer..." %yellow14% %black0%
rem PrintReturn
Call :wait_time
GOTO:EOF

rem ***************************
rem backup and restore registry
rem ***************************
Set HK1=HKEY_LOCAL_MACHINE
Set HK2=HKEY_CURRENT_USER
Set HK3=HKEY_USERS
Set HK4=HKEY_CLASSES_ROOT
Set HK5=HKEY_CURRENT_CONFIG

:wRegBackup
Set lmenu=REG-BACK
Call :show_me %black0% 1
rem PrintColorAt "{%lmenu%}" 3 5 %gray7% %black0%
rem PrintColorAt "[ BACKUP ]" 4 5 %cyan11% %black0%
rem PrintColorAt "[ RESTORE]" 5 5 %cyan11% %black0%
rem PrintColorAt "[ <BACK< ]" 6 5 %yellow14% %black0%

rem *************
rem button matrix
rem *************

rem MouseCmd 5,4,14,4 5,5,14,5 5,6,14,6

If %result% EQU 1 (
Call :make_button "[ BACKUP ]" 4 5 1 10 %cyan11% %btntime% %black0%
rem PrintColorAt "(BACKUP the registry.)" 4 16 %cyan11% %black0%
rem Wait %misstime%
Call :backup_registry
GoTo wRegBackup
)

If %result% EQU 2 (
Call :make_button "[ RESTORE]" 5 5 1 10 %cyan11% %btntime% %black0%
rem PrintColorAt "(RESTORE the registry.)" 5 16 %cyan11% %black0%
rem Wait %misstime%
Call :restore_registry
Set shutdown=False
GoTo wSystem
)

If %result% EQU 3 (
Call :make_button "[ <BACK< ]" 6 5 1 10 %yellow14% %btntime% %black0%
rem PrintColorAt "(Go BACK to the WINTOOLS menu.)" 6 16 %yellow14% %black0%
rem Wait %misstime%
GoTo wTools
)
GoTo wRegBackup

rem backup the registry
:backup_registry
Call :show_me %black0% 0
If not exist %backupDir% mkdir %backupDir%
If exist %backupDir%\*.reg del %backupDir%\*.reg

rem PrintColorAt "Backing up registry hives..." 2 2 %yellow14% %black0%
rem PrintColorAt "Backing up HKLM..." 3 2 %cyan11% %black0%
rem PrintReturn
reg export %HK1% %backupDir%\%HK1%.reg /y
rem PrintColorAt "Backing up HKCU..." 5 2 %cyan11% %black0%
rem PrintReturn
reg export %HK2% %backupDir%\%HK2%.reg /y
rem PrintColorAt "Backing up HKU..." 7 2 %cyan11% %black0%
rem PrintReturn
reg export %HK3% %backupDir%\%HK3%.reg /y
rem PrintColorAt "Backing up HKCR..." 9 2 %cyan11% %black0%
rem PrintReturn
reg export %HK4% %backupDir%\%HK4%.reg /y
rem PrintColorAt "Backing up HKCC..." 11 2 %cyan11% %black0%
rem PrintReturn
reg export %HK5% %backupDir%\%HK5%.reg /y
rem PrintReturn
rem PrintColorAt "All hives were backed up to '%backupDir%'." 13 2 %green10% %black0%
Call :wait_time
GOTO:EOF

rem restore the registry
:restore_registry
If not exist %backupDir% GoTo backup_registry
Call :show_me %black0% 0

rem PrintColorAt "Restoring registry hives..." 2 2 %yellow14% %black0%
rem PrintColorAt "Restoring HKLM..." 3 2 %cyan11% %black0%
rem PrintReturn
reg import %backupDir%\%HK1%.reg
rem PrintColorAt "Restoring HKCU..." 5 2 %cyan11% %black0%
rem PrintReturn
reg import %backupDir%\%HK2%.reg
rem PrintColorAt "Restoring HKU..." 7 2 %cyan11% %black0%
rem PrintReturn
reg import %backupDir%\%HK3%.reg
rem PrintColorAt "Restoring HKCR..." 9 2 %cyan11% %black0%
rem PrintReturn
reg import %backupDir%\%HK4%.reg
rem PrintColorAt "Restoring HKCC..." 11 2 %cyan11% %black0%
rem PrintReturn
reg import %backupDir%\%HK5%.reg
rem PrintReturn
rem PrintColorAt "Restoring from '%backupDir%' completed." 13 2 %green10% %black0%
Call :wait_time
GOTO:EOF

rem ***************
rem end subroutines
rem ***************