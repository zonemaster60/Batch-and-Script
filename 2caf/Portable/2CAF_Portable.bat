@ECHO OFF
REM BFCPEOPTIONSTART
REM Advanced BAT to EXE Converter www.BatToExeConverter.com
REM BFCPEEXE=C:\Users\zonem\Documents\BatchScript Projects\2caf\Portable\2CAF_Portable.exe
REM BFCPEICON=D:\Develop\Advanced BAT to EXE Converter PRO\ab2econv461pro\icons\icon3.ico
REM BFCPEICONINDEX=1
REM BFCPEEMBEDDISPLAY=0
REM BFCPEEMBEDDELETE=1
REM BFCPEADMINEXE=1
REM BFCPEINVISEXE=0
REM BFCPEVERINCLUDE=1
REM BFCPEVERVERSION=0.9.6.4
REM BFCPEVERPRODUCT=2Click Auto Fixer Portable
REM BFCPEVERDESC=Uses built-in tools to fix file errors
REM BFCPEVERCOMPANY=ZoneSoft
REM BFCPEVERCOPYRIGHT=David Scouten (2024)
REM BFCPEWINDOWCENTER=1
REM BFCPEDISABLEQE=0
REM BFCPEWINDOWHEIGHT=25
REM BFCPEWINDOWWIDTH=80
REM BFCPEWTITLE=
REM BFCPEEMBED=C:\Users\zonem\Documents\BatchScript Projects\2caf\Portable\w10mu.exe
REM BFCPEEMBED=C:\Users\zonem\Documents\BatchScript Projects\2caf\Portable\SFCFix.exe
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
Set shutdown=False
Set version=0.9.6.4

rem support files
rem *************
Set logfile=Repairs.log
Set inifile=Portable.ini
Set exe1=%myfiles%\sfcfix.exe
Set exe2=%myfiles%\w10mu.exe

rem set initial values
rem ******************
Set analyze=False
Set repair=False
Set logson=True

rem time values
rem ***********
Set cprofile=1
Set waittime=5000
Set wshutdown=30

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

rem website addresses
rem *****************
Set www1=battoexeconverter.com
Set www2=www.facebook.com/DavesPCPortal
Set www3=github.com/zonemaster60
Set www4=www.sysnative.com/forums/downloads/sfcfix/
Set www5=www.google.com/

rem display title
rem *************
Title 2Click Auto Fixer Portable v%version%

rem math routines
rem *************
Call :do_the_math

rem create inifile file if not exist
rem *******************************
If Not Exist %inifile% Call :data_manager 2
If %logson% EQU True Echo [%DATE%-%TIME%: '%~nx0' Initialized.]>>%logfile%

:wMainMenu
rem main menu
rem *********
Call :show_me %schcol1% 1
Call :data_manager 1
rem PaintBoxAt 3 3 21 76 %schcol2%
rem PaintBoxAt 12 14 3 53 %schcol1%

rem PrintColorAt "[MAINMENU]" 4 6 7 %txtbg%
rem PrintColorAt "[ ANALYZE]" 5 6 %btnbg% %txtbg%
rem PrintColorAt "[ REPAIR ]" 6 6 %btnbg% %txtbg%
rem PrintColorAt "[ CHKDSK ]" 7 6 %btnbg% %txtbg%
rem PrintColorAt "[CLEANMGR]" 8 6 %btnbg% %txtbg%
rem PrintColorAt "[  INFO  ]" 9 6 %btnbg% %txtbg%
rem PrintColorAt "[  EXIT  ]" 10 6 %schcol4% %txtbg%
rem PrintColorAt "Choose ANALYZE, REPAIR, CHKDSK, Or Something Else" 13 16 %btnfg% %txtbg%

