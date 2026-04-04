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
REM BFCPEVERVERSION=1.1.4.4
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
Set version=v1.1.4.4

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
Set "SYSlog=Handy2ClickAutoFixer.log"

rem **********************
rem *addon paths and limits
rem **********************
Set "addondir=addons"
Set "logdir=logs"
Set "readme=readme.txt"
Set "viewer=viewer.exe"
Set max=16

rem make the addons folder
If not exist "%addondir%" mkdir "%addondir%" >nul 2>&1
rem make the log folder
If not exist "%logdir%" mkdir "%logdir%" >nul 2>&1

rem ********************
rem check for powershell
rem ********************
rem CursorHide
rem PaintScreen 0
rem PrintColorAt "{Checking for Java versions...}" 2 2 %yellow14% %black0%
where java >nul 2>&1
if %errorlevel% EQU 0 (
rem PrintColorAt "{Java Is Installed.}" 3 6 %green10% %black0%
) else (
rem PrintColorAt "{Java Is NOT Installed.}" 3 6 %yellow14% %red4%
)
timeout /t %ct1% /nobreak >nul
rem PrintColorAt "{Checking for PowerShell versions...}" 5 2 %yellow14% %black0%
where powershell >nul 2>&1
If %errorlevel% EQU 0 (
rem PrintColorAt "{PowerShell Is Installed.}" 6 6 %green10% %black0%
) else (
rem PrintColorAt "{PowerShell Is NOT Installed.}" 6 6 %yellow14% %red4%
)
timeout /t %ct1% /nobreak >nul
where pwsh >nul 2>&1
If %errorlevel% EQU 0 (
rem PrintColorAt "{PowerShell Core Is Installed.}" 7 6 %green10% %black0%
) else (
rem PrintColorAt "{PowerShell Core Is NOT Installed.}" 7 6 %yellow14% %red4%
)
timeout /t %ct1% /nobreak >nul
rem PrintColorAt "{Checking for Python versions...}" 9 2 %yellow14% %black0%
where python >nul 2>&1
if %errorlevel% EQU 0 (
rem PrintColorAt "{Python Is Installed.}" 10 6 %green10% %black0%
) else (
rem PrintColorAt "{Python Is NOT Installed.}" 10 6 %yellow14% %red4%
)
timeout /t %ct1% /nobreak >nul

rem *********
rem main menu
rem *********

:MAIN
Set lmenu=MAIN
Call :load_addons
Call :show_me %black0% 1
rem PrintColorAt "{%lmenu%MENU}" 3 5 %gray7% %black0%
rem PrintColorAt "[ ANALYZE]" 4 5 %yellow14% %black0%
rem PrintColorAt "[ REPAIR ]" 5 5 %green10% %black0%
rem PrintColorAt "[  INFO  ]" 6 5 %magenta13% %black0%
If exist "%viewer%" (
rem PrintColorAt "[VIEWLOGS]" 7 5 %cyan3% %black0%
) else (
rem PrintColorAt "[VIEWLOGS]" 7 5 %yellow14% %black0%
)
rem PrintColorAt "[WINTOOLS]" 8 5 %cyan11% %black0%
rem PrintColorAt "[  EXIT  ]" 9 5 %red12% %black0%

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
Set /a avl=%max%-%count%
If %count% GTR 0 (
rem PrintColorAt "[ ADDONS ]" 7 66 %cyan3% %black0%
rem PrintColorAt "{U:%count%|A:%avl%}" 8 66 %cyan3% %black0%
) else (
rem PrintColorAt "[ ADDONS ]" 7 66 %yellow14% %black0%
rem PrintColorAt "{U:%count%|A:%avl%}" 8 66 %yellow14% %black0%
)
rem viewer or notepad
If exist "%viewer%" (
rem PrintColorAt "[ README ]" 9 66 %cyan3% %black0%
) else (
rem PrintColorAt "[ README ]" 9 66 %yellow14% %black0%
)
rem PrintColorAt "[ CHKDSK ]" 10 66 %cyan11% %black0%

rem *************
rem button matrix
rem *************

rem MouseCmd 5,4,14,4 5,5,14,5 5,6,14,6 5,7,14,7 5,8,14,8 5,9,14,9 66,7,75,7 66,9,75,9 66,10,75,10

