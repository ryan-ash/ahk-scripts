#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%

;======================== CLOCK & TIMER ========================

TimerState := 0
TimerPaused := 0
TimerInitState := 1
TimerStartTime := 0
TimerEndTime := 0
TimerElapsedSeconds := 0

; control visual state
; add show / hide timer (alt + ...)

ScrollLock::
    if (TimerState == 1)
        if (TimerPaused == 0)
            gosub GuiStop
        else
            gosub GuiContinue
    else
        gosub GuiStart
    return


+ScrollLock::
    if (TimerState != 0)
        gosub GuiClose
    else
        gosub GuiStart
    return


!ScrollLock::
    gosub GuiRestart
    return


GuiStart:
    TimerState := 1

    if (TimerInitState != 0)
    {
        ;On-screen display (OSD)
        CustomColor = 000000  ; Can be any RGB color (it will be made transparent below).

        Gui +LastFound +AlwaysOnTop +ToolWindow -Caption  ; +ToolWindow avoids a taskbar button and an alt-tab menu item.
        Gui, Color, %CustomColor%
        Gui, Font, s13  ; Set a large font size (32-point).
        Gui, Add, Text, vMyText cGray, -00:00:00 | 00:00:00 ; XX & YY serve to auto-size the window.

        WinSet, TransColor, %CustomColor% 150 ; Make all pixels of this color transparent and make the text itself translucent (150):
        SetTimer, UpdateOSD, 50 ; Causes a subroutine to be launched automatically and repeatedly at a specified time interval.
        Gosub, UpdateOSD  ; Make the first update immediate rather than waiting for the timer.
        TimerInitState := 0

        TimerStartTime := A_TickCount
        gosub GuiContinue
    }

    SysGet, m2, Monitor, 2          ; Get data on second monitor size.
    SysGet, m1, Monitor, 1
    drapeTop := m1Top < m2Top ? m1Top : m2Top
    drapeBottom := m1Bottom > m2Bottom ? m1Bottom : m2Bottom
    drapeHeight := drapeBottom - drapeTop
    drapeLeft := m1Left < m2Left ? m1Left : m2Left
    drapeRight := m1Right > m2Right ? m1Right : m2Right
    drapeWidth := drapeRight - drapeLeft
    offset := 0

    Gui, Show, x%offset% y%offset% NoActivate, Timer ; NoActivate avoids deactivating the currently active window.

    Return  ; // End of Auto-Execute Section


GuiRestart:
    TimerStartTime := A_TickCount
    TimerEndTime := A_TickCount
    Return

GuiStop:
    TimerPaused := 1
    SetScrollLockState, off
    Return

GuiContinue:
    TimerPaused := 0
    if (TimerElapsedSeconds == 0)
        gosub GuiRestart
    SetScrollLockState, on
    Return

GuiClose:
    TimerState := 0
    Gui, Hide
    Return



UpdateOSD:
    arrivo := 20070603230000        ; this is the finishing time
    mysec := arrivo                 
    EnvSub, mysec, %A_Now%, seconds
    if (TimerPaused == 0)
        TimerEndTime := A_TickCount
    TimerElapsedSeconds := Floor((TimerEndTime - TimerStartTime)/1000.0)
    TimerValue := FormatSeconds(TimerElapsedSeconds)
    GuiControl,, MyText, %A_Hour%:%A_Min%:%A_Sec% | %TimerValue%
    Return 



FormatSeconds(NumberOfSeconds)  ; Convert the specified number of seconds to hh:mm:ss format.
{
    time = 19990101  ; *Midnight* of an arbitrary date.
    time += %NumberOfSeconds%, seconds
    FormatTime, mmss, %time%, mm:ss
    hours := NumberOfSeconds // 3600 ; This method is used to support more than 24 hours worth of sections.
    hours := hours < 10 ? "0" . hours : hours
    return hours ":" mmss  
}