EnableExplicit

Structure LinkData
  gadget.i
  url.s
EndStructure

Global NewList links.LinkData()
Global linkHeight = 25
Global padding = 10

Procedure.i CountLines(FileName.s)
  Protected count = 0
  If ReadFile(1, FileName)
    While Not Eof(1)
      If Trim(ReadString(1)) <> ""
        count + 1
      EndIf
    Wend
    CloseFile(1)
  EndIf
  ProcedureReturn count
EndProcedure

Procedure LoadWebsites(FileName.s)
  Protected y = padding, gID
  Protected linkCount = CountLines(FileName)
  If linkCount = 0
    MessageRequester("Info", "No valid website links found.")
    End
  EndIf

  Protected winHeight = (linkHeight + 5) * linkCount + padding * 2
  OpenWindow(0, 200, 200, 400, winHeight, "Useful Website Links", #PB_Window_SystemMenu | #PB_Window_ScreenCentered)

  If ReadFile(0, FileName)
    While Not Eof(0)
      Protected site.s = Trim(ReadString(0))
      If site <> ""
        gID = HyperLinkGadget(#PB_Any, 10, y, 380, linkHeight, site, RGB(0, 0, 255), #PB_HyperLink_Underline)
        AddElement(links())
        links()\gadget = gID
        links()\url = site
        y + linkHeight + 5
      EndIf
    Wend
    CloseFile(0)
  Else
    MessageRequester("Error", "Could not open the file: " + FileName)
    End
  EndIf
EndProcedure

Procedure HandleEvents()
  Protected event
  Repeat
    event = WaitWindowEvent()
    If event = #PB_Event_Gadget
      ForEach links()
        If EventGadget() = links()\gadget
          RunProgram(links()\url)
        EndIf
      Next
    EndIf
  Until event = #PB_Event_CloseWindow
EndProcedure

LoadWebsites("websites.list")
HandleEvents()

; IDE Options = PureBasic 6.21 (Windows - x64)
; CursorPosition = 42
; FirstLine = 42
; Folding = -
; Optimizer
; EnableThread
; EnableXP
; DPIAware
; DllProtection
; UseIcon = loadwebsites.ico
; Executable = loadwebsites.exe