If %result% EQU 1 (
rem PrintColorAt "{Go to the 'ANALYZE' menu.}" 4 16 %yellow14% %black0%
Call :make_button "[ ANALYZE]" 4 5 1 10 %yellow14% %btntime% %black0%
Goto ANALYZE
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
If exist "%viewer%" (
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
Goto WINTOOLS
)

If %result% EQU 6 (
rem PrintColorAt "{Go to the 'EXIT' menu.}" 9 16 %red12% %black0%
Call :make_button "[  EXIT  ]" 9 5 1 10 %red12% %btntime% %black0%
Goto EXIT
)

If %result% EQU 7 (
If %count% GTR 0 (
rem PrintColorAt "{Go to the 'ADDONS' menu.}" 7 39 %cyan3% %black0%
Call :make_button "[ ADDONS ]" 7 66 1 10 %cyan3% %btntime% %black0%
Goto ADDONS
) else (
rem PrintColorAt "{'addons' folder has no .exe files.}" 7 31 %yellow14% %black0%
Call :make_button "[ ADDONS ]" 7 66 1 10 %yellow14% %btntime% %black0%
Goto MAIN
)
)

If %result% EQU 8 (
If exist "%viewer%" (
rem PrintColorAt "{View the 'readme' with %viewer%.}" 9 29 %cyan3% %black0%
Call :make_button "[ README ]" 9 66 1 10 %cyan3% %btntime% %black0%
Call :open_file_with_viewer "%readme%" >nul
) else (
rem PrintColorAt "{View the 'readme' with notepad.exe.}" 9 28 %yellow14% %black0%
Call :make_button "[ README ]" 9 66 1 10 %yellow14% %btntime% %black0%
Call :open_file_with_viewer "%readme%" >nul
Goto MAIN
)
)

If %result% EQU 9 (
rem PrintColorAt "{Go to the 'CHKDSK' menu.}" 10 39 %cyan11% %black0%
Call :make_button "[ CHKDSK ]" 10 66 1 10 %cyan11% %btntime% %black0%
Goto CHKDSK
)
Goto MAIN

rem ************
rem analyze menu
rem ************

:ANALYZE
Set lmenu=ANALYZE
Call :show_me %black0% 1
rem PrintColorAt "{ %lmenu%}" 3 5 %gray7% %black0%
for /l %%N in (1,1,2) do Call :show_analyze_slot %%N
rem PrintColorAt "[ <BACK< ]" 6 5 %yellow14% %gray8%

rem *************
rem button matrix
rem *************

rem MouseCmd 5,4,14,4 5,5,14,5 5,6,14,6

If %result% GEQ 1 If %result% LEQ 2 (
Call :launch_analyze_slot %result%
Goto ANALYZE1
)

If %result% EQU 3 (
rem PrintColorAt "{Go 'BACK' to the 'MAIN' menu.}" 6 16 %yellow14% %black0%
Call :make_button "[ <BACK< ]" 6 5 1 10 %yellow14% %btntime% %gray8%
Goto MAIN
)
Goto ANALYZE

:ANALYZE1
rem ***********
rem analyze now
rem *********************
rem check component store
rem *********************

Call :show_me %black0% 0
rem PrintCenter "{%lmenu% > 1/3 > Analyzes the system component store for errors.}" 2 %blue9% %black0%
Call :run_command "dism /online /cleanup-image /analyzecomponentstore" ""
timeout /t %ct2% /nobreak >nul

rem ********************
rem check or scan health
rem ********************

Call :show_me %black0% 0
If %chkhealth% EQU True (
rem PrintCenter "{%lmenu% > 2/3 > CheckHealth is faster, but not as thorough.}" 2 %blue9% %black0%
Call :run_command "dism /online /cleanup-image /checkhealth" ""
) else (
rem PrintCenter "{%lmenu% > 2/3 > ScanHealth is slower, but performs a better test.}" 2 %blue9% %black0%
Call :run_command "dism /online /cleanup-image /scanhealth" ""
)
timeout /t %ct2% /nobreak >nul


rem ************
rem verify files
rem ************

Call :show_me %black0% 0
rem PrintCenter "{%lmenu% > 3/3 > Verifies, but does not replace any system files.}" 2 %blue9% %black0%
Call :run_command "sfc /verifyonly" ""
timeout /t %ct2% /nobreak >nul
Set analyze=True
Set skipped=False
Goto MAIN

rem ***********
rem repair menu
rem ***********

:REPAIR
Set lmenu=REPAIR
Call :show_me %black0% 1
rem PrintColorAt "{ %lmenu% }" 3 5 %gray7% %black0%
for /l %%N in (1,1,3) do Call :show_repair_slot %%N
rem PrintColorAt "[ <BACK< ]" 7 5 %yellow14% %gray8%

rem *************
rem button matrix
rem *************

rem MouseCmd 5,4,14,4 5,5,14,5 5,6,14,6 5,7,14,7

If %result% GEQ 1 If %result% LEQ 3 (
Call :launch_repair_slot %result%
Goto REPAIR1
)

If %result% EQU 4 (
rem PrintColorAt "{Go 'BACK' to the 'MAIN' menu.}" 7 16 %yellow14% %black0%
Call :make_button "[ <BACK< ]" 7 5 1 10 %yellow14% %btntime% %gray8%
Goto MAIN
)
Goto REPAIR

:REPAIR1
rem **********
rem repair now
rem **************************
rem resetbase / normal cleanup
rem **************************

Call :show_me %black0% 0
If %resetbase% EQU True (
rem PrintCenter "{%lmenu% > 1/3 > Reset the entire system component store to baseline.}" 2 %blue9% %black0%
Call :run_command "dism /online /cleanup-image /startcomponentcleanup /resetbase" ""
) else (
rem PrintCenter "{%lmenu% > 1/3 > Perform a normal system component store cleanup.}" 2 %blue9% %black0%
Call :run_command "dism /online /cleanup-image /startcomponentcleanup" ""
)
timeout /t %ct2% /nobreak >nul

rem **************
rem restore health
rem **************

Call :show_me %black0% 0
If %winupdate% EQU False (
rem PrintCenter "{%lmenu% > 2/3 > Clean, update, and restore the system image health.}" 2 %blue9% %black0%
Call :run_command "dism /online /cleanup-image /restorehealth" ""
) else (
rem PrintCenter "{%lmenu% > 2/3 > Clean, update, and restore using Windows Update.}" 2 %blue9% %black0%
Call :run_command "dism /online /cleanup-image /restorehealth /source:windowsupdate" ""
)
timeout /t %ct2% /nobreak >nul

rem ********
rem scan now
rem ********

Call :show_me %black0% 0
rem PrintCenter "{%lmenu% > 3/3 > Scans, and replaces any corrupted system files.}" 2 %blue9% %black0%
Call :run_command "sfc /scannow" ""
If %analyze% EQU False (
Set skipped=True
) else (
Set skipped=False
Set analyze=True
)
Set repair=True
rem run sfcfix if it's in the 'addons' folder
If exist "addons\sfcfix.exe" Call :run_command "start addons\sfcfix.exe" "" >nul
timeout /t %ct2% /nobreak >nul
Goto MAIN

rem ***********
rem info part 1
rem ***********

:INFO1
Call :show_me %black0% 0
Set lmenu=INFO1
rem PrintCenter "%title1%" 1 %cyan3% %black0%
rem PrintCenter "{%lmenu%}" 2 %cyan3% %black0%
rem PrintCenter "{Use The Mouse to Navigate or the Number 0-9 Keys}" 4 %yellow14% %black0%
rem PrintCenter "[ ANALYZE ] This uses DISM and SFC to analyze" 6 %yellow14% %black0%
rem PrintCenter "any corrupted system files. [SCAN] and [CHECK] are options." 7 %yellow14% %black0%
rem PrintCenter "[ REPAIR ] This uses DISM and SFC to repair" 9 %green10% %black0%
rem PrintCenter "any corrupted system files. [REPAIR], [REPAIR+] and [RSETBASE] are options." 10 %green10% %black0%
rem PrintCenter "[  INFO  ] You are reading it now. {3 pages}" 12 %magenta13% %black0%
If exist "%viewer%" (
rem PrintCenter "[VIEWLOGS] View the CBS and DISM system logs." 14 %cyan3% %black0%
) else (
rem PrintCenter "[VIEWLOGS] View the CBS and DISM system logs." 14 %yellow14% %black0%
)
rem PrintCenter "[WINTOOLS] Access the windows built in tools." 16 %cyan11% %black0%
rem PrintCenter "[  EXIT  ] Exit the program." 18 %red12% %black0%
Call :next_page

rem ***********
rem info part 2
rem ***********

:INFO2
Call :show_me %black0% 0
Call :load_addons
Set lmenu=INFO2
rem PrintCenter "%title1%" 1 %cyan3% %black0%
rem PrintCenter "{%lmenu%}" 2 %cyan3% %black0%
rem PrintCenter "{Use The Mouse to Navigate or the Number 0-9 Keys}" 4 %yellow14% %black0%
rem PrintCenter "{ STATUS } The status of [ ANALYZE ] and [ REPAIR ] system image tasks." 6 %gray7% %black0%
rem PrintCenter "{ ------ } ------/ DONE [ ANALYZE ] system image task." 8 %gray7% %black0%
rem PrintCenter "{ ------ } ------/ DONE [ REPAIR ] system image task." 10 %gray7% %black0%
rem PrintCenter "{ OPTION } Options are [ ADDONS ]." 12 %gray7% %black0%
If %count% GTR 0 (
rem PrintCenter "[ ADDONS ] If you have (portable .exe's) you can access them from here." 14 %cyan3% %black0%
rem PrintCenter "{U:XX|A:XX} U:XX = USED addon slots, A:XX = AVAILABLE addon slots." 16 %cyan3% %black0%
) else (
rem PrintCenter "[ ADDONS ] If you have (portable .exe's) you can access them from here." 14 %yellow14% %black0%
rem PrintCenter "{U:XX|A:XX} U:XX = USED addon slots, A:XX = AVAILABLE addon slots." 16 %yellow14% %black0%
)
If exist "%viewer%" (
rem PrintCenter "[ README ] View the readme using 'Notepad' or your own viewer." 18 %cyan3% %black0% 
) else (
rem PrintCenter "[ README ] View the readme using 'Notepad' or your own viewer." 18 %yellow14% %black0% 
)
rem PrintCenter "[ CHKDSK ] Go to the CHKDSK menu." 20 %cyan11% %black0%
Call :next_page

rem ***********
rem info part 3
rem ***********

:INFO3
Call :show_me %black0% 0
Set lmenu=INFO3
rem PrintCenter "%title1%" 1 %cyan3% %black0%
rem PrintCenter "{%lmenu%}" 2 %cyan3% %black0%
rem PrintCenter "{Use The Mouse to Navigate or the Number 0-9 Keys}" 4 %yellow14% %black0%
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
rem PrintCenter "{Thank you for taking the time to try this program.}" 18 %green10% %black0%
Call :next_page
Goto MAIN

rem ********************
rem view the repair logs
rem ********************
:VIEWLOGS
Set lmenu=VIEWLOGS
Call :show_me %black0% 1
rem PrintColorAt "{%lmenu%}" 3 5 %gray7% %black0%
for /l %%N in (1,1,2) do Call :show_log_slot %%N
rem PrintColorAt "[ <BACK< ]" 6 5 %yellow14% %gray8%

rem *************
rem button matrix
rem *************

rem MouseCmd 5,4,14,4 5,5,14,5 5,6,14,6

If %result% GEQ 1 If %result% LEQ 2 (
Call :launch_log_slot %result%
Goto VIEWLOGS
)

If %result% EQU 3 (
rem PrintColorAt "{Go 'BACK' to the 'MAIN' menu.}" 6 16 %yellow14% %black0%
Call :make_button "[ <BACK< ]" 6 5 1 10 %yellow14% %btntime% %gray8%
Goto MAIN
)
Goto VIEWLOGS

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
rem PrintCenter "{Thank you for using this FREE Software.}" 13 %green10% %black0%
timeout /t %ct2% /nobreak >nul
rem reboot system if repairs were done.
If %repair% EQU True Goto RESTART
ENDLOCAL
Exit /B %ErrorLevel%
)

