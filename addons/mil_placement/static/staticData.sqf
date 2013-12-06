ALIVE_unitBlackist = 
[
	"O_UAV_AI",
	"B_UAV_AI"
];

ALIVE_vehicleBlacklist = 
[
	"O_UAV_02_F",
	"O_UAV_02_CAS_F",
	"O_UAV_01_F",
	"O_UGV_01_F",
	"O_UGV_01_rcws_F",
	"B_UAV_01_F",
	"B_UAV_02_F",
	"B_UAV_02_CAS_F",
	"B_UGV_01_F",
	"B_UGV_01_rcws_F"
];

ALIVE_groupBlacklist = 
[
	"HAF_AttackTeam_UAV",
	"HAF_ReconTeam_UAV",
	"HAF_AttackTeam_UGV",
	"HAF_ReconTeam_UGV",
	"HAF_SmallTeam_UAV",
	"BUS_AttackTeam_UAV",
	"BUS_ReconTeam_UAV",
	"BUS_AttackTeam_UGV",
	"BUS_ReconTeam_UGV",
	"BUS_SmallTeam_UAV",
	"OI_AttackTeam_UAV",
	"OI_ReconTeam_UAV",
	"OI_AttackTeam_UGV",
	"OI_ReconTeam_UGV",
	"OI_SmallTeam_UAV",
	"BUS_TankPlatoon_AA", // BUG in CfgGroups vehicle name wrong
	"BUS_MechInf_AA" // BUG in CfgGroups vehicle name wrong
];

ALIVE_sideDefaultSupports = [] call ALIVE_fnc_hashCreate;
[ALIVE_sideDefaultSupports, "EAST", ["O_Truck_02_Ammo_F","O_Truck_02_box_F","O_Truck_02_fuel_F","O_Truck_02_medical_F"]] call ALIVE_fnc_hashSet; // ,"Box_East_AmmoVeh_F"
[ALIVE_sideDefaultSupports, "WEST", ["B_Truck_01_ammo_F","B_Truck_01_fuel_F","B_Truck_01_medical_F","B_Truck_01_Repair_F"]] call ALIVE_fnc_hashSet; // ,"Box_IND_AmmoVeh_F"
[ALIVE_sideDefaultSupports, "GUER", ["I_Truck_02_ammo_F","I_Truck_02_box_F","I_Truck_02_fuel_F","I_Truck_02_medical_F"]] call ALIVE_fnc_hashSet;

ALIVE_sideDefaultSupplies = [] call ALIVE_fnc_hashCreate;
[ALIVE_sideDefaultSupplies, "EAST", ["Box_East_Ammo_F","Box_East_AmmoOrd_F","Box_East_Grenades_F","Box_East_Support_F","Box_East_Wps_F","Box_East_WpsLaunch_F","Box_East_WpsSpecial_F"]] call ALIVE_fnc_hashSet;
[ALIVE_sideDefaultSupplies, "WEST", ["Box_NATO_Ammo_F","Box_NATO_AmmoOrd_F","Box_NATO_Grenades_F","Box_NATO_Support_F","Box_NATO_Wps_F","Box_NATO_WpsLaunch_F","Box_NATO_WpsSpecial_F"]] call ALIVE_fnc_hashSet;
[ALIVE_sideDefaultSupplies, "GUER", ["Box_IND_Ammo_F","Box_IND_AmmoOrd_F","Box_IND_Grenades_F","Box_IND_Support_F","Box_IND_Wps_F","Box_IND_WpsLaunch_F","Box_IND_WpsSpecial_F"]] call ALIVE_fnc_hashSet;

