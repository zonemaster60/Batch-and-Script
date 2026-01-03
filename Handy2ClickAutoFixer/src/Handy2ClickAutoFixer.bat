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
REM BFCPEVERVERSION=1.0.7.7
REM BFCPEVERPRODUCT=Handy 2Click AutoFixer
REM BFCPEVERDESC=Handy 2Click AutoFixer
REM BFCPEVERCOMPANY=ZoneSoft
REM BFCPEVERCOPYRIGHT=David Scouten (2024-2025)
REM BFCPEWINDOWCENTER=1
REM BFCPEDISABLEQE=0
REM BFCPEWINDOWHEIGHT=25
REM BFCPEWINDOWWIDTH=80
REM BFCPEWTITLE=
REM BFCPEOPTIONEND
@Echo off
SETLOCAL EnableExtensions
pushd "%~dp0"

rem PrintCenter "Loading....please wait." 1 15 0
rem Wait 500

rem CenterSelf
rem CursorHide
rem DisableQuickEdit

rem ***********************************************
rem David Scouten (c2024-25) zonemaster60@gmail.com
rem ***********************************************
rem compiled with Advanced BAT to EXE Converter
rem *********************************************

rem ********************
rem variables start here
rem ********************
Set chkflag=False
Set chkhealth=False
Set resetbase=False
Set shutdown=False
Set version=1.0.7.7

rem ******************
rem set initial values
rem ******************
Set analyze=False
Set repair=False
Set skipped=False

rem *************
rem files created
rem *************
Set logfile=Handy2ClickAutoFixer.log

rem ***********
rem time values
rem ***********
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
rem *************

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

Call :logMessage "Handy2ClickAutoFixer started."
Title {Handy 2Click AutoFixer-v%version%}

rem *********
rem main menu
rem *********

:wMainMenu
Call :show_me %cyan3% 1
rem PaintBoxAt 2 3 9 14 %cyan11%
rem PaintBoxAt 12 14 3 53 %cyan11%
rem PrintColorAt "{MAINMENU}" 3 5 %gray7% %cyan3%
rem PrintColorAt "[ ANALYZE]" 4 5 %yellow14% %gray8%
rem PrintColorAt "[ REPAIR ]" 5 5 %green10% %gray8%
rem PrintColorAt "[ SYSINT ]" 6 5 %magenta5% %gray8%
rem PrintColorAt "[  INFO  ]" 7 5 %blue1% %gray8%
rem PrintColorAt "[WINTOOLS]" 8 5 %green10% %gray8%
rem PrintColorAt "[ >EXIT> ]" 9 5 %red12% %gray8%
rem PrintColorAt "Choose ANALYZE, REPAIR, SYSINT, Or Something Else" 13 16 %gray7% %gray8%

rem **************
rem display status
rem **************

rem PaintBoxAt 2 64 8 14 %cyan11%
rem PrintColorAt "{ STATUS }" 3 66 %gray7% %cyan3%
If %analyze% EQU True (
rem PrintColorAt "{  DONE  }" 4 66 %gray7% %green10%
) else (
rem PrintColorAt "{ ------ }" 4 66 %gray7% %red12%
)
If %skipped% EQU True (
rem PrintColorAt "{  SKIP  }" 4 66 %gray8% %yellow14%
)
If %repair% EQU True (
rem PrintColorAt "{  DONE  }" 5 66 %gray7% %green10%
) else (
rem PrintColorAt "{ ------ }" 5 66 %gray7% %red12%
)

rem *************
rem other options
rem *************

rem PrintColorAt "{ OPTION }" 6 66 %gray7% %cyan3%
If %repair% EQU True (
rem PrintColorAt "[ SYSTEM ]" 7 66 %red12% %gray8%
) else (
rem PrintColorAt "[ SYSTEM ]" 7 66 %yellow14% %gray8%
)
rem PrintColorAt "[ VIEWLOG]" 8 66 %cyan3% %gray8%

rem *************
rem button matrix
rem *************

rem MouseCmd 5,4,14,4 5,5,14,5 5,6,14,6 5,7,14,7 5,8,14,8 5,9,14,9 66,7,75,7 66,8,75,8

If %result% EQU 1 (
Call :make_button "[ ANALYZE]" 4 5 1 10 %yellow14% %btntime% %gray8%
Call :logMessage "wAnalyze(menu) was called."
GoTo wAnalyze
)

