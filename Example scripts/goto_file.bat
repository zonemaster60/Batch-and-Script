@setlocal enableextensions & "C:/users/zonem/AppData/Local/Python/bin/python.exe" -x "%~f0" %* & goto :EOF 

# Looks for a file on disk and take me there
import sys
import os
if len(sys.argv) == 2:
    for root, dirnames, filenames in os.walk(os.getcwd()):
        for filename in filenames:
            if filename == sys.argv[1]:
                print 'TAKING YOU TO: %s'%root
                os.system('cls')
                os.system('title %s'%root)
                os.system('cd %s'%root)
                quit()