ALIVE_factionDefaultSupports = [] call ALIVE_fnc_hashCreate;
[ALIVE_factionDefaultSupports, "OPF_F", ["O_Truck_02_Ammo_F","O_Truck_02_box_F","O_Truck_02_fuel_F","O_Truck_02_medical_F"]] call ALIVE_fnc_hashSet; // ,"Box_East_AmmoVeh_F"
[ALIVE_factionDefaultSupports, "OPF_G_F", ["O_G_Offroad_01_armed_F","O_G_Van_01_fuel_F","O_G_Van_01_transport_F"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultSupports, "IND_F", ["I_Truck_02_ammo_F","I_Truck_02_box_F","I_Truck_02_fuel_F","I_Truck_02_medical_F"]] call ALIVE_fnc_hashSet; // ,"Box_IND_AmmoVeh_F"
[ALIVE_factionDefaultSupports, "BLU_F", ["B_Truck_01_ammo_F","B_Truck_01_fuel_F","B_Truck_01_medical_F","B_Truck_01_Repair_F"]] call ALIVE_fnc_hashSet; // ,"Box_NATO_AmmoVeh_F"
[ALIVE_factionDefaultSupports, "BLU_G_F", ["B_G_Van_01_fuel_F"]] call ALIVE_fnc_hashSet;

ALIVE_factionDefaultSupplies = [] call ALIVE_fnc_hashCreate;
[ALIVE_factionDefaultSupplies, "OPF_F", ["Box_East_Ammo_F","Box_East_AmmoOrd_F","Box_East_Grenades_F","Box_East_Support_F","Box_East_Wps_F","Box_East_WpsLaunch_F","Box_East_WpsSpecial_F"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultSupplies, "OPF_G_F", ["Box_East_Ammo_F","Box_East_AmmoOrd_F","Box_East_Grenades_F","Box_East_Support_F","Box_East_Wps_F","Box_East_WpsLaunch_F","Box_East_WpsSpecial_F"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultSupplies, "IND_F", ["Box_IND_Ammo_F","Box_IND_AmmoOrd_F","Box_IND_Grenades_F","Box_IND_Support_F","Box_IND_Wps_F","Box_IND_WpsLaunch_F","Box_IND_WpsSpecial_F"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultSupplies, "BLU_F", ["Box_NATO_Ammo_F","Box_NATO_AmmoOrd_F","Box_NATO_Grenades_F","Box_NATO_Support_F","Box_NATO_Wps_F","Box_NATO_WpsLaunch_F","Box_NATO_WpsSpecial_F"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultSupplies, "BLU_G_F", ["Box_IND_Ammo_F","Box_IND_AmmoOrd_F","Box_IND_Grenades_F","Box_IND_Support_F","Box_IND_Wps_F","Box_IND_WpsLaunch_F","Box_IND_WpsSpecial_F"]] call ALIVE_fnc_hashSet;

ALIVE_airBuildingTypes = [
	"hangar"
];

ALIVE_militaryParkingBuildingTypes = [
	"airport",
	"bunker",
	"cargo_house_v",
	"cargo_patrol_",
	"research"
];

ALIVE_militarySupplyBuildingTypes = [
	"barrack",
	"cargo_hq_",
	"miloffices",
	"mil_house",
	"mil_controltower",
	"barrack",
	"miloffices",
	"cargo_house_v",
	"cargo_patrol_",
	"research"
];

ALIVE_militaryHQBuildingTypes = [
	"barrack",
	"cargo_hq_",
	"miloffices",
	"mil_house",
	"mil_controltower",
	"barrack",
	"miloffices",
	"cargo_tower"
];

ALIVE_militaryAirBuildingTypes = [
	"tenthangar",
	"mil_hangar"				
];

ALIVE_civilianAirBuildingTypes = [
	"ss_hangar",
	"hangar_2",
	"hangar",				
	"runway_beton",
	"runway_end",
	"runway_main",
	"runway_secondary",
	"runwayold"
];

ALIVE_militaryHeliBuildingTypes = [
	"helipadempty",
	"helipadsquare",
	"heli_h_army"
];
		
ALIVE_civilianHeliBuildingTypes = [
	"helipadempty",
	"heli_h_civil",
	"heli_h_rescue"
];		

ALIVE_militaryBuildingTypes = [
	"airport_tower",
	"airport",
	"radar",
	"bunker",
	"cargo_house_v",
	"cargo_patrol_",
	"research",
	"deerstand",
	"hbarrier",
	"mil_wall",
	"fortification",
	//"mil_wired",
	"razorwire",
	"dome",
	"vez"
];

ALIVE_civilianHQBuildingTypes = [
	"a_municipaloffice",
	"a_office01",
	"a_office02",
	"offices",
	"airport_tower"
];

ALIVE_civilianPowerBuildingTypes = [
	"dam_",
	"dp_main",
	"pec_",
	"powerstation",
	"spp_t",
	"trafostanica",
	"ind_coltan_mine"
];

ALIVE_civilianCommsBuildingTypes = [
	"communication_f",
	"IlluminantTower",
	"vysilac_fm",
	"telek",
	"ttowerbig_",
	"tvtower"
];


ALIVE_civilianMarineBuildingTypes = [
	"crane",
	"lighthouse",
	"nav_pier",
	"pier_",
	"wtower"
];


ALIVE_civilianRailBuildingTypes = [
	"rail_house",
	"rail_station",
	"rail_platform",
	"rails_bridge",
	"stationhouse"
];


ALIVE_civilianFuelBuildingTypes = [
	"fuelstation",
	"oil_",
	"dp_bigtank",
	"expedice",
	"IndPipe",
	"komin",
	"Ind_Stack_Big",
	"Ind_TankBig",
	"fuel_tank_big",
	"ind_fuelstation"
];


ALIVE_civilianConstructionBuildingTypes = [
	"Ind_Mlyn_01",
	"Ind_Pec_01",
	"wip",
	"bridge_highway"
];


ALIVE_civilianSettlementBuildingTypes = [
    "church",
	"hospital",
	"amphitheater",
	"chapel_v",
	/*"households",*/
	"house",
	"housel",
	"housec",
	"housea",
	"housek"
];