If %result% EQU 2 (
Call :make_button "[ REPAIR ]" 5 5 1 10 %green10% %btntime% %gray8%
Call :logMessage "wRepair(menu) was called."
Goto wRepair
)

If %result% EQU 3 (
Call :make_button "[ SYSINT ]" 6 5 1 10 %magenta5% %btntime% %gray8%
Call :run_command "start https://live.sysinternals.com/" 6 >nul
Goto wMainMenu
)

If %result% EQU 4 (
Call :make_button "[  INFO  ]" 7 5 1 10 %blue1% %btntime% %gray8%
Call :logMessage "wInfo1(page1) was called."
Goto wInfo1
)

If %result% EQU 5 (
Call :make_button "[WINTOOLS]" 8 5 1 10 %green10% %btntime% %gray8%
Call :logMessage "wTools(menu) was called."
GoTo wTools
)

If %result% EQU 6 (
Call :make_button "[ >EXIT> ]" 9 5 1 10 %red12% %btntime% %gray8%
Call :logMessage "wExit(menu) was called."
Goto wExit
)

If %result% EQU 7 (
If %repair% EQU True (
Call :make_button "[ SYSTEM ]" 7 66 1 10 %red12% %btntime% %gray8%
Call :logMessage "wSystem(menu) was called."
Goto wSystem
) else (
Call :make_button "[ SYSTEM ]" 7 66 1 10 %yellow14% %btntime% %gray8%
Call :logMessage "wSystem(menu) was called."
Goto wSystem
)
)

If %result% EQU 8 (
Call :make_button "[ VIEWLOG]" 8 66 1 10 %cyan3% %btntime% %gray8%
Call :run_command "start notepad %logfile%" 8 >nul
Call :logMessage "notepad.exe was called."
GoTo wMainMenu
)
GoTo wMainMenu

rem ************
rem analyze menu
rem ************

:wAnalyze
Call :show_me %cyan3% 1
rem PaintBoxAt 2 3 6 14 %cyan11%
rem PaintBoxAt 11 18 3 46 %cyan11%
rem PrintColorAt "{ ANALYZE}" 3 5 %yellow14% %cyan3%
rem PrintColorAt "[  SCAN  ]" 4 5 %cyan11% %gray8%
rem PrintColorAt "[  CHECK ]" 5 5 %cyan11% %gray8%
rem PrintColorAt "[ <BACK< ]" 6 5 %yellow14% %gray8%
rem PrintColorAt "Choose SCAN, CHECK, Or <BACK< For MAINMENU" 12 20 %gray7% %gray8%

rem *************
rem button matrix
rem *************

rem MouseCmd 5,4,14,4 5,5,14,5 5,6,14,6

If %result% EQU 1 (
Call :make_button "[  SCAN  ]" 4 5 1 10 %cyan11% %btntime% %gray8%
Set chkhealth=False
Call :logMessage "wAnalyzeNow(scan) was called."
GoTo wAnalyzeNow
)

If %result% EQU 2 (
Call :make_button "[  CHECK ]" 5 5 1 10 %cyan11% %btntime% %gray8%
Set chkhealth=True
Call :logMessage "wAnalyzeNow(check) was called."
GoTo wAnalyzeNow
)

If %result% EQU 3 (
Call :make_button "[ <BACK< ]" 6 5 1 10 %yellow14% %btntime% %gray8%
Call :logMessage "wMainMenu(menu) was called."
GoTo wMainMenu
)
Call :logMessage "wAnalyze(menu) was called."
GoTo wAnalyze

rem ***********
rem analyze now
rem ***********

rem ***************************
rem run chkdsk online scan mode
rem ***************************

:wAnalyzeNow
Call :logMessage "Analyze start."
Call :logMessage "chkdsk.exe C: /scan was called."
Call :show_me 0 0
Call :check_num "Online Scan mode"
Set chkflag=True
Call :run_command "chkdsk %systemdrive% /scan" 4
Call :wait_time

rem *********************
rem check component store
rem *********************

Call :logMessage "dism.exe /online /cleanup-image /analyzecomponentstore was called."
Call :show_me 0 0
Call :count_num 1 "Analyzes the system component store for errors."
Call :run_command "dism /online /cleanup-image /analyzecomponentstore" 4
Call :wait_time

rem ********************
rem check or scan health
rem ********************

