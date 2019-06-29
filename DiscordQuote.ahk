#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance Force ; Makes sure the script only runs one at a time.

; https://regex101.com/r/vxzLHZ/1
AuthorMatchPattern := "O)^(.+)(\d\d\/\d\d\/\d\d\d\d|(?>(?>Yesterday|Today|Last [a-zA-Z]+) at [\d\:APM ]+))$"

#IfWinActive ahk_exe Discord.exe
    ~^+vk45::
        Send {AltUp}{ShiftUp}
        Clipboard =
        Send {CtrlDown}{vk43}{CtrlUp}
        Send {Tab}
        Sleep 200
        BlockStarted := false

        Clipboard := Trim(Clipboard, OmitChars := " `t`r`n")
        ClipboardLines := StrSplit(Clipboard, "`n", "`n`r")

        For Number, Line in ClipboardLines {
            AuthorLine := RegExMatch(Line, AuthorMatchPattern, AuthorParts)
            if (AuthorLine) {
                if (BlockStarted) {
                    BlockStarted := false
                    Send {``}{``}{``}
                    Send +{Enter}
                }
                AuthorName := AuthorParts.Value(1)
                Send {@}
                Send %AuthorName%
                Send {`:}+{Enter}
            } else {
                if (!BlockStarted) {
                    BlockStarted := true
                    Send {``}{``}{``}
                } else {
                    Send +{Enter}
                }
                SendRaw %Line%
            }
        }
        if (BlockStarted) {
            BlockStarted := false
            Send {``}{``}{``}
            Send +{Enter}
        }
        return