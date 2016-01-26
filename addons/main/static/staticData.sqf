/*
VNPA MISSIONS FACTORY
 
@filename: staticData.sqf

Author:
	
	ALiVE Development Team
	
	maquez [Q-Net]

Special Thanks:

	N/A

Last modified:

	26-01-2016

Description:

	Declaring Faction Mappings for RHS.
	
	http://alivemod.com/wiki/index.php/Declaring_Faction_Mappings
____________________________________________________________________________
// ----------------------------------------------------------------------
//usage:
//copy this to init.sqf
// ----------------------------------------------------------------------
// ----------------------------------------------------------------------
if(isServer) then {
	// ------------------------------------------------------------------
	// override default data 
	// see script/staticData.sqf
	["MISSION INIT - Waiting"] call ALIVE_fnc_dump;
 
	waitUntil {!isNil "ALiVE_STATIC_DATA_LOADED"};
 
	["MISSION INIT - Continue"] call ALIVE_fnc_dump;
 
	// override static data settings
	call compile (preprocessFileLineNumbers "script\staticData.sqf");
 
	["MISSION INIT - Static data override loaded"] call ALIVE_fnc_dump;
 
	// -----------------------------------------------------------------
};
	// -----------------------------------------------------------------
____________________________________________________________________________*/
// RHS
// ---------------------------------------------------------------------------------------------------------------------

ALIVE_RHSResupplyVehicleOptions = [] call ALIVE_fnc_hashCreate;
[ALIVE_RHSResupplyVehicleOptions, "PR_AIRDROP", [["<< Back","Car","Ship","RHS Car","RHS Truck"],["<< Back","Car","Ship","rhs_vehclass_car","rhs_vehclass_truck"]]] call ALIVE_fnc_hashSet;
[ALIVE_RHSResupplyVehicleOptions, "PR_HELI_INSERT", [["<< Back","Air","RHS Helicopter"],["<< Back","Air","rhs_vehclass_helicopter"]]] call ALIVE_fnc_hashSet;
[ALIVE_RHSResupplyVehicleOptions, "PR_STANDARD", [["<< Back","Car","Armored","Support","RHS Car","RHS Truck","RHS MRAP","RHS IFV","RHS APC","RHS Tank","RHS AA","RHS Artillery"],["<< Back","Car","Armored","Support","rhs_vehclass_car","rhs_vehclass_truck","rhs_vehclass_MRAP","rhs_vehclass_ifv","rhs_vehclass_apc","rhs_vehclass_tank","rhs_vehclass_aa","rhs_vehclass_artillery"]]] call ALIVE_fnc_hashSet;

[ALIVE_factionDefaultResupplyVehicleOptions, "rhs_faction_usarmy_wd", ALIVE_RHSResupplyVehicleOptions] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultResupplyVehicleOptions, "rhs_faction_usarmy_d", ALIVE_RHSResupplyVehicleOptions] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultResupplyVehicleOptions, "rhs_faction_usmc_wd", ALIVE_RHSResupplyVehicleOptions] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultResupplyVehicleOptions, "rhs_faction_usmc_d", ALIVE_RHSResupplyVehicleOptions] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultResupplyVehicleOptions, "rhs_faction_usaf", ALIVE_RHSResupplyVehicleOptions] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultResupplyVehicleOptions, "rhs_faction_usn", ALIVE_RHSResupplyVehicleOptions] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultResupplyVehicleOptions, "rhs_faction_socom", ALIVE_RHSResupplyVehicleOptions] call ALIVE_fnc_hashSet;

[ALIVE_factionDefaultResupplyVehicleOptions, "rhs_faction_msv", ALIVE_RHSResupplyVehicleOptions] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultResupplyVehicleOptions, "rhs_faction_vdv", ALIVE_RHSResupplyVehicleOptions] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultResupplyVehicleOptions, "rhs_faction_vmf", ALIVE_RHSResupplyVehicleOptions] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultResupplyVehicleOptions, "rhs_faction_vv", ALIVE_RHSResupplyVehicleOptions] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultResupplyVehicleOptions, "rhs_faction_tv", ALIVE_RHSResupplyVehicleOptions] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultResupplyVehicleOptions, "rhs_faction_vpvo", ALIVE_RHSResupplyVehicleOptions] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultResupplyVehicleOptions, "rhs_faction_vvs", ALIVE_RHSResupplyVehicleOptions] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultResupplyVehicleOptions, "rhs_faction_vvs_c", ALIVE_RHSResupplyVehicleOptions] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultResupplyVehicleOptions, "rhs_faction_rva", ALIVE_RHSResupplyVehicleOptions] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultResupplyVehicleOptions, "rhs_faction_insurgents", ALIVE_RHSResupplyVehicleOptions] call ALIVE_fnc_hashSet;



ALIVE_RHSResupplyIndividualOptions = [] call ALIVE_fnc_hashCreate;
[ALIVE_RHSResupplyIndividualOptions, "PR_AIRDROP", [["<< Back","Men","MenDiver","MenRecon","MenSniper","MenSupport","RHS Infantry"],["<< Back","Men","MenDiver","MenRecon","MenSniper","MenSupport","rhs_vehclass_infantry"]]] call ALIVE_fnc_hashSet;
[ALIVE_RHSResupplyIndividualOptions, "PR_HELI_INSERT", [["<< Back","Men","MenDiver","MenRecon","MenSniper","MenSupport","RHS Infantry"],["<< Back","Men","MenDiver","MenRecon","MenSniper","MenSupport","rhs_vehclass_infantry"]]] call ALIVE_fnc_hashSet;
[ALIVE_RHSResupplyIndividualOptions, "PR_STANDARD", [["<< Back","Men","MenDiver","MenRecon","MenSniper","MenSupport","RHS Infantry"],["<< Back","Men","MenDiver","MenRecon","MenSniper","MenSupport","rhs_vehclass_infantry"]]] call ALIVE_fnc_hashSet;

[ALIVE_factionDefaultResupplyIndividualOptions, "rhs_faction_usarmy_wd", ALIVE_RHSResupplyIndividualOptions] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultResupplyIndividualOptions, "rhs_faction_usarmy_d", ALIVE_RHSResupplyIndividualOptions] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultResupplyIndividualOptions, "rhs_faction_usmc_wd", ALIVE_RHSResupplyIndividualOptions] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultResupplyIndividualOptions, "rhs_faction_usmc_d", ALIVE_RHSResupplyIndividualOptions] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultResupplyIndividualOptions, "rhs_faction_usaf", ALIVE_RHSResupplyIndividualOptions] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultResupplyIndividualOptions, "rhs_faction_usn", ALIVE_RHSResupplyIndividualOptions] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultResupplyIndividualOptions, "rhs_faction_socom", ALIVE_RHSResupplyIndividualOptions] call ALIVE_fnc_hashSet;

[ALIVE_factionDefaultResupplyIndividualOptions, "rhs_faction_msv", ALIVE_RHSResupplyIndividualOptions] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultResupplyIndividualOptions, "rhs_faction_vdv", ALIVE_RHSResupplyIndividualOptions] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultResupplyIndividualOptions, "rhs_faction_vmf", ALIVE_RHSResupplyIndividualOptions] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultResupplyIndividualOptions, "rhs_faction_vv", ALIVE_RHSResupplyIndividualOptions] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultResupplyIndividualOptions, "rhs_faction_tv", ALIVE_RHSResupplyIndividualOptions] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultResupplyIndividualOptions, "rhs_faction_vpvo", ALIVE_RHSResupplyIndividualOptions] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultResupplyIndividualOptions, "rhs_faction_vvs", ALIVE_RHSResupplyIndividualOptions] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultResupplyIndividualOptions, "rhs_faction_vvs_c", ALIVE_RHSResupplyIndividualOptions] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultResupplyIndividualOptions, "rhs_faction_rva", ALIVE_RHSResupplyIndividualOptions] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultResupplyIndividualOptions, "rhs_faction_insurgents", ALIVE_RHSResupplyIndividualOptions] call ALIVE_fnc_hashSet;



ALIVE_RHSResupplyGroupOptions = [] call ALIVE_fnc_hashCreate;
[ALIVE_RHSResupplyGroupOptions, "PR_AIRDROP", [
	"Armored",
	"Support",
	"rhs_group_nato_usarmy_wd_m1a1",
	"rhs_group_nato_usarmy_wd_M1A2",
	"rhs_group_nato_usarmy_wd_M109",
	"rhs_group_nato_usarmy_d_m1a1",
	"rhs_group_nato_usarmy_d_M1A2",
	"rhs_group_nato_usarmy_d_M109",
	"rhs_group_nato_usmc_d_m1a1",
	"rhs_group_nato_usmc_wd_m1a1",
	"rhs_group_rus_msv_bm21",
	"rhs_group_rus_vdv_mi8",
	"rhs_group_rus_vdv_mi24",
	"rhs_group_rus_vdv_bm21",
	"rhs_group_rus_tv_72",
	"rhs_group_rus_tv_80",
	"rhs_group_rus_tv_90",
	"rhs_group_rus_tv_2s3",
	"rhs_group_chdkz_bm21",
	"rhs_group_chdkz_72"
]] call ALIVE_fnc_hashSet;
[ALIVE_RHSResupplyGroupOptions, "PR_HELI_INSERT", [
	"Armored",
	"Mechanized",
	"Motorized",
	"Motorized_MTP",
	"SpecOps",
	"Support",
	"Motorized_MTP",
	"SpecOps",
	"Support",
	"rhs_group_nato_usarmy_wd_RG33",
	"rhs_group_nato_usarmy_wd_FMTV",
	"rhs_group_nato_usarmy_wd_HMMWV",
	"rhs_group_nato_usarmy_wd_M113",
	"rhs_group_nato_usarmy_wd_bradley",
	"rhs_group_nato_usarmy_wd_bradleyA3",
	"rhs_group_nato_usarmy_wd_m1a1",
	"rhs_group_nato_usarmy_wd_M1A2",
	"rhs_group_nato_usarmy_wd_M109",
	"rhs_group_nato_usarmy_d_RG33",
	"rhs_group_nato_usarmy_d_FMTV",
	"rhs_group_nato_usarmy_d_HMMWV",
	"rhs_group_nato_usarmy_d_M113",
	"rhs_group_nato_usarmy_d_bradley",
	"rhs_group_nato_usarmy_d_bradleyA3",
	"rhs_group_nato_usarmy_d_m1a1",
	"rhs_group_nato_usarmy_d_M1A2",
	"rhs_group_nato_usarmy_d_M109",
	"rhs_group_nato_usmc_wd_HMMWV",
	"rhs_group_nato_usmc_wd_RG33",
	"rhs_group_nato_usmc_wd_m1a1",
	"rhs_group_nato_usmc_d_RG33",
	"rhs_group_nato_usmc_d_HMMWV",
	"rhs_group_nato_usmc_d_m1a1",
	"rhs_group_rus_msv_Ural",
	"rhs_group_rus_msv_gaz66",
	"rhs_group_rus_msv_btr70",
	"rhs_group_rus_msv_BTR80",
	"rhs_group_rus_msv_BTR80a",
	"rhs_group_rus_msv_bmp1",
	"rhs_group_rus_msv_bmp2",
	"rhs_group_rus_MSV_BMP3",
	"rhs_group_rus_msv_bm21",
	"rhs_group_rus_vdv_Ural",
	"rhs_group_rus_vdv_gaz66",
	"rhs_group_rus_vdv_btr60",
	"rhs_group_rus_vdv_btr70",
	"rhs_group_rus_vdv_BTR80",
	"rhs_group_rus_vdv_BTR80a",
	"rhs_group_rus_vdv_bmp1",
	"rhs_group_rus_vdv_bmp2",
	"rhs_group_rus_vdv_bmd1",
	"rhs_group_rus_vdv_bmd2",
	"rhs_group_rus_vdv_bmd4",
	"rhs_group_rus_vdv_bmd4m",
	"rhs_group_rus_vdv_bmd4ma",
	"rhs_group_rus_vdv_2s25",
	"rhs_group_rus_vdv_mi8",
	"rhs_group_rus_vdv_mi24",
	"rhs_group_rus_vdv_bm21",
	"rhs_group_rus_tv_72",
	"rhs_group_rus_tv_80",
	"rhs_group_rus_tv_90",
	"rhs_group_rus_tv_2s3",
	"rhs_group_chdkz_Ural",
	"rhs_group_chdkz_btr60",
	"rhs_group_chdkz_btr70",
	"rhs_group_chdkz_bmp1",
	"rhs_group_chdkz_bmp2",
	"rhs_group_chdkz_bmd1",
	"rhs_group_chdkz_bmd2",
	"rhs_group_chdkz_bm21",
	"rhs_group_chdkz_72"	
]] call ALIVE_fnc_hashSet;
[ALIVE_RHSResupplyGroupOptions, "PR_STANDARD", ["Support"]] call ALIVE_fnc_hashSet;

[ALIVE_factionDefaultResupplyGroupOptions, "rhs_faction_usarmy_wd", ALIVE_RHSResupplyGroupOptions] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultResupplyGroupOptions, "rhs_faction_usarmy_d", ALIVE_RHSResupplyGroupOptions] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultResupplyGroupOptions, "rhs_faction_usmc_wd", ALIVE_RHSResupplyGroupOptions] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultResupplyGroupOptions, "rhs_faction_usmc_d", ALIVE_RHSResupplyGroupOptions] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultResupplyGroupOptions, "rhs_faction_usaf", ALIVE_RHSResupplyGroupOptions] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultResupplyGroupOptions, "rhs_faction_usn", ALIVE_RHSResupplyGroupOptions] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultResupplyGroupOptions, "rhs_faction_socom", ALIVE_RHSResupplyGroupOptions] call ALIVE_fnc_hashSet;

[ALIVE_factionDefaultResupplyGroupOptions, "rhs_faction_msv", ALIVE_RHSResupplyGroupOptions] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultResupplyGroupOptions, "rhs_faction_vdv", ALIVE_RHSResupplyGroupOptions] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultResupplyGroupOptions, "rhs_faction_tv", ALIVE_RHSResupplyGroupOptions] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultResupplyGroupOptions, "rhs_faction_vmf", ALIVE_RHSResupplyGroupOptions] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultResupplyGroupOptions, "rhs_faction_vv", ALIVE_RHSResupplyGroupOptions] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultResupplyGroupOptions, "rhs_faction_vpvo", ALIVE_RHSResupplyGroupOptions] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultResupplyGroupOptions, "rhs_faction_vvs", ALIVE_RHSResupplyGroupOptions] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultResupplyGroupOptions, "rhs_faction_vvs_c", ALIVE_RHSResupplyGroupOptions] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultResupplyGroupOptions, "rhs_faction_rva", ALIVE_RHSResupplyGroupOptions] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultResupplyGroupOptions, "rhs_faction_insurgents", ALIVE_RHSResupplyGroupOptions] call ALIVE_fnc_hashSet;



// RHS USAF ----------------------------------------------------------------------------------------------------------------

// rhs_faction_usarmy_wd

rhs_faction_usarmy_wd_mappings = [] call ALIVE_fnc_hashCreate;

rhs_faction_usarmy_wd_factionCustomGroups = [] call ALIVE_fnc_hashCreate;

[rhs_faction_usarmy_wd_mappings, "Side", "WEST"] call ALIVE_fnc_hashSet;
[rhs_faction_usarmy_wd_mappings, "GroupSideName", "WEST"] call ALIVE_fnc_hashSet;
[rhs_faction_usarmy_wd_mappings, "FactionName", "rhs_faction_usarmy_wd"] call ALIVE_fnc_hashSet;
[rhs_faction_usarmy_wd_mappings, "GroupFactionName", "rhs_faction_usarmy_wd"] call ALIVE_fnc_hashSet;

rhs_faction_usarmy_wd_typeMappings = [] call ALIVE_fnc_hashCreate;

[rhs_faction_usarmy_wd_mappings, "GroupFactionTypes", rhs_faction_usarmy_wd_typeMappings] call ALIVE_fnc_hashSet;

[rhs_faction_usarmy_wd_factionCustomGroups, "Infantry", ["rhs_group_nato_usarmy_wd_infantry_squad","rhs_group_nato_usarmy_wd_infantry_weaponsquad","rhs_group_nato_usarmy_wd_infantry_squad_sniper","rhs_group_nato_usarmy_wd_infantry_team","rhs_group_nato_usarmy_wd_infantry_team_MG","rhs_group_nato_usarmy_wd_infantry_team_AA","rhs_group_nato_usarmy_wd_infantry_team_support","rhs_group_nato_usarmy_wd_infantry_team_heavy_AT"]] call ALIVE_fnc_hashSet;
[rhs_faction_usarmy_wd_factionCustomGroups, "Motorized", ["BUS_MotInf_Team_GMG","BUS_MotInf_Team_HMG","BUS_MotInf_AT","BUS_MotInf_AA","rhs_group_nato_usarmy_wd_FMTV_1078_squad","rhs_group_nato_usarmy_wd_FMTV_1078_squad_2mg","rhs_group_nato_usarmy_wd_FMTV_1078_squad_sniper","rhs_group_nato_usarmy_wd_FMTV_1078_squad_mg_sniper","rhs_group_nato_usarmy_wd_FMTV_1083_squad","rhs_group_nato_usarmy_wd_FMTV_1083_squad_2mg","rhs_group_nato_usarmy_wd_FMTV_1083_squad_sniper","rhs_group_nato_usarmy_wd_FMTV_1083_squad_mg_sniper","rhs_group_nato_usarmy_wd_RG33_squad","rhs_group_nato_usarmy_wd_RG33_squad_2mg","rhs_group_nato_usarmy_wd_RG33_squad_sniper","rhs_group_nato_usarmy_wd_RG33_squad_mg_sniper","rhs_group_nato_usarmy_wd_RG33_m2_squad","rhs_group_nato_usarmy_wd_RG33_m2_squad_2mg","rhs_group_nato_usarmy_wd_RG33_m2_squad_sniper","rhs_group_nato_usarmy_wd_RG33_m2_squad_mg_sniper"]] call ALIVE_fnc_hashSet;
[rhs_faction_usarmy_wd_factionCustomGroups, "Mechanized", ["rhs_group_nato_usarmy_wd_bradleyA3_squad","rhs_group_nato_usarmy_wd_bradleyA3_squad_2mg","rhs_group_nato_usarmy_wd_bradleyA3_squad_sniper","rhs_group_nato_usarmy_wd_bradleyA3_squad_mg_sniper","rhs_group_nato_usarmy_d_bradleyA3_aa","rhs_group_nato_usarmy_wd_bradley_squad","rhs_group_nato_usarmy_wd_bradley_squad_2mg","rhs_group_nato_usarmy_wd_bradley_squad_sniper","rhs_group_nato_usarmy_wd_bradley_squad_mg_sniper","rhs_group_nato_usarmy_d_bradley_aa","rhs_group_nato_usarmy_wd_M113_squad","rhs_group_nato_usarmy_wd_M113_squad_2mg","rhs_group_nato_usarmy_wd_M113_squad_sniper","rhs_group_nato_usarmy_wd_M113_squad_mg_sniper"]] call ALIVE_fnc_hashSet;
[rhs_faction_usarmy_wd_factionCustomGroups, "Armored", ["RHS_M1A2SEP_wd_Platoon","RHS_M1A2SEP_wd_Platoon_AA","RHS_M1A2SEP_wd_Section","RHS_M1A2SEP_wd_TUSK_Platoon","RHS_M1A2SEP_wd_TUSK_Platoon_AA","RHS_M1A2SEP_wd_TUSK_Section","RHS_M1A2SEP_wd_TUSK2_Platoon","RHS_M1A2SEP_wd_TUSK2_Platoon_AA","RHS_M1A2SEP_wd_TUSK2_Section","RHS_M1A1AIM_wd_Platoon","RHS_M1A1AIM_wd_Platoon_AA","RHS_M1A1AIM_wd_Section","RHS_M1A1AIM_wd_TUSK_Platoon","RHS_M1A1AIM_wd_TUSK_Platoon_AA","RHS_M1A1AIM_wd_TUSK_Section"]] call ALIVE_fnc_hashSet;
[rhs_faction_usarmy_wd_factionCustomGroups, "Artillery", ["RHS_M109_wd_Platoon","RHS_M109_wd_Section"]] call ALIVE_fnc_hashSet;

[rhs_faction_usarmy_wd_mappings, "Groups", rhs_faction_usarmy_wd_factionCustomGroups] call ALIVE_fnc_hashSet;

[ALIVE_factionCustomMappings, "rhs_faction_usarmy_wd", rhs_faction_usarmy_wd_mappings] call ALIVE_fnc_hashSet;

