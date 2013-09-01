@echo off
rem set exe=echo
set exe=MakePBO.exe -A -BD -L -G
rem -Z

for /F "Tokens=2* skip=2" %%A In ('REG QUERY "HKLM\SOFTWARE\Wow6432Node\Bohemia Interactive Studio\ArmA 3" /v "MAIN"') do (set _FOUNDPATH_A3=%%B)
if defined _FOUNDPATH_A3 goto found_A3
 
for /F "Tokens=2* skip=2" %%A In ('REG QUERY "HKLM\SOFTWARE\Bohemia Interactive Studio\ArmA 3" /v "MAIN"') do (set _FOUNDPATH_A3=%%B)
if defined _FOUNDPATH_A3 goto found_A3
 
for /F "Tokens=2* skip=2" %%A In ('REG QUERY "HKLM\SOFTWARE\Wow6432Node\Bohemia Interactive\ArmA 3" /v "MAIN"') do (set _FOUNDPATH_A3=%%B)
if defined _FOUNDPATH_A3 goto found_A3
 
for /F "Tokens=2* skip=2" %%A In ('REG QUERY "HKLM\SOFTWARE\Bohemia Interactive\ArmA 3" /v "MAIN"') do (set _FOUNDPATH_A3=%%B)
if defined _FOUNDPATH_A3 goto found_A3

:found_A3
set _ARMA3_PATH=%_FOUNDPATH_A3%

set source=P:\x\alive\addons
set target="%_ARMA3_PATH%\@ALiVE\addons"

FOR /F "tokens=1* delims=," %%A in ('dir %source% /ad /b') do (
	%exe% "%source%\%%A"
	if ERRORLEVEL 1 goto err
)

del /Y %target%\*.pbo
move /Y %source%\*.pbo %target%\

goto end

:err
pause

:end