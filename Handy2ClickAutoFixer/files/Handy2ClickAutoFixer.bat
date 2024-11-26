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
REM BFCPEVERVERSION=1.0.4.1
REM BFCPEVERPRODUCT=Handy 2Click AutoFixer
REM BFCPEVERDESC=Handy 2Click AutoFixer
REM BFCPEVERCOMPANY=ZoneSoft
REM BFCPEVERCOPYRIGHT=David Scouten (2024)
REM BFCPEWINDOWCENTER=1
REM BFCPEDISABLEQE=0
REM BFCPEWINDOWHEIGHT=25
REM BFCPEWINDOWWIDTH=80
REM BFCPEWTITLE=
REM BFCPEOPTIONEND
@Echo off
SETLOCAL EnableExtensions
mode con:cols=80 lines=25

rem CenterSelf
rem CursorHide
rem DisableQuickEdit

rem ********************************************
rem David Scouten (c2024) zonemaster@yahoo.com
rem ********************************************
rem compiled with Advanced BAT to EXE Converter
rem ********************************************

rem variables start here
rem ********************
Set chkhealth=False
Set resetbase=False
Set version=1.0.4.1
Set shutdown=1

rem set the title
rem *************
Set title1=Handy 2Click AutoFixer

rem set initial values
rem ******************
Set analyze=False
Set repair=False

rem time values
rem ***********
Set waittime=5000
Set wshutdown=20

rem gui colors
rem **********
Set gray7=7
Set gray8=8
Set cyan3=3
Set cyan11=11
Set red4=4
Set red12=12
Set green10=10

rem cool links
rem **********
Set www1=battoexeconverter.com
Set www2=www.facebook.com/DavesPCPortal
Set www3=github.com/zonemaster60/Batch-and-Script
Set www4=www.majorgeeks.com
Set www5=www.microsoft.com

rem display title
rem *************
Title [%title1%-v%version%]

rem math routines
rem *************
Call :do_the_math

:wMainMenu
rem main menu
rem *********
Call :show_me %cyan3% 1
rem PaintBoxAt 3 3 8 14 %cyan11%
rem PaintBoxAt 12 14 3 53 %cyan11%
rem PrintColorAt "[MAINMENU]" 4 5 %gray7% %cyan3%
rem PrintColorAt "[ ANALYZE]" 5 5 %gray7% %gray8%
rem PrintColorAt "[ REPAIR ]" 6 5 %gray7% %gray8%
rem PrintColorAt "[ CHKDSK ]" 7 5 %gray7% %gray8%
rem PrintColorAt "[  INFO  ]" 8 5 %gray7% %gray8%
rem PrintColorAt "[ >>>>>> ]" 9 5 %gray7% %red12%
rem PrintColorAt "Choose ANALYZE, REPAIR, CHKDSK, Or Something Else" 13 16 %gray7% %gray8%

rem display status
rem **************
rem PrintColorAt "[ STATUS ]" 4 66 %gray7% %cyan3%
If %analyze% EQU True (
rem PrintColorAt "[ ++++++ ]" 5 66 %gray7% %green10%
) else (
rem PrintColorAt "[ ------ ]" 5 66 %gray7% %red12%
)
If %repair% EQU True (
rem PrintColorAt "[ ++++++ ]" 6 66 %gray7% %green10%
) else (
rem PrintColorAt "[ ------ ]" 6 66 %gray7% %red12%
)

rem other stuff
rem ***********
rem PrintColorAt "[ OPTION ]" 7 66 %gray7% %cyan3%
If %repair% EQU True (
rem PrintColorAt "[>>>][ SYSTEM ]" 8 61 %gray7% %red12%
) else (
rem PrintColorAt "[ SYSTEM ]" 8 66 %gray7% %gray8%
)
rem PrintColorAt "[  TOOLS ]" 9 66 %gray7% %gray8%

rem button matrix
rem *************
rem MouseCmd 5,5,14,5 5,6,14,6 5,7,14,7 5,8,14,8 5,9,14,9 66,8,75,8 66,9,75,9

