@echo off

IF NOT EXIST P:\NUL GOTO MAP_P
subst P: /D 

:MAP_P
subst P: "C:\Users\Wolffy.au\Documents\Arma 3 Alpha\Missions"

rem pause