EnableExplicit

Structure LinkData
  gadget.i
  url.s
EndStructure

Global NewList links.LinkData()
Global linkHeight = 25
Global padding = 10
Global scrollID, searchGadget

Procedure RefreshLinks(filter.s)
  Protected y = padding
  ForEach links()
    If FindString(LCase(links()\url), LCase(filter))
      HideGadget(links()\gadget, #False)
      ResizeGadget(links()\gadget, #PB_Ignore, y, #PB_Ignore, #PB_Ignore)
      y + linkHeight + 5
    Else
      HideGadget(links()\gadget, #True)
    EndIf
  Next
EndProcedure

Procedure LoadWebsites(FileName.s)
  Protected y = padding, gID, site.s

  If ReadFile(0, FileName)
    While Not Eof(0)
      site = Trim(ReadString(0))
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

  CloseGadgetList()
EndProcedure

Procedure HandleEvents()
  Protected event
  Repeat
    event = WaitWindowEvent()
    Select event
      Case #PB_Event_Gadget
        Select EventGadget()
          Case searchGadget
            RefreshLinks(GetGadgetText(searchGadget))
          Default
            ForEach links()
              If EventGadget() = links()\gadget
                RunProgram(links()\url)
              EndIf
            Next
        EndSelect
    EndSelect
  Until event = #PB_Event_CloseWindow
EndProcedure

; Setup window and GUI
Define displayHeight = 400, totalScrollHeight = 1000

OpenWindow(0, 200, 200, 440, displayHeight + 60, "Useful Website Links", #PB_Window_SystemMenu | #PB_Window_ScreenCentered)
searchGadget = StringGadget(#PB_Any, 10, 10, 420, 25, "Search...", #PB_String)
scrollID = ScrollAreaGadget(0, 10, 40, 420, displayHeight, 400, totalScrollHeight, 10)
LoadWebsites("websites.list")
HandleEvents()
; IDE Options = PureBasic 6.21 (Windows - x64)
; CursorPosition = 75
; FirstLine = 48
; Folding = -
; Optimizer
; EnableThread
; EnableXP
; DPIAware
; DllProtection
; UseIcon = loadwebsites.ico
; Executable = loadwebsites.exe