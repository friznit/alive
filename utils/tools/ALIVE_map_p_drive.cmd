@echo off

IF NOT EXIST P:\NUL GOTO MAP_P
subst P: /D 

:MAP_P
subst P: "C:\Users\Andy\Documents\Arma 3 - Other Profiles\ARJay\missions"

rem pause