rem display status
rem **************
rem PrintColorAt "[ STATUS ]" 4 66 7 %txtbg%
rem *
If %analyze% EQU True (
Set a_col=10
rem PrintColorAt "[ ISDONE ]" 5 66 %btnbg% %txtfg%
) else (
Set a_col=12
rem PrintColorAt "[NOT-DONE]" 5 66 %btnbg% 12
)
If %repair% EQU True (
Set r_col=10
rem PrintColorAt "[ ISDONE ]" 6 66 %btnbg% %txtfg%
) else (
Set r_col=12
rem PrintColorAt "[NOT-DONE]" 6 66 %btnbg% 12
)

rem other stuff
rem ***********
rem PrintColorAt "[ OPTION ]" 8 66 7 %txtbg%
rem PrintColorAt "[ SYSTEM ]" 9 66 %btnbg% %txtbg%
rem PrintColorAt "[  TOOLS ]" 10 66 %btnbg% %txtbg%

rem button matrix
rem *************
rem MouseCmd 6,5,15,5 6,6,15,6 6,7,15,7 6,8,15,8 6,9,15,9 6,10,15,10 66,9,75,9 66,10,75,10

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
Call :make_button "[CLEANMGR]" 8 6 1 10 %btnbg% %btntime% %txtbg%
Goto wCleanMgr
)

If %result% EQU 5 (
Call :make_button "[  INFO  ]" 9 6 1 10 %btnbg% %btntime% %txtbg%
Goto wInfo1
)

If %result% EQU 6 (
Call :make_button "[  EXIT  ]" 10 6 1 10 %schcol4% %btntime% %txtbg%
Goto wExit
)

If %result% EQU 7 (
Call :make_button "[ SYSTEM ]" 9 66 1 10 %btnbg% %btntime% %txtbg%
Goto wSystem
)

If %result% EQU 8 (
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
rem PrintColorAt "[ <<PREV ]" 8 5 %schcol4% %txtbg%
rem PrintColorAt "Choose SCAN, CHECK, Or <<PREV For MAINMENU" 13 20 %btnfg% %txtbg%

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
Call :make_button "[ <<PREV ]" 8 5 1 10 %schcol4% %btntime% %txtbg%
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
Call :data_manager 2
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
rem PrintColorAt "[ <<PREV ]" 8 5 %schcol4% %txtbg%
rem PrintColorAt "Choose REPAIR, RESETBAS, Or <<PREV For MAINMENU" 13 18 %btnfg% %txtbg%

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
Call :make_button "[ <<PREV ]" 8 5 1 10 %schcol4% %btntime% %txtbg%
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
Call :count_num 1 "Resets the entire component store to baseline."
Call :run_command "dism /online /cleanup-image /startcomponentcleanup /resetbase" 5
) else (
Call :count_num 1 "Performs a normal component store cleanup."
Call :run_command "dism /online /cleanup-image /startcomponentcleanup" 5
)
Call :wait_time
rem restore health
rem **************
Call :show_me 0 0
Call :count_num 2 "Cleans and restores health to the system image."
Call :run_command "dism /online /cleanup-image /restorehealth" 5
Call :wait_time
rem scan now
rem ********
Call :show_me 0 0
Call :count_num 3 "Scans and replaces corrupted system files."
Call :run_command "sfc /scannow" 5
Set analyze=True
Set repair=True
Call :data_manager 2
Call :click_next
GoTo wMainMenu

:wInfo1
rem info part 1
rem ***********
Call :show_me %schcol1% 0
rem PrintCenter "[ Use The Mouse to Navigate or the Number 0-9 Keys ]" 3 15 %txtbg%
rem PrintCenter "[ ANALYZE] (Button) - This uses DISM and SFC to [ANALYZE] for" 5 %btnbg% %txtbg%
rem PrintCenter "corrupted system files. This option DOES NOT make any repairs!" 6 %btnbg% %txtbg%
rem PrintCenter "[ REPAIR ] (Button) - This also uses DISM and SFC" 8 %btnbg% %txtbg%
rem PrintCenter "to [ANALYZE] and [REPAIR] any corrupted system files." 9 %btnbg% %txtbg%
rem PrintCenter "[ CHKDSK ] (Button) - Accesses the [CHKDSK] menu options." 11 %btnbg% %txtbg%
rem PrintCenter "[CLEANMGR] (Button) - Use cleanmgr to clean up temporary files." 13 %btnbg% %txtbg%
rem PrintCenter "[  INFO  ] (Button) - [INFO] - HELP, you are reading it now." 15 %btnbg% %txtbg%
rem PrintCenter "[  EXIT  ] (Button) - Well this is kind of self-explanatory." 17 %schcol4% %txtbg%
rem PrintCenter "(In any case, thank you for taking the time to try this tool!)" 18 %schcol4% %txtbg%
Call :click_next

