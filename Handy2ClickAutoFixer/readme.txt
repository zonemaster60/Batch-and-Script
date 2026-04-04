General
=======

MainMenu
========

[ANALYZE] -> Go to the ANALYZE menu -> [  SCAN  ] -> Scan the windows image for corruption. (SFC/DISM)
									   			[  CHECK ] -> Check the windows image for corruption. (SFC/DISM)

[REPAIR] -> Go to the REPAIR menu -> [ REPAIR ] -> Repair the windows image. (SFC/DISM)
									 			 [ REPAIR+] -> Repair the windows image using windows update. (SFC/DISM)
									 			 [RSETBASE] -> Repair and Reset the component store to baseline. (SFC/DISM)
									 
[INFO] -> Info about your system -> [  INFO1 ] -> explains the left-side {main menu} of items.
												[  INFO2 ] -> explains the right-side { STATUS } bar.
												[  INFO3 ] -> shows your system info.

[VIEWLOGS] -> View the 'CBS'/'DISM' system logs.

[WINTOOLS] -> Go to the WINTOOLS menu -> [CLEANMGR] -> Run the windows disk clean manager.
										 			  [EVNTVIEW] -> Run this tool for viewing system events.
										 			  [ GPEDIT ] -> Edit Group policies.
										 			  [MSCONFIG] -> enable/disable startup items.
										 			  [ REGEDIT] -> Use this with CAUTION, edit registry items.
										 			  [SERVICES] -> Configure system services to your needs.
										 			  [ TASKMGR] -> Monitor processes and close them if neccessary.
										 			  [TASKSCHD] -> create, edit, and run windows tasks.
										 			  [RBLDICON] -> NOT a Windows Tool. (resets iconcache and reboots system)
										 			  [ SYSLOG ] -> NOT a Windows Tool. (view the 'Handy2ClickAutoFixer.log')		
[EXIT] -> Exit the program.

Status
======

{ STATUS }
{ ------ } -> Analyze status -> [  DONE  ] (completed) or [  SKIP  ] (Go directly to [ REPAIR ])
{ ------ } -> Repair status -> [  DONE  ] will reboot (y/n) choice.
[ OPTION ]
[ ADDONS ] -> Go to the 'ADDONS' menu.
{U:XX|A:XX} -> [ ADDONS ] status {U:XX = Used | A:XX = Availible}
[ README ] -> View the 'readme.txt' using your own external viewer/notepad.
[ CHKDSK ] -> Go to the 'CHKDSK' menu.

Addons
======

1. Put your single '.exe' files or 'folders\filename.exe' in the the 'addons\' folder.
(A maximum of 16 addons is allowed.)

There is a status bar below the [ADDONS] button.
{U:XX|A:XX} -> Used: XX addons (slots) Available: XX Addons (slots)

2. Suggested apps for use in [ADDONS] slots.

HandyWSERTool.exe -> https://github.com/zonemaster60/PureBasic/
SFCFix.exe -> https://www.sysnative.com/forums/downloads/sfcfix/
Viewer.exe -> https://github.com/zonemaster60/PureBasic/
WindowsUpdateRepair.exe -> https://github.com/zonemaster60/PureBasic/
Winslopr.exe -> https://github.com/builtbybel/Winslopr/

Other
=====

1. If you have your own external viewer tool you can place that next
   to the '.exe' in the install folder. It must be named 'viewer.exe'.
   If you don't have one, it will be viewed by default in Windows Notepad.