If %result% EQU 1 (
Call :make_button "[ ANALYZE]" 5 5 1 10 %gray7% %btntime% %gray8%
Goto wAnalyze
)

If %result% EQU 2 (
Call :make_button "[ REPAIR ]" 6 5 1 10 %gray7% %btntime% %gray8%
Goto wRepair
)

If %result% EQU 3 (
Call :make_button "[ CHKDSK ]" 7 5 1 10 %gray7% %btntime% %gray8%
GoTo wCheckDisk
)

If %result% EQU 4 (
Call :make_button "[  INFO  ]" 8 5 1 10 %gray7% %btntime% %gray8%
Goto wInfo1
)

If %result% EQU 5 (
Call :make_button "[ >>>>>> ]" 9 5 1 10 %gray7% %btntime% %red12%
Goto wExit
)

If %result% EQU 6 (
Call :make_button "[ SYSTEM ]" 8 66 1 10 %gray7% %btntime% %gray8%
Goto wSystem
)

If %result% EQU 7 (
Call :make_button "[  TOOLS ]" 9 66 1 10 %gray7% %btntime% %gray8%
Goto wTools
)
GoTo wMainMenu

:wAnalyze
rem analyze menu
rem ************
Call :show_me %cyan3% 0
rem PaintBoxAt 3 3 6 14 %cyan11%
rem PaintBoxAt 12 18 3 46 %cyan11%
rem PrintColorAt "[ ANALYZE]" 4 5 %gray7% %cyan3%
rem PrintColorAt "[  SCAN  ]" 5 5 %gray7% %gray8%
rem PrintColorAt "[  CHECK ]" 6 5 %gray7% %gray8%
rem PrintColorAt "[ <<<<<< ]" 7 5 %gray7% %red12%
rem PrintColorAt "Choose SCAN, CHECK, Or <<<<<< For MAINMENU" 13 20 %gray7% %gray8%

rem button matrix
rem *************
rem MouseCmd 5,5,14,5 5,6,14,6 5,7,14,7

If %result% EQU 1 (
Call :make_button "[  SCAN  ]" 5 5 1 10 %gray7% %btntime% %gray8%
Set chkhealth=False
GoTo wAnalyzeNow
)

If %result% EQU 2 (
Call :make_button "[  CHECK ]" 6 5 1 10 %gray7% %btntime% %gray8%
Set chkhealth=True
GoTo wAnalyzeNow
)

If %result% EQU 3 (
Call :make_button "[ <<<<<< ]" 7 5 1 10 %gray7% %btntime% %red12%
GoTo wMainMenu
)
GoTo wAnalyze

:wAnalyzeNow
rem analyze now
rem ***********
Call :show_me 0 0
Call :count_num 1 "Analyzes the component store for errors."
Call :run_command "dism /online /cleanup-image /analyzecomponentstore" 5
Call :wait_time

rem check or scan health
rem ********************
Call :show_me 0 0
If %chkhealth% EQU True ( 
Call :count_num 2 "CheckHealth is faster, but not as thorough."
Call :run_command "dism /online /cleanup-image /checkhealth" 5
) else (
Call :count_num 2 "ScanHealth is slower, but does a better test."
Call :run_command "dism /online /cleanup-image /scanhealth" 5
)
Call :wait_time

rem verify files
rem ************
Call :show_me 0 0
Call :count_num 3 "Verifies, but doesn't repair system files."
Call :run_command "sfc /verifyonly" 5
Set analyze=True
Call :click_next
GoTo wMainMenu

:wRepair
rem repair menu
rem ***********
Call :show_me %cyan3% 0
rem PaintBoxAt 3 3 6 14 %cyan11%
rem PaintBoxAt 12 16 3 51 %cyan11%
rem PrintColorAt "[ REPAIR ]" 4 5 %gray7% %cyan3%
rem PrintColorAt "[ REPAIR ]" 5 5 %gray7% %gray8%
rem PrintColorAt "[RESETBAS]" 6 5 %gray7% %gray8%
rem PrintColorAt "[ <<<<<< ]" 7 5 %gray7% %red12%
rem PrintColorAt "Choose REPAIR, RESETBAS, Or <<<<<< For MAINMENU" 13 18 %gray7% %gray8%