If %result% EQU 2 (
rem PrintColorAt "{Go 'BACK' to the 'MAIN' menu.}" 5 16 %yellow14% %black0%
Call :make_button "[ <BACK< ]" 5 5 1 10 %yellow14% %btntime% %gray8%
Goto MAIN
)
Goto EXIT

:ADDONS
Set lmenu=ADDONS
Call :load_addons
Call :show_me %black0% 1
rem PrintColorAt "{ %lmenu% }" 3 5 %gray7% %black0%
for /l %%N in (1,1,%max%) do (
Call :addon_row %%N addonrow
Call :show_addon_slot %%N !addonrow!
)
rem PrintColorAt "[ <BACK< ]" 23 5 %yellow14% %gray8%

rem *************
rem button matrix
rem *************

rem MouseCmd 5,4,14,4 5,5,14,5 5,6,14,6 5,7,14,7 5,8,14,8 5,9,14,9 5,10,14,10 5,11,14,11 5,15,14,15 5,16,14,16 5,17,14,17 5,18,14,18 5,19,14,19 5,20,14,20 5,21,14,21 5,22,14,22 5,23,14,23

If %result% GEQ 1 If %result% LEQ %max% (
Call :addon_row %result% addonrow
Call :launch_addon_slot %result% !addonrow!
Goto ADDONS
)

