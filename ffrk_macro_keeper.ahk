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
global iniurl := A_ScriptDir  "\include\ffrk_macro.ini"
global logurl := A_ScriptDir  "\log\" A_YYYY "_" A_MM "_" A_DD ".txt"
global fightID = 0
global emptyloop = 0
global rebootwhilefight
global staminalog = 0
global MOmode
global remRW = 0
global chRW = 0
global foRW = 0
global rollRW = 0
global failoverscreenshot

IniRead, ffrkcrashrelog, %iniurl%, baguette, ffrkcrashrelog , 1
IniRead, ffrkdailyrelog, %iniurl%, baguette, ffrkdailyrelog , 0
IniRead, ffrkautostart, %iniurl%, baguette, ffrkautostart , 1
IniRead, ffrkstamina, %iniurl%, baguette, ffrkstamina , 20
IniRead, ffrkaggro, %iniurl%, and, ffrkaggro , 1
;IniRead, ffrkmacromode, %iniurl%, and, ffrkmacromode , 1
ffrkmacromode = 1
IniRead, ffrkmacrocond, %iniurl%, and, ffrkmacrocond , 1
IniRead, ffrkheight, %iniurl%, and, ffrkheight , 39
IniRead, ffrkwidth, %iniurl%, and, ffrkwidth , 16
IniRead, delaystart, %iniurl%, knuckles, delaystart , 100
IniRead, ffrktmor, %iniurl%, knuckles, dungeonforcequit , 0
IniRead, extdeviceforcerelog, %iniurl%, knuckles, extdeviceforcerelog , 0
IniRead, blackscreentimer, %iniurl%, knuckles, blackscreentimer , 25
IniRead, sleepspeed, %iniurl%, knuckles, sleepspeed , 2
IniRead, rebootwhilefight, %iniurl%, knuckles, rebootwhilefight , 0
IniRead, MOmode, %iniurl%, knuckles, MOmode , 0
global ffrk_window_height := 498 + ffrkheight
global ffrk_window_width := 280 + ffrkwidth
global ffrk_clic_width := ffrkwidth / 2
global ffrk_clic_height := ffrkheight - ffrk_clic_width

If ((substr(a_osversion, 1, 2)) = "10")
	{
	IniRead, failoverscreenshot, %iniurl%, knuckles, failoverscreenshot , 1
	}
else
	{
	failoverscreenshot = 0
	}
	
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
if (MOmode = 1)
	{
	global failoverreset = 700
	global failovermodulo = 100
	}
else
	{
	global failoverreset = 100
	global failovermodulo = 20
	}
	
MsgBox, 48,FFRK Magia Macro Keeper V2.10 by LosBaguettor, Hello`nTo properly use this macro,`nPlease check the README !`n`nPress F1 to START the macro`nPress F2 to CLOSE the macro`nPress F3 to RELOAD the macro`n`nPress OK to continue`n`nHave fun farming !!

F2::ExitApp

F3::Reload

