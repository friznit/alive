rem
rem		Define your additional modfolders
rem

set _CUSTOM_MODS=@CBA_A3;@ALiVE


rem
rem		Adjust your parameters
rem

set _DEFAULT_PARAMETERS=-nosplash -config=server_A3.cfg -profiles=server
rem -nosplash -skipintro -world=empty -noFilePatching 

set _DEVELOPMENT_PARAMTERS=
rem -window -showScriptErrors

set _PROFILE_PARAMETERS=
rem "-profiles=%_ARMA3_PATH%" "-name=UserName"



rem ///////////////////////////////////////////////////////////////////////////
rem
rem DONT MODIFY ANYTHING BELOW
rem
rem ///////////////////////////////////////////////////////////////////////////


rem Find A3
 
for /F "Tokens=2* skip=2" %%A In ('REG QUERY "HKLM\SOFTWARE\Wow6432Node\Bohemia Interactive Studio\ArmA 3" /v "MAIN"') do (set _FOUNDPATH_A3=%%B)
if defined _FOUNDPATH_A3 goto found_A3
 
for /F "Tokens=2* skip=2" %%A In ('REG QUERY "HKLM\SOFTWARE\Bohemia Interactive Studio\ArmA 3" /v "MAIN"') do (set _FOUNDPATH_A3=%%B)
if defined _FOUNDPATH_A3 goto found_A3
 
for /F "Tokens=2* skip=2" %%A In ('REG QUERY "HKLM\SOFTWARE\Wow6432Node\Bohemia Interactive\ArmA 3" /v "MAIN"') do (set _FOUNDPATH_A3=%%B)
if defined _FOUNDPATH_A3 goto found_A3
 
for /F "Tokens=2* skip=2" %%A In ('REG QUERY "HKLM\SOFTWARE\Bohemia Interactive\ArmA 3" /v "MAIN"') do (set _FOUNDPATH_A3=%%B)
if defined _FOUNDPATH_A3 goto found_A3
 
for /F "Tokens=2* skip=2" %%A In ('REG QUERY "HKLM\SOFTWARE\Wow6432Node\Valve\Steam" /v "InstallPath"') do (set _FOUNDPATH_A3=%%B\steamapps\common\Arma 3)
if defined _FOUNDPATH_A3 goto found_A3
 
for /F "Tokens=2* skip=2" %%A In ('REG QUERY "HKLM\SOFTWARE\Valve\Steam" /v "InstallPath"') do (set _FOUNDPATH_A3=%%B\steamapps\common\Arma 3)
if defined _FOUNDPATH_A3 goto found_A3

:found_A3
set _ARMA3_PATH=%_FOUNDPATH_A3%


rem Find A1
 
for /F "Tokens=2* skip=2" %%A In ('REG QUERY "HKLM\SOFTWARE\Wow6432Node\Bohemia Interactive Studio\ArmA" /v "MAIN"') do (set _FOUNDPATH_A1=%%B)
if defined _FOUNDPATH_A1 goto found_A1
 
for /F "Tokens=2* skip=2" %%A In ('REG QUERY "HKLM\SOFTWARE\Bohemia Interactive Studio\ArmA" /v "MAIN"') do (set _FOUNDPATH_A1=%%B)
if defined _FOUNDPATH_A1 goto found_A1

:found_A1
set _ARMA1_PATH=%_FOUNDPATH_A1%


rem Find A2
 
for /F "Tokens=2* skip=2" %%A In ('REG QUERY "HKLM\SOFTWARE\Wow6432Node\Bohemia Interactive Studio\ArmA 2" /v "MAIN"') do (set _FOUNDPATH_A2=%%B)
if defined _FOUNDPATH_A2 goto found_A2
 
for /F "Tokens=2* skip=2" %%A In ('REG QUERY "HKLM\SOFTWARE\Bohemia Interactive Studio\ArmA 2" /v "MAIN"') do (set _FOUNDPATH_A2=%%B)
if defined _FOUNDPATH_A2 goto found_A2

:found_A2
set _ARMA2_PATH=%_FOUNDPATH_A2%


rem Find OA
 
for /F "Tokens=2* skip=2" %%A In ('REG QUERY "HKLM\SOFTWARE\Wow6432Node\Bohemia Interactive Studio\ArmA 2 OA" /v "MAIN"') do (set _FOUNDPATH_OA=%%B)
if defined _FOUNDPATH_OA goto found_OA
 
for /F "Tokens=2* skip=2" %%A In ('REG QUERY "HKLM\SOFTWARE\Bohemia Interactive Studio\ArmA 2 OA" /v "MAIN"') do (set _FOUNDPATH_OA=%%B)
if defined _FOUNDPATH_OA goto found_OA

:found_OA
set _ARMA2OA_PATH=%_FOUNDPATH_OA%


rem Find TKOH
 
for /F "Tokens=2* skip=2" %%A In ('REG QUERY "HKLM\SOFTWARE\Wow6432Node\Bohemia Interactive Studio\Take On Helicopters" /v "MAIN"') do (set _FOUNDPATH_TKOH=%%B)
if defined _FOUNDPATH_TKOH goto found_TKOH
 
for /F "Tokens=2* skip=2" %%A In ('REG QUERY "HKLM\SOFTWARE\Bohemia Interactive Studio\Take On Helicopters" /v "MAIN"') do (set _FOUNDPATH_TKOH=%%B)
if defined _FOUNDPATH_TKOH goto found_TKOH

:found_TKOH
set _TKOH_PATH=%_FOUNDPATH_TKOH%



rem ///////////////////////////////////////////////////////////////////////////

cd /D "%_ARMA3_PATH%"

arma3Retail_Server.exe %_DEFAULT_PARAMETERS% %_DEVELOPMENT_PARAMTERS% %_PROFILE_PARAMETERS% "-mod=%_CUSTOM_MODS%;%_ARMA2OA_PATH%\@LIB_DLC_1;%_ARMA2OA_PATH%\@IF_Other_Addons;%_ARMA2OA_PATH%\@IF;@AllInArma\ProductDummies;@AllInArma\A1Dummies;%_ARMA2_PATH%;%_ARMA2OA_PATH%;%_ARMA2OA_PATH%\Expansion;%_ARMA3_PATH%;@AllInArma\Core;%_ARMA2OA_PATH%\@IFA3M;@IFA3;@AllInArma\PostA3"

exit