:wInfo2
rem info part 2
rem ***********
Call :show_me %schcol1% 0
rem PrintCenter "[ Use The Mouse to Navigate or the Number 0-9 Keys ]" 3 15 %txtbg%
rem PrintColorAt "1] cprofile=%cprofile% - profile number for use with cleanmgr." 5 10 15 %txtbg%
rem PrintColorAt "2] waittime=%waittime% - timing interval for wait/pause." 6 10 15 %txtbg%
rem PrintColorAt "3] wshutdown=%wshutdown% - time for windows to shutdown." 7 10 15 %txtbg%
rem PrintColorAt "4] btnbg=%btnbg% - button background color." 8 10 %btnbg% %txtbg%
rem PrintColorAt "5] btnfg=%btnfg% - button foreground color." 9 10 %btnfg% %txtbg%
rem PrintColorAt "6] schcol1=%schcol1% - scheme color one." 10 10 %schcol1% %txtbg%
rem PrintColorAt "7] schcol2=%schcol2% - scheme color two." 11 10 %schcol2% %txtbg%
rem PrintColorAt "8] schcol3=%schcol3% - scheme color three." 12 10 %schcol3% %txtbg%
rem PrintColorAt "9] schcol4=%schcol4% - scheme color four." 13 10 %schcol4% %txtbg%
rem PrintColorAt "10] txtbg=%txtbg% - text background color." 14 9 %txtbg% 7
rem PrintColorAt "11] txtfg=%txtfg% - text foreground color." 15 9 %txtfg% %txtbg%
rem PrintCenter "(Only values that can be edited are shown here.)" 17 14 %txtbg%
Call :click_next

:wInfo3
rem info part 3
rem ***********
Call :show_me %schcol1% 0
rem PrintCenter "[ Use The Mouse to Navigate or the Number 0-9 Keys ]" 3 15 %txtbg%
rem PrintCenter "[ STATUS ] (Status) - The status of [ANALYZE] and [REPAIR] tasks." 5 7 %txtbg%
rem PrintCenter "[NOT-DONE] (Status) - NOT-DONE/ISDONE Analyze task." 7 %a_col% %txtbg%
rem PrintCenter "[NOT-DONE] (Status) - NOT-DONE/ISDONE Repair task." 9 %r_col% %txtbg%
rem PrintCenter "[ OPTION ] (Option) - to [RESTART] or [SHUTDOWN] system." 11 7 %txtbg%
rem PrintCenter "[ SYSTEM ] (Button) - Used to Restart or Shutdown system." 13 14 %txtbg%
rem PrintCenter "[  TOOLS ] (Button) - Will be used to access TOOLS menu." 15 14 %txtbg%
rem PrintCenter "(User: '%username%' - Computer: '%computername%')" 17 %schcol2% %txtbg%
Call :click_next
GoTo wMainMenu

