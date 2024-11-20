@ECHO OFF
REM BFCPEOPTIONSTART
REM Advanced BAT to EXE Converter www.BatToExeConverter.com
REM BFCPEEXE=C:\Users\zonem\Documents\Batch-and-Script\2CAF_Standalone\2CAF_Standalone.exe
REM BFCPEICON=D:\Develop\Advanced BAT to EXE Converter PRO\ab2econv461pro\icons\icon3.ico
REM BFCPEICONINDEX=1
REM BFCPEEMBEDDISPLAY=0
REM BFCPEEMBEDDELETE=1
REM BFCPEADMINEXE=1
REM BFCPEINVISEXE=0
REM BFCPEVERINCLUDE=1
REM BFCPEVERVERSION=1.0.2.5
REM BFCPEVERPRODUCT=2Click AutoFixer Standalone
REM BFCPEVERDESC=2Click AutoFixer Standalone
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
Set conmode=1
If %conmode% EQU 1 mode con:cols=80 lines=25
If %conmode% EQU 2 mode con:cols=120 lines=30

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
Set version=1.0.2.5
Set shutdown=1

rem support files
rem *************
Set title1=2Click AutoFixer Standalone
Set chngfile=2CAF_Standalone.txt

rem set initial values
rem ******************
Set analyze=False
Set repair=False

rem time values
rem ***********
Set waittime=5000
Set wshutdown=20

rem button colors
rem *************
Set btnbg=14
Set btnfg=7

rem scheme colors
rem *************
Set schcol1=3
Set schcol2=11
Set schcol3=4
Set schcol4=12

rem text colors
rem ***********
Set txtbg=8
Set txtfg=10

rem cool links
rem **********
Set www1=battoexeconverter.com
Set www2=www.facebook.com/DavesPCPortal
Set www3=github.com/zonemaster60/Batch-and-Script
Set www4=www.filehippo.com
Set www5=www.majorgeeks.com

rem display title
rem *************
Title [%title1%-v%version%]

rem math routines
rem *************
Call :do_the_math

rem create chngfile file if not exist
rem *********************************
If Exist %chngfile% GoTo wMainMenu
If Not Exist %chngfile% Call :changes_file

:wMainMenu
rem main menu
rem *********
Call :show_me %schcol1% 1
rem PaintBoxAt 3 3 20 76 %schcol2%
rem PaintBoxAt 12 14 3 53 %schcol1%

rem PrintColorAt "[MAINMENU]" 4 6 7 %txtbg%
rem PrintColorAt "[ ANALYZE]" 5 6 %btnbg% %txtbg%
rem PrintColorAt "[ REPAIR ]" 6 6 %btnbg% %txtbg%
rem PrintColorAt "[ CHKDSK ]" 7 6 %btnbg% %txtbg%
rem PrintColorAt "[  INFO  ]" 8 6 %btnbg% %txtbg%
rem PrintColorAt "[  EXIT  ]" 9 6 %schcol4% %txtbg%
rem PrintColorAt "Choose ANALYZE, REPAIR, CHKDSK, Or Something Else" 13 16 %btnfg% %txtbg%

rem display status
rem **************
rem PrintColorAt "[ STATUS ]" 4 66 7 %txtbg%
If %analyze% EQU True (
rem PrintColorAt "[ ++++++ ]" 5 66 %btnbg% %txtfg%
) else (
rem PrintColorAt "[ ------ ]" 5 66 %btnbg% %schcol4%
)
If %repair% EQU True (
rem PrintColorAt "[ ++++++ ]" 6 66 %btnbg% %txtfg%
) else (
rem PrintColorAt "[ ------ ]" 6 66 %btnbg% %schcol4%
)

