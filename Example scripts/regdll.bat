@echo off

for %1 in (C:\Windows\System32\*.dll) do regsvr32 /s %1