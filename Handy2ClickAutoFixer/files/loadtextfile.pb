﻿EnableExplicit

; Variable definitions
Define filename.s, content.s, line.s

Procedure Exit()
  Define Req = MessageRequester("Exit", "Do you want to exit now?", #PB_MessageRequester_YesNo | #PB_MessageRequester_Info)
  If Req = #PB_MessageRequester_Yes
    End
  EndIf
EndProcedure

; Create the main window
If OpenWindow(0, 100, 100, 800, 600, "TextViewer", #PB_Window_SystemMenu | #PB_Window_SizeGadget)

  ; Build File menu
  CreateMenu(0, WindowID(0))
  MenuTitle("File")
  MenuItem(1, "Open")
  MenuBar()
  MenuItem(2, "Exit")

  ; Editor gadget with scrollbars and read-only mode
  EditorGadget(0, 10, 10, 780, 550, #PB_Editor_WordWrap | #PB_Editor_ReadOnly)

  ; Load file if provided via command-line argument
  If ProgramParameter(0)
    filename = ProgramParameter(0)
    If ReadFile(1, filename, #PB_UTF8)
      content = ""
      While Not Eof(1)
        line = ReadString(1, #PB_File_IgnoreEOL)
        content + line + #CRLF$
      Wend
      CloseFile(1)
      SetGadgetText(0, content)
      SetWindowTitle(0, "TextViewer - " + filename)
    Else
      MessageRequester("Error", "Unable to open file from argument.", #PB_MessageRequester_Error)
      End
    EndIf
  EndIf

  Repeat
    Define Event = WaitWindowEvent()
    Select Event

      Case #PB_Event_Menu
        Select EventMenu()
        
          Case 1  ; Open file
            filename = OpenFileRequester("Open text file", "", "Text files|*.txt|All files|*.*", 0)
            If filename
              If ReadFile(1, filename, #PB_UTF8)
                content = ""
                While Not Eof(1)
                  line = ReadString(1, #PB_File_IgnoreEOL)
                  content + line + #CRLF$
                Wend
                CloseFile(1)
                SetGadgetText(0, content)
                SetWindowTitle(0, "TextViewer - " + filename)
              Else
                MessageRequester("Error", "Unable to open the file.", #PB_MessageRequester_Error)
                End
              EndIf
            EndIf

          Case 2  ; Exit
            Exit()

        EndSelect

      Case #PB_Event_CloseWindow
        Exit()

    EndSelect
  ForEver

EndIf

; IDE Options = PureBasic 6.21 (Windows - x64)
; CursorPosition = 39
; FirstLine = 19
; Folding = -
; Optimizer
; EnableThread
; EnableXP
; DPIAware
; DllProtection
; UseIcon = loadtextfile.ico
; Executable = ..\loadtextfile.exe
; IncludeVersionInfo
; VersionField0 = 1,0,0,0
; VersionField1 = 1,0,0,0
; VersionField2 = ZoneSoft
; VersionField3 = loadtextfile.exe
; VersionField4 = 1.0.0.0
; VersionField5 = 1.0.0.0
; VersionField6 = Loads and displays text files
; VersionField8 = loadtextfile.exe
; VersionField9 = David Scouten
; VersionField13 = zonemaster@yahoo.com