rem button matrix
rem *************
rem MouseCmd 5,5,14,5 5,6,14,6 5,7,14,7

If %result% EQU 1 (
Call :make_button "[ REPAIR ]" 5 5 1 10 %gray7% %btntime% %gray8%
Set resetbase=False
GoTo wRepairNow
)

If %result% EQU 2 (
Call :make_button "[RESETBAS]" 6 5 1 10 %gray7% %btntime% %gray8%
Set resetbase=True
GoTo wRepairNow
)

If %result% EQU 3 (
Call :make_button "[ <<<<<< ]" 7 5 1 10 %gray7% %btntime% %red12%
GoTo wMainMenu
)
GoTo wRepair

:wRepairNow
rem repair now
rem **********
rem resetbase / normal cleanup
rem **************************
Call :show_me 0 0
If %resetbase% EQU True (
Call :count_num 1 "Reset the entire component stores to baseline."
Call :run_command "dism /online /cleanup-image /startcomponentcleanup /resetbase" 5
) else (
Call :count_num 1 "Performs a normal component stores cleanup."
Call :run_command "dism /online /cleanup-image /startcomponentcleanup" 5
)
Call :wait_time

rem restore health
rem **************
Call :show_me 0 0
Call :count_num 2 "Repair, clean, and restore health to the system image."
Call :run_command "dism /online /cleanup-image /restorehealth" 5
Call :wait_time

rem scan now
rem ********
Call :show_me 0 0
Call :count_num 3 "Scans and repairs/replaces corrupted system files."
Call :run_command "sfc /scannow" 5
Set repair=True
Call :click_next

GoTo wMainMenu

:wInfo1
rem info part 1
rem ***********
Call :show_me %cyan3% 0
rem PrintCenter "[ Use The Mouse to Navigate or the Number 0-9 Keys ]" 3 15 %gray8%
rem PrintCenter "[ANALYZE] (Button) - This uses DISM and SFC to [ANALYZE] for" 5 %gray7% %gray8%
rem PrintCenter "corrupted system files. This option DOES NOT make any repairs!" 6 %gray7% %gray8%
rem PrintCenter "[REPAIR] (Button) - This also uses DISM and SFC" 8 %gray7% %gray8%
rem PrintCenter "to [ANALYZE] and [REPAIR] any corrupted system files." 9 %gray7% %gray8%
rem PrintCenter "[CHKDSK] (Button) - Accesses the [CHKDSK] menu options." 11 %gray7% %gray8%
rem PrintCenter "[ INFO ] (Button) - [INFO] - You are reading it now." 13 %gray7% %gray8%
rem PrintCenter "[>>>>>>] (Button) - [>>>>>>] Exit the program." 15 %red12% %gray8%
Call :click_next

:wInfo2
rem info part 2
rem ***********
Call :show_me %cyan3% 0
rem PrintCenter "[ Use The Mouse to Navigate or the Number 0-9 Keys ]" 3 15 %gray8%
rem PrintCenter "[ STATUS ] The status of [ANALYZE] and [REPAIR] image tasks." 5 7 %gray8%
rem PrintCenter "[ ------ ] (Status) - ------/++++++ [ANALYZE] image task." 7 %red12% %gray8%
rem PrintCenter "[ ------ ] (Status) - ------/++++++ [REPAIR] image task." 9 %red12% %gray8%
rem PrintCenter "[ OPTION ] (Option) - [RESTART], boot to [+WINRE], or [SHUTDOWN]." 11 7 %gray8%
rem PrintCenter "[ SYSTEM ] (Button) - Used to [RESTART] or [SHUTDOWN] system." 13 14 %gray8%
rem PrintCenter "[  TOOLS ] (Button) - Used to access the extra Windows [TOOLS] menu." 15 14 %gray8%
rem PrintCenter "(In any case, thank you for taking the time to try this tool!)" 17 %green10% %gray8%
Call :click_next
GoTo wMainMenu