:wExit
rem exit menu
rem *********
Call :show_me %schcol4% 0
rem PaintBoxAt 4 3 5 14 %schcol3%
rem PaintBoxAt 12 22 3 39 %schcol3%
rem PrintColorAt "[  EXIT  ]" 5 5 7 %txtbg%
rem PrintColorAt "[  EXIT  ]" 6 5 %schcol4% %txtbg%
rem PrintColorAt "[ <<PREV ]" 7 5 %btnbg% %txtbg%
rem PrintColorAt "Choose EXIT, Or <<PREV For MAINMENU" 13 24 %btnfg% %txtbg%
rem PrintColorAt "[%www1%]" 16 6 %txtfg% %txtbg%
rem GetLength %www1%
Set /a len1=%result% + 2
rem PrintColorAt "[%www2%]" 18 6 %txtfg% %txtbg%
rem GetLength %www2%
Set /a len2=%result% + 2
rem PrintColorAt "[%www3%]" 20 6 %txtfg% %txtbg%
rem GetLength %www3%
Set /a len3=%result% + 2
rem PrintColorAt "[%www4%]" 22 6 %txtfg% %txtbg%
rem GetLength %www4%
Set /a len4=%result% + 2
rem PrintColorAt "[%www5%]" 24 6 %txtfg% %txtbg%
rem GetLength %www5%
Set /a len5=%result% + 2
 
rem button matrix
rem *************
rem MouseCmd 5,6,14,6 5,7,14,7 6,16,%len1%,16 6,18,%len2%,18 6,20,%len3%,20 6,22,%len4%,22 6,24,%len5%,24

If %result% EQU 1 (
Call :make_button "[  EXIT  ]" 6 5 1 10 %schcol4% %btntime% %txtbg%
GoTo wExitNow
)

If %result% EQU 2 (
Call :make_button "[ <<PREV ]" 7 5 1 10 %btnbg% %btntime% %txtbg%
GoTo wMainMenu
)

If %result% EQU 3 (
Call :make_button "[%www1%]" 16 6 1 %len1% %txtfg% %btntime% %txtbg%
Call :run_command "start https://%www1%" 16 >nul
GoTo wExit
)

If %result% EQU 4 (
Call :make_button "[%www2%]" 18 6 1 %len2% %txtfg% %btntime% %txtbg%
Call :run_command "start https://%www2%" 18 >nul
GoTo wExit
)

If %result% EQU 5 (
Call :make_button "[%www3%]" 20 6 1 %len3% %txtfg% %btntime% %txtbg%
Call :run_command "start https://%www3%" 20 >nul
GoTo wExit
)

If %result% EQU 6 (
Call :make_button "[%www4%]" 22 6 1 %len4% %txtfg% %btntime% %txtbg%
Call :run_command "start https://%www4%" 22 >nul
GoTo wExit
)

If %result% EQU 7 (
Call :make_button "[%www5%]" 24 6 1 %len5% %txtfg% %btntime% %txtbg%
Call :run_command "start https://%www5%" 24 >nul
GoTo wExit
)

GoTo wExit

:wExitNow
rem exit now
rem ********
Call :show_me %schcol4% 1
rem PaintBoxAt 12 19 3 43 %schcol3%
rem PrintColorAt "Thank you for using this FREE software!" 13 21 %btnfg% %txtbg%
If %logson% EQU True Echo [%TIME%: '%~nx0' Terminated.]>>%logfile%
Call :wait_time >nul
Call :reset_inifile
ENDLOCAL
Exit /B %ErrorLevel%

:wSystem
rem system menu
rem ***********
Call :show_me %schcol4% 1
rem PaintBoxAt 4 3 6 14 %schcol3%
rem PaintBoxAt 12 15 3 52 %schcol3%
rem PrintColorAt "[ SYSTEM ]" 5 5 7 %txtbg%
rem PrintColorAt "[ RESTART]" 6 5 %btnbg% %txtbg%
rem PrintColorAt "[SHUTDOWN]" 7 5 %btnbg% %txtbg%
rem PrintColorAt "[ <<PREV ]" 8 5 %schcol4% %txtbg%
rem PrintColorAt "Choose RESTART, SHUTDOWN, Or <<PREV For MAINMENU" 13 17 %btnfg% %txtbg%