rem other stuff
rem ***********
rem PrintColorAt "[ OPTION ]" 8 66 7 %txtbg%
If %repair% EQU True (
rem PrintColorAt ">>>[ SYSTEM ]" 9 63 %btnbg% %schcol4%
) else (
rem PrintColorAt "[ SYSTEM ]" 9 66 %btnbg% %txtbg%
)
rem PrintColorAt "[  TOOLS ]" 10 66 %btnbg% %txtbg%

rem button matrix
rem *************
rem MouseCmd 6,5,15,5 6,6,15,6 6,7,15,7 6,8,15,8 6,9,15,9 66,9,75,9 66,10,75,10

If %result% EQU 1 (
Call :make_button "[ ANALYZE]" 5 6 1 10 %btnbg% %btntime% %txtbg%
Goto wAnalyze
)

If %result% EQU 2 (
Call :make_button "[ REPAIR ]" 6 6 1 10 %btnbg% %btntime% %txtbg%
Goto wRepair
)

If %result% EQU 3 (
Call :make_button "[ CHKDSK ]" 7 6 1 10 %btnbg% %btntime% %txtbg%
GoTo wCheckDisk
)

If %result% EQU 4 (
Call :make_button "[  INFO  ]" 8 6 1 10 %btnbg% %btntime% %txtbg%
Goto wInfo1
)

If %result% EQU 5 (
Call :make_button "[  EXIT  ]" 9 6 1 10 %schcol4% %btntime% %txtbg%
Goto wExit
)

If %result% EQU 6 (
Call :make_button "[ SYSTEM ]" 9 66 1 10 %btnbg% %btntime% %txtbg%
Goto wSystem
)

If %result% EQU 7 (
Call :make_button "[  TOOLS ]" 10 66 1 10 %btnbg% %btntime% %txtbg%
Goto wTools
)
GoTo wMainMenu

:wAnalyze
rem analyze menu
rem ************
Call :show_me %schcol1% 0
rem PaintBoxAt 4 3 6 14 %schcol2%
rem PaintBoxAt 12 18 3 46 %schcol2%
rem PrintColorAt "[ ANALYZE]" 5 5 7 %txtbg%
rem PrintColorAt "[  SCAN  ]" 6 5 %btnbg% %txtbg%
rem PrintColorAt "[  CHECK ]" 7 5 %btnbg% %txtbg%
rem PrintColorAt "[ <<<<<< ]" 8 5 %schcol4% %txtbg%
rem PrintColorAt "Choose SCAN, CHECK, Or <<<<<< For MAINMENU" 13 20 %btnfg% %txtbg%

rem button matrix
rem *************
rem MouseCmd 5,6,14,6 5,7,14,7 5,8,14,8

If %result% EQU 1 (
Call :make_button "[  SCAN  ]" 6 5 1 10 %btnbg% %btntime% %txtbg%
Set chkhealth=False
GoTo wAnalyzeNow
)

If %result% EQU 2 (
Call :make_button "[  CHECK ]" 7 5 1 10 %btnbg% %btntime% %txtbg%
Set chkhealth=True
GoTo wAnalyzeNow
)