:wExit
rem exit menu
rem *********
Call :show_me %red12% 0
rem PaintBoxAt 3 3 5 14 %red4%
rem PaintBoxAt 12 20 3 41 %red4%
rem PrintColorAt "[ >>>>>> ]" 4 5 %gray7% %cyan3%
rem PrintColorAt "[ >>>>>> ]" 5 5 %gray7% %red4%
rem PrintColorAt "[ <<<<<< ]" 6 5 %gray7% %red12%
rem PrintColorAt "Choose >>>>>>, Or <<<<<< For MAINMENU" 13 22 %gray7% %gray8%

rem show links
rem PrintColorAt "<%www1%>" 16 6 %green10% %gray8%
rem GetLength %www1%
Set /a len1=%result% + 2
rem PrintColorAt "<%www2%>" 18 6 %green10% %gray8%
rem GetLength %www2%
Set /a len2=%result% + 2
rem PrintColorAt "<%www3%>" 20 6 %green10% %gray8%
rem GetLength %www3%
Set /a len3=%result% + 2
rem PrintColorAt "<%www4%>" 22 6 %green10% %gray8%
rem GetLength %www4%
Set /a len4=%result% + 2
rem PrintColorAt "<%www5%>" 24 6 %green10% %gray8%
rem GetLength %www5%
Set /a len5=%result% + 2

rem button matrix
rem *************
rem MouseCmd 5,5,14,5 5,6,14,6 6,16,%len1%,16 6,18,%len2%,18 6,20,%len3%,20 6,22,%len4%,22 6,24,%len5%,24

If %result% EQU 1 (
Call :make_button "[ >>>>>> ]" 5 5 1 10 %gray7% %btntime% %red4%
GoTo wExitNow
)

If %result% EQU 2 (
Call :make_button "[ <<<<<< ]" 6 5 1 10 %gray7% %btntime% %red12%
GoTo wMainMenu
)

rem cool links
rem **********

If %result% EQU 3 (
Call :make_button "<%www1%>" 16 6 1 %len1% %green10% %btntime% %gray8%
Call :run_command "start https://%www1%" 16 >nul
)

If %result% EQU 4 (
Call :make_button "<%www2%>" 18 6 1 %len2% %green10% %btntime% %gray8%
Call :run_command "start https://%www2%" 18 >nul
)

If %result% EQU 5 (
Call :make_button "<%www3%>" 20 6 1 %len3% %green10% %btntime% %gray8%
Call :run_command "start https://%www3%" 20 >nul
)

If %result% EQU 6 (
Call :make_button "<%www4%>" 22 6 1 %len4% %green10% %btntime% %gray8%
Call :run_command "start https://%www4%" 22 >nul
)

If %result% EQU 7 (
Call :make_button "<%www5%>" 24 6 1 %len5% %green10% %btntime% %gray8%
Call :run_command "start https://%www5%" 24 >nul
)
GoTo wExit

:wExitNow
rem exit now
rem ********
Call :show_me %red12% 1
rem PaintBoxAt 12 19 3 43 %red4%
rem PrintColorAt "Thank you for using this FREE Software!" 13 21 %gray7% %gray8%
Call :wait_time >nul
ENDLOCAL
Exit /B %ErrorLevel%

:wSystem
rem system menu
rem ***********
Call :show_me %red12% 1
rem PaintBoxAt 3 3 7 14 %red4%
rem PaintBoxAt 12 15 3 52 %red4%
rem PrintColorAt "[ SYSTEM ]" 4 5 %gray7% %cyan3%
If %repair% EQU True (
rem PrintColorAt "[ RESTART]" 5 5 %gray7% %red12%
rem PrintColorAt "[<<<]" 5 15 %gray7% %red12%
) else (
rem PrintColorAt "[ RESTART]" 5 5 %gray7% %gray8%
)
rem PrintColorAt "[WINRE-OS]" 6 5 %gray7% %gray8%
rem PrintColorAt "[SHUTDOWN]" 7 5 %gray7% %gray8%
rem PrintColorAt "[ <<<<<< ]" 8 5 %gray7% %red12%
rem PrintColorAt "Choose RESTART, WINRE-OS, Or <<<<<< For MAINMENU" 13 17 %gray7% %gray8%