If %result% EQU 17 (
rem PrintColorAt "{Go 'BACK' to the 'MAIN' menu.}" 23 16 %yellow14% %black0%
Call :make_button "[ <BACK< ]" 23 5 1 10 %yellow14% %btntime% %gray8%
Goto MAIN
)
Goto ADDONS

rem *************
rem wintools menu
rem *************

:WINTOOLS
Set lmenu=WINTOOLS
Call :show_me %black0% 1
rem PrintColorAt "{%lmenu%}" 3 5 %gray7% %black0%
for /l %%N in (1,1,10) do Call :show_wintool_slot %%N
rem PrintColorAt "[ <BACK< ]" 14 5 %yellow14% %gray8%

rem *************
rem button matrix
rem *************

rem MouseCmd 5,4,14,4 5,5,14,5 5,6,14,6 5,7,14,7 5,8,14,8 5,9,14,9 5,10,14,10 5,11,14,11 5,12,14,12 5,13,14,13 5,14,14,14

If %result% GEQ 1 If %result% LEQ 10 (
Call :run_wintool_slot %result%
Goto WINTOOLS
)

If %result% EQU 11 (
rem PrintColorAt "{Go 'BACK' to the 'MAIN' menu.}" 14 16 %yellow14% %black0%
Call :make_button "[ <BACK< ]" 14 5 1 10 %yellow14% %btntime% %gray8%
Goto MAIN
)
Goto WINTOOLS

