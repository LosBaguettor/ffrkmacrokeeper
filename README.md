# FFRK macro keeper

### Introduction

Hi everyone,

**Make sure to read everything before starting.**  

If anything unexpected happen, check if this issue already exist, if it doesn't, please generate one.  
Make sure to join a screenshot of the app (use Alt+PrintScreen then past in Paint, save it in PNG).  

This macro use image to work, if you have any permanent special settings activated (like forced AA) in your graphic card, this macro may not work, make sure to desactivate them if you do.

as a reminder, **FFRK AndApp** version only exist for the **Japanese version** of the game.

##

### Changelog

**V2.10**
**Major version update**  
Now include MO boss farming !  
You can now choose to farm a specific MO boss or fabul, see Mo Boss	Mode section for more detail.  

Added Timout error, totally forgot about this one...  

Failover has been reworked to make log less junky.  

DPI issue with the configurator has been fixed.  
an issue can still trigger with eGPU but this one **cannot be fixed** (it's a Windows issue).  

[WINDOWS 10 ONLY]  
Now include an auto printscreen function that will trigger if the failover is activated, the screenshot will be in your windows \Pictures\Screenshots\ folder.  
Crop the screenshot and join it to the issue report if that happen.  


**V2.02**  
Now include a massive failover.  
If autostart is desactivated and the failover triggers, the game will close which means the farm will stop complely.  
If autostart is activated and the failover triggers, the game will restart and try to continue farming.  

Now include a basic log function.  
If you don't want to use it, delete log folder, but this can help to find issues if the macro doesn't work for you.  
I'll rework it for next version for a more advanced version.  

Now include a way to continue or cancel the current fight if the game crash while fighting, see Configuration.  

##

### What does this macro do ?

- Farm Fabul dungeon or a defined MO boss when Stamina is higher than a defined threshold.
- Automatically start FFRK AndApp.
- Recover from (most) System Error.
- Recover from a Black Screen hang.
- Automatically Relog at daily reset.
- Automatically Relog the macro if you logged in from an other device if activated.
- Force quit any non-"Normal Dungeon" to go farm fabul if activated.
- Delay the start of the farm.

##

### How to use this Macro ? 

**Important note** : make sure the macro works with fabul (at least 3 fight in row) before trying to farm a MO boss.  
**Important note** : You need to run the configurator only the first time and after a new version update.  

- Install **AutoHotKey**
- Install **FFRK AndApp version** and **create a shortcut** on your **desktop** when asked.
- Launch **ffrk_configurator.ahk** and configure everything, see **Configuration** section for more info on what everything does and how to access the advanced functions.
- Launch **ffrk_macro_keeper.ahk** , read the instructions and press F1 to start.

##

### Configuration

There's 3 categories of settings, you can automatically generate 2 of them with the Configurator, the last one must be manually changed.

Format used below is the following : 

[Category]  
Name - effect

**[baguette]** : Related to the FFRK game
- **Crash Relog** - Recover from (most) system error.
- **Daily Relog** - Automatically relog at daily reset time.
- **Autostart** - Automatically Start FFRK if not launched, FFRK shortcut must exist on desktop.
- **Stamina% Kept** - You will always have at least this amount of stamina in %.

note : to recover from Black Screen hang both autostart and Crash Relog must be activated.

**[and]** : Related to the Macro itself
- **Aggressive Mode** - Before doing any action, the macro will always re-enforce the focus on FFRK window, highly recommanded.
- **Macro Mode** - Switch between Image and Pixel Mode (only Image Mode is available for now).
- **Condition Check** - Macro sensibility to consider things accurate, If the macro doesn't work, try to set it on "Low" before opening an issue, "Low" can lead to false positive or unexpected result.
- **WidthD** - Difference between Outside and Inside Window, default is for normal DPI on Windows 10.
- **HeightD** - Difference between Outside and Inside Window, default is for normal DPI on Windows 10.

To get your WidthD and HeightD :
- Launch FFRK AndApp
- Launch "Window Spy" or "Active Window Info" (it's a tool installed with AutoHotKey)
- Select FFRK window
- Look **Active window Position** (ATP) w & h value.
- WidthD : substract ATP top w value with ATP bottom w value.
- HeightD : substract ATP top h value with ATP bottom h value.

**[knuckles]** : Advanced settings, to edit them open **include** folder then **ffrk_macro.ini**
- **delaystart** - Value in msec before the macro really start, ex : 1 800 000 = start 30min after pressing F1. (default : 100)
- **dungeonforcequit** - set to 1 if you want the macro to force quit any non-"Normal Dungeon" (for fabul) or any non-"Event dungeon" (for MO Mode), you will lose your progress on this dungeon. (default : 0)
- **extdeviceforcerelog** - set to 1 if you want to the macro to relog after being kicked out because you logged on an other device. (default : 0)
- **blackscreentimer** - Number of Loop before the macro consider your game hanged on a Black Screen. (default : 25)
- **sleepspeed** - Reduce Macro sleep delay,  higher chance of unexpected result for non-standard value in case of Lag (default : 2)
- **rebootwhilefight** - set to 1 if you want to continue the fight if the game crash while in fight. (default : 0)
- **MOmode** - set to 1 if you want to farm a MO boss, **this setting requires specific changes, see MO Boss Mode section**. (default : 0)
- **failoverscreenshot** - set to 0 if you want to desactivate the automatic screenshot in case of failover. (default : 1 , automatically desactivated if you don't use Windows 10)

sleepspeed values :
- Very Fast : [0] , reduce most sleep by 85%.
- Fast : [1] , reduce most sleep by 50%.
- Normal : [2] , normal sleep time.

##

### MO Boss Mode

**Important note** :  
This mode will not work if you don't do these changes properly.  
Also no support will be given for this mode if you cannot set it up correctly.  
If fabul run correctly but not MO mode, it means you did something wrong on your side.  
Make sure your team can clear the stage in Auto.  
Make sure to correctly set your Auto settings.  
By default, the RW is God Wall, if you plan to use it, you don't need to create this image.  

How to use it :  

- Set MOmode to 1 in the ini file.
- Start the macro normally, the macro will hang in MO boss list, press F2 to close the macro.  
- DON'T CLOSE NOR RESIZE FFRK.
- Go to \image_custom\ folder.
- You need to create the 4 "ffrk_" file you need for the boss you want to farm.
- Check the equivalent "TUTO_ffrk_" file to know the appropriate area you need to create.

For each 4 files :  

- Go to the appropriate screen, press ALT+PRINTSCREEN.
- Paste in Paint.
- Crop the appropriate area.
- Save it with the appropriate "ffrk_" name.

Once done, Start the macro, if the macro hang, fix the appropriate image.  

##

### Credit

Macro by LosBaguettor  
Gui Generated with AutoGUI

