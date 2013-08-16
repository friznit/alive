_logic = _this select ((count _this)-1);
_logic setvariable ["HAC_HQ", GrpNull];
_logic setvariable ["HAC_HQ", group _logic];

_logic kbAddTopic ["orders","\x\alive\addons\sys_HAC\topics.bikb",""];
waituntil {(_logic kbHasTopic "orders")};

_logic setvariable ["HAC_HQ_Cyclecount", 0];

waituntil {not (isNull (_logic getvariable "HAC_HQ"))};

_logic setvariable ["HAC_HQ_PersDone", false];
[_logic,"personality",(_logic getvariable ["HAC_HQ_Personality","GENIUS"])] call ALiVE_fnc_HAC;
waituntil {_logic getvariable "HAC_HQ_PersDone"};

_logic setvariable ["HAC_HQ_LHQInit", false];
[_logic] spawn ALiVE_fnc_HAC_LHQ;
waituntil {_logic getvariable "HAC_HQ_LHQInit"};

if (isNil {_logic getvariable "HAC_HQ_Boxed"}) then {_logic setvariable ["HAC_HQ_Boxed", []]};
if (isNil {_logic getvariable "HAC_HQ_AmmoBoxes"}) then 
	{
	_logic setvariable ["HAC_HQ_AmmoBoxes", []];

	if not (isNil {_logic getvariable "HAC_HQ_AmmoDepot"}) then 
		{
		_rds = (triggerArea (_logic getvariable "HAC_HQ_AmmoDepot")) select 0;
		_logic setvariable ["HAC_HQ_AmmoBoxes",(getposATL (_logic getvariable "HAC_HQ_AmmoDepot")) nearObjects ["ReammoBox",_rds]];
		}
	};

[_logic] spawn ALiVE_fnc_HAC_HQReset;
[_logic] spawn ALiVE_fnc_HAC_Rev;
[_logic] spawn ALiVE_fnc_HAC_SuppMed;
[_logic] spawn ALiVE_fnc_HAC_SuppFuel;
[_logic] spawn ALiVE_fnc_HAC_SuppAmmo;
[_logic] spawn ALiVE_fnc_HAC_SuppRep;
[_logic] spawn ALiVE_fnc_HAC_SFIdleOrd;
[_logic] spawn ALiVE_fnc_HAC_Reloc;
[_logic] spawn ALiVE_fnc_HAC_LPos;

_specFor = (_logic getvariable "RHQ_SpecFor") + ["RUS_Soldier_Sab","RUS_Soldier_GL","RUS_Soldier_Marksman","RUS_Commander","RUS_Soldier1","RUS_Soldier2","RUS_Soldier3","RUS_Soldier_TL"] - (_logic getvariable "RHQs_SpecFor");
_recon = (_logic getvariable "RHQ_Recon") + ["FR_TL","FR_Sykes","FR_R","FR_Rodriguez","FR_OHara","FR_Miles","FR_Marksman","FR_AR","FR_GL","FR_AC","FR_Sapper","FR_Corpsman","FR_Cooper","FR_Commander","FR_Assault_R","FR_Assault_GL","USMC_SoldierS_Spotter","USMC_SoldierS","MQ9PredatorB","CDF_Soldier_Spotter","RU_Soldier_Spotter","RUS_Soldier3","Pchela1T","GUE_Soldier_Scout"] - (_logic getvariable "RHQs_Recon");
_FO = (_logic getvariable "RHQ_FO") + ["USMC_SoldierS_Spotter","CDF_Soldier_Spotter","RU_Soldier_Spotter","Ins_Soldier_CO","GUE_Soldier_Scout"] - (_logic getvariable "RHQs_FO");
_snipers = (_logic getvariable "RHQ_Snipers") + ["USMC_SoldierS_Sniper","USMC_SoldierS_SniperH","USMC_SoldierM_Marksman","FR_Marksman","CDF_Soldier_Sniper","CDF_Soldier_Marksman","RU_Soldier_Marksman","RU_Soldier_Sniper","RU_Soldier_SniperH","MVD_Soldier_Marksman","MVD_Soldier_Sniper","RUS_Soldier_Marksman","Ins_Soldier_Sniper","GUE_Soldier_Sniper"] - (_logic getvariable "RHQs_Snipers");
_ATinf = (_logic getvariable "RHQ_ATInf") + ["USMC_Soldier_HAT","USMC_Soldier_AT","USMC_Soldier_LAT","HMMWV_TOW","CDF_Soldier_RPG","RU_Soldier_HAT","RU_Soldier_AT","RU_Soldier_LAT","MVD_Soldier_AT","Ins_Soldier_AT","GUE_Soldier_AT"] - (_logic getvariable "RHQs_ATInf");
_AAinf = (_logic getvariable "RHQ_AAInf") + ["USMC_Soldier_AA","HMMWV_Avenger","CDF_Soldier_Strela","Ural_ZU23_CDF","RU_Soldier_AA","2S6M_Tunguska","Ins_Soldier_AA","ZSU_INS","Ural_ZU23_INS","GUE_Soldier_AA","Ural_ZU23_Gue"] - (_logic getvariable "RHQs_AAInf");
_Inf = (_logic getvariable "RHQ_Inf") + ["GUE_Commander","GUE_Soldier_Scout","GUE_Soldier_Sab","GUE_Soldier_AA","GUE_Soldier_AT","GUE_Soldier_1","GUE_Soldier_2","GUE_Soldier_3","GUE_Soldier_Pilot","GUE_Soldier_Medic","GUE_Soldier_MG","GUE_Soldier_Sniper","GUE_Soldier_GL","GUE_Soldier_Crew","GUE_Soldier_CO","GUE_Soldier_AR","Ins_Woodlander1","Ins_Villager4","Ins_Worker2","Ins_Woodlander2","Ins_Woodlander3","Ins_Villager3","Ins_Soldier_Sniper","Ins_Soldier_Sapper","Ins_Soldier_Sab","Ins_Soldier_2","Ins_Soldier_1","Ins_Soldier_Pilot","Ins_Soldier_CO","Ins_Soldier_Medic","Ins_Soldier_MG","Ins_Bardak","Ins_Soldier_GL","Ins_Soldier_Crew","Ins_Commander","Ins_Lopotev","Ins_Soldier_AR","Ins_Soldier_AT","Ins_Soldier_AA","RUS_Soldier_TL","RUS_Soldier3","RUS_Soldier2","RUS_Soldier1","RUS_Commander","RUS_Soldier_Marksman","RUS_Soldier_GL","RUS_Soldier_Sab","MVD_Soldier_TL","MVD_Soldier_Sniper","MVD_Soldier_AT","MVD_Soldier_GL","MVD_Soldier","MVD_Soldier_Marksman","MVD_Soldier_MG","RU_Soldier_TL","RU_Soldier_SL","RU_Soldier_Spotter","RU_Soldier_SniperH","RU_Soldier_Sniper","RU_Soldier2","RU_Soldier_AT","RU_Soldier_LAT","RU_Soldier","RU_Soldier_Pilot","RU_Soldier_Officer","RU_Soldier_Medic","RU_Soldier_Marksman","RU_Soldier_MG","RU_Soldier_GL","RU_Commander","RU_Soldier_Crew","RU_Soldier_AR","RU_Soldier_HAT","RU_Soldier_AA","CDF_Soldier_TL","CDF_Soldier_Spotter","CDF_Soldier_Light","CDF_Soldier_Sniper","CDF_Soldier","CDF_Soldier_Pilot","CDF_Soldier_Officer","CDF_Soldier_Militia","CDF_Soldier_Medic","CDF_Soldier_Marksman","CDF_Soldier_MG","CDF_Soldier_GL","CDF_Commander","CDF_Soldier_Engineer","CDF_Soldier_Crew","CDF_Soldier_AR","CDF_Soldier_RPG","CDF_Soldier_Strela","FR_TL","FR_Sykes","FR_R","FR_Rodriguez","FR_OHara","FR_Miles","FR_Marksman","FR_AR","FR_GL","FR_AC","FR_Sapper","FR_Corpsman","FR_Cooper","FR_Commander","FR_Assault_R","FR_Assault_GL","USMC_Soldier_SL","USMC_SoldierS_Spotter","USMC_SoldierS_SniperH","USMC_SoldierS_Sniper","USMC_SoldierS","USMC_Soldier_LAT","USMC_Soldier2","USMC_Soldier","USMC_Soldier_Pilot","USMC_Soldier_Officer","USMC_Soldier_MG","USMC_Soldier_GL","USMC_Soldier_TL","USMC_SoldierS_Engineer","USMC_SoldierM_Marksman","USMC_Soldier_Crew","USMC_Soldier_Medic","USMC_Soldier_AR","USMC_Soldier_AT","USMC_Soldier_HAT","USMC_Soldier_AA"] - (_logic getvariable "RHQs_Inf");
_Art = (_logic getvariable "RHQ_Art") + ["2b14_82mm_GUE","2b14_82mm_INS","GRAD_INS","2b14_82mm","D30_RU","GRAD_RU","2b14_82mm_CDF","D30_CDF","GRAD_CDF","MLRS","M252","M119"] - (_logic getvariable "RHQs_Art");
_HArmor = (_logic getvariable "RHQ_HArmor") + ["T72_Gue","T34","T72_INS","T90","T72_RU","T72_CDF","M1A1","M1A2_TUSK_MG"] - (_logic getvariable "RHQs_HArmor");
_MArmor = (_logic getvariable "RHQ_MArmor") + ["T34","BMP2_Gue","BMP2_INS","BMP2_CDF","BMP3"] - (_logic getvariable "RHQs_MArmor");
_LArmor = (_logic getvariable "RHQ_LArmor") + ["BRDM2_HQ_Gue","BRDM2_Gue","BMP2_Gue","ZSU_INS","BRDM2_ATGM_INS","BRDM2_INS","BMP2_HQ_INS","BMP2_INS","GAZ_Vodnik_HMG","GAZ_Vodnik","BTR90_HQ","BTR90","BMP3","2S6M_Tunguska","ZSU_CDF","BRDM2_ATGM_CDF","BRDM2_CDF","BMP2_HQ_CDF","BMP2_CDF","LAV25_HQ","LAV25","AAV"] - (_logic getvariable "RHQs_LArmor");
_LArmorAT = (_logic getvariable "RHQ_LArmorAT") + ["BMP2_Gue","BRDM2_ATGM_INS","BMP2_INS","BTR90","BMP3","BRDM2_ATGM_CDF","BMP2_CDF"] - (_logic getvariable "RHQs_LArmorAT");
_Cars = (_logic getvariable "RHQ_Cars") + ["Ural_ZU23_Gue","V3S_Gue","Pickup_PK_GUE","Offroad_SPG9_Gue","Offroad_DSHKM_Gue","TT650_Gue","UralRepair_INS","UralRefuel_INS","UralReammo_INS","BMP2_Ambul_INS","Ural_ZU23_INS","UralOpen_INS","Ural_INS","UAZ_SPG9_INS","UAZ_MG_INS","UAZ_AGS30_INS","UAZ_INS","Pickup_PK_INS","Offroad_DSHKM_INS","TT650_Ins","GRAD_INS","GAZ_Vodnik_MedEvac","KamazRepair","KamazRefuel","KamazReammo","KamazOpen","Kamaz","UAZ_AGS30_RU","UAZ_RU","GRAD_RU","UralRepair_CDF","UralRefuel_CDF","UralReammo_CDF","BMP2_Ambul_CDF","Ural_ZU23_CDF","UralOpen_CDF","Ural_CDF","UAZ_MG_CDF","UAZ_AGS30_CDF","UAZ_CDF","GRAD_CDF","MtvrRepair","MtvrRefuel","MtvrReammo","HMMWV_Ambulance","TowingTractor","MTVR","MMT_USMC","M1030","HMMWV_Avenger","HMMWV_TOW","HMMWV_MK19","HMMWV_Armored","HMMWV_M2","HMMWV"] - (_logic getvariable "RHQs_Cars");
_Air = (_logic getvariable "RHQ_Air") + ["Mi17_medevac_Ins","Su25_Ins","Mi17_Ins","Mi17_medevac_RU","Su34","Su39","Pchela1T","Mi17_rockets_RU","Mi24_V","Mi24_P","Ka52Black","Ka52","Mi17_medevac_CDF","Su25_CDF","Mi24_D","Mi17_CDF","MV22","C130J","MQ9PredatorB","AH64D","UH1Y","MH60S","F35B","AV8B","AV8B2","AH1Z","A10"] - (_logic getvariable "RHQs_Air");
_BAir = (_logic getvariable "RHQ_BAir") + [] - (_logic getvariable "RHQs_BAir");
_RAir = (_logic getvariable "RHQ_RAir") + ["Pchela1T","MQ9PredatorB"] - (_logic getvariable "RHQs_RAir");
_NCAir = (_logic getvariable "RHQ_NCAir") + ["Mi17_medevac_Ins","Mi17_medevac_RU","Pchela1T","Mi17_medevac_CDF","MV22","C130J","MQ9PredatorB"] - (_logic getvariable "RHQs_NCAir");
_Naval = (_logic getvariable "RHQ_Naval") + ["PBX","RHIB2Turret","RHIB","Zodiac"] - (_logic getvariable "RHQs_Naval");
_Static = (_logic getvariable "RHQ_Static") + ["GUE_WarfareBMGNest_PK","ZU23_Gue","SPG9_Gue","2b14_82mm_GUE","DSHKM_Gue","Ins_WarfareBMGNest_PK","ZU23_Ins","SPG9_Ins","2b14_82mm_INS","DSHkM_Mini_TriPod","DSHKM_Ins","D30_Ins","AGS_Ins","RU_WarfareBMGNest_PK","CDF_WarfareBMGNest_PK","USMC_WarfareBMGNest_M240","2b14_82mm","Metis","KORD","KORD_high","D30_RU","AGS_RU","Igla_AA_pod_East","ZU23_CDF","SPG9_CDF","2b14_82mm_CDF","DSHkM_Mini_TriPod_CDF","DSHKM_CDF","D30_CDF","AGS_CDF","TOW_TriPod","MK19_TriPod","M2HD_mini_TriPod","M252","M2StaticMG","M119","Stinger_Pod","Fort_Nest_M240"] - (_logic getvariable "RHQs_Static");
_StaticAA = (_logic getvariable "RHQ_StaticAA") + ["ZU23_Gue","ZU23_Ins","Igla_AA_pod_East","ZU23_CDF","Stinger_Pod"] - (_logic getvariable "RHQs_StaticAA");
_StaticAT = (_logic getvariable "RHQ_StaticAT") + ["SPG9_Gue","SPG9_Ins","Metis","SPG9_CDF","TOW_TriPod"] - (_logic getvariable "RHQs_StaticAT");
_Support = (_logic getvariable "RHQ_Support") + ["UralRepair_INS","UralRefuel_INS","UralReammo_INS","Mi17_medevac_Ins","BMP2_Ambul_INS","GAZ_Vodnik_MedEvac","KamazRepair","KamazRefuel","Mi17_medevac_RU","KamazReammo","UralRepair_CDF","UralRefuel_CDF","UralReammo_CDF","Mi17_medevac_CDF","BMP2_Ambul_CDF","MtvrRepair","MtvrRefuel","MtvrReammo","HMMWV_Ambulance","MH60S"] - (_logic getvariable "RHQs_Support");
_Cargo = (_logic getvariable "RHQ_Cargo") + ["V3S_Gue","Pickup_PK_GUE","Offroad_SPG9_Gue","Offroad_DSHKM_Gue","BRDM2_HQ_Gue","BRDM2_Gue","BMP2_Gue","Mi17_medevac_Ins","BMP2_Ambul_INS","UralOpen_INS","Ural_INS","UAZ_SPG9_INS","UAZ_MG_INS","UAZ_AGS30_INS","UAZ_INS","Pickup_PK_INS","Offroad_DSHKM_INS","BRDM2_ATGM_INS","BRDM2_INS","BMP2_HQ_INS","BMP2_INS","Mi17_Ins","GAZ_Vodnik_MedEvac","Mi17_medevac_RU","PBX","KamazOpen","Kamaz","UAZ_AGS30_RU","UAZ_RU","GAZ_Vodnik_HMG","GAZ_Vodnik","BTR90_HQ","BTR90","BMP3","Mi17_rockets_RU","Mi17_medevac_CDF","BMP2_Ambul_CDF","UralOpen_CDF","Ural_CDF","UAZ_MG_CDF","UAZ_AGS30_CDF","UAZ_CDF","BRDM2_ATGM_CDF","BRDM2_CDF","BMP2_HQ_CDF","BMP2_CDF","Mi17_CDF","HMMWV_Ambulance","RHIB2Turret","RHIB","Zodiac","MTVR","HMMWV_TOW","HMMWV_MK19","HMMWV_Armored","HMMWV_M2","HMMWV","LAV25_HQ","LAV25","AAV","UH1Y","MH60S","MV22","C130J"] - (_logic getvariable "RHQs_Cargo");
_NCCargo = (_logic getvariable "RHQ_NCCargo") + ["V3S_Gue","Mi17_medevac_Ins","BMP2_Ambul_INS","UralOpen_INS","Ural_INS","UAZ_INS","GAZ_Vodnik_MedEvac","Mi17_medevac_RU","PBX","KamazOpen","Kamaz","UAZ_RU","Mi17_medevac_CDF","BMP2_Ambul_CDF","UralOpen_CDF","Ural_CDF","UAZ_CDF","HMMWV_Ambulance","Zodiac","MTVR","HMMWV","MV22","C130J"] - (_logic getvariable "RHQs_NCCargo");
_Crew = (_logic getvariable "RHQ_Crew") + ["GUE_Soldier_Pilot","INS_Soldier_Pilot","RU_Soldier_Pilot","CDF_Soldier_Pilot","USMC_Soldier_Pilot","GUE_Soldier_Crew","INS_Soldier_Crew","RU_Soldier_Crew","CDF_Soldier_Crew","USMC_Soldier_Crew"] - (_logic getvariable "RHQs_Crew");
_Other = (_logic getvariable "RHQ_Other") + [];
_NCrewInf = _Inf - _Crew;
_Cargo = _Cargo - (_Support - ["MH60S"]);