rem *****************
rem begin subroutines
rem *****************

rem *******
rem restart
rem *******

:RESTART
Call :show_me %black0% 0
rem PrintColorAt ">> Restart?" 25 2 %cyan11% %black0%
rem Locate 25 14
choice /C yn /T 10 /D y /M ""
If %errorlevel% EQU 1 Goto yes1
If %errorlevel% EQU 2 Goto MAIN
:yes1
Call :show_me %black0% 0
rem PrintCenter "{Restarting System In %wshutdown% Second(s).}" 12 %yellow14% %red4%
timeout /t %ct2% /nobreak >nul
Call :run_command "shutdown /R /T %wshutdown%" "" >nul
ENDLOCAL
Exit /B %errorlevel%
Goto MAIN

:show_me
mode con:cols=80 lines=25
rem CursorHide
rem ClearColor
rem PaintScreen %1
:redo1
rem GenRandom 15
If %result% EQU 0 Goto redo1
If %result% EQU 4 Goto redo1
If %result% EQU 12 Goto redo1
If %2 EQU 1 (
rem PrintCenter "%title1%" 1 %result% %black0%
rem PrintCenter "{%lmenu% Menu}" 2 %result% %black0%
rem PrintCenter "{Choose An Option From The '%lmenu%' Menu}" 13 %result% %black0%
rem PrintColorAt "{ZoneSoft (c2024-26) zonemaster60@gmail.com}" 25 18 %result% %black0%
)
rem CursorHide
Goto:EOF

rem ****************
rem next_page button
rem ****************

:next_page
rem CursorHide
rem PrintColorAt "[ >>>>>> ]" 25 35 %green10% %black0%
rem MouseCmd 35,25,44,25

