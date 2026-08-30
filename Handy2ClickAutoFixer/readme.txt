General
=======

MainMenu
========

[ANALYZE] -> Go to the ANALYZE menu -> [  SCAN  ] -> Scan the windows image for corruption. (SFC/DISM)
									   			[  CHECK ] -> Check the windows image for corruption. (SFC/DISM)

[REPAIR] -> Go to the REPAIR menu -> [ REPAIR ] -> Repair the windows image. (SFC/DISM)
									 			 [ REPAIR+] -> Repair the windows image using windows update. (SFC/DISM)
									 			 [RSETBASE] -> Repair and Reset the component store to baseline. (SFC/DISM)
									 
[HELP] -> Help and Information about your system -> [  HELP Page 1 ] -> explains the left-side {main menu} of items.
																	 [  HELP Page 2 ] -> explains the right-side { STATUS } bar.

[VIEWLOGS] -> View the system logs -> [   CBS  ] -> shows the log for SFC repairs.
												  [  DISM  ] -> shows the log for DISM repairs.
												  [ SYSLOG ] -> shows the log for Handy2ClickAutoFixer.

[WINTOOLS] -> Go to the WINTOOLS menu -> [CLEANMGR] -> Run the windows disk clean manager.
										 			  [EVNTVIEW] -> Run this tool for viewing system events.
										 			  [ GPEDIT ] -> Edit Group policies.
										 			  [MSCONFIG] -> enable/disable startup items.
										 			  [ REGEDIT] -> Use this with CAUTION, edit registry items.
										 			  [SERVICES] -> Configure system services to your needs.
										 			  [ TASKMGR] -> Monitor processes and close them if neccessary.
										 			  [TASKSCHD] -> create, edit, and run windows tasks.

[ABOUT] -> View the 'ABOUT' dialog.
													  [ ABOUT Page 2 ] -> shows your system info.
													  [ ABOUT Page 3 ] -> shows installed system components
													  
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