If %result% EQU 3 (
Call :make_button "[ <<<<<< ]" 8 5 1 10 %schcol4% %btntime% %txtbg%
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
Call :show_me %schcol1% 0
rem PaintBoxAt 4 3 6 14 %schcol2%
rem PaintBoxAt 12 16 3 51 %schcol2%
rem PrintColorAt "[ REPAIR ]" 5 5 7 %txtbg%
rem PrintColorAt "[ REPAIR ]" 6 5 %btnbg% %txtbg%
rem PrintColorAt "[RESETBAS]" 7 5 %btnbg% %txtbg%
rem PrintColorAt "[ <<<<<< ]" 8 5 %schcol4% %txtbg%
rem PrintColorAt "Choose REPAIR, RESETBAS, Or <<<<<< For MAINMENU" 13 18 %btnfg% %txtbg%

rem button matrix
rem *************
rem MouseCmd 5,6,14,6 5,7,14,7 5,8,14,8

If %result% EQU 1 (
Call :make_button "[ REPAIR ]" 6 5 1 10 %btnbg% %btntime% %txtbg%
Set resetbase=False
GoTo wRepairNow
)

If %result% EQU 2 (
Call :make_button "[RESETBAS]" 7 5 1 10 %btnbg% %btntime% %txtbg%
Set resetbase=True
GoTo wRepairNow
)

If %result% EQU 3 (
Call :make_button "[ <<<<<< ]" 8 5 1 10 %schcol4% %btntime% %txtbg%
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
Set analyze=True
Set repair=True
Call :click_next

GoTo wMainMenu

:wInfo1
rem info part 1
rem ***********
Call :show_me %schcol1% 0
rem PrintCenter "[ Use The Mouse to Navigate or the Number 0-9 Keys ]" 3 15 %txtbg%
rem PrintCenter "[ANALYZE] (Button) - This uses DISM and SFC to [ANALYZE] for" 5 %btnbg% %txtbg%
rem PrintCenter "corrupted system files. This option DOES NOT make any repairs!" 6 %btnbg% %txtbg%
rem PrintCenter "[REPAIR] (Button) - This also uses DISM and SFC" 8 %btnbg% %txtbg%
rem PrintCenter "to [ANALYZE] and [REPAIR] any corrupted system files." 9 %btnbg% %txtbg%
rem PrintCenter "[CHKDSK] (Button) - Accesses the [CHKDSK] menu options." 11 %btnbg% %txtbg%
rem PrintCenter "[ INFO ] (Button) - [INFO] - You are reading it now." 13 %btnbg% %txtbg%
rem PrintCenter "[ EXIT ] (Button) - Well this is kind of self-explanatory." 15 %schcol4% %txtbg%
Call :click_next

:wInfo2
rem info part 2
rem ***********
Call :show_me %schcol1% 0
rem PrintCenter "[ Use The Mouse to Navigate or the Number 0-9 Keys ]" 3 15 %txtbg%
rem PrintCenter "[ STATUS ] The status of [ANALYZE] and [REPAIR] image tasks." 5 7 %txtbg%
rem PrintCenter "[ ------ ] (Status) - ------/++++++ [ANALYZE] image task." 7 %schcol4% %txtbg%
rem PrintCenter "[ ------ ] (Status) - ------/++++++ [REPAIR] image task." 9 %schcol4% %txtbg%
rem PrintCenter "[ OPTION ] (Option) - [RESTART], boot to [+WINRE], or [SHUTDOWN]." 11 7 %txtbg%
rem PrintCenter "[ SYSTEM ] (Button) - Used to [RESTART] or [SHUTDOWN] system." 13 14 %txtbg%
rem PrintCenter "[  TOOLS ] (Button) - Used to access the extra Windows [TOOLS] menu." 15 14 %txtbg%
rem PrintCenter "(In any case, thank you for taking the time to try this tool!)" 17 %txtfg% %txtbg%
Call :click_next
GoTo wMainMenu

:wExit
rem exit menu
rem *********
Call :show_me %schcol4% 0
rem PaintBoxAt 4 3 5 14 %schcol3%
rem PaintBoxAt 12 20 3 39 %schcol3%
rem PrintColorAt "[  EXIT  ]" 5 5 7 %txtbg%
rem PrintColorAt "[  EXIT  ]" 6 5 %schcol4% %txtbg%
rem PrintColorAt "[ <<<<<< ]" 7 5 %btnbg% %txtbg%
rem PrintColorAt "Choose EXIT, Or <<<<<< For MAINMENU" 13 22 %btnfg% %txtbg%

rem show links
rem PrintColorAt "<%www1%>" 16 6 %txtfg% %txtbg%
rem GetLength %www1%
Set /a len1=%result% + 2
rem PrintColorAt "<%www2%>" 18 6 %txtfg% %txtbg%
rem GetLength %www2%
Set /a len2=%result% + 2
rem PrintColorAt "<%www3%>" 20 6 %txtfg% %txtbg%
rem GetLength %www3%
Set /a len3=%result% + 2
rem PrintColorAt "<%www4%>" 22 6 %txtfg% %txtbg%
rem GetLength %www4%
Set /a len4=%result% + 2
rem PrintColorAt "<%www5%>" 24 6 %txtfg% %txtbg%
rem GetLength %www5%
Set /a len5=%result% + 2

rem button matrix
rem *************
rem MouseCmd 5,6,14,6 5,7,14,7 6,16,%len1%,16 6,18,%len2%,18 6,20,%len3%,20 6,22,%len4%,22 6,24,%len5%,24

If %result% EQU 1 (
Call :make_button "[  EXIT  ]" 6 5 1 10 %btnbg% %btntime% %txtbg%
GoTo wExitNow
)

If %result% EQU 2 (
Call :make_button "[ <<<<<< ]" 7 5 1 10 %btnbg% %btntime% %txtbg%
GoTo wMainMenu
)

rem cool links
rem **********

If %result% EQU 3 (
Call :make_button "<%www1%>" 16 6 1 %len1% %txtfg% %btntime% %txtbg%
Call :run_command "start https://%www1%" 16 >nul
)

If %result% EQU 4 (
Call :make_button "<%www2%>" 18 6 1 %len2% %txtfg% %btntime% %txtbg%
Call :run_command "start https://%www2%" 18 >nul
)

If %result% EQU 5 (
Call :make_button "<%www3%>" 20 6 1 %len3% %txtfg% %btntime% %txtbg%
Call :run_command "start https://%www3%" 20 >nul
)

If %result% EQU 6 (
Call :make_button "<%www4%>" 22 6 1 %len4% %txtfg% %btntime% %txtbg%
Call :run_command "start https://%www4%" 22 >nul
)

If %result% EQU 7 (
Call :make_button "<%www5%>" 24 6 1 %len5% %txtfg% %btntime% %txtbg%
Call :run_command "start https://%www5%" 24 >nul
)
GoTo wExit

:wExitNow
rem exit now
rem ********
Call :show_me %schcol4% 1
rem PaintBoxAt 12 19 3 43 %schcol3%
rem PrintColorAt "Thank you for using this FREE Software!" 13 21 %btnfg% %txtbg%
Call :wait_time >nul
ENDLOCAL
Exit /B %ErrorLevel%

:wSystem
rem system menu
rem ***********
Call :show_me %schcol4% 1
rem PaintBoxAt 4 3 7 14 %schcol3%
rem PaintBoxAt 12 15 3 52 %schcol3%
rem PrintColorAt "[ SYSTEM ]" 5 5 7 %txtbg%
If %repair% EQU True (
rem PrintColorAt "[ RESTART]" 6 5 %btnbg% %schcol4%
rem PrintColorAt "<<<" 6 15 %btnbg% %schcol4%
) else (
rem PrintColorAt "[ RESTART]" 6 5 %btnbg% %txtbg%
)
rem PrintColorAt "[WINRE-OS]" 7 5 10 %txtbg%
rem PrintColorAt "[SHUTDOWN]" 8 5 %btnbg% %txtbg%
rem PrintColorAt "[ <<<<<< ]" 9 5 %schcol4% %txtbg%
rem PrintColorAt "Choose RESTART, WINRE-OS, Or <<<<<< For MAINMENU" 13 17 %btnfg% %txtbg%

rem button matrix
rem *************
rem MouseCmd 5,6,14,6 5,7,14,7 5,8,14,8 5,9,14,9

If %result% EQU 1 (
Call :make_button "[ RESTART]" 6 5 1 10 %btnbg% %btntime% %txtbg%
Set shutdown=1
GoTo wRestartNow
)

If %result% EQU 2 (
Call :make_button "[WINRE-OS]" 7 5 1 10 %txtfg% %btntime% %txtbg%
Set shutdown=2
GoTo wRestartNow
)

If %result% EQU 3 (
Call :make_button "[SHUTDOWN]" 8 5 1 10 %btnbg% %btntime% %txtbg%
Set shutdown=3
GoTo wRestartNow
)

If %result% EQU 4 (
Call :make_button "[ <<<<<< ]" 9 5 1 10 %schcol4% %btntime% %txtbg%
GoTo wMainMenu
)
GoTo wSystem

:wRestartNow
rem restart now
rem ***********
Call :show_me %schcol4% 1
rem restart
If %shutdown% EQU 1 (
rem PaintBoxAt 12 21 3 38 %schcol3%
rem PrintColorAt "Restarting system in %wshutdown% second(s)!" 13 23 %schcol2% %txtbg%
Call :wait_time >nul
Call :run_command "shutdown /R /T %wshutdown%" 20 >nul
)
rem boot in winre
If %shutdown% EQU 2 (
rem PaintBoxAt 12 21 3 43 %schcol3%
rem PrintColorAt "Restarting to WINRE-OS in 30 second(s)!" 13 23 %schcol2% %txtbg%
Call :wait_time >nul
Call :run_command "shutdown /R /O" 20 >nul
)
rem shutdown
If %shutdown% EQU 3 (
rem PaintBoxAt 12 21 3 41 %schcol3%
rem PrintColorAt "Shutting down system in %wshutdown% second(s)!" 13 23 %schcol2% %txtbg%
Call :wait_time >nul
Call :run_command "shutdown /S /T %wshutdown%" 20 >nul
)

rem reset inifile file
rem *****************
ENDLOCAL
Exit /B %ErrorLevel%

rem the tools menu
rem **************
:wTools
Call :show_me %schcol1% 0
rem PaintBoxAt 3 3 14 14 %schcol2%
rem PaintBoxAt 12 20 3 41 %schcol2%
rem PrintColorAt "[  TOOLS ]" 4 5 7 %txtbg%
rem PrintColorAt "[CLEANMGR]" 5 5 %txtfg% %txtbg%
rem PrintColorAt "[COMPMGMT]" 6 5 %txtfg% %txtbg%
rem PrintColorAt "[ DXDIAG ]" 7 5 %txtfg% %txtbg%
rem PrintColorAt "[EVENTVWR]" 8 5 %txtfg% %txtbg%
rem PrintColorAt "[ GPEDIT ]" 9 5 %txtfg% %txtbg%
rem PrintColorAt "[MSCONFIG]" 10 5 %txtfg% %txtbg%
rem PrintColorAt "[ REGEDIT]" 11 5 %txtfg% %txtbg%
rem PrintColorAt "[SERVICES]" 12 5 %txtfg% %txtbg%
rem PrintColorAt "[ SYSINFO]" 13 5 %txtfg% %txtbg%
rem PrintColorAt "[TASKSCHD]" 14 5 %txtfg% %txtbg%
rem PrintColorAt "[ <<<<<< ]" 15 5 %schcol4% %txtbg%
rem PrintColorAt "Choose a TOOL, or <<<<<< For MAINMENU" 13 22 %btnfg% %txtbg%

rem button matrix
rem *************
rem MouseCmd 5,5,14,5 5,6,14,6 5,7,14,7 5,8,14,8 5,9,14,9 5,10,14,10 5,11,14,11 5,12,14,12 5,13,14,13 5,14,14,14 5,15,14,15

If %result% EQU 1 (
Call :make_button "[CLEANMGR]" 5 5 1 10 %txtfg% %btntime% %txtbg%
Call :run_command "cleanmgr.exe" 20 >nul
)

If %result% EQU 2 (
Call :make_button "[COMPMGMT]" 6 5 1 10 %txtfg% %btntime% %txtbg%
Call :run_command "compmgmt.msc /s" 20 >nul
)

If %result% EQU 3 (
Call :make_button "[ DXDIAG ]" 7 5 1 10 %txtfg% %btntime% %txtbg%
Call :run_command "dxdiag.exe" 20 >nul
)

If %result% EQU 4 (
Call :make_button "[EVENTVWR]" 8 5 1 10 %txtfg% %btntime% %txtbg%
Call :run_command "eventvwr.msc /s" 20 >nul
)

If %result% EQU 5 (
Call :make_button "[ GPEDIT ]" 9 5 1 10 %txtfg% %btntime% %txtbg%
Call :run_command "gpedit.msc" 20 >nul
)

If %result% EQU 6 (
Call :make_button "[MSCONFIG]" 10 5 1 10 %txtfg% %btntime% %txtbg%
Call :run_command "msconfig.exe" 20 >nul
)

If %result% EQU 7 (
Call :make_button "[ REGEDIT]" 11 5 1 10 %txtfg% %btntime% %txtbg%
Call :run_command "regedit.exe" 20 >nul
)

If %result% EQU 8 (
Call :make_button "[SERVICES]" 12 5 1 10 %txtfg% %btntime% %txtbg%
Call :run_command "services.msc" 20 >nul
)

If %result% EQU 9 (
Call :make_button "[ SYSINFO]" 13 5 1 10 %txtfg% %btntime% %txtbg%
Call :run_command "msinfo32.exe" 20 >nul
)

If %result% EQU 10 (
Call :make_button "[TASKSCHD]" 14 5 1 10 %txtfg% %btntime% %txtbg%
Call :run_command "taskschd.msc /s" 20 >nul
)

If %result% EQU 11 (
Call :make_button "[ <<<<<< ]" 15 5 1 10 %schcol4% %btntime% %txtbg%
GoTo wMainMenu
)
GoTo wTools

:wCheckDisk
rem checkdisk menu
rem **************
Call :show_me %schcol1% 0
rem PaintBoxAt 3 3 8 14 %schcol2%
rem PaintBoxAt 12 15 3 52 %schcol2%
rem PrintColorAt "[ CHKDSK ]" 4 5 7 %txtbg%
rem PrintColorAt "[READONLY]" 5 5 %btnbg% %txtbg%
rem PrintColorAt "[  SCAN  ]" 6 5 %btnbg% %txtbg%
rem PrintColorAt "[ REPAIR ]" 7 5 %btnbg% %txtbg%
rem PrintColorAt "[ SPOTFIX]" 8 5 %btnbg% %txtbg%
rem PrintColorAt "[ <<<<<< ]" 9 5 %schcol4% %txtbg%
rem PrintColorAt "Choose READONLY, SCAN, REPAIR, Or Something Else" 13 17 %btnfg% %txtbg%

rem button matrix
rem *************
rem MouseCmd 5,5,14,5 5,6,14,6 5,7,14,7 5,8,14,8 5,9,14,9

If %result% EQU 1 (
Call :make_button "[READONLY]" 5 5 1 10 %btnbg% %btntime% %txtbg%
Call :show_me 0 0
Call :run_command "chkdsk %systemdrive%" 3
Call :click_next
GoTo wCheckDisk
)

If %result% EQU 2 (
Call :make_button "[  SCAN  ]" 6 5 1 10 %btnbg% %btntime% %txtbg%
Call :show_me 0 0
Call :run_command "chkdsk %systemdrive% /scan" 3
Call :click_next
GoTo wCheckDisk
)

If %result% EQU 3 (
Call :make_button "[ REPAIR ]" 7 5 1 10 %btnbg% %btntime% %txtbg%
Call :show_me 0 0
Call :run_command "chkdsk %systemdrive% /F" 3
Call :click_next
GoTo wSystem
)

If %result% EQU 4 (
Call :make_button "[ SPOTFIX]" 8 5 1 10 %btnbg% %btntime% %txtbg%
Call :show_me 0 0
Call :run_command "chkdsk %systemdrive% /spotfix" 3
Call :click_next
GoTo wSystem
)

If %result% EQU 5 (
Call :make_button "[ <<<<<< ]" 9 5 1 10 %schcol4% %btntime% %txtbg%
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
rem PrintColorAt "[%title1%-v%version%]" 1 22 %schcol2% %txtbg%
If %2 EQU 1 ( 
rem PrintColorAt "David Scouten [c2024] zonemaster@yahoo.com" 25 20 %schcol2% %txtbg%
)
rem CursorHide
GOTO:EOF

rem run a command with error checking
rem *********************************
:run_command
rem PrintColorAt "> %TIME%" %1 %2 2 14 2
rem PrintReturn
Set /a t1=%2 + 2
rem PrintColorAt "[Please Do Not Close This Window Until Task Is Completed!]" %t1% 2 14 13
rem PrintReturn
Cmd /c %1
rem PrintReturn
rem PrintColorAt "< %TIME%" 24 2 14 12
If %ErrorLevel% LSS 1 (
rem PrintReturn
rem PrintCenter "[Success!]" 24 %txtfg% %txtbg%
) else (
rem PrintReturn
rem PrintCenter "[Failed!!]" 24 %schcol4% %txtbg%
)
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
rem PrintColorAt "[ >>>>>> ]" 25 35 %schcol2% %txtbg%
rem MouseCmd 36,25,46,25
If %result% EQU 1 Call :make_button "[ >>>>>> ]" 25 35 1 10 %schcol2% %btntime% %txtbg%
GOTO:EOF

rem time out for menus
rem ******************
:wait_time
Set wtime=5
:Loop1
rem PrintColorAt "[Please wait for %wtime% second(s)]" 25 26 %schcol2% %txtbg%
rem Wait %newtime2%
rem PrintColorAt "[Please wait for %wtime% second(s)]" 25 26 %schcol1% %txtbg%
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

rem writes the changes file
rem ***********************
:changes_file
(
Echo %chngfile%
Echo -
Echo %DATE%: %version%
Echo -
Echo PLEASE NOTE: You will need Advanced BAT to EXE converter if you
Echo plan on compiling this batch script. You can get that here:
Echo https://battoexeconverter.com
Echo -
Echo v1.0.0.0 - v1.0 released.
Echo ........ - main functions/routines all implemented.
Echo v1.0.1.0 - 'Settings changed' added to logging.
Echo v1.0.1.1 - Updated 'changes_file' function.
Echo ........ - Bug fixes.
Echo v1.0.1.2 - When compiling changes are automatically saved
Echo ........ - to 2CAF_Standalone.txt.
Echo v1.0.1.4 - More bug fixes.
Echo ........ - Cleaned up log file logging of functions.
Echo v1.0.1.5 - Removed logging option functions.
Echo v1.0.1.6 - Bug fixes.
Echo v1.0.1.7 - Optimizations and bug fixes.
Echo v1.0.1.8 - Added 'Task Scheduler' to 'TOOLS' menu.
Echo v1.0.1.9 - Added 'System Info' to 'TOOLS' and more fixes.
Echo v1.0.2.0 - Moved 'Clean Manager' from 'MainMenu' to 'TOOLS'.
Echo v1.0.2.1 - Removed restore point function was unneeded.
Echo v1.0.2.2 - Added 'DirectX Diagnostics' to 'TOOLS'.
Echo ........ - Bug fixes.
Echo v1.0.2.3 - Removed unneeded 'cleanmgr' code, and fixes.
Echo v1.0.2.4 - Added 'Computer Management' and 'RegEdit' to 'TOOLS'.
Echo v1.0.2.5 - Added flag '>>>' arrows to 'repair' after fix.
) > %chngfile%
GOTO:EOF

rem ***************
rem end subroutines
rem ***************