_logic setvariable ["HAC_HQ_NCVeh",_NCCargo + (_Support - ["MH60S"])];

[(_snipers + _ATinf + _AAinf),_logic] spawn ALiVE_fnc_HAC_Garrison;

_logic setvariable ["HAC_HQ_ReconDone", false];
_logic setvariable ["HAC_HQ_DefDone", false];
_logic setvariable ["HAC_HQ_ReconStage", 1];
_logic setvariable ["HAC_HQ_KnEnPos", []];
_logic setvariable ["HAC_HQ_AirInDef", []];
if (isNil {_logic getvariable "HAC_HQ_Excluded"}) then {_logic setvariable ["HAC_HQ_Excluded", []]};
if (isNil {_logic getvariable "HAC_HQ_Fast"}) then {_logic setvariable ["HAC_HQ_Fast", false]};
if (isNil {_logic getvariable "HAC_HQ_ExInfo"}) then {_logic setvariable ["HAC_HQ_ExInfo", false]};
if (isNil {_logic getvariable "HAC_HQ_ObjHoldTime"}) then {_logic setvariable ["HAC_HQ_ObjHoldTime", 600]};
if (isNil {_logic getvariable "HAC_HQ_NObj"}) then {_logic setvariable ["HAC_HQ_NObj", 1]};

_logic setvariable ["HAC_HQ_Init",true];
_logic setvariable ["HAC_HQ_Inertia",0];
_logic setvariable ["HAC_HQ_Morale",0];
_logic setvariable ["HAC_HQ_CInitial",0];
_logic setvariable ["HAC_HQ_CLast",0];
_logic setvariable ["HAC_HQ_CCurrent",0];
_logic setvariable ["HAC_HQ_CIMoraleC",0];
_logic setvariable ["HAC_HQ_CLMoraleC",0];
_logic setvariable ["HAC_HQ_Surrender",false];
_logic setvariable ["HAC_HQ_FirstEMark",true];
_logic setvariable ["HAC_HQ_LastE",0];
_logic setvariable ["HAC_HQ_FlankingInit",false];
_logic setvariable ["HAC_HQ_FlankingDone",false];
_logic setvariable ["HAC_HQ_Progress",0];
_logic setvariable ["HAC_HQ_AAthreat",[]];
_logic setvariable ["HAC_HQ_ATthreat",[]];
_logic setvariable ["HAC_HQ_Airthreat",[]];
_logic setvariable ["HAC_HQ_Exhausted",[]];

_lastHQ = _logic;
_OLmpl = 0;
_cycleCap = 0;
_firstMC = 0; 
_wp = [];

//diag_log format ["Init HQSITREP Part 1 ended %1",time];

