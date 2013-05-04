@echo off
rem set exe=echo
set exe=MakePBO.exe -A -Z -BD -L -G
set source=P:\x\alive\addons

FOR /F "tokens=1* delims=," %%A in ('dir %source% /ad /b') do (
	%exe% "%source%\%%A"
	if ERRORLEVEL 1 goto err
)

goto end

:err
pause

:end