rem button matrix
rem *************
rem MouseCmd 5,5,14,5 5,6,14,6 5,7,14,7 5,8,14,8

If %result% EQU 1 (
Call :make_button "[ RESTART]" 5 5 1 10 %gray7% %btntime% %gray8%
Set shutdown=1
GoTo wRestartNow
)

If %result% EQU 2 (
Call :make_button "[WINRE-OS]" 6 5 1 10 %gray7% %btntime% %gray8%
Set shutdown=2
GoTo wRestartNow
)

If %result% EQU 3 (
Call :make_button "[SHUTDOWN]" 7 5 1 10 %gray7% %btntime% %gray8%
Set shutdown=3
GoTo wRestartNow
)

If %result% EQU 4 (
Call :make_button "[ <<<<<< ]" 8 5 1 10 %gray7% %btntime% %red12%
GoTo wMainMenu
)
GoTo wSystem

:wRestartNow
rem restart now
rem ***********
Call :show_me %red12% 1
rem restart
If %shutdown% EQU 1 (
rem PaintBoxAt 12 21 3 38 %red4%
rem PrintColorAt "Restarting system in %wshutdown% second(s)!" 13 23 %cyan11% %gray8%
Call :wait_time >nul
Call :run_command "shutdown /R /T %wshutdown%" 20 >nul
)
rem boot in winre
If %shutdown% EQU 2 (
rem PaintBoxAt 12 21 3 43 %red4%
rem PrintColorAt "Restarting to WINRE-OS in 30 second(s)!" 13 23 %cyan11% %gray8%
Call :wait_time >nul
Call :run_command "shutdown /R /O" 20 >nul
)
rem shutdown
If %shutdown% EQU 3 (
rem PaintBoxAt 12 21 3 41 %red4%
rem PrintColorAt "Shutting down system in %wshutdown% second(s)!" 13 23 %cyan11% %gray8%
Call :wait_time >nul
Call :run_command "shutdown /S /T %wshutdown%" 20 >nul
)

rem exit
rem ****
ENDLOCAL
Exit /B %ErrorLevel%

rem the tools menu
rem **************
:wTools
Call :show_me 2 0
rem PaintBoxAt 3 3 17 14 %green10%
rem PaintBoxAt 12 20 3 41 %green10%
rem PrintColorAt "[  TOOLS ]" 4 5 %gray7% %cyan3%
rem PrintColorAt "[CLEANMGR]" 5 5 %gray7% %gray8%
rem PrintColorAt "[COMPMGMT]" 6 5 %gray7% %gray8%
rem PrintColorAt "[ DXDIAG ]" 7 5 %gray7% %gray8%
rem PrintColorAt "[EVENTVWR]" 8 5 %gray7% %gray8%
rem PrintColorAt "[ GPEDIT ]" 9 5 %gray7% %gray8%
rem PrintColorAt "[MSCONFIG]" 10 5 %gray7% %gray8%
rem PrintColorAt "[ PERFMON]" 11 5 %gray7% %gray8%
rem PrintColorAt "[ REGEDIT]" 12 5 %gray7% %gray8%
rem PrintColorAt "[ RESMON ]" 13 5 %gray7% %gray8%
rem PrintColorAt "[SERVICES]" 14 5 %gray7% %gray8%
rem PrintColorAt "[ SYSINFO]" 15 5 %gray7% %gray8%
rem PrintColorAt "[ TASKMGR]" 16 5 %gray7% %gray8%
rem PrintColorAt "[TASKSCHD]" 17 5 %gray7% %gray8%
rem PrintColorAt "[ <<<<<< ]" 18 5 %gray7% %red12%
rem PrintColorAt "Choose a TOOL, or <<<<<< For MAINMENU" 13 22 %gray7% %gray8%

rem button matrix
rem *************
rem MouseCmd 5,5,14,5 5,6,14,6 5,7,14,7 5,8,14,8 5,9,14,9 5,10,14,10 5,11,14,11 5,12,14,12 5,13,14,13 5,14,14,14 5,15,14,15 5,16,14,16 5,17,14,17 5,18,14,18

