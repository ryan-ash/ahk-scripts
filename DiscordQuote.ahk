#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance Force ; Makes sure the script only runs one at a time.

#IfWinActive ahk_exe Discord.exe
    ~^+vk45::
        Send {AltUp}{ShiftUp}
        Clipboard =
        Send {CtrlDown}{vk43}{CtrlUp}
        Send {Tab}

        ClipboardLines := StrSplit(Clipboard, "`n", "`n`r")

        For Number, Line in ClipboardLines {
            Send {>}{Space}{``}
            SendRaw %Line%
            Send {``}+{Enter}
        }
        Send +{Enter}
        return