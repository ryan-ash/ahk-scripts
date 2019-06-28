#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance Force ; Makes sure the script only runs one at a time.

AuthorMatchPattern := "O)^(\D+)((?>\d\d\/?)+|(?>(?>Yesterday|Today|Last [a-zA-Z]+) at [\d\:APM ]+))$"

#IfWinActive ahk_exe Discord.exe
    ~^+vk45::
        Send {AltUp}{ShiftUp}
        Clipboard =
        Send {CtrlDown}{vk43}{CtrlUp}
        Send {Tab}
        Sleep 200

        ClipboardLines := StrSplit(Clipboard, "`n", "`n`r")

        For Number, Line in ClipboardLines {
            AuthorLine := RegExMatch(Line, AuthorMatchPattern, AuthorParts)
            if (AuthorLine) {
                AuthorName := AuthorParts.Value(1)
                Send {@}
                Send %AuthorName%
                Send {`:}+{Enter}
            } else {
                Send {>}{Space}{``}
                SendRaw %Line%
                Send {``}+{Enter}
            }
        }
        Send +{Enter}
        return