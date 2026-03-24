General
=======

MainMenu
========

[ANALYZE] -> Go to the ANALYZE menu -> [  SCAN  ] -> Scan the windows image for corruption.
									   			[  CHECK ] -> Check the windows image for corruption.

[REPAIR] -> Go to the REPAIR menu -> [ REPAIR ] -> Repair the windows image.
									 			 [ REPAIR+] -> Repair the windows image using windows update.
									 			 [BASELINE] -> Repair and Reset the component store to baseline.
									 
[INFO] -> Info about your system -> [  INFO1 ] -> explains the main menu of items.
												[  INFO2 ] -> explains the right-side [STATUS] bar.
												[  INFO3 ] -> shows your system info.

[VIEWLOGS] -> View the 'CBS' and 'DISM' system logs.

[WINTOOLS] -> Go to the WINTOOLS menu -> [ CLEANMGR] -> Run the windows disk clean manager.
										 			  [ EVNTVIEW] -> Run this tool for viewing system events.
										 			  [  GPEDIT ] -> Edit Group policies.
										 			  [ MSCONFIG] -> enable/disable startup items.
										 			  [ REGEDIT ] -> Use this with CAUTION, edit registry items.
										 			  [ SERVICES] -> Configure system services to your needs.
										 			  [ TASKMGR ] -> Monitor processes and close them if neccessary.
										 			  [ TASKSCHD] -> create, edit, and run windows tasks.

[EXIT] -> Exit the program.

Status
======

{ STATUS }
{ ------ } -> analyze status -> DONE or SKIP (if you go directly to repairing)
{ ------ } -> repair status -> DONE will reboot (y/n) choice.
[ OPTION ]
[ ADDONS ] -> Go to the 'ADDONS' menu.
{U:XX|A:XX} -> addon status {U:XX=used | A:XX=Availible}
[ README ] -> View the 'readme' using your own external viewer/notepad.
[ CHKDSK ] -> Go to the 'CHKDSK' menu.

Addons
======

1. Put your single '.exe' files or 'folders\filename.exe' in the the 'addons\' folder.
(A maximum of 16 addons is allowed.)

There is a status bar below the [ADDONS] button
{U:XX|A:XX} -> Used : XX addons (slots) Available : XX Addons (slots)

2. Suggested apps for use in ADDON slots

Dism++ -> https://github.com/Chuyu-Team/Dism-Multi-language/releases
DisplayTool -> https://display-tool.com/
SFCFix -> https://www.sysnative.com/forums/downloads/sfcfix/
TweakingRegistryBackup -> https://www.majorgeeks.com/files/details/tweaking_com_registry_backup_portable.html
UpdateFixer_Portable -> https://winupdatefixer.com

Other
=====

1. If you have your own external viewer tool you can place that next
   to the '.exe' in the install folder. It must be named 'viewer.exe',
   If you don't it will view the file in Windows Notepad.