If %result% EQU 1 (
rem PrintColorAt "{  NEXT  }" 25 46 %green10% %black0%
Call :make_button "[ >>>>>> ]" 25 35 1 10 %green10% %btntime% %black0%
)
rem CursorHide
Goto:EOF

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
Goto:EOF

:load_addons
Set /a count=0
for /l %%N in (1,1,%max%) do (
Set "addon%%N="
Set "addonlabel%%N="
Set "folder%%N="
)
If exist "%addondir%" (
pushd "%addondir%"
Set "addonroot=!CD!\"
for /f "delims=" %%F in ('dir /b /a-d /on "*.exe" 2^>nul') do (
    If !count! LSS %max% (
        Set /a count+=1
        Set "folder!count!=."
        Set "addon!count!=%%F"
        Set "addonlabel!count!=%%~nxF"
    )
)
for /f "delims=" %%D in ('dir /b /ad /on 2^>nul') do (
    If !count! LSS %max% (
        Set "addonfolder=%%D"
        Set "addonfoldername=%%~nxD"
        If exist "%%D\!addonfoldername!.exe" (
            Set /a count+=1
            Set "folder!count!=!addonfolder!"
            Set "addon!count!=!addonfolder!\!addonfoldername!.exe"
            Set "addonlabel!count!=!addonfoldername!.exe"
        )
    )
)
popd
)
Goto:EOF

:addon_row
Set /a row=%~1+3
If %~1 GTR 8 Set /a row=%~1+6
Set "%~2=%row%"
Goto:EOF

:show_addon_slot
Set "slotid=0%~1"
Set "slotid=%slotid:~-2%"
Set "addonname=!addon%~1!"
Set "addonlabel=!addonlabel%~1!"
If defined addonname if exist "%addondir%\!addonname!" (
rem PrintColorAt "[ADDON-%slotid%] {!addonlabel!}" %~2 5 %cyan11% %black0%
) else (
rem PrintColorAt "[ADDON-%slotid%] {'filename%slotid%'}" %~2 5 %yellow14% %black0%
)
Goto:EOF

:launch_addon_slot
Set "slotid=0%~1"
Set "slotid=%slotid:~-2%"
Set "addonname=!addon%~1!"
Set "addonlabel=!addonlabel%~1!"
If defined addonname if exist "%addondir%\!addonname!" (
Call :make_button "[ADDON-%slotid%] {!addonlabel!}" %~2 5 1 10 %cyan11% %btntime% %black0%
start "" "%addondir%\!addonname!" >nul 2>&1
) else (
Call :make_button "[ADDON-%slotid%] {'filename%slotid%' not found.}" %~2 5 1 10 %yellow14% %btntime% %black0%
)
Goto:EOF

:show_analyze_slot
If %~1 EQU 1 Set "analyzebutton=[  SCAN  ]"
If %~1 EQU 2 Set "analyzebutton=[  CHECK ]"
Set /a analyzerow=%~1+3
rem PrintColorAt "%analyzebutton%" %analyzerow% 5 %cyan11% %black0%
Goto:EOF

:launch_analyze_slot
If %~1 EQU 1 (
Set "analyzebutton=[  SCAN  ]"
Set chkhealth=False
) else (
Set "analyzebutton=[  CHECK ]"
Set chkhealth=True
)
Set /a analyzerow=%~1+3
Call :make_button "%analyzebutton%" %analyzerow% 5 1 10 %cyan11% %btntime% %black0%
Call :show_me %black0% 0
Goto:EOF

:show_repair_slot
Call :repair_meta %~1 repairrow repairbutton repairreset repairupdate
rem PrintColorAt "%repairbutton%" %repairrow% 5 %cyan11% %black0%
Goto:EOF

:launch_repair_slot
Call :repair_meta %~1 repairrow repairbutton repairreset repairupdate
Call :make_button "%repairbutton%" %repairrow% 5 1 10 %cyan11% %btntime% %black0%
Call :show_me %black0% 0
Set "resetbase=%repairreset%"
Set "winupdate=%repairupdate%"
Goto:EOF

:repair_meta
If %~1 EQU 1 (
Set "%~2=4"
Set "%~3=[ REPAIR ]"
Set "%~4=False"
Set "%~5=False"
)
If %~1 EQU 2 (
Set "%~2=5"
Set "%~3=[ REPAIR+]"
Set "%~4=False"
Set "%~5=True"
)
If %~1 EQU 3 (
Set "%~2=6"
Set "%~3=[RSETBASE]"
Set "%~4=True"
Set "%~5=False"
)
Goto:EOF