Call :show_me 0 0
If %chkhealth% EQU True (
Call :logMessage "dism.exe /online /cleanup-image /checkhealth was called."
Call :count_num 2 "CheckHealth is faster, but not a thorough test."
Call :run_command "dism /online /cleanup-image /checkhealth" 4
) else (
Call :logMessage "dism.exe /online /cleanup-image /scanhealth was called."
Call :count_num 2 "ScanHealth is slower, but performs a much better test."
Call :run_command "dism /online /cleanup-image /scanhealth" 4
)
Call :wait_time

rem ************
rem verify files
rem ************

Call :logMessage "sfc.exe /verifyonly was called."
Call :show_me 0 0
Call :count_num 3 "Verifies, but doesn't repair any system files."
Call :run_command "sfc /verifyonly" 4
Set analyze=True
Set skipped=False
Call :next_page
Call :logMessage "Analyze Finish."
GoTo wMainMenu

rem ***********
rem repair menu
rem ***********

:wRepair
Call :show_me %cyan3% 1
rem PaintBoxAt 2 3 6 14 %cyan11%
rem PaintBoxAt 11 16 3 51 %cyan11%
rem PrintColorAt "{ REPAIR }" 3 5 %green10% %cyan3%
rem PrintColorAt "[ REPAIR ]" 4 5 %cyan11% %gray8%
rem PrintColorAt "[RESETBAS]" 5 5 %cyan11% %gray8%
rem PrintColorAt "[ <BACK< ]" 6 5 %yellow14% %gray8%
rem PrintColorAt "Choose REPAIR, RESETBAS, Or <BACK< For MAINMENU" 12 18 %gray7% %gray8%

rem *************
rem button matrix
rem *************

rem MouseCmd 5,4,14,4 5,5,14,5 5,6,14,6

If %result% EQU 1 (
Call :make_button "[ REPAIR ]" 4 5 1 10 %cyan11% %btntime% %gray8%
Set resetbase=False
Call :logMessage "wRepairNow(!resetbase) was called."
GoTo wRepairNow
)

If %result% EQU 2 (
Call :make_button "[RESETBAS]" 5 5 1 10 %cyan11% %btntime% %gray8%
Set resetbase=True
Call :logMessage "wRepairNow(resetbase) was called."
GoTo wRepairNow
)

If %result% EQU 3 (
Call :make_button "[ <BACK< ]" 6 5 1 10 %yellow14% %btntime% %gray8%
Call :logMessage "wMainMenu() was called."
GoTo wMainMenu
)
Call :logMessage "wRepair(menu) was called."
GoTo wRepair

rem **********
rem repair now
rem **********

rem ***************************
rem run chkdsk online scan mode
rem ***************************

:wRepairNow
Call :logMessage "Repair started."
Call :logMessage "chkdsk.exe C: /scan was called."
Call :show_me 0 0
Call :check_num "Online Scan mode"
Set chkflag=True
Call :run_command "chkdsk %systemdrive% /scan" 4
Call :wait_time

rem **************************
rem resetbase / normal cleanup
rem **************************

Call :show_me 0 0
If %resetbase% EQU True (
Call :logMessage "dism.exe /online /cleanup-image /startcomponentcleanup /resetbase was called."
Call :count_num 1 "Reset the entire system component store to baseline."
Call :run_command "dism /online /cleanup-image /startcomponentcleanup /resetbase" 4
) else (
Call :logMessage "dism.exe /online /cleanup-image /startcomponentcleanup was called."
Call :count_num 1 "Performs a normal system component store cleanup."
Call :run_command "dism /online /cleanup-image /startcomponentcleanup" 4
)
Call :wait_time

rem **************
rem restore health
rem **************

Call :logMessage "dism /online /cleanup-image /restorehealth was called."
Call :show_me 0 0
Call :count_num 2 "Clean, repair, and restore the health to the system image."
Call :run_command "dism /online /cleanup-image /restorehealth" 4
Call :wait_time

rem ********
rem scan now
rem ********

Call :logMessage "sfc.exe /scannow was called."
Call :show_me 0 0
Call :count_num 3 "Scans, and repairs any corrupted system files."
Call :run_command "sfc /scannow" 4
If %analyze% EQU False (
Set skipped=True
) else (
Set skipped=False
Set analyze=True
)
Set repair=True
Call :next_page
Call :logMessage "Repair finished."
Call :logMessage "wMainMenu(menu) was called."
GoTo wMainMenu

rem ***********
rem info part 1
rem ***********

