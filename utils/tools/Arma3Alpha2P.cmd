@echo off
if not exist p:\ (goto installP)
if not exist extractpbo.exe (goto installpbo)

For /F "Tokens=2* skip=2" %%A In ('REG QUERY "HKLM\SOFTWARE\Wow6432Node\Bohemia Interactive Studio\Oxygen 2 Personal Edition" /v "MAIN"') Do (set _ARMA2PATH=%%B)
IF DEFINED _ARMA2PATH (GOTO found)
For /F "Tokens=2* skip=2" %%A In ('REG QUERY "HKLM\SOFTWARE\Bohemia Interactive Studio\Oxygen 2 Personal Edition" /v "MAIN"') Do (set _ARMA2PATH=%%B)
IF DEFINED _ARMA2PATH (GOTO found)
echo you must install BI's personal tools
pause
@exit /B 1
:installpbo
echo extractpbo is required
pause
@exit /B 1
:installP
echo P: drive must be set
pause
@exit /B 1
:found
rem Dta\bin.pbo
rem Dta\core.pbo
rem Dta\languagecore.pbo
rem Dta\languagecore_f.pbo
rem Dta\languagecore_h.pbo
rem Dta\product.bin

rem TODO: some sort of error with windows 7 and the slash in p:\ ???

rem unpacks all A2/OA/CO pbo's to the p: tree

rem ***************************************************
rem ********** YOU MUST HAVE P: set *******************
rem ***************************************************

rem run this cmd from same dir as extractpbo.exe
rem WARNING*WARNING*WARNING*WARNING*WARNING*WARNING*WARNING*WARNING*
rem WARNING: this bat obviously overwrites everything in p:\a3
rem WARNING*WARNING*WARNING*WARNING*WARNING*WARNING*WARNING*WARNING

SETLOCAL ENABLEEXTENSIONS
SET WRP_PROJECTS="P:\WRP_PROJECTS_A3"
rem ********************
rem find the arma3 path
rem ********************
:v64_path_a2
For /F "Tokens=2* skip=2" %%A In ('REG QUERY "HKLM\SOFTWARE\Wow6432Node\Bohemia Interactive\ArmA 3" /v "MAIN"') Do (set _ARMA3PATH=%%B)

IF NOT DEFINED _ARMA3PATH (GOTO v32_path_a2) ELSE (GOTO v64_path_a2oa)

:v32_path_a2

For /F "Tokens=2* skip=2" %%C In ('REG QUERY "HKLM\SOFTWARE\Bohemia Interactive Studio\ArmA 3" /v "MAIN"') Do (set _ARMA3PATH=%%D)

IF NOT DEFINED _ARMA3PATH (GOTO uac_PATH_A2) ELSE (GOTO v64_path_a2oa)

:uac_PATH_A2

@FOR /F "tokens=2* delims=	 " %%I IN ('REG QUERY "HKLM\SOFTWARE\Wow6432Node\Bohemia Interactive\ArmA 3" /v "MAIN"') DO (SET _ARMA3PATH=%%J)

IF NOT DEFINED _ARMA3PATH (GOTO std_PATH_A2) ELSE (GOTO v64_path_a2oa)

rem arma2 not there

:std_PATH_A2
@FOR /F "tokens=2* delims=	 " %%K IN ('REG QUERY "HKLM\SOFTWARE\Bohemia Interactive\ArmA 3" /v "MAIN"') DO (SET _ARMA3PATH=%%L)

IF NOT DEFINED _ARMA3PATH (GOTO ENDfailA2) ELSE (GOTO v64_path_a2oa)



:v64_path_a2oa
echo %_ARMA3PATH%

:run

rem for record keeping

if exist "%_ARMA3PATH%\Addons" (dir /b/s "%_ARMA3PATH%\Addons\*.pbo" >a3pbo.lst) 
if exist "%_ARMA3PATH%\Dta" (dir /b/s "%_ARMA3PATH%\Dta\*.pbo" >>a3pbo.lst)



:process

echo preserving personal edition shaders and hpp's
if not exist p:\bin (goto nobin)
if exist p:\pebin (rmdir /s/q p:\pebin)
ren p:\bin pebin
:nobin

echo removing folders. Expect this to take some time......

@echo off
if exist p:\a3 (rmdir /s/q p:\a3)
rem no need to remove languagecores plural, they're single files
rem if exist p:\languagecore (rmdir /s/q p:\languagecore)
if exist p:\core (rmdir /s/q p:\core)

if exist %WRP_PROJECTS% (rmdir /s/q %WRP_PROJECTS%)
if exist p:\a3_bin (rmdir /s/q p:\a3_bin)

echo extracting pbo's. expect THIS to take some time !!!.......

rem just do the entire folder in one go
extractpbo "%_ARMA3PATH%\Addons" p:\
extractpbo  "%_ARMA3PATH%\Dta" p:\

echo replacing with a3's bin config
rem ******** retrieve pe's bin stuff (except cpp) eg overwrite it shaders are pe********
rem the engine's config is installed, the shaders et al are personal tools stuff, left for buldozer
copy /y p:\bin\config.cpp p:\pebin
ren p:\bin a3_bin
ren p:\pebin bin
echo attaching product.bin
copy /y "%_ARMA3PATH%\Dta\product.bin" p:\


rem ******** fixup languagecore ***************
echo fixing stringtables
copy p:\languagecore\stringtable.xml p:\bin
rem can't do anything about _f and _h because they're called same thing


rem ************* copy all a3 configs to project folder ***************
echo creating a wrp projects folder
xcopy /s /y p:\a3\*.cpp "%WRP_PROJECTS%\a3\"
echo copy (or move) %WRP_PROJECTS%\a3 to "your projects folder"\a3




del a3pbo.lst
rem record keeping
:success
echo success 
pause
@exit /B 0

:err
:ENDfailA2
echo fail
pause

@exit /B 1

:ENDfailA2OA
pause
@exit /B 2