If %result% EQU 1 (
Call :make_button "[CLEANMGR]" 5 5 1 10 %gray7% %btntime% %gray8%
Call :run_command "cleanmgr.exe" 20 >nul
)

If %result% EQU 2 (
Call :make_button "[COMPMGMT]" 6 5 1 10 %gray7% %btntime% %gray8%
Call :run_command "compmgmt.msc /s" 20 >nul
)

If %result% EQU 3 (
Call :make_button "[ DXDIAG ]" 7 5 1 10 %gray7% %btntime% %gray8%
Call :run_command "dxdiag.exe" 20 >nul
)

If %result% EQU 4 (
Call :make_button "[EVENTVWR]" 8 5 1 10 %gray7% %btntime% %gray8%
Call :run_command "eventvwr.msc /s" 20 >nul
)

If %result% EQU 5 (
Call :make_button "[ GPEDIT ]" 9 5 1 10 %gray7% %btntime% %gray8%
Call :run_command "gpedit.msc" 20 >nul
)

If %result% EQU 6 (
Call :make_button "[MSCONFIG]" 10 5 1 10 %gray7% %btntime% %gray8%
Call :run_command "msconfig.exe" 20 >nul
)

If %result% EQU 7 (
Call :make_button "[ PERFMON]" 11 5 1 10 %gray7% %btntime% %gray8%
Call :run_command "perfmon.msc /s" 20 >nul
)

If %result% EQU 8 (
Call :make_button "[ REGEDIT]" 12 5 1 10 %gray7% %btntime% %gray8%
Call :run_command "regedit.exe" 20 >nul
)

If %result% EQU 9 (
Call :make_button "[ RESMON ]" 13 5 1 10 %gray7% %btntime% %gray8%
Call :run_command "perfmon.exe /res" 20 >nul
)

If %result% EQU 10 (
Call :make_button "[SERVICES]" 14 5 1 10 %gray7% %btntime% %gray8%
Call :run_command "services.msc" 20 >nul
)

If %result% EQU 11 (
Call :make_button "[ SYSINFO]" 15 5 1 10 %gray7% %btntime% %gray8%
Call :run_command "msinfo32.exe" 20 >nul
)

If %result% EQU 12 (
Call :make_button "[ TASKMGR]" 16 5 1 10 %gray7% %btntime% %gray8%
Call :run_command "taskmgr.exe /7" 20 >nul
)

If %result% EQU 13 (
Call :make_button "[TASKSCHD]" 17 5 1 10 %gray7% %btntime% %gray8%
Call :run_command "taskschd.msc /s" 20 >nul
)

If %result% EQU 14 (
Call :make_button "[ <<<<<< ]" 18 5 1 10 %gray7% %btntime% %red12%
GoTo wMainMenu
)
GoTo wTools

:wCheckDisk
rem checkdisk menu
rem **************
Call :show_me %cyan3% 0
rem PaintBoxAt 3 3 8 14 %cyan11%
rem PaintBoxAt 12 15 3 52 %cyan11%
rem PrintColorAt "[ CHKDSK ]" 4 5 %gray7% %cyan3%
rem PrintColorAt "[READONLY]" 5 5 %gray7% %gray8%
rem PrintColorAt "[  SCAN  ]" 6 5 %gray7% %gray8%
rem PrintColorAt "[ REPAIR ]" 7 5 %gray7% %gray8%
rem PrintColorAt "[ SPOTFIX]" 8 5 %gray7% %gray8%
rem PrintColorAt "[ <<<<<< ]" 9 5 %gray7% %red12%
rem PrintColorAt "Choose READONLY, SCAN, REPAIR, Or Something Else" 13 17 %gray7% %gray8%

rem button matrix
rem *************
rem MouseCmd 5,5,14,5 5,6,14,6 5,7,14,7 5,8,14,8 5,9,14,9