[ALIVE_factionDefaultSupports, "rhs_faction_usarmy_wd", ["rhsusf_rg33_usmc_wd","rhsusf_rg33_m2_usmc_wd","rhsusf_m998_w_s_2dr","rhsusf_m998_w_s_2dr_halftop","rhsusf_m998_w_s_2dr_fulltop","rhsusf_m998_w_s_4dr","rhsusf_m998_w_s_4dr_halftop","rhsusf_m998_w_s_4dr_fulltop","rhsusf_m1025_w_s","rhsusf_m1025_w_s_m2","rhsusf_m1025_w_s_Mk19","rhsusf_rg33_wd","rhsusf_rg33_m2_wd","rhsusf_m998_w_2dr","rhsusf_m998_w_2dr_halftop","rhsusf_m998_w_2dr_fulltop","rhsusf_m998_w_4dr","rhsusf_m998_w_4dr_halftop","rhsusf_m998_w_4dr_fulltop","rhsusf_m1025_w","rhsusf_m1025_w_m2","rhsusf_m1025_w_mk19","rhsusf_m109_usarmy","RHS_M6_wd"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultTransport, "rhs_faction_usarmy_wd", ["rhsusf_M1078A1P2_B_wd_fmtv_usarmy","rhsusf_M1078A1P2_wd_fmtv_usarmy","rhsusf_M1083A1P2_B_wd_fmtv_usarmy","rhsusf_M1083A1P2_wd_fmtv_usarmy","rhsusf_M977A2_usarmy_wd","rhsusf_M977A2_CPK_usarmy_wd"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultAirTransport, "rhs_faction_usarmy_wd", ["RHS_CH_47F","RHS_UH60M","RHS_UH60M_MEV","RHS_UH60M_MEV2"]] call ALIVE_fnc_hashSet;

/*
// rhs_vehclass_truck
[ALIVE_factionDefaultSupports, "rhs_faction_usarmy_wd", ["rhsusf_M1078A1P2_B_wd_fmtv_usarmy","rhsusf_M1078A1P2_wd_fmtv_usarmy","rhsusf_M1083A1P2_B_wd_fmtv_usarmy","rhsusf_M1083A1P2_wd_fmtv_usarmy","rhsusf_M977A2_usarmy_wd","rhsusf_M977A2_CPK_usarmy_wd","rhsusf_M978A2_usarmy_wd","rhsusf_M978A2_CPK_usarmy_wd"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultSupplies, "rhs_faction_usarmy_wd", ["rhsusf_M1078A1P2_B_wd_fmtv_usarmy","rhsusf_M1078A1P2_wd_fmtv_usarmy","rhsusf_M1083A1P2_B_wd_fmtv_usarmy","rhsusf_M1083A1P2_wd_fmtv_usarmy","rhsusf_M977A2_usarmy_wd","rhsusf_M977A2_CPK_usarmy_wd","rhsusf_M978A2_usarmy_wd","rhsusf_M978A2_CPK_usarmy_wd"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultTransport, "rhs_faction_usarmy_wd", ["rhsusf_M1078A1P2_B_wd_fmtv_usarmy","rhsusf_M1078A1P2_wd_fmtv_usarmy","rhsusf_M1083A1P2_B_wd_fmtv_usarmy","rhsusf_M1083A1P2_wd_fmtv_usarmy","rhsusf_M977A2_usarmy_wd","rhsusf_M977A2_CPK_usarmy_wd","rhsusf_M978A2_usarmy_wd","rhsusf_M978A2_CPK_usarmy_wd"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultAirTransport, "rhs_faction_usarmy_wd", ["rhsusf_M1078A1P2_B_wd_fmtv_usarmy","rhsusf_M1078A1P2_wd_fmtv_usarmy","rhsusf_M1083A1P2_B_wd_fmtv_usarmy","rhsusf_M1083A1P2_wd_fmtv_usarmy","rhsusf_M977A2_usarmy_wd","rhsusf_M977A2_CPK_usarmy_wd","rhsusf_M978A2_usarmy_wd","rhsusf_M978A2_CPK_usarmy_wd"]] call ALIVE_fnc_hashSet;

// rhs_vehclass_MRAP
[ALIVE_factionDefaultSupports, "rhs_faction_usarmy_wd", ["rhsusf_rg33_wd","rhsusf_rg33_m2_wd"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultSupplies, "rhs_faction_usarmy_wd", ["rhsusf_rg33_wd","rhsusf_rg33_m2_wd"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultTransport, "rhs_faction_usarmy_wd", ["rhsusf_rg33_wd","rhsusf_rg33_m2_wd"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultAirTransport, "rhs_faction_usarmy_wd", ["rhsusf_rg33_wd","rhsusf_rg33_m2_wd"]] call ALIVE_fnc_hashSet;

// Static
[ALIVE_factionDefaultSupports, "rhs_faction_usarmy_wd", ["RHS_Stinger_AA_pod_WD","RHS_M2StaticMG_WD","RHS_M2StaticMG_MiniTripod_WD","RHS_TOW_TriPod_WD","RHS_MK19_TriPod_WD"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultSupplies, "rhs_faction_usarmy_wd", ["RHS_Stinger_AA_pod_WD","RHS_M2StaticMG_WD","RHS_M2StaticMG_MiniTripod_WD","RHS_TOW_TriPod_WD","RHS_MK19_TriPod_WD"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultTransport, "rhs_faction_usarmy_wd", ["RHS_Stinger_AA_pod_WD","RHS_M2StaticMG_WD","RHS_M2StaticMG_MiniTripod_WD","RHS_TOW_TriPod_WD","RHS_MK19_TriPod_WD"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultAirTransport, "rhs_faction_usarmy_wd", ["RHS_Stinger_AA_pod_WD","RHS_M2StaticMG_WD","RHS_M2StaticMG_MiniTripod_WD","RHS_TOW_TriPod_WD","RHS_MK19_TriPod_WD"]] call ALIVE_fnc_hashSet;

// rhs_vehclass_car
[ALIVE_factionDefaultSupports, "rhs_faction_usarmy_wd", ["rhsusf_m998_w_2dr","rhsusf_m998_w_2dr_halftop","rhsusf_m998_w_2dr_fulltop","rhsusf_m998_w_4dr","rhsusf_m998_w_4dr_halftop","rhsusf_m998_w_4dr_fulltop","rhsusf_m1025_w","rhsusf_m1025_w_m2","rhsusf_m1025_w_mk19"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultSupplies, "rhs_faction_usarmy_wd", ["rhsusf_m998_w_2dr","rhsusf_m998_w_2dr_halftop","rhsusf_m998_w_2dr_fulltop","rhsusf_m998_w_4dr","rhsusf_m998_w_4dr_halftop","rhsusf_m998_w_4dr_fulltop","rhsusf_m1025_w","rhsusf_m1025_w_m2","rhsusf_m1025_w_mk19"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultTransport, "rhs_faction_usarmy_wd", ["rhsusf_m998_w_2dr","rhsusf_m998_w_2dr_halftop","rhsusf_m998_w_2dr_fulltop","rhsusf_m998_w_4dr","rhsusf_m998_w_4dr_halftop","rhsusf_m998_w_4dr_fulltop","rhsusf_m1025_w","rhsusf_m1025_w_m2","rhsusf_m1025_w_mk19"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultAirTransport, "rhs_faction_usarmy_wd", ["rhsusf_m998_w_2dr","rhsusf_m998_w_2dr_halftop","rhsusf_m998_w_2dr_fulltop","rhsusf_m998_w_4dr","rhsusf_m998_w_4dr_halftop","rhsusf_m998_w_4dr_fulltop","rhsusf_m1025_w","rhsusf_m1025_w_m2","rhsusf_m1025_w_mk19"]] call ALIVE_fnc_hashSet;

// rhs_vehclass_artillery
[ALIVE_factionDefaultSupports, "rhs_faction_usarmy_wd", ["rhsusf_m109_usarmy","RHS_M119_WD","RHS_M252_WD"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultSupplies, "rhs_faction_usarmy_wd", ["rhsusf_m109_usarmy","RHS_M119_WD","RHS_M252_WD"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultTransport, "rhs_faction_usarmy_wd", ["rhsusf_m109_usarmy","RHS_M119_WD","RHS_M252_WD"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultAirTransport, "rhs_faction_usarmy_wd", ["rhsusf_m109_usarmy","RHS_M119_WD","RHS_M252_WD"]] call ALIVE_fnc_hashSet;

// rhs_vehclass_apc
[ALIVE_factionDefaultSupports, "rhs_faction_usarmy_wd", ["rhsusf_m113_usarmy"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultSupplies, "rhs_faction_usarmy_wd", ["rhsusf_m113_usarmy"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultTransport, "rhs_faction_usarmy_wd", ["rhsusf_m113_usarmy"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultAirTransport, "rhs_faction_usarmy_wd", ["rhsusf_m113_usarmy"]] call ALIVE_fnc_hashSet;

// rhs_vehclass_tank
[ALIVE_factionDefaultSupports, "rhs_faction_usarmy_wd", ["rhsusf_m1a1aimwd_usarmy","rhsusf_m1a1aim_tuski_wd","rhsusf_m1a2sep1wd_usarmy","rhsusf_m1a2sep1tuskiwd_usarmy","rhsusf_m1a2sep1tuskiiwd_usarmy"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultSupplies, "rhs_faction_usarmy_wd", ["rhsusf_m1a1aimwd_usarmy","rhsusf_m1a1aim_tuski_wd","rhsusf_m1a2sep1wd_usarmy","rhsusf_m1a2sep1tuskiwd_usarmy","rhsusf_m1a2sep1tuskiiwd_usarmy"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultTransport, "rhs_faction_usarmy_wd", ["rhsusf_m1a1aimwd_usarmy","rhsusf_m1a1aim_tuski_wd","rhsusf_m1a2sep1wd_usarmy","rhsusf_m1a2sep1tuskiwd_usarmy","rhsusf_m1a2sep1tuskiiwd_usarmy"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultAirTransport, "rhs_faction_usarmy_wd", ["rhsusf_m1a1aimwd_usarmy","rhsusf_m1a1aim_tuski_wd","rhsusf_m1a2sep1wd_usarmy","rhsusf_m1a2sep1tuskiwd_usarmy","rhsusf_m1a2sep1tuskiiwd_usarmy"]] call ALIVE_fnc_hashSet;

// rhs_vehclass_helicopter
[ALIVE_factionDefaultSupports, "rhs_faction_usarmy_wd", ["RHS_AH64D_wd","RHS_AH64D_wd_GS","RHS_AH64D_wd_CS","RHS_CH_47F","RHS_UH60M","RHS_UH60M_MEV","RHS_UH60M_MEV2"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultSupplies, "rhs_faction_usarmy_wd", ["RHS_AH64D_wd","RHS_AH64D_wd_GS","RHS_AH64D_wd_CS","RHS_CH_47F","RHS_UH60M","RHS_UH60M_MEV","RHS_UH60M_MEV2"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultTransport, "rhs_faction_usarmy_wd", ["RHS_AH64D_wd","RHS_AH64D_wd_GS","RHS_AH64D_wd_CS","RHS_CH_47F","RHS_UH60M","RHS_UH60M_MEV","RHS_UH60M_MEV2"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultAirTransport, "rhs_faction_usarmy_wd", ["RHS_AH64D_wd","RHS_AH64D_wd_GS","RHS_AH64D_wd_CS","RHS_CH_47F","RHS_UH60M","RHS_UH60M_MEV","RHS_UH60M_MEV2"]] call ALIVE_fnc_hashSet;

// rhs_vehclass_ifv
[ALIVE_factionDefaultSupports, "rhs_faction_usarmy_wd", ["RHS_M2A3_BUSKIII_wd","RHS_M2A2_wd","RHS_M2A2_BUSKI_WD","RHS_M2A3_BUSKI_wd","RHS_M2A3_wd"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultSupplies, "rhs_faction_usarmy_wd", ["RHS_M2A3_BUSKIII_wd","RHS_M2A2_wd","RHS_M2A2_BUSKI_WD","RHS_M2A3_BUSKI_wd","RHS_M2A3_wd"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultTransport, "rhs_faction_usarmy_wd", ["RHS_M2A3_BUSKIII_wd","RHS_M2A2_wd","RHS_M2A2_BUSKI_WD","RHS_M2A3_BUSKI_wd","RHS_M2A3_wd"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultAirTransport, "rhs_faction_usarmy_wd", ["RHS_M2A3_BUSKIII_wd","RHS_M2A2_wd","RHS_M2A2_BUSKI_WD","RHS_M2A3_BUSKI_wd","RHS_M2A3_wd"]] call ALIVE_fnc_hashSet;

// rhs_vehclass_aa
[ALIVE_factionDefaultSupports, "rhs_faction_usarmy_wd", ["RHS_M6_wd"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultSupplies, "rhs_faction_usarmy_wd", ["RHS_M6_wd"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultTransport, "rhs_faction_usarmy_wd", ["RHS_M6_wd"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultAirTransport, "rhs_faction_usarmy_wd", ["RHS_M6_wd"]] call ALIVE_fnc_hashSet;
*/


// rhs_faction_usarmy_d

rhs_faction_usarmy_d_mappings = [] call ALIVE_fnc_hashCreate;

rhs_faction_usarmy_d_factionCustomGroups = [] call ALIVE_fnc_hashCreate;

[rhs_faction_usarmy_d_mappings, "Side", "WEST"] call ALIVE_fnc_hashSet;
[rhs_faction_usarmy_d_mappings, "GroupSideName", "WEST"] call ALIVE_fnc_hashSet;
[rhs_faction_usarmy_d_mappings, "FactionName", "rhs_faction_usarmy_d"] call ALIVE_fnc_hashSet;
[rhs_faction_usarmy_d_mappings, "GroupFactionName", "rhs_faction_usarmy_d"] call ALIVE_fnc_hashSet;

rhs_faction_usarmy_d_typeMappings = [] call ALIVE_fnc_hashCreate;

[rhs_faction_usarmy_d_mappings, "GroupFactionTypes", rhs_faction_usarmy_d_typeMappings] call ALIVE_fnc_hashSet;

[rhs_faction_usarmy_d_factionCustomGroups, "Infantry", ["rhs_group_nato_usarmy_d_infantry_squad","rhs_group_nato_usarmy_d_infantry_weaponsquad","rhs_group_nato_usarmy_d_infantry_squad_sniper","rhs_group_nato_usarmy_d_infantry_team","rhs_group_nato_usarmy_d_infantry_team_MG","rhs_group_nato_usarmy_d_infantry_team_AA","rhs_group_nato_usarmy_d_infantry_team_AT","rhs_group_nato_usarmy_d_infantry_team_support"]] call ALIVE_fnc_hashSet;
[rhs_faction_usarmy_d_factionCustomGroups, "Motorized", ["BUS_MotInf_Team_GMG","BUS_MotInf_Team_HMG","BUS_MotInf_AT","BUS_MotInf_AA","rhs_group_nato_usarmy_d_FMTV_1078_squad","rhs_group_nato_usarmy_d_FMTV_1078_squad_2mg","rhs_group_nato_usarmy_d_FMTV_1078_squad_sniper","rhs_group_nato_usarmy_d_FMTV_1078_squad_mg_sniper","rhs_group_nato_usarmy_d_FMTV_1083_squad","rhs_group_nato_usarmy_d_FMTV_1083_squad_2mg","rhs_group_nato_usarmy_d_FMTV_1083_squad_sniper","rhs_group_nato_usarmy_d_FMTV_1083_squad_mg_sniper","rhs_group_nato_usarmy_d_RG33_squad","rhs_group_nato_usarmy_d_RG33_squad_2mg","rhs_group_nato_usarmy_d_RG33_squad_sniper","rhs_group_nato_usarmy_d_RG33_squad_mg_sniper","rhs_group_nato_usarmy_d_RG33_m2_squad","rhs_group_nato_usarmy_d_RG33_m2_squad_2mg","rhs_group_nato_usarmy_d_RG33_m2_squad_sniper","rhs_group_nato_usarmy_d_RG33_m2_squad_mg_sniper"]] call ALIVE_fnc_hashSet;
[rhs_faction_usarmy_d_factionCustomGroups, "Mechanized", ["rhs_group_nato_usarmy_d_bradleyA3_squad","rhs_group_nato_usarmy_d_bradleyA3_squad_2mg","rhs_group_nato_usarmy_d_bradleyA3_squad_sniper","rhs_group_nato_usarmy_d_bradleyA3_squad_mg_sniper","rhs_group_nato_usarmy_d_bradleyA3_aa","rhs_group_nato_usarmy_d_bradley_squad","rhs_group_nato_usarmy_d_bradley_squad_2mg","rhs_group_nato_usarmy_d_bradley_squad_sniper","rhs_group_nato_usarmy_d_bradley_squad_mg_sniper","rhs_group_nato_usarmy_d_bradley_aa","rhs_group_nato_usarmy_d_M113_squad","rhs_group_nato_usarmy_d_M113_squad_2mg","rhs_group_nato_usarmy_d_M113_squad_sniper","rhs_group_nato_usarmy_d_M113_squad_mg_sniper"]] call ALIVE_fnc_hashSet;
[rhs_faction_usarmy_d_factionCustomGroups, "Armored", ["RHS_M1A2SEP_Platoon","RHS_M1A2SEP_Platoon_AA","RHS_M1A2SEP_Section","RHS_M1A2SEP_TUSK_Platoon","RHS_M1A2SEP_TUSK_Platoon_AA","RHS_M1A2SEP_TUSK_Section","RHS_M1A2SEP_d_TUSK2_Platoon","RHS_M1A2SEP_d_TUSK2_Platoon_AA","RHS_M1A2SEP_d_TUSK2_Section","RHS_M1A1AIM_Platoon","RHS_M1A1AIM_Platoon_AA","RHS_M1A1AIM_Section","RHS_M1A1AIM_TUSK_Platoon","RHS_M1A1AIM_TUSK_Platoon_AA","RHS_M1A1AIM_TUSK_Section"]] call ALIVE_fnc_hashSet;
[rhs_faction_usarmy_d_factionCustomGroups, "Artillery", ["RHS_M109_Platoon","RHS_M109_Section"]] call ALIVE_fnc_hashSet;

[rhs_faction_usarmy_d_mappings, "Groups", rhs_faction_usarmy_d_factionCustomGroups] call ALIVE_fnc_hashSet;

[ALIVE_factionCustomMappings, "rhs_faction_usarmy_d", rhs_faction_usarmy_d_mappings] call ALIVE_fnc_hashSet;

[ALIVE_factionDefaultSupports, "rhs_faction_usarmy_d", ["rhsusf_m998_d_s_2dr","rhsusf_m998_d_s_2dr_halftop","rhsusf_m998_d_s_2dr_fulltop","rhsusf_m998_d_s_4dr","rhsusf_m998_d_s_4dr_halftop","rhsusf_m998_d_s_4dr_fulltop","rhsusf_m1025_d_s","rhsusf_m1025_d_s_m2","rhsusf_m1025_d_s_Mk19","rhsusf_rg33_usmc_d","rhsusf_rg33_m2_usmc_d","RHS_M6","rhsusf_m109d_usarmy","rhsusf_m998_d_2dr","rhsusf_m998_d_2dr_halftop","rhsusf_m998_d_2dr_fulltop","rhsusf_m998_d_4dr","rhsusf_m998_d_4dr_halftop","rhsusf_m998_d_4dr_fulltop","rhsusf_m1025_d","rhsusf_m1025_d_m2","rhsusf_m1025_d_Mk19","rhsusf_rg33_d","rhsusf_rg33_m2_d"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultTransport, "rhs_faction_usarmy_d", ["rhsusf_M1078A1P2_B_d_fmtv_usarmy","rhsusf_M1078A1P2_d_fmtv_usarmy","rhsusf_M1083A1P2_B_d_fmtv_usarmy","rhsusf_M1083A1P2_d_fmtv_usarmy","rhsusf_m998_d_2dr","rhsusf_m998_d_2dr_halftop","rhsusf_m998_d_2dr_fulltop","rhsusf_m998_d_4dr","rhsusf_m998_d_4dr_halftop","rhsusf_m998_d_4dr_fulltop","rhsusf_m1025_d","rhsusf_m1025_d_m2","rhsusf_m1025_d_Mk19"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultAirTransport, "rhs_faction_usarmy_d", ["RHS_CH_47F_light","RHS_UH60M_d","RHS_UH60M_MEV_d","RHS_UH60M_MEV2_d"]] call ALIVE_fnc_hashSet;

/*
// rhs_vehclass_truck
[ALIVE_factionDefaultSupports, "rhs_faction_usarmy_d", ["rhsusf_M1078A1P2_B_d_fmtv_usarmy","rhsusf_M1078A1P2_d_fmtv_usarmy","rhsusf_M1083A1P2_B_d_fmtv_usarmy","rhsusf_M1083A1P2_d_fmtv_usarmy"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultSupplies, "rhs_faction_usarmy_d", ["rhsusf_M1078A1P2_B_d_fmtv_usarmy","rhsusf_M1078A1P2_d_fmtv_usarmy","rhsusf_M1083A1P2_B_d_fmtv_usarmy","rhsusf_M1083A1P2_d_fmtv_usarmy"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultTransport, "rhs_faction_usarmy_d", ["rhsusf_M1078A1P2_B_d_fmtv_usarmy","rhsusf_M1078A1P2_d_fmtv_usarmy","rhsusf_M1083A1P2_B_d_fmtv_usarmy","rhsusf_M1083A1P2_d_fmtv_usarmy"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultAirTransport, "rhs_faction_usarmy_d", ["rhsusf_M1078A1P2_B_d_fmtv_usarmy","rhsusf_M1078A1P2_d_fmtv_usarmy","rhsusf_M1083A1P2_B_d_fmtv_usarmy","rhsusf_M1083A1P2_d_fmtv_usarmy"]] call ALIVE_fnc_hashSet;

// rhs_vehclass_MRAP
[ALIVE_factionDefaultSupports, "rhs_faction_usarmy_d", ["rhsusf_rg33_d","rhsusf_rg33_m2_d"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultSupplies, "rhs_faction_usarmy_d", ["rhsusf_rg33_d","rhsusf_rg33_m2_d"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultTransport, "rhs_faction_usarmy_d", ["rhsusf_rg33_d","rhsusf_rg33_m2_d"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultAirTransport, "rhs_faction_usarmy_d", ["rhsusf_rg33_d","rhsusf_rg33_m2_d"]] call ALIVE_fnc_hashSet;

// Static
[ALIVE_factionDefaultSupports, "rhs_faction_usarmy_d", ["RHS_Stinger_AA_pod_D","RHS_M2StaticMG_D","RHS_M2StaticMG_MiniTripod_D","RHS_TOW_TriPod_D","RHS_MK19_TriPod_D"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultSupplies, "rhs_faction_usarmy_d", ["RHS_Stinger_AA_pod_D","RHS_M2StaticMG_D","RHS_M2StaticMG_MiniTripod_D","RHS_TOW_TriPod_D","RHS_MK19_TriPod_D"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultTransport, "rhs_faction_usarmy_d", ["RHS_Stinger_AA_pod_D","RHS_M2StaticMG_D","RHS_M2StaticMG_MiniTripod_D","RHS_TOW_TriPod_D","RHS_MK19_TriPod_D"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultAirTransport, "rhs_faction_usarmy_d", ["RHS_Stinger_AA_pod_D","RHS_M2StaticMG_D","RHS_M2StaticMG_MiniTripod_D","RHS_TOW_TriPod_D","RHS_MK19_TriPod_D"]] call ALIVE_fnc_hashSet;

// rhs_vehclass_car
[ALIVE_factionDefaultSupports, "rhs_faction_usarmy_d", ["rhsusf_m998_d_2dr","rhsusf_m998_d_2dr_halftop","rhsusf_m998_d_2dr_fulltop","rhsusf_m998_d_4dr","rhsusf_m998_d_4dr_halftop","rhsusf_m998_d_4dr_fulltop","rhsusf_m1025_d","rhsusf_m1025_d_m2","rhsusf_m1025_d_Mk19"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultSupplies, "rhs_faction_usarmy_d", ["rhsusf_m998_d_2dr","rhsusf_m998_d_2dr_halftop","rhsusf_m998_d_2dr_fulltop","rhsusf_m998_d_4dr","rhsusf_m998_d_4dr_halftop","rhsusf_m998_d_4dr_fulltop","rhsusf_m1025_d","rhsusf_m1025_d_m2","rhsusf_m1025_d_Mk19"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultTransport, "rhs_faction_usarmy_d", ["rhsusf_m998_d_2dr","rhsusf_m998_d_2dr_halftop","rhsusf_m998_d_2dr_fulltop","rhsusf_m998_d_4dr","rhsusf_m998_d_4dr_halftop","rhsusf_m998_d_4dr_fulltop","rhsusf_m1025_d","rhsusf_m1025_d_m2","rhsusf_m1025_d_Mk19"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultAirTransport, "rhs_faction_usarmy_d", ["rhsusf_m998_d_2dr","rhsusf_m998_d_2dr_halftop","rhsusf_m998_d_2dr_fulltop","rhsusf_m998_d_4dr","rhsusf_m998_d_4dr_halftop","rhsusf_m998_d_4dr_fulltop","rhsusf_m1025_d","rhsusf_m1025_d_m2","rhsusf_m1025_d_Mk19"]] call ALIVE_fnc_hashSet;

// rhs_vehclass_artillery
[ALIVE_factionDefaultSupports, "rhs_faction_usarmy_d", ["rhsusf_m109d_usarmy","RHS_M119_D","RHS_M252_D"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultSupplies, "rhs_faction_usarmy_d", ["rhsusf_m109d_usarmy","RHS_M119_D","RHS_M252_D"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultTransport, "rhs_faction_usarmy_d", ["rhsusf_m109d_usarmy","RHS_M119_D","RHS_M252_D"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultAirTransport, "rhs_faction_usarmy_d", ["rhsusf_m109d_usarmy","RHS_M119_D","RHS_M252_D"]] call ALIVE_fnc_hashSet;

// rhs_vehclass_apc
[ALIVE_factionDefaultSupports, "rhs_faction_usarmy_d", ["rhsusf_m113d_usarmy"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultSupplies, "rhs_faction_usarmy_d", ["rhsusf_m113d_usarmy"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultTransport, "rhs_faction_usarmy_d", ["rhsusf_m113d_usarmy"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultAirTransport, "rhs_faction_usarmy_d", ["rhsusf_m113d_usarmy"]] call ALIVE_fnc_hashSet;

// rhs_vehclass_tank
[ALIVE_factionDefaultSupports, "rhs_faction_usarmy_d", ["rhsusf_m1a1aimd_usarmy","rhsusf_m1a1aim_tuski_d","rhsusf_m1a2sep1d_usarmy","rhsusf_m1a2sep1tuskid_usarmy","rhsusf_m1a2sep1tuskiid_usarmy"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultSupplies, "rhs_faction_usarmy_d", ["rhsusf_m1a1aimd_usarmy","rhsusf_m1a1aim_tuski_d","rhsusf_m1a2sep1d_usarmy","rhsusf_m1a2sep1tuskid_usarmy","rhsusf_m1a2sep1tuskiid_usarmy"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultTransport, "rhs_faction_usarmy_d", ["rhsusf_m1a1aimd_usarmy","rhsusf_m1a1aim_tuski_d","rhsusf_m1a2sep1d_usarmy","rhsusf_m1a2sep1tuskid_usarmy","rhsusf_m1a2sep1tuskiid_usarmy"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultAirTransport, "rhs_faction_usarmy_d", ["rhsusf_m1a1aimd_usarmy","rhsusf_m1a1aim_tuski_d","rhsusf_m1a2sep1d_usarmy","rhsusf_m1a2sep1tuskid_usarmy","rhsusf_m1a2sep1tuskiid_usarmy"]] call ALIVE_fnc_hashSet;

// rhs_vehclass_helicopter
[ALIVE_factionDefaultSupports, "rhs_faction_usarmy_d", ["RHS_AH64D","RHS_AH64D_GS","RHS_AH64D_CS","RHS_AH64DGrey","RHS_CH_47F_light","RHS_UH60M_d","RHS_UH60M_MEV_d","RHS_UH60M_MEV2_d"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultSupplies, "rhs_faction_usarmy_d", ["RHS_AH64D","RHS_AH64D_GS","RHS_AH64D_CS","RHS_AH64DGrey","RHS_CH_47F_light","RHS_UH60M_d","RHS_UH60M_MEV_d","RHS_UH60M_MEV2_d"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultTransport, "rhs_faction_usarmy_d", ["RHS_AH64D","RHS_AH64D_GS","RHS_AH64D_CS","RHS_AH64DGrey","RHS_CH_47F_light","RHS_UH60M_d","RHS_UH60M_MEV_d","RHS_UH60M_MEV2_d"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultAirTransport, "rhs_faction_usarmy_d", ["RHS_AH64D","RHS_AH64D_GS","RHS_AH64D_CS","RHS_AH64DGrey","RHS_CH_47F_light","RHS_UH60M_d","RHS_UH60M_MEV_d","RHS_UH60M_MEV2_d"]] call ALIVE_fnc_hashSet;

// rhs_vehclass_ifv
[ALIVE_factionDefaultSupports, "rhs_faction_usarmy_d", ["RHS_M2A2","RHS_M2A2_BUSKI","RHS_M2A3","RHS_M2A3_BUSKI","RHS_M2A3_BUSKIII"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultSupplies, "rhs_faction_usarmy_d", ["RHS_M2A2","RHS_M2A2_BUSKI","RHS_M2A3","RHS_M2A3_BUSKI","RHS_M2A3_BUSKIII"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultTransport, "rhs_faction_usarmy_d", ["RHS_M2A2","RHS_M2A2_BUSKI","RHS_M2A3","RHS_M2A3_BUSKI","RHS_M2A3_BUSKIII"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultAirTransport, "rhs_faction_usarmy_d", ["RHS_M2A2","RHS_M2A2_BUSKI","RHS_M2A3","RHS_M2A3_BUSKI","RHS_M2A3_BUSKIII"]] call ALIVE_fnc_hashSet;

// rhs_vehclass_aa
[ALIVE_factionDefaultSupports, "rhs_faction_usarmy_d", ["RHS_M6"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultSupplies, "rhs_faction_usarmy_d", ["RHS_M6"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultTransport, "rhs_faction_usarmy_d", ["RHS_M6"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultAirTransport, "rhs_faction_usarmy_d", ["RHS_M6"]] call ALIVE_fnc_hashSet;
*/


// rhs_faction_usmc_wd

rhs_faction_usmc_wd_mappings = [] call ALIVE_fnc_hashCreate;

rhs_faction_usmc_wd_factionCustomGroups = [] call ALIVE_fnc_hashCreate;

[rhs_faction_usmc_wd_mappings, "Side", "WEST"] call ALIVE_fnc_hashSet;
[rhs_faction_usmc_wd_mappings, "GroupSideName", "WEST"] call ALIVE_fnc_hashSet;
[rhs_faction_usmc_wd_mappings, "FactionName", "rhs_faction_usmc_wd"] call ALIVE_fnc_hashSet;
[rhs_faction_usmc_wd_mappings, "GroupFactionName", "rhs_faction_usmc_wd"] call ALIVE_fnc_hashSet;

rhs_faction_usmc_wd_typeMappings = [] call ALIVE_fnc_hashCreate;

[rhs_faction_usmc_wd_mappings, "GroupFactionTypes", rhs_faction_usmc_wd_typeMappings] call ALIVE_fnc_hashSet;

[rhs_faction_usmc_wd_factionCustomGroups, "Infantry", ["rhs_group_nato_usmc_wd_infantry_squad","rhs_group_nato_usmc_wd_infantry_weaponsquad","rhs_group_nato_usmc_wd_infantry_squad_sniper","rhs_group_nato_usmc_wd_infantry_team","rhs_group_nato_usmc_wd_infantry_team_MG","rhs_group_nato_usmc_wd_infantry_team_AA","rhs_group_nato_usmc_wd_infantry_team_support","rhs_group_nato_usmc_wd_infantry_team_heavy_AT"]] call ALIVE_fnc_hashSet;
[rhs_faction_usmc_wd_factionCustomGroups, "Motorized", ["rhs_group_nato_usmc_wd_RG33_squad","rhs_group_nato_usmc_wd_RG33_squad_2mg","rhs_group_nato_usmc_wd_RG33_squad_sniper","rhs_group_nato_usmc_wd_RG33_squad_mg_sniper","rhs_group_nato_usmc_wd_RG33_m2_squad","rhs_group_nato_usmc_wd_RG33_m2_squad_2mg","rhs_group_nato_usmc_wd_RG33_m2_squad_sniper","rhs_group_nato_usmc_wd_RG33_m2_squad_mg_sniper","BUS_MotInf_Team_GMG","BUS_MotInf_Team_HMG","BUS_MotInf_AT","BUS_MotInf_AA"]] call ALIVE_fnc_hashSet;
[rhs_faction_usmc_wd_factionCustomGroups, "Armored", ["RHS_M1A1AIM_wd_Platoon","RHS_M1A1FEP_wd_Section"]] call ALIVE_fnc_hashSet;

[rhs_faction_usmc_wd_mappings, "Groups", rhs_faction_usmc_wd_factionCustomGroups] call ALIVE_fnc_hashSet;

[ALIVE_factionCustomMappings, "rhs_faction_usmc_wd", rhs_faction_usmc_wd_mappings] call ALIVE_fnc_hashSet;

[ALIVE_factionDefaultSupports, "rhs_faction_usmc_wd", ["rhsusf_rg33_usmc_wd","rhsusf_rg33_m2_usmc_wd","rhsusf_m998_w_s_2dr","rhsusf_m998_w_s_2dr_halftop","rhsusf_m998_w_s_2dr_fulltop","rhsusf_m998_w_s_4dr","rhsusf_m998_w_s_4dr_halftop","rhsusf_m998_w_s_4dr_fulltop","rhsusf_m1025_w_s","rhsusf_m1025_w_s_m2","rhsusf_m1025_w_s_Mk19","rhsusf_rg33_wd","rhsusf_rg33_m2_wd","rhsusf_m998_w_2dr","rhsusf_m998_w_2dr_halftop","rhsusf_m998_w_2dr_fulltop","rhsusf_m998_w_4dr","rhsusf_m998_w_4dr_halftop","rhsusf_m998_w_4dr_fulltop","rhsusf_m1025_w","rhsusf_m1025_w_m2","rhsusf_m1025_w_mk19","rhsusf_m109_usarmy","RHS_M6_wd"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultTransport, "rhs_faction_usmc_wd", ["rhsusf_M1078A1P2_B_wd_fmtv_usarmy","rhsusf_M1078A1P2_wd_fmtv_usarmy","rhsusf_M1083A1P2_B_wd_fmtv_usarmy","rhsusf_M1083A1P2_wd_fmtv_usarmy","rhsusf_M977A2_usarmy_wd","rhsusf_M977A2_CPK_usarmy_wd","rhsusf_m998_w_s_2dr","rhsusf_m998_w_s_2dr_halftop","rhsusf_m998_w_s_2dr_fulltop","rhsusf_m998_w_s_4dr","rhsusf_m998_w_s_4dr_halftop","rhsusf_m998_w_s_4dr_fulltop","rhsusf_m1025_w_s","rhsusf_m1025_w_s_m2","rhsusf_m1025_w_s_Mk19"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultAirTransport, "rhs_faction_usmc_wd", ["RHS_CH_47F","rhsusf_CH53E_USMC","RHS_UH60M","RHS_UH60M_MEV","RHS_UH60M_MEV2"]] call ALIVE_fnc_hashSet;

/*
// rhs_vehclass_MRAP
[ALIVE_factionDefaultSupports, "rhs_faction_usmc_wd", ["rhsusf_rg33_usmc_wd","rhsusf_rg33_m2_usmc_wd"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultSupplies, "rhs_faction_usmc_wd", ["rhsusf_rg33_usmc_wd","rhsusf_rg33_m2_usmc_wd"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultTransport, "rhs_faction_usmc_wd", ["rhsusf_rg33_usmc_wd","rhsusf_rg33_m2_usmc_wd"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultAirTransport, "rhs_faction_usmc_wd", ["rhsusf_rg33_usmc_wd","rhsusf_rg33_m2_usmc_wd"]] call ALIVE_fnc_hashSet;

// rhs_vehclass_car
[ALIVE_factionDefaultSupports, "rhs_faction_usmc_wd", ["rhsusf_m998_w_s_2dr","rhsusf_m998_w_s_2dr_halftop","rhsusf_m998_w_s_2dr_fulltop","rhsusf_m998_w_s_4dr","rhsusf_m998_w_s_4dr_halftop","rhsusf_m998_w_s_4dr_fulltop","rhsusf_m1025_w_s","rhsusf_m1025_w_s_m2","rhsusf_m1025_w_s_Mk19"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultSupplies, "rhs_faction_usmc_wd", ["rhsusf_m998_w_s_2dr","rhsusf_m998_w_s_2dr_halftop","rhsusf_m998_w_s_2dr_fulltop","rhsusf_m998_w_s_4dr","rhsusf_m998_w_s_4dr_halftop","rhsusf_m998_w_s_4dr_fulltop","rhsusf_m1025_w_s","rhsusf_m1025_w_s_m2","rhsusf_m1025_w_s_Mk19"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultTransport, "rhs_faction_usmc_wd", ["rhsusf_m998_w_s_2dr","rhsusf_m998_w_s_2dr_halftop","rhsusf_m998_w_s_2dr_fulltop","rhsusf_m998_w_s_4dr","rhsusf_m998_w_s_4dr_halftop","rhsusf_m998_w_s_4dr_fulltop","rhsusf_m1025_w_s","rhsusf_m1025_w_s_m2","rhsusf_m1025_w_s_Mk19"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultAirTransport, "rhs_faction_usmc_wd", ["rhsusf_m998_w_s_2dr","rhsusf_m998_w_s_2dr_halftop","rhsusf_m998_w_s_2dr_fulltop","rhsusf_m998_w_s_4dr","rhsusf_m998_w_s_4dr_halftop","rhsusf_m998_w_s_4dr_fulltop","rhsusf_m1025_w_s","rhsusf_m1025_w_s_m2","rhsusf_m1025_w_s_Mk19"]] call ALIVE_fnc_hashSet;

// rhs_vehclass_tank
[ALIVE_factionDefaultSupports, "rhs_faction_usmc_wd", ["rhsusf_m1a1fep_wd","rhsusf_m1a1fep_od"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultSupplies, "rhs_faction_usmc_wd", ["rhsusf_m1a1fep_wd","rhsusf_m1a1fep_od"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultTransport, "rhs_faction_usmc_wd", ["rhsusf_m1a1fep_wd","rhsusf_m1a1fep_od"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultAirTransport, "rhs_faction_usmc_wd", ["rhsusf_m1a1fep_wd","rhsusf_m1a1fep_od"]] call ALIVE_fnc_hashSet;
*/


// rhs_faction_usmc_d

rhs_faction_usmc_d_mappings = [] call ALIVE_fnc_hashCreate;

rhs_faction_usmc_d_factionCustomGroups = [] call ALIVE_fnc_hashCreate;

[rhs_faction_usmc_d_mappings, "Side", "WEST"] call ALIVE_fnc_hashSet;
[rhs_faction_usmc_d_mappings, "GroupSideName", "WEST"] call ALIVE_fnc_hashSet;
[rhs_faction_usmc_d_mappings, "FactionName", "rhs_faction_usmc_d"] call ALIVE_fnc_hashSet;
[rhs_faction_usmc_d_mappings, "GroupFactionName", "rhs_faction_usmc_d"] call ALIVE_fnc_hashSet;

rhs_faction_usmc_d_typeMappings = [] call ALIVE_fnc_hashCreate;

[rhs_faction_usmc_d_mappings, "GroupFactionTypes", rhs_faction_usmc_d_typeMappings] call ALIVE_fnc_hashSet;

[rhs_faction_usmc_d_factionCustomGroups, "Infantry", ["rhs_group_nato_usmc_d_infantry_squad","rhs_group_nato_usmc_d_infantry_weaponsquad","rhs_group_nato_usmc_d_infantry_squad_sniper","rhs_group_nato_usmc_d_infantry_team","rhs_group_nato_usmc_d_infantry_team_MG","rhs_group_nato_usmc_d_infantry_team_AA","rhs_group_nato_usmc_d_infantry_team_support","rhs_group_nato_usmc_d_infantry_team_heavy_AT"]] call ALIVE_fnc_hashSet;
[rhs_faction_usmc_d_factionCustomGroups, "Motorized", ["BUS_MotInf_Team_GMG","BUS_MotInf_Team_HMG","BUS_MotInf_AT","BUS_MotInf_AA","rhs_group_nato_usmc_d_RG33_squad","rhs_group_nato_usmc_d_RG33_squad_2mg","rhs_group_nato_usmc_d_RG33_squad_sniper","rhs_group_nato_usmc_d_RG33_squad_mg_sniper","rhs_group_nato_usmc_d_RG33_m2_squad","rhs_group_nato_usmc_d_RG33_m2_squad_2mg","rhs_group_nato_usmc_d_RG33_m2_squad_sniper","rhs_group_nato_usmc_d_RG33_m2_squad_mg_sniper"]] call ALIVE_fnc_hashSet;
[rhs_faction_usmc_d_factionCustomGroups, "Armored", ["RHS_M1A1AIM_d_Platoon","RHS_M1A1FEP_d_Section"]] call ALIVE_fnc_hashSet;

[rhs_faction_usmc_d_mappings, "Groups", rhs_faction_usmc_d_factionCustomGroups] call ALIVE_fnc_hashSet;

[ALIVE_factionCustomMappings, "rhs_faction_usmc_d", rhs_faction_usmc_d_mappings] call ALIVE_fnc_hashSet;

[ALIVE_factionDefaultSupports, "rhs_faction_usmc_d", ["rhsusf_m998_d_s_2dr","rhsusf_m998_d_s_2dr_halftop","rhsusf_m998_d_s_2dr_fulltop","rhsusf_m998_d_s_4dr","rhsusf_m998_d_s_4dr_halftop","rhsusf_m998_d_s_4dr_fulltop","rhsusf_m1025_d_s","rhsusf_m1025_d_s_m2","rhsusf_m1025_d_s_Mk19","rhsusf_rg33_usmc_d","rhsusf_rg33_m2_usmc_d","RHS_M6","rhsusf_m109d_usarmy","rhsusf_m998_d_2dr","rhsusf_m998_d_2dr_halftop","rhsusf_m998_d_2dr_fulltop","rhsusf_m998_d_4dr","rhsusf_m998_d_4dr_halftop","rhsusf_m998_d_4dr_fulltop","rhsusf_m1025_d","rhsusf_m1025_d_m2","rhsusf_m1025_d_Mk19","rhsusf_rg33_d","rhsusf_rg33_m2_d"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultTransport, "rhs_faction_usmc_d", ["rhsusf_M1078A1P2_B_d_fmtv_usarmy","rhsusf_M1078A1P2_d_fmtv_usarmy","rhsusf_M1083A1P2_B_d_fmtv_usarmy","rhsusf_M1083A1P2_d_fmtv_usarmy","rhsusf_m998_d_s_2dr","rhsusf_m998_d_s_2dr_halftop","rhsusf_m998_d_s_2dr_fulltop","rhsusf_m998_d_s_4dr","rhsusf_m998_d_s_4dr_halftop","rhsusf_m998_d_s_4dr_fulltop","rhsusf_m1025_d_s","rhsusf_m1025_d_s_m2","rhsusf_m1025_d_s_Mk19"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultAirTransport, "rhs_faction_usmc_d", ["RHS_CH_47F_light","rhsusf_CH53E_USMC_D","RHS_UH60M_d","RHS_UH60M_MEV_d","RHS_UH60M_MEV2_d"]] call ALIVE_fnc_hashSet;

/*
// rhs_vehclass_MRAP
[ALIVE_factionDefaultSupports, "rhs_faction_usmc_d", ["rhsusf_rg33_usmc_d","rhsusf_rg33_m2_usmc_d"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultSupplies, "rhs_faction_usmc_d", ["rhsusf_rg33_usmc_d","rhsusf_rg33_m2_usmc_d"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultTransport, "rhs_faction_usmc_d", ["rhsusf_rg33_usmc_d","rhsusf_rg33_m2_usmc_d"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultAirTransport, "rhs_faction_usmc_d", ["rhsusf_rg33_usmc_d","rhsusf_rg33_m2_usmc_d"]] call ALIVE_fnc_hashSet;

// rhs_vehclass_car
[ALIVE_factionDefaultSupports, "rhs_faction_usmc_d", ["rhsusf_m998_d_s_2dr","rhsusf_m998_d_s_2dr_halftop","rhsusf_m998_d_s_2dr_fulltop","rhsusf_m998_d_s_4dr","rhsusf_m998_d_s_4dr_halftop","rhsusf_m998_d_s_4dr_fulltop","rhsusf_m1025_d_s","rhsusf_m1025_d_s_m2","rhsusf_m1025_d_s_Mk19"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultSupplies, "rhs_faction_usmc_d", ["rhsusf_m998_d_s_2dr","rhsusf_m998_d_s_2dr_halftop","rhsusf_m998_d_s_2dr_fulltop","rhsusf_m998_d_s_4dr","rhsusf_m998_d_s_4dr_halftop","rhsusf_m998_d_s_4dr_fulltop","rhsusf_m1025_d_s","rhsusf_m1025_d_s_m2","rhsusf_m1025_d_s_Mk19"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultTransport, "rhs_faction_usmc_d", ["rhsusf_m998_d_s_2dr","rhsusf_m998_d_s_2dr_halftop","rhsusf_m998_d_s_2dr_fulltop","rhsusf_m998_d_s_4dr","rhsusf_m998_d_s_4dr_halftop","rhsusf_m998_d_s_4dr_fulltop","rhsusf_m1025_d_s","rhsusf_m1025_d_s_m2","rhsusf_m1025_d_s_Mk19"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultAirTransport, "rhs_faction_usmc_d", ["rhsusf_m998_d_s_2dr","rhsusf_m998_d_s_2dr_halftop","rhsusf_m998_d_s_2dr_fulltop","rhsusf_m998_d_s_4dr","rhsusf_m998_d_s_4dr_halftop","rhsusf_m998_d_s_4dr_fulltop","rhsusf_m1025_d_s","rhsusf_m1025_d_s_m2","rhsusf_m1025_d_s_Mk19"]] call ALIVE_fnc_hashSet;

// rhs_vehclass_tank
[ALIVE_factionDefaultSupports, "rhs_faction_usmc_d", ["rhsusf_m1a1fep_d"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultSupplies, "rhs_faction_usmc_d", ["rhsusf_m1a1fep_d"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultTransport, "rhs_faction_usmc_d", ["rhsusf_m1a1fep_d"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultAirTransport, "rhs_faction_usmc_d", ["rhsusf_m1a1fep_d"]] call ALIVE_fnc_hashSet;
*/


/*
// rhs_faction_usaf

rhs_faction_usaf_mappings = [] call ALIVE_fnc_hashCreate;

rhs_faction_usaf_factionCustomGroups = [] call ALIVE_fnc_hashCreate;

[rhs_faction_usaf_mappings, "Side", "WEST"] call ALIVE_fnc_hashSet;
[rhs_faction_usaf_mappings, "GroupSideName", "WEST"] call ALIVE_fnc_hashSet;
[rhs_faction_usaf_mappings, "FactionName", "rhs_faction_usaf"] call ALIVE_fnc_hashSet;
[rhs_faction_usaf_mappings, "GroupFactionName", "rhs_faction_usaf"] call ALIVE_fnc_hashSet;

rhs_faction_usaf_typeMappings = [] call ALIVE_fnc_hashCreate;

[rhs_faction_usaf_mappings, "GroupFactionTypes", rhs_faction_usaf_typeMappings] call ALIVE_fnc_hashSet;

rhs_faction_usaf_typeMappings, "Air", "Air"] call ALIVE_fnc_hashSet;
rhs_faction_usaf_typeMappings, "Armored", "Armored"] call ALIVE_fnc_hashSet;
rhs_faction_usaf_typeMappings, "Infantry", "Infantry"] call ALIVE_fnc_hashSet;
rhs_faction_usaf_typeMappings, "Mechanized", "Mechanized"] call ALIVE_fnc_hashSet;
rhs_faction_usaf_typeMappings, "Motorized", "Motorized"] call ALIVE_fnc_hashSet;
rhs_faction_usaf_typeMappings, "Motorized_MTP", "Motorized_MTP"] call ALIVE_fnc_hashSet;
rhs_faction_usaf_typeMappings, "SpecOps", "SpecOps"] call ALIVE_fnc_hashSet;
rhs_faction_usaf_typeMappings, "Support", "Support"] call ALIVE_fnc_hashSet;

[rhs_faction_usaf_mappings, "Groups", rhs_faction_usaf_factionCustomGroups] call ALIVE_fnc_hashSet;

[ALIVE_factionCustomMappings, "rhs_faction_usaf", rhs_faction_usaf_mappings] call ALIVE_fnc_hashSet;

// rhs_vehclass_aircraft
[ALIVE_factionDefaultSupports, "rhs_faction_usaf", ["RHS_C130J","RHS_A10","rhsusf_f22"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultSupplies, "rhs_faction_usaf", ["RHS_C130J","RHS_A10","rhsusf_f22"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultTransport, "rhs_faction_usaf", ["RHS_C130J","RHS_A10","rhsusf_f22"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultAirTransport, "rhs_faction_usaf", ["RHS_C130J","RHS_A10","rhsusf_f22"]] call ALIVE_fnc_hashSet;



// rhs_faction_usn

rhs_faction_usn_mappings = [] call ALIVE_fnc_hashCreate;

rhs_faction_usn_factionCustomGroups = [] call ALIVE_fnc_hashCreate;

[rhs_faction_usn_mappings, "Side", "WEST"] call ALIVE_fnc_hashSet;
[rhs_faction_usn_mappings, "GroupSideName", "WEST"] call ALIVE_fnc_hashSet;
[rhs_faction_usn_mappings, "FactionName", "rhs_faction_usn"] call ALIVE_fnc_hashSet;
[rhs_faction_usn_mappings, "GroupFactionName", "rhs_faction_usn"] call ALIVE_fnc_hashSet;

rhs_faction_usn_typeMappings = [] call ALIVE_fnc_hashCreate;

[rhs_faction_usn_mappings, "GroupFactionTypes", rhs_faction_usn_typeMappings] call ALIVE_fnc_hashSet;

rhs_faction_usn_typeMappings, "Air", "Air"] call ALIVE_fnc_hashSet;
rhs_faction_usn_typeMappings, "Armored", "Armored"] call ALIVE_fnc_hashSet;
rhs_faction_usn_typeMappings, "Infantry", "Infantry"] call ALIVE_fnc_hashSet;
rhs_faction_usn_typeMappings, "Mechanized", "Mechanized"] call ALIVE_fnc_hashSet;
rhs_faction_usn_typeMappings, "Motorized", "Motorized"] call ALIVE_fnc_hashSet;
rhs_faction_usn_typeMappings, "Motorized_MTP", "Motorized_MTP"] call ALIVE_fnc_hashSet;
rhs_faction_usn_typeMappings, "SpecOps", "SpecOps"] call ALIVE_fnc_hashSet;
rhs_faction_usn_typeMappings, "Support", "Support"] call ALIVE_fnc_hashSet;

[rhs_faction_usn_mappings, "Groups", rhs_faction_usn_factionCustomGroups] call ALIVE_fnc_hashSet;

[ALIVE_factionCustomMappings, "rhs_faction_usn", rhs_faction_usn_mappings] call ALIVE_fnc_hashSet;



// rhs_faction_socom

rhs_faction_socom_mappings = [] call ALIVE_fnc_hashCreate;

rhs_faction_socom_factionCustomGroups = [] call ALIVE_fnc_hashCreate;

[rhs_faction_socom_mappings, "Side", "WEST"] call ALIVE_fnc_hashSet;
[rhs_faction_socom_mappings, "GroupSideName", "WEST"] call ALIVE_fnc_hashSet;
[rhs_faction_socom_mappings, "FactionName", "rhs_faction_socom"] call ALIVE_fnc_hashSet;
[rhs_faction_socom_mappings, "GroupFactionName", "rhs_faction_socom"] call ALIVE_fnc_hashSet;

rhs_faction_socom_typeMappings = [] call ALIVE_fnc_hashCreate;

[rhs_faction_socom_mappings, "GroupFactionTypes", rhs_faction_socom_typeMappings] call ALIVE_fnc_hashSet;

rhs_faction_socom_typeMappings, "Air", "Air"] call ALIVE_fnc_hashSet;
rhs_faction_socom_typeMappings, "Armored", "Armored"] call ALIVE_fnc_hashSet;
rhs_faction_socom_typeMappings, "Infantry", "Infantry"] call ALIVE_fnc_hashSet;
rhs_faction_socom_typeMappings, "Mechanized", "Mechanized"] call ALIVE_fnc_hashSet;
rhs_faction_socom_typeMappings, "Motorized", "Motorized"] call ALIVE_fnc_hashSet;
rhs_faction_socom_typeMappings, "Motorized_MTP", "Motorized_MTP"] call ALIVE_fnc_hashSet;
rhs_faction_socom_typeMappings, "SpecOps", "SpecOps"] call ALIVE_fnc_hashSet;
rhs_faction_socom_typeMappings, "Support", "Support"] call ALIVE_fnc_hashSet;

[rhs_faction_socom_mappings, "Groups", rhs_faction_socom_factionCustomGroups] call ALIVE_fnc_hashSet;

[ALIVE_factionCustomMappings, "rhs_faction_socom", rhs_faction_socom_mappings] call ALIVE_fnc_hashSet;
*/

// ------------------------------------------------------------------------------------------------------



// RHS AFRF ----------------------------------------------------------------------------------------------------------------

// rhs_faction_msv

rhs_faction_msv_mappings = [] call ALIVE_fnc_hashCreate;

rhs_faction_msv_factionCustomGroups = [] call ALIVE_fnc_hashCreate;

[rhs_faction_msv_mappings, "Side", "EAST"] call ALIVE_fnc_hashSet;
[rhs_faction_msv_mappings, "GroupSideName", "EAST"] call ALIVE_fnc_hashSet;
[rhs_faction_msv_mappings, "FactionName", "rhs_faction_msv"] call ALIVE_fnc_hashSet;
[rhs_faction_msv_mappings, "GroupFactionName", "rhs_faction_msv"] call ALIVE_fnc_hashSet;

rhs_faction_msv_typeMappings = [] call ALIVE_fnc_hashCreate;

[rhs_faction_msv_mappings, "GroupFactionTypes", rhs_faction_msv_typeMappings] call ALIVE_fnc_hashSet;

[rhs_faction_msv_factionCustomGroups, "Infantry", ["rhs_group_rus_msv_infantry_emr_chq","rhs_group_rus_msv_infantry_emr_squad","rhs_group_rus_msv_infantry_emr_squad_2mg","rhs_group_rus_msv_infantry_emr_squad_sniper","rhs_group_rus_msv_infantry_emr_squad_mg_sniper","rhs_group_rus_msv_infantry_emr_section_mg","rhs_group_rus_msv_infantry_emr_section_marksman","rhs_group_rus_msv_infantry_emr_section_AT","rhs_group_rus_msv_infantry_emr_section_AA","rhs_group_rus_msv_infantry_emr_fireteam","rhs_group_rus_msv_infantry_emr_MANEUVER","rhs_group_rus_msv_infantry_chq","rhs_group_rus_msv_infantry_squad","rhs_group_rus_msv_infantry_squad_2mg","rhs_group_rus_msv_infantry_squad_sniper","rhs_group_rus_msv_infantry_squad_mg_sniper","rhs_group_rus_msv_infantry_section_mg","rhs_group_rus_msv_infantry_section_marksman","rhs_group_rus_msv_infantry_section_AT","rhs_group_rus_msv_infantry_section_AA","rhs_group_rus_msv_infantry_fireteam","rhs_group_rus_msv_infantry_MANEUVER"]] call ALIVE_fnc_hashSet;
[rhs_faction_msv_factionCustomGroups, "Motorized", ["rhs_group_rus_msv_gaz66_chq","rhs_group_rus_msv_gaz66_squad","rhs_group_rus_msv_gaz66_squad_2mg","rhs_group_rus_msv_gaz66_squad_sniper","rhs_group_rus_msv_gaz66_squad_mg_sniper","rhs_group_rus_msv_gaz66_squad_aa","rhs_group_rus_msv_Ural_chq","rhs_group_rus_msv_Ural_squad","rhs_group_rus_msv_Ural_squad_2mg","rhs_group_rus_msv_Ural_squad_sniper","rhs_group_rus_msv_Ural_squad_mg_sniper","rhs_group_rus_msv_Ural_squad_aa"]] call ALIVE_fnc_hashSet;
[rhs_faction_msv_factionCustomGroups, "Mechanized", ["rhs_group_rus_MSV_BMP3_chq","rhs_group_rus_MSV_BMP3_squad","rhs_group_rus_MSV_BMP3_squad_2mg","rhs_group_rus_MSV_BMP3_squad_sniper","rhs_group_rus_MSV_BMP3_squad_mg_sniper","rhs_group_rus_MSV_BMP3_squad_aa","rhs_group_rus_msv_bmp2_chq","rhs_group_rus_msv_bmp2_squad","rhs_group_rus_msv_bmp2_squad_2mg","rhs_group_rus_msv_bmp2_squad_sniper","rhs_group_rus_msv_bmp2_squad_mg_sniper","rhs_group_rus_msv_bmp2_squad_aa","rhs_group_rus_msv_bmp1_chq","rhs_group_rus_msv_bmp1_squad","rhs_group_rus_msv_bmp1_squad_2mg","rhs_group_rus_msv_bmp1_squad_sniper","rhs_group_rus_msv_bmp1_squad_mg_sniper","rhs_group_rus_msv_bmp1_squad_aa","rhs_group_rus_msv_BTR80a_chq","rhs_group_rus_msv_BTR80a_squad","rhs_group_rus_msv_BTR80a_squad_2mg","rhs_group_rus_msv_BTR80a_squad_sniper","rhs_group_rus_msv_BTR80a_squad_mg_sniper","rhs_group_rus_msv_BTR80a_squad_aa","rhs_group_rus_msv_BTR80_chq","rhs_group_rus_msv_BTR80_squad","rhs_group_rus_msv_BTR80_squad_2mg","rhs_group_rus_msv_BTR80_squad_sniper","rhs_group_rus_msv_BTR80_squad_mg_sniper","rhs_group_rus_msv_BTR80_squad_aa","rhs_group_rus_msv_btr70_chq","rhs_group_rus_msv_btr70_squad","rhs_group_rus_msv_btr70_squad_2mg","rhs_group_rus_msv_btr70_squad_sniper","rhs_group_rus_msv_btr70_squad_mg_sniper","rhs_group_rus_msv_btr70_squad_aa"]] call ALIVE_fnc_hashSet;
[rhs_faction_msv_factionCustomGroups, "Artillery", ["RHS_SPGPlatoon_msv_bm21","RHS_SPGSection_msv_bm21"]] call ALIVE_fnc_hashSet;
[rhs_faction_msv_factionCustomGroups, "Armored", ["RHS_T80Platoon","RHS_T80Platoon_AA","RHS_T80Section","RHS_T80BPlatoon","RHS_T80BPlatoon_AA","RHS_T80BSection","RHS_T80BVPlatoon","RHS_T80BVPlatoon_AA","RHS_T80BVSection","RHS_T80APlatoon","RHS_T80APlatoon_AA","RHS_T80ASection","RHS_T80UPlatoon","RHS_T80UPlatoon_AA","RHS_T80USection","RHS_T72BAPlatoon","RHS_T72BAPlatoon_AA","RHS_T72BASection","RHS_T72BBPlatoon","RHS_T72BBPlatoon_AA","RHS_T72BBSection","RHS_T72BCPlatoon","RHS_T72BCPlatoon_AA","RHS_T72BCSection","RHS_T72BDPlatoon","RHS_T72BDPlatoon_AA","RHS_T72BDSection"]] call ALIVE_fnc_hashSet;

[rhs_faction_msv_mappings, "Groups", rhs_faction_msv_factionCustomGroups] call ALIVE_fnc_hashSet;

[ALIVE_factionCustomMappings, "rhs_faction_msv", rhs_faction_msv_mappings] call ALIVE_fnc_hashSet;

[ALIVE_factionDefaultSupports, "rhs_faction_msv", ["rhs_p37","rhs_prv13","rhs_2P3_1","rhs_2P3_2","rhs_v2","rhs_v3","rhs_9k79","rhs_9k79_K","rhs_9k79_B","rhs_2s3_tv","rhs_zsu234_aa","RHS_Ural_VMF_01","RHS_Ural_Open_VMF_01","RHS_Ural_Fuel_VMF_01","RHS_BM21_VMF_01","rhs_gaz66_vmf","rhs_gaz66o_vmf","rhs_gaz66_r142_vmf","rhs_gaz66_repair_vmf","rhs_gaz66_ap2_vmf","rhs_gaz66_ammo_vmf","rhs_tigr_vmf","rhs_tigr_3camo_vmf","rhs_tigr_ffv_vmf","rhs_tigr_ffv_3camo_vmf","rhs_tigr_sts_vmf","rhs_tigr_sts_3camo_vmf","rhs_tigr_m_vmf","rhs_tigr_m_3camo_vmf","rhs_uaz_vmf","rhs_uaz_open_vmf","rhs_tigr_vdv","rhs_tigr_3camo_vdv","rhs_tigr_ffv_vdv","rhs_tigr_ffv_3camo_vdv","rhs_tigr_sts_vdv","rhs_tigr_sts_3camo_vdv","rhs_tigr_m_vdv","rhs_tigr_m_3camo_vdv","rhs_uaz_vdv","rhs_uaz_open_vdv","rhs_tigr_msv","rhs_tigr_3camo_msv","rhs_tigr_ffv_msv","rhs_tigr_ffv_3camo_msv","rhs_tigr_sts_msv","rhs_tigr_sts_3camo_msv","rhs_tigr_m_msv","rhs_tigr_m_3camo_msv","RHS_UAZ_MSV_01","rhs_uaz_open_MSV_01","RHS_Ural_MSV_01","RHS_Ural_Open_MSV_01","RHS_Ural_Fuel_MSV_01","RHS_BM21_MSV_01","rhs_gaz66_msv","rhs_gaz66o_msv","rhs_gaz66_r142_msv","rhs_gaz66_repair_msv","rhs_gaz66_ap2_msv","rhs_gaz66_ammo_msv"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultTransport, "rhs_faction_msv", ["rhs_tigr_msv","rhs_tigr_3camo_msv","rhs_tigr_ffv_msv","rhs_tigr_ffv_3camo_msv","rhs_tigr_sts_msv","rhs_tigr_sts_3camo_msv","rhs_tigr_m_msv","rhs_tigr_m_3camo_msv","RHS_UAZ_MSV_01","rhs_uaz_open_MSV_01","RHS_UAZ_MSV_01","rhs_uaz_open_MSV_01","rhs_uaz_vdv","rhs_uaz_open_vdv","rhs_gaz66_vmf","rhs_gaz66o_vmf"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultAirTransport, "rhs_faction_msv", ["RHS_Mi24P_vvsc","RHS_Mi24P_CAS_vvsc","RHS_Mi24P_AT_vvsc","RHS_Mi24V_vvsc","RHS_Mi24V_FAB_vvsc","RHS_Mi24V_UPK23_vvsc","RHS_Mi24V_AT_vvsc","RHS_Mi8mt_vvsc","RHS_Mi8mt_Cargo_vvsc","RHS_Mi8MTV3_vvsc","RHS_Mi8MTV3_UPK23_vvsc","RHS_Mi8MTV3_FAB_vvsc","RHS_Mi8AMT_vvsc","RHS_Mi8AMTSh_vvsc","RHS_Mi8AMTSh_UPK23_vvsc","RHS_Mi8AMTSh_FAB_vvsc","rhs_ka60_c","RHS_Mi24P_vvs","RHS_Mi24P_CAS_vvs","RHS_Mi24P_AT_vvs","RHS_Mi24V_vvs","RHS_Mi24V_FAB_vvs","RHS_Mi24V_UPK23_vvs","RHS_Mi24V_AT_vvs","RHS_Mi24Vt_vvs","RHS_Mi8mt_vvs","RHS_Mi8mt_Cargo_vvs","RHS_Mi8MTV3_vvs","RHS_Mi8MTV3_UPK23_vvs","RHS_Mi8MTV3_FAB_vvs","RHS_Mi8AMT_vvs","RHS_Mi8AMTSh_vvs","RHS_Mi8AMTSh_UPK23_vvs","RHS_Mi8AMTSh_FAB_vvs","rhs_ka60_grey","RHS_Mi8mt_vv","RHS_Mi8mt_Cargo_vv","RHS_Mi24P_CAS_vdv","RHS_Mi24P_AT_vdv","RHS_Mi24P_vdv","RHS_Mi24V_FAB_vdv","RHS_Mi24V_UPK23_vdv","RHS_Mi24V_AT_vdv","RHS_Mi24V_vdv","RHS_Mi8mt_vdv","RHS_Mi8mt_Cargo_vdv","RHS_Mi8MTV3_vdv","RHS_Mi8MTV3_UPK23_vdv","RHS_Mi8MTV3_FAB_vdv","RHS_Mi8AMT_vdv"]] call ALIVE_fnc_hashSet;

/*
// Static
[ALIVE_factionDefaultSupports, "rhs_faction_msv", ["rhs_Metis_9k115_2_msv","rhs_Igla_AA_pod_msv","RHS_AGS30_TriPod_MSV","rhs_KORD_MSV","rhs_KORD_high_MSV","RHS_NSV_TriPod_MSV"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultSupplies, "rhs_faction_msv", ["rhs_Metis_9k115_2_msv","rhs_Igla_AA_pod_msv","RHS_AGS30_TriPod_MSV","rhs_KORD_MSV","rhs_KORD_high_MSV","RHS_NSV_TriPod_MSV"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultTransport, "rhs_faction_msv", ["rhs_Metis_9k115_2_msv","rhs_Igla_AA_pod_msv","RHS_AGS30_TriPod_MSV","rhs_KORD_MSV","rhs_KORD_high_MSV","RHS_NSV_TriPod_MSV"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultAirTransport, "rhs_faction_msv", ["rhs_Metis_9k115_2_msv","rhs_Igla_AA_pod_msv","RHS_AGS30_TriPod_MSV","rhs_KORD_MSV","rhs_KORD_high_MSV","RHS_NSV_TriPod_MSV"]] call ALIVE_fnc_hashSet;

// rhs_vehclass_car
[ALIVE_factionDefaultSupports, "rhs_faction_msv", ["rhs_tigr_msv","rhs_tigr_3camo_msv","rhs_tigr_ffv_msv","rhs_tigr_ffv_3camo_msv","rhs_tigr_sts_msv","rhs_tigr_sts_3camo_msv","rhs_tigr_m_msv","rhs_tigr_m_3camo_msv","RHS_UAZ_MSV_01","rhs_uaz_open_MSV_01"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultSupplies, "rhs_faction_msv", ["rhs_tigr_msv","rhs_tigr_3camo_msv","rhs_tigr_ffv_msv","rhs_tigr_ffv_3camo_msv","rhs_tigr_sts_msv","rhs_tigr_sts_3camo_msv","rhs_tigr_m_msv","rhs_tigr_m_3camo_msv","RHS_UAZ_MSV_01","rhs_uaz_open_MSV_01"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultTransport, "rhs_faction_msv", ["rhs_tigr_msv","rhs_tigr_3camo_msv","rhs_tigr_ffv_msv","rhs_tigr_ffv_3camo_msv","rhs_tigr_sts_msv","rhs_tigr_sts_3camo_msv","rhs_tigr_m_msv","rhs_tigr_m_3camo_msv","RHS_UAZ_MSV_01","rhs_uaz_open_MSV_01"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultAirTransport, "rhs_faction_msv", ["rhs_tigr_msv","rhs_tigr_3camo_msv","rhs_tigr_ffv_msv","rhs_tigr_ffv_3camo_msv","rhs_tigr_sts_msv","rhs_tigr_sts_3camo_msv","rhs_tigr_m_msv","rhs_tigr_m_3camo_msv","RHS_UAZ_MSV_01","rhs_uaz_open_MSV_01"]] call ALIVE_fnc_hashSet;

// rhs_vehclass_artillery
[ALIVE_factionDefaultSupports, "rhs_faction_msv", ["rhs_D30_msv","rhs_D30_at_msv","rhs_2b14_82mm_msv"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultSupplies, "rhs_faction_msv", ["rhs_D30_msv","rhs_D30_at_msv","rhs_2b14_82mm_msv"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultTransport, "rhs_faction_msv", ["rhs_D30_msv","rhs_D30_at_msv","rhs_2b14_82mm_msv"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultAirTransport, "rhs_faction_msv", ["rhs_D30_msv","rhs_D30_at_msv","rhs_2b14_82mm_msv"]] call ALIVE_fnc_hashSet;

// rhs_vehclass_truck
[ALIVE_factionDefaultSupports, "rhs_faction_msv", ["RHS_Ural_MSV_01","RHS_Ural_Open_MSV_01","RHS_Ural_Fuel_MSV_01","RHS_BM21_MSV_01","rhs_gaz66_msv","rhs_gaz66o_msv","rhs_gaz66_r142_msv","rhs_gaz66_repair_msv","rhs_gaz66_ap2_msv","rhs_gaz66_ammo_msv"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultSupplies, "rhs_faction_msv", ["RHS_Ural_MSV_01","RHS_Ural_Open_MSV_01","RHS_Ural_Fuel_MSV_01","RHS_BM21_MSV_01","rhs_gaz66_msv","rhs_gaz66o_msv","rhs_gaz66_r142_msv","rhs_gaz66_repair_msv","rhs_gaz66_ap2_msv","rhs_gaz66_ammo_msv"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultTransport, "rhs_faction_msv", ["RHS_Ural_MSV_01","RHS_Ural_Open_MSV_01","RHS_Ural_Fuel_MSV_01","RHS_BM21_MSV_01","rhs_gaz66_msv","rhs_gaz66o_msv","rhs_gaz66_r142_msv","rhs_gaz66_repair_msv","rhs_gaz66_ap2_msv","rhs_gaz66_ammo_msv"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultAirTransport, "rhs_faction_msv", ["RHS_Ural_MSV_01","RHS_Ural_Open_MSV_01","RHS_Ural_Fuel_MSV_01","RHS_BM21_MSV_01","rhs_gaz66_msv","rhs_gaz66o_msv","rhs_gaz66_r142_msv","rhs_gaz66_repair_msv","rhs_gaz66_ap2_msv","rhs_gaz66_ammo_msv"]] call ALIVE_fnc_hashSet;

// rhs_vehclass_ifv
[ALIVE_factionDefaultSupports, "rhs_faction_msv", ["rhs_bmp3_msv","rhs_bmp3_late_msv","rhs_bmp3m_msv","rhs_bmp3mera_msv","rhs_bmp1_msv","rhs_bmp1p_msv","rhs_bmp1k_msv","rhs_bmp1d_msv","rhs_prp3_msv","rhs_bmp2e_msv","rhs_bmp2_msv","rhs_bmp2k_msv","rhs_bmp2d_msv","rhs_brm1k_msv"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultSupplies, "rhs_faction_msv", ["rhs_bmp3_msv","rhs_bmp3_late_msv","rhs_bmp3m_msv","rhs_bmp3mera_msv","rhs_bmp1_msv","rhs_bmp1p_msv","rhs_bmp1k_msv","rhs_bmp1d_msv","rhs_prp3_msv","rhs_bmp2e_msv","rhs_bmp2_msv","rhs_bmp2k_msv","rhs_bmp2d_msv","rhs_brm1k_msv"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultTransport, "rhs_faction_msv", ["rhs_bmp3_msv","rhs_bmp3_late_msv","rhs_bmp3m_msv","rhs_bmp3mera_msv","rhs_bmp1_msv","rhs_bmp1p_msv","rhs_bmp1k_msv","rhs_bmp1d_msv","rhs_prp3_msv","rhs_bmp2e_msv","rhs_bmp2_msv","rhs_bmp2k_msv","rhs_bmp2d_msv","rhs_brm1k_msv"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultAirTransport, "rhs_faction_msv", ["rhs_bmp3_msv","rhs_bmp3_late_msv","rhs_bmp3m_msv","rhs_bmp3mera_msv","rhs_bmp1_msv","rhs_bmp1p_msv","rhs_bmp1k_msv","rhs_bmp1d_msv","rhs_prp3_msv","rhs_bmp2e_msv","rhs_bmp2_msv","rhs_bmp2k_msv","rhs_bmp2d_msv","rhs_brm1k_msv"]] call ALIVE_fnc_hashSet;

// rhs_vehclass_apc
[ALIVE_factionDefaultSupports, "rhs_faction_msv", ["rhs_btr70_msv","rhs_btr80_msv","rhs_btr80a_msv","rhs_btr60_msv"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultSupplies, "rhs_faction_msv", ["rhs_btr70_msv","rhs_btr80_msv","rhs_btr80a_msv","rhs_btr60_msv"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultTransport, "rhs_faction_msv", ["rhs_btr70_msv","rhs_btr80_msv","rhs_btr80a_msv","rhs_btr60_msv"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultAirTransport, "rhs_faction_msv", ["rhs_btr70_msv","rhs_btr80_msv","rhs_btr80a_msv","rhs_btr60_msv"]] call ALIVE_fnc_hashSet;
*/


// rhs_faction_vdv

rhs_faction_vdv_mappings = [] call ALIVE_fnc_hashCreate;

rhs_faction_vdv_factionCustomGroups = [] call ALIVE_fnc_hashCreate;

[rhs_faction_vdv_mappings, "Side", "EAST"] call ALIVE_fnc_hashSet;
[rhs_faction_vdv_mappings, "GroupSideName", "EAST"] call ALIVE_fnc_hashSet;
[rhs_faction_vdv_mappings, "FactionName", "rhs_faction_vdv"] call ALIVE_fnc_hashSet;
[rhs_faction_vdv_mappings, "GroupFactionName", "rhs_faction_vdv"] call ALIVE_fnc_hashSet;

rhs_faction_vdv_typeMappings = [] call ALIVE_fnc_hashCreate;

[rhs_faction_vdv_mappings, "GroupFactionTypes", rhs_faction_vdv_typeMappings] call ALIVE_fnc_hashSet;

[rhs_faction_vdv_factionCustomGroups, "Infantry", ["rhs_group_rus_vdv_infantry_mflora_chq","rhs_group_rus_vdv_infantry_mflora_squad","rhs_group_rus_vdv_infantry_mflora_squad_2mg","rhs_group_rus_vdv_infantry_mflora_squad_sniper","rhs_group_rus_vdv_infantry_mflora_squad_mg_sniper","rhs_group_rus_vdv_infantry_mflora_section_mg","rhs_group_rus_vdv_infantry_mflora_section_marksman","rhs_group_rus_vdv_infantry_mflora_section_AT","rhs_group_rus_vdv_infantry_mflora_section_AA","rhs_group_rus_vdv_infantry_mflora_fireteam","rhs_group_rus_vdv_infantry_mflora_MANEUVER","rhs_group_rus_vdv_infantry_flora_chq","rhs_group_rus_vdv_infantry_flora_squad","rhs_group_rus_vdv_infantry_flora_squad_2mg","rhs_group_rus_vdv_infantry_flora_squad_sniper","rhs_group_rus_vdv_infantry_flora_squad_mg_sniper","rhs_group_rus_vdv_infantry_flora_section_mg","rhs_group_rus_vdv_infantry_flora_section_marksman","rhs_group_rus_vdv_infantry_flora_section_AT","rhs_group_rus_vdv_infantry_flora_section_AA","rhs_group_rus_vdv_infantry_flora_fireteam","rhs_group_rus_vdv_infantry_flora_MANEUVER","rhs_group_rus_vdv_infantry_chq","rhs_group_rus_vdv_infantry_squad","rhs_group_rus_vdv_infantry_squad_2mg","rhs_group_rus_vdv_infantry_squad_sniper","rhs_group_rus_vdv_infantry_squad_mg_sniper","rhs_group_rus_vdv_infantry_section_mg","rhs_group_rus_vdv_infantry_section_marksman","rhs_group_rus_vdv_infantry_section_AT","rhs_group_rus_vdv_infantry_section_AA","rhs_group_rus_vdv_infantry_fireteam","rhs_group_rus_vdv_infantry_MANEUVER","rhs_group_rus_vdv_recon_infantry_squad"]] call ALIVE_fnc_hashSet;
[rhs_faction_vdv_factionCustomGroups, "Motorized", ["rhs_group_rus_vdv_gaz66_chq","rhs_group_rus_vdv_gaz66_squad","rhs_group_rus_vdv_gaz66_squad_2mg","rhs_group_rus_vdv_gaz66_squad_sniper","rhs_group_rus_vdv_gaz66_squad_mg_sniper","rhs_group_rus_vdv_gaz66_squad_aa","rhs_group_rus_vdv_Ural_chq","rhs_group_rus_vdv_Ural_squad","rhs_group_rus_vdv_Ural_squad_2mg","rhs_group_rus_vdv_Ural_squad_sniper","rhs_group_rus_vdv_Ural_squad_mg_sniper","rhs_group_rus_vdv_Ural_squad_aa"]] call ALIVE_fnc_hashSet;
[rhs_faction_vdv_factionCustomGroups, "Mechanized", ["rhs_group_rus_vdv_bmd4ma_chq","rhs_group_rus_vdv_bmd4ma_squad","rhs_group_rus_vdv_bmd4ma_squad_2mg","rhs_group_rus_vdv_bmd4ma_squad_sniper","rhs_group_rus_vdv_bmd4ma_squad_mg_sniper","rhs_group_rus_vdv_bmd4ma_squad_aa","rhs_group_rus_vdv_bmd4m_chq","rhs_group_rus_vdv_bmd4m_squad","rhs_group_rus_vdv_bmd4m_squad_2mg","rhs_group_rus_vdv_bmd4m_squad_sniper","rhs_group_rus_vdv_bmd4m_squad_mg_sniper","rhs_group_rus_vdv_bmd4m_squad_aa","rhs_group_rus_vdv_bmd4_chq","rhs_group_rus_vdv_bmd4_squad","rhs_group_rus_vdv_bmd4_squad_2mg","rhs_group_rus_vdv_bmd4_squad_sniper","rhs_group_rus_vdv_bmd4_squad_mg_sniper","rhs_group_rus_vdv_bmd4_squad_aa","rhs_group_rus_vdv_bmd2_chq","rhs_group_rus_vdv_bmd2_squad","rhs_group_rus_vdv_bmd2_squad_2mg","rhs_group_rus_vdv_bmd2_squad_sniper","rhs_group_rus_vdv_bmd2_squad_mg_sniper","rhs_group_rus_vdv_bmd2_squad_aa","rhs_group_rus_vdv_bmd1_chq","rhs_group_rus_vdv_bmd1_squad","rhs_group_rus_vdv_bmd1_squad_2mg","rhs_group_rus_vdv_bmd1_squad_sniper","rhs_group_rus_vdv_bmd1_squad_mg_sniper","rhs_group_rus_vdv_bmd1_squad_aa","rhs_group_rus_vdv_bmp2_chq","rhs_group_rus_vdv_bmp2_squad","rhs_group_rus_vdv_bmp2_squad_2mg","rhs_group_rus_vdv_bmp2_squad_sniper","rhs_group_rus_vdv_bmp2_squad_mg_sniper","rhs_group_rus_vdv_bmp2_squad_aa","rhs_group_rus_vdv_bmp1_chq","rhs_group_rus_vdv_bmp1_squad","rhs_group_rus_vdv_bmp1_squad_2mg","rhs_group_rus_vdv_bmp1_squad_sniper","rhs_group_rus_vdv_bmp1_squad_mg_sniper","rhs_group_rus_vdv_bmp1_squad_aa","rhs_group_rus_vdv_BTR80a_chq","rhs_group_rus_vdv_BTR80a_squad","rhs_group_rus_vdv_BTR80a_squad_2mg","rhs_group_rus_vdv_BTR80a_squad_sniper","rhs_group_rus_vdv_BTR80a_squad_mg_sniper","rhs_group_rus_vdv_BTR80a_squad_aa","rhs_group_rus_vdv_BTR80_chq","rhs_group_rus_vdv_BTR80_squad","rhs_group_rus_vdv_BTR80_squad_2mg","rhs_group_rus_vdv_BTR80_squad_sniper","rhs_group_rus_vdv_BTR80_squad_mg_sniper","rhs_group_rus_vdv_BTR80_squad_aa","rhs_group_rus_vdv_btr70_chq","rhs_group_rus_vdv_btr70_squad","rhs_group_rus_vdv_btr70_squad_2mg","rhs_group_rus_vdv_btr70_squad_sniper","rhs_group_rus_vdv_btr70_squad_mg_sniper","rhs_group_rus_vdv_btr70_squad_aa","rhs_group_rus_vdv_btr60_chq","rhs_group_rus_vdv_btr60_squad","rhs_group_rus_vdv_btr60_squad_2mg","rhs_group_rus_vdv_btr60_squad_sniper","rhs_group_rus_vdv_btr60_squad_mg_sniper","rhs_group_rus_vdv_btr60_squad_aa"]] call ALIVE_fnc_hashSet;
[rhs_faction_vdv_factionCustomGroups, "Airborne", ["rhs_group_rus_vdv_mi24_chq","rhs_group_rus_vdv_mi24_squad","rhs_group_rus_vdv_mi24_squad_2mg","rhs_group_rus_vdv_mi24_squad_sniper","rhs_group_rus_vdv_mi24_squad_mg_sniper","rhs_group_rus_vdv_mi8_chq","rhs_group_rus_vdv_mi8_squad","rhs_group_rus_vdv_mi8_squad_2mg","rhs_group_rus_vdv_mi8_squad_sniper","rhs_group_rus_vdv_mi8_squad_mg_sniper"]] call ALIVE_fnc_hashSet;
[rhs_faction_vdv_factionCustomGroups, "Artillery", ["RHS_SPGPlatoon_vdv_bm21","RHS_SPGSection_vdv_bm21","RHS_SPGPlatoon_tv_2s3","RHS_SPGSection_tv_2s3"]] call ALIVE_fnc_hashSet;
[rhs_faction_vdv_factionCustomGroups, "Armored", ["RHS_2S25Platoon","RHS_2S25Platoon_AA","RHS_2S25Section","RHS_T80Platoon","RHS_T80Platoon_AA","RHS_T80Section","RHS_T80BPlatoon","RHS_T80BPlatoon_AA","RHS_T80BSection","RHS_T80BVPlatoon","RHS_T80BVPlatoon_AA","RHS_T80BVSection","RHS_T80APlatoon","RHS_T80APlatoon_AA","RHS_T80ASection","RHS_T80UPlatoon","RHS_T80UPlatoon_AA","RHS_T80USection","RHS_T72BAPlatoon","RHS_T72BAPlatoon_AA","RHS_T72BASection","RHS_T72BBPlatoon","RHS_T72BBPlatoon_AA","RHS_T72BBSection","RHS_T72BCPlatoon","RHS_T72BCPlatoon_AA","RHS_T72BCSection","RHS_T72BDPlatoon","RHS_T72BDPlatoon_AA","RHS_T72BDSection"]] call ALIVE_fnc_hashSet;

[rhs_faction_vdv_mappings, "Groups", rhs_faction_vdv_factionCustomGroups] call ALIVE_fnc_hashSet;

[ALIVE_factionCustomMappings, "rhs_faction_vdv", rhs_faction_vdv_mappings] call ALIVE_fnc_hashSet;

[ALIVE_factionDefaultSupports, "rhs_faction_vdv", ["rhs_p37","rhs_prv13","rhs_2P3_1","rhs_2P3_2","rhs_v2","rhs_v3","rhs_9k79","rhs_9k79_K","rhs_9k79_B","rhs_2s3_tv","rhs_zsu234_aa","RHS_Ural_VMF_01","RHS_Ural_Open_VMF_01","RHS_Ural_Fuel_VMF_01","RHS_BM21_VMF_01","rhs_gaz66_vmf","rhs_gaz66o_vmf","rhs_gaz66_r142_vmf","rhs_gaz66_repair_vmf","rhs_gaz66_ap2_vmf","rhs_gaz66_ammo_vmf","rhs_tigr_vmf","rhs_tigr_3camo_vmf","rhs_tigr_ffv_vmf","rhs_tigr_ffv_3camo_vmf","rhs_uaz_vmf","rhs_uaz_open_vmf","rhs_tigr_vdv","rhs_tigr_3camo_vdv","rhs_tigr_ffv_vdv","rhs_tigr_ffv_3camo_vdv","rhs_tigr_sts_vdv","rhs_tigr_sts_3camo_vdv","rhs_tigr_m_vdv","rhs_tigr_m_3camo_vdv","rhs_uaz_vdv","rhs_uaz_open_vdv"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultTransport, "rhs_faction_vdv", ["RHS_Ural_VDV_01","RHS_Ural_Open_VDV_01","rhs_gaz66_vdv","rhs_gaz66o_vdv","rhs_gaz66_ap2_vdv"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultAirTransport, "rhs_faction_vdv", ["RHS_Mi24P_CAS_vdv","RHS_Mi24P_AT_vdv","RHS_Mi24P_vdv","RHS_Mi24V_FAB_vdv","RHS_Mi24V_UPK23_vdv","RHS_Mi24V_AT_vdv","RHS_Mi24V_vdv","RHS_Mi8mt_vdv","RHS_Mi8mt_Cargo_vdv","RHS_Mi8MTV3_vdv","RHS_Mi8MTV3_UPK23_vdv","RHS_Mi8MTV3_FAB_vdv","RHS_Mi8AMT_vdv"]] call ALIVE_fnc_hashSet;

/*
// Static
[ALIVE_factionDefaultSupports, "rhs_faction_vdv", ["rhs_Metis_9k115_2_vdv","rhs_Igla_AA_pod_vdv","RHS_AGS30_TriPod_VDV","rhs_KORD_VDV","rhs_KORD_high_VDV","RHS_NSV_TriPod_VDV"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultSupplies, "rhs_faction_vdv", ["rhs_Metis_9k115_2_vdv","rhs_Igla_AA_pod_vdv","RHS_AGS30_TriPod_VDV","rhs_KORD_VDV","rhs_KORD_high_VDV","RHS_NSV_TriPod_VDV"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultTransport, "rhs_faction_vdv", ["rhs_Metis_9k115_2_vdv","rhs_Igla_AA_pod_vdv","RHS_AGS30_TriPod_VDV","rhs_KORD_VDV","rhs_KORD_high_VDV","RHS_NSV_TriPod_VDV"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultAirTransport, "rhs_faction_vdv", ["rhs_Metis_9k115_2_vdv","rhs_Igla_AA_pod_vdv","RHS_AGS30_TriPod_VDV","rhs_KORD_VDV","rhs_KORD_high_VDV","RHS_NSV_TriPod_VDV"]] call ALIVE_fnc_hashSet;

// rhs_vehclass_car
[ALIVE_factionDefaultSupports, "rhs_faction_vdv", ["rhs_tigr_vdv","rhs_tigr_3camo_vdv","rhs_tigr_ffv_vdv","rhs_tigr_ffv_3camo_vdv","rhs_tigr_sts_vdv","rhs_tigr_sts_3camo_vdv","rhs_tigr_m_vdv","rhs_tigr_m_3camo_vdv","rhs_uaz_vdv","rhs_uaz_open_vdv"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultSupplies, "rhs_faction_vdv", ["rhs_tigr_vdv","rhs_tigr_3camo_vdv","rhs_tigr_ffv_vdv","rhs_tigr_ffv_3camo_vdv","rhs_tigr_sts_vdv","rhs_tigr_sts_3camo_vdv","rhs_tigr_m_vdv","rhs_tigr_m_3camo_vdv","rhs_uaz_vdv","rhs_uaz_open_vdv"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultTransport, "rhs_faction_vdv", ["rhs_tigr_vdv","rhs_tigr_3camo_vdv","rhs_tigr_ffv_vdv","rhs_tigr_ffv_3camo_vdv","rhs_tigr_sts_vdv","rhs_tigr_sts_3camo_vdv","rhs_tigr_m_vdv","rhs_tigr_m_3camo_vdv","rhs_uaz_vdv","rhs_uaz_open_vdv"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultAirTransport, "rhs_faction_vdv", ["rhs_tigr_vdv","rhs_tigr_3camo_vdv","rhs_tigr_ffv_vdv","rhs_tigr_ffv_3camo_vdv","rhs_tigr_sts_vdv","rhs_tigr_sts_3camo_vdv","rhs_tigr_m_vdv","rhs_tigr_m_3camo_vdv","rhs_uaz_vdv","rhs_uaz_open_vdv"]] call ALIVE_fnc_hashSet;

// rhs_vehclass_artillery
[ALIVE_factionDefaultSupports, "rhs_faction_vdv", ["rhs_D30_vdv","rhs_D30_at_vdv","rhs_2b14_82mm_vdv"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultSupplies, "rhs_faction_vdv", ["rhs_D30_vdv","rhs_D30_at_vdv","rhs_2b14_82mm_vdv"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultTransport, "rhs_faction_vdv", ["rhs_D30_vdv","rhs_D30_at_vdv","rhs_2b14_82mm_vdv"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultAirTransport, "rhs_faction_vdv", ["rhs_D30_vdv","rhs_D30_at_vdv","rhs_2b14_82mm_vdv"]] call ALIVE_fnc_hashSet;

// rhs_vehclass_helicopter
[ALIVE_factionDefaultSupports, "rhs_faction_vdv", ["RHS_Mi24P_CAS_vdv","RHS_Mi24P_AT_vdv","RHS_Mi24P_vdv","RHS_Mi24V_FAB_vdv","RHS_Mi24V_UPK23_vdv","RHS_Mi24V_AT_vdv","RHS_Mi24V_vdv","RHS_Mi8mt_vdv","RHS_Mi8mt_Cargo_vdv","RHS_Mi8MTV3_vdv","RHS_Mi8MTV3_UPK23_vdv","RHS_Mi8MTV3_FAB_vdv","RHS_Mi8AMT_vdv"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultSupplies, "rhs_faction_vdv", ["RHS_Mi24P_CAS_vdv","RHS_Mi24P_AT_vdv","RHS_Mi24P_vdv","RHS_Mi24V_FAB_vdv","RHS_Mi24V_UPK23_vdv","RHS_Mi24V_AT_vdv","RHS_Mi24V_vdv","RHS_Mi8mt_vdv","RHS_Mi8mt_Cargo_vdv","RHS_Mi8MTV3_vdv","RHS_Mi8MTV3_UPK23_vdv","RHS_Mi8MTV3_FAB_vdv","RHS_Mi8AMT_vdv"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultTransport, "rhs_faction_vdv", ["RHS_Mi24P_CAS_vdv","RHS_Mi24P_AT_vdv","RHS_Mi24P_vdv","RHS_Mi24V_FAB_vdv","RHS_Mi24V_UPK23_vdv","RHS_Mi24V_AT_vdv","RHS_Mi24V_vdv","RHS_Mi8mt_vdv","RHS_Mi8mt_Cargo_vdv","RHS_Mi8MTV3_vdv","RHS_Mi8MTV3_UPK23_vdv","RHS_Mi8MTV3_FAB_vdv","RHS_Mi8AMT_vdv"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultAirTransport, "rhs_faction_vdv", ["RHS_Mi24P_CAS_vdv","RHS_Mi24P_AT_vdv","RHS_Mi24P_vdv","RHS_Mi24V_FAB_vdv","RHS_Mi24V_UPK23_vdv","RHS_Mi24V_AT_vdv","RHS_Mi24V_vdv","RHS_Mi8mt_vdv","RHS_Mi8mt_Cargo_vdv","RHS_Mi8MTV3_vdv","RHS_Mi8MTV3_UPK23_vdv","RHS_Mi8MTV3_FAB_vdv","RHS_Mi8AMT_vdv"]] call ALIVE_fnc_hashSet;

// rhs_vehclass_truck
[ALIVE_factionDefaultSupports, "rhs_faction_vdv", ["RHS_Ural_VDV_01","RHS_Ural_Open_VDV_01","RHS_Ural_Fuel_VDV_01","RHS_BM21_VDV_01","rhs_typhoon_vdv","rhs_gaz66_vdv","rhs_gaz66o_vdv","rhs_gaz66_r142_vdv","rhs_gaz66_repair_vdv","rhs_gaz66_ap2_vdv","rhs_gaz66_ammo_vdv"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultSupplies, "rhs_faction_vdv", ["RHS_Ural_VDV_01","RHS_Ural_Open_VDV_01","RHS_Ural_Fuel_VDV_01","RHS_BM21_VDV_01","rhs_typhoon_vdv","rhs_gaz66_vdv","rhs_gaz66o_vdv","rhs_gaz66_r142_vdv","rhs_gaz66_repair_vdv","rhs_gaz66_ap2_vdv","rhs_gaz66_ammo_vdv"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultTransport, "rhs_faction_vdv", ["RHS_Ural_VDV_01","RHS_Ural_Open_VDV_01","RHS_Ural_Fuel_VDV_01","RHS_BM21_VDV_01","rhs_typhoon_vdv","rhs_gaz66_vdv","rhs_gaz66o_vdv","rhs_gaz66_r142_vdv","rhs_gaz66_repair_vdv","rhs_gaz66_ap2_vdv","rhs_gaz66_ammo_vdv"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultAirTransport, "rhs_faction_vdv", ["RHS_Ural_VDV_01","RHS_Ural_Open_VDV_01","RHS_Ural_Fuel_VDV_01","RHS_BM21_VDV_01","rhs_typhoon_vdv","rhs_gaz66_vdv","rhs_gaz66o_vdv","rhs_gaz66_r142_vdv","rhs_gaz66_repair_vdv","rhs_gaz66_ap2_vdv","rhs_gaz66_ammo_vdv"]] call ALIVE_fnc_hashSet;

// rhs_vehclass_ifv
[ALIVE_factionDefaultSupports, "rhs_faction_vdv", ["rhs_bmd1","rhs_bmd1k","rhs_bmd1p","rhs_bmd1pk","rhs_bmd1r","rhs_bmd2","rhs_bmd2m","rhs_bmd2k","rhs_bmp1_vdv","rhs_bmp1p_vdv","rhs_bmp1k_vdv","rhs_bmp1d_vdv","rhs_prp3_vdv","rhs_bmp2e_vdv","rhs_bmp2_vdv","rhs_bmp2k_vdv","rhs_bmp2d_vdv","rhs_brm1k_vdv","rhs_bmd4_vdv","rhs_bmd4m_vdv","rhs_bmd4ma_vdv"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultSupplies, "rhs_faction_vdv", ["rhs_bmd1","rhs_bmd1k","rhs_bmd1p","rhs_bmd1pk","rhs_bmd1r","rhs_bmd2","rhs_bmd2m","rhs_bmd2k","rhs_bmp1_vdv","rhs_bmp1p_vdv","rhs_bmp1k_vdv","rhs_bmp1d_vdv","rhs_prp3_vdv","rhs_bmp2e_vdv","rhs_bmp2_vdv","rhs_bmp2k_vdv","rhs_bmp2d_vdv","rhs_brm1k_vdv","rhs_bmd4_vdv","rhs_bmd4m_vdv","rhs_bmd4ma_vdv"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultTransport, "rhs_faction_vdv", ["rhs_bmd1","rhs_bmd1k","rhs_bmd1p","rhs_bmd1pk","rhs_bmd1r","rhs_bmd2","rhs_bmd2m","rhs_bmd2k","rhs_bmp1_vdv","rhs_bmp1p_vdv","rhs_bmp1k_vdv","rhs_bmp1d_vdv","rhs_prp3_vdv","rhs_bmp2e_vdv","rhs_bmp2_vdv","rhs_bmp2k_vdv","rhs_bmp2d_vdv","rhs_brm1k_vdv","rhs_bmd4_vdv","rhs_bmd4m_vdv","rhs_bmd4ma_vdv"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultAirTransport, "rhs_faction_vdv", ["rhs_bmd1","rhs_bmd1k","rhs_bmd1p","rhs_bmd1pk","rhs_bmd1r","rhs_bmd2","rhs_bmd2m","rhs_bmd2k","rhs_bmp1_vdv","rhs_bmp1p_vdv","rhs_bmp1k_vdv","rhs_bmp1d_vdv","rhs_prp3_vdv","rhs_bmp2e_vdv","rhs_bmp2_vdv","rhs_bmp2k_vdv","rhs_bmp2d_vdv","rhs_brm1k_vdv","rhs_bmd4_vdv","rhs_bmd4m_vdv","rhs_bmd4ma_vdv"]] call ALIVE_fnc_hashSet;

// rhs_vehclass_apc
[ALIVE_factionDefaultSupports, "rhs_faction_vdv", ["rhs_btr70_vdv","rhs_btr80_vdv","rhs_btr80a_vdv","rhs_btr60_vdv"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultSupplies, "rhs_faction_vdv", ["rhs_btr70_vdv","rhs_btr80_vdv","rhs_btr80a_vdv","rhs_btr60_vdv"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultTransport, "rhs_faction_vdv", ["rhs_btr70_vdv","rhs_btr80_vdv","rhs_btr80a_vdv","rhs_btr60_vdv"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultAirTransport, "rhs_faction_vdv", ["rhs_btr70_vdv","rhs_btr80_vdv","rhs_btr80a_vdv","rhs_btr60_vdv"]] call ALIVE_fnc_hashSet;

// rhs_vehclass_tank
[ALIVE_factionDefaultSupports, "rhs_faction_vdv", ["rhs_sprut_vdv"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultSupplies, "rhs_faction_vdv", ["rhs_sprut_vdv"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultTransport, "rhs_faction_vdv", ["rhs_sprut_vdv"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultAirTransport, "rhs_faction_vdv", ["rhs_sprut_vdv"]] call ALIVE_fnc_hashSet;
*/


// rhs_faction_tv

rhs_faction_tv_mappings = [] call ALIVE_fnc_hashCreate;

rhs_faction_tv_factionCustomGroups = [] call ALIVE_fnc_hashCreate;

[rhs_faction_tv_mappings, "Side", "EAST"] call ALIVE_fnc_hashSet;
[rhs_faction_tv_mappings, "GroupSideName", "EAST"] call ALIVE_fnc_hashSet;
[rhs_faction_tv_mappings, "FactionName", "rhs_faction_tv"] call ALIVE_fnc_hashSet;
[rhs_faction_tv_mappings, "GroupFactionName", "rhs_faction_tv"] call ALIVE_fnc_hashSet;

rhs_faction_tv_typeMappings = [] call ALIVE_fnc_hashCreate;

[rhs_faction_tv_mappings, "GroupFactionTypes", rhs_faction_tv_typeMappings] call ALIVE_fnc_hashSet;

[rhs_faction_tv_factionCustomGroups, "Armored", ["RHS_T90Platoon","RHS_T90Platoon_AA","RHS_T90Section","RHS_T90APlatoon","RHS_T90APlatoon_AA","RHS_T90ASection","RHS_T80Platoon","RHS_T80Platoon_AA","RHS_T80Section","RHS_T80BPlatoon","RHS_T80BPlatoon_AA","RHS_T80BSection","RHS_T80BVPlatoon","RHS_T80BVPlatoon_AA","RHS_T80BVSection","RHS_T80APlatoon","RHS_T80APlatoon_AA","RHS_T80ASection","RHS_T80UPlatoon","RHS_T80UPlatoon_AA","RHS_T80USection","RHS_T72BAPlatoon","RHS_T72BAPlatoon_AA","RHS_T72BASection","RHS_T72BBPlatoon","RHS_T72BBPlatoon_AA","RHS_T72BBSection","RHS_T72BCPlatoon","RHS_T72BCPlatoon_AA","RHS_T72BCSection","RHS_T72BDPlatoon","RHS_T72BDPlatoon_AA","RHS_T72BDSection"]] call ALIVE_fnc_hashSet;
[rhs_faction_tv_factionCustomGroups, "Artillery", ["RHS_SPGPlatoon_tv_2s3","RHS_SPGSection_tv_2s3"]] call ALIVE_fnc_hashSet;

[rhs_faction_tv_mappings, "Groups", rhs_faction_tv_factionCustomGroups] call ALIVE_fnc_hashSet;

[ALIVE_factionCustomMappings, "rhs_faction_tv", rhs_faction_tv_mappings] call ALIVE_fnc_hashSet;

/*
// rhs_vehclass_artillery
[ALIVE_factionDefaultSupports, "rhs_faction_tv", ["rhs_2s3_tv"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultSupplies, "rhs_faction_tv", ["rhs_2s3_tv"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultTransport, "rhs_faction_tv", ["rhs_2s3_tv"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultAirTransport, "rhs_faction_tv", ["rhs_2s3_tv"]] call ALIVE_fnc_hashSet;

// rhs_vehclass_ifv
[ALIVE_factionDefaultSupports, "rhs_faction_tv", ["rhs_bmp1_tv","rhs_bmp1p_tv","rhs_bmp1k_tv","rhs_bmp1d_tv","rhs_prp3_tv","rhs_bmp2e_tv","rhs_bmp2_tv","rhs_bmp2k_tv","rhs_bmp2d_tv","rhs_brm1k_tv"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultSupplies, "rhs_faction_tv", ["rhs_bmp1_tv","rhs_bmp1p_tv","rhs_bmp1k_tv","rhs_bmp1d_tv","rhs_prp3_tv","rhs_bmp2e_tv","rhs_bmp2_tv","rhs_bmp2k_tv","rhs_bmp2d_tv","rhs_brm1k_tv"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultTransport, "rhs_faction_tv", ["rhs_bmp1_tv","rhs_bmp1p_tv","rhs_bmp1k_tv","rhs_bmp1d_tv","rhs_prp3_tv","rhs_bmp2e_tv","rhs_bmp2_tv","rhs_bmp2k_tv","rhs_bmp2d_tv","rhs_brm1k_tv"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultAirTransport, "rhs_faction_tv", ["rhs_bmp1_tv","rhs_bmp1p_tv","rhs_bmp1k_tv","rhs_bmp1d_tv","rhs_prp3_tv","rhs_bmp2e_tv","rhs_bmp2_tv","rhs_bmp2k_tv","rhs_bmp2d_tv","rhs_brm1k_tv"]] call ALIVE_fnc_hashSet;

// rhs_vehclass_tank
[ALIVE_factionDefaultSupports, "rhs_faction_tv", ["rhs_t72ba_tv","rhs_t72bb_tv","rhs_t72bc_tv","rhs_t72bd_tv","rhs_t80b","rhs_t80bk","rhs_t80bv","rhs_t80bvk","rhs_t80","rhs_t80a","rhs_t80u","rhs_t80u45m","rhs_t80ue1","rhs_t80um","rhs_t90_tv","rhs_t90a_tv"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultSupplies, "rhs_faction_tv", ["rhs_t72ba_tv","rhs_t72bb_tv","rhs_t72bc_tv","rhs_t72bd_tv","rhs_t80b","rhs_t80bk","rhs_t80bv","rhs_t80bvk","rhs_t80","rhs_t80a","rhs_t80u","rhs_t80u45m","rhs_t80ue1","rhs_t80um","rhs_t90_tv","rhs_t90a_tv"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultTransport, "rhs_faction_tv", ["rhs_t72ba_tv","rhs_t72bb_tv","rhs_t72bc_tv","rhs_t72bd_tv","rhs_t80b","rhs_t80bk","rhs_t80bv","rhs_t80bvk","rhs_t80","rhs_t80a","rhs_t80u","rhs_t80u45m","rhs_t80ue1","rhs_t80um","rhs_t90_tv","rhs_t90a_tv"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultAirTransport, "rhs_faction_tv", ["rhs_t72ba_tv","rhs_t72bb_tv","rhs_t72bc_tv","rhs_t72bd_tv","rhs_t80b","rhs_t80bk","rhs_t80bv","rhs_t80bvk","rhs_t80","rhs_t80a","rhs_t80u","rhs_t80u45m","rhs_t80ue1","rhs_t80um","rhs_t90_tv","rhs_t90a_tv"]] call ALIVE_fnc_hashSet;
*/


/*
// rhs_faction_vmf

rhs_faction_vmf_mappings = [] call ALIVE_fnc_hashCreate;

rhs_faction_vmf_factionCustomGroups = [] call ALIVE_fnc_hashCreate;

[rhs_faction_vmf_mappings, "Side", "EAST"] call ALIVE_fnc_hashSet;
[rhs_faction_vmf_mappings, "GroupSideName", "EAST"] call ALIVE_fnc_hashSet;
[rhs_faction_vmf_mappings, "FactionName", "rhs_faction_vmf"] call ALIVE_fnc_hashSet;
[rhs_faction_vmf_mappings, "GroupFactionName", "rhs_faction_vmf"] call ALIVE_fnc_hashSet;

rhs_faction_vmf_typeMappings = [] call ALIVE_fnc_hashCreate;

[rhs_faction_vmf_mappings, "GroupFactionTypes", rhs_faction_vmf_typeMappings] call ALIVE_fnc_hashSet;

rhs_faction_vmf_typeMappings, "Air", "Air"] call ALIVE_fnc_hashSet;
rhs_faction_vmf_typeMappings, "Armored", "Armored"] call ALIVE_fnc_hashSet;
rhs_faction_vmf_typeMappings, "Infantry", "Infantry"] call ALIVE_fnc_hashSet;
rhs_faction_vmf_typeMappings, "Mechanized", "Mechanized"] call ALIVE_fnc_hashSet;
rhs_faction_vmf_typeMappings, "Motorized", "Motorized"] call ALIVE_fnc_hashSet;
rhs_faction_vmf_typeMappings, "Motorized_MTP", "Motorized_MTP"] call ALIVE_fnc_hashSet;
rhs_faction_vmf_typeMappings, "SpecOps", "SpecOps"] call ALIVE_fnc_hashSet;
rhs_faction_vmf_typeMappings, "Support", "Support"] call ALIVE_fnc_hashSet;

[rhs_faction_vmf_mappings, "Groups", rhs_faction_vmf_factionCustomGroups] call ALIVE_fnc_hashSet;

[ALIVE_factionCustomMappings, "rhs_faction_vmf", rhs_faction_vmf_mappings] call ALIVE_fnc_hashSet;

// rhs_vehclass_car
[ALIVE_factionDefaultSupports, "rhs_faction_vmf", ["rhs_tigr_vmf","rhs_tigr_3camo_vmf","rhs_tigr_ffv_vmf","rhs_tigr_ffv_3camo_vmf","rhs_tigr_sts_vmf","rhs_tigr_sts_3camo_vmf","rhs_tigr_m_vmf","rhs_tigr_m_3camo_vmf","rhs_uaz_vmf","rhs_uaz_open_vmf"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultSupplies, "rhs_faction_vmf", ["rhs_tigr_vmf","rhs_tigr_3camo_vmf","rhs_tigr_ffv_vmf","rhs_tigr_ffv_3camo_vmf","rhs_tigr_sts_vmf","rhs_tigr_sts_3camo_vmf","rhs_tigr_m_vmf","rhs_tigr_m_3camo_vmf","rhs_uaz_vmf","rhs_uaz_open_vmf"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultTransport, "rhs_faction_vmf", ["rhs_tigr_vmf","rhs_tigr_3camo_vmf","rhs_tigr_ffv_vmf","rhs_tigr_ffv_3camo_vmf","rhs_tigr_sts_vmf","rhs_tigr_sts_3camo_vmf","rhs_tigr_m_vmf","rhs_tigr_m_3camo_vmf","rhs_uaz_vmf","rhs_uaz_open_vmf"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultAirTransport, "rhs_faction_vmf", ["rhs_tigr_vmf","rhs_tigr_3camo_vmf","rhs_tigr_ffv_vmf","rhs_tigr_ffv_3camo_vmf","rhs_tigr_sts_vmf","rhs_tigr_sts_3camo_vmf","rhs_tigr_m_vmf","rhs_tigr_m_3camo_vmf","rhs_uaz_vmf","rhs_uaz_open_vmf"]] call ALIVE_fnc_hashSet;

// rhs_vehclass_truck
[ALIVE_factionDefaultSupports, "rhs_faction_vmf", ["RHS_Ural_VMF_01","RHS_Ural_Open_VMF_01","RHS_Ural_Fuel_VMF_01","RHS_BM21_VMF_01","rhs_gaz66_vmf","rhs_gaz66o_vmf","rhs_gaz66_r142_vmf","rhs_gaz66_repair_vmf","rhs_gaz66_ap2_vmf","rhs_gaz66_ammo_vmf"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultSupplies, "rhs_faction_vmf", ["RHS_Ural_VMF_01","RHS_Ural_Open_VMF_01","RHS_Ural_Fuel_VMF_01","RHS_BM21_VMF_01","rhs_gaz66_vmf","rhs_gaz66o_vmf","rhs_gaz66_r142_vmf","rhs_gaz66_repair_vmf","rhs_gaz66_ap2_vmf","rhs_gaz66_ammo_vmf"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultTransport, "rhs_faction_vmf", ["RHS_Ural_VMF_01","RHS_Ural_Open_VMF_01","RHS_Ural_Fuel_VMF_01","RHS_BM21_VMF_01","rhs_gaz66_vmf","rhs_gaz66o_vmf","rhs_gaz66_r142_vmf","rhs_gaz66_repair_vmf","rhs_gaz66_ap2_vmf","rhs_gaz66_ammo_vmf"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultAirTransport, "rhs_faction_vmf", ["RHS_Ural_VMF_01","RHS_Ural_Open_VMF_01","RHS_Ural_Fuel_VMF_01","RHS_BM21_VMF_01","rhs_gaz66_vmf","rhs_gaz66o_vmf","rhs_gaz66_r142_vmf","rhs_gaz66_repair_vmf","rhs_gaz66_ap2_vmf","rhs_gaz66_ammo_vmf"]] call ALIVE_fnc_hashSet;

// rhs_vehclass_ifv
[ALIVE_factionDefaultSupports, "rhs_faction_vmf", ["rhs_bmp1_vmf","rhs_bmp1p_vmf","rhs_bmp1k_vmf","rhs_bmp1d_vmf","rhs_prp3_vmf","rhs_bmp2e_vmf","rhs_bmp2_vmf","rhs_bmp2k_vmf","rhs_bmp2d_vmf","rhs_brm1k_vmf"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultSupplies, "rhs_faction_vmf", ["rhs_bmp1_vmf","rhs_bmp1p_vmf","rhs_bmp1k_vmf","rhs_bmp1d_vmf","rhs_prp3_vmf","rhs_bmp2e_vmf","rhs_bmp2_vmf","rhs_bmp2k_vmf","rhs_bmp2d_vmf","rhs_brm1k_vmf"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultTransport, "rhs_faction_vmf", ["rhs_bmp1_vmf","rhs_bmp1p_vmf","rhs_bmp1k_vmf","rhs_bmp1d_vmf","rhs_prp3_vmf","rhs_bmp2e_vmf","rhs_bmp2_vmf","rhs_bmp2k_vmf","rhs_bmp2d_vmf","rhs_brm1k_vmf"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultAirTransport, "rhs_faction_vmf", ["rhs_bmp1_vmf","rhs_bmp1p_vmf","rhs_bmp1k_vmf","rhs_bmp1d_vmf","rhs_prp3_vmf","rhs_bmp2e_vmf","rhs_bmp2_vmf","rhs_bmp2k_vmf","rhs_bmp2d_vmf","rhs_brm1k_vmf"]] call ALIVE_fnc_hashSet;

// rhs_vehclass_apc
[ALIVE_factionDefaultSupports, "rhs_faction_vmf", ["rhs_btr70_vmf","rhs_btr80_vmf","rhs_btr80a_vmf","rhs_btr60_vmf"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultSupplies, "rhs_faction_vmf", ["rhs_btr70_vmf","rhs_btr80_vmf","rhs_btr80a_vmf","rhs_btr60_vmf"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultTransport, "rhs_faction_vmf", ["rhs_btr70_vmf","rhs_btr80_vmf","rhs_btr80a_vmf","rhs_btr60_vmf"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultAirTransport, "rhs_faction_vmf", ["rhs_btr70_vmf","rhs_btr80_vmf","rhs_btr80a_vmf","rhs_btr60_vmf"]] call ALIVE_fnc_hashSet;



// rhs_faction_vv

rhs_faction_vv_mappings = [] call ALIVE_fnc_hashCreate;

rhs_faction_vv_factionCustomGroups = [] call ALIVE_fnc_hashCreate;

[rhs_faction_vv_mappings, "Side", "EAST"] call ALIVE_fnc_hashSet;
[rhs_faction_vv_mappings, "GroupSideName", "EAST"] call ALIVE_fnc_hashSet;
[rhs_faction_vv_mappings, "FactionName", "rhs_faction_vv"] call ALIVE_fnc_hashSet;
[rhs_faction_vv_mappings, "GroupFactionName", "rhs_faction_vv"] call ALIVE_fnc_hashSet;

rhs_faction_vv_typeMappings = [] call ALIVE_fnc_hashCreate;

[rhs_faction_vv_mappings, "GroupFactionTypes", rhs_faction_vv_typeMappings] call ALIVE_fnc_hashSet;

rhs_faction_vv_typeMappings, "Air", "Air"] call ALIVE_fnc_hashSet;
rhs_faction_vv_typeMappings, "Armored", "Armored"] call ALIVE_fnc_hashSet;
rhs_faction_vv_typeMappings, "Infantry", "Infantry"] call ALIVE_fnc_hashSet;
rhs_faction_vv_typeMappings, "Mechanized", "Mechanized"] call ALIVE_fnc_hashSet;
rhs_faction_vv_typeMappings, "Motorized", "Motorized"] call ALIVE_fnc_hashSet;
rhs_faction_vv_typeMappings, "Motorized_MTP", "Motorized_MTP"] call ALIVE_fnc_hashSet;
rhs_faction_vv_typeMappings, "SpecOps", "SpecOps"] call ALIVE_fnc_hashSet;
rhs_faction_vv_typeMappings, "Support", "Support"] call ALIVE_fnc_hashSet;

[rhs_faction_vv_mappings, "Groups", rhs_faction_vv_factionCustomGroups] call ALIVE_fnc_hashSet;

[ALIVE_factionCustomMappings, "rhs_faction_vv", rhs_faction_vv_mappings] call ALIVE_fnc_hashSet;

// rhs_vehclass_car
[ALIVE_factionDefaultSupports, "rhs_faction_vv", ["rhs_tigr_vv","rhs_tigr_3camo_vv","rhs_tigr_ffv_vv","rhs_tigr_ffv_3camo_vv","rhs_tigr_sts_vv","rhs_tigr_sts_3camo_vv","rhs_tigr_m_vv","rhs_tigr_m_3camo_vv","rhs_uaz_vv","rhs_uaz_open_vv"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultSupplies, "rhs_faction_vv", ["rhs_tigr_vv","rhs_tigr_3camo_vv","rhs_tigr_ffv_vv","rhs_tigr_ffv_3camo_vv","rhs_tigr_sts_vv","rhs_tigr_sts_3camo_vv","rhs_tigr_m_vv","rhs_tigr_m_3camo_vv","rhs_uaz_vv","rhs_uaz_open_vv"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultTransport, "rhs_faction_vv", ["rhs_tigr_vv","rhs_tigr_3camo_vv","rhs_tigr_ffv_vv","rhs_tigr_ffv_3camo_vv","rhs_tigr_sts_vv","rhs_tigr_sts_3camo_vv","rhs_tigr_m_vv","rhs_tigr_m_3camo_vv","rhs_uaz_vv","rhs_uaz_open_vv"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultAirTransport, "rhs_faction_vv", ["rhs_tigr_vv","rhs_tigr_3camo_vv","rhs_tigr_ffv_vv","rhs_tigr_ffv_3camo_vv","rhs_tigr_sts_vv","rhs_tigr_sts_3camo_vv","rhs_tigr_m_vv","rhs_tigr_m_3camo_vv","rhs_uaz_vv","rhs_uaz_open_vv"]] call ALIVE_fnc_hashSet;

// rhs_vehclass_helicopter
[ALIVE_factionDefaultSupports, "rhs_faction_vv", ["RHS_Mi8mt_vv","RHS_Mi8mt_Cargo_vv"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultSupplies, "rhs_faction_vv", ["RHS_Mi8mt_vv","RHS_Mi8mt_Cargo_vv"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultTransport, "rhs_faction_vv", ["RHS_Mi8mt_vv","RHS_Mi8mt_Cargo_vv"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultAirTransport, "rhs_faction_vv", ["RHS_Mi8mt_vv","RHS_Mi8mt_Cargo_vv"]] call ALIVE_fnc_hashSet;

// rhs_vehclass_truck
[ALIVE_factionDefaultSupports, "rhs_faction_vv", ["RHS_Ural_VV_01","RHS_Ural_Open_VV_01","RHS_Ural_Fuel_VV_01","RHS_BM21_VV_01","rhs_gaz66_vv","rhs_gaz66o_vv","rhs_gaz66_r142_vv","rhs_gaz66_repair_vv","rhs_gaz66_ap2_vv","rhs_gaz66_ammo_vv"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultSupplies, "rhs_faction_vv", ["RHS_Ural_VV_01","RHS_Ural_Open_VV_01","RHS_Ural_Fuel_VV_01","RHS_BM21_VV_01","rhs_gaz66_vv","rhs_gaz66o_vv","rhs_gaz66_r142_vv","rhs_gaz66_repair_vv","rhs_gaz66_ap2_vv","rhs_gaz66_ammo_vv"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultTransport, "rhs_faction_vv", ["RHS_Ural_VV_01","RHS_Ural_Open_VV_01","RHS_Ural_Fuel_VV_01","RHS_BM21_VV_01","rhs_gaz66_vv","rhs_gaz66o_vv","rhs_gaz66_r142_vv","rhs_gaz66_repair_vv","rhs_gaz66_ap2_vv","rhs_gaz66_ammo_vv"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultAirTransport, "rhs_faction_vv", ["RHS_Ural_VV_01","RHS_Ural_Open_VV_01","RHS_Ural_Fuel_VV_01","RHS_BM21_VV_01","rhs_gaz66_vv","rhs_gaz66o_vv","rhs_gaz66_r142_vv","rhs_gaz66_repair_vv","rhs_gaz66_ap2_vv","rhs_gaz66_ammo_vv"]] call ALIVE_fnc_hashSet;

// rhs_vehclass_ifv
[ALIVE_factionDefaultSupports, "rhs_faction_vv", ["rhs_bmp1_vv","rhs_bmp1p_vv","rhs_bmp1k_vv","rhs_bmp1d_vv","rhs_prp3_vv","rhs_bmp2e_vv","rhs_bmp2_vv","rhs_bmp2k_vv","rhs_bmp2d_vv","rhs_brm1k_vv"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultSupplies, "rhs_faction_vv", ["rhs_bmp1_vv","rhs_bmp1p_vv","rhs_bmp1k_vv","rhs_bmp1d_vv","rhs_prp3_vv","rhs_bmp2e_vv","rhs_bmp2_vv","rhs_bmp2k_vv","rhs_bmp2d_vv","rhs_brm1k_vv"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultTransport, "rhs_faction_vv", ["rhs_bmp1_vv","rhs_bmp1p_vv","rhs_bmp1k_vv","rhs_bmp1d_vv","rhs_prp3_vv","rhs_bmp2e_vv","rhs_bmp2_vv","rhs_bmp2k_vv","rhs_bmp2d_vv","rhs_brm1k_vv"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultAirTransport, "rhs_faction_vv", ["rhs_bmp1_vv","rhs_bmp1p_vv","rhs_bmp1k_vv","rhs_bmp1d_vv","rhs_prp3_vv","rhs_bmp2e_vv","rhs_bmp2_vv","rhs_bmp2k_vv","rhs_bmp2d_vv","rhs_brm1k_vv"]] call ALIVE_fnc_hashSet;

// rhs_vehclass_apc
[ALIVE_factionDefaultSupports, "rhs_faction_vv", ["rhs_btr70_vv","rhs_btr80_vv","rhs_btr80a_vv","rhs_btr60_vv"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultSupplies, "rhs_faction_vv", ["rhs_btr70_vv","rhs_btr80_vv","rhs_btr80a_vv","rhs_btr60_vv"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultTransport, "rhs_faction_vv", ["rhs_btr70_vv","rhs_btr80_vv","rhs_btr80a_vv","rhs_btr60_vv"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultAirTransport, "rhs_faction_vv", ["rhs_btr70_vv","rhs_btr80_vv","rhs_btr80a_vv","rhs_btr60_vv"]] call ALIVE_fnc_hashSet;



// rhs_faction_vpvo

rhs_faction_vpvo_mappings = [] call ALIVE_fnc_hashCreate;

rhs_faction_vpvo_factionCustomGroups = [] call ALIVE_fnc_hashCreate;

[rhs_faction_vpvo_mappings, "Side", "EAST"] call ALIVE_fnc_hashSet;
[rhs_faction_vpvo_mappings, "GroupSideName", "EAST"] call ALIVE_fnc_hashSet;
[rhs_faction_vpvo_mappings, "FactionName", "rhs_faction_vpvo"] call ALIVE_fnc_hashSet;
[rhs_faction_vpvo_mappings, "GroupFactionName", "rhs_faction_vpvo"] call ALIVE_fnc_hashSet;

rhs_faction_vpvo_typeMappings = [] call ALIVE_fnc_hashCreate;

[rhs_faction_vpvo_mappings, "GroupFactionTypes", rhs_faction_vpvo_typeMappings] call ALIVE_fnc_hashSet;

rhs_faction_vpvo_typeMappings, "Air", "Air"] call ALIVE_fnc_hashSet;
rhs_faction_vpvo_typeMappings, "Armored", "Armored"] call ALIVE_fnc_hashSet;
rhs_faction_vpvo_typeMappings, "Infantry", "Infantry"] call ALIVE_fnc_hashSet;
rhs_faction_vpvo_typeMappings, "Mechanized", "Mechanized"] call ALIVE_fnc_hashSet;
rhs_faction_vpvo_typeMappings, "Motorized", "Motorized"] call ALIVE_fnc_hashSet;
rhs_faction_vpvo_typeMappings, "Motorized_MTP", "Motorized_MTP"] call ALIVE_fnc_hashSet;
rhs_faction_vpvo_typeMappings, "SpecOps", "SpecOps"] call ALIVE_fnc_hashSet;
rhs_faction_vpvo_typeMappings, "Support", "Support"] call ALIVE_fnc_hashSet;

[rhs_faction_vpvo_mappings, "Groups", rhs_faction_vpvo_factionCustomGroups] call ALIVE_fnc_hashSet;

[ALIVE_factionCustomMappings, "rhs_faction_vpvo", rhs_faction_vpvo_mappings] call ALIVE_fnc_hashSet;

// rhs_vehclass_radar
[ALIVE_factionDefaultSupports, "rhs_faction_vpvo", ["rhs_p37","rhs_prv13","rhs_2P3_1","rhs_2P3_2","rhs_v2","rhs_v3"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultSupplies, "rhs_faction_vpvo", ["rhs_p37","rhs_prv13","rhs_2P3_1","rhs_2P3_2","rhs_v2","rhs_v3"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultTransport, "rhs_faction_vpvo", ["rhs_p37","rhs_prv13","rhs_2P3_1","rhs_2P3_2","rhs_v2","rhs_v3"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultAirTransport, "rhs_faction_vpvo", ["rhs_p37","rhs_prv13","rhs_2P3_1","rhs_2P3_2","rhs_v2","rhs_v3"]] call ALIVE_fnc_hashSet;

// rhs_vehclass_aa
[ALIVE_factionDefaultSupports, "rhs_faction_vpvo", ["rhs_zsu234_aa"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultSupplies, "rhs_faction_vpvo", ["rhs_zsu234_aa"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultTransport, "rhs_faction_vpvo", ["rhs_zsu234_aa"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultAirTransport, "rhs_faction_vpvo", ["rhs_zsu234_aa"]] call ALIVE_fnc_hashSet;



// rhs_faction_vvs

rhs_faction_vvs_mappings = [] call ALIVE_fnc_hashCreate;

rhs_faction_vvs_factionCustomGroups = [] call ALIVE_fnc_hashCreate;

[rhs_faction_vvs_mappings, "Side", "EAST"] call ALIVE_fnc_hashSet;
[rhs_faction_vvs_mappings, "GroupSideName", "EAST"] call ALIVE_fnc_hashSet;
[rhs_faction_vvs_mappings, "FactionName", "rhs_faction_vvs"] call ALIVE_fnc_hashSet;
[rhs_faction_vvs_mappings, "GroupFactionName", "rhs_faction_vvs"] call ALIVE_fnc_hashSet;

rhs_faction_vvs_typeMappings = [] call ALIVE_fnc_hashCreate;

[rhs_faction_vvs_mappings, "GroupFactionTypes", rhs_faction_vvs_typeMappings] call ALIVE_fnc_hashSet;

rhs_faction_vvs_typeMappings, "Air", "Air"] call ALIVE_fnc_hashSet;
rhs_faction_vvs_typeMappings, "Armored", "Armored"] call ALIVE_fnc_hashSet;
rhs_faction_vvs_typeMappings, "Infantry", "Infantry"] call ALIVE_fnc_hashSet;
rhs_faction_vvs_typeMappings, "Mechanized", "Mechanized"] call ALIVE_fnc_hashSet;
rhs_faction_vvs_typeMappings, "Motorized", "Motorized"] call ALIVE_fnc_hashSet;
rhs_faction_vvs_typeMappings, "Motorized_MTP", "Motorized_MTP"] call ALIVE_fnc_hashSet;
rhs_faction_vvs_typeMappings, "SpecOps", "SpecOps"] call ALIVE_fnc_hashSet;
rhs_faction_vvs_typeMappings, "Support", "Support"] call ALIVE_fnc_hashSet;

[rhs_faction_vvs_mappings, "Groups", rhs_faction_vvs_factionCustomGroups] call ALIVE_fnc_hashSet;

[ALIVE_factionCustomMappings, "rhs_faction_vvs", rhs_faction_vvs_mappings] call ALIVE_fnc_hashSet;

// rhs_vehclass_helicopter
[ALIVE_factionDefaultSupports, "rhs_faction_vvs", ["RHS_Mi24P_vvs","RHS_Mi24P_CAS_vvs","RHS_Mi24P_AT_vvs","RHS_Mi24V_vvs","RHS_Mi24V_FAB_vvs","RHS_Mi24V_UPK23_vvs","RHS_Mi24V_AT_vvs","RHS_Mi24Vt_vvs","RHS_Mi8mt_vvs","RHS_Mi8mt_Cargo_vvs","RHS_Mi8MTV3_vvs","RHS_Mi8MTV3_UPK23_vvs","RHS_Mi8MTV3_FAB_vvs","RHS_Mi8AMT_vvs","RHS_Mi8AMTSh_vvs","RHS_Mi8AMTSh_UPK23_vvs","RHS_Mi8AMTSh_FAB_vvs","RHS_Ka52_vvs","RHS_Ka52_UPK23_vvs","rhs_ka60_grey"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultSupplies, "rhs_faction_vvs", ["RHS_Mi24P_vvs","RHS_Mi24P_CAS_vvs","RHS_Mi24P_AT_vvs","RHS_Mi24V_vvs","RHS_Mi24V_FAB_vvs","RHS_Mi24V_UPK23_vvs","RHS_Mi24V_AT_vvs","RHS_Mi24Vt_vvs","RHS_Mi8mt_vvs","RHS_Mi8mt_Cargo_vvs","RHS_Mi8MTV3_vvs","RHS_Mi8MTV3_UPK23_vvs","RHS_Mi8MTV3_FAB_vvs","RHS_Mi8AMT_vvs","RHS_Mi8AMTSh_vvs","RHS_Mi8AMTSh_UPK23_vvs","RHS_Mi8AMTSh_FAB_vvs","RHS_Ka52_vvs","RHS_Ka52_UPK23_vvs","rhs_ka60_grey"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultTransport, "rhs_faction_vvs", ["RHS_Mi24P_vvs","RHS_Mi24P_CAS_vvs","RHS_Mi24P_AT_vvs","RHS_Mi24V_vvs","RHS_Mi24V_FAB_vvs","RHS_Mi24V_UPK23_vvs","RHS_Mi24V_AT_vvs","RHS_Mi24Vt_vvs","RHS_Mi8mt_vvs","RHS_Mi8mt_Cargo_vvs","RHS_Mi8MTV3_vvs","RHS_Mi8MTV3_UPK23_vvs","RHS_Mi8MTV3_FAB_vvs","RHS_Mi8AMT_vvs","RHS_Mi8AMTSh_vvs","RHS_Mi8AMTSh_UPK23_vvs","RHS_Mi8AMTSh_FAB_vvs","RHS_Ka52_vvs","RHS_Ka52_UPK23_vvs","rhs_ka60_grey"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultAirTransport, "rhs_faction_vvs", ["RHS_Mi24P_vvs","RHS_Mi24P_CAS_vvs","RHS_Mi24P_AT_vvs","RHS_Mi24V_vvs","RHS_Mi24V_FAB_vvs","RHS_Mi24V_UPK23_vvs","RHS_Mi24V_AT_vvs","RHS_Mi24Vt_vvs","RHS_Mi8mt_vvs","RHS_Mi8mt_Cargo_vvs","RHS_Mi8MTV3_vvs","RHS_Mi8MTV3_UPK23_vvs","RHS_Mi8MTV3_FAB_vvs","RHS_Mi8AMT_vvs","RHS_Mi8AMTSh_vvs","RHS_Mi8AMTSh_UPK23_vvs","RHS_Mi8AMTSh_FAB_vvs","RHS_Ka52_vvs","RHS_Ka52_UPK23_vvs","rhs_ka60_grey"]] call ALIVE_fnc_hashSet;

// rhs_vehclass_aircraft
[ALIVE_factionDefaultSupports, "rhs_faction_vvs", ["RHS_Su25SM_vvs","RHS_Su25SM_KH29_vvs","RHS_T50_vvs_generic","RHS_T50_vvs_051","RHS_T50_vvs_052","RHS_T50_vvs_053","RHS_T50_vvs_054","RHS_T50_vvs_055"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultSupplies, "rhs_faction_vvs", ["RHS_Su25SM_vvs","RHS_Su25SM_KH29_vvs","RHS_T50_vvs_generic","RHS_T50_vvs_051","RHS_T50_vvs_052","RHS_T50_vvs_053","RHS_T50_vvs_054","RHS_T50_vvs_055"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultTransport, "rhs_faction_vvs", ["RHS_Su25SM_vvs","RHS_Su25SM_KH29_vvs","RHS_T50_vvs_generic","RHS_T50_vvs_051","RHS_T50_vvs_052","RHS_T50_vvs_053","RHS_T50_vvs_054","RHS_T50_vvs_055"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultAirTransport, "rhs_faction_vvs", ["RHS_Su25SM_vvs","RHS_Su25SM_KH29_vvs","RHS_T50_vvs_generic","RHS_T50_vvs_051","RHS_T50_vvs_052","RHS_T50_vvs_053","RHS_T50_vvs_054","RHS_T50_vvs_055"]] call ALIVE_fnc_hashSet;

// Autonomous
[ALIVE_factionDefaultSupports, "rhs_faction_vvs", ["rhs_pchela1t_vvs"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultSupplies, "rhs_faction_vvs", ["rhs_pchela1t_vvs"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultTransport, "rhs_faction_vvs", ["rhs_pchela1t_vvs"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultAirTransport, "rhs_faction_vvs", ["rhs_pchela1t_vvs"]] call ALIVE_fnc_hashSet;



// rhs_faction_vvs_c

rhs_faction_vvs_c_mappings = [] call ALIVE_fnc_hashCreate;

rhs_faction_vvs_c_factionCustomGroups = [] call ALIVE_fnc_hashCreate;

[rhs_faction_vvs_c_mappings, "Side", "EAST"] call ALIVE_fnc_hashSet;
[rhs_faction_vvs_c_mappings, "GroupSideName", "EAST"] call ALIVE_fnc_hashSet;
[rhs_faction_vvs_c_mappings, "FactionName", "rhs_faction_vvs_c"] call ALIVE_fnc_hashSet;
[rhs_faction_vvs_c_mappings, "GroupFactionName", "rhs_faction_vvs_c"] call ALIVE_fnc_hashSet;

rhs_faction_vvs_c_typeMappings = [] call ALIVE_fnc_hashCreate;

[rhs_faction_vvs_c_mappings, "GroupFactionTypes", rhs_faction_vvs_c_typeMappings] call ALIVE_fnc_hashSet;

rhs_faction_vvs_c_typeMappings, "Air", "Air"] call ALIVE_fnc_hashSet;
rhs_faction_vvs_c_typeMappings, "Armored", "Armored"] call ALIVE_fnc_hashSet;
rhs_faction_vvs_c_typeMappings, "Infantry", "Infantry"] call ALIVE_fnc_hashSet;
rhs_faction_vvs_c_typeMappings, "Mechanized", "Mechanized"] call ALIVE_fnc_hashSet;
rhs_faction_vvs_c_typeMappings, "Motorized", "Motorized"] call ALIVE_fnc_hashSet;
rhs_faction_vvs_c_typeMappings, "Motorized_MTP", "Motorized_MTP"] call ALIVE_fnc_hashSet;
rhs_faction_vvs_c_typeMappings, "SpecOps", "SpecOps"] call ALIVE_fnc_hashSet;
rhs_faction_vvs_c_typeMappings, "Support", "Support"] call ALIVE_fnc_hashSet;

[rhs_faction_vvs_c_mappings, "Groups", rhs_faction_vvs_c_factionCustomGroups] call ALIVE_fnc_hashSet;

[ALIVE_factionCustomMappings, "rhs_faction_vvs_c", rhs_faction_vvs_c_mappings] call ALIVE_fnc_hashSet;

// rhs_vehclass_helicopter
[ALIVE_factionDefaultSupports, "rhs_faction_vvs_c", ["RHS_Mi24P_vvsc","RHS_Mi24P_CAS_vvsc","RHS_Mi24P_AT_vvsc","RHS_Mi24V_vvsc","RHS_Mi24V_FAB_vvsc","RHS_Mi24V_UPK23_vvsc","RHS_Mi24V_AT_vvsc","RHS_Mi8mt_vvsc","RHS_Mi8mt_Cargo_vvsc","RHS_Mi8MTV3_vvsc","RHS_Mi8MTV3_UPK23_vvsc","RHS_Mi8MTV3_FAB_vvsc","RHS_Mi8AMT_vvsc","RHS_Mi8AMTSh_vvsc","RHS_Mi8AMTSh_UPK23_vvsc","RHS_Mi8AMTSh_FAB_vvsc","RHS_Ka52_vvsc","RHS_Ka52_UPK23_vvsc","rhs_ka60_c"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultSupplies, "rhs_faction_vvs_c", ["RHS_Mi24P_vvsc","RHS_Mi24P_CAS_vvsc","RHS_Mi24P_AT_vvsc","RHS_Mi24V_vvsc","RHS_Mi24V_FAB_vvsc","RHS_Mi24V_UPK23_vvsc","RHS_Mi24V_AT_vvsc","RHS_Mi8mt_vvsc","RHS_Mi8mt_Cargo_vvsc","RHS_Mi8MTV3_vvsc","RHS_Mi8MTV3_UPK23_vvsc","RHS_Mi8MTV3_FAB_vvsc","RHS_Mi8AMT_vvsc","RHS_Mi8AMTSh_vvsc","RHS_Mi8AMTSh_UPK23_vvsc","RHS_Mi8AMTSh_FAB_vvsc","RHS_Ka52_vvsc","RHS_Ka52_UPK23_vvsc","rhs_ka60_c"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultTransport, "rhs_faction_vvs_c", ["RHS_Mi24P_vvsc","RHS_Mi24P_CAS_vvsc","RHS_Mi24P_AT_vvsc","RHS_Mi24V_vvsc","RHS_Mi24V_FAB_vvsc","RHS_Mi24V_UPK23_vvsc","RHS_Mi24V_AT_vvsc","RHS_Mi8mt_vvsc","RHS_Mi8mt_Cargo_vvsc","RHS_Mi8MTV3_vvsc","RHS_Mi8MTV3_UPK23_vvsc","RHS_Mi8MTV3_FAB_vvsc","RHS_Mi8AMT_vvsc","RHS_Mi8AMTSh_vvsc","RHS_Mi8AMTSh_UPK23_vvsc","RHS_Mi8AMTSh_FAB_vvsc","RHS_Ka52_vvsc","RHS_Ka52_UPK23_vvsc","rhs_ka60_c"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultAirTransport, "rhs_faction_vvs_c", ["RHS_Mi24P_vvsc","RHS_Mi24P_CAS_vvsc","RHS_Mi24P_AT_vvsc","RHS_Mi24V_vvsc","RHS_Mi24V_FAB_vvsc","RHS_Mi24V_UPK23_vvsc","RHS_Mi24V_AT_vvsc","RHS_Mi8mt_vvsc","RHS_Mi8mt_Cargo_vvsc","RHS_Mi8MTV3_vvsc","RHS_Mi8MTV3_UPK23_vvsc","RHS_Mi8MTV3_FAB_vvsc","RHS_Mi8AMT_vvsc","RHS_Mi8AMTSh_vvsc","RHS_Mi8AMTSh_UPK23_vvsc","RHS_Mi8AMTSh_FAB_vvsc","RHS_Ka52_vvsc","RHS_Ka52_UPK23_vvsc","rhs_ka60_c"]] call ALIVE_fnc_hashSet;

// rhs_vehclass_aircraft
[ALIVE_factionDefaultSupports, "rhs_faction_vvs_c", ["RHS_Su25SM_vvsc","RHS_Su25SM_KH29_vvsc"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultSupplies, "rhs_faction_vvs_c", ["RHS_Su25SM_vvsc","RHS_Su25SM_KH29_vvsc"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultTransport, "rhs_faction_vvs_c", ["RHS_Su25SM_vvsc","RHS_Su25SM_KH29_vvsc"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultAirTransport, "rhs_faction_vvs_c", ["RHS_Su25SM_vvsc","RHS_Su25SM_KH29_vvsc"]] call ALIVE_fnc_hashSet;

// Autonomous
[ALIVE_factionDefaultSupports, "rhs_faction_vvs_c", ["rhs_pchela1t_vvsc"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultSupplies, "rhs_faction_vvs_c", ["rhs_pchela1t_vvsc"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultTransport, "rhs_faction_vvs_c", ["rhs_pchela1t_vvsc"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultAirTransport, "rhs_faction_vvs_c", ["rhs_pchela1t_vvsc"]] call ALIVE_fnc_hashSet;



// rhs_faction_rva

rhs_faction_rva_mappings = [] call ALIVE_fnc_hashCreate;

rhs_faction_rva_factionCustomGroups = [] call ALIVE_fnc_hashCreate;

[rhs_faction_rva_mappings, "Side", "EAST"] call ALIVE_fnc_hashSet;
[rhs_faction_rva_mappings, "GroupSideName", "EAST"] call ALIVE_fnc_hashSet;
[rhs_faction_rva_mappings, "FactionName", "rhs_faction_rva"] call ALIVE_fnc_hashSet;
[rhs_faction_rva_mappings, "GroupFactionName", "rhs_faction_rva"] call ALIVE_fnc_hashSet;

rhs_faction_rva_typeMappings = [] call ALIVE_fnc_hashCreate;

[rhs_faction_rva_mappings, "GroupFactionTypes", rhs_faction_rva_typeMappings] call ALIVE_fnc_hashSet;

rhs_faction_rva_typeMappings, "Air", "Air"] call ALIVE_fnc_hashSet;
rhs_faction_rva_typeMappings, "Armored", "Armored"] call ALIVE_fnc_hashSet;
rhs_faction_rva_typeMappings, "Infantry", "Infantry"] call ALIVE_fnc_hashSet;
rhs_faction_rva_typeMappings, "Mechanized", "Mechanized"] call ALIVE_fnc_hashSet;
rhs_faction_rva_typeMappings, "Motorized", "Motorized"] call ALIVE_fnc_hashSet;
rhs_faction_rva_typeMappings, "Motorized_MTP", "Motorized_MTP"] call ALIVE_fnc_hashSet;
rhs_faction_rva_typeMappings, "SpecOps", "SpecOps"] call ALIVE_fnc_hashSet;
rhs_faction_rva_typeMappings, "Support", "Support"] call ALIVE_fnc_hashSet;

[rhs_faction_rva_mappings, "Groups", rhs_faction_rva_factionCustomGroups] call ALIVE_fnc_hashSet;

[ALIVE_factionCustomMappings, "rhs_faction_rva", rhs_faction_rva_mappings] call ALIVE_fnc_hashSet;

// rhs_vehclass_artillery
[ALIVE_factionDefaultSupports, "rhs_faction_rva", ["rhs_9k79","rhs_9k79_K","rhs_9k79_B"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultSupplies, "rhs_faction_rva", ["rhs_9k79","rhs_9k79_K","rhs_9k79_B"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultTransport, "rhs_faction_rva", ["rhs_9k79","rhs_9k79_K","rhs_9k79_B"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultAirTransport, "rhs_faction_rva", ["rhs_9k79","rhs_9k79_K","rhs_9k79_B"]] call ALIVE_fnc_hashSet;
*/


// ------------------------------------------------------------------------------------------------------------------



// RHS Insurgents -----------------------------------------------------------------------------------------------------

// rhs_faction_insurgents

rhs_faction_insurgents_mappings = [] call ALIVE_fnc_hashCreate;

rhs_faction_insurgents_factionCustomGroups = [] call ALIVE_fnc_hashCreate;

[rhs_faction_insurgents_mappings, "Side", "GUER"] call ALIVE_fnc_hashSet;
[rhs_faction_insurgents_mappings, "GroupSideName", "GUER"] call ALIVE_fnc_hashSet;
[rhs_faction_insurgents_mappings, "FactionName", "rhs_faction_insurgents"] call ALIVE_fnc_hashSet;
[rhs_faction_insurgents_mappings, "GroupFactionName", "rhs_faction_insurgents"] call ALIVE_fnc_hashSet;

rhs_faction_insurgents_typeMappings = [] call ALIVE_fnc_hashCreate;

[rhs_faction_insurgents_mappings, "GroupFactionTypes", rhs_faction_insurgents_typeMappings] call ALIVE_fnc_hashSet;


[rhs_faction_insurgents_typeMappings, "Infantry", ["IRG_InfSquad","IRG_InfSquad_Weapons","IRG_InfTeam","IRG_InfTeam_AT","IRG_InfTeam_MG","IRG_InfSentry","IRG_ReconSentry","IRG_SniperTeam_M","IRG_Support_CLS"]] call ALIVE_fnc_hashSet;
[rhs_faction_insurgents_typeMappings, "Motorized", ["BUS_MotInf_Team_GMG","BUS_MotInf_Team_HMG","BUS_MotInf_AT","BUS_MotInf_AA","rhs_group_chdkz_ural_chq","rhs_group_chdkz_ural_squad","rhs_group_chdkz_ural_squad_2mg","rhs_group_chdkz_ural_squad_sniper","rhs_group_chdkz_ural_squad_mg_sniper","rhs_group_chdkz_ural_squad_aa"]] call ALIVE_fnc_hashSet;
[rhs_faction_insurgents_typeMappings, "Mechanized", ["rhs_group_chdkz_btr60_chq","rhs_group_chdkz_btr60_squad","rhs_group_chdkz_btr60_squad_2mg","rhs_group_chdkz_btr60_squad_sniper","rhs_group_chdkz_btr60_squad_mg_sniper","rhs_group_chdkz_btr60_squad_aa","rhs_group_chdkz_btr70_chq","rhs_group_chdkz_btr70_squad","rhs_group_chdkz_btr70_squad_2mg","rhs_group_chdkz_btr70_squad_sniper","rhs_group_chdkz_btr70_squad_mg_sniper","rhs_group_chdkz_btr70_squad_aa","rhs_group_rus_ins_bmd1_chq","rhs_group_rus_ins_bmd1_squad","rhs_group_rus_ins_bmd1_squad_2mg","rhs_group_rus_ins_bmd1_squad_sniper","rhs_group_rus_ins_bmd1_squad_mg_sniper","rhs_group_rus_ins_bmd1_squad_aa","rhs_group_rus_ins_bmd2_chq","rhs_group_rus_ins_bmd2_squad","rhs_group_rus_ins_bmd2_squad_2mg","rhs_group_rus_ins_bmd2_squad_sniper","rhs_group_rus_ins_bmd2_squad_mg_sniper","rhs_group_rus_ins_bmd2_squad_aa","rhs_group_indp_ins_bmp1_chq","rhs_group_indp_ins_bmp1_squad","rhs_group_indp_ins_bmp1_squad_2mg","rhs_group_indp_ins_bmp1_squad_sniper","rhs_group_indp_ins_bmp1_squad_mg_sniper","rhs_group_indp_ins_bmp1_squad_aa","rhs_group_indp_ins_bmp2_chq","rhs_group_indp_ins_bmp2_squad","rhs_group_indp_ins_bmp2_squad_2mg","rhs_group_indp_ins_bmp2_squad_sniper","rhs_group_indp_ins_bmp2_squad_mg_sniper","rhs_group_indp_ins_bmp2_squad_aa"]] call ALIVE_fnc_hashSet;
[rhs_faction_insurgents_typeMappings, "Artillery", ["RHS_SPGPlatoon_ins_bm21","RHS_SPGSection_ins_bm21"]] call ALIVE_fnc_hashSet;
[rhs_faction_insurgents_typeMappings, "Armored", ["RHS_T72BBPlatoon","RHS_T72BBPlatoon_AA","RHS_T72BBSection"]] call ALIVE_fnc_hashSet;

[rhs_faction_insurgents_mappings, "Groups", rhs_faction_insurgents_factionCustomGroups] call ALIVE_fnc_hashSet;

[ALIVE_factionCustomMappings, "rhs_faction_insurgents", rhs_faction_insurgents_mappings] call ALIVE_fnc_hashSet;

[ALIVE_factionDefaultSupports, "rhs_faction_insurgents", ["RHS_UAZ_chdkz","rhs_uaz_open_chdkz","rhs_uaz_dshkm_chdkz","rhs_uaz_ags_chdkz","rhs_uaz_spg9_chdkz","rhs_ural_open_chdkz","rhs_ural_work_chdkz","rhs_ural_work_open_chdkz","RHS_BM21_chdkz","rhs_zsu234_chdkz"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultTransport, "rhs_faction_insurgents", ["RHS_UAZ_chdkz","rhs_uaz_open_chdkz","rhs_ural_chdkz","rhs_ural_open_chdkz","rhs_ural_work_chdkz","rhs_ural_work_open_chdkz"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultAirTransport, "rhs_faction_insurgents", ["RHS_Mi8amt_chdkz"]] call ALIVE_fnc_hashSet;

/*
// rhs_vehclass_car
[ALIVE_factionDefaultSupports, "rhs_faction_insurgents", ["RHS_UAZ_chdkz","rhs_uaz_open_chdkz","rhs_uaz_dshkm_chdkz","rhs_uaz_ags_chdkz","rhs_uaz_spg9_chdkz"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultSupplies, "rhs_faction_insurgents", ["RHS_UAZ_chdkz","rhs_uaz_open_chdkz","rhs_uaz_dshkm_chdkz","rhs_uaz_ags_chdkz","rhs_uaz_spg9_chdkz"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultTransport, "rhs_faction_insurgents", ["RHS_UAZ_chdkz","rhs_uaz_open_chdkz","rhs_uaz_dshkm_chdkz","rhs_uaz_ags_chdkz","rhs_uaz_spg9_chdkz"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultAirTransport, "rhs_faction_insurgents", ["RHS_UAZ_chdkz","rhs_uaz_open_chdkz","rhs_uaz_dshkm_chdkz","rhs_uaz_ags_chdkz","rhs_uaz_spg9_chdkz"]] call ALIVE_fnc_hashSet;

// rhs_vehclass_artillery
[ALIVE_factionDefaultSupports, "rhs_faction_insurgents", ["RHS_BM21_chdkz"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultSupplies, "rhs_faction_insurgents", ["RHS_BM21_chdkz"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultTransport, "rhs_faction_insurgents", ["RHS_BM21_chdkz"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultAirTransport, "rhs_faction_insurgents", ["RHS_BM21_chdkz"]] call ALIVE_fnc_hashSet;

// rhs_vehclass_helicopter
[ALIVE_factionDefaultSupports, "rhs_faction_insurgents", ["RHS_Mi8amt_chdkz"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultSupplies, "rhs_faction_insurgents", ["RHS_Mi8amt_chdkz"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultTransport, "rhs_faction_insurgents", ["RHS_Mi8amt_chdkz"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultAirTransport, "rhs_faction_insurgents", ["RHS_Mi8amt_chdkz"]] call ALIVE_fnc_hashSet;

// rhs_vehclass_truck
[ALIVE_factionDefaultSupports, "rhs_faction_insurgents", ["rhs_ural_chdkz","rhs_ural_open_chdkz","rhs_ural_work_chdkz","rhs_ural_work_open_chdkz","RHS_BM21_chdkz"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultSupplies, "rhs_faction_insurgents", ["rhs_ural_chdkz","rhs_ural_open_chdkz","rhs_ural_work_chdkz","rhs_ural_work_open_chdkz","RHS_BM21_chdkz"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultTransport, "rhs_faction_insurgents", ["rhs_ural_chdkz","rhs_ural_open_chdkz","rhs_ural_work_chdkz","rhs_ural_work_open_chdkz","RHS_BM21_chdkz"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultAirTransport, "rhs_faction_insurgents", ["rhs_ural_chdkz","rhs_ural_open_chdkz","rhs_ural_work_chdkz","rhs_ural_work_open_chdkz","RHS_BM21_chdkz"]] call ALIVE_fnc_hashSet;

// rhs_vehclass_aa
[ALIVE_factionDefaultSupports, "rhs_faction_insurgents", ["rhs_zsu234_chdkz"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultSupplies, "rhs_faction_insurgents", ["rhs_zsu234_chdkz"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultTransport, "rhs_faction_insurgents", ["rhs_zsu234_chdkz"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultAirTransport, "rhs_faction_insurgents", ["rhs_zsu234_chdkz"]] call ALIVE_fnc_hashSet;

// rhs_vehclass_ifv
[ALIVE_factionDefaultSupports, "rhs_faction_insurgents", ["rhs_bmd1_chdkz","rhs_bmd2_chdkz","rhs_bmp1_chdkz","rhs_bmp1p_chdkz","rhs_bmp1d_chdkz","rhs_bmp1k_chdkz","rhs_bmp2_chdkz","rhs_bmp2e_chdkz","rhs_bmp2k_chdkz","rhs_bmp2d_chdkz"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultSupplies, "rhs_faction_insurgents", ["rhs_bmd1_chdkz","rhs_bmd2_chdkz","rhs_bmp1_chdkz","rhs_bmp1p_chdkz","rhs_bmp1d_chdkz","rhs_bmp1k_chdkz","rhs_bmp2_chdkz","rhs_bmp2e_chdkz","rhs_bmp2k_chdkz","rhs_bmp2d_chdkz"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultTransport, "rhs_faction_insurgents", ["rhs_bmd1_chdkz","rhs_bmd2_chdkz","rhs_bmp1_chdkz","rhs_bmp1p_chdkz","rhs_bmp1d_chdkz","rhs_bmp1k_chdkz","rhs_bmp2_chdkz","rhs_bmp2e_chdkz","rhs_bmp2k_chdkz","rhs_bmp2d_chdkz"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultAirTransport, "rhs_faction_insurgents", ["rhs_bmd1_chdkz","rhs_bmd2_chdkz","rhs_bmp1_chdkz","rhs_bmp1p_chdkz","rhs_bmp1d_chdkz","rhs_bmp1k_chdkz","rhs_bmp2_chdkz","rhs_bmp2e_chdkz","rhs_bmp2k_chdkz","rhs_bmp2d_chdkz"]] call ALIVE_fnc_hashSet;

// rhs_vehclass_apc
[ALIVE_factionDefaultSupports, "rhs_faction_insurgents", ["rhs_btr60_chdkz","rhs_btr70_chdkz"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultSupplies, "rhs_faction_insurgents", ["rhs_btr60_chdkz","rhs_btr70_chdkz"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultTransport, "rhs_faction_insurgents", ["rhs_btr60_chdkz","rhs_btr70_chdkz"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultAirTransport, "rhs_faction_insurgents", ["rhs_btr60_chdkz","rhs_btr70_chdkz"]] call ALIVE_fnc_hashSet;

// rhs_vehclass_tank
[ALIVE_factionDefaultSupports, "rhs_faction_insurgents", ["rhs_t72bb_chdkz"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultSupplies, "rhs_faction_insurgents", ["rhs_t72bb_chdkz"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultTransport, "rhs_faction_insurgents", ["rhs_t72bb_chdkz"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultAirTransport, "rhs_faction_insurgents", ["rhs_t72bb_chdkz"]] call ALIVE_fnc_hashSet;
*/


// ---------------------------------------------------------------------------------------------------------------------