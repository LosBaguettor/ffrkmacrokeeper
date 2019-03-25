# FFRK macro keeper

### Introduction

Hi everyone,

**Make sure to read everything before starting.**  

If anything unexcepted happen, check if this issue already exist, if it doesn't, please generate one.  

as a reminder, **FFRK AndApp** version only exist for the **Japanese version** of the game.


##

### What does this macro do ?

- Farm Fabul dungeon when Stamina is higher than a defined threshold.
- Automatically start FFRK AndApp.
- Recover from (most) System Error.
- Recover from a Black Screen hang.
- Automatically Relog at daily reset if activated
- Automatically Relog the macro if you logged in from an other device if activated. (not done yet)
- Force quit any non-"Normal Dungeon" to go farm fabul if activated.
- Delay the start of the farm.

##

### How to use this Macro ?

- Install **AutoHotKey**
- Install **FFRK AndApp version** and **create a shortcut** on your **desktop** when asked.
- Launch **ffrk_configurator.ahk** and customize your standards settings, see **Configuration** section for more info on what everything does and how to access the advanced functions.
- Launch **ffrk_macro_keeper.ahk** , read the instructions and press F1 to start.

##

### Configuration

There's 3 categories of settings, you can automatically generate 2 of them with the Configurator, the last one must be manually changed.

Format used below is the following : 

[Category]  
Name - effect

**[baguette]** : Related to the FFRK game
- **Crash Relog** - Recover from (most) system error.
- **Daily Relog** - Automatically relog at daily reset time, desactivated by default.
- **Autostart** - Automatically Start FFRK if not launched, FFRK shortcut must exist on desktop.
- **Stamina% Kept** - You will always have at least this amount of stamina in %.

note : to recover from Black Screen hang both autostart and Crash Relog must be activated.

**[and]** : Related to the Macro itself
- **Aggressive Mode** - Before doing any action, the macro will always re-enforce the focus on FFRK window, highly recommanded.
- **Macro Mode** - Switch between Image and Pixel Mode (only Image Mode is available for now).
- **Condition Check** - Macro sensibility to considere things accurate, If the macro doesn't work, try to set it on "Low" before opening an issue, "Low" can lead to false positive or unexpected result.
- **WidthD** - Difference between Outside and Inside Window, only change if macro doesn't work or misclick.
- **HeightD** - Difference between Outside and Inside Window only change if macro doesn't work or misclick.

To get WidthD and HeightD, Launch FFRK AndApp, start "Active Window Info" 
- Launch FFRK AndApp
- Launch "Active Window Info" (it's a tool installed with AutoHotKey)
- Select FFRK window
- Look **Active window Position** (ATP) w & h value.
- WidthD : substract ATP top w value with ATP bottom w value.
- HeightD : substract ATP top h value with ATP bottom h value.

**[knuckles]** : Advanced settings, to edit them open **include** folder then **ffrk_macro.ini**
- **delaystart** - Value in msec before the macro really start, ex : 1 800 000 = start 30min after pressing F1. (default : 100)
- **dungeonforcequit** - set to 1 if you want the macro to force quit any non-"Normal Dungeon", you will lose your progress on this dungeon. (default : 0)
- **extdeviceforcerelog** - set to 1 if you want to the macro to relog after being kicked out because you logged on an other device. (default : 0)
- **blackscreentimer** - Number of Loop before the macro consider your game hanged on a Black Screen. (default : 25)

##

### Credit

Macro by LosBaguettor  
Gui Generated with AutoGUI

