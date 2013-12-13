@echo off

IF NOT EXIST P:\NUL GOTO MAP_P
subst P: /D 

:MAP_P
subst P: "C:\alive_dev"

rem pause