:wInfo1
Call :logMessage "wInfo1(page1) was called."
Call :show_me %cyan3% 0
rem PrintCenter "{ Use The Mouse to Navigate or the Number 0-9 Keys }" 2 %yellow14% %gray8%
rem PrintCenter "[ ANALYZE ] This uses DISM and SFC to [ ANALYZE ] for" 4 %yellow14% %gray8%
rem PrintCenter "corrupted system files. This option DOES NOT make any repairs!" 5 %gray7% %gray8%
rem PrintCenter "[ REPAIR ] This also uses DISM and SFC" 7 %green10% %gray8%
rem PrintCenter "to [ ANALYZE ] and [ REPAIR ] any corrupted system files." 8 %gray7% %gray8%
rem PrintCenter "[ SYSINT ] Open/Loads the Sysinternals Tools Web Page." 10 %blue1% %gray8%
rem PrintCenter "[ INFO ] You are reading it now." 12 %gray7% %gray8%
rem PrintCenter "[ LINKS ]" Runs a PureBasic app to display a page of useful weblinks. 14 %green10% %gray8%
rem PrintCenter "[ >EXIT> ] Exit the program." 16 %red12% %gray8%
Call :next_page

rem ***********
rem info part 2
rem ***********

:wInfo2
Call :logMessage "wInfo1(page2) was called."
Call :show_me %cyan3% 0
rem PrintCenter "{ Use The Mouse to Navigate or the Number 0-9 Keys }" 2 %yellow14% %gray8%
rem PrintCenter "{ STATUS } The status of [ ANALYZE ] and [ REPAIR ] system image tasks." 4 %gray7% %gray8%
rem PrintCenter "{ ------ } ------/ DONE [ ANALYZE ] system image task." 6 %red12% %gray8%
rem PrintCenter "{ ------ } ------/ DONE [ REPAIR ] system image task." 8 %red12% %gray8%
rem PrintCenter "{ OPTION } Options are [ RESTART ], [ SHUTDOWN ], or [ WINTOOLS ]." 10 %gray7% %gray8%
rem PrintCenter "[ SYSTEM ] [ RESTART ] and [ SHUTDOWN ] the system." 12 %yellow14% %gray8%
rem PrintCenter "[ WINTOOLS ] Used to access the extra Windows [ WINTOOLS ] menu." 14 %green10% %gray8%
Call :next_page

rem ***********
rem info part 3
rem ***********

:wInfo3
Call :logMessage "wInfo1(page3) was called."
Call :show_me %cyan3% 0
rem PrintCenter "{ Use The Mouse to Navigate or the Number 0-9 Keys }" 2 %yellow14% %gray8%
rem PrintColorAt "ComputerName: %computername%" 4 15 %gray7% %gray8%
rem PrintColorAt "HomeDrive: %homedrive%" 6 15 %gray7% %gray8%
rem PrintColorAt "HomePath: %homepath%" 8 15 %gray7% %gray8%
rem PrintColorAt "Operating System: %os%" 10 15 %gray7% %gray8%
rem PrintColorAt "Architecture: %PROCESSOR_ARCHITECTURE%" 12 15 %gray7% %gray8%
rem PrintColorAt "UserName: %username%" 14 15 %gray7% %gray8%
rem PrintColorAt "Windows Directory: %windir%" 16 15 %gray7% %gray8%
rem PrintCenter "{ Thank you for taking the time to try this program! }" 18 %green10% %gray8%
rem PrintReturn
rem PrintReturn
Call :next_page
Call :logMessage "wMainMenu(menu) was called."
GoTo wMainMenu

rem *********
rem exit menu
rem *********

:wExit
Call :show_me %red12% 1
rem PaintBoxAt 2 3 5 14 %red4%
rem PaintBoxAt 11 20 3 41 %red4%
rem PrintColorAt "{ >EXIT> }" 3 5 %cyan11% %cyan3%
rem PrintColorAt "[ >EXIT> ]" 4 5 %red12% %gray8%
rem PrintColorAt "[ <BACK< ]" 5 5 %yellow14% %gray8%
rem PrintColorAt "Choose >EXIT>, Or <BACK< For MAINMENU" 12 22 %gray7% %gray8%

rem *************
rem button matrix
rem *************

rem MouseCmd 5,4,14,4 5,5,14,5
If %result% EQU 1 (
Call :make_button "[ >EXIT> ]" 4 5 1 10 %red12% %btntime% %gray8%
Call :logMessage "wExitNow(menu) was called."
GoTo wExitNow
)

