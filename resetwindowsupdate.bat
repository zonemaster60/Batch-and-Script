@echo off
net stop wuauserv
net stop bits
net stop cryptsvc
Ren %systemroot%SoftwareDistributionSoftwareDistribution.bak
Ren %systemroot%system32catroot2catroot2.bak
net start wuauserv
net start bits
net start cryptsvc
pause
exit