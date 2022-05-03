#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance Force ; Makes sure the script only runs one at a time.

;========================== startup ==========================

Run, %A_ScriptDir%\main.ahk
; Run, %A_ScriptDir%\numpad_emulation.ahk
; Run, %A_ScriptDir%\DiscordQuote.ahk