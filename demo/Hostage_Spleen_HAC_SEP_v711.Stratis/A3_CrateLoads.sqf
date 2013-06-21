/*
null = [this, "A3B_Full"] call compile preprocessFile "vScripts\A3_CrateLoads.sqf";

Case IDs:  Javelin, Dragon, AllItems, Sniper, Launchers, Ordnance, ArtyM252, Rope, Mounted, AllWeaponsItems, LimitedRocket, Limited, HeavyMachineGun, pistols

*/
 
_crate = _this select 0;
_strLoadout = _this select 1;
 
clearMagazineCargo _crate;
clearWeaponCargo _crate;
 
switch (_strLoadout) do {

// Blufor Weapons, Ammo, Items, Backpacks, and other
	case "A3B_Sniper":
	{
// Sniper Rifles		
		_crate addWeaponCargo ["srifle_GM6_SOS_F",2];
		_crate addWeaponCargo ["srifle_LRR_SOS_F",2];
		_crate addWeaponCargo ["srifle_LRR_F",2];
		_crate addWeaponCargo ["srifle_GM6_F",2];
		_crate addWeaponCargo ["srifle_EBR_Hamr_F",2];
		_crate addWeaponCargo ["srifle_EBR_ARCO_F",2];
		_crate addWeaponCargo ["srifle_EBR_ACOg_F",2];
		_crate addWeaponCargo ["srifle_EBR_Holo_F",2];
		_crate addWeaponCargo ["srifle_EBR_ACO_F",2];
		_crate addWeaponCargo ["srifle_EBR_F",2];
		// _crate addWeaponCargo ["srifle_EBR_Hamr_point_F",2];
		// _crate addWeaponCargo ["srifle_EBR_ARCO_point_F",2];
		// _crate addWeaponCargo ["srifle_EBR_ACOg_point_F",2];
		// _crate addWeaponCargo ["srifle_EBR_Holo_point_F",2];
		// _crate addWeaponCargo ["srifle_EBR_ACO_point_F",2];

// Ammo
		_crate addMagazineCargo ["5Rnd_127x108_Mag",25];
		_crate addMagazineCargo ["7rnd_408_mag",25];
		_crate addMagazineCargo ["20rnd_762x51_mag",25];

// Weapon Optics, Silencers, and IR/Flash light Items
		_crate addItemCargo ["acc_flashlight",10];
		_crate addItemCargo ["acc_pointer_IR",10];
		_crate addItemCargo ["muzzle_snds_H",10];
		_crate addItemCargo ["muzzle_snds_B",10];
		_crate addItemCargo ["muzzle_snds_L",10];
		_crate addItemCargo ["muzzle_snds_H_MG",10];
		_crate addItemCargo ["muzzle_snds_L",5];
		_crate addItemCargo ["optic_Arco",5];
		_crate addItemCargo ["optic_Hamr",5];
		_crate addItemCargo ["optic_Holosight",5];
		_crate addItemCargo ["optic_Aco",5];
		_crate addItemCargo ["optic_ACO_grn",5];
		_crate addItemCargo ["optic_SOS",3];
		// _crate addItemCargo ["optic_scop",2];
		// _crate addItemCargo ["optic_scop_Bors",2];

	};
	case "A3B_HandGuns":
	{
// Hand Guns		
		_crate addWeaponCargo ["hgun_P07_F",2];
		_crate addWeaponCargo ["hgun_P07_snds_F",2];
		_crate addWeaponCargo ["arifle_SDAR_F",2];
		_crate addWeaponCargo ["launch_NLAW_F",2];
// Ammo
		_crate addMagazineCargo ["16Rnd_9x21_Mag",10];
		_crate addMagazineCargo ["30Rnd_9x21_Mag",12];
	};
	
	case "A3B_Rifles":
	{
// Hand Guns		
		_crate addWeaponCargo ["hgun_P07_F",2];
		_crate addWeaponCargo ["hgun_P07_snds_F",2];
		_crate addWeaponCargo ["arifle_SDAR_F",2];
		_crate addWeaponCargo ["launch_NLAW_F",2];
// Ammo
		_crate addMagazineCargo ["16Rnd_9x21_Mag",10];
		_crate addMagazineCargo ["30Rnd_9x21_Mag",12];

// Assault Rifles
		_crate addWeaponCargo ["arifle_TRG20_F",2];
		_crate addWeaponCargo ["arifle_TRG20_Holo_F",2];
		// _crate addWeaponCargo ["arifle_TRG20_Holo_mzls_F",2];
		_crate addWeaponCargo ["arifle_TRG20_Holo_point_F",2];
		_crate addWeaponCargo ["arifle_TRG20_ACOg_point_F",2];
		// _crate addWeaponCargo ["arifle_TRG20_ACOg_flash_mzls_F",2];
		_crate addWeaponCargo ["arifle_TRG20_ACOg_F",2];
		_crate addWeaponCargo ["arifle_TRG21_F",2];
		_crate addWeaponCargo ["arifle_TRG21_GL_F",2];
		_crate addWeaponCargo ["arifle_TRG21_ACOg_point_F",2];
		_crate addWeaponCargo ["arifle_TRG21_ARCO_point_F",2];
		_crate addWeaponCargo ["arifle_TRG21_GL_ACOg_point_F",2];
		// _crate addWeaponCargo ["arifle_TRG21_GL_ACOg_point_mzls_F",2];
		_crate addWeaponCargo ["arifle_MX_F",2];
		_crate addWeaponCargo ["arifle_MX_GL_F",2];
		_crate addWeaponCargo ["arifle_MX_SW_F",2];
		_crate addWeaponCargo ["arifle_MXC_F",2];
		_crate addWeaponCargo ["arifle_MXM_F",2];
		// _crate addWeaponCargo ["arifle_MX_Hamr_point_grip_F",2];
		// _crate addWeaponCargo ["arifle_MX_ACO_point_grip_F",2];
		_crate addWeaponCargo ["arifle_MX_GL_ACO_point_F",2];
		// _crate addWeaponCargo ["arifle_MX_GL_Hamr_point_mzls_F",2];
		_crate addWeaponCargo ["arifle_MXC_Holo_F",2];
		// _crate addWeaponCargo ["arifle_MXC_Holo_point_grip_F",2];
		// _crate addWeaponCargo ["arifle_MXC_Holo_point_grip_snds_F",2];
		// _crate addWeaponCargo ["arifle_MXC_ACO_point_grip_mzls_F",2];
		// _crate addWeaponCargo ["arifle_MXC_ACO_point_grip_F",2];
		// _crate addWeaponCargo ["arifle_MXC_ACO_flash_grip_mzls_F",2];
		// _crate addWeaponCargo ["arifle_MX_SW_Hamr_point_gripod_F",2];
		// _crate addWeaponCargo ["arifle_MXM_Hamr_point_gripod_F",2];

// LMG - Light Machine Guns		
		_crate addWeaponCargo ["LMG_Mk200_F",1];
		// _crate addWeaponCargo ["LMG_Mk200_ARCO_bipod_F",1];
		// _crate addWeaponCargo ["LMG_Mk200_ARCO_pointer_bipod_F",1];
		// _crate addWeaponCargo ["LMG_Mk200_ACO_grip_F",1];
		// _crate addWeaponCargo ["LMG_Mk200_ACO_point_gripf_F",1];

// AMMO
// LMG - Light Machine Guns		
		_crate addMagazineCargo ["100Rnd_65x39_caseless_mag",10];
		_crate addMagazineCargo ["100Rnd_65x39_caseless_mag_Tracer",10];
// SDAR
		_crate addMagazineCargo ["20Rnd_556x45_UW_mag",10];
		_crate addMagazineCargo ["30Rnd_556x45_Stanag",10];

//T RG20
		_crate addMagazineCargo ["30Rnd_65x39_case_mag",10];
		// _crate addMagazineCargo ["30Rnd_65x39_case_mag_Tracer",10];

// MX
		_crate addMagazineCargo ["30Rnd_65x39_caseless_mag",10];
		_crate addMagazineCargo ["30Rnd_65x39_caseless_mag_Tracer",10];

// MX200
		_crate addMagazineCargo ["200Rnd_65x39_cased_Box",10];
		_crate addMagazineCargo ["200Rnd_65x39_cased_Box_Tracer",10];

// EBR/MXM
		// _crate addMagazineCargo ["20Rnd_762x45_mag",10];
// 88 mags to here
		_crate addMagazineCargo ["DemoCharge_Remote_Mag",10];
		_crate addMagazineCargo ["MiniGrenade",10];
		_crate addMagazineCargo ["SmokeShell",10];
		_crate addMagazineCargo ["1Rnd_HE_Grenade_shell",10];
		_crate addMagazineCargo ["1Rnd_Smoke_Grenade_shell",10];
		_crate addMagazineCargo ["UGL_FlareWhite_F",15];
// ROCKET
		_crate addMagazineCargo ["NLAW_F",10];
		
	
	};	
	
	case "A3B_Ammo":
	{
// Ammo
// LMG - Light Machine Guns		
		_crate addMagazineCargo ["100Rnd_65x39_caseless_mag",10];
		_crate addMagazineCargo ["100Rnd_65x39_caseless_mag_Tracer",10];

// ROCKET
		_crate addMagazineCargo ["NLAW_F",10];

// PISTOL
		_crate addMagazineCargo ["16Rnd_9x21_Mag",10];
		_crate addMagazineCargo ["30Rnd_9x21_Mag",10];

// SDAR
		_crate addMagazineCargo ["20Rnd_556x45_UW_mag",10];
		_crate addMagazineCargo ["30Rnd_556x45_Stanag",10];

//T RG20
		_crate addMagazineCargo ["30Rnd_65x39_case_mag",10];
		// _crate addMagazineCargo ["30Rnd_65x39_case_mag_Tracer",10];

// MX
		_crate addMagazineCargo ["30Rnd_65x39_caseless_mag",10];
		_crate addMagazineCargo ["30Rnd_65x39_caseless_mag_Tracer",10];

// MX200
		_crate addMagazineCargo ["200Rnd_65x39_cased_Box",10];
		_crate addMagazineCargo ["200Rnd_65x39_cased_Box_Tracer",10];

// EBR/MXM
		// _crate addMagazineCargo ["20Rnd_762x45_mag",10];

// 88 mags to here
		_crate addMagazineCargo ["DemoCharge_Remote_Mag",10];
		_crate addMagazineCargo ["MiniGrenade",10];
		_crate addMagazineCargo ["SmokeShell",10];
		_crate addMagazineCargo ["1Rnd_HE_Grenade_shell",10];
		_crate addMagazineCargo ["1Rnd_Smoke_Grenade_shell",10];
		_crate addMagazineCargo ["UGL_FlareWhite_F",10];

	};
	
	case "A3B_Uniforms":
	{
	////////////// Helmets, Uniforms, and Other //////////////
// HELMETS
		_crate addItemCargo ["H_MilCap_ocamo",2];
		_crate addItemCargo ["H_MilCap_mcamo",2];
		_crate addItemCargo ["H_HelmetB",2];
		_crate addItemCargo ["H_PilotHelmetHeli_B",2];
		_crate addItemCargo ["H_HelmetB_paint",2];
		_crate addItemCargo ["H_HelmetB_light",2];
		_crate addItemCargo ["H_HelmetO_ocamo",2];
		_crate addItemCargo ["H_PilotHelmetHeli_O",2];

// civ clothes - Caps
		_crate addItemCargo ["H_Cap_red",2];
		_crate addItemCargo ["H_Cap_blu",2];
		_crate addItemCargo ["H_Cap_brn_SERO",2];

// UNIFORMS

//civ clothes cargo 10
		// _crate addItemCargo ["U_B_poloshirt_blue",1];
		// _crate addItemCargo ["U_B_poloshirt_burgundy",1];
		// _crate addItemCargo ["U_B_poloshirt_stripped",1];
		// _crate addItemCargo ["U_B_poloshirt_tricolour",1];
		// _crate addItemCargo ["U_B_poloshirt_salmon",1];
		// _crate addItemCargo ["U_B_poloshirt_redwhite",1];
		// _crate addItemCargo ["U_B_commoner1_1",1];
		// _crate addItemCargo ["U_B_commoner1_2",1];
		// _crate addItemCargo ["U_B_commoner1_3",1];

//cargo 20
		_crate addItemCargo ["U_B_CombatUniform_mcam",2];
		_crate addItemCargo ["U_B_CombatUniform_mcam_tshirt",2];
		_crate addItemCargo ["U_B_CombatUniform_mcam_vest",2];
		_crate addItemCargo ["U_Rangemaster",2];
		// _crate addItemCargo ["U_OI_CombatUniform_ocamo",2];

//cargo 50
		_crate addItemCargo ["U_B_HeliPilotCoveralls",2]; 
		// _crate addItemCargo ["U_OI_PilotCoveralls",2];

//cargo 90
		_crate addItemCargo ["U_B_Wetsuit",5];
		// _crate addItemCargo ["U_OI_Wetsuit",2];
		// _crate addItemCargo ["U_I_Wetsuit",2];

//VESTS
//cargo 0
		_crate addItemCargo ["V_RebreatherB",5];
		_crate addItemCargo ["V_RebreatherIR",5];
		// _crate addItemCargo ["V_RebreatherIA",1];

//cargo 10
		_crate addItemCargo ["V_Rangemaster_belt",2];

//cargo 60
		_crate addItemCargo ["V_BandollierB_rgr",2];
		_crate addItemCargo ["V_BandollierB_cbr",2];
		_crate addItemCargo ["V_BandollierB_khk",2];

//cargo 70
		// _crate addItemCargo ["V_ChestrigB_rgr",2];

//cargo 80
		_crate addItemCargo ["V_Chestrig_khk",2];

//cargo 90
		_crate addItemCargo ["V_TacVest_khk",2];
		_crate addItemCargo ["V_TacVest_brn",2];
		_crate addItemCargo ["V_TacVest_oli",2];

//cargo 100
		_crate addItemCargo ["V_PlateCarrier1_rgr",2];
		_crate addItemCargo ["V_PlateCarrier1_cbr",2];

//cargo 140
		_crate addItemCargo ["V_PlateCarrier2_rgr",2];

//cargo 150
		_crate addItemCargo ["V_PlateCarrierGL_rgr",2];

//cargo 180
		_crate addItemCargo ["V_HarnessO_brn",2];

//cargo 200
		_crate addItemCargo ["V_HarnessOGL_brn",2];

//Mk6Mortar
		_crate addBackpackCargo ["B_Mortar_01_FMortar_Wpn",2];
		_crate addBackpackCargo ["B_Mortar_01_FMortar_Support",2];

//load 240
		_crate addBackpackCargo ["B_AssaultPack_khk",1];
		_crate addBackpackCargo ["B_AssaultPack_dgtl",1];
		_crate addBackpackCargo ["B_AssaultPack_rgr",1];
		_crate addBackpackCargo ["B_AssaultPack_sgg",1];
		_crate addBackpackCargo ["B_AssaultPack_cbr",1];
		_crate addBackpackCargo ["B_AssaultPack_mcamo",1];
		_crate addBackpackCargo ["B_AssaultPack_ocamo",1];
		_crate addBackpackCargo ["B_AssaultPack_blk",1];
		_crate addBackpackCargo ["B_AssaultPack_rgr_Medic",1];
		_crate addBackpackCargo ["B_AssaultPack_rgr_Repair",1];
		_crate addBackpackCargo ["B_AssaultPack_blk_DiverExp",1];
		_crate addBackpackCargo ["B_AssaultPack_blk_DiverTL",1];

//load 250
		_crate addBackpackCargo ["B_FieldPack_blk",1];
		_crate addBackpackCargo ["B_FieldPack_ocamo",1];
		_crate addBackpackCargo ["B_FieldPack_oucamo",1];
		_crate addBackpackCargo ["B_FieldPack_cbr",1];
		_crate addBackpackCargo ["B_FieldPack_ocamo_Medic",1];
		_crate addBackpackCargo ["B_FieldPack_cbr_AT",1];
		_crate addBackpackCargo ["B_FieldPack_blk_DiverExp",1];
		_crate addBackpackCargo ["B_FieldPack_blk_DiverTL",1];

//300 load
		_crate addBackpackCargo ["B_Kitbag_mcamo",1];
		_crate addBackpackCargo ["B_Kitbag_sgg",1];
		_crate addBackpackCargo ["B_Kitbag_cbr",1];

//380 load
		_crate addBackpackCargo ["B_Bergen_sgg",1];
		_crate addBackpackCargo ["B_Bergen_sgg_Exp",1];

//420 load
		_crate addBackpackCargo ["B_Carryall_ocamo",1];
		_crate addBackpackCargo ["B_Carryall_oucamo",1];
		// _crate addBackpackCargo ["B_Carryall_oucamo_Exp",1];

	};
	
	case "A3B_Items":
	{
	// Weapon Optics, Silencers, and IR/Flash light Items
		_crate addItemCargo ["acc_flashlight",10];
		_crate addItemCargo ["acc_pointer_IR",10];
		_crate addItemCargo ["muzzle_snds_H",10];
		_crate addItemCargo ["muzzle_snds_B",10];
		_crate addItemCargo ["muzzle_snds_L",10];
		_crate addItemCargo ["muzzle_snds_H_MG",10];
		_crate addItemCargo ["optic_Arco",10];
		_crate addItemCargo ["optic_Hamr",10];
		_crate addItemCargo ["optic_Aco",10];
		_crate addItemCargo ["optic_ACO_grn",10];
		_crate addItemCargo ["optic_Holosight",10];
		_crate addItemCargo ["muzzle_snds_L",10];

// Repair and Health Kits
		_crate addItemCargo ["FirstAidKit",20];
		_crate addItemCargo ["Medikit",10];
		_crate addItemCargo ["ToolKit",10];

// Misc Items
		_crate addItemCargo ["ItemWatch",10];
		_crate addItemCargo ["ItemCompass",10];
		_crate addItemCargo ["ItemGPS",10];
		_crate addItemCargo ["ItemRadio",10];
		_crate addItemCargo ["ItemMap",10];
		_crate addItemCargo ["MineDetector",10];
		_crate addWeaponCargo ["Binocular",10];
		_crate addItemCargo ["NVGoggles",10];
		// _crate addItemCargo ["G_Diving",2];
//				_crate addItemCargo ["NVCGoggles",1];
//				_crate addItemCargo ["TIGoggles",1];
//				_crate addItemCargo ["Laserdesignator",1];
//				_crate addWeaponCargo ["Laserdesignator",1];
// Chem Lights
		_crate addMagazineCargo ["Chemlight_blue",10];
		_crate addMagazineCargo ["Chemlight_green",10];
		_crate addMagazineCargo ["Chemlight_red",10];
		_crate addMagazineCargo ["Chemlight_yellow",10];

	};
	
	case "A3B_Kits":
	{
// Repair and Health Kits
		_crate addItemCargo ["FirstAidKit",20];
		_crate addItemCargo ["Medikit",10];
		_crate addItemCargo ["ToolKit",10];

	};
	
	case "A3B_Ordnance":
	{
// Explosive and Smoke Hand Grenades
		_crate addMagazineCargo ["MiniGrenade",20];
		_crate addMagazineCargo ["HandGrenade",20];
		_crate addMagazineCargo ["SmokeShell",20];
		_crate addMagazineCargo ["SmokeShellRed",20];
		_crate addMagazineCargo ["SmokeShellGreen",20];
		_crate addMagazineCargo ["SmokeShellYellow",20];
		_crate addMagazineCargo ["SmokeShellPurple",20];
		_crate addMagazineCargo ["SmokeShellBlue",20];
		_crate addMagazineCargo ["SmokeShellOrange",20];

// Grenade Launcher HE - High Explosive and Smoke Grenades
		_crate addMagazineCargo ["1Rnd_HE_Grenade_shell",20];
		_crate addMagazineCargo ["1Rnd_Smoke_Grenade_shell",20];
		_crate addMagazineCargo ["1Rnd_SmokeGreen_Grenade_shell",20];
		_crate addMagazineCargo ["1Rnd_SmokeYellow_Grenade_shell",20];
		_crate addMagazineCargo ["1Rnd_SmokePurple_Grenade_shell",20];
		_crate addMagazineCargo ["1Rnd_SmokeBlue_Grenade_shell",20];
		_crate addMagazineCargo ["1Rnd_SmokeOrange_Grenade_shell",20];
		_crate addMagazineCargo ["1Rnd_SmokeRed_Grenade_shell",20];

	};
	
	case "A3B_Explosives":
	{
// Ordnance - Mine, Claymore, C4, and Satchel Explosives
		_crate addMagazineCargo ["ATMine_Range_Mag",20];
		_crate addMagazineCargo ["APERSMine_Range_Mag",20];
		_crate addMagazineCargo ["APERSBoundingMine_Range_Mag",20];
		_crate addMagazineCargo ["SLAMDirectionalMine_Wire_Mag",20];
		_crate addMagazineCargo ["APERSTripMine_Wire_Mag",20];
		_crate addMagazineCargo ["ClaymoreDirectionalMine_Remote_Mag",20];
		_crate addMagazineCargo ["DemoCharge_Remote_Mag",20];
		_crate addMagazineCargo ["SatchelCharge_Remote_Mag",20];
	
	};
	
	case "A3B_Full":
	{
// Hand Guns		
		_crate addWeaponCargo ["hgun_P07_F",1];
		_crate addWeaponCargo ["hgun_P07_snds_F",1];
		_crate addWeaponCargo ["arifle_SDAR_F",1];
		_crate addWeaponCargo ["launch_NLAW_F",1];

// Assault Rifles
		_crate addWeaponCargo ["arifle_TRG20_F",1];
		_crate addWeaponCargo ["arifle_TRG20_Holo_F",1];
		// _crate addWeaponCargo ["arifle_TRG20_Holo_mzls_F",1];
		_crate addWeaponCargo ["arifle_TRG20_Holo_point_F",1];
		_crate addWeaponCargo ["arifle_TRG20_ACOg_point_F",1];
		// _crate addWeaponCargo ["arifle_TRG20_ACOg_flash_mzls_F",1];
		_crate addWeaponCargo ["arifle_TRG20_ACOg_F",1];
		_crate addWeaponCargo ["arifle_TRG21_F",1];
		_crate addWeaponCargo ["arifle_TRG21_GL_F",1];
		_crate addWeaponCargo ["arifle_TRG21_ACOg_point_F",1];
		_crate addWeaponCargo ["arifle_TRG21_ARCO_point_F",1];
		_crate addWeaponCargo ["arifle_TRG21_GL_ACOg_point_F",1];
		// _crate addWeaponCargo ["arifle_TRG21_GL_ACOg_point_mzls_F",1];
		_crate addWeaponCargo ["arifle_MX_F",1];
		_crate addWeaponCargo ["arifle_MX_GL_F",1];
		_crate addWeaponCargo ["arifle_MX_SW_F",1];
		_crate addWeaponCargo ["arifle_MXC_F",1];
		_crate addWeaponCargo ["arifle_MXM_F",1];
		// _crate addWeaponCargo ["arifle_MX_Hamr_point_grip_F",1];
		// _crate addWeaponCargo ["arifle_MX_ACO_point_grip_F",1];
		_crate addWeaponCargo ["arifle_MX_GL_ACO_point_F",1];
		// _crate addWeaponCargo ["arifle_MX_GL_Hamr_point_mzls_F",1];
		_crate addWeaponCargo ["arifle_MXC_Holo_F",1];
		// _crate addWeaponCargo ["arifle_MXC_Holo_point_grip_F",1];
		// _crate addWeaponCargo ["arifle_MXC_Holo_point_grip_snds_F",1];
		// _crate addWeaponCargo ["arifle_MXC_ACO_point_grip_mzls_F",1];
		// _crate addWeaponCargo ["arifle_MXC_ACO_point_grip_F",1];
		// _crate addWeaponCargo ["arifle_MXC_ACO_flash_grip_mzls_F",1];
		// _crate addWeaponCargo ["arifle_MX_SW_Hamr_point_gripod_F",1];
		// _crate addWeaponCargo ["arifle_MXM_Hamr_point_gripod_F",1];

// LMG - Light Machine Guns		
		_crate addWeaponCargo ["LMG_Mk200_F",1];
		// _crate addWeaponCargo ["LMG_Mk200_ARCO_bipod_F",1];
		// _crate addWeaponCargo ["LMG_Mk200_ARCO_pointer_bipod_F",1];
		// _crate addWeaponCargo ["LMG_Mk200_ACO_grip_F",1];
		// _crate addWeaponCargo ["LMG_Mk200_ACO_point_gripf_F",1];

// AMMO
// LMG - Light Machine Guns		
		_crate addMagazineCargo ["100Rnd_65x39_caseless_mag",8];
		_crate addMagazineCargo ["100Rnd_65x39_caseless_mag_Tracer",4];

// ROCKET
		_crate addMagazineCargo ["NLAW_F",10];

// PISTOL
		_crate addMagazineCargo ["16Rnd_9x21_Mag",8];
		_crate addMagazineCargo ["30Rnd_9x21_Mag",10];

// SDAR
		_crate addMagazineCargo ["20Rnd_556x45_UW_mag",8];
		_crate addMagazineCargo ["30Rnd_556x45_Stanag",8];

//T RG20
		_crate addMagazineCargo ["30Rnd_65x39_case_mag",8];
		// _crate addMagazineCargo ["30Rnd_65x39_case_mag_Tracer",4];

// MX
		_crate addMagazineCargo ["30Rnd_65x39_caseless_mag",8];
		_crate addMagazineCargo ["30Rnd_65x39_caseless_mag_Tracer",4];

// MX200
		_crate addMagazineCargo ["200Rnd_65x39_cased_Box",6];
		_crate addMagazineCargo ["200Rnd_65x39_cased_Box_Tracer",4];

// EBR/MXM
		// _crate addMagazineCargo ["20Rnd_762x45_mag",4];

// 88 mags to here
		_crate addMagazineCargo ["DemoCharge_Remote_Mag",1];
		_crate addMagazineCargo ["MiniGrenade",4];
		_crate addMagazineCargo ["SmokeShell",1];
		_crate addMagazineCargo ["1Rnd_HE_Grenade_shell",4];
		_crate addMagazineCargo ["1Rnd_Smoke_Grenade_shell",2];
		_crate addMagazineCargo ["UGL_FlareWhite_F",10];
		
////////////// Helmets, Uniforms, and Other //////////////
// HELMETS
		_crate addItemCargo ["H_MilCap_ocamo",1];
		_crate addItemCargo ["H_MilCap_mcamo",1];
		_crate addItemCargo ["H_HelmetB",1];
		_crate addItemCargo ["H_PilotHelmetHeli_B",1];
		_crate addItemCargo ["H_HelmetB_paint",1];
		_crate addItemCargo ["H_HelmetB_light",1];
		_crate addItemCargo ["H_HelmetO_ocamo",1];
		_crate addItemCargo ["H_PilotHelmetHeli_O",1];

// civ clothes - Caps
		_crate addItemCargo ["H_Cap_red",1];
		_crate addItemCargo ["H_Cap_blu",1];
		_crate addItemCargo ["H_Cap_brn_SERO",1];

// UNIFORMS

//civ clothes cargo 10
		// _crate addItemCargo ["U_B_poloshirt_blue",1];
		// _crate addItemCargo ["U_B_poloshirt_burgundy",1];
		// _crate addItemCargo ["U_B_poloshirt_stripped",1];
		// _crate addItemCargo ["U_B_poloshirt_tricolour",1];
		// _crate addItemCargo ["U_B_poloshirt_salmon",1];
		// _crate addItemCargo ["U_B_poloshirt_redwhite",1];
		// _crate addItemCargo ["U_B_commoner1_1",1];
		// _crate addItemCargo ["U_B_commoner1_2",1];
		// _crate addItemCargo ["U_B_commoner1_3",1];

//cargo 20
		_crate addItemCargo ["U_B_CombatUniform_mcam",1];
		_crate addItemCargo ["U_B_CombatUniform_mcam_tshirt",1];
		_crate addItemCargo ["U_B_CombatUniform_mcam_vest",1];
		_crate addItemCargo ["U_Rangemaster",1];
		// _crate addItemCargo ["U_OI_CombatUniform_ocamo",1];

//cargo 50
		_crate addItemCargo ["U_B_HeliPilotCoveralls",1]; 
		// _crate addItemCargo ["U_OI_PilotCoveralls",1];

//cargo 90
		_crate addItemCargo ["U_B_Wetsuit",2];
		// _crate addItemCargo ["U_OI_Wetsuit",2];
		// _crate addItemCargo ["U_I_Wetsuit",1];

//VESTS
//cargo 0
		_crate addItemCargo ["V_RebreatherB",2];
		_crate addItemCargo ["V_RebreatherIR",2];
		// _crate addItemCargo ["V_RebreatherIA",1];

//cargo 10
		_crate addItemCargo ["V_Rangemaster_belt",1];

//cargo 60
		_crate addItemCargo ["V_BandollierB_rgr",1];
		_crate addItemCargo ["V_BandollierB_cbr",1];
		_crate addItemCargo ["V_BandollierB_khk",1];

//cargo 70
		_crate addItemCargo ["V_ChestrigB_rgr",1];

//cargo 80
		_crate addItemCargo ["V_Chestrig_khk",1];

//cargo 90
		_crate addItemCargo ["V_TacVest_khk",1];
		_crate addItemCargo ["V_TacVest_brn",1];
		_crate addItemCargo ["V_TacVest_oli",1];

//cargo 100
		_crate addItemCargo ["V_PlateCarrier1_rgr",1];
		_crate addItemCargo ["V_PlateCarrier1_cbr",1];

//cargo 140
		_crate addItemCargo ["V_PlateCarrier2_rgr",1];

//cargo 150
		_crate addItemCargo ["V_PlateCarrierGL_rgr",1];

//cargo 180
		_crate addItemCargo ["V_HarnessO_brn",1];

//cargo 200
		_crate addItemCargo ["V_HarnessOGL_brn",1];

//Mk6Mortar
		_crate addBackpackCargo ["B_Mortar_01_FMortar_Wpn",1];
		_crate addBackpackCargo ["B_Mortar_01_FMortar_Support",1];

//load 240
		_crate addBackpackCargo ["B_AssaultPack_khk",1];
		_crate addBackpackCargo ["B_AssaultPack_dgtl",1];
		_crate addBackpackCargo ["B_AssaultPack_rgr",1];
		_crate addBackpackCargo ["B_AssaultPack_sgg",1];
		_crate addBackpackCargo ["B_AssaultPack_cbr",1];
		_crate addBackpackCargo ["B_AssaultPack_mcamo",1];
		_crate addBackpackCargo ["B_AssaultPack_ocamo",1];
		_crate addBackpackCargo ["B_AssaultPack_blk",1];
		_crate addBackpackCargo ["B_AssaultPack_rgr_Medic",1];
		_crate addBackpackCargo ["B_AssaultPack_rgr_Repair",1];
		_crate addBackpackCargo ["B_AssaultPack_blk_DiverExp",1];
		_crate addBackpackCargo ["B_AssaultPack_blk_DiverTL",1];

//load 250
		_crate addBackpackCargo ["B_FieldPack_blk",1];
		_crate addBackpackCargo ["B_FieldPack_ocamo",1];
		_crate addBackpackCargo ["B_FieldPack_oucamo",1];
		_crate addBackpackCargo ["B_FieldPack_cbr",1];
		_crate addBackpackCargo ["B_FieldPack_ocamo_Medic",1];
		_crate addBackpackCargo ["B_FieldPack_cbr_AT",1];
		_crate addBackpackCargo ["B_FieldPack_blk_DiverExp",1];
		_crate addBackpackCargo ["B_FieldPack_blk_DiverTL",1];

//300 load
		_crate addBackpackCargo ["B_Kitbag_mcamo",1];
		_crate addBackpackCargo ["B_Kitbag_sgg",1];
		_crate addBackpackCargo ["B_Kitbag_cbr",1];

//380 load
		_crate addBackpackCargo ["B_Bergen_sgg",1];
		_crate addBackpackCargo ["B_Bergen_sgg_Exp",1];

//420 load
		_crate addBackpackCargo ["B_Carryall_ocamo",1];
		_crate addBackpackCargo ["B_Carryall_oucamo",1];
		// _crate addBackpackCargo ["B_Carryall_oucamo_Exp",1];

// Weapon Optics, Silencers, and IR/Flash light Items
		_crate addItemCargo ["acc_flashlight",1];
		_crate addItemCargo ["acc_pointer_IR",1];
		_crate addItemCargo ["muzzle_snds_H",1];
		_crate addItemCargo ["muzzle_snds_B",1];
		_crate addItemCargo ["muzzle_snds_L",1];
		_crate addItemCargo ["muzzle_snds_H_MG",1];
		_crate addItemCargo ["optic_Arco",1];
		_crate addItemCargo ["optic_Hamr",1];
		_crate addItemCargo ["optic_Aco",1];
		_crate addItemCargo ["optic_ACO_grn",1];
		_crate addItemCargo ["optic_Holosight",1];
		_crate addItemCargo ["muzzle_snds_L",1];

// Repair and Health Kits
		_crate addItemCargo ["FirstAidKit",10];
		_crate addItemCargo ["Medikit",2];
		_crate addItemCargo ["ToolKit",2];

// Misc Items
		_crate addItemCargo ["ItemWatch",1];
		_crate addItemCargo ["ItemCompass",1];
		_crate addItemCargo ["ItemGPS",1];
		_crate addItemCargo ["ItemRadio",1];
		_crate addItemCargo ["ItemMap",1];
		_crate addItemCargo ["MineDetector",1];
		_crate addWeaponCargo ["Binocular",1];
		_crate addItemCargo ["NVGoggles",1];
		// _crate addItemCargo ["G_Diving",2];
//				_crate addItemCargo ["NVCGoggles",1];
//				_crate addItemCargo ["TIGoggles",1];
//				_crate addItemCargo ["Laserdesignator",1];
//				_crate addWeaponCargo ["Laserdesignator",1];

// Ordnance - Mine, Claymore, C4, and Satchel Explosives
		_crate addMagazineCargo ["ATMine_Range_Mag",10];
		_crate addMagazineCargo ["APERSMine_Range_Mag",10];
		_crate addMagazineCargo ["APERSBoundingMine_Range_Mag",10];
		_crate addMagazineCargo ["SLAMDirectionalMine_Wire_Mag",10];
		_crate addMagazineCargo ["APERSTripMine_Wire_Mag",10];
		_crate addMagazineCargo ["ClaymoreDirectionalMine_Remote_Mag",10];
		_crate addMagazineCargo ["DemoCharge_Remote_Mag",10];
		_crate addMagazineCargo ["SatchelCharge_Remote_Mag",10];

// Explosive and Smoke Hand Grenades
		_crate addMagazineCargo ["MiniGrenade",10];
		_crate addMagazineCargo ["HandGrenade",10];
		_crate addMagazineCargo ["SmokeShell",10];
		_crate addMagazineCargo ["SmokeShellRed",10];
		_crate addMagazineCargo ["SmokeShellGreen",10];
		_crate addMagazineCargo ["SmokeShellYellow",10];
		_crate addMagazineCargo ["SmokeShellPurple",10];
		_crate addMagazineCargo ["SmokeShellBlue",10];
		_crate addMagazineCargo ["SmokeShellOrange",10];

// Grenade Launcher HE - High Explosive and Smoke Grenades
		_crate addMagazineCargo ["1Rnd_HE_Grenade_shell",10];
		_crate addMagazineCargo ["1Rnd_Smoke_Grenade_shell",10];
		_crate addMagazineCargo ["1Rnd_SmokeGreen_Grenade_shell",10];
		_crate addMagazineCargo ["1Rnd_SmokeYellow_Grenade_shell",10];
		_crate addMagazineCargo ["1Rnd_SmokePurple_Grenade_shell",10];
		_crate addMagazineCargo ["1Rnd_SmokeBlue_Grenade_shell",10];
		_crate addMagazineCargo ["1Rnd_SmokeOrange_Grenade_shell",10];
		_crate addMagazineCargo ["1Rnd_SmokeRed_Grenade_shell",10];

		
// Chem Lights
		_crate addMagazineCargo ["Chemlight_blue",10];
		_crate addMagazineCargo ["Chemlight_green",10];
		_crate addMagazineCargo ["Chemlight_red",10];
		_crate addMagazineCargo ["Chemlight_yellow",10];

// Flares for Flare Gun
		_crate addMagazineCargo ["FlareGreen_F",10];
		_crate addMagazineCargo ["FlareRed_F",10];
		_crate addMagazineCargo ["FlareWhite_F",10];
		_crate addMagazineCargo ["FlareYellow_F",10];

// Grenade Launcher Flares
		_crate addMagazineCargo ["UGL_FlareGreen_F",10];
		_crate addMagazineCargo ["UGL_FlareRed_F",10];
		_crate addMagazineCargo ["UGL_FlareWhite_F",10];
		_crate addMagazineCargo ["UGL_FlareYellow_F",10];
		_crate addMagazineCargo ["UGL_FlareCIR_F",10];

//		_crate addMagazineCargo ["3Rnd_UGL_FlareGreen_F",10];
//		_crate addMagazineCargo ["3Rnd_UGL_FlareRed_F",10];
//		_crate addMagazineCargo ["3Rnd_UGL_FlareWhite_F",10];
//		_crate addMagazineCargo ["3Rnd_UGL_FlareYellow_F",10];
//		_crate addMagazineCargo ["3Rnd_UGL_FlareCIR_F",10];
//		_crate addMagazineCargo ["3Rnd_HE_Grenade_shell",10];
//		_crate addMagazineCargo ["3Rnd_Smoke_Grenade_shell",10];
//		_crate addMagazineCargo ["3Rnd_SmokeGreen_Grenade_shell",10];
//		_crate addMagazineCargo ["3Rnd_SmokeYellow_Grenade_shell",10];
//		_crate addMagazineCargo ["3Rnd_SmokePurple_Grenade_shell",10];
//		_crate addMagazineCargo ["3Rnd_SmokeBlue_Grenade_shell",10];
//		_crate addMagazineCargo ["3Rnd_SmokeOrange_Grenade_shell",10];
//		_crate addMagazineCargo ["3Rnd_SmokeRed_Grenade_shell",10];
	};

};
 