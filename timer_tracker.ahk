#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%

;======================== CLOCK & TIMER ========================

TimerOpened := 0
TimerPaused := 0

TimerInitState := 1

TimerStartTime := 0
TimerEndTime := 0
TimerElapsedSeconds := 0

TimerPauseStartTime := 0
TimerPauseEndTime := 0
TimerTimeInPause := 0

ClockVisible := 1
TimerVisible := 1

; control placement anchor

ScrollLock::
    if (TimerOpened == 1)
        if (TimerPaused == 0)
            gosub GuiStop
        else
            gosub GuiContinue
    else
        gosub GuiStart
    return


+ScrollLock::
    if (TimerOpened != 0)
        gosub GuiClose
    else
        gosub GuiStart
    return


!ScrollLock::
    gosub GuiRestart
    return


!^#vk25::
    gosub ToggleClock
    return


!^#vk27::
    gosub ToggleTimer
    return


!#vk25::
    gosub MoveTimerLeft
    return

!#vk26::
    gosub MoveTimerUp
    return

!#vk27::
    gosub MoveTimerRight
    return

!#vk28::
    gosub MoveTimerDown
    return


GuiStart:
    TimerOpened := 1

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
    TimerTimeInPause := 0
    TimerPauseStartTime := 0
    TimerPauseEndTime := 0
    Return

GuiStop:
    TimerPaused := 1
    TimerPauseStartTime := A_TickCount
    SetScrollLockState, off
    Return

GuiContinue:
    TimerPaused := 0
    if (TimerElapsedSeconds == 0)
        gosub GuiRestart
    TimerPauseEndTime := A_TickCount
    if (TimerPauseStartTime != 0) {
        TimeInThisPause := Floor((TimerPauseEndTime - TimerPauseStartTime)/1000.0)
        TimerTimeInPause := TimerTimeInPause + TimeInThisPause
        TimerPauseStartTime := 0
    }
    SetScrollLockState, on
    Return

GuiClose:
    TimerOpened := 0
    Gui, Hide
    Return

ToggleClock:
    if (ClockVisible == 1)
        ClockVisible := 0
    else
        ClockVisible := 1
    return

ToggleTimer:
    if (TimerVisible == 1)
        TimerVisible := 0
    else
        TimerVisible := 1
    return


UpdateOSD:
    arrivo := 20070603230000        ; this is the finishing time
    mysec := arrivo                 
    EnvSub, mysec, %A_Now%, seconds

    if (TimerPaused == 0)
        TimerEndTime := A_TickCount
    TimerElapsedSeconds := Floor((TimerEndTime - TimerStartTime)/1000.0) - TimerTimeInPause
    TimerValue := FormatSeconds(TimerElapsedSeconds)

    if (TimerVisible == 1 && ClockVisible == 1)
        GuiControl,, MyText, %A_Hour%:%A_Min%:%A_Sec% | %TimerValue%
    else if (ClockVisible == 1)
        GuiControl,, MyText, %A_Hour%:%A_Min%:%A_Sec%
    else if (TimerVisible == 1)
        GuiControl,, MyText, %TimerValue%
    else
        GuiControl,, MyText, 

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

MoveTimerLeft:
    return
MoveTimerUp:
    return
MoveTimerRight:
    return
MoveTimerDown:
    return