while {not ((isNull (_logic getvariable "HAC_HQ")) or ((_logic getvariable "HAC_HQ_Surrender")))} do
	{
    //diag_log format ["Init HQSITREP Part 2 started %1",time];
	if not ((_logic getvariable "HAC_HQ_Fast")) then {waituntil {sleep 0.1;(_logic getvariable "HAC_xHQ_Done")};
	if (isNil {_logic getvariable "HAC_HQ_SupportWP"}) then {_logic setvariable ["HAC_HQ_SupportWP", false]};

	if ((_logic getvariable "HAC_HQ_Cyclecount") > 1) then
		{
		if not (_lastHQ == _logic) then {sleep (60 + (random 60))};
		};

	_lastHQ = _logic;
	_logic setvariable ["HAC_HQ_Cyclecount",(_logic getvariable "HAC_HQ_Cyclecount") + 1];
	_logic setvariable ["HAC_xHQ_Done",false];
	_logic setvariable ["HAC_HQ_SpecFor",[]];
	_logic setvariable ["HAC_HQ_recon",[]];
	_logic setvariable ["HAC_HQ_FO",[]];
	_logic setvariable ["HAC_HQ_snipers",[]];
	_logic setvariable ["HAC_HQ_ATinf",[]];
	_logic setvariable ["HAC_HQ_AAinf",[]];
	_logic setvariable ["HAC_HQ_Inf",[]];
	_logic setvariable ["HAC_HQ_Art",[]];
	_logic setvariable ["HAC_HQ_HArmor",[]];
	_logic setvariable ["HAC_HQ_MArmor",[]];
	_logic setvariable ["HAC_HQ_LArmor",[]];
	_logic setvariable ["HAC_HQ_LArmorAT",[]];
	_logic setvariable ["HAC_HQ_Cars",[]];
	_logic setvariable ["HAC_HQ_Air",[]];
	_logic setvariable ["HAC_HQ_BAir",[]];
	_logic setvariable ["HAC_HQ_RAir",[]];
	_logic setvariable ["HAC_HQ_NCAir",[]];
	_logic setvariable ["HAC_HQ_Naval",[]];
	_logic setvariable ["HAC_HQ_Static",[]];
	_logic setvariable ["HAC_HQ_StaticAA",[]];
	_logic setvariable ["HAC_HQ_StaticAT",[]];
	_logic setvariable ["HAC_HQ_Support",[]];
	_logic setvariable ["HAC_HQ_Cargo",[]];
	_logic setvariable ["HAC_HQ_NCCargo",[]];
	_logic setvariable ["HAC_HQ_Other",[]];
	_logic setvariable ["HAC_HQ_Crew",[]];
	_logic setvariable ["HAC_HQ_NCrewInf",[]];
	_logic setvariable ["HAC_HQ_SpecForG",[]];
	_logic setvariable ["HAC_HQ_reconG",[]];
	_logic setvariable ["HAC_HQ_FOG",[]];
	_logic setvariable ["HAC_HQ_snipersG",[]];
	_logic setvariable ["HAC_HQ_ATinfG",[]];
	_logic setvariable ["HAC_HQ_AAinfG",[]];
	_logic setvariable ["HAC_HQ_InfG",[]];
	_logic setvariable ["HAC_HQ_ArtG",[]];
	_logic setvariable ["HAC_HQ_HArmorG",[]];
	_logic setvariable ["HAC_HQ_MArmorG",[]];
	_logic setvariable ["HAC_HQ_LArmorG",[]];
	_logic setvariable ["HAC_HQ_LArmorATG",[]];
	_logic setvariable ["HAC_HQ_CarsG",[]];
	_logic setvariable ["HAC_HQ_AirG",[]];
	_logic setvariable ["HAC_HQ_BAirG",[]];
	_logic setvariable ["HAC_HQ_RAirG",[]];
	_logic setvariable ["HAC_HQ_NCAirG",[]];
	_logic setvariable ["HAC_HQ_NavalG",[]];
	_logic setvariable ["HAC_HQ_StaticG",[]];
	_logic setvariable ["HAC_HQ_StaticAAG",[]];
	_logic setvariable ["HAC_HQ_StaticATG",[]];
	_logic setvariable ["HAC_HQ_SupportG",[]];
	_logic setvariable ["HAC_HQ_CargoG",[]];
	_logic setvariable ["HAC_HQ_NCCargoG",[]];
	_logic setvariable ["HAC_HQ_OtherG",[]];
	_logic setvariable ["HAC_HQ_CrewG",[]];
	_logic setvariable ["HAC_HQ_NCrewInfG",[]];
	_logic setvariable ["HAC_HQ_EnSpecFor",[]];
	_logic setvariable ["HAC_HQ_Enrecon",[]];
	_logic setvariable ["HAC_HQ_EnFO",[]];
	_logic setvariable ["HAC_HQ_Ensnipers",[]];
	_logic setvariable ["HAC_HQ_EnATinf",[]];
	_logic setvariable ["HAC_HQ_EnAAinf",[]];
	_logic setvariable ["HAC_HQ_EnInf",[]];
	_logic setvariable ["HAC_HQ_EnArt",[]];
	_logic setvariable ["HAC_HQ_EnHArmor",[]];
	_logic setvariable ["HAC_HQ_EnMArmor",[]];
	_logic setvariable ["HAC_HQ_EnLArmor",[]];
	_logic setvariable ["HAC_HQ_EnLArmorAT",[]];
	_logic setvariable ["HAC_HQ_EnCars",[]];
	_logic setvariable ["HAC_HQ_EnAir",[]];
	_logic setvariable ["HAC_HQ_EnBAir",[]];
	_logic setvariable ["HAC_HQ_EnRAir",[]];
	_logic setvariable ["HAC_HQ_EnNCAir",[]];
	_logic setvariable ["HAC_HQ_EnNaval",[]];
	_logic setvariable ["HAC_HQ_EnStatic",[]];
	_logic setvariable ["HAC_HQ_EnStaticAA",[]];
	_logic setvariable ["HAC_HQ_EnStaticAT",[]];
	_logic setvariable ["HAC_HQ_EnSupport",[]];
	_logic setvariable ["HAC_HQ_EnCargo",[]];
	_logic setvariable ["HAC_HQ_EnNCCargo",[]];
	_logic setvariable ["HAC_HQ_EnOther",[]];
	_logic setvariable ["HAC_HQ_EnCrew",[]];
	_logic setvariable ["HAC_HQ_EnNCrewInf",[]];
	_logic setvariable ["HAC_HQ_EnSpecForG",[]];
	_logic setvariable ["HAC_HQ_EnreconG",[]];
	_logic setvariable ["HAC_HQ_EnFOG",[]];
	_logic setvariable ["HAC_HQ_EnsnipersG",[]];
	_logic setvariable ["HAC_HQ_EnATinfG",[]];
	_logic setvariable ["HAC_HQ_EnAAinfG",[]];
	_logic setvariable ["HAC_HQ_EnInfG",[]];
	_logic setvariable ["HAC_HQ_EnArtG",[]];
	_logic setvariable ["HAC_HQ_EnHArmorG",[]];
	_logic setvariable ["HAC_HQ_EnMArmorG",[]];
	_logic setvariable ["HAC_HQ_EnLArmorG",[]];
	_logic setvariable ["HAC_HQ_EnLArmorATG",[]];
	_logic setvariable ["HAC_HQ_EnCarsG",[]];
	_logic setvariable ["HAC_HQ_EnAirG",[]];
	_logic setvariable ["HAC_HQ_EnBAirG",[]];
	_logic setvariable ["HAC_HQ_EnRAirG",[]];
	_logic setvariable ["HAC_HQ_EnNCAirG",[]];
	_logic setvariable ["HAC_HQ_EnNavalG",[]];
	_logic setvariable ["HAC_HQ_EnStaticG",[]];
	_logic setvariable ["HAC_HQ_EnStaticAAG",[]];
	_logic setvariable ["HAC_HQ_EnStaticATG",[]];
	_logic setvariable ["HAC_HQ_EnSupportG",[]];
	_logic setvariable ["HAC_HQ_EnCargoG",[]];
	_logic setvariable ["HAC_HQ_EnNCCargoG",[]];
	_logic setvariable ["HAC_HQ_EnOtherG",[]];
	_logic setvariable ["HAC_HQ_EnCrewG",[]];
	_logic setvariable ["HAC_HQ_EnNCrewInfG",[]];
	_logic setvariable ["HAC_HQ_LastE", count (_logic getvariable "HAC_HQ_KnEnemies")];
	_logic setvariable ["HAC_HQ_LastFriends",(_logic getvariable "HAC_HQ_Friends")];

	if (isNil {_logic getvariable "HAC_HQ_NoAirCargo"}) then {_logic setvariable ["HAC_HQ_NoAirCargo",false]};
	if (isNil {_logic getvariable "HAC_HQ_NoLandCargo"}) then {_logic setvariable ["HAC_HQ_NoLandCargo",false]};
	if (isNil {_logic getvariable "HAC_HQ_LastFriends"}) then {_logic setvariable ["HAC_HQ_LastFriends",[]]};
	if (isNil {_logic getvariable "HAC_HQ_CargoFind"}) then {_logic setvariable ["HAC_HQ_CargoFind",0]};
	if (isNil {_logic getvariable "HAC_HQ_Subordinated"}) then {_logic setvariable ["HAC_HQ_Subordinated",[]]};
	if (isNil {_logic getvariable "HAC_HQ_Included"}) then {_logic setvariable ["HAC_HQ_Included",[]]};
	if (isNil {_logic getvariable "HAC_HQ_ExcludedG"}) then {_logic setvariable ["HAC_HQ_ExcludedG",[]]};
	if (isNil {_logic getvariable "HAC_HQ_SubAll"}) then {_logic setvariable ["HAC_HQ_SubAll",true]};
	if (isNil {_logic getvariable "HAC_HQ_SubSynchro"}) then {_logic setvariable ["HAC_HQ_SubSynchro",false]};
	if (isNil {_logic getvariable "HAC_HQ_SubNamed"}) then {_logic setvariable ["HAC_HQ_SubNamed",false]};
	if (isNil {_logic getvariable "HAC_HQ_SubZero"}) then {_logic setvariable ["HAC_HQ_SubZero",false]};
	if (isNil {_logic getvariable "HAC_HQ_ReSynchro"}) then {_logic setvariable ["HAC_HQ_ReSynchro",true]};
	if (isNil {_logic getvariable "HAC_HQ_NameLimit"}) then {_logic setvariable ["HAC_HQ_NameLimit",100]};
	if (isNil {_logic getvariable "HAC_HQ_Surr"}) then {_logic setvariable ["HAC_HQ_Surr",false]};
	if (isNil {_logic getvariable "HAC_HQ_AOnly"}) then {_logic setvariable ["HAC_HQ_AOnly",[]]};
	if (isNil {_logic getvariable "HAC_HQ_ROnly"}) then {_logic setvariable ["HAC_HQ_ROnly",[]]};
	if (isNil {_logic getvariable "HAC_HQ_CargoOnly"}) then {_logic setvariable ["HAC_HQ_CargoOnly",[]]};
	if (isNil {_logic getvariable "HAC_HQ_NoCargo"}) then {_logic setvariable ["HAC_HQ_NoCargo",[]]};
	if (isNil {_logic getvariable "HAC_HQ_NoFlank"}) then {_logic setvariable ["HAC_HQ_NoFlank",[]]};
	if (isNil {_logic getvariable "HAC_HQ_NoDef"}) then {_logic setvariable ["HAC_HQ_NoDef",[]]};
	if (isNil {_logic getvariable "HAC_HQ_FirstToFight"}) then {_logic setvariable ["HAC_HQ_FirstToFight",[]]};
	if (isNil {_logic getvariable "HAC_HQ_VoiceComm"}) then {_logic setvariable ["HAC_HQ_VoiceComm",true]};
	if (isNil {_logic getvariable "HAC_HQ_Front"}) then {_logic setvariable ["HAC_HQ_Front",false]};
	if (isNil {_logic getvariable "HAC_HQ_LRelocating"}) then {_logic setvariable ["HAC_HQ_LRelocating",false]};
	if (isNil {_logic getvariable "HAC_HQ_Flee"}) then {_logic setvariable ["HAC_HQ_Flee",true]};
	if (isNil {_logic getvariable "HAC_HQ_GarrR"}) then {_logic setvariable ["HAC_HQ_GarrR",500]};
	if (isNil {_logic getvariable "HAC_HQ_Rush"}) then {_logic setvariable ["HAC_HQ_Rush",false]};
	if (isNil {_logic getvariable "HAC_HQ_GarrVehAb"}) then {_logic setvariable ["HAC_HQ_GarrVehAb",false]};
	if (isNil {_logic getvariable "HAC_HQ_DefendObjectives"}) then {_logic setvariable ["HAC_HQ_DefendObjectives",4]};
	if (isNil {_logic getvariable "HAC_HQ_DefSpot"}) then {_logic setvariable ["HAC_HQ_DefSpot",[]]};
	if (isNil {_logic getvariable "HAC_HQ_RecDefSpot"}) then {_logic setvariable ["HAC_HQ_RecDefSpot",[]]};
	if (isNil {_logic getvariable "HAC_HQ_Flare"}) then {_logic setvariable ["HAC_HQ_Flare",true]};
	if (isNil {_logic getvariable "HAC_HQ_Smoke"}) then {_logic setvariable ["HAC_HQ_Smoke",true]};
	if (isNil {_logic getvariable "HAC_HQ_NoRec"}) then {_logic setvariable ["HAC_HQ_NoRec",1]};
	if (isNil {_logic getvariable "HAC_HQ_RapidCapt"}) then {_logic setvariable ["HAC_HQ_RapidCapt",10]};
	if (isNil {_logic getvariable "HAC_HQ_Muu"}) then {_logic setvariable ["HAC_HQ_Muu",1]};
	if (isNil {_logic getvariable "HAC_HQ_ArtyShells"}) then {_logic setvariable ["HAC_HQ_ArtyShells",120]};
	if (isNil {_logic getvariable "HAC_HQ_Withdraw"}) then {_logic setvariable ["HAC_HQ_Withdraw",1]};
	if (isNil {_logic getvariable "HAC_HQ_Berserk"}) then {_logic setvariable ["HAC_HQ_Berserk",false]};
	if (isNil {_logic getvariable "HAC_HQ_IDChance"}) then {_logic setvariable ["HAC_HQ_IDChance",100]};
	if (isNil {_logic getvariable "HAC_HQ_RDChance"}) then {_logic setvariable ["HAC_HQ_RDChance",100]};
	if (isNil {_logic getvariable "HAC_HQ_SDChance"}) then {_logic setvariable ["HAC_HQ_SDChance",100]};
	if (isNil {_logic getvariable "HAC_HQ_AmmoDrop"}) then {_logic setvariable ["HAC_HQ_AmmoDrop",[]]};
	if (isNil {_logic getvariable "HAC_HQ_SFTargets"}) then {_logic setvariable ["HAC_HQ_SFTargets",[]]};
	if (isNil {_logic getvariable "HAC_HQ_LZ"}) then {_logic setvariable ["HAC_HQ_LZ",false]};
	if (isNil {_logic getvariable "HAC_HQ_SFBodyGuard"}) then {_logic setvariable ["HAC_HQ_SFBodyGuard",[]]};
	if (isNil {_logic getvariable "HAC_HQ_DynForm"}) then {_logic setvariable ["HAC_HQ_DynForm",false]};
	if (isNil {_logic getvariable "HAC_HQ_UnlimitedCapt"}) then {_logic setvariable ["HAC_HQ_UnlimitedCapt",false]};
	if (isNil {_logic getvariable "HAC_HQ_CaptLimit"}) then {_logic setvariable ["HAC_HQ_CaptLimit",10]};
	if (isNil {_logic getvariable "HAC_HQ_GetHQInside"}) then {_logic setvariable ["HAC_HQ_GetHQInside",false]};

	_logic setvariable ["HAC_HQ_Friends", []];
	_logic setvariable ["HAC_HQ_Enemies", []];
	_logic setvariable ["HAC_HQ_KnEnemies", []];
	_logic setvariable ["HAC_HQ_KnEnemiesG", []];
	_logic setvariable ["HAC_HQ_FValue", 0];
	_logic setvariable ["HAC_HQ_EValue", 0];

	if ((_logic getvariable "HAC_xHQ_AIChatDensity") > 0) then
		{
		_varName1 = "HAC_AIChatRep";
		_varName2 = "_West";

		switch ((side (_logic getvariable "HAC_HQ"))) do
			{
			case (east) : {_varName2 = "_East"};
			case (resistance) : {_varName2 = "_Guer"};
			};

		missionNamespace setVariable [_varName1 + _varName2,0];

		_varName1 = "HAC_AIChatLT";

		missionNamespace setVariable [_varName1 + _varName2,[0,""]]
		};

	if ((_logic getvariable "HAC_HQ_NObj") == 1) then {_logic setvariable ["HAC_HQ_Obj", (_logic getvariable "HAC_HQ_Obj1")]};
	if ((_logic getvariable "HAC_HQ_NObj") == 2) then {_logic setvariable ["HAC_HQ_Obj", (_logic getvariable "HAC_HQ_Obj2")]};
	if ((_logic getvariable "HAC_HQ_NObj") == 3) then {_logic setvariable ["HAC_HQ_Obj", (_logic getvariable "HAC_HQ_Obj3")]};
	if ((_logic getvariable "HAC_HQ_NObj") >= 4) then {_logic setvariable ["HAC_HQ_Obj", (_logic getvariable "HAC_HQ_Obj4")]};

	_logic setvariable ["HAC_HQ_LastSub", (_logic getvariable "HAC_HQ_Subordinated")];
	_logic setvariable ["HAC_HQ_Subordinated",[]];

	_civF = ["CIV","CIV_RU","BIS_TK_CIV","BIS_CIV_special"];
	if not (isNil {_logic getvariable "HAC_HQ_CivF"}) then {_civF = (_logic getvariable "HAC_HQ_CivF")};

		{
		_isCaptive = _x getVariable ("isCaptive" + (str _x));
		if (isNil "_isCaptive") then {_isCaptive = false};

		_isCiv = false;
		if ((faction (leader _x)) in _civF) then {_isCiv = true};
		if not ((isNull (_logic)) and not (isNull _x) and (alive (_logic)) and (alive (leader _x)) and not (_isCaptive)) then
			{
			if (not ((_logic getvariable "HAC_HQ_Front")) and ((side _x) getFriend (side (_logic getvariable "HAC_HQ")) < 0.6) and not (_isCiv)) then {if not (_x in (_logic getvariable "HAC_HQ_Enemies")) then {_logic setvariable ["HAC_HQ_Enemies",(_logic getvariable "HAC_HQ_Enemies") + [_x]]}};
			if (((_logic getvariable "HAC_HQ_Front")) and ((side _x) getFriend (side (_logic getvariable "HAC_HQ")) < 0.6) and ((getposATL (vehicle (leader _x))) in (_logic getvariable "FrontA")) and not (_isCiv)) then {if not (_x in (_logic getvariable "HAC_HQ_Enemies")) then {_logic setvariable ["HAC_HQ_Enemies",(_logic getvariable "HAC_HQ_Enemies") + [_x]]}};
			if ((_logic getvariable "HAC_HQ_SubAll")) then 
				{
				if not ((side _x) getFriend (side (_logic getvariable "HAC_HQ")) < 0.6) then 
					{
					if (not (_x in (_logic getvariable "HAC_HQ_Friends")) and not (((leader _x) in (_logic getvariable "HAC_HQ_Excluded")) or (_isCiv))) then {_logic setvariable ["HAC_HQ_Enemies",(_logic getvariable "HAC_HQ_Enemies") + [_x]]}
					};
				};
			}
		}
	foreach allGroups;

	_logic setvariable ["HAC_HQ_Excl", []];

		{
		if not ((group _x) in (_logic getvariable "HAC_HQ_Excl")) then {_logic setvariable ["HAC_HQ_Excl",(_logic getvariable "HAC_HQ_Excl") + [group _x]]} 
		}
	foreach (_logic getvariable "HAC_HQ_Excluded");

	if ((_logic getvariable "HAC_HQ_SubSynchro")) then 
		{
			{
			if ((_x in (_logic getvariable "HAC_HQ_LastSub")) and not ((leader _x) in (synchronizedObjects _logic)) and ((_logic getvariable "HAC_HQ_ReSynchro"))) then {_logic setvariable ["HAC_HQ_Subordinated",(_logic getvariable "HAC_HQ_Subordinated") + [_x]]};
			if (not (_x in (_logic getvariable "HAC_HQ_Subordinated")) and ((leader _x) in (synchronizedObjects _logic))) then {_logic setvariable ["HAC_HQ_Subordinated",(_logic getvariable "HAC_HQ_Subordinated") + [_x]]};
			}
		foreach allGroups;
		};

	if ((_logic getvariable "HAC_HQ_SubNamed")) then 
		{
			{
			for [{_i = 1},{_i <= (_logic getvariable "HAC_HQ_NameLimit")},{_i = _i + 1}] do
				{
				if (not (_x in (_logic getvariable "HAC_HQ_Subordinated")) and ((str (leader _x)) == ("HAC_" + str (_i)))) then {_logic setvariable ["HAC_HQ_Subordinated",(_logic getvariable "HAC_HQ_Subordinated") + [_x]]};
				};
			}
		foreach allGroups;
		};

	if ((_logic getvariable "HAC_HQ_SubZero")) then 
		{
			{
			if (((random 100) >= 50) and not (_x in (_logic getvariable "HAC_HQ_Subordinated"))) then {_logic setvariable ["HAC_HQ_Subordinated",(_logic getvariable "HAC_HQ_Subordinated") + [_x]]} else {if (not (_x in (_logic getvariable "HAC_HQB_Subordinated"))) then {_logic setvariable ["HAC_HQ_Subordinated",(_logic getvariable "HAC_HQ_Subordinated") + [_x]]}};
			}
		foreach allGroups;
		};

    _logic setvariable ["HAC_HQ_Friends", (_logic getvariable "HAC_HQ_Friends") + (_logic getvariable "HAC_HQ_Subordinated") + (_logic getvariable "HAC_HQ_Included") - ((_logic getvariable "HAC_HQ_ExcludedG") + (_logic getvariable "HAC_HQ_Excl"))];
	_logic setvariable ["HAC_HQ_Friends", (_logic getvariable "HAC_HQ_Friends") - [(_logic getvariable "HAC_HQ")]];
	_logic setvariable ["HAC_HQ_NoWayD", allGroups - (_logic getvariable "HAC_HQ_LastFriends")];

	_logic setvariable ["HAC_HQ_Friends", [(_logic getvariable "HAC_HQ_Friends"),_logic] call ALiVE_fnc_HAC_RandomOrd];

		{
		[_x,_logic] call ALiVE_fnc_HAC_WPdel;
		}
	foreach (((_logic getvariable "HAC_HQ_Excl") + (_logic getvariable "HAC_HQ_ExcludedG")) - (_logic getvariable "HAC_HQ_NoWayD"));

	if ((_logic getvariable "HAC_HQ_Init")) then 
		{
			{
			_logic setvariable ["HAC_HQ_CInitial", (_logic getvariable "HAC_HQ_CInitial") + (count (units _x))];
			}
		foreach ((_logic getvariable "HAC_HQ_Friends") + [(_logic getvariable "HAC_HQ")])
		};

	_logic setvariable ["HAC_HQ_CLast", (_logic getvariable "HAC_HQ_CCurrent")];
	_logic setvariable ["HAC_HQ_CCurrent", 0];
		{
		_logic setvariable ["HAC_HQ_CCurrent", (_logic getvariable "HAC_HQ_CCurrent") + (count (units _x))];
		}
	foreach (_logic getvariable "HAC_HQ_Friends") + [(_logic getvariable "HAC_HQ")];

	/* Raps modified for new group caching project, not to be mistaken with profile caching of all units, this will only hash cache sub-ordinates under the group leader - this will include CEP caching units to the total so HAC does not think that all the unita are killed. */
	if (!isNil "cep_unit_count") then {
		_logic setvariable ["HAC_HQ_CCurrent", (_logic getvariable "HAC_HQ_CCurrent") + cep_unit_count];
	};
	
	_logic setvariable ["HAC_HQ_Ex", []];

	if ((_logic getvariable "HAC_HQ_ExInfo")) then 
		{
		_logic setvariable ["HAC_HQ_Ex", (_logic getvariable "HAC_HQ_Excl") + (_logic getvariable "HAC_HQ_ExcludedG")];
		};

		{
		for [{_a = 0},{_a < count (units _x)},{_a = _a + 1}] do
			{
			_enemyU = vehicle ((units _x) select _a);
				{
				if ((_x knowsAbout _enemyU) >= 0.05) exitwith 
					{
					if not (_enemyU in (_logic getvariable "HAC_HQ_KnEnemies")) then 
						{
						(_logic getvariable "HAC_HQ_KnEnemies") set [(count (_logic getvariable "HAC_HQ_KnEnemies")),_enemyU];
						};

					if not ((group _enemyU) in (_logic getvariable "HAC_HQ_KnEnemiesG")) then 
						{
						_already = missionnameSpace getVariable ["AlreadySpotted",[]];
						_logic setvariable ["HAC_HQ_KnEnemiesG", (_logic getvariable "HAC_HQ_KnEnemiesG") + [group _enemyU]];
						if not ((group _enemyU) in _already) then
							{
							_UL = (leader _x);if not (isPlayer _UL) then {if ((random 100) < (_logic getvariable "HAC_xHQ_AIChatDensity")) then {[_UL,(_logic getvariable "HAC_xHQ_AIC_EnemySpot"),"EnemySpot",_logic] call ALiVE_fnc_HAC_AIChatter}};
							}
						}
					} 
				}
			foreach ((_logic getvariable "HAC_HQ_Friends") + [(_logic getvariable "HAC_HQ")] + (_logic getvariable "HAC_HQ_Ex"))
			}
		}
	foreach (_logic getvariable "HAC_HQ_Enemies");

	_already = missionnameSpace getVariable ["AlreadySpotted",[]];

		{
		if not (_x in _already) then
			{
			_already set [(count _already),_x]
			}
		}
	foreach (_logic getvariable "HAC_HQ_KnEnemiesG");

	missionnameSpace setVariable ["AlreadySpotted",_already];

	_lossFinal = (_logic getvariable "HAC_HQ_CInitial") - (_logic getvariable "HAC_HQ_CCurrent");
	if (_lossFinal < 0) then {_lossFinal = 0;_logic setvariable ["HAC_HQ_CInitial", (_logic getvariable "HAC_HQ_CCurrent")]};

	if not ((_logic getvariable "HAC_HQ_Init")) then 
		{
		_lossP = _lossFinal/(_logic getvariable "HAC_HQ_CInitial");

		if ((_OLmpl == 0) and ((count (_logic getvariable "HAC_HQ_KnEnemies")) > 0)) then
			{
			_OLmpl = 0.01;
			_firstMC = (_logic getvariable "HAC_HQ_Cyclecount") - 1
			};

		if ((_cycleCap < (50 / (1.01 - _lossP))) and ((count (_logic getvariable "HAC_HQ_KnEnemies")) == 0) and (_OLmpl == 0.01)) then
			{
			_cycleCap = _cycleCap + 1;
			if ((random 1) < _lossP) then {_firstMC = _firstMC + 1}
			}
		else
			{
			if not ((count (_logic getvariable "HAC_HQ_KnEnemies")) == 0) then
				{
				_cycleCap = 0;
				}
			};

		
		_lossPerc = _lossP * 100;
		_cycle = (_logic getvariable "HAC_HQ_Cyclecount") - _firstMC;

		_OLF = _OLmpl * (((-(_lossPerc * _lossPerc))/(1.1^_cycle)) + ((15 + (random 5) + (random 5))/(1 + _lossP)) - (_lossP * 10) + (_cycle ^ ((10 * (1 - _lossP))/_cycle)));

		_mplLU = 1;
		_lostU = (_logic getvariable "HAC_HQ_CLast") - (_logic getvariable "HAC_HQ_CCurrent");
		if (_lostU < 0) then {_lostU = - _lostU;_mplLU = -1};

		_lossL = _mplLU * ((100 * _lostU/(_logic getvariable "HAC_HQ_CInitial"))^(1.55 + (random 0.05) + (random 0.05)))/10;

		_balanceF = 0.5 + (random 0.5) + (random 0.5) - _lossP - (count (_logic getvariable "HAC_HQ_KnEnemies"))/(_logic getvariable "HAC_HQ_CCurrent");

		_logic setvariable ["HAC_HQ_Morale",(_logic getvariable "HAC_HQ_Morale") + (_OLF - _lossL + _balanceF)];
		//HAC_HQ_Morale = HAC_HQ_Morale + (((HAC_HQ_CCurrent - HAC_HQ_CInitial) * (6/(1 + (HAC_HQ_Cyclecount/25)))) + (6 * ((random 0.5) + HAC_HQ_CCurrent - HAC_HQ_CLast)))/((1 + (10*HAC_HQ_CInitial))/(1 + ((count (_logic getvariable "HAC_HQ_KnEnemies")) * 0.5)));
		//diag_log format ["Init: %2, Last: %3, Current: %3,Zmiana morale: %1",(((HAC_HQ_CCurrent - HAC_HQ_CInitial) * (6/(1 + (HAC_HQ_Cyclecount/25)))) + (6 * ((random 0.5) + HAC_HQ_CCurrent - HAC_HQ_CLast)))/((1 + (10*HAC_HQ_CInitial))/(1 + ((count (_logic getvariable "HAC_HQ_KnEnemies")) * 0.5))),HAC_HQ_CInitial,HAC_HQ_CLast,HAC_HQ_CCurrent];
		};

	if ((_logic getvariable "HAC_HQ_Morale") < -50) then {_logic setvariable ["HAC_HQ_Morale", -50]};
	if ((_logic getvariable "HAC_HQ_Morale") > 0) then {_logic setvariable ["HAC_HQ_Morale", 0]};
	if (_logic getvariable "HAC_HQ_Debug") then 
		{
		_mdbg = format ["Morale %5 (%2): %1 - losses: %3 percent (%4)",(_logic getvariable "HAC_HQ_Morale"),(_logic getvariable "HAC_HQ_Personality"),(round (((_lossFinal/(_logic getvariable "HAC_HQ_CInitial")) * 100) * 10)/10),_lossFinal,_logic];
		diag_log _mdbg;
		_logic globalChat _mdbg;

		_cl = "<t color='#007f00'>A -> M: %1 - L: %2%3</t>";

		switch (side (_logic getvariable "HAC_HQ")) do
			{
			case (west) : {_cl = "<t color='#0d81c4'>A -> M: %1 - L: %2%3</t>"};
			case (east) : {_cl = "<t color='#ff0000'>A -> M: %1 - L: %2%3</t>"};
			};

		_dbgMon = parseText format [_cl,(round ((_logic getvariable "HAC_HQ_Morale") * 10))/10,(round (((_lossFinal/(_logic getvariable "HAC_HQ_CInitial")) * 100) * 10)/10),"%"];

		(_logic getvariable "HAC_HQ") setVariable ["DbgMon",_dbgMon];
		};

	if ((_logic getvariable "HAC_HQ_Init")) then {[(_logic getvariable "HAC_HQ"),_logic] spawn ALiVE_fnc_HAC_Desperado};

	_logic setvariable ["HAC_HQ_Init", false];

		{
			{
			_SpecForcheck = false;
			_reconcheck = false;
			_FOcheck = false;
			_sniperscheck = false;
			_ATinfcheck = false;
			_AAinfcheck = false;
			_Infcheck = false;
			_Artcheck = false;
			_HArmorcheck = false;
			_MArmorcheck = false;
			_LArmorcheck = false;
			_LArmorATcheck = false;
			_Carscheck = false;
			_Aircheck = false;
			_BAircheck = false;
			_RAircheck = false;
			_NCAircheck = false;
			_Navalcheck = false;
			_Staticcheck = false;
			_StaticAAcheck = false;
			_StaticATcheck = false;
			_Supportcheck = false;
			_Cargocheck = false;
			_NCCargocheck = false;
			_Othercheck = true;

			_Crewcheck = false;
			_NCrewInfcheck = false;

			_tp = typeOf _x;
			_grp = group _x;
			_vh = vehicle _x;
			_asV = assignedvehicle _x;
			_grpD = group (assignedDriver _asV);
			_grpG = group (assignedGunner _asV);
			if (isNull _grpD) then {_grpD = _grpG};
			_Tvh = typeOf _vh;
			_TasV = typeOf _asV;
            
			if (((_grp == _grpD) and (_TasV in _specFor)) or (_tp in _specFor)) then {_SpecForcheck = true;_Othercheck = false};
			if (((_grp == _grpD) and (_TasV in _recon)) or (_tp in _recon)) then {_reconcheck = true;_Othercheck = false};
			if (((_grp == _grpD) and (_TasV in _FO)) or (_tp in _FO)) then {_FOcheck = true;_Othercheck = false};
			if (((_grp == _grpD) and (_TasV in _snipers)) or (_tp in _snipers)) then {_sniperscheck = true;_Othercheck = false};
			if (((_grp == _grpD) and (_TasV in _ATinf)) or (_tp in _ATinf)) then {_ATinfcheck = true;_Othercheck = false};
			if (((_grp == _grpD) and (_TasV in _AAinf)) or (_tp in _AAinf)) then {_AAinfcheck = true;_Othercheck = false};
			if (((_grp == _grpD) and (_TasV in _Inf)) or (_tp in _Inf)) then {_Infcheck = true;_Othercheck = false};
			if (((_grp == _grpD) and (_TasV in _Art)) or (_tp in _Art)) then {_Artcheck = true;_Othercheck = false;};
			if (((_grp == _grpD) and (_TasV in _HArmor)) or (_tp in _HArmor)) then {_HArmorcheck = true;_Othercheck = false};
			if (((_grp == _grpD) and (_TasV in _MArmor)) or (_tp in _MArmor)) then {_MArmorcheck = true;_Othercheck = false};
			if (((_grp == _grpD) and (_TasV in _LArmor)) or (_tp in _LArmor)) then {_LArmorcheck = true;_Othercheck = false};
			if (((_grp == _grpD) and (_TasV in _LArmorAT)) or (_tp in _LArmorAT)) then {_LArmorATcheck = true;_Othercheck = false};
			if (((_grp == _grpD) and (_TasV in _Cars)) or (_tp in _Cars)) then {_Carscheck = true;_Othercheck = false};
			if (((_grp == _grpD) and (_TasV in _Air)) or (_tp in _Air)) then {_Aircheck = true;_Othercheck = false};
			if (((_grp == _grpD) and (_TasV in _BAir)) or (_tp in _BAir)) then {_BAircheck = true;_Othercheck = false};
			if (((_grp == _grpD) and (_TasV in _RAir)) or (_tp in _RAir)) then {_RAircheck = true;_Othercheck = false};
			if (((_grp == _grpD) and (_TasV in _NCAir)) or (_tp in _NCAir)) then {_NCAircheck = true;_Othercheck = false};
			if (((_grp == _grpD) and (_TasV in _Naval)) or (_tp in _Naval)) then {_Navalcheck = true;_Othercheck = false};
			if (((_grp == _grpG) and (_TasV in _Static)) or (_tp in _Static)) then {_Staticcheck = true;_Othercheck = false};
			if (((_grp == _grpG) and (_TasV in _StaticAA)) or (_tp in _StaticAA)) then {_StaticAAcheck = true;_Othercheck = false};
			if (((_grp == _grpG) and (_TasV in _StaticAT)) or (_tp in _StaticAT)) then {_StaticATcheck = true;_Othercheck = false};
			if (((_grp == _grpD) and (_TasV in _Cargo)) or (_tp in _Cargo)) then {_Cargocheck = true;_Othercheck = false};
			if (((_grp == _grpD) and (_TasV in _NCCargo)) or (_tp in _NCCargo)) then {_NCCargocheck = true;_Othercheck = false};
			if (((_grp == _grpD) and (_TasV in _Crew)) or (_tp in _Crew)) then {_Crewcheck = true;_Othercheck = false};
			if (((_grp == _grpD) and (_TasV in _NCrewInf)) or (_tp in _NCrewInf)) then {_NCrewInfcheck = true;_Othercheck = false};
			if (((_grp == _grpD) and (_TasV in _Support)) or (_tp in _Support)) then {_Supportcheck = true;_NCrewInfcheck = false;_Othercheck = false};
			
			if ((_TasV in _NCCargo) and (_x == (assignedDriver _asV)) and ((count (units (group _x))) == 1) and not ((_ATinfcheck) or (_AAinfcheck) or (_reconcheck) or (_FOcheck) or (_sniperscheck))) then {_NCrewInfcheck = false;_Othercheck = false};
			
			if (_SpecForcheck) then {if not (_vh in (_logic getvariable "HAC_HQ_SpecFor")) then {_logic setvariable ["HAC_HQ_SpecFor", (_logic getvariable "HAC_HQ_SpecFor") + [_vh]]};if not (_grp in (_logic getvariable "HAC_HQ_SpecForG")) then {_logic setvariable ["HAC_HQ_SpecForG", (_logic getvariable "HAC_HQ_SpecForG") + [_grp]]}};
			if (_reconcheck) then {if not (_vh in (_logic getvariable "HAC_HQ_recon")) then {_logic setvariable ["HAC_HQ_recon", (_logic getvariable "HAC_HQ_recon") + [_vh]]};if not (_grp in (_logic getvariable "HAC_HQ_reconG")) then {_logic setvariable ["HAC_HQ_reconG", (_logic getvariable "HAC_HQ_reconG") + [_grp]]}};
			if (_FOcheck) then {if not (_vh in (_logic getvariable "HAC_HQ_FO")) then {_logic setvariable ["HAC_HQ_FO", (_logic getvariable "HAC_HQ_FO") + [_vh]]};if not (_grp in (_logic getvariable "HAC_HQ_FOG")) then {_logic setvariable ["HAC_HQ_FOG", (_logic getvariable "HAC_HQ_FOG") + [_grp]]}};
			if (_sniperscheck) then {if not (_vh in (_logic getvariable "HAC_HQ_snipers")) then {_logic setvariable ["HAC_HQ_snipers", (_logic getvariable "HAC_HQ_snipers") + [_vh]]};if not (_grp in (_logic getvariable "HAC_HQ_snipersG")) then {_logic setvariable ["HAC_HQ_snipersG", (_logic getvariable "HAC_HQ_snipersG") + [_grp]]}};
			if (_ATinfcheck) then {if not (_vh in (_logic getvariable "HAC_HQ_ATinf")) then {_logic setvariable ["HAC_HQ_ATinf", (_logic getvariable "HAC_HQ_ATinf") + [_vh]]};if not (_grp in (_logic getvariable "HAC_HQ_ATinfG")) then {_logic setvariable ["HAC_HQ_ATinfG", (_logic getvariable "HAC_HQ_ATinfG") + [_grp]]}};
			if (_AAinfcheck) then {if not (_vh in (_logic getvariable "HAC_HQ_AAinf")) then {_logic setvariable ["HAC_HQ_AAinf", (_logic getvariable "HAC_HQ_AAinf") + [_vh]]};if not (_grp in (_logic getvariable "HAC_HQ_AAinfG")) then {_logic setvariable ["HAC_HQ_AAinfG", (_logic getvariable "HAC_HQ_AAinfG") + [_grp]]}};
			if (_Infcheck) then {if not (_vh in (_logic getvariable "HAC_HQ_Inf")) then {_logic setvariable ["HAC_HQ_FValue",(_logic getvariable "HAC_HQ_FValue") + 1]; _logic setvariable ["HAC_HQ_Inf", (_logic getvariable "HAC_HQ_Inf") + [_vh]]};if not (_grp in (_logic getvariable "HAC_HQ_InfG")) then {_logic setvariable ["HAC_HQ_InfG", (_logic getvariable "HAC_HQ_InfG") + [_grp]]}};
			if (_Artcheck) then {if not (_vh in (_logic getvariable "HAC_HQ_Art")) then {_logic setvariable ["HAC_HQ_FValue",(_logic getvariable "HAC_HQ_FValue") + 3]; _logic setvariable ["HAC_HQ_Art", (_logic getvariable "HAC_HQ_Art") + [_vh]]};if not (_grp in (_logic getvariable "HAC_HQ_ArtG")) then {_logic setvariable ["HAC_HQ_ArtG", (_logic getvariable "HAC_HQ_ArtG") + [_grp]]}};
			if (_HArmorcheck) then {if not (_vh in (_logic getvariable "HAC_HQ_HArmor")) then {_logic setvariable ["HAC_HQ_FValue",(_logic getvariable "HAC_HQ_FValue") + 10]; _logic setvariable ["HAC_HQ_HArmor", (_logic getvariable "HAC_HQ_HArmor") + [_vh]]};if not (_grp in (_logic getvariable "HAC_HQ_HArmorG")) then {_logic setvariable ["HAC_HQ_HArmorG", (_logic getvariable "HAC_HQ_HArmorG") + [_grp]]}};
			if (_MArmorcheck) then {if not (_vh in (_logic getvariable "HAC_HQ_MArmor")) then {_logic setvariable ["HAC_HQ_MArmor", (_logic getvariable "HAC_HQ_MArmor") + [_vh]]};if not (_grp in (_logic getvariable "HAC_HQ_MArmorG")) then {_logic setvariable ["HAC_HQ_MArmorG", (_logic getvariable "HAC_HQ_MArmorG") + [_grp]]}};
			if (_LArmorcheck) then {if not (_vh in (_logic getvariable "HAC_HQ_LArmor")) then {_logic setvariable ["HAC_HQ_FValue",(_logic getvariable "HAC_HQ_FValue") + 5]; _logic setvariable ["HAC_HQ_LArmor", (_logic getvariable "HAC_HQ_LArmor") + [_vh]]};if not (_grp in (_logic getvariable "HAC_HQ_LArmorG")) then {_logic setvariable ["HAC_HQ_LArmorG", (_logic getvariable "HAC_HQ_LArmorG") + [_grp]]}};
			if (_LArmorATcheck) then {if not (_vh in (_logic getvariable "HAC_HQ_LArmorAT")) then {_logic setvariable ["HAC_HQ_LArmorAT", (_logic getvariable "HAC_HQ_LArmorAT") + [_vh]]};if not (_grp in (_logic getvariable "HAC_HQ_LArmorATG")) then {_logic setvariable ["HAC_HQ_LArmorATG", (_logic getvariable "HAC_HQ_LArmorATG") + [_grp]]}};
			if (_Carscheck) then {if not (_vh in (_logic getvariable "HAC_HQ_Cars")) then {_logic setvariable ["HAC_HQ_FValue",(_logic getvariable "HAC_HQ_FValue") + 3]; _logic setvariable ["HAC_HQ_Cars", (_logic getvariable "HAC_HQ_Cars") + [_vh]]};if not (_grp in (_logic getvariable "HAC_HQ_CarsG")) then {_logic setvariable ["HAC_HQ_CarsG", (_logic getvariable "HAC_HQ_CarsG") + [_grp]]}};
			if (_Aircheck) then {if not (_vh in (_logic getvariable "HAC_HQ_Air")) then {_logic setvariable ["HAC_HQ_FValue",(_logic getvariable "HAC_HQ_FValue") + 15]; _logic setvariable ["HAC_HQ_Air", (_logic getvariable "HAC_HQ_Air") + [_vh]]};if not (_grp in (_logic getvariable "HAC_HQ_AirG")) then {_logic setvariable ["HAC_HQ_AirG", (_logic getvariable "HAC_HQ_AirG") + [_grp]]}};
			if (_BAircheck) then {if not (_vh in (_logic getvariable "HAC_HQ_BAir")) then {_logic setvariable ["HAC_HQ_BAir", (_logic getvariable "HAC_HQ_BAir") + [_vh]]};if not (_grp in (_logic getvariable "HAC_HQ_BAirG")) then {_logic setvariable ["HAC_HQ_BAirG", (_logic getvariable "HAC_HQ_BAirG") + [_grp]]}};
			if (_RAircheck) then {if not (_vh in (_logic getvariable "HAC_HQ_RAir")) then {_logic setvariable ["HAC_HQ_RAir", (_logic getvariable "HAC_HQ_RAir") + [_vh]]};if not (_grp in (_logic getvariable "HAC_HQ_RAirG")) then {_logic setvariable ["HAC_HQ_RAirG", (_logic getvariable "HAC_HQ_RAirG") + [_grp]]}};
			if (_NCAircheck) then {if not (_vh in (_logic getvariable "HAC_HQ_NCAir")) then {_logic setvariable ["HAC_HQ_NCAir", (_logic getvariable "HAC_HQ_NCAir") + [_vh]]};if not (_grp in (_logic getvariable "HAC_HQ_NCAirG")) then {_logic setvariable ["HAC_HQ_NCAirG", (_logic getvariable "HAC_HQ_NCAirG") + [_grp]]}};
			if (_Navalcheck) then {if not (_vh in (_logic getvariable "HAC_HQ_Naval")) then {_logic setvariable ["HAC_HQ_Naval", (_logic getvariable "HAC_HQ_Naval") + [_vh]]};if not (_grp in (_logic getvariable "HAC_HQ_NavalG")) then {_logic setvariable ["HAC_HQ_NavalG", (_logic getvariable "HAC_HQ_NavalG") + [_grp]]}};
			if (_Staticcheck) then {if not (_vh in (_logic getvariable "HAC_HQ_Static")) then {_logic setvariable ["HAC_HQ_FValue",(_logic getvariable "HAC_HQ_FValue") + 1]; _logic setvariable ["HAC_HQ_Static", (_logic getvariable "HAC_HQ_Static") + [_vh]]};if not (_grp in (_logic getvariable "HAC_HQ_StaticG")) then {_logic setvariable ["HAC_HQ_StaticG", (_logic getvariable "HAC_HQ_StaticG") + [_grp]]}};
			if (_StaticAAcheck) then {if not (_vh in (_logic getvariable "HAC_HQ_StaticAA")) then {_logic setvariable ["HAC_HQ_StaticAA", (_logic getvariable "HAC_HQ_StaticAA") + [_vh]]};if not (_grp in (_logic getvariable "HAC_HQ_StaticAAG")) then {_logic setvariable ["HAC_HQ_StaticAAG", (_logic getvariable "HAC_HQ_StaticAAG") + [_grp]]}};
			if (_StaticATcheck) then {if not (_vh in (_logic getvariable "HAC_HQ_StaticAT")) then {_logic setvariable ["HAC_HQ_StaticAT", (_logic getvariable "HAC_HQ_StaticAT") + [_vh]]};if not (_grp in (_logic getvariable "HAC_HQ_StaticATG")) then {_logic setvariable ["HAC_HQ_StaticATG", (_logic getvariable "HAC_HQ_StaticATG") + [_grp]]}};
			if (_Supportcheck) then {if not (_vh in (_logic getvariable "HAC_HQ_Support")) then {_logic setvariable ["HAC_HQ_Support", (_logic getvariable "HAC_HQ_Support") + [_vh]]};if not (_grp in (_logic getvariable "HAC_HQ_SupportG")) then {_logic setvariable ["HAC_HQ_SupportG", (_logic getvariable "HAC_HQ_SupportG") + [_grp]]}};
			if (_Cargocheck) then {if not (_vh in (_logic getvariable "HAC_HQ_Cargo")) then {_logic setvariable ["HAC_HQ_Cargo", (_logic getvariable "HAC_HQ_Cargo") + [_vh]]};if not (_grp in (_logic getvariable "HAC_HQ_CargoG")) then {_logic setvariable ["HAC_HQ_CargoG", (_logic getvariable "HAC_HQ_CargoG") + [_grp]]}};
			if (_NCCargocheck) then {if not (_vh in (_logic getvariable "HAC_HQ_NCCargo")) then {_logic setvariable ["HAC_HQ_NCCargo", (_logic getvariable "HAC_HQ_NCCargo") + [_vh]]};if not (_grp in (_logic getvariable "HAC_HQ_NCCargoG")) then {_logic setvariable ["HAC_HQ_NCCargoG", (_logic getvariable "HAC_HQ_NCCargoG") + [_grp]]}};
			if (_Crewcheck) then {if not (_vh in (_logic getvariable "HAC_HQ_Crew")) then {_logic setvariable ["HAC_HQ_Crew", (_logic getvariable "HAC_HQ_Crew") + [_vh]]};if not (_grp in (_logic getvariable "HAC_HQ_CrewG")) then {_logic setvariable ["HAC_HQ_CrewG", (_logic getvariable "HAC_HQ_CrewG") + [_grp]]}};
			if (_NCrewInfcheck) then {if not (_vh in (_logic getvariable "HAC_HQ_NCrewInf")) then {_logic setvariable ["HAC_HQ_NCrewInf", (_logic getvariable "HAC_HQ_NCrewInf") + [_vh]]};if not (_grp in (_logic getvariable "HAC_HQ_NCrewInfG")) then {_logic setvariable ["HAC_HQ_NCrewInfG", (_logic getvariable "HAC_HQ_NCrewInfG") + [_grp]]}};
			}
		foreach (units _x)
		}
	foreach (_logic getvariable "HAC_HQ_Friends");

	_logic setvariable ["HAC_HQ_NCrewInfG", (_logic getvariable "HAC_HQ_NCrewInfG") - ((_logic getvariable "HAC_HQ_RAirG") + (_logic getvariable "HAC_HQ_StaticG"))];
	_logic setvariable ["HAC_HQ_NCrewInf", (_logic getvariable "HAC_HQ_NCrewInf") - ((_logic getvariable "HAC_HQ_RAir") + (_logic getvariable "HAC_HQ_Static"))];
	_logic setvariable ["HAC_HQ_InfG", (_logic getvariable "HAC_HQ_InfG") - ((_logic getvariable "HAC_HQ_RAirG") + (_logic getvariable "HAC_HQ_StaticG"))];
	_logic setvariable ["HAC_HQ_Inf", (_logic getvariable "HAC_HQ_Inf") - ((_logic getvariable "HAC_HQ_RAir") + (_logic getvariable "HAC_HQ_Static"))];

	_logic setvariable ["HAC_HQ_CargoAirEx", []];
	_logic setvariable ["HAC_HQ_CargoLandEx", []];
	if ((_logic getvariable "HAC_HQ_NoAirCargo")) then {_logic setvariable ["HAC_HQ_CargoAirEx", (_logic getvariable "HAC_HQ_AirG")]};
	if ((_logic getvariable "HAC_HQ_NoLandCargo")) then {_logic setvariable ["HAC_HQ_CargoLandEx", (_logic getvariable "HAC_HQ_CargoG") - (_logic getvariable "HAC_HQ_AirG")]};
	_logic setvariable ["HAC_HQ_CargoG", (_logic getvariable "HAC_HQ_CargoG") - ((_logic getvariable "HAC_HQ_CargoAirEx") + (_logic getvariable "HAC_HQ_CargoLandEx") + (_logic getvariable "HAC_HQ_AmmoDrop"))];

		{
		if not (_x in (_logic getvariable "HAC_HQ_SupportG")) then
			{
			_logic setvariable ["HAC_HQ_SupportG",(_logic getvariable "HAC_HQ_SupportG") + [_x]];
			}
		}
	foreach (_logic getvariable "HAC_HQ_AmmoDrop");
		
		{
			{
			_SpecForcheck = false;
			_reconcheck = false;
			_FOcheck = false;
			_sniperscheck = false;
			_ATinfcheck = false;
			_AAinfcheck = false;
			_Infcheck = false;
			_Artcheck = false;
			_HArmorcheck = false;
			_MArmorcheck = false;
			_LArmorcheck = false;
			_LArmorATcheck = false;
			_Carscheck = false;
			_Aircheck = false;
			_BAircheck = false;
			_RAircheck = false;
			_NCAircheck = false;
			_Navalcheck = false;
			_Staticcheck = false;
			_StaticAAcheck = false;
			_StaticATcheck = false;
			_Supportcheck = false;
			_Cargocheck = false;
			_NCCargocheck = false;
			_Cargocheck = false;
			_NCCargocheck = false;
			_Othercheck = true;

			_Crewcheck = false;
			_NCrewInfcheck = false;

			_tp = typeOf _x;
			_grp = group _x;
			_vh = vehicle _x;
			_asV = assignedvehicle _x;
			_grpD = group (assignedDriver _asV);
			_grpG = group (assignedGunner _asV);
			if (isNull _grpD) then {_grpD = _grpG};
			_Tvh = typeOf _vh;
			_TasV = typeOf _asV;

				if (((_grp == _grpD) and (_TasV in _specFor)) or (_tp in _specFor)) then {_SpecForcheck = true;_Othercheck = false};
				if (((_grp == _grpD) and (_TasV in _recon)) or (_tp in _recon)) then {_reconcheck = true;_Othercheck = false};
				if (((_grp == _grpD) and (_TasV in _FO)) or (_tp in _FO)) then {_FOcheck = true;_Othercheck = false};
				if (((_grp == _grpD) and (_TasV in _snipers)) or (_tp in _snipers)) then {_sniperscheck = true;_Othercheck = false};
				if (((_grp == _grpD) and (_TasV in _ATinf)) or (_tp in _ATinf)) then {_ATinfcheck = true;_Othercheck = false};
				if (((_grp == _grpD) and (_TasV in _AAinf)) or (_tp in _AAinf)) then {_AAinfcheck = true;_Othercheck = false};
				if (((_grp == _grpD) and (_TasV in _Inf)) or (_tp in _Inf)) then {_Infcheck = true;_Othercheck = false};
				if (((_grp == _grpD) and (_TasV in _Art)) or (_tp in _Art)) then {_Artcheck = true;_Othercheck = false};
				if (((_grp == _grpD) and (_TasV in _HArmor)) or (_tp in _HArmor)) then {_HArmorcheck = true;_Othercheck = false};
				if (((_grp == _grpD) and (_TasV in _MArmor)) or (_tp in _MArmor)) then {_MArmorcheck = true;_Othercheck = false};
				if (((_grp == _grpD) and (_TasV in _LArmor)) or (_tp in _LArmor)) then {_LArmorcheck = true;_Othercheck = false};
				if (((_grp == _grpD) and (_TasV in _LArmorAT)) or (_tp in _LArmorAT)) then {_LArmorATcheck = true;_Othercheck = false};
				if (((_grp == _grpD) and (_TasV in _Cars)) or (_tp in _Cars)) then {_Carscheck = true;_Othercheck = false};
				if (((_grp == _grpD) and (_TasV in _Air)) or (_tp in _Air)) then {_Aircheck = true;_Othercheck = false};
				if (((_grp == _grpD) and (_TasV in _BAir)) or (_tp in _BAir)) then {_BAircheck = true;_Othercheck = false};
				if (((_grp == _grpD) and (_TasV in _RAir)) or (_tp in _RAir)) then {_RAircheck = true;_Othercheck = false};
				if (((_grp == _grpD) and (_TasV in _NCAir)) or (_tp in _NCAir)) then {_NCAircheck = true;_Othercheck = false};
				if (((_grp == _grpD) and (_TasV in _Naval)) or (_tp in _Naval)) then {_Navalcheck = true;_Othercheck = false};
				if (((_grp == _grpG) and (_TasV in _Static)) or (_tp in _Static)) then {_Staticcheck = true;_Othercheck = false};
				if (((_grp == _grpG) and (_TasV in _StaticAA)) or (_tp in _StaticAA)) then {_StaticAAcheck = true;_Othercheck = false};
				if (((_grp == _grpG) and (_TasV in _StaticAT)) or (_tp in _StaticAT)) then {_StaticATcheck = true;_Othercheck = false};
				if (((_grp == _grpD) and (_TasV in _Cargo)) or (_tp in _Cargo)) then {_Cargocheck = true;_Othercheck = false};
				if (((_grp == _grpD) and (_TasV in _NCCargo)) or (_tp in _NCCargo)) then {_NCCargocheck = true;_Othercheck = false};
				if (((_grp == _grpD) and (_TasV in _Crew)) or (_tp in _Crew)) then {_Crewcheck = true;_Othercheck = false};
				if (((_grp == _grpD) and (_TasV in _NCrewInf)) or (_tp in _NCrewInf)) then {_NCrewInfcheck = true;_Othercheck = false};
				if (((_grp == _grpD) and (_TasV in _Support)) or (_tp in _Support)) then {_Supportcheck = true;_NCrewInfcheck = false;_Othercheck = false};
				if ((_TasV in _NCCargo) and (_x == (assignedDriver _asV)) and ((count (units (group _x))) == 1) and not ((_ATinfcheck) or (_AAinfcheck) or (_reconcheck) or (_FOcheck) or (_sniperscheck))) then {_NCrewInfcheck = false;_Othercheck = false};
				if (_SpecForcheck) then {if not (_vh in (_logic getvariable "HAC_HQ_EnSpecFor")) then {_logic setvariable ["HAC_HQ_EnSpecFor", (_logic getvariable "HAC_HQ_EnSpecFor") + [_vh]]};if not (_grp in (_logic getvariable "HAC_HQ_EnSpecForG")) then {_logic setvariable ["HAC_HQ_EnSpecForG", (_logic getvariable "HAC_HQ_EnSpecForG") + [_grp]]}};
				if (_reconcheck) then {if not (_vh in (_logic getvariable "HAC_HQ_Enrecon")) then {_logic setvariable ["HAC_HQ_Enrecon", (_logic getvariable "HAC_HQ_Enrecon") + [_vh]]};if not (_grp in (_logic getvariable "HAC_HQ_EnreconG")) then {_logic setvariable ["HAC_HQ_EnreconG", (_logic getvariable "HAC_HQ_EnreconG") + [_grp]]}};
				if (_FOcheck) then {if not (_vh in (_logic getvariable "HAC_HQ_EnFO")) then {_logic setvariable ["HAC_HQ_EnFO", (_logic getvariable "HAC_HQ_EnFO") + [_vh]]};if not (_grp in (_logic getvariable "HAC_HQ_EnFOG")) then {_logic setvariable ["HAC_HQ_EnFOG", (_logic getvariable "HAC_HQ_EnFOG") + [_grp]]}};
				if (_sniperscheck) then {if not (_vh in (_logic getvariable "HAC_HQ_Ensnipers")) then {_logic setvariable ["HAC_HQ_Ensnipers", (_logic getvariable "HAC_HQ_Ensnipers") + [_vh]]};if not (_grp in (_logic getvariable "HAC_HQ_EnsnipersG")) then {_logic setvariable ["HAC_HQ_EnsnipersG", (_logic getvariable "HAC_HQ_EnsnipersG") + [_grp]]}};
				if (_ATinfcheck) then {if not (_vh in (_logic getvariable "HAC_HQ_EnATinf")) then {_logic setvariable ["HAC_HQ_EnATinf", (_logic getvariable "HAC_HQ_EnATinf") + [_vh]]};if not (_grp in (_logic getvariable "HAC_HQ_EnATinfG")) then {_logic setvariable ["HAC_HQ_EnATinfG", (_logic getvariable "HAC_HQ_EnATinfG") + [_grp]]}};
				if (_AAinfcheck) then {if not (_vh in (_logic getvariable "HAC_HQ_EnAAinf")) then {_logic setvariable ["HAC_HQ_EnAAinf", (_logic getvariable "HAC_HQ_EnAAinf") + [_vh]]};if not (_grp in (_logic getvariable "HAC_HQ_EnAAinfG")) then {_logic setvariable ["HAC_HQ_EnAAinfG", (_logic getvariable "HAC_HQ_EnAAinfG") + [_grp]]}};
				if (_Infcheck) then {if not (_vh in (_logic getvariable "HAC_HQ_EnInf")) then {_logic setvariable ["HAC_HQ_EnFValue",(_logic getvariable "HAC_HQ_EnFValue") + 1]; _logic setvariable ["HAC_HQ_EnInf", (_logic getvariable "HAC_HQ_EnInf") + [_vh]]};if not (_grp in (_logic getvariable "HAC_HQ_EnInfG")) then {_logic setvariable ["HAC_HQ_EnInfG", (_logic getvariable "HAC_HQ_EnInfG") + [_grp]]}};
				if (_Artcheck) then {if not (_vh in (_logic getvariable "HAC_HQ_EnArt")) then {_logic setvariable ["HAC_HQ_EnFValue",(_logic getvariable "HAC_HQ_EnFValue") + 3]; _logic setvariable ["HAC_HQ_EnArt", (_logic getvariable "HAC_HQ_EnArt") + [_vh]]};if not (_grp in (_logic getvariable "HAC_HQ_EnArtG")) then {_logic setvariable ["HAC_HQ_EnArtG", (_logic getvariable "HAC_HQ_EnArtG") + [_grp]]}};
				if (_HArmorcheck) then {if not (_vh in (_logic getvariable "HAC_HQ_EnHArmor")) then {_logic setvariable ["HAC_HQ_EnFValue",(_logic getvariable "HAC_HQ_EnFValue") + 10]; _logic setvariable ["HAC_HQ_EnHArmor", (_logic getvariable "HAC_HQ_EnHArmor") + [_vh]]};if not (_grp in (_logic getvariable "HAC_HQ_EnHArmorG")) then {_logic setvariable ["HAC_HQ_EnHArmorG", (_logic getvariable "HAC_HQ_EnHArmorG") + [_grp]]}};
				if (_MArmorcheck) then {if not (_vh in (_logic getvariable "HAC_HQ_EnMArmor")) then {_logic setvariable ["HAC_HQ_EnMArmor", (_logic getvariable "HAC_HQ_EnMArmor") + [_vh]]};if not (_grp in (_logic getvariable "HAC_HQ_EnMArmorG")) then {_logic setvariable ["HAC_HQ_EnMArmorG", (_logic getvariable "HAC_HQ_EnMArmorG") + [_grp]]}};
				if (_LArmorcheck) then {if not (_vh in (_logic getvariable "HAC_HQ_EnLArmor")) then {_logic setvariable ["HAC_HQ_EnFValue",(_logic getvariable "HAC_HQ_EnFValue") + 5]; _logic setvariable ["HAC_HQ_EnLArmor", (_logic getvariable "HAC_HQ_EnLArmor") + [_vh]]};if not (_grp in (_logic getvariable "HAC_HQ_EnLArmorG")) then {_logic setvariable ["HAC_HQ_EnLArmorG", (_logic getvariable "HAC_HQ_EnLArmorG") + [_grp]]}};
				if (_LArmorATcheck) then {if not (_vh in (_logic getvariable "HAC_HQ_EnLArmorAT")) then {_logic setvariable ["HAC_HQ_EnLArmorAT", (_logic getvariable "HAC_HQ_EnLArmorAT") + [_vh]]};if not (_grp in (_logic getvariable "HAC_HQ_EnLArmorATG")) then {_logic setvariable ["HAC_HQ_EnLArmorATG", (_logic getvariable "HAC_HQ_EnLArmorATG") + [_grp]]}};
				if (_Carscheck) then {if not (_vh in (_logic getvariable "HAC_HQ_EnCars")) then {_logic setvariable ["HAC_HQ_EnFValue",(_logic getvariable "HAC_HQ_EnFValue") + 3]; _logic setvariable ["HAC_HQ_EnCars", (_logic getvariable "HAC_HQ_EnCars") + [_vh]]};if not (_grp in (_logic getvariable "HAC_HQ_EnCarsG")) then {_logic setvariable ["HAC_HQ_EnCarsG", (_logic getvariable "HAC_HQ_EnCarsG") + [_grp]]}};
				if (_Aircheck) then {if not (_vh in (_logic getvariable "HAC_HQ_EnAir")) then {_logic setvariable ["HAC_HQ_EnFValue",(_logic getvariable "HAC_HQ_EnFValue") + 15]; _logic setvariable ["HAC_HQ_EnAir", (_logic getvariable "HAC_HQ_EnAir") + [_vh]]};if not (_grp in (_logic getvariable "HAC_HQ_EnAirG")) then {_logic setvariable ["HAC_HQ_EnAirG", (_logic getvariable "HAC_HQ_EnAirG") + [_grp]]}};
				if (_BAircheck) then {if not (_vh in (_logic getvariable "HAC_HQ_EnBAir")) then {_logic setvariable ["HAC_HQ_EnBAir", (_logic getvariable "HAC_HQ_EnBAir") + [_vh]]};if not (_grp in (_logic getvariable "HAC_HQ_EnBAirG")) then {_logic setvariable ["HAC_HQ_EnBAirG", (_logic getvariable "HAC_HQ_EnBAirG") + [_grp]]}};
				if (_RAircheck) then {if not (_vh in (_logic getvariable "HAC_HQ_EnRAir")) then {_logic setvariable ["HAC_HQ_EnRAir", (_logic getvariable "HAC_HQ_EnRAir") + [_vh]]};if not (_grp in (_logic getvariable "HAC_HQ_EnRAirG")) then {_logic setvariable ["HAC_HQ_EnRAirG", (_logic getvariable "HAC_HQ_EnRAirG") + [_grp]]}};
				if (_NCAircheck) then {if not (_vh in (_logic getvariable "HAC_HQ_EnNCAir")) then {_logic setvariable ["HAC_HQ_EnNCAir", (_logic getvariable "HAC_HQ_EnNCAir") + [_vh]]};if not (_grp in (_logic getvariable "HAC_HQ_EnNCAirG")) then {_logic setvariable ["HAC_HQ_EnNCAirG", (_logic getvariable "HAC_HQ_EnNCAirG") + [_grp]]}};
				if (_Navalcheck) then {if not (_vh in (_logic getvariable "HAC_HQ_EnNaval")) then {_logic setvariable ["HAC_HQ_EnNaval", (_logic getvariable "HAC_HQ_EnNaval") + [_vh]]};if not (_grp in (_logic getvariable "HAC_HQ_EnNavalG")) then {_logic setvariable ["HAC_HQ_EnNavalG", (_logic getvariable "HAC_HQ_EnNavalG") + [_grp]]}};
				if (_Staticcheck) then {if not (_vh in (_logic getvariable "HAC_HQ_EnStatic")) then {_logic setvariable ["HAC_HQ_EnFValue",(_logic getvariable "HAC_HQ_EnFValue") + 1]; _logic setvariable ["HAC_HQ_EnStatic", (_logic getvariable "HAC_HQ_EnStatic") + [_vh]]};if not (_grp in (_logic getvariable "HAC_HQ_EnStaticG")) then {_logic setvariable ["HAC_HQ_EnStaticG", (_logic getvariable "HAC_HQ_EnStaticG") + [_grp]]}};
				if (_StaticAAcheck) then {if not (_vh in (_logic getvariable "HAC_HQ_EnStaticAA")) then {_logic setvariable ["HAC_HQ_EnStaticAA", (_logic getvariable "HAC_HQ_EnStaticAA") + [_vh]]};if not (_grp in (_logic getvariable "HAC_HQ_EnStaticAAG")) then {_logic setvariable ["HAC_HQ_EnStaticAAG", (_logic getvariable "HAC_HQ_EnStaticAAG") + [_grp]]}};
				if (_StaticATcheck) then {if not (_vh in (_logic getvariable "HAC_HQ_EnStaticAT")) then {_logic setvariable ["HAC_HQ_EnStaticAT", (_logic getvariable "HAC_HQ_EnStaticAT") + [_vh]]};if not (_grp in (_logic getvariable "HAC_HQ_EnStaticATG")) then {_logic setvariable ["HAC_HQ_EnStaticATG", (_logic getvariable "HAC_HQ_EnStaticATG") + [_grp]]}};
				if (_Supportcheck) then {if not (_vh in (_logic getvariable "HAC_HQ_EnSupport")) then {_logic setvariable ["HAC_HQ_EnSupport", (_logic getvariable "HAC_HQ_EnSupport") + [_vh]]};if not (_grp in (_logic getvariable "HAC_HQ_EnSupportG")) then {_logic setvariable ["HAC_HQ_EnSupportG", (_logic getvariable "HAC_HQ_EnSupportG") + [_grp]]}};
				if (_Cargocheck) then {if not (_vh in (_logic getvariable "HAC_HQ_EnCargo")) then {_logic setvariable ["HAC_HQ_EnCargo", (_logic getvariable "HAC_HQ_EnCargo") + [_vh]]};if not (_grp in (_logic getvariable "HAC_HQ_EnCargoG")) then {_logic setvariable ["HAC_HQ_EnCargoG", (_logic getvariable "HAC_HQ_EnCargoG") + [_grp]]}};
				if (_NCCargocheck) then {if not (_vh in (_logic getvariable "HAC_HQ_EnNCCargo")) then {_logic setvariable ["HAC_HQ_EnNCCargo", (_logic getvariable "HAC_HQ_EnNCCargo") + [_vh]]};if not (_grp in (_logic getvariable "HAC_HQ_EnNCCargoG")) then {_logic setvariable ["HAC_HQ_EnNCCargoG", (_logic getvariable "HAC_HQ_EnNCCargoG") + [_grp]]}};
                if (_Crewcheck) then {if not (_vh in (_logic getvariable "HAC_HQ_EnCrew")) then {_logic setvariable ["HAC_HQ_EnCrew", (_logic getvariable "HAC_HQ_EnCrew") + [_vh]]};if not (_grp in (_logic getvariable "HAC_HQ_EnCrewG")) then {_logic setvariable ["HAC_HQ_EnCrewG", (_logic getvariable "HAC_HQ_EnCrewG") + [_grp]]}};
                if (_NCrewInfcheck) then {if not (_vh in (_logic getvariable "HAC_HQ_EnNCrewInf")) then {_logic setvariable ["HAC_HQ_EnNCrewInf", (_logic getvariable "HAC_HQ_EnNCrewInf") + [_vh]]};if not (_grp in (_logic getvariable "HAC_HQ_EnNCrewInfG")) then {_logic setvariable ["HAC_HQ_EnNCrewInfG", (_logic getvariable "HAC_HQ_EnNCrewInfG") + [_grp]]}};
			}
		foreach (units _x)
		}
	foreach (_logic getvariable "HAC_HQ_KnEnemiesG");

	_logic setvariable ["HAC_HQ_EnNCrewInfG", (_logic getvariable "HAC_HQ_EnNCrewInfG") - ((_logic getvariable "HAC_HQ_EnRAirG") + (_logic getvariable "HAC_HQ_EnStaticG"))];
	_logic setvariable ["HAC_HQ_EnNCrewInf", (_logic getvariable "HAC_HQ_EnNCrewInf") - ((_logic getvariable "HAC_HQ_EnRAir") + (_logic getvariable "HAC_HQ_EnStatic"))];
	_logic setvariable ["HAC_HQ_EnInfG", (_logic getvariable "HAC_HQ_EnInfG") - ((_logic getvariable "HAC_HQ_EnRAirG") + (_logic getvariable "HAC_HQ_EnStaticG"))];
	_logic setvariable ["HAC_HQ_EnInf", (_logic getvariable "HAC_HQ_EnInf") - ((_logic getvariable "HAC_HQ_EnRAir") + (_logic getvariable "HAC_HQ_EnStatic"))];

	if ((_logic getvariable "HAC_HQ_Flee")) then
		{
		_AllCow = 0;
		_AllPanic = 0;

			{
			_cow = _x getVariable ("Cow" + (str _x));
			if (isNil ("_cow")) then {_cow = 0};

			_AllCow = _AllCow + _cow;

			_panic = _x getVariable ("inPanic" + (str _x));
			if (isNil ("_panic")) then {_panic = false};

			if (_panic) then {_AllPanic = _AllPanic + 1};
			}
		foreach (_logic getvariable "HAC_HQ_Friends");

		if (_AllPanic == 0) then {_AllPanic = 1};
		_midCow = 0;
		if not ((count (_logic getvariable "HAC_HQ_Friends")) == 0) then {_midCow = _AllCow/(count (_logic getvariable "HAC_HQ_Friends"))};

			{
			_cowF = ((- (_logic getvariable "HAC_HQ_Morale"))/(50 + (random 25))) + (random (2 * _midCow)) - _midCow;
			_cowF = _cowF * (_logic getvariable "HAC_HQ_Muu");
			if (_x in (_logic getvariable "HAC_HQ_SpecForG")) then {_cowF = _cowF - 0.8};
			if (_cowF < 0) then {_cowF = 0};
			if (_cowF > 1) then {_cowF = 1};
			_i = "";
			if (_cowF > 0.5) then
				{
				_UL = leader _x;
				if not (isPlayer _UL) then 
					{
					_inDanger = _x getVariable ["NearE",0];
					if (_inDanger > 0.05) then
						{
						if ((random 100) < (_logic getvariable "HAC_xHQ_AIChatDensity")) then {[_UL,(_logic getvariable "HAC_xHQ_AIC_InFear"),"InFear",_logic] call ALiVE_fnc_HAC_AIChatter}
						}
					}
				};

			if (((random ((20 + ((_logic getvariable "HAC_HQ_Morale")/5))/_AllPanic)) < _cowF) && ((random 100) > (100/(_AllPanic + 1))) && ({({alive _x} count (units _x)) > 0} count (_logic getvariable "HAC_HQ_Subordinated") <= 3)) then 
				{
				[_x,_logic] call ALiVE_fnc_HAC_WPdel;
				_x setVariable [("inPanic" + (str _x)), true];
				if ((_logic getvariable "HAC_HQ_DebugII")) then {_i = [(getposATL (vehicle (leader _x))),_x,"markPanic",(_logic getvariable ["HAC_HQ_Color","ColorYellow"]),"ICON","mil_dot","Survive","A!",[0.5,0.5],_logic] call ALiVE_fnc_HAC_Mark};
                _x setVariable [("Busy" + (str _x)), true];

				_UL = leader _x;
				if not (isPlayer _UL) then 
					{
					if ((random 100) < (_logic getvariable "HAC_xHQ_AIChatDensity")) then {[_UL,(_logic getvariable "HAC_xHQ_AIC_InPanic"),"InPanic",_logic] call ALiVE_fnc_HAC_AIChatter}
					};

				if ((_logic getvariable "HAC_HQ_Surr")) then
					{
					if ((random 100) > 50) then
						{
						if ((_logic getvariable "HAC_HQ_DebugII")) then {_i setMarkerColor "ColorPink";_i setMarkerText "A!!!"};
						_isCaptive = _x getVariable ("isCaptive" + (str _x));
						if (isNil "_isCaptive") then {_isCaptive = false};
						if not (_isCaptive) then
							{
							[_x] spawn
								{
								_gp = _this select 0;

								_gp setVariable [("isCaptive" + (str _gp)), true];

								(units _gp) orderGetIn false;
								(units _gp) allowGetin false;

									{
									[_x] spawn
										{
										_unit = _this select 0;

										sleep (random 1);
										if (isPlayer _unit) exitWith {};

										_unit setCaptive true;
										unassignVehicle _unit;

										for [{_a = 0},{_a < (count (weapons _unit))},{_a = _a + 1}] do
											{
											_weapon = (weapons _unit) select _a;
											_unit Action ["dropWeapon", _unit, _weapon] 
											};

										_unit PlayAction "Surrender"
										}
									}
								foreach (units _gp)
								}
							}
						}
					}
				};

			_panic = _x getVariable ("inPanic" + (str _x));
			if (isNil ("_panic")) then {_panic = false};

			if not (_panic) then 
				{
				_x allowFleeing _cowF;
				_x setVariable [("Cow" + (str _x)),_cowF,true];
				} 
			else 
				{
				_x allowFleeing 1; 
				_x setVariable [("Cow" + (str _x)),1,true];
				if ((random 1.1) > _cowF) then 
					{
					_isCaptive = _x getVariable ("isCaptive" + (str _x));
					if (isNil "_isCaptive") then {_isCaptive = false};
					_x setVariable [("inPanic" + (str _x)), false];
					if not (_isCaptive) then {_x setVariable [("Busy" + (str _x)), false]};
					}
				}
			}
		foreach (_logic getvariable "HAC_HQ_Friends")
		};

		{
		_logic setvariable ["HAC_HQ_KnEnPos", (_logic getvariable "HAC_HQ_KnEnPos") + [getposATL (vehicle (leader _x))]];
		if ((count (_logic getvariable "HAC_HQ_KnEnPos")) >= 100) then {_logic setvariable ["HAC_HQ_KnEnPos", (_logic getvariable "HAC_HQ_KnEnPos") - [(_logic getvariable "HAC_HQ_KnEnPos") select 0]]};
		}
	foreach (_logic getvariable "HAC_HQ_KnEnemiesG");

	for [{_z = 0},{_z < (count (_logic getvariable "HAC_HQ_KnEnemies"))},{_z = _z + 1}] do
		{
		_KnEnemy = (_logic getvariable "HAC_HQ_KnEnemies") select _z;
			{
			if ((_x knowsAbout _KnEnemy) > 0.01) then {(_logic getvariable "HAC_HQ") reveal [_KnEnemy,2]}
			}
		foreach (_logic getvariable "HAC_HQ_Friends")
		};

	if (((_logic getvariable "HAC_BB_Active") and (_logic in ((_logic getvariable "HAC_BBa_HQs") + (_logic getvariable "HAC_BBb_HQs"))))) then {[_logic] call ALiVE_fnc_HAC_BBArrRefresh};

	if ((_logic getvariable "HAC_HQ_Cyclecount") == 1) then
		{
		[_logic] spawn ALiVE_fnc_HAC_EnemyScan;
		if ((_logic getvariable "HAC_HQ_ArtyShells") > 0) then
			{
			[(_logic getvariable "HAC_HQ_ArtG"),(_logic getvariable "HAC_HQ_ArtyShells"),_logic] call ALiVE_fnc_HAC_ArtyPrep;
			};

		if (((_logic getvariable "HAC_BB_Active")) and (_logic in ((_logic getvariable "HAC_BBa_HQs") + (_logic getvariable "HAC_BBb_HQs")))) then 
			{
			_logic setvariable ["HAC_HQ_readyForBB", true];
			_logic setvariable ["HAC_xHQ_Done", true];
			if (_logic in (_logic getvariable "HAC_BBa_HQs")) then 
				{
				waitUntil {sleep 0.1;((_logic getvariable "HAC_BBa_InitDone"))}
				};

			if (_logic in (_logic getvariable "HAC_BBb_HQs")) then 
				{
				waitUntil {sleep 0.1;((_logic getvariable "HAC_BBb_InitDone"))}
				}
			}
		};

	if (((count (_logic getvariable "HAC_HQ_KnEnemies")) > 0) and ((count (_logic getvariable "HAC_HQ_ArtG")) > 0)) then {[(_logic getvariable "HAC_HQ_ArtG"),(_logic getvariable "HAC_HQ_KnEnemies"),((_logic getvariable "HAC_HQ_EnHArmor") + (_logic getvariable "HAC_HQ_EnMArmor") + (_logic getvariable "HAC_HQ_EnLArmor")),(_logic getvariable "HAC_HQ_Friends"),(_logic getvariable "HAC_HQ_Debug"),_logic,_logic] call ALiVE_fnc_HAC_CFF};

	if (isNil {_logic getvariable "HAC_HQ_Order"}) then {_logic setvariable ["HAC_HQ_Order", "ATTACK"]};
	_gauss100 = (random 10) + (random 10) + (random 10) + (random 10) + (random 10) + (random 10) + (random 10) + (random 10) + (random 10) + (random 10);
	if ((((_gauss100 + (_logic getvariable "HAC_HQ_Inertia") + (_logic getvariable "HAC_HQ_Morale")) > (((_logic getvariable "HAC_HQ_EValue")/((_logic getvariable "HAC_HQ_FValue") + 0.1)) * 60)) and not (isNil {_logic getvariable "HAC_HQ_Obj"}) and not ((_logic getvariable "HAC_HQ_Order") == "DEFEND")) or ((_logic getvariable "HAC_HQ_Berserk"))) then 
		{
		_lastS = (_logic getvariable "HAC_HQ") getVariable ["LastStance","At"];
		if ((_lastS == "De") or ((_logic getvariable "HAC_HQ_CycleCount") == 1)) then
			{
			if ((random 100) < (_logic getvariable "HAC_xHQ_AIChatDensity")) then {[_logic,(_logic getvariable "HAC_xHQ_AIC_OffStance"),"OffStance",_logic] call ALiVE_fnc_HAC_AIChatter};
			};

		(_logic getvariable "HAC_HQ") setVariable ["LastStance","At"];
		_logic setvariable ["HAC_HQ_Inertia", 30 * (0.5 + (_logic getvariable "HAC_HQ_Consistency"))*(0.5 + (_logic getvariable "HAC_HQ_Activity"))];
		[_logic] spawn ALiVE_fnc_HAC_HQOrders 
		} 
	else 
		{
		_lastS = (_logic getvariable "HAC_HQ") getVariable ["LastStance","De"];
		if ((_lastS == "At") or ((_logic getvariable "HAC_HQ_CycleCount") == 1)) then
			{
			if ((random 100) < (_logic getvariable "HAC_xHQ_AIChatDensity")) then {[_logic,(_logic getvariable "HAC_xHQ_AIC_DefStance"),"DefStance",_logic] call ALiVE_fnc_HAC_AIChatter};
			};

		(_logic getvariable "HAC_HQ") setVariable ["LastStance","De"];
		_logic setvariable ["HAC_HQ_Inertia", - (30  * (0.5 + (_logic getvariable "HAC_HQ_Consistency")))/(0.5 + (_logic getvariable "HAC_HQ_Activity"))];
		[_logic] spawn ALiVE_fnc_HAC_HQOrdersDef 
		};


	if (((((_logic getvariable "HAC_HQ_Circumspection") + (_logic getvariable "HAC_HQ_Fineness"))/2) + 0.1) > (random 1.2)) then
		{
		_SFcount = {not (_x getVariable ["Busy" + (str _x),false]) and not (_x getVariable ["Resting" + (str _x),false])} count ((_logic getvariable "HAC_HQ_SpecForG") - (_logic getvariable "HAC_HQ_SFBodyGuard"));

		if (_SFcount > 0) then
			{
			_isNight = [_logic] call ALiVE_fnc_HAC_isNight;
			_SFTgts = [];
			_chance = 40 + (60 * (_logic getvariable "HAC_HQ_Activity"));

				{
				_HQ = group _x;
				if (_HQ in (_logic getvariable "HAC_HQ_KnEnemiesG")) then
					{
					_SFTgts set [(count _SFTgts),_HQ]
					}
				}
			foreach ((_logic getvariable "HAC_xHQ_AllLeaders") - [(_logic getvariable "_logic")]);

			if ((count _SFTgts) == 0) then
				{
				_chance = _chance/2;
				_SFTgts = (_logic getvariable "HAC_HQ_EnArtG")
				};

			if ((count _SFTgts) == 0) then
				{
				_chance = _chance/3;
				_SFTgts = (_logic getvariable "HAC_HQ_EnStaticG")
				};

			if (_isNight) then
				{
				_chance = _chance + 25
				};

			if ((count _SFTgts) > 0) then
				{
				_chance = _chance + (((2 * _SFcount) - (8/(0.75 + ((_logic getvariable "HAC_HQ_Recklessness")/2)))) * 20);
				_trgG = _SFTgts select (floor (random (count _SFTgts)));
				_alreadyAttacked = {_x == _trgG} count (_logic getvariable "HAC_HQ_SFTargets");
				_chance = _chance/(1 + _alreadyAttacked);
				if (_chance  < _SFcount) then 
					{
					_chance = _SFcount
					}
				else
					{
					if (_chance > (85 + _SFcount)) then
						{
						_chance = 85 + _SFcount
						}
					};

				if ((random 100) < _chance) then 
					{
					_SFAv = [];

						{
						_isBusy = _x getVariable ["Busy" + (str _x),false];

						if not (_isBusy) then
							{
							_isResting = _x getVariable ["Resting" + (str _x),false];

							if not (_isResting) then
								{
								if not (_x in (_logic getvariable "HAC_HQ_SFBodyGuard")) then
									{	
									_SFAv set [(count _SFAv),_x]
									}
								}
							}
						}
					foreach (_logic getvariable "HAC_HQ_SpecForG");

					_team = _SFAv select (floor (random (count _SFAv)));
					_trg = vehicle (leader _trgG);
					if (not ((typeOf _trg) in (_HArmor + _LArmor)) or ((random 100) > (90 - ((_logic getvariable "HAC_HQ_Recklessness") * 10)))) then {[_team,_trg,_trgG,_logic] spawn ALiVE_fnc_HAC_GoSFAttack}
					}
				}
			}
		};

	if ((_logic getvariable "HAC_HQ_LRelocating")) then
		{
		if ((abs (speed (vehicle _logic))) < 0.1) then {(_logic getvariable "HAC_HQ") setVariable ["onMove",false]};
		_onMove = (_logic getvariable "HAC_HQ") getVariable ["onMove",false];

		if not (_onMove) then 
			{
			if (not (isPlayer _logic) and (((_logic getvariable "HAC_HQ_Cyclecount") == 1) or not ((_logic getvariable "HAC_HQ_Progress") == 0))) then
				{
				[(_logic getvariable "HAC_HQ"),_logic] call ALiVE_fnc_HAC_WPdel;

				_Lpos = position _logic;
				if ((_logic getvariable "HAC_HQ_Cyclecount") == 1) then {_logic setvariable ["HAC_HQ_Fpos", _Lpos]};

				_rds = 0;

				if ((_logic getvariable "HAC_HQ_LRelocating")) then 
					{
					_rds = 0;
					if ((_logic getvariable "HAC_HQ_NObj") == 1) then {_Lpos = (_logic getvariable "HAC_HQ_Fpos");if (_logic in ((_logic getvariable "HAC_BBa_HQs") + (_logic getvariable "HAC_BBb_HQs"))) then {_Lpos = position _logic};_rds = 0};
					if ((_logic getvariable "HAC_HQ_NObj") == 2) then {_Lpos = position (_logic getvariable "HAC_HQ_Obj1")};
					if ((_logic getvariable "HAC_HQ_NObj") == 3) then {_Lpos = position (_logic getvariable "HAC_HQ_Obj2")};
					if ((_logic getvariable "HAC_HQ_NObj") >= 4) then {_Lpos = position (_logic getvariable "HAC_HQ_Obj3")};
					};

				_spd = "LIMITED";
				if ((_logic getvariable "HAC_HQ_Progress") == -1) then {_spd = "NORMAL"};
				_logic setvariable ["HAC_HQ_Progress", 0];
				_enemyN = false;

					{
					_eLdr = vehicle (leader _x);
					_eDst = _eLdr distance _Lpos;

					if (_eDst < 600) exitWith {_enemyN = true}
					}
				foreach (_logic getvariable "HAC_HQ_KnEnemiesG");

				if not (_enemyN) then 
					{
					_wp = [_logic,(_logic getvariable "HAC_HQ"),_Lpos,"HOLD","AWARE","GREEN",_spd,["true",""],true,_rds,[0,0,0],"FILE"] call ALiVE_fnc_HAC_WPadd;
					if (isNull (assignedVehicle _logic)) then
						{
						if ((_logic getvariable "HAC_HQ_GetHQInside")) then {[_wp,_logic] call ALiVE_fnc_HAC_GoInside}
						};

					if (((_logic getvariable "HAC_HQ_LRelocating")) and ((_logic getvariable "HAC_HQ_NObj") > 1) and ((_logic getvariable "HAC_HQ_Cyclecount") > 1)) then 
						{
						[_Lpos] spawn
							{
							_Lpos = _this select 0;
						
							_eDst = 1000;
							_onPlace = false;
							_getBack = false;

							waitUntil 
								{
								sleep 10;

									{
									_eLdr = vehicle (leader _x);
									_eDst = _eLdr distance _Lpos;

									if (_eDst < 600) exitWith {_getBack = true}
									}
								foreach (_logic getvariable "HAC_HQ_KnEnemiesG");

								if (isNull (_logic getvariable "HAC_HQ")) then 
									{
									_onPlace = true
									}
								else
									{
									if not (_getBack) then
										{
										if (((vehicle _logic) distance _LPos) < 30) then {_onPlace = true}
										}
									};
								

								((_getback) or (_onPlace))
								};

							if not (_onPlace) then
								{
								_rds = 30;
								if ((_logic getvariable "HAC_HQ_NObj") <= 2) then {_Lpos = getposATL (vehicle _logic);_rds = 0};
								if ((_logic getvariable "HAC_HQ_NObj") == 3) then {_Lpos = position (_logic getvariable "HAC_HQ_Obj1")};
								if ((_logic getvariable "HAC_HQ_NObj") >= 4) then {_Lpos = position (_logic getvariable "HAC_HQ_Obj2")};

								_getBack = false;

									{
									_eLdr = vehicle (leader _x);
									_eDst = _eLdr distance _Lpos;

									if (_eDst < 600) exitWith {_getBack = true}
									}
								foreach (_logic getvariable "HAC_HQ_KnEnemiesG");

								if (_getBack) then {_Lpos = getposATL (vehicle _logic);_rds = 0};

								[(_logic getvariable "HAC_HQ"),_logic] call ALiVE_fnc_HAC_WPdel;	

								_spd = "NORMAL";
								if not (((vehicle _logic) distance _LPos) < 50) then {_spd = "FULL"};
								_wp = [_logic,(_logic getvariable "HAC_HQ"),_Lpos,"HOLD","AWARE","GREEN",_spd,["true",""],true,_rds,[0,0,0],"FILE"] call ALiVE_fnc_HAC_WPadd;
								if (isNull (assignedVehicle _logic)) then
									{
									if ((_logic getvariable "HAC_HQ_GetHQInside")) then {[_wp,_logic] call ALiVE_fnc_HAC_GoInside}
									};

								(_logic getvariable "HAC_HQ") setVariable ["onMove",true];
								}
							}
						}
					}
				}
			}
		};
    };
	if (isNil {_logic getvariable "HAC_HQ_CommDelay"}) then {_logic setvariable ["HAC_HQ_CommDelay", 1]};
	_delay = (((22.5 + (count (_logic getvariable "HAC_HQ_Friends")))/(0.5 + (_logic getvariable "HAC_HQ_Reflex"))) * (_logic getvariable "HAC_HQ_CommDelay"));
	sleep _delay;

		{
		(_logic getvariable "HAC_HQ") reveal vehicle (leader _x)
		}
        foreach (_logic getvariable "HAC_HQ_Friends");

	for [{_z = 0},{_z < (count (_logic getvariable "HAC_HQ_KnEnemies"))},{_z = _z + 1}] do
		{
		_KnEnemy = (_logic getvariable "HAC_HQ_KnEnemies") select _z;

			{
			if ((_x knowsAbout _KnEnemy) > 0.01) then {(_logic getvariable "HAC_HQ") reveal [_KnEnemy,2]} 
			}
		foreach (_logic getvariable "HAC_HQ_Friends")
		}
	};