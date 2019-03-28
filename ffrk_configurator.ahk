﻿; Generated by AutoGUI 2.5.4
#SingleInstance Force
#NoEnv
SetWorkingDir %A_ScriptDir%
SetBatchLines -1

Gui +Resize -MinimizeBox -MaximizeBox -SysMenu +AlwaysOnTop +DPIScale -Theme
Gui Add, Picture, x0 y0 w400 h79, %A_ScriptDir%\include\header.gif
Gui Add, Text, x0 y80 w433 h2 +0x10
Gui Add, Button, gffrk_saveandexit x96 y208 w100 h30, Save and Exit
Gui Add, Button, gffrkexit x208 y208 w100 h30, Ignore and Exit
Gui Font, s12
Gui Add, Text, x8 y112 w125 h20, Daily Relog
Gui Font
Gui Font, s12
Gui Add, Text, x8 y136 w125 h20, Autostart
Gui Font
Gui Font, s12
Gui Add, Text, x8 y88 w125 h20, Crash relog
Gui Font
Gui Font, s12
Gui Add, Text, x208 y112 w125 h20, Macro Mode
Gui Font
Gui Font, s12
Gui Add, Text, x208 y88 w125 h20, Aggressive Mode
Gui Font
Gui Add, Text, x200 y80 w2 h130 +0x1 +0x10
Gui Font, s12
Gui Add, Text, x8 y160 w125 h20, Stamina`% Kept
Gui Font
Gui Add, Text, x0 y206 w398 h2 +0x10
Gui Font, s12
Gui Add, Text, x208 y136 w125 h20, Condition Check
Gui Font
Gui Add, CheckBox, vffrkcrashrelog x136 y92 w12 h12 +Checked
Gui Add, CheckBox, vffrkdailyrelog x136 y116 w12 h12
Gui Add, CheckBox, vffrkautostart x136 y140 w12 h12 +Checked
Gui Add, CheckBox, vffrkaggro x336 y92 w12 h12 +Checked
Gui Add, ComboBox, vffrkmacromode x336 y112 w60, Image||
Gui Add, ComboBox, vffrkmacrocond x336 y136 w60, Normal||Low
Gui Add, ComboBox, vffrkstamina x136 y160 w60, 10|20||30|40
Gui Font, s12
Gui Add, Text, x208 y160 w125 h20, WidthD
Gui Font
Gui Add, edit, vffrkwidth x336 y160 w60, 16
Gui Font, s12
Gui Add, Text, x208 y184 w125 h20, HeightD
Gui Font
Gui Add, edit, vffrkheight x336 y184 w60,39

Gui Show, w400 h240, FFRK Macro Configurator
Return

ffrk_saveandexit:
Gui,submit
IniWrite, %ffrkcrashrelog%, %A_ScriptDir%\include\ffrk_macro.ini, baguette, ffrkcrashrelog
IniWrite, %ffrkdailyrelog%, %A_ScriptDir%\include\ffrk_macro.ini, baguette, ffrkdailyrelog
IniWrite, %ffrkautostart%, %A_ScriptDir%\include\ffrk_macro.ini, baguette, ffrkautostart
IniWrite, %ffrkstamina%, %A_ScriptDir%\include\ffrk_macro.ini, baguette, ffrkstamina
IniWrite, %ffrkaggro%, %A_ScriptDir%\include\ffrk_macro.ini, and, ffrkaggro
If ( ffrkmacromode = "Pixel")
	{
	IniWrite, 0, %A_ScriptDir%\include\ffrk_macro.ini, and, ffrkmacromode
	}
else
	{
	IniWrite, 1, %A_ScriptDir%\include\ffrk_macro.ini, and, ffrkmacromode
	}
If ( ffrkmacrocond = "Low")
	{
	IniWrite, 0, %A_ScriptDir%\include\ffrk_macro.ini, and, ffrkmacrocond
	}
else
	{
	IniWrite, 1, %A_ScriptDir%\include\ffrk_macro.ini, and, ffrkmacrocond
	}
IniWrite, %ffrkheight%, %A_ScriptDir%\include\ffrk_macro.ini, and, ffrkheight
IniWrite, %ffrkwidth%, %A_ScriptDir%\include\ffrk_macro.ini, and, ffrkwidth
;IniWrite, 100, %A_ScriptDir%\include\ffrk_macro.ini, knuckles, delaystart
;IniWrite, 0, %A_ScriptDir%\include\ffrk_macro.ini, knuckles, dungeonforcequit
;IniWrite, 0, %A_ScriptDir%\include\ffrk_macro.ini, knuckles, extdeviceforcerelog
;IniWrite, 25, %A_ScriptDir%\include\ffrk_macro.ini, knuckles, blackscreentimer
;IniWrite, 2, %A_ScriptDir%\include\ffrk_macro.ini, knuckles, sleepspeed
;IniWrite, 0, %A_ScriptDir%\include\ffrk_macro.ini, knuckles, rebootwhilefight
;IniWrite, 0, %A_ScriptDir%\include\ffrk_macro.ini, knuckles, MOmode
;IniWrite, 0, %A_ScriptDir%\include\ffrk_macro.ini, knuckles, failoverscreenshot
Sleep,1000
ExitApp
Return

ffrkexit:
Gui,submit
Sleep,1000
ExitApp
Return

GuiSize:
    If (A_EventInfo == 1) {
        Return
    }

Return

GuiEscape:
GuiClose:
    ExitApp