If %result% EQU 2 (
Call :make_button "[ <BACK< ]" 5 5 1 10 %yellow14% %btntime% %gray8%
Call :logMessage "wMainMenu(menu) was called."
GoTo wMainMenu
)
Call :logMessage "wExit() was called."
GoTo wExit

:wExitNow
rem exit now
rem ********
Call :show_me %red12% 0
rem PaintBoxAt 11 19 3 43 %red4%
rem PrintColorAt "Thank you for using this FREE Software!" 12 21 %gray7% %gray8%
Call :wait_time >nul
Call :logMessage "Handy2ClickAutoFixer finished."
ENDLOCAL
Exit /B %ErrorLevel%

rem ***********
rem system menu
rem ***********

:wSystem
Call :show_me %red12% 1
rem PaintBoxAt 2 3 6 14 %red4%
rem PaintBoxAt 11 15 3 52 %red4%
rem PrintColorAt "{ SYSTEM }" 3 5 %yellow14% %cyan3%
rem PrintColorAt "[ RESTART]" 4 5 %cyan11% %gray8%
rem PrintColorAt "[SHUTDOWN]" 5 5 %cyan11% %gray8%
rem PrintColorAt "[ <BACK< ]" 6 5 %yellow14% %gray8%
rem PrintColorAt "Choose RESTART, SHUTDOWN, Or <BACK< For MAINMENU" 12 17 %gray7% %gray8%

rem *************
rem button matrix
rem *************

rem MouseCmd 5,4,14,4 5,5,14,5 5,6,14,6

If %result% EQU 1 (
Call :make_button "[ RESTART]" 4 5 1 10 %cyan11% %btntime% %gray8%
Set shutdown=False
Call :logMessage "wRestartNow(restart) was called."
GoTo wRestartNow
)

If %result% EQU 2 (
Call :make_button "[SHUTDOWN]" 5 5 1 10 %cyan11% %btntime% %gray8%
Set shutdown=True
Call :logMessage "wRestartNow(shutdown) was called."
GoTo wRestartNow
)

If %result% EQU 3 (
Call :make_button "[ <BACK< ]" 6 5 1 10 %yellow14% %btntime% %gray8%
Call :logMessage "wMainMenu(menu) was called."
GoTo wMainMenu
)
Call :logMessage "wSystem(menu) was called."
GoTo wSystem

rem *******
rem restart
rem *******

:wRestartNow
Call :show_me %red12% 1
If %shutdown% EQU False (
rem PaintBoxAt 11 21 3 38 %red4%
rem PrintColorAt "Restarting system in %wshutdown% second(s)!" 12 23 %cyan11% %gray8%
Call :wait_time >nul
Call :run_command "shutdown /R /T %wshutdown%" 20 >nul
Call :logMessage "shutdown.exe was called. Restart pending..."
)

rem ********
rem shutdown
rem ********

If %shutdown% EQU True (
rem PaintBoxAt 11 21 3 41 %red4%
rem PrintColorAt "Shutting down system in %wshutdown% second(s)!" 12 23 %cyan11% %gray8%
Call :wait_time >nul
Call :run_command "shutdown /S /T %wshutdown%" 20 >nul
Call :logMessage "shutdown.exe was called. Shutdown pending..."
)

rem ****
rem exit
rem ****

ENDLOCAL
Call :logMessage "Handy2ClickAutoFixer finished."
Exit /B %ErrorLevel%

rem *************
rem wintools menu
rem *************

:wTools
Call :show_me %green2% 1
rem PaintBoxAt 2 3 10 14 %green10%
rem PaintBoxAt 11 20 3 44 %green10%
rem PrintColorAt "{WINTOOLS}" 3 5 %green10% %cyan3%
rem PrintColorAt "[ CHKDSK ]" 4 5 %gray7% %gray8%
rem PrintColorAt "[CLEANMGR]" 5 5 %gray7% %gray8%
rem PrintColorAt "[MSCONFIG]" 6 5 %gray7% %gray8%
rem PrintColorAt "[SERVICES]" 7 5 %gray7% %gray8%
rem PrintColorAt "[ TASKMGR]" 8 5 %gray7% %gray8%
rem PrintColorAt "[WINUPFIX]" 9 5 %gray7% %gray8%
rem PrintColorAt "[ <BACK< ]" 10 5 %yellow14% %gray8%
rem PrintColorAt "Choose a WINTOOL, or <BACK< For MAINMENU" 12 22 %gray7% %gray8%