:show_log_slot
Call :log_meta %~1 logrow logbutton logpath
If exist "%viewer%" (
rem PrintColorAt "%logbutton%" %logrow% 5 %cyan11% %black0%
) else (
rem PrintColorAt "%logbutton%" %logrow% 5 %yellow14% %black0%
)
Goto:EOF

:launch_log_slot
Call :log_meta %~1 logrow logbutton logpath
If exist "%viewer%" (
Call :make_button "%logbutton%" %logrow% 5 1 10 %cyan11% %btntime% %black0%
Call :run_command "start %viewer% %logpath%" "" >nul
) else (
Call :make_button "%logbutton%" %logrow% 5 1 10 %yellow14% %btntime% %black0%
Call :run_command "start notepad.exe %logpath%" "" >nul
)
Goto:EOF

:log_meta
Set /a row=%~1+3
Set "%~2=%row%"
If %~1 EQU 1 (
Set "%~3=[   CBS  ]"
Set "%~4=%CBSlog%"
) else (
Set "%~3=[  DISM  ]"
Set "%~4=%DISMlog%"
)
Goto:EOF

:show_wintool_slot
Call :wintool_meta %~1 wintoolrow wintoolbutton wintoolcmd
rem PrintColorAt "%wintoolbutton%" %wintoolrow% 5 %cyan11% %black0%
Goto:EOF

:run_wintool_slot
Call :wintool_meta %~1 wintoolrow wintoolbutton wintoolcmd
Call :make_button "%wintoolbutton%" %wintoolrow% 5 1 10 %cyan11% %btntime% %black0%
Call :run_command "%wintoolcmd%" "" >nul
Goto:EOF

:wintool_meta
If %~1 EQU 1 (
Set "%~2=4"
Set "%~3=[CLEANMGR]"
Set "%~4=cleanmgr.exe"
)
If %~1 EQU 2 (
Set "%~2=5"
Set "%~3=[EVNTVIEW]"
Set "%~4=eventvwr.msc /s"
)
If %~1 EQU 3 (
Set "%~2=6"
Set "%~3=[ GPEDIT ]"
Set "%~4=gpedit.msc /s"
)
If %~1 EQU 4 (
Set "%~2=7"
Set "%~3=[MSCONFIG]"
Set "%~4=msconfig.exe"
)
If %~1 EQU 5 (
Set "%~2=8"
Set "%~3=[ REGEDIT]"
Set "%~4=regedit.exe"
)
If %~1 EQU 6 (
Set "%~2=9"
Set "%~3=[SERVICES]"
Set "%~4=services.msc"
)
If %~1 EQU 7 (
Set "%~2=10"
Set "%~3=[ TASKMGR]"
Set "%~4=taskmgr.exe /7"
)
If %~1 EQU 8 (
Set "%~2=11"
Set "%~3=[TASKSCHD]"
Set "%~4=taskschd.msc /s"
)
If %~1 EQU 9 (
Set "%~2=12"
Set "%~3=[RBLDICON]"
Set "%~4=Call :rebuild_icon_cache"
)
If %~1 EQU 10 (
Set "%~2=13"
Set "%~3=[ SYSLOG ]"
Set "%~4=Call :open_file_with_viewer %logdir%\%SYSlog% >nul"
)
Goto:EOF

:open_file_with_viewer
Set "targetfile=%~1"
If exist "%viewer%" (
Call :run_command "start %viewer% %targetfile%" "" >nul
) else (
Call :run_command "start notepad.exe %targetfile%" "" >nul
)
Goto:EOF

:show_chkdsk_slot
Call :chkdsk_meta %~1 chkdskrow chkdskbutton chkdskcmd
rem PrintColorAt "%chkdskbutton%" %chkdskrow% 5 %cyan11% %black0%
Goto:EOF

:run_chkdsk_slot
Call :chkdsk_meta %~1 chkdskrow chkdskbutton chkdskcmd
Call :make_button "%chkdskbutton%" %chkdskrow% 5 1 10 %cyan11% %btntime% %black0%
Call :show_me %black0% 0
Call :run_command "%chkdskcmd%" ""
timeout /t %ct2% /nobreak >nul
Goto:EOF

