General
=======

MainMenu
========

[ANALYZE] -> Go to the ANALYZE menu -> [SCAN] -> Scan the windows image for corruption
									   [CHECK] -> Check the windows image for corruption

[REPAIR] -> Go to the REPAIR menu -> [REPAIR] -> Repair the windows image
									 [REPAIR+] -> Repair the windows image using windows update
									 [BASELINE] -> Repair and Reset the component store to baseline
									 
[INFO] -> Info about your system -> [INFO1] -> explains the main menu of items
									[INFO2] -> explains the right-side [STATUS] bar
									[INFO3] -> shows your system info

[WINTOOLS] -> Go to the WINTOOLS menu -> [CLEANMGR] -> Run the windows disk clean manager
										 [EVNTVIEW] -> Run this tool for viewing system events
										 [MSCONFIG] -> enable/disable startup items
										 [NOTEPAD] -> Use windows notepad for viewing text files
										 [REGEDIT] -> Use this with CAUTION, edit registry items
										 [SERVICES] -> Configure system services to your needs
										 [TASKMGR] -> Monitor processes and close them if neccessary
										 [TASKSCHD] -> create, edit, and run windows tasks.

[EXIT] -> Exit the program

Status
======

{ STATUS }
{ ------ } -> analyze status -> [DONE] or [SKIP] (if you go directly to repairing)
{ ------ } -> repair status -> [DONE] will reboot (y/n) choice
[ OPTION ]
[ ADDONS ] -> [ADDONS] button
{U:XX|A:XX} -> addon status {U:XX=used slots A:XX=Availible slots}

Addons
======

1. In order to use the 'ADDONS menu' you must first create a blank 'addons.txt'

2. Place the 'addons.txt' next to your Handy2ClickAutoFixer.exe.
(This will create the 'addons\' folder)

3. You can edit this text file and add just the filenames. (not the .exe)

like this:
	filename
	or...
	folder\filename

4. Put your '.exe' files in the the 'addons\' folder. (A maximum of 16 addons.)

There is a status bar below the [ADDONS] button
{U:XX|A:XX} -> Used : XX addons (slots) Available : XX Addons (slots)

5. Suggested apps for use in ADDON slots

Dism++
DisplayTool
SFCFix
TweakingRegistryBackup
UpdateFixer_Portable

Other
=====

1. 'CHKDSK /scan' can be run from some menus simply
	by pressing '0' on your keyboard.