rem *************
rem button matrix
rem *************

rem MouseCmd 5,4,14,4 5,5,14,5 5,6,14,6 5,7,14,7 5,8,14,8 5,9,14,9 5,10,14,10

If %result% EQU 1 (
Call :make_button "[ CHKDSK ]" 4 5 1 10 %gray7% %btntime% %gray8%
Call :logMessage "wCheckDisk(menu) was called."
GoTo wCheckDisk
)

If %result% EQU 2 (
Call :make_button "[CLEANMGR]" 5 5 1 10 %gray7% %btntime% %gray8%
Call :run_command "cleanmgr.exe" 20 >nul
Call :logMessage "cleanmgr.exe was called."
)

If %result% EQU 3 (
Call :make_button "[MSCONFIG]" 6 5 1 10 %gray7% %btntime% %gray8%
Call :run_command "msconfig.exe" 20 >nul
Call :logMessage "msconfig.exe was called."
)

If %result% EQU 4 (
Call :make_button "[SERVICES]" 7 5 1 10 %gray7% %btntime% %gray8%
Call :run_command "services.msc" 20 >nul
Call :logMessage "services.msc was called."
)

If %result% EQU 5 (
Call :make_button "[ TASKMGR]" 8 5 1 10 %gray7% %btntime% %gray8%
Call :run_command "taskmgr.exe /7" 20 >nul
Call :logMessage "taskmgr.exe was called."
)

If %result% EQU 6 (
Call :make_button "[WINUPFIX]" 9 5 1 10 %gray7% %btntime% %gray8%
Call :show_me 0 0
Call :resetwindowsupdate
Call :logMessage "resetwindowsupdate() was called."
set shutdown=False
Call :logMessage "wRestartNow(menu) was called."
GoTo wRestartNow
)

If %result% EQU 7 (
Call :make_button "[ <BACK< ]" 10 5 1 10 %yellow14% %btntime% %gray8%
Call :logMessage "wMainMenu(menu) was called."
GoTo wMainMenu
)
Call :logMessage "wTools(menu) was called."
GoTo wTools

rem **************
rem checkdisk menu
rem **************

:wCheckDisk
Call :show_me %cyan3% 1
rem PaintBoxAt 2 3 8 14 %cyan11%
rem PaintBoxAt 11 15 3 52 %cyan11%
rem PrintColorAt "{ CHKDSK }" 3 5 %gray7% %cyan3%
rem PrintColorAt "[READONLY]" 4 5 %cyan11% %gray8%
rem PrintColorAt "[  SCAN  ]" 5 5 %cyan11% %gray8%
rem PrintColorAt "[ REPAIR ]" 6 5 %cyan11% %gray8%
rem PrintColorAt "[ SPOTFIX]" 7 5 %cyan11% %gray8%
rem PrintColorAt "[ <BACK< ]" 8 5 %yellow14% %gray8%
rem PrintColorAt "Choose READONLY, SCAN, REPAIR, Or Something Else" 12 17 %gray7% %gray8%

rem *************
rem button matrix
rem *************

rem MouseCmd 5,4,14,4 5,5,14,5 5,6,14,6 5,7,14,7 5,8,14,8

If %result% EQU 1 (
Call :make_button "[READONLY]" 4 5 1 10 %cyan11% %btntime% %gray8%
Call :logMessage "chkdsk.exe C: was called."
Call :show_me 0 0
Call :check_num "Read Only mode"
Set chkflag=True
Call :run_command "chkdsk %SystemDrive%" 4
Call :next_page
Call :logMessage "wCheckDisk(menu) was called."
GoTo wCheckDisk
)

If %result% EQU 2 (
Call :make_button "[  SCAN  ]" 5 5 1 10 %cyan11% %btntime% %gray8%
Call :logMessage "chkdsk.exe C: /scan was called."
Call :show_me 0 0
Call :check_num "Online Scan mode"
Set chkflag=True
Call :run_command "chkdsk %SystemDrive% /scan" 4
Call :next_page
Call :logMessage "wCheckDisk(menu) was called."
GoTo wCheckDisk
)

If %result% EQU 3 (
Call :make_button "[ REPAIR ]" 6 5 1 10 %cyan11% %btntime% %gray8%
Call :logMessage "chkdsk.exe C: /F was called."
Call :show_me 0 0
Call :check_num "Boot Repair mode"
Set chkflag=True
Call :run_command "chkdsk %SystemDrive% /F" 4
Call :next_page
Call :logMessage "wSystem(menu) was called."
GoTo wSystem
)