:chkdsk_meta
If %~1 EQU 1 (
Set "%~2=4"
Set "%~3=[READONLY]"
Set "%~4=chkdsk c:"
)
If %~1 EQU 2 (
Set "%~2=5"
Set "%~3=[  SCAN  ]"
Set "%~4=chkdsk c: /scan"
)
If %~1 EQU 3 (
Set "%~2=6"
Set "%~3=[ REPAIR ]"
Set "%~4=chkdsk c: /f"
)
If %~1 EQU 4 (
Set "%~2=7"
Set "%~3=[ SPOTFIX]"
Set "%~4=chkdsk c: /spotfix"
)
If %~1 EQU 5 (
Set "%~2=8"
Set "%~3=[ RECLAIM]"
Set "%~4=chkdsk c: /f /r"
)
Goto:EOF

:CHKDSK
rem run chkdsk
Set lmenu=CHKDSK
Call :show_me %black0% 1
rem PrintColorAt "{ %lmenu% }" 3 5 %gray7% %black0%
for /l %%N in (1,1,5) do Call :show_chkdsk_slot %%N
rem PrintColorAt "[ <BACK< ]" 9 5 %yellow14% %gray8%

rem *************
rem button matrix
rem *************

rem MouseCmd 5,4,14,4 5,5,14,5 5,6,14,6 5,7,14,7 5,8,14,8 5,9,14,9

If %result% GEQ 1 If %result% LEQ 5 (
Call :run_chkdsk_slot %result%
If %result% LEQ 2 (
Goto CHKDSK
) else (
Goto RESTART
)
)

If %result% EQU 6 (
rem PrintColorAt "{Go 'BACK' to the 'MAIN' menu.}" 9 16 %yellow14% %black0%
Call :make_button "[ <BACK< ]" 9 5 1 10 %yellow14% %btntime% %gray8%
Goto MAIN
)
Goto CHKDSK

rem *********************************
rem run a command with error checking
rem *********************************

:run_command
rem CursorHide
Set "cmdToRun=%~1"
Set "description=%~2"
If not defined description Set "description=%cmdToRun%"

rem PrintColorAt "> [%DATE%-%TIME%]" 4 2 %green10% %black0%
rem PrintColorAt "> {INFO} %description%" 5 2 %result% %black0%
rem PrintCenter "{Do Not Close This Window, It Will Close When ALL Tasks Are Done.}" 7 %yellow14% %red4%
rem PrintReturn
rem PrintReturn
rem ChangeColor %result% %black0%

%cmdToRun%

rem PrintReturn
rem PrintColorAt "> [%DATE%-%TIME%]" 24 2 %red12% %black0%
rem Handle exit codes
If %ERRORLEVEL% NEQ 0 (
rem PrintColorAt "> {ERROR} An error has occurred! Error=%ERRORLEVEL%" 25 2 %red12% %black0%
timeout /t %ct2% /nobreak >nul
Echo [%DATE%-%TIME%]-{%description%}-[Error=%ERRORLEVEL%] >> %logdir%\%SYSlog%
exit /b %ERRORLEVEL%
) else (
rem PrintColorAt "> {SUCCESS} Operation complete." 25 2 %green10% %black0%
Echo [%DATE%-%TIME%]-{%description%}-[Error=%ERRORLEVEL%] >> %logdir%\%SYSlog%
)
rem CursorHide
Goto:EOF

:rebuild_icon_cache
Call :run_command "taskkill /f /im explorer.exe" "" >nul
cd /d %userprofile%\AppData\Local\Microsoft\Windows\Explorer
attrib -h thumbcache*
If exist thumbcache* del /f thumbcache*
cd /d %userprofile%\AppData\Local\
attrib -h iconcache*
if exist iconcache* del /f iconcache*
cd /d C:\Windows
Call :run_command "start C:\Windows\explorer.exe" "" >nul
timeout /t %ct2% /nobreak >nul
Call :run_command "shutodwn /R /T %wshutdown%" "" >nul
ENDLOCAL
Exit /B %errorlevel%
Goto:EOF

rem ***************
rem end subroutines
rem ***************
