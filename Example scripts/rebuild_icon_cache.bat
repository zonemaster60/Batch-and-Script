@echo off
pushd "%~dp0"

taskkill /f /im explorer.exe
cd /d %userprofile%\AppData\Local\Microsoft\Windows\Explorer
attrib -h thumbcache*
if exist thumbcache* del /f thumbcache*
cd /d %userprofile%\AppData\Local\
attrib -h iconcache*
if exist iconcache* del /f iconcache*
start C:\Windows\explorer.exe
shutdown /r /t 10
exit /b