rem button matrix
rem *************
rem MouseCmd 5,6,14,6 5,7,14,7 5,8,14,8

If %result% EQU 1 (
Call :make_button "[ RESTART]" 6 5 1 10 %btnbg% %btntime% %txtbg%
Set shutdown=False
If %logson% EQU True Echo [%TIME%: Restarting system.]>>%logfile%
GoTo wRestartNow
)

If %result% EQU 2 (
Call :make_button "[SHUTDOWN]" 7 5 1 10 %btnbg% %btntime% %txtbg%
Set shutdown=True
If %logson% EQU True Echo [%TIME%: Shutting down system.]>>%logfile%
GoTo wRestartNow
)

If %result% EQU 3 (
Call :make_button "[ <<PREV ]" 8 5 1 10 %schcol4% %btntime% %txtbg%
GoTo wMainMenu
)
GoTo wSystem

:wRestartNow
rem restart now
rem ***********
Call :show_me %schcol4% 1
If %shutdown% EQU True (
rem PaintBoxAt 12 21 3 41 %schcol3%
rem PrintColorAt "Shutting down system in %wshutdown% second(s)!" 13 23 %schcol2% %txtbg%
Call :wait_time >nul
Call :run_command "shutdown /S /T %wshutdown%" 20 >nul
)
If %shutdown% EQU False (
rem PaintBoxAt 12 21 3 38 %schcol3%
rem PrintColorAt "Restarting system in %wshutdown% second(s)!" 13 23 %schcol2% %txtbg%
Call :wait_time >nul
Call :run_command "shutdown /R /T %wshutdown%" 20 >nul
)

rem reset inifile file
rem *****************
If %logson% EQU True Echo [%TIME%: '%~nx0' Terminated.]>>%logfile%
Call :reset_inifile
ENDLOCAL
Exit /B %ErrorLevel%

:wTools
Call :show_me %schcol1% 0
rem PaintBoxAt 3 3 8 14 %schcol2%
rem PaintBoxAt 12 15 3 47 %schcol2%
rem PrintColorAt "[  TOOLS ]" 4 5 7 %txtbg%
rem PrintColorAt "[ SFCFIX ]" 5 5 %txtfg% %txtbg%
rem PrintColorAt "[ UPDWIN ]" 6 5 %txtfg% %txtbg%
rem PrintColorAt "[ POLICY ]" 7 5 %schcol4% %txtbg%
rem PrintColorAt "[ REGADD ]" 8 5 %txtfg% %txtbg
rem PrintColorAt "[ <<PREV ]" 9 5 %schcol4% %txtbg%
rem PrintColorAt "(WIP) Choose a TOOL, or <<PREV For MAINMENU" 13 17 %btnfg% %txtbg%

rem button matrix
rem *************
rem MouseCmd 5,5,14,5 5,6,14,6 5,7,14,7 5,8,14,8 5,9,14,9

If %result% EQU 1 (
Call :make_button "[ SFCFIX ]" 5 5 1 10 %txtfg% %btntime% %txtbg%
Cmd /c start %exe1%
Call :click_next
)

If %result% EQU 2 (
Call :make_button "[ UPDWIN ]" 6 5 1 10 %txtfg% %btntime% %txtbg%
Cmd /c start %exe2%
Call :click_next
)

If %result% EQU 3 (
Call :make_button "[ POLICY ]" 7 5 1 10 %schcol4% %btntime% %txtbg%
rem PrintColorAt "Resetting Policies to defaults..." 13 20 %btnfg% %txtbg%
reg delete "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies" /f
reg delete "HKLM\Software\Microsoft\WindowsSelfHost" /f
reg delete "HKLM\Software\Policies" /f
reg delete "HKLM\Software\WOW6432Node\Microsoft\Policies" /f
reg delete "HKLM\Software\WOW6432Node\Microsoft\Windows\CurrentVersion\Policies" /f
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies" /f
reg delete "HKCU\Software\Microsoft\WindowsSelfHost" /f
reg delete "HKCU\Software\Policies" /f
reg delete "HKLM\Software\Microsoft\Policies" /f
Call :click_next
GoTo wRestartNow
)

