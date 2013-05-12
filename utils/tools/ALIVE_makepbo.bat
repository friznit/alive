@echo off
rem set exe=echo
set exe=MakePBO.exe -A -BD -L -G
rem -Z
set source=P:\x\alive\addons
set target="C:\Program Files (x86)\Steam\SteamApps\common\Arma 3\@ALiVE\addons"

FOR /F "tokens=1* delims=," %%A in ('dir %source% /ad /b') do (
	%exe% "%source%\%%A"
	if ERRORLEVEL 1 goto err
)

move /Y %source%\*.pbo %target%\

goto end

:err
pause

:end