F1::
FileAppend , Macro started at %A_Hour%h %A_Min%min`n , %logurl%
if (ffrkautostart = 1)
	{
	ffrkshortcut := A_Desktop "\FFRK.lnk"
	if !FileExist(ffrkshortcut)
		{
		msgbox, 48,ERROR,There's no Andapp FFRK shortcut on your desktop !`n`nThis macro will close.
		FileAppend , ERROR no FFRK shortcut`n , %logurl%
		sleep, 2000
		ExitApp
		}
	FileAppend , FFRK Shortcut OK`n , %logurl%
	}
FileAppend , Script will start in %delaystart%msec`n , %logurl%
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
			FileAppend , FFRK has started`n , %logurl%
			sleep 30000
			}
		}
	FFRK_state(1)
	If (ffrkcrashrelog = 1)
		{
		ffrkcTO := FFRK_ConfirmImage("ffrk_crash_timeout",imagevar,0)
		if ( ffrkcTO = 0 )
			{
			FFRK_click(138,298)	
			}
		}		
	If (ffrkcrashrelog = 1 and ffrkautostart = 1)
		{
		ffrkcBS := FFRK_ConfirmImage("ffrk_crash_blackscreen",imagevar,0)
		If ( ffrkcBS = 0 and ffrkcBScount > blackscreentimer)
			{
			FFRK_state(1)
			Sleep, %SLP1%
			WinClose
			FileAppend , ERROR FFRK Black screen hang FFRK will restart`n , %logurl%
			Sleep,10000
			}
		else if ( ffrkcBS = 0 )
			{
			ffrkcBScount := ffrkcBScount + 1
			}
		else
			{
			ffrkcBScount = 0
			}		
		}
	ffrkb5 := FFRK_ConfirmImage("ffrk_battle_5",imagevar,0)
	If ( ffrkb5 = 0 )
		{
		FFRK_click(137,416)
		sleep, %SLP2%
		goto, FFRK_farming_process
		}	
	ffrkbX := FFRK_ConfirmImage("ffrk_battle_X",imagevar,0)
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
	ffrkb1 := FFRK_ConfirmImage(ffrkstamlimit,imagevar,0)
	ffrkb2 := FFRK_ConfirmImage("ffrk_battle_2",imagevar,0)
	ffrkb2b := FFRK_ConfirmImage("ffrk_battle_2b",imagevar,0)
	If ( ffrkb2 = 0 or ffrkb2b = 0)
		{
		If ( ffrkb1 = 0 )
			{
			staminalog = 0
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
		else
			{
			staminalog := staminalog+1
			staminalogmod := mod(staminalog,250)
			if (staminalogmod = 0)
				{
				FileAppend , Stamina threshold not reached yet %staminalog% - waiting`n , %logurl%
				}
			sleep, %SLP2%
			goto, FFRK_farming_process
			}	
		}		
	ffrkb3 := FFRK_ConfirmImage("ffrk_battle_3",80,0)
	If ( ffrkb3 = 0 )
		{
		FFRK_click(194,304)
		sleep, %SLP2%
		fightID := fightID +1
		FileAppend , fight %fightID% has started`n , %logurl%
		goto, FFRK_farming_process
		}
	ffrkb4 := FFRK_ConfirmImage("ffrk_battle_4",imagevar,0)
	If ( ffrkb4 = 0 )
		{
		FFRK_click(23,382)
		sleep, %SLP2%
		goto, FFRK_farming_process
		}	
	;common variable to both mode
	ffrks6 := FFRK_ConfirmImage("ffrk_select_6_team",imagevar,0)
	global ffrks7 := FFRK_ConfirmImage("ffrk_select_7_rw",imagevar,0)
	
	ffrkr1 := FFRK_ConfirmImage("ffrk_relog_1_start",imagevar,0)
	ffrkr2 := FFRK_ConfirmImage("ffrk_relog_2_main",imagevar,0)

	ffrkcSE := FFRK_ConfirmImage("ffrk_crash_systemerror",imagevar,0)
	ffrkcEXTD := FFRK_ConfirmImage("ffrk_crash_extdevicelog",imagevar,0)
	ffrkrXWF := FFRK_ConfirmImage("ffrk_relog_X_rebootwhilefight",imagevar,0)	

	ffrksXF := FFRK_ConfirmImage("ffrk_select_X_dungeonforcequit",imagevar,0)

	ffrkd1 := FFRK_ConfirmImage("ffrk_daily_1_screen",imagevar,0)
	ffrkd2 := FFRK_ConfirmImage("ffrk_daily_2_ok",imagevar,0)
	ffrkd3 := FFRK_ConfirmImage("ffrk_daily_3_okb",imagevar,0)
	ffrkd4 := FFRK_ConfirmImage("ffrk_daily_4_mission",imagevar,0)
	
	ffrkKO1 := FFRK_ConfirmImage("ffrk_dead_1_youdied",imagevar,0)
	ffrkKO2 := FFRK_ConfirmImage("ffrk_dead_1b_youdied",imagevar,0)
	ffrkKO3 := FFRK_ConfirmImage("ffrk_dead_1c_youdied",imagevar,0)
	
	;fabul only
	If ( MOmode != 1)
		{
		ffrks1 := FFRK_ConfirmImage("ffrk_select_1_realm",imagevar,0)
		ffrks2 := FFRK_ConfirmImage("ffrk_select_2_realm",imagevar,0)
		ffrks3 := FFRK_ConfirmImage("ffrk_select_3_realm",imagevar,0)
		ffrks4 := FFRK_ConfirmImage("ffrk_select_4_fabul",imagevar,0)
		ffrks5 := FFRK_ConfirmImage("ffrk_select_5_fabul",imagevar,0)	

		ffrkr2b := FFRK_ConfirmImage("ffrk_relog_2b",imagevar,0)
		}

	;MO only
	if ( MOmode = 1)
		{
		ffrkr2b := FFRK_ConfirmImage("ffrk_custom_common_1_main",imagevar,0)
		ffrkr2c := FFRK_ConfirmImage("ffrk_custom_common_1b_main",imagevar,0)
	
		ffrkMO1 := FFRK_ConfirmImage("ffrk_custom_common_1_main",imagevar,0)
		ffrkMO2 := FFRK_ConfirmImage("ffrk_custom_common_2_MOmenu",imagevar,0)
		ffrkMO3 := FFRK_ConfirmImage("ffrk_custom_common_3_confirmfight",imagevar,0)
		ffrkMO4 := FFRK_ConfirmImage("ffrk_custom_common_4_selectsolo",imagevar,0)
		global ffrkMO5 := FFRK_ConfirmImage("ffrk_custom_common_5_reloadRW",imagevar,0)
		ffrkMO8 := FFRK_ConfirmImage("ffrk_custom_common_8_cancelfriend",imagevar,0)
		
		ffrkMOc1 := FFRK_ConfirmImage("ffrk_custom_1_selectboss",imagevar,1)
		ffrkMOc2 := FFRK_ConfirmImage("ffrk_custom_2_selectdiff",imagevar,1)
		ffrkMOc4 := FFRK_ConfirmImage("ffrk_custom_4_bossbattle",imagevar,1)		
		}
	;msgbox 	ffrkr2b %ffrkr2b% ffrkr2c %ffrkr2c% ffrkr2 %ffrkr2%
	If ( ffrkr1 = 0 )
		{
		FFRK_click(141,432)
		}
	else If ( ffrkcSE = 0 )
		{
		FileAppend , SYSTEM ERROR relog`n , %logurl%
		FFRK_click(132,311)
		}	
	else If ( ffrksXF = 0 and ffrktmor = 1)
		{
		FileAppend , FORCE QUIT DUNGEON ACTIVATED`n , %logurl%
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
	else If ( ffrkr2 = 0 )
		{
		If ( MOmode = 1 )
			{
			if (ffrkr2b = 0)
				{
				imageurl := A_ScriptDir "\image\ffrk_custom_common_1_main.png"
				}
			else
				{
				imageurl := A_ScriptDir "\image\ffrk_custom_common_1b_main.png"
				}
			imagevarb := "*" imagevar
			ImageSearch, ffrkclicx, ffrkclicy, 0, 0, %ffrk_window_width%, %ffrk_window_height%, %imagevarb% %imageurl%
			ffrkclicx := ffrkclicx - ffrk_clic_width + 10
			ffrkclicy := ffrkclicy - ffrk_clic_height + 35
			FFRK_click(ffrkclicx,ffrkclicy)
			sleep, 1000
			}
		Else
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
			else
				{
				FFRK_click(66,314)
				sleep, 1000
				}
			}
		}	
	else if (( MOmode != 1 ) and ( ffrks1 = 0 OR ffrks2 = 0 OR ffrks3 = 0 OR ffrks4 = 0 OR ffrks5 = 0 OR ffrks7 = 0 ))
		{
		If ( ffrks1 = 0 )
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
		else If ( ffrks5 = 0 )
			{
			FFRK_click(195,425)
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
		}
	else if (( MOmode = 1 ) and ( ffrkMO2 = 0 OR ffrkMOc1 = 0 OR ffrkMOc2 = 0 OR ffrkMO3 = 0 OR ffrkMO4 = 0 OR ffrkMO5 = 0 OR ffrkMOc4 = 0 OR ffrkMO8 = 0))
		{
		If ( ffrkMO2 = 0 )
			{
			FFRK_click(219,29)
			}	
		else If ( ffrkMOc1 = 0 )
			{
			imageurl := A_ScriptDir "\image_custom\ffrk_custom_1_selectboss.png"
			imagevarb := "*" imagevar
			ImageSearch, ffrkclicx, ffrkclicy, 0, 0, %ffrk_window_width%, %ffrk_window_height%, %imagevarb% %imageurl%
			ffrkclicx := ffrkclicx - ffrk_clic_width
			ffrkclicy := ffrkclicy - ffrk_clic_height
			FFRK_click(ffrkclicx,ffrkclicy)
			}	
		else If ( ffrkMOc2 = 0 )
			{
			imageurl := A_ScriptDir "\image_custom\ffrk_custom_2_selectdiff.png"
			imagevarb := "*" imagevar
			ImageSearch, ffrkclicx, ffrkclicy, 0, 0, %ffrk_window_width%, %ffrk_window_height%, %imagevarb% %imageurl%
			ffrkclicx := ffrkclicx - ffrk_clic_width
			ffrkclicy := ffrkclicy - ffrk_clic_height
			FFRK_click(ffrkclicx,ffrkclicy)
			}	
		else If ( ffrkMO3 = 0 )
			{
			FFRK_click(199,428)
			}
		else If ( ffrkMO4 = 0 )
			{
			FFRK_click(69,280)
			}
		else If ( ffrkMO5 = 0 )
			{
			FFRK_RWfinder()
			}
		else If ( ffrkMOc4 = 0 )
			{
			FFRK_click(138,210)
			}
		else If ( ffrkMO8 = 0 )
			{
			FFRK_click(65,333)
			}

		}	
	else If ( ffrkd1 = 0 and ffrkdailyrelog = 1)
		{
		FileAppend , DAILY RELOG ACTIVATE`n , %logurl%
		FFRK_click(140,313)
		}	
	else If ( ffrkKO1 = 0)
		{
		imageurl := A_ScriptDir "\image\ffrk_dead_1_youdied.png"
		imagevarb := "*" imagevar
		ImageSearch, ffrkclicx, ffrkclicy, 0, 0, %ffrk_window_width%, %ffrk_window_height%, %imagevarb% %imageurl%
		ffrkclicx := ffrkclicx - ffrk_clic_width
		ffrkclicy := ffrkclicy - ffrk_clic_height
		FFRK_click(ffrkclicx,ffrkclicy)
		}	
	else If ( ffrkKO2 = 0)
		{
		imageurl := A_ScriptDir "\image\ffrk_dead_1b_youdied.png"
		imagevarb := "*" imagevar
		ImageSearch, ffrkclicx, ffrkclicy, 0, 0, %ffrk_window_width%, %ffrk_window_height%, %imagevarb% %imageurl%
		ffrkclicx := ffrkclicx - ffrk_clic_width
		ffrkclicy := ffrkclicy - ffrk_clic_height
		FFRK_click(ffrkclicx,ffrkclicy)
		}	
	else If ( ffrkKO3 = 0)
		{
		imageurl := A_ScriptDir "\image\ffrk_dead_1c_youdied.png"
		imagevarb := "*" imagevar
		ImageSearch, ffrkclicx, ffrkclicy, 0, 0, %ffrk_window_width%, %ffrk_window_height%, %imagevarb% %imageurl%
		ffrkclicx := ffrkclicx - ffrk_clic_width
		ffrkclicy := ffrkclicy - ffrk_clic_height
		FileAppend , YOU DIED`n , %logurl%
		FFRK_click(ffrkclicx,ffrkclicy)
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
	else If ( ffrkd4 = 0 )
		{
		imageurl := A_ScriptDir "\image\ffrk_daily_4_mission.png"
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
			FileAppend , ERROR Disconnected ! An other device has logged`n , %logurl%
			msgbox, 48,ERROR,Disconnected !`nAn other device has logged on this account !`n`nThis macro will close.
			sleep, 2000
			ExitApp
			}
		else
			{
			FileAppend , Disconnected ! an other device has logged - force relog`n , %logurl%
			FFRK_click(139,314)
			}
		}	
	else If ( ffrkrXWF = 0 )
		{
		if (rebootwhilefight = 1)
			{
			FileAppend , ERROR Fight exist at login - GO TO BATTLE`n , %logurl%
			FFRK_click(193,313)
			}
		else
			{
			FileAppend , ERROR Fight exist at login - CANCEL BATTLE`n , %logurl%
			FFRK_click(70,313)
			}
		}	
	else
		{
		FFRK_failover()
		}
	}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; check FFRK Grey window error network 101 and close it
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
	emptyloop = 0
	Sleep 500
	}
	
; check image for lazy
FFRK_ConfirmImage(image,imagevar,toggle)
	{
	FFRK_state(ffrkaggro)
	Loop, 3
		{
		if (toggle = 1)
			{
			imageurl := A_ScriptDir "\image_custom\" image ".png"
			}
		else
			{
			imageurl := A_ScriptDir "\image\" image ".png"
			}
		imagevarb := "*" imagevar
		ImageSearch, , , 0, 0, %ffrk_window_width%, %ffrk_window_height%, %imagevarb% %imageurl%
		if ErrorLevel = 0
			Return ErrorLevel
		Sleep %SLP2%
		}
	Return ErrorLevel
	}

FFRK_failover()
	{
	emptyloop := emptyloop +1
	emptyloopmod := mod(emptyloop,failovermodulo)
	if (emptyloopmod = 0)
		{
		FileAppend , ERROR Macro did nothing for %emptyloop% turns`n , %logurl%
		}
	if (emptyloop > failoverreset)
		{
		FFRK_state(1)
		Sleep, %SLP1%
		If ( failoverscreenshot = 1)
			{
			send {LWin down}
			Sleep, 100
			send {PrintScreen down}
			Sleep, 100
			send {PrintScreen up}			
			Sleep, 100
			send {LWin up}
			Sleep, 3000
			}
		WinClose
		FileAppend , ERROR Macro seems to do nothing `n , %logurl%
		remRW = 0
		chRW = 0
		foRW = 0
		emptyloop = 0
		Sleep,1000
		If ( ffrkautostart = 0 )
			{
			msgbox, 48,ERROR,Macro seems to do nothing and autostart is desactivated !`n`nThis macro will close.
			FileAppend , FFRK and Macro will close`n , %logurl%
			sleep, 2000
			ExitApp
			}
		else
			{
			FileAppend , FFRK will restart`n , %logurl%
			}
			Sleep,9000
			}
	}


; find specific RW for MO mode
FFRK_RWfinder()
	{
	Loop
		{
		RWfind:
		ffrkMO6 := FFRK_ConfirmImage("ffrk_custom_common_6_unselectRW",imagevar,0)
		If (remRW = 0)
			;remove original RW before searching to avoid infinite loop
			{
			imageurl := A_ScriptDir "\image\ffrk_custom_common_6_unselectRW.png"
			ImageSearch, ffrkclicx, ffrkclicy, 0, 0, %ffrk_window_width%, %ffrk_window_height%, *80 %imageurl%
			ffrkclicx := ffrkclicx - ffrk_clic_width
			ffrkclicy := ffrkclicy - ffrk_clic_height
			FFRK_click(ffrkclicx,ffrkclicy)
			remRW = 1
			sleep,2000
			goto, RWfind
			}
		else If (remRW = 1 and chRW = 0)
			{
			ffrkMOc3 := FFRK_ConfirmImage("ffrk_custom_3_RW",80,1)
			if ( ffrkMOc3 = 0 )
				{
				imageurl := A_ScriptDir "\image_custom\ffrk_custom_3_RW.png"
				;msgbox imageurl %imageurl%
				ImageSearch, ffrkclicx, ffrkclicy, 0, 0, %ffrk_window_width%, %ffrk_window_height%, *80 %imageurl%
				ffrkclicx := ffrkclicx - ffrk_clic_width + 190
				ffrkclicy := ffrkclicy - ffrk_clic_height
				FFRK_click(ffrkclicx,ffrkclicy)
				chRW = 1
				rollRW = 0
				emptyloop = 0
				sleep,500
				goto, RWfind
				}
			else if (rollRW > 6)
				{
				rollRW = 0
				remRW = 0
				FFRK_click(246,139)
				sleep,1000
				break
				}
			else 
				{
				send, {WheelDown 3}
				rollRW := rollRW +1
				emptyloop = 0
				sleep,5000
				goto, RWfind
				}
			}
		else if (chRW = 1 and foRW = 0)
			{
			FFRK_click(138,466)
			foRW = 1
			emptyloop = 0
			sleep,2000
			goto, RWfind
			}
		else if (foRW = 1 and ffrkMOc3 != 0)
			{
			remRW = 0
			chRW = 0
			foRW = 0
			emptyloop = 0
			sleep,2000
			break
			}
		else
			{
			FFRK_failover()
			break
			}
		}
	}