If %result% EQU 4 (
Call :make_button "[ REGADD ]" 8 5 1 10 %txtfg% %btntime% %txtbg%
)

If %result% EQU 5 (
Call :make_button "[ <<PREV ]" 9 5 1 10 %schcol4% %btntime% %txtbg%
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
rem PrintColorAt "[ <<PREV ]" 9 5 %schcol4% %txtbg%
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
Call :make_button "[ <<PREV ]" 9 5 1 10 %schcol4% %btntime% %txtbg%
GoTo wMainMenu
)
GoTo wCheckDisk

:wCleanMgr
rem cleanmgr menu
rem *************
Call :show_me %schcol1% 0
rem PaintBoxAt 3 3 7 14 %schcol2%
rem PaintBoxAt 12 18 3 47 %schcol2%
rem PrintColorAt "[CLEANMGR]" 4 5 7 %txtbg%
rem PrintColorAt "[  SETUP ]" 5 5 %btnbg% %txtbg%
rem PrintColorAt "[  CLEAN ]" 6 5 %btnbg% %txtbg%
rem PrintColorAt "[ TUNEUP ]" 7 5 %btnbg% %txtbg%
rem PrintColorAt "[ <<PREV ]" 8 5 %schcol4% %txtbg%
rem PrintColorAt "Choose SETUP, CLEAN, Or <<PREV For MAINMENU" 13 20 %btnfg% %txtbg%

rem button matrix
rem *************
rem MouseCmd 5,5,14,5 5,6,14,6 5,7,14,7 5,8,14,8

If %result% EQU 1 (
Call :make_button "[  SETUP ]" 5 5 1 10 %btnbg% %btntime% %txtbg%
Call :show_me %schcol1% 0
rem PrintColorAt "Cleanup manager - Drive: %systemdrive%" 3 5 %schcol1% %txtbg%
Call :run_command "cleanmgr /d %systemdrive% /sageset:%cprofile%" 5
rem PrintColorAt "Setup complete." 9 5 %schcol1% %txtbg%
Call :click_next
GoTo wCleanMgr
)

If %result% EQU 2 (
Call :make_button "[  CLEAN ]" 6 5 1 10 %btnbg% %btntime% %txtbg%
Call :show_me %schcol1% 0
rem PrintColorAt "Cleanup manager - Drive: %systemdrive%" 3 5 %schcol2% %txtbg%
Call :run_command "cleanmgr /d %systemdrive% /sagerun:%cprofile%" 5
rem PrintColorAt "Cleanup complete." 9 5 %schcol2% %txtbg%
Call :click_next
GoTo wCleanMgr
)

If %result% EQU 3 (
Call :make_button "[ TUNEUP ]" 7 5 1 10 %btnbg% %btntime% %txtbg%
Call :show_me %schcol1% 0
rem PrintColorAt "Cleanup manager - Drive: %systemdrive%" 3 5 %schcol2% %txtbg%
Call :run_command "cleanmgr /d %systemdrive% /tuneup:%cprofile%" 5
rem PrintColorAt "TuneUp complete." 9 5 %schcol2% %txtbg%
Call :click_next
GoTo wCleanMgr
)

If %result% EQU 4 (
Call :make_button "[ <<PREV ]" 8 5 1 10 %schcol4% %btntime% %txtbg%
GoTo wMainMenu
)
GoTo wCleanMgr

rem *****************
rem begin subroutines
rem *****************

rem display the title section
rem *************************
:show_me
If %conmode% EQU 1 mode con:cols=80 lines=25
If %conmode% EQU 2 mode con:cols=120 lines=30
rem ClearColor
rem PaintScreen %1
rem PrintColorAt "2Click Auto Fixer v%version%" 1 27 %schcol2% %txtbg%
If %2 EQU 1 ( 
rem PrintColorAt "David Scouten [c2024] zonemaster@yahoo.com" 25 20 %schcol2% %txtbg%
)
rem CursorHide
GOTO:EOF

