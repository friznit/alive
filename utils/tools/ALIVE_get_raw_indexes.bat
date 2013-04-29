@echo off
set exe=DeWrp.exe -O
set arma=C:\Program Files (x86)\Steam\SteamApps\common\Arma 3\
set target=P:\x\alive\addons\fnc_strategic\indexes

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


pause