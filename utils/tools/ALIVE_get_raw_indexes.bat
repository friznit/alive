@echo off
set exe=DeWrp.exe -O
set arma=C:\Program Files (x86)\Steam\SteamApps\common\Arma 3\
set target=P:\x\alive\addons\sys_strategic\indexes

%exe% "%arma%\Addons\map_stratis.pbo" > %target%\objects.stratis.sqf

pause