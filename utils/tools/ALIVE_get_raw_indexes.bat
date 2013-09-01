@echo off
set exe=DeWrp.exe -O

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

set arma=%_ARMA3PATH%

set target=P:\x\alive\addons\fnc_strategic\indexes

%exe% "%arma%\Addons\map_altis.pbo" > %target%\objects.altis.sqf
%exe% "%arma%\Addons\map_stratis.pbo" > %target%\objects.stratis.sqf

%exe% "%arma%\@a2co\Addons\chernarus.pbo" > %target%\objects.chernarus.sqf
%exe% "%arma%\@a2co\Addons\utes.pbo" > %target%\objects.utes.sqf
%exe% "%arma%\@a2co\Expansion\Addons\desert_e.pbo" > %target%\objects.desert_e.sqf
%exe% "%arma%\@a2co\Expansion\Addons\takistan.pbo" > %target%\objects.takistan.sqf
%exe% "%arma%\@a2co\Expansion\Addons\zargabad.pbo" > %target%\objects.zargabad.sqf
%exe% "%arma%\@a2co\Common\provinggrounds_pmc.pbo" > %target%\objects.provinggrounds_pmc.sqf
%exe% "%arma%\@a2co\Common\shapur_baf.pbo" > %target%\objects.shapur_baf.sqf

rem %exe% "%arma%\@a2co\@CWR2\Addons\cwr2_abel.pbo" > %target%\objects.abel.sqf
rem %exe% "%arma%\@a2co\@CWR2\Addons\cwr2_cain.pbo" > %target%\objects.cain.sqf
rem %exe% "%arma%\@a2co\@CWR2\Addons\cwr2_eden.pbo" > %target%\objects.eden.sqf
rem %exe% "%arma%\@a2co\@CWR2\Addons\cwr2_noe.pbo" > %target%\objects.noe.sqf
rem %exe% "%arma%\@a2co\@carraigdubh\Addons\carraigdubh.pbo" > %target%\objects.carraigdubh.sqf
rem %exe% "%arma%\@a2co\@CLAfghan\Addons\clafghan.pbo" > %target%\objects.clafghan.sqf
rem %exe% "%arma%\@a2co\@fallujah\Addons\fallujah1_2.pbo" > %target%\objects.fallujah.sqf
rem %exe% "%arma%\@a2co\@FDF_Podagorsk\Addons\fdf_isle1_a.pbo" > %target%\objects.fdf_isle1_a.sqf
rem %exe% "%arma%\@a2co\@isla_duala\Addons\isladuala.pbo" > %target%\objects.isladuala.sqf
rem %exe% "%arma%\@a2co\@Lingor\Addons\lingor.pbo" > %target%\objects.lingor.sqf
rem %exe% "%arma%\@a2co\@MBG_Celle\Addons\celle.pbo" > %target%\objects.celle.sqf
rem %exe% "%arma%\@a2co\@mcn_hazarkot\Addons\mcn_hazarkot.pbo" > %target%\objects.mcn_hazarkot.sqf
rem @namalsk %exe% "%arma%\@a2co\@CLAfghan\Addons\clafghan.pbo" > %target%\objects.clafghan.sqf
rem @NGS_Capraia %exe% "%arma%\@a2co\@CLAfghan\Addons\clafghan.pbo" > %target%\objects.clafghan.sqf
rem @Thirsk %exe% "%arma%\@a2co\@CLAfghan\Addons\clafghan.pbo" > %target%\objects.clafghan.sqf
rem %exe% "%arma%\@a2co\@tigeria\Addons\tigeria.pbo" > %target%\objects.tigeria.sqf
rem %exe% "%arma%\@a2co\@tigeria\Addons\tigeria_se.pbo" > %target%\objects.tigeria_se.sqf
rem %exe% "%arma%\@a2co\@ToraBora\Addons\torabora.pbo" > %target%\objects.torabora.sqf
rem %exe% "%arma%\@a2co\@TUP\Addons\tup_qom.pbo" > %target%\objects.tup_qom.sqf
rem %exe% "%arma%\@a2co\@vostok\Addons\vostok.pbo" > %target%\objects.vostok.sqf
rem %exe% "%arma%\@a2co\@vostok\Addons\vostok_w.pbo" > %target%\objects.vostok_w.sqf


:err
:ENDfailA2
pause