If %result% EQU 1 (
Call :make_button "[READONLY]" 5 5 1 10 %gray7% %btntime% %gray8%
Call :show_me 0 0
Call :run_command "chkdsk %systemdrive%" 3
Call :click_next
GoTo wCheckDisk
)

If %result% EQU 2 (
Call :make_button "[  SCAN  ]" 6 5 1 10 %gray7% %btntime% %gray8%
Call :show_me 0 0
Call :run_command "chkdsk %systemdrive% /scan" 3
Call :click_next
GoTo wCheckDisk
)

If %result% EQU 3 (
Call :make_button "[ REPAIR ]" 7 5 1 10 %gray7% %btntime% %gray8%
Call :show_me 0 0
Call :run_command "chkdsk %systemdrive% /F" 3
Call :click_next
GoTo wSystem
)

If %result% EQU 4 (
Call :make_button "[ SPOTFIX]" 8 5 1 10 %gray7% %btntime% %gray8%
Call :show_me 0 0
Call :run_command "chkdsk %systemdrive% /spotfix" 3
Call :click_next
GoTo wSystem
)

If %result% EQU 5 (
Call :make_button "[ <<<<<< ]" 9 5 1 10 %gray7% %btntime% %red12%
GoTo wMainMenu
)
GoTo wCheckDisk

rem *****************
rem begin subroutines
rem *****************

rem display the title section
rem *************************
:show_me
rem ClearColor
rem PaintScreen %1
rem PrintColorAt "[%title1%-v%version%]" 1 24 %cyan11% %gray8%
If %2 EQU 1 ( 
rem PrintColorAt "David Scouten [c2024] zonemaster@yahoo.com" 25 20 %cyan11% %gray8%
)
rem CursorHide
GOTO:EOF

rem run a command with error checking
rem *********************************
:run_command
rem PrintColorAt "> %TIME%" %1 %2 2 14 2
rem PrintReturn
Set /a t1=%2 + 2
rem PrintColorAt "[Please Do Not Close This Window; BAD Things WILL Happen!]" %t1% 2 14 13
rem PrintReturn
Cmd /c %1
If %ErrorLevel% LSS 1 (
rem PrintReturn
rem PrintCenter "[Success!]" 24 %green10% %gray8%
) else (
rem PrintReturn
rem PrintCenter "[Failed!!]" 24 %red12% %gray8%
)
rem PrintReturn
rem PrintColorAt "< %TIME%" 24 2 14 12
GOTO:EOF

rem shows current stage of repairs
rem ******************************
:count_num
Set nums=3
rem PrintColorAt "Stage %1 of %nums% - %2" 3 2 14 1
GOTO:EOF

rem click next button
rem *****************
:click_next
rem PrintColorAt "[ >>>>>> ]" 25 35 %cyan11% %gray8%
rem MouseCmd 36,25,46,25
If %result% EQU 1 Call :make_button "[ >>>>>> ]" 25 35 1 10 %cyan11% %btntime% %gray8%
GOTO:EOF

rem time out for menus
rem ******************
:wait_time
Set wtime=5
:Loop1
rem PrintCenter "[Continue in %wtime%]" 25 %cyan11% %gray8%
rem Wait %newtime2%
rem PrintCenter "[Continue in %wtime%]" 25 %cyan3% %gray8%
rem Wait %newtime2%
Set /a wtime-=1
If %wtime% LSS 1 GoTo wFin1
GoTo Loop1
:wFin1
GOTO:EOF

rem math routines
rem *************
:do_the_math
rem btntime = waittime - 4800
Set /a btntime=waittime - 4800

rem newtime = waittime / 5
rem **********************
Set /a newtime=waittime / 5

rem newtime2 = newtime / 2
rem **********************
Set /a newtime2=newtime / 2
GOTO:EOF

rem makes a menu button
rem *******************
:make_button
rem Call :make_button "btnname" line column height width colorfg btntime colorbg
rem PaintBoxAt %2 %3 %4 %5 %6
rem Wait %7
rem PrintColorAt %1 %2 %3 %6 %8
rem Wait %7
Set /a len1=(%3 + %5) - 1
GOTO:EOF

rem ***************
rem end subroutines
rem ***************