rem run a command with error checking
rem *********************************
:run_command
rem PrintColorAt "Start: %TIME%" %1 %2 2 14 2
rem PrintReturn
Set /a t1=%2 + 2
rem PrintColorAt "Please Wait (Do Not Close This Window!)" %t1% 2 14 %schcol4%
rem PrintReturn
Cmd /c %1
rem PrintReturn
rem PrintColorAt "End: %TIME%" 23 2 14 13
If %ErrorLevel% LSS 1 (
rem PrintReturn
rem PrintCenter "[Success]" 24 %txtfg% %txtbg%
If %logson% EQU True Echo [%TIME%: Command Run: %1]>>%logfile%
) else (
rem PrintReturn
rem PrintCenter "[Fail! Error '%ErrorLevel%']" 24 %schcol4% %txtbg%
If %logson% EQU True Echo [%TIME%: Command Run: %1: Error '%ErrorLevel%']>>%logfile%
)
GOTO:EOF

rem shows current stage of repairs
rem ******************************
:count_num
Set nums=3
rem PrintColorAt "Stage %1 of %nums% - %2" 3 2 14 1
If %logson% EQU True Echo [%TIME%: Stage %1 of %nums%: '%2']>>%logfile%
GOTO:EOF

rem click next button
rem *****************
:click_next
rem PrintColorAt "[ NEXT> ]" 25 36 %schcol2% %txtbg%
rem MouseCmd 36,25,43,25
If %result% EQU 1 Call :make_button "[ NEXT> ]" 25 36 1 9 %schcol2% %btntime% %txtbg%
GOTO:EOF

rem data manager v0.5
rem *****************
:data_manager
If %1 EQU 1 GoTo :load
If %1 EQU 2 GoTo :save
GoTo :data_manager

rem load settings data
rem ******************
:load
< %inifile% (
Set /p analyze=
Set /p repair=
Set /p cprofile=
Set /p waittime=
Set /p wshutdown=
Set /p btnbg=
Set /p btnfg=
Set /p schcol1=
Set /p schcol2=
Set /p schcol3=
Set /p schcol4=
Set /p txtbg=
Set /p txtfg=
Set /p www1=
Set /p www2=
Set /p www3=
Set /p www4=
Set /p www5=
)
If %logson% EQU True Echo [%TIME%: Loaded Configuration: '%inifile%']>>%logfile%
GOTO:EOF

rem save settings data
rem ******************
:save
(
Echo %analyze%
Echo %repair%
Echo %cprofile%
Echo %waittime%
Echo %wshutdown%
Echo %btnbg%
Echo %btnfg%
Echo %schcol1%
Echo %schcol2%
Echo %schcol3%
Echo %schcol4%
Echo %txtbg%
Echo %txtfg%
Echo %www1%
Echo %www2%
Echo %www3%
Echo %www4%
Echo %www5%
) > %inifile%
If %logson% EQU True Echo [%TIME%: Saved Configuration: '%inifile%']>>%logfile%
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

:make_button
Set tracking=False
rem call :make_button "btnname" line column height width colorfg btntime colorbg
rem PaintBoxAt %2 %3 %4 %5 %6
rem Wait %7
rem PrintColorAt %1 %2 %3 %6 %8
rem Wait %7
Set /a len1=(%3 + %5) - 1
If %tracking% EQU True Echo [Button '%1': rem MouseCmd %3,%2,%len1%,%2]>>%logfile%
GOTO:EOF

:reset_inifile
Set analyze=False
Set repair=False
If %logson% EQU True Echo [%TIME%: Reset Configuration: '%inifile%']>>%logfile% 
Call :data_manager 2
GOTO:EOF

rem ***************
rem end subroutines
rem ***************