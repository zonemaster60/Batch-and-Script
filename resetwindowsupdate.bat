@echo off
net stop wuauserv
net stop bits
net stop cryptsvc
if exist %systemroot%\SoftwareDistibution Ren %systemroot%\SoftwareDistribution SoftwareDistribution.bak
if exist %systemroot%\system32\catroot2 Ren %systemroot%\system32\catroot2 catroot2.bak
net start cryptsvc
net start bits
net start wuauserv
pause
exit /b 0