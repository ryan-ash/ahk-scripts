#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance Force ; Makes sure the script only runs one at a time.

#IfWinActive ahk_exe Discord.exe
    ~^+vk43::
        Send {CtrlDown}{vk43}{CtrlUp}
        Send {Tab}
        Sleep 200
        Send {>}{Space}{``}
        Send {CtrlDown}{vk56}{CtrlUp}
        Send {``}+{Enter}+{Enter}
        return