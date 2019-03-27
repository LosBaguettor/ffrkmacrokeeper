#NoEnv
SetWorkingDir %A_ScriptDir%
#SingleInstance Force
#WinActivateForce
SetTitleMatchMode 2
SetControlDelay 0
SetKeyDelay -1
SetMouseDelay -1
SetWinDelay 0
SetBatchLines -1
CoordMode, Pixel, relative

global ffrkaggro
global ffrkcBS = 1
global ffrkcBScount = 0
global blackscreentimer
global extdeviceforcerelog
global sleepspeed

IniRead, ffrkcrashrelog, %A_ScriptDir%\include\ffrk_macro.ini, baguette, ffrkcrashrelog , 1
IniRead, ffrkdailyrelog, %A_ScriptDir%\include\ffrk_macro.ini, baguette, ffrkdailyrelog , 0
IniRead, ffrkautostart, %A_ScriptDir%\include\ffrk_macro.ini, baguette, ffrkautostart , 1
IniRead, ffrkstamina, %A_ScriptDir%\include\ffrk_macro.ini, baguette, ffrkstamina , 20
IniRead, ffrkaggro, %A_ScriptDir%\include\ffrk_macro.ini, and, ffrkaggro , 1
;IniRead, ffrkmacromode, %A_ScriptDir%\include\ffrk_macro.ini, and, ffrkmacromode , 1
ffrkmacromode = 1
IniRead, ffrkmacrocond, %A_ScriptDir%\include\ffrk_macro.ini, and, ffrkmacrocond , 1
IniRead, ffrkheight, %A_ScriptDir%\include\ffrk_macro.ini, and, ffrkheight , 39
IniRead, ffrkwidth, %A_ScriptDir%\include\ffrk_macro.ini, and, ffrkwidth , 16
IniRead, delaystart, %A_ScriptDir%\include\ffrk_macro.ini, knuckles, delaystart , 100
IniRead, ffrktmor, %A_ScriptDir%\include\ffrk_macro.ini, knuckles, dungeonforcequit , 0
IniRead, extdeviceforcerelog, %A_ScriptDir%\include\ffrk_macro.ini, knuckles, extdeviceforcerelog , 0
IniRead, blackscreentimer, %A_ScriptDir%\include\ffrk_macro.ini, knuckles, blackscreentimer , 25
IniRead, sleepspeed, %A_ScriptDir%\include\ffrk_macro.ini, knuckles, sleepspeed , 2

global ffrk_window_height := 498 + ffrkheight
global ffrk_window_width := 280 + ffrkwidth
global ffrk_clic_width := ffrkwidth / 2
global ffrk_clic_height := ffrkheight - ffrk_clic_width

if (ffrkmacrocond = 0)
	{
	imagevar = 40
	pixelvar = 30
	}
else
	{
	imagevar = 15
	pixelvar = 10
	}
ffrkstamlimit := "ffrk_battle_1_stamina_" ffrkstamina
if (sleepspeed = 1)
	{
	global SLP1 = 50
	global SLP2 = 5
	}
else if (sleepspeed = 0)
	{
	global SLP1 = 15
	global SLP2 = 1
	}
else
	{
	global SLP1 = 100
	global SLP2 = 10
	}
	
MsgBox, 48,FFRK Magia Macro Keeper V2.00 by LosBaguettor, Hello`nTo properly use this macro,`nPlease check the README !`n`nPress F1 to START the macro`nPress F2 to CLOSE the macro`nPress F3 to RELOAD the macro`n`nPress OK to continue`n`nHave fun farming !!

F2::ExitApp

F3::Reload

F1::
if (ffrkautostart = 1)
	{
	ffrkshortcut := A_Desktop "\FFRK.lnk"
	if !FileExist(ffrkshortcut)
		{
		msgbox, 48,ERROR,There's no Andapp FFRK shortcut on your desktop !`n`nThis macro will close.
		sleep, 2000
		ExitApp
		}
	}
Sleep, delaystart
Loop
	{
FFRK_farming_process:
	FFRK_grey()
	If ( ffrkautostart = 1 )
		{
		ffrkon := FFRK_state(0)
		If ( ffrkon = 0 )
			{
			Run %ffrkshortcut%
			sleep 30000
			}
		}
	FFRK_state(1)
	If (ffrkcrashrelog = 1 and ffrkautostart = 1)
		{
		ffrkcBS := FFRK_ConfirmImage("ffrk_crash_blackscreen",imagevar)
		If ( ffrkcBS = 0 and ffrkcBScount > blackscreentimer)
			{
			FFRK_state(1)
			Sleep, %SLP1%
			WinClose
			Sleep,10000
			}
		else if ( ffrkcBS = 0)
			{
			ffrkcBScount := ffrkcBScount + 1
			}
		else
			{
			ffrkcBScount = 0
			}		
		}
	ffrkb5 := FFRK_ConfirmImage("ffrk_battle_5",imagevar)
	If ( ffrkb5 = 0 )
		{
		FFRK_click(137,416)
		sleep, %SLP2%
		goto, FFRK_farming_process
		}	
	ffrkbX := FFRK_ConfirmImage("ffrk_battle_X",imagevar)
	If ( ffrkbX = 0 ) ; garde-fou
		{
		sleep 1000
		If ( ffrkbX = 0 )
			{
			FFRK_click(137,416)
			sleep, %SLP2%
			goto, FFRK_farming_process
			}
		}	
	ffrkb1 := FFRK_ConfirmImage(ffrkstamlimit,imagevar)
	ffrkb2 := FFRK_ConfirmImage("ffrk_battle_2",imagevar)
	ffrkb2b := FFRK_ConfirmImage("ffrk_battle_2b",imagevar)
	If ( ffrkb2 = 0 or ffrkb2b = 0)
		{
		If ( ffrkb1 = 0 )
			{
			If ( ffrkb2 = 0 )
				{
				imageurl := A_ScriptDir "\image\ffrk_battle_2.png"
				}
			else 
				{
				imageurl := A_ScriptDir "\image\ffrk_battle_2b.png"
				}				
			imagevarb := "*" imagevar
			ImageSearch, ffrkclicx, ffrkclicy, 0, 0, %ffrk_window_width%, %ffrk_window_height%, %imagevarb% %imageurl%
			ffrkclicx := ffrkclicx - ffrk_clic_width
			ffrkclicy := ffrkclicy - ffrk_clic_height
			FFRK_click(ffrkclicx,ffrkclicy)	
			sleep, %SLP2%
			goto, FFRK_farming_process
			}
		}		
	ffrkb3 := FFRK_ConfirmImage("ffrk_battle_3",imagevar)
	If ( ffrkb3 = 0 )
		{
		FFRK_click(194,304)
		sleep, %SLP2%
		goto, FFRK_farming_process
		}
	ffrkb4 := FFRK_ConfirmImage("ffrk_battle_4",imagevar)
	If ( ffrkb4 = 0 )
		{
		FFRK_click(23,382)
		sleep, %SLP2%
		goto, FFRK_farming_process
		}	
	ffrks1 := FFRK_ConfirmImage("ffrk_select_1_realm",imagevar)
	ffrks2 := FFRK_ConfirmImage("ffrk_select_2_realm",imagevar)
	ffrks3 := FFRK_ConfirmImage("ffrk_select_3_realm",imagevar)
	ffrks4 := FFRK_ConfirmImage("ffrk_select_4_fabul",imagevar)
	ffrks5 := FFRK_ConfirmImage("ffrk_select_5_fabul",imagevar)
	ffrks6 := FFRK_ConfirmImage("ffrk_select_6_team",imagevar)
	ffrks7 := FFRK_ConfirmImage("ffrk_select_7_rw",imagevar)

	ffrkr1 := FFRK_ConfirmImage("ffrk_relog_1_start",imagevar)
	ffrkr2 := FFRK_ConfirmImage("ffrk_relog_2_main",imagevar)
	ffrkr2b := FFRK_ConfirmImage("ffrk_relog_2b",imagevar)
	
	ffrkcSE := FFRK_ConfirmImage("ffrk_crash_systemerror",imagevar)
	ffrkcEXTD := FFRK_ConfirmImage("ffrk_crash_extdevicelog",imagevar)

	ffrksXF := FFRK_ConfirmImage("ffrk_select_X_dungeonforcequit",imagevar)
	
	ffrkd1 := FFRK_ConfirmImage("ffrk_daily_1_screen",imagevar)
	ffrkd2 := FFRK_ConfirmImage("ffrk_daily_2_ok",imagevar)
	ffrkd3 := FFRK_ConfirmImage("ffrk_daily_3_okb",imagevar)
	
	If ( ffrkr1 = 0 )
		{
		FFRK_click(141,432)
		}
	else If ( ffrkcSE = 0 )
		{
		FFRK_click(132,311)
		}	
	else If ( ffrksXF = 0 and ffrktmor = 1)
		{
		FFRK_click(183,311)
		}	
	else If ( ffrks6 = 0 )
		{
		imageurl := A_ScriptDir "\image\ffrk_select_6_team.png"
		imagevarb := "*" imagevar
		ImageSearch, ffrkclicx, ffrkclicy, 0, 0, %ffrk_window_width%, %ffrk_window_height%, %imagevarb% %imageurl%
		ffrkclicx := ffrkclicx - ffrk_clic_width
		ffrkclicy := ffrkclicy - ffrk_clic_height
		FFRK_click(ffrkclicx,ffrkclicy)
		}	
	else If ( ffrks7 = 0 )
		{
		imageurl := A_ScriptDir "\image\ffrk_select_7_rw.png"
		imagevarb := "*" imagevar
		ImageSearch, ffrkclicx, ffrkclicy, 0, 0, %ffrk_window_width%, %ffrk_window_height%, %imagevarb% %imageurl%
		ffrkclicx := ffrkclicx - ffrk_clic_width
		ffrkclicy := ffrkclicy - ffrk_clic_height
		FFRK_click(ffrkclicx,ffrkclicy)
		}	
	else If ( ffrks5 = 0 )
		{
		FFRK_click(195,425)
		}
	else If ( ffrkr2 = 0 )
		{
		If ( ffrkr2b != 0 and ffrktmor = 1)
			{
			MouseMove, X, Y, 5
			Sleep, 200
			Click, 14 ,239 Down Left
			Sleep, 700
			Click, 278 ,239 Up Left
			Sleep, 500
			}
		FFRK_click(66,314)
		}	
	else If ( ffrks1 = 0 )
		{
		FFRK_click(116,61)
		}	
	else If ( ffrks2 = 0 )
		{
		FFRK_click(66,405)
		}	
	else If ( ffrks3 = 0 )
		{
		FFRK_click(140,325)
		}		
	else If ( ffrks4 = 0 )
		{
		imageurl := A_ScriptDir "\image\ffrk_select_4_fabul.png"
		imagevarb := "*" imagevar
		ImageSearch, ffrkclicx, ffrkclicy, 0, 0, %ffrk_window_width%, %ffrk_window_height%, %imagevarb% %imageurl%
		ffrkclicx := ffrkclicx - ffrk_clic_width
		ffrkclicy := ffrkclicy - ffrk_clic_height
		FFRK_click(ffrkclicx,ffrkclicy)
		}	
	else If ( ffrkd1 = 0 and ffrkdailyrelog = 1)
		{
		FFRK_click(140,313)
		}	
	else If ( ffrkd2 = 0 )
		{
		imageurl := A_ScriptDir "\image\ffrk_daily_2_ok.png"
		imagevarb := "*" imagevar
		ImageSearch, ffrkclicx, ffrkclicy, 0, 0, %ffrk_window_width%, %ffrk_window_height%, %imagevarb% %imageurl%
		ffrkclicx := ffrkclicx - ffrk_clic_width
		ffrkclicy := ffrkclicy - ffrk_clic_height
		FFRK_click(ffrkclicx,ffrkclicy)
		}		
	else If ( ffrkd3 = 0 )
		{
		imageurl := A_ScriptDir "\image\ffrk_daily_3_okb.png"
		imagevarb := "*" imagevar
		ImageSearch, ffrkclicx, ffrkclicy, 0, 0, %ffrk_window_width%, %ffrk_window_height%, %imagevarb% %imageurl%
		ffrkclicx := ffrkclicx - ffrk_clic_width
		ffrkclicy := ffrkclicy - ffrk_clic_height
		FFRK_click(ffrkclicx,ffrkclicy)
		}	
	else If ( ffrkcEXTD = 0 )
		{
		if (extdeviceforcerelog = 0)
			{
			msgbox, 48,ERROR,Disconnected !`nAn other device has logged on this account !`n`nThis macro will close.
			sleep, 2000
			ExitApp
			}
		else
			{
			FFRK_click(139,314)
			}
		}	
	}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; check FFRK Grey window error and close it
FFRK_grey()
	{
	If WinExist("ahk_class #32770")
		{
		WinActivate, ahk_class #32770
		Sleep, 300
		MouseMove, 82, 128 , 5
		Sleep, 200
		Click, 82, 128 Left, 1
		Sleep, 100
		}
	}

; check FFRK status
FFRK_state(aggro)
	{
	IfWinNotExist FINAL FANTASY Record Keeper ahk_class KickmotorMain
		{
		Sleep, %SLP1%
		Return 0
		}
	else
		{
		If ( aggro = 1)
			{
			WinActivate
			WinMove, FINAL FANTASY Record Keeper ,,,,%ffrk_window_width%,%ffrk_window_height%
			}
		Sleep, %SLP1%
		Return 1
		}
	}
	
; Move and click function because i'm lazy
FFRK_click(X,Y)
	{
	X := X + ffrk_clic_width
	Y := Y + ffrk_clic_height
	MouseMove, X, Y, 5
	Sleep, 200
	Click, X ,Y Down Left
	Sleep, 300
	Click, X ,Y Up Left
	}
	
; check image for lazy
FFRK_ConfirmImage(image,imagevar)
	{
	FFRK_state(ffrkaggro)
	Loop, 3
		{
		imageurl := A_ScriptDir "\image\" image ".png"
		imagevarb := "*" imagevar
		ImageSearch, , , 0, 0, %ffrk_window_width%, %ffrk_window_height%, %imagevarb% %imageurl%
		if ErrorLevel = 0
			Return ErrorLevel
		Sleep %SLP2%
		}
	Return ErrorLevel
	}
