@echo off
net stop winmgmt
winmgmt /resetrepository
net start winmgmt