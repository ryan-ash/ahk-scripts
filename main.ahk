;========================== hints ==========================

; # - Win
; ! - Alt
; ^ - Control
; + - Shift

; Run, %A_WorkingDir%\shortcuts\shortcutName.lnk - shortcuts in userScripts
; Sleep, ms

; log: 
;  OutputDebug, Text
;  MsgBox, Text


+^!F12::
    KeyHistory
    return

; To learn vk codes press [Alt+Ctrl+Shift+F12] 

; get two monitors' dimensions
; SysGet, m2, Monitor, 2
; SysGet, m1, Monitor, 1
; m1Width := m1Right - m1Left
; m1DoubleWidth := m1Width * 2
; m1Height := m1Bottom - m1Top
; m1DoubleHeight := m1Height * 2
; m2DoubleWidth := (m2Right - m2Left) * 2
; m2DoubleHeight := (m2Bottom - m2Top) * 2


; TEMP-HOTKEY
;  +F3::
;      ;  sendinput, {#}
;      Send, {#}612{/}11{*}
;      return


;========================== key reader ==========================

#Installkeybdhook
#Persistent 

;========================== spotify browse gaming ========================== ; TODO: open gaming section on spotify

;========================== stream timer ==========================
!^#F12::
    Run, %A_WorkingDir%\shortcuts\StreamTimer.lnk
    Sleep 1000
    Send {F11}
    return


;========================== capture ==========================

;  PrintScreen::
    ;  Send !^+{vk50}
    ;  return

; TODO: debug
^PrintScreen::
    Run, %A_WorkingDir%\shortcuts\obs.lnk
    Sleep 1000
    Send {Click 1440 540 Screen}
    Sleep 1000
    Send {Alt Down}{Ctrl Down}{Shift Down}{vkbb}{Shift Up}{Ctrl Up}{Alt Up}
    return

;========================== dnd toggle ========================== TODO: rewrite

;  NumLock::
    ;  Send #{vk44}
    ;  Sleep 500
    ;  Send !#{Right}
    ;  Sleep 500
    ;  Send !#{Left}
    ;  return

;========================== launcher ==========================

; RAlt::
    ;     Send #{vk52}
    ;     return

;========================== notes ==========================
  
; on
;  Numpad0 & NumpadDot::
;  NumpadIns & NumpadDel::
    ;  IfWinExist, Sticky Notes
        ;  WinActivate ;
    ;  else {
        ;  Send {LWin}
        ;  Sleep 500
        ;  Send {s}{t}{i}
        ;  Sleep 100
        ;  Send {Enter}
    ;  }
    ;  return

; off
;  NumpadDot & Numpad0::
;  NumpadDel & NumpadIns::
    ;  WinClose, Sticky Notes
    ;  return

;======================== wheel contol ========================

^!+WheelUp::
    N := 15
    Loop %N% {
        Sleep 30
        Send {WheelUp}
    }
    return

^!+WheelDown::
    N := 15
    Loop %N% {
        Sleep 30
        Send {WheelDown}
    }
    return

+WheelDown::
    SoundSet, -10
    return

+WheelUp::
    SoundSet, +10
    return
    
;  ^~WheelUp::   
;      Send ^{Up}
;      return

;  #WheelUp::
;      Send #{Up}
;      return

;  ^~WheelDown::
;      Send ^{Down}
;      return

;  #WheelDown::
;      Send #{Down}
;      return    

;======================== mousebtn4\5 ========================
;  CtrlPressedFromMouse := 0
;  AltPressedFromMouse := 0

;  XButton2::
    ;  Send {Ctrl Down}
    ;  CtrlPressedFromMouse := 1
    ;  gosub MouseCtrlCoroutine
    ;  return
;  XButton1::
    ;  Send {Alt Down}
    ;  AltPressedFromMouse := 1
    ;  gosub MouseAltCoroutine
    ;  return

;  MouseCtrlCoroutine:
    ;  if GetKeyState("XButton2","p") {
        ;  sleep 100
;          gosub MouseCtrlCoroutine
;      }
;      if (CtrlPressedFromMouse == 1) {
;          CtrlPressedFromMouse := 0
;          Send {Ctrl Up}
;      }
;      return
;  MouseAltCoroutine:
;      if GetKeyState("XButton1","p") {
;          sleep 100
;          gosub MouseAltCoroutine
;      }
;      if (AltPressedFromMouse == 1) {
;          AltPressedFromMouse := 0
;          Send {Alt Up}
;      }
;      return

;======================== mouse play\pause ========================

;  XButton1Used := 0
;  XButton2Used := 0

;  ~XButton1::
;      XButton1Used := 1
;      gosub CheckForPlayPause
;      return
;  XButton1 UP::
;      XButton1Used := 0
;      return
;  ~XButton2::
;      XButton2Used := 1
;      gosub CheckForPlayPause
;      return
;  XButton2 UP::
;      XButton2Used := 0
;      return

;;;;;;;;  TODO: DEBUG

;  MButtonCooldown := 0
;  MButtonDelta := 500
;  MButtonMax := 500
;  MButtonCoroutineStep := 100

;  ~MButton::
;      MButtonCooldown := MButtonCooldown + MButtonDelta
;      gosub CheckForPlayPause
;      gosub MButtonCooldownCoroutine
;      return

;  MButtonCooldownCoroutine:
;      if (MButtonCooldown <= 0)
;          return
;      Sleep %MButtonCoroutineStep%
;      MButtonCooldown := MButtonCooldown - MButtonCoroutineStep
;      gosub MButtonCooldownCoroutine
;      return

;  CheckForPlayPause:
;      if (XButton1Used == 1 && XButton2Used == 1 || MButtonCooldown > MButtonMax) {
;          Send ^!{Home}
;          XButton1Used := 0
;          XButton2Used := 0
;          MButtonCooldown := 0
;      }
;      return

;======================== window killer ========================

;  rButtonUsed := 0
;  middleFakeUsed := 0
;  RButton::
    ;  if (CtrlPressedFromMouse == 0 && AltPressedFromMouse == 0)
        ;  rButtonUsed := 1
    ;  else if (CtrlPressedFromMouse == 1)
        ;  Send ^{Right}
    ;  else if (AltPressedFromMouse == 1)
        ;  Send !{Right}
    ;  return

;  ~LButton::
    ;  if (rButtonUsed) {
        ;  Send ^{vk57}
        ;  middleFakeUsed := 1
    ;  } else if (CtrlPressedFromMouse == 1)
        ;  Send ^{Left}
    ;  else if (AltPressedFromMouse == 1)
        ;  Send !{Left}
    ;  return

;  RButton Up::
    ;  if (middleFakeUsed == 0 && !CtrlPressedFromMouse && !AltPressedFromMouse) {
        ;  Send {RButton}
    ;  }
    ;  rButtonUsed := 0
    ;  middleFakeUsed := 0
    ;  return

;======================== backdrop ========================
        
^MButton::
    Send {F11}
    return

^+MButton::
^F11::
    Send {F11}
+MButton::
ScrollLock::
Insert::

    ; Cover/uncover backdrop with GUI (toggle).
    ; Get the currently active window to put on top. Note that alt-tab works normally. 

    ifwinnotexist, Backdrop
        gosub Drape
    else
        gosub RestoreNormalcy
    return

Drape:

    SetScrollLockState, on

    SysGet, MonitorCount, MonitorCount

    WinHide, ahk_class Shell_TrayWnd

    if (MonitorCount > 1)
        gosub DrapeTwoMonitors
    else
        gosub DrapeOneMonitor
    return

DrapeTwoMonitors:

    SysGet, m2, Monitor, 2          ; Get data on second monitor size.
    SysGet, m1, Monitor, 1
    drapeTop := m1Top < m2Top ? m1Top : m2Top
    drapeBottom := m1Bottom > m2Bottom ? m1Bottom : m2Bottom
    drapeHeight := drapeBottom - drapeTop
    drapeLeft := m1Left < m2Left ? m1Left : m2Left
    drapeRight := m1Right > m2Right ? m1Right : m2Right
    drapeWidth := drapeRight - drapeLeft

    WinGetTitle, FocusWin, A
    WinHide, ahk_class Shell_SecondaryTrayWnd
    
    Gui 2:-Caption -border +ToolWindow                              ; No title, no taskbar icon.
    Gui 2:Color, 0                                                  ; Blackout blinds. 

    Gui 2:Show, x%drapeLeft% y%drapeTop% h%drapeHeight% w%drapeWidth%, Backdrop ; 1st monitor on the left 

    WinActivate %FocusWin%                                          ; Move the active window to top.
    winset, alwaysontop, on 
    return

DrapeOneMonitor:

    SysGet, m1, Monitor, 1
    m1Width := m1Right - m1Left
    m1Height := m1Bottom - m1Top

    WinGetTitle, FocusWin, A
    
    Gui 2:-Caption -border +ToolWindow                              ; No title, no taskbar icon.
    Gui 2:Color, 0                                                  ; Blackout blinds. 
    Gui 2:Show, x0 y0 h%m1Height% w%m1Width%, Backdrop 
    WinActivate %FocusWin%                                          ; Move the active window to top.
    winset, alwaysontop, on 
    return

RestoreNormalcy:

    SetScrollLockState, off
    Gui 2:Destroy                                               ; Remove blinds. 
    winshow, ahk_class Shell_TrayWnd                            ; Show tray.
    winshow, ahk_class Shell_SecondaryTrayWnd
    return

;======================== player control ========================
; TODO: Write true is playing detection and LED support

IsPlaying := 0
;  SetStoreCapslockMode = On

CapsLock::
    ; Send, {CapsLock}
    gosub PlayStop
    return

PlayStop:
    if (IsPlaying == 1) {
        gosub Stop
    } else {
        gosub Play
    }

    return

Play:
    ; Send ^!{Up} ; -> comment out if / when toastify is fixed
    Send {Media_Play_Pause}
    ; SetCapsLockState, AlwaysOn
    IsPlaying := 0
    return

Stop:
    ; Send ^!{Up} ; -> comment out if / when toastify is fixed
    Send {Media_Play_Pause}
    ; SetCapsLockState, AlwaysOff
    IsPlaying := 1
    return


;======================== ctrl+s -> alt+tab -> f5 -> alt+tab ========================

!F5::
!^vk53::
    Send {Shift Down}{Shift Up}
    Sleep 100
    Send {Ctrl Down}{vk53}{Ctrl Up}
    Sleep 100
    Send !{Tab}
    Sleep 100
    Send {F5}
    Sleep 100
    Send !{Tab}        
    return

;======================== hide \ show navigation pane ========================

F4::
    Send {Shift Down}{Shift Up}
    Sleep 100
    Send {LAlt Down}
    ;  Sleep 1000
    Send {vk56}
    ;  Sleep 500
    Send {vk4e}
    ;  Sleep 500
    Send {LAlt Up}{Space}
    return
        


;======================== change Audio Playback Device ========================

^vk61::
    SwitchToDevice("Speakers")
    return
^vk62::
    SwitchToDevice("Headset")
    return
^vk63::
    SwitchToDevice("HDMI")
    return

SwitchToDevice(Device)
{
    Run nircmd setdefaultsounddevice %Device%
    soundToggleBox(Device)
}

; Display sound toggle GUI
soundToggleBox(Device)
{
    IfWinExist, soundToggleWin
    {
        Gui, destroy
    }
    
    Gui, +ToolWindow -Caption +0x000000 +alwaysontop
    Gui, Add, text, x5 y5, %Device%
    SysGet, screenx, 0
    SysGet, screeny, 1
    xpos:=screenx-60
    ypos:=screeny-25
    Gui, Show, NoActivate x%xpos% y%ypos% h25 w60, soundToggleWin
    
    SetTimer,soundToggleClose, 2000
}
soundToggleClose:
    SetTimer,soundToggleClose, off
    Gui, destroy
Return


;======================== move windows between monitors ========================
;======================== TODO: DEBUG ========================

NumpadLeft::
    Send {LWin Down}{LAlt Down}{vk25}{LAlt Up}{LWin Up}
    return
NumpadRight::
    Send {LWin Down}{LAlt Down}{vk27}{LAlt Up}{LWin Up}
    return
NumpadEnd::
    Send {LWin Down}{Ctrl Down}{vk25}{Ctrl Up}{LWin Up}
    return
NumpadPgDn::
    Send {LWin Down}{Ctrl Down}{vk27}{Ctrl Up}{LWin Up}
    return


;======================== connect bluetooth devices ========================

#!vk43::
    Run, D:\Work\git\win10-bluetooth-headphones\ConnectBluetooth.lnk, D:\Work\git\win10-bluetooth-headphones
    return

#vk43::
    gosub OpenConnectMenu
    return

; NOTE: YOU NEED TO PLACE CONNECT FIRST AND CLEANUP UNRELATED DEVICES FOR THIS TO WORK
OpenConnectMenu:
    Send {LWinDown}{vk41}{LWinUp}
    Sleep 200
    Send {Tab}
    Send {Tab}
    Sleep 200
    Send {Enter}
    Sleep 1500
    Send {Tab}
    return


;======================== close all explorer windows ========================

#+^vk51::
    CloseExplorerWindows()

    ; workaround to make sure all windows are closed; for some reason, it tends to leave 1 or 2 on the first pass
    Sleep 500
    CloseExplorerWindows()
    return

CloseExplorerWindows()
{
    for wb in ComObjCreate("Shell.Application").Windows
        wb.quit
}


;======================== pause / unpause youtube ========================

~vk13::
    SetTitleMatchMode, RegEx
    WinGet, active_id, ID, A
    match_pattern:=".*- YouTube"
    if WinExist(match_pattern) {
        ControlClick, x200 y200, %match_pattern%
        WinActivate, ahk_id %active_id%
    }
    SetTitleMatchMode, 1
    return


;======================== tv control ========================

#!^2::
#!^vk62::
    ; MsgBox, "TV"
    Run, "D:\Distrib\Monitor Profile Switcher\MonitorSwitcher.exe" -load:C:\Users\scarl\AppData\Roaming\MonitorSwitcher\Profiles\TV.xml, , Hide,
    return

#!^1::
#!^vk61::
    ; MsgBox, "Core"
    Run, "D:\Distrib\Monitor Profile Switcher\MonitorSwitcher.exe" -load:C:\Users\scarl\AppData\Roaming\MonitorSwitcher\Profiles\Core.xml, , Hide,
    return


;======================== window control ========================

#vk64::
    Send {LWin Down}{Left}{Left}{Left}{Up}{Up}{Up}{LWin Up}
    return

#vk66::
    Send {LWin Down}{Right}{Right}{Right}{Up}{Up}{Up}{LWin Up}
    return


;======================== language control ========================

; TODO: better handle cases when it's not just a single quick key press
; TODO: better detect games overall, not just select titles

SetInputLang(Lang)
{
    WinExist("A")
    ControlGetFocus, CtrlInFocus
    PostMessage, 0x50, 0, % Lang, %CtrlInFocus%
}

#If !WinActive(ahk_exe destiny2.exe)
~LShift::
    ShiftStartTime := A_TickCount
    KeyWait, LShift
    ShiftEndTime := A_TickCount
    ShiftElapsedSeconds := (ShiftEndTime - ShiftStartTime)/1000.0
    if (ShiftElapsedSeconds < 0.25)
    {
        SetInputLang(0x0409) ; English
    }
    return

#If !WinActive(ahk_exe destiny2.exe)
~LCtrl::
    CtrlStartTime := A_TickCount
    KeyWait, LCtrl
    CtrlEndTime := A_TickCount
    CtrlElapsedSeconds := (CtrlEndTime - CtrlStartTime)/1000.0
    if (CtrlElapsedSeconds < 0.25)
    {
        SetInputLang(0x0419) ; Russian
    }
    return