If %result% EQU 4 (
Call :make_button "[ SPOTFIX]" 7 5 1 10 %cyan11% %btntime% %gray8%
Call :logMessage "chkdsk.exe C: /spotfix was called."
Call :show_me 0 0
Call :check_num "Online Spotfix mode"
Set chkflag=True
Call :run_command "chkdsk %SystemDrive% /spotfix" 4
Call :next_page
Call :logMessage "wSystem(menu) was called."
GoTo wSystem
)

If %result% EQU 5 (
Call :make_button "[ <BACK< ]" 8 5 1 10 %yellow14% %btntime% %gray8%
Call :logMessage "wTools(menu) was called."
GoTo wTools
)
Call :logMessage "wCheckDisk(menu) was called."
GoTo wCheckDisk

rem *****************
rem begin subroutines
rem *****************

rem *************************
rem display the title section
rem *************************

:show_me
Call :logMessage "show_me(color,author) was called."
Call :screensize 0
rem ClearColor
rem PaintScreen %1
If %2 EQU 1 ( 
rem PrintColorAt "{ZoneSoft (c2024-25) zonemaster60@gmail.com}" 25 20 %cyan11% %gray8%
)
rem CursorHide
GOTO:EOF

rem *********************************
rem run a command with error checking
rem *********************************

:run_command
Call :logMessage "run_command(cmd) was called."
rem PrintColorAt "> %TIME%" 4 2 %green10% %black0%
rem PrintColorAt ">> %1" 5 2 %green10% %black0%
rem PrintReturn
rem t1 = %2 + 2
rem ***********
rem Add %2 3
Set t1=%result%
rem PrintReturn
rem PrintCenter "{Please Do Not Close This Window Or BAD Things May Happen!}" %t1% %yellow14% %gray8%
rem PrintReturn
If %chkflag% EQU True (
rem PrintReturn
Set chkflag=False
)
rem ChangeColor %cyan11% %black0%
Cmd /c %1
If %ErrorLevel% LSS 1 (
rem PrintReturn
rem PrintReturn
rem PrintCenter "{Success!}" 24 %green10% %black0%
) else (
rem PrintReturn
rem PrintCenter "{Failed!!}" 24 %red12% %black0%
)
rem PrintReturn
rem PrintColorAt "> %TIME%" 24 2 %red12% %black0%
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
rem PrintColorAt "[ >>>>>> ]" 25 40 %green10% %gray8%
rem PrintColorAt "[ <<<<<< ]" 25 29 %green10% %gray8%
rem MouseCmd 29,25,38,25 40,25,49,25

If %result% EQU 1 (
Call :make_button "[ <<<<<< ]" 25 29 1 10 %green10% %btntime% %gray8%
Call :logMessage "wMainMenu(menu) was called."
GoTo wMainMenu
)

If %result% EQU 2 (
Call :make_button "[ >>>>>> ]" 25 40 1 10 %green10% %btntime% %gray8%
)
GOTO:EOF

rem ******************
rem time out for menus
rem ******************

rem ************************
rem ***** wait for 4 seconds
rem ************************

:wait_time
Call :logMessage "wait_time() was called."
Set wtime=4
:Loop1
rem PrintColorAt "{Continue in %wtime%}" 25 32 %cyan11% %black0%
rem Wait %newtime2%
rem PrintColorAt "{Continue in %wtime%}" 25 32 %cyan3% %black0%
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
Call :logMessage "make_button(btnname,line,col,hgt,wid,cfg,btntime,cbg) was called."
rem Call :make_button "btnname" line col hgt wid cfg btntime cbg
rem ************************************************************
rem PaintBoxAt %2 %3 %4 %5 %6
rem Wait %7
rem PrintColorAt %1 %2 %3 %6 %8
rem Wait %7
rem len1 = (%3 + %5) - 1
rem ********************
rem Add %3 %5
rem Subtract %result% 1
Set len1=%result%
GOTO:EOF

rem *******************
rem default screen size
rem *******************

:screensize
Call :logMessage "screensize(size) was called."
If %1 EQU 0 (
mode con:cols=80 lines=25
) else (
mode con:cols=120 lines=30
)
GOTO:EOF

rem *******************
rem log system messages
rem *******************

:logMessage
Echo "LOG: [%TIME%-%DATE%]<->%1">>%logfile%
GOTO:EOF

rem *****************************
rem reset windows update services
rem *****************************

:resetwindowsupdate
Call :logMessage "resetwindowsupdate() was called."
Call :show_me %black0% 0
rem PrintColor "Checking Drive Health Status..." %yellow14% %gray8%
rem PrintReturn
rem PrintReturn
fsutil dirty query %SystemDrive%
rem PrintReturn
rem PrintColor "Stopping update services..." %red12% %gray8%
rem PrintReturn
rem PrintReturn
net stop wuauserv
net stop bits
net stop appidsvc
net stop cryptsvc
rem PrintColor "Flushing DNS Configuration..." %yellow14% %gray8%
rem PrintReturn
rem PrintReturn
ipconfig /flushdns
rem PrintReturn
If exist %ALLUSERSPROFILE%\Application Data\Microsoft\Network\Downloader\qmgr*.dat del /s /q /f %ALLUSERSPROFILE%\Application Data\Microsoft\Network\Downloader\qmgr*.dat 
If exist %ALLUSERSPROFILE%\Microsoft\Network\Downloader\qmgr*.dat del /s /q /f %ALLUSERSPROFILE%\Microsoft\Network\Downloader\qmgr*.dat
If exist %SYSTEMROOT%\Logs\WindowsUpdate\* del /s /q /f %SYSTEMROOT%\Logs\WindowsUpdate\*
rem PrintColor "Reseting Windows Update Policies..." %yellow14% %gray8%
rem PrintReturn
rem PrintReturn
reg query "HKCU\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v >nul 2>&1
If %errorlevel%==0 (
rem PrintColor "Registry Object Deleted." %green10% %gray8%
rem Printreturn
reg delete "HKCU\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /f
) else (
rem PrintColor "Registry Object Not Found!" %red12% %gray8%
rem Printreturn
)
reg query "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\WindowsUpdate" /v >nul 2>&1
If %errorlevel%==0 (
rem PrintColor "Registry Object Deleted." %green10% %gray8%
rem Printreturn
reg delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\WindowsUpdate" /f
) else (
rem PrintColor "Registry Object Not Found!" %red12% %gray8%
rem Printreturn
)
reg query "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v >nul 2>&1
If %errorlevel%==0 (
rem PrintColor "Registry Object Deleted." %green10% %gray8%
rem Printreturn
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /f
) else (
rem PrintColor "Registry Object Not Found!" %red12% %gray8%
rem Printreturn
)
reg query "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\WindowsUpdate" /v >nul 2>&1
If %errorlevel%==0 (
rem PrintColor "Registry Object Deleted." %green10% %gray8%
rem Printreturn
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\WindowsUpdate" /f
) else (
rem PrintColor "Registry Object Not Found!" %red12% %gray8%
rem Printreturn
)
gpupdate /force
rem PrintReturn
rem PrintColor "Removing old 'SoftwareDistribution' folder..." %red12% %gray8%
rem PrintReturn
rem PrintReturn
If exist %systemroot%\SoftwareDistribution.old rmdir /s /q %systemroot%\SoftwareDistribution.old
rem PrintColor "Renaming new 'SoftwareDistribution' folder..." %yellow14% %gray8%
rem PrintReturn
rem PrintReturn
If exist %systemroot%\SoftwareDistribution ren %systemroot%\SoftwareDistribution SoftwareDistribution.old
rem PrintColor "Removing old 'catroot2' folder..." %red12% %gray8%
rem PrintReturn
rem PrintReturn
If exist %systemroot%\system32\catroot2.old rmdir /s /q %systemroot%\system32\catroot2.old
rem PrintColor "Renaming new 'catroot2' folder..." %yellow14% %gray8%
rem PrintReturn
rem PrintReturn
If exist %systemroot%\system32\catroot2 ren %systemroot%\system32\catroot2 catroot2.old
rem PrintColor "Resetting WinSock Configuration..." %yellow14% %gray8%
rem PrintReturn
rem PrintReturn
netsh winsock reset
netsh winsock reset proxy
rem PrintReturn
rem PrintColor "Starting update services..." %green10% %gray8%
rem PrintReturn
rem PrintReturn
net start cryptsvc
net start appidsvc
net start bits
net start wuauserv
rem PrintColor "Finished, Rebooting your computer..." %yellow14% %gray8%
rem PrintReturn
rem PrintReturn
Call :wait_time
GOTO:EOF

rem ***************
rem end subroutines
rem ***************