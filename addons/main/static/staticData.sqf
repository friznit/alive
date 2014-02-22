/*
 * CQB Defaults
 */


ALIVE_CQBStrategicTypes =
[
	//A3
	"Land_Cargo_Patrol_V1_F",
	"Land_Cargo_Patrol_V2_F",
	"Land_Cargo_House_V1_F",
	"Land_Cargo_House_V2_F",
	"Land_Cargo_Tower_V3_F",
	"Land_Airport_Tower_F",
	"Land_Cargo_HQ_V1_F",
	"Land_Cargo_HQ_V2_F",
	"Land_MilOffices_V1_F",
	"Land_Offices_01_V1_F",
	"Land_Research_HQ_F",
	"Land_CarService_F",
	"Land_Hospital_main_F",
	"Land_dp_smallFactory_F",
	"Land_Radar_F",
	"Land_TentHangar_V1_F",
	
	//A2
	"Land_A_TVTower_Base",
	"Land_Dam_ConcP_20",
	"Land_Ind_Expedice_1",
	"Land_Ind_SiloVelke_02",
	"Land_Mil_Barracks",
	"Land_Mil_Barracks_i",
	"Land_Mil_Barracks_L",
	"Land_Mil_Guardhouse",
	"Land_Mil_House",
	"Land_Fort_Watchtower",
	"Land_Vysilac_FM",
	"Land_SS_hangar",
	"Land_telek1",
	"Land_vez",
	"Land_A_FuelStation_Shed",
	"Land_watertower1",
	"Land_trafostanica_velka",
	"Land_Ind_Oil_Tower_EP1",
	"Land_A_Villa_EP1",
	"Land_fortified_nest_small_EP1",
	"Land_Mil_Barracks_i_EP1",
	"Land_fortified_nest_big_EP1",
	"Land_Fort_Watchtower_EP1",
	"Land_Ind_PowerStation_EP1",
	"Land_Ind_PowerStation"
];

ALIVE_CQBunitBlackist =
[
	//A3
	"B_Helipilot_F",
	"B_diver_F",
	"B_diver_TL_F",
	"B_diver_exp_F",
	"B_RangeMaster_F",
	"B_crew_F",
	"B_Pilot_F",
	"B_helicrew_F",
	
	"O_helipilot_F",
	"O_diver_F",
	"O_diver_TL_F",
	"O_diver_exp_F",
	"O_crew_F",
	"O_Pilot_F",
	"O_helicrew_F",
	"O_UAV_AI",
	
	"I_crew_F",
	"I_helipilot_F",
	"I_helicrew_F",
	"I_diver_F",
	"I_diver_exp_F",
	"I_diver_TL_F",
	"I_pilot_F",
	"I_Story_Colonel_F"
];


/*
 * MP, CP, ML Defaults
 */


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

/*
 * Custom support and ammo classes for faction
 * Used by MP CP to place support vehicles and ammo boxes
 * If no faction specific settings are found will fall back to side
 */


ALIVE_sideDefaultSupports = [] call ALIVE_fnc_hashCreate;
[ALIVE_sideDefaultSupports, "EAST", ["O_Truck_02_Ammo_F","O_Truck_02_box_F","O_Truck_02_fuel_F","O_Truck_02_medical_F"]] call ALIVE_fnc_hashSet; // ,"Box_East_AmmoVeh_F"
[ALIVE_sideDefaultSupports, "WEST", ["B_Truck_01_ammo_F","B_Truck_01_fuel_F","B_Truck_01_medical_F","B_Truck_01_Repair_F"]] call ALIVE_fnc_hashSet; // ,"Box_IND_AmmoVeh_F"
[ALIVE_sideDefaultSupports, "GUER", ["I_Truck_02_ammo_F","I_Truck_02_box_F","I_Truck_02_fuel_F","I_Truck_02_medical_F"]] call ALIVE_fnc_hashSet;
[ALIVE_sideDefaultSupports, "CIV", ["C_Van_01_box_F","C_Van_01_transport_F","C_Van_01_fuel_F"]] call ALIVE_fnc_hashSet;

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
[ALIVE_factionDefaultSupports, "CIV_F", ["C_Van_01_box_F","C_Van_01_transport_F","C_Van_01_fuel_F"]] call ALIVE_fnc_hashSet;

ALIVE_factionDefaultSupplies = [] call ALIVE_fnc_hashCreate;
[ALIVE_factionDefaultSupplies, "OPF_F", ["Box_East_Ammo_F","Box_East_AmmoOrd_F","Box_East_Grenades_F","Box_East_Support_F","Box_East_Wps_F","Box_East_WpsLaunch_F","Box_East_WpsSpecial_F"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultSupplies, "OPF_G_F", ["Box_East_Ammo_F","Box_East_AmmoOrd_F","Box_East_Grenades_F","Box_East_Support_F","Box_East_Wps_F","Box_East_WpsLaunch_F","Box_East_WpsSpecial_F"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultSupplies, "IND_F", ["Box_IND_Ammo_F","Box_IND_AmmoOrd_F","Box_IND_Grenades_F","Box_IND_Support_F","Box_IND_Wps_F","Box_IND_WpsLaunch_F","Box_IND_WpsSpecial_F"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultSupplies, "BLU_F", ["Box_NATO_Ammo_F","Box_NATO_AmmoOrd_F","Box_NATO_Grenades_F","Box_NATO_Support_F","Box_NATO_Wps_F","Box_NATO_WpsLaunch_F","Box_NATO_WpsSpecial_F"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultSupplies, "BLU_G_F", ["Box_IND_Ammo_F","Box_IND_AmmoOrd_F","Box_IND_Grenades_F","Box_IND_Support_F","Box_IND_Wps_F","Box_IND_WpsLaunch_F","Box_IND_WpsSpecial_F"]] call ALIVE_fnc_hashSet;

/*
 * Map bounds for analysis grid, this is for when the map bounds function is faulty
 * due to incorrect map size values from config.
 */
ALIVE_mapBounds = [] call ALIVE_fnc_hashCreate;
[ALIVE_mapBounds, "utes", 5000] call ALIVE_fnc_hashSet;
[ALIVE_mapBounds, "fallujah", 11000] call ALIVE_fnc_hashSet;
[ALIVE_mapBounds, "Thirsk", 6000] call ALIVE_fnc_hashSet;
[ALIVE_mapBounds, "ThirskW", 6000] call ALIVE_fnc_hashSet;
[ALIVE_mapBounds, "Chernarus", 16000] call ALIVE_fnc_hashSet;
[ALIVE_mapBounds, "FDF_Isle1_a", 21000] call ALIVE_fnc_hashSet;
[ALIVE_mapBounds, "Takistan", 13000] call ALIVE_fnc_hashSet;
[ALIVE_mapBounds, "IsolaDiCapraia", 11000] call ALIVE_fnc_hashSet;
[ALIVE_mapBounds, "fata", 11000] call ALIVE_fnc_hashSet;
[ALIVE_mapBounds, "hellskitchen", 6000] call ALIVE_fnc_hashSet;
[ALIVE_mapBounds, "hellskitchens", 6000] call ALIVE_fnc_hashSet;
[ALIVE_mapBounds, "pja305", 21000] call ALIVE_fnc_hashSet;
[ALIVE_mapBounds, "Celle", 11000] call ALIVE_fnc_hashSet;
[ALIVE_mapBounds, "Takistan", 13000] call ALIVE_fnc_hashSet;


/*
 * CP MP building types for cluster generation
 */

private["_worldName"];

_worldName = worldName;

["WORLD NAME: %1",_worldName] call ALIVE_fnc_dump;


ALIVE_airBuildingTypes = [];
ALIVE_militaryParkingBuildingTypes = [];
ALIVE_militarySupplyBuildingTypes = [];
ALIVE_militaryHQBuildingTypes = [];
ALIVE_militaryAirBuildingTypes = [];
ALIVE_civilianAirBuildingTypes = [];
ALIVE_militaryHeliBuildingTypes = [];
ALIVE_civilianHeliBuildingTypes = [];
ALIVE_militaryBuildingTypes = [];

ALIVE_civilianParkingBuildingTypes = [];
ALIVE_civilianHQBuildingTypes = [];
ALIVE_civilianPowerBuildingTypes = [];
ALIVE_civilianCommsBuildingTypes = [];
ALIVE_civilianMarineBuildingTypes = [];
ALIVE_civilianRailBuildingTypes = [];
ALIVE_civilianFuelBuildingTypes = [];
ALIVE_civilianConstructionBuildingTypes = [];
ALIVE_civilianSettlementBuildingTypes = [];

// Altis Stratis
if(_worldName == "Altis" || _worldName == "Stratis" || _worldName == "Koplic") then {

    ALIVE_airBuildingTypes = ALIVE_airBuildingTypes + [
    	"hangar"
    ];

    ALIVE_militaryParkingBuildingTypes = ALIVE_militaryParkingBuildingTypes + [
    	"airport",
    	"bunker",
    	"cargo_house_v",
    	"cargo_patrol_",
    	"research"
    ];

    ALIVE_militarySupplyBuildingTypes = ALIVE_militarySupplyBuildingTypes + [
    	"barrack",
    	"cargo_hq_",
    	"miloffices",
    	"cargo_house_v",
    	"cargo_patrol_",
    	"research"
    ];

    ALIVE_militaryHQBuildingTypes = ALIVE_militaryHQBuildingTypes + [
    	"barrack",
    	"cargo_hq_",
    	"miloffices",
    	"cargo_tower"
    ];

    ALIVE_militaryAirBuildingTypes = ALIVE_militaryAirBuildingTypes + [
    	"tenthangar"
    ];

    ALIVE_civilianAirBuildingTypes = ALIVE_civilianAirBuildingTypes + [
    	"hangar",
    	"runway_beton",
    	"runway_main",
    	"runway_secondary"
    ];

    ALIVE_militaryHeliBuildingTypes = ALIVE_militaryHeliBuildingTypes + [
    	"helipads"
    ];

    ALIVE_civilianHeliBuildingTypes = ALIVE_civilianHeliBuildingTypes + [
    	"helipads"
    ];

    ALIVE_militaryBuildingTypes = ALIVE_militaryBuildingTypes + [
    	"airport_tower",
    	"radar",
    	"bunker",
    	"cargo_house_v",
    	"cargo_patrol_",
    	"research",
    	"mil_wall",
    	"fortification",
    	"razorwire",
    	"dome"
    ];

    ALIVE_civilianParkingBuildingTypes = ALIVE_civilianParkingBuildingTypes + [
        "house_",
        "shop_",
        "garage_",
        "stone_"
    ];

    ALIVE_civilianHQBuildingTypes = ALIVE_civilianHQBuildingTypes + [
    	"offices"
    ];

    ALIVE_civilianPowerBuildingTypes = ALIVE_civilianPowerBuildingTypes + [
    	"dp_main",
    	"spp_t"
    ];

    ALIVE_civilianCommsBuildingTypes = ALIVE_civilianCommsBuildingTypes + [
    	"communication_f",
    	"ttowerbig_"
    ];

    ALIVE_civilianMarineBuildingTypes = ALIVE_civilianMarineBuildingTypes + [
    	"crane",
    	"lighthouse",
    	"nav_pier",
    	"pier_"
    ];

    ALIVE_civilianRailBuildingTypes = ALIVE_civilianRailBuildingTypes + [

    ];

    ALIVE_civilianFuelBuildingTypes = ALIVE_civilianFuelBuildingTypes + [
    	"fuelstation",
    	"dp_bigtank"
    ];

    ALIVE_civilianConstructionBuildingTypes = ALIVE_civilianConstructionBuildingTypes + [
    	"wip",
    	"bridge_highway"
    ];

    ALIVE_civilianSettlementBuildingTypes = ALIVE_civilianSettlementBuildingTypes + [
        "church",
    	"hospital",
    	"amphitheater",
    	"chapel_v",
    	"households"
    ];

};

// Iron Front
if(_worldName == "Baranow" || _worldName == "Staszow" || _worldName == "ivachev" || _worldName == "Panovo" || _worldName == "Colleville") then {

    ALIVE_militaryParkingBuildingTypes = ALIVE_militaryParkingBuildingTypes + [
        "Land_lib_Mil_Barracks",
        "lib_posed",
        "blockhouse",
        "barrier_p1",
        "ZalChata",
        "lib_Mil_Barracks_L",
        "dum01"
    ];

    ALIVE_militarySupplyBuildingTypes = ALIVE_militarySupplyBuildingTypes + [
        "Land_lib_Mil_Barracks",
        "lib_posed",
        "blockhouse",
        "barrier_p1",
        "ZalChata",
        "lib_Mil_Barracks_L",
        "dum01"
    ];

    ALIVE_militaryHQBuildingTypes = ALIVE_militaryHQBuildingTypes + [
    	"Land_lib_Mil_Barracks",
    	"lib_Mil_Barracks_L",
        "dum01"
    ];

    ALIVE_militaryBuildingTypes = ALIVE_militaryBuildingTypes + [
    	"Land_lib_Mil_Barracks",
        "lib_posed",
        "blockhouse",
        "barrier_p1",
        "ZalChata",
        "lib_Mil_Barracks_L",
        "dum01"
    ];

    ALIVE_civilianHQBuildingTypes = ALIVE_civilianHQBuildingTypes + [
    	"lib_admin",
    	"lib_kostel_1",
    	"lib_church"
    ];

    ALIVE_civilianSettlementBuildingTypes = ALIVE_civilianSettlementBuildingTypes + [
        "kulna",
        "lib_dom",
        "lib_cr",
        "lib_sarai",
        "lib_Kladovka",
        "lib_hata",
        "lib_apteka",
        "lib_city_shop",
        "lib_kirpich",
        "lib_banya"
    ];

};

// Fallujah
if(_worldName == "fallujah") then {

    ALIVE_airBuildingTypes = ALIVE_airBuildingTypes + [
        "hangar"
    ];

    ALIVE_militaryParkingBuildingTypes = ALIVE_militaryParkingBuildingTypes + [
        "airport",
        "bunker",
        "watchtower",
        "fortified"
    ];

    ALIVE_militarySupplyBuildingTypes = ALIVE_militarySupplyBuildingTypes + [
        "barrack",
        "mil_house",
        "mil_controltower",
        "watchtower",
        "fortified"
    ];

    ALIVE_militaryHQBuildingTypes = ALIVE_militaryHQBuildingTypes + [
        "barrack",
        "mil_house",
        "mil_controltower",
        "miloffices"
    ];

    ALIVE_militaryAirBuildingTypes = ALIVE_militaryAirBuildingTypes + [

    ];

    ALIVE_civilianAirBuildingTypes = ALIVE_civilianAirBuildingTypes + [
        "ss_hangar",
        "hangar_2",
        "hangar",
        "runway_beton",
        "runway_end",
        "runway_main",
        "runway_secondary"
    ];

    ALIVE_militaryHeliBuildingTypes = ALIVE_militaryHeliBuildingTypes + [
        "heli_h_army"
    ];

    ALIVE_civilianHeliBuildingTypes = ALIVE_civilianHeliBuildingTypes + [
        "heli_h_rescue"
    ];

    ALIVE_militaryBuildingTypes = ALIVE_militaryBuildingTypes + [
        "radar",
        "bunker",
        "deerstand",
        "hbarrier",
        "razorwire",
        "vez",
        "watchtower",
        "fortified"
    ];

    ALIVE_civilianHQBuildingTypes = ALIVE_civilianHQBuildingTypes + [
        "a_office01",
        "a_office02"
    ];

    ALIVE_civilianPowerBuildingTypes = ALIVE_civilianPowerBuildingTypes + [
        "pec_",
        "powerstation",
        "trafostanica"
    ];

    ALIVE_civilianCommsBuildingTypes = ALIVE_civilianCommsBuildingTypes + [
        "illuminanttower",
        "vysilac_fm",
        "telek",
        "tvtower"
    ];

    ALIVE_civilianMarineBuildingTypes = ALIVE_civilianMarineBuildingTypes + [
        "crane",
        "wtower"
    ];

    ALIVE_civilianRailBuildingTypes = ALIVE_civilianRailBuildingTypes + [
        "stationhouse"
    ];

    ALIVE_civilianFuelBuildingTypes = ALIVE_civilianFuelBuildingTypes + [
        "fuelstation",
        "expedice",
        "indpipe",
        "komin",
        "ind_stack_big",
        "ind_tankbig",
        "fuel_tank_big"
    ];

    ALIVE_civilianConstructionBuildingTypes = ALIVE_civilianConstructionBuildingTypes + [
        "ind_mlyn_01",
        "ind_pec_01",
        "wip",
        "bridge_highway",
        "sawmillpen",
        "workshop"
    ];

    ALIVE_civilianSettlementBuildingTypes = ALIVE_civilianSettlementBuildingTypes + [
        "fallujah_hou",
        "hospital"
    ];

};


// Namalsk
if(_worldName == "Namalsk") then {

    ALIVE_airBuildingTypes = ALIVE_airBuildingTypes + [
        "hangar"
    ];

    ALIVE_militaryParkingBuildingTypes = ALIVE_militaryParkingBuildingTypes + [

    ];

    ALIVE_militarySupplyBuildingTypes = ALIVE_militarySupplyBuildingTypes + [
        "barrack",
        "mil_house"
    ];

    ALIVE_militaryHQBuildingTypes = ALIVE_militaryHQBuildingTypes + [
        "barrack",
        "mil_house"
    ];

    ALIVE_militaryAirBuildingTypes = ALIVE_militaryAirBuildingTypes + [

    ];

    ALIVE_civilianAirBuildingTypes = ALIVE_civilianAirBuildingTypes + [
        "hangar"
    ];

    ALIVE_militaryHeliBuildingTypes = ALIVE_militaryHeliBuildingTypes + [
        "heli_h_army"
    ];

    ALIVE_civilianHeliBuildingTypes = ALIVE_civilianHeliBuildingTypes + [
        "heli_h_civil"
    ];

    ALIVE_militaryBuildingTypes = ALIVE_militaryBuildingTypes + [
        "deerstand",
        "razorwire",
        "vez",
        "hlaska"
    ];

    ALIVE_civilianHQBuildingTypes = ALIVE_civilianHQBuildingTypes + [
        "a_office01",
        "a_office02"
    ];

    ALIVE_civilianPowerBuildingTypes = ALIVE_civilianPowerBuildingTypes + [
        "pec_",
        "powerstation",
        "trafostanica"
    ];

    ALIVE_civilianCommsBuildingTypes = ALIVE_civilianCommsBuildingTypes + [
        "vysilac_fm"
    ];

    ALIVE_civilianMarineBuildingTypes = ALIVE_civilianMarineBuildingTypes + [
        "Crane",
        "lighthouse",
        "nav_pier",
        "pier_",
        "wtower"
    ];

    ALIVE_civilianRailBuildingTypes = ALIVE_civilianRailBuildingTypes + [
        "stationhouse"
    ];

    ALIVE_civilianFuelBuildingTypes = ALIVE_civilianFuelBuildingTypes + [
        "fuelstation",
        "expedice",
        "komin",
        "fuel_tank_big"
    ];

    ALIVE_civilianConstructionBuildingTypes = ALIVE_civilianConstructionBuildingTypes + [
        "wip",
        "sawmillpen",
        "workshop"
    ];

    ALIVE_civilianSettlementBuildingTypes = ALIVE_civilianSettlementBuildingTypes + [
        "hospital"
    ];

};

// SMD Sahrani
if(_worldName == "smd_sahrani_a2") then {

    ALIVE_militaryParkingBuildingTypes = ALIVE_militaryParkingBuildingTypes + [
        "army",
        "vez",
        "budova"
    ];

    ALIVE_militarySupplyBuildingTypes = ALIVE_militarySupplyBuildingTypes + [
        "army"
    ];

    ALIVE_militaryHQBuildingTypes = ALIVE_militaryHQBuildingTypes + [
        "mesto3"
    ];

    ALIVE_militaryBuildingTypes = ALIVE_militaryBuildingTypes + [
        "vez",
        "hlaska",
        "budova",
        "posed",
        "hospital"
    ];

    ALIVE_civilianHQBuildingTypes = ALIVE_civilianHQBuildingTypes + [
        "rohova"
    ];

    ALIVE_civilianSettlementBuildingTypes = ALIVE_civilianSettlementBuildingTypes + [
        "olezlina",
        "domek",
        "dum",
        "kulna",
        "statek",
        "afbar",
        "panelak",
        "deutshe",
        "mesto",
        "hotel"
    ];

    ALIVE_civilianMarineBuildingTypes = ALIVE_civilianMarineBuildingTypes + [
        "najezd",
        "cargo",
        "nabrezi",
        "podesta"
    ];

};

// Thirsk
if(_worldName == "thirsk" || _worldName == "thirskw" ) then {

    ALIVE_airBuildingTypes = ALIVE_airBuildingTypes + [
        "hangar"
    ];

    ALIVE_militaryParkingBuildingTypes = ALIVE_militaryParkingBuildingTypes + [
        "airport"
    ];

    ALIVE_militarySupplyBuildingTypes = ALIVE_militarySupplyBuildingTypes + [
        "barrack",
        "mil_house",
        "mil_controltower"
    ];

    ALIVE_militaryHQBuildingTypes = ALIVE_militaryHQBuildingTypes + [
        "barrack",
        "mil_house",
        "mil_controltower"
    ];

    ALIVE_militaryAirBuildingTypes = ALIVE_militaryAirBuildingTypes + [

    ];

    ALIVE_civilianAirBuildingTypes = ALIVE_civilianAirBuildingTypes + [
        "ss_hangar",
        "hangar",
        "runway_end",
        "runway_main"
    ];

    ALIVE_militaryHeliBuildingTypes = ALIVE_militaryHeliBuildingTypes + [

    ];

    ALIVE_civilianHeliBuildingTypes = ALIVE_civilianHeliBuildingTypes + [
        "heli_h_civil"
    ];

    ALIVE_militaryBuildingTypes = ALIVE_militaryBuildingTypes + [
        "razorwire",
        "vez"
    ];

    ALIVE_civilianHQBuildingTypes = ALIVE_civilianHQBuildingTypes + [
        "a_office02"
    ];

    ALIVE_civilianPowerBuildingTypes = ALIVE_civilianPowerBuildingTypes + [
        "powerstation",
        "trafostanica"
    ];

    ALIVE_civilianCommsBuildingTypes = ALIVE_civilianCommsBuildingTypes + [
        "illuminanttower",
        "vysilac_fm",
        "telek",
        "tvtower"
    ];

    ALIVE_civilianMarineBuildingTypes = ALIVE_civilianMarineBuildingTypes + [
        "crane",
        "wtower"
    ];

    ALIVE_civilianRailBuildingTypes = ALIVE_civilianRailBuildingTypes + [
        "stationhouse"
    ];

    ALIVE_civilianFuelBuildingTypes = ALIVE_civilianFuelBuildingTypes + [
        "fuelstation",
        "indpipe",
        "fuel_tank_big"
    ];

    ALIVE_civilianConstructionBuildingTypes = ALIVE_civilianConstructionBuildingTypes + [
        "wip",
        "sawmillpen",
        "workshop"
    ];

    ALIVE_civilianSettlementBuildingTypes = ALIVE_civilianSettlementBuildingTypes + [
        "hospital",
        "house"
    ];

};

// Chernarus
if(_worldName == "Chernarus") then {

    ALIVE_airBuildingTypes = ALIVE_airBuildingTypes + [
        "hangar"
    ];

    ALIVE_militaryParkingBuildingTypes = ALIVE_militaryParkingBuildingTypes + [
        "bunker"
    ];

    ALIVE_militarySupplyBuildingTypes = ALIVE_militarySupplyBuildingTypes + [
        "barrack",
        "mil_house",
        "mil_controltower"
    ];

    ALIVE_militaryHQBuildingTypes = ALIVE_militaryHQBuildingTypes + [
        "barrack",
        "mil_house",
        "mil_controltower"
    ];

    ALIVE_militaryAirBuildingTypes = ALIVE_militaryAirBuildingTypes + [

    ];

    ALIVE_civilianAirBuildingTypes = ALIVE_civilianAirBuildingTypes + [
        "ss_hangar",
        "hangar_2",
        "hangar",
        "runway_beton",
        "runway_end",
        "runway_main",
        "runway_secondary"
    ];

    ALIVE_militaryHeliBuildingTypes = ALIVE_militaryHeliBuildingTypes + [
    ];

    ALIVE_civilianHeliBuildingTypes = ALIVE_civilianHeliBuildingTypes + [
    ];

    ALIVE_militaryBuildingTypes = ALIVE_militaryBuildingTypes + [
        "deerstand",
        "vez"
    ];

    ALIVE_civilianHQBuildingTypes = ALIVE_civilianHQBuildingTypes + [
        "a_office01",
        "a_office02",
        "a_municipaloffice"
    ];

    ALIVE_civilianPowerBuildingTypes = ALIVE_civilianPowerBuildingTypes + [
        "pec_",
        "powerstation",
        "trafostanica"
    ];

    ALIVE_civilianCommsBuildingTypes = ALIVE_civilianCommsBuildingTypes + [
        "illuminanttower",
        "vysilac_fm",
        "telek",
        "tvtower"
    ];

    ALIVE_civilianMarineBuildingTypes = ALIVE_civilianMarineBuildingTypes + [
        "crane",
        "lighthouse",
        "nav_pier",
        "pier_",
        "pier"
    ];

    ALIVE_civilianRailBuildingTypes = ALIVE_civilianRailBuildingTypes + [
        "rail_house",
        "rail_station",
        "rail_platform",
        "rails_bridge",
        "stationhouse"
    ];

    ALIVE_civilianFuelBuildingTypes = ALIVE_civilianFuelBuildingTypes + [
        "fuelstation",
        "expedice",
        "indpipe",
        "komin",
        "ind_stack_big",
        "ind_tankbig",
        "fuel_tank_big"
    ];

    ALIVE_civilianConstructionBuildingTypes = ALIVE_civilianConstructionBuildingTypes + [
        "ind_mlyn_01",
        "ind_pec_01",
        "wip",
        "sawmillpen",
        "workshop"
    ];

    ALIVE_civilianSettlementBuildingTypes = ALIVE_civilianSettlementBuildingTypes + [
        "hospital",
        "houseblock",
        "generalstore",
        "house"
    ];

};

// Podagorsk
if(_worldName == "fdf_isle1_a") then {

    ALIVE_airBuildingTypes = ALIVE_airBuildingTypes + [
        "hangar"
    ];

    ALIVE_militaryParkingBuildingTypes = ALIVE_militaryParkingBuildingTypes + [
        "bunker"
    ];

    ALIVE_militarySupplyBuildingTypes = ALIVE_militarySupplyBuildingTypes + [
        "barrack",
        "mil_house",
        "mil_controltower"
    ];

    ALIVE_militaryHQBuildingTypes = ALIVE_militaryHQBuildingTypes + [
        "barrack",
        "mil_house",
        "mil_controltower"
    ];

    ALIVE_militaryAirBuildingTypes = ALIVE_militaryAirBuildingTypes + [

    ];

    ALIVE_civilianAirBuildingTypes = ALIVE_civilianAirBuildingTypes + [
        "ss_hangar",
        "hangar_2",
        "hangar",
        "runway_beton",
        "runway_end",
        "runway_main",
        "runway_secondary"
    ];

    ALIVE_militaryHeliBuildingTypes = ALIVE_militaryHeliBuildingTypes + [
    ];

    ALIVE_civilianHeliBuildingTypes = ALIVE_civilianHeliBuildingTypes + [
    ];

    ALIVE_militaryBuildingTypes = ALIVE_militaryBuildingTypes + [
        "deerstand",
        "vez"
    ];

    ALIVE_civilianHQBuildingTypes = ALIVE_civilianHQBuildingTypes + [
        "a_office01",
        "a_office02",
        "a_municipaloffice"
    ];

    ALIVE_civilianPowerBuildingTypes = ALIVE_civilianPowerBuildingTypes + [
        "pec_",
        "powerstation",
        "trafostanica"
    ];

    ALIVE_civilianCommsBuildingTypes = ALIVE_civilianCommsBuildingTypes + [
        "illuminanttower",
        "vysilac_fm",
        "telek",
        "tvtower"
    ];

    ALIVE_civilianMarineBuildingTypes = ALIVE_civilianMarineBuildingTypes + [
        "crane",
        "lighthouse",
        "nav_pier",
        "pier_",
        "pier"
    ];

    ALIVE_civilianRailBuildingTypes = ALIVE_civilianRailBuildingTypes + [
        "rail_house",
        "rail_station",
        "rail_platform",
        "rails_bridge",
        "stationhouse"
    ];

    ALIVE_civilianFuelBuildingTypes = ALIVE_civilianFuelBuildingTypes + [
        "fuelstation",
        "expedice",
        "indpipe",
        "komin",
        "ind_stack_big",
        "ind_tankbig",
        "fuel_tank_big"
    ];

    ALIVE_civilianConstructionBuildingTypes = ALIVE_civilianConstructionBuildingTypes + [
        "ind_mlyn_01",
        "ind_pec_01",
        "wip",
        "sawmillpen",
        "workshop"
    ];

    ALIVE_civilianSettlementBuildingTypes = ALIVE_civilianSettlementBuildingTypes + [
        "hospital",
        "houseblock",
        "generalstore",
        "house"
    ];

};

// MBG Celle 2
if(_worldName == "mbg_celle2" || _worldName == "Celle") then {

    ALIVE_airBuildingTypes = ALIVE_airBuildingTypes + [
        "hangar"
    ];

    ALIVE_militaryParkingBuildingTypes = ALIVE_militaryParkingBuildingTypes + [
        "bunker"
    ];

    ALIVE_militarySupplyBuildingTypes = ALIVE_militarySupplyBuildingTypes + [
        "barrack",
        "mil_house",
        "mil_controltower"
    ];

    ALIVE_militaryHQBuildingTypes = ALIVE_militaryHQBuildingTypes + [
        "barrack",
        "mil_house",
        "mil_controltower"
    ];

    ALIVE_militaryAirBuildingTypes = ALIVE_militaryAirBuildingTypes + [

    ];

    ALIVE_civilianAirBuildingTypes = ALIVE_civilianAirBuildingTypes + [
        "ss_hangar",
        "hangar_2",
        "hangar",
        "runway_beton",
        "runway_end",
        "runway_main",
        "runway_secondary"
    ];

    ALIVE_militaryHeliBuildingTypes = ALIVE_militaryHeliBuildingTypes + [
    ];

    ALIVE_civilianHeliBuildingTypes = ALIVE_civilianHeliBuildingTypes + [
    ];

    ALIVE_militaryBuildingTypes = ALIVE_militaryBuildingTypes + [
        "deerstand",
        "vez"
    ];

    ALIVE_civilianHQBuildingTypes = ALIVE_civilianHQBuildingTypes + [
        "a_office01",
        "a_office02",
        "a_municipaloffice"
    ];

    ALIVE_civilianPowerBuildingTypes = ALIVE_civilianPowerBuildingTypes + [
        "pec_",
        "powerstation",
        "trafostanica"
    ];

    ALIVE_civilianCommsBuildingTypes = ALIVE_civilianCommsBuildingTypes + [
        "illuminanttower",
        "vysilac_fm",
        "telek",
        "tvtower"
    ];

    ALIVE_civilianMarineBuildingTypes = ALIVE_civilianMarineBuildingTypes + [
        "crane",
        "lighthouse",
        "nav_pier",
        "pier_",
        "pier"
    ];

    ALIVE_civilianRailBuildingTypes = ALIVE_civilianRailBuildingTypes + [
        "rail_house",
        "rail_station",
        "rail_platform",
        "rails_bridge",
        "stationhouse"
    ];

    ALIVE_civilianFuelBuildingTypes = ALIVE_civilianFuelBuildingTypes + [
        "fuelstation",
        "expedice",
        "indpipe",
        "komin",
        "ind_stack_big",
        "ind_tankbig",
        "fuel_tank_big"
    ];

    ALIVE_civilianConstructionBuildingTypes = ALIVE_civilianConstructionBuildingTypes + [
        "ind_mlyn_01",
        "ind_pec_01",
        "wip",
        "sawmillpen",
        "workshop"
    ];

    ALIVE_civilianSettlementBuildingTypes = ALIVE_civilianSettlementBuildingTypes + [
        "hospital",
        "houseblock",
        "generalstore",
        "house"
    ];

};

// Shapur
if(_worldName == "Shapur_BAF") then {

    ALIVE_airBuildingTypes = ALIVE_airBuildingTypes + [
    ];

    ALIVE_militaryParkingBuildingTypes = ALIVE_militaryParkingBuildingTypes + [
    ];

    ALIVE_militarySupplyBuildingTypes = ALIVE_militarySupplyBuildingTypes + [
        "barrack",
        "mil_house"
    ];

    ALIVE_militaryHQBuildingTypes = ALIVE_militaryHQBuildingTypes + [
        "barrack",
        "mil_house"
    ];

    ALIVE_militaryAirBuildingTypes = ALIVE_militaryAirBuildingTypes + [

    ];

    ALIVE_civilianAirBuildingTypes = ALIVE_civilianAirBuildingTypes + [
    ];

    ALIVE_militaryHeliBuildingTypes = ALIVE_militaryHeliBuildingTypes + [
    ];

    ALIVE_civilianHeliBuildingTypes = ALIVE_civilianHeliBuildingTypes + [
    ];

    ALIVE_militaryBuildingTypes = ALIVE_militaryBuildingTypes + [
        "vez"
    ];

    ALIVE_civilianHQBuildingTypes = ALIVE_civilianHQBuildingTypes + [
    ];

    ALIVE_civilianPowerBuildingTypes = ALIVE_civilianPowerBuildingTypes + [
        "powerstation"
    ];

    ALIVE_civilianCommsBuildingTypes = ALIVE_civilianCommsBuildingTypes + [
    ];

    ALIVE_civilianMarineBuildingTypes = ALIVE_civilianMarineBuildingTypes + [
    ];

    ALIVE_civilianRailBuildingTypes = ALIVE_civilianRailBuildingTypes + [
    ];

    ALIVE_civilianFuelBuildingTypes = ALIVE_civilianFuelBuildingTypes + [
        "fuelstation",
        "indpipe",
        "komin",
        "ind_tankbig",
        "fuel_tank_big"
    ];

    ALIVE_civilianConstructionBuildingTypes = ALIVE_civilianConstructionBuildingTypes + [
    ];

    ALIVE_civilianSettlementBuildingTypes = ALIVE_civilianSettlementBuildingTypes + [
        "house"
    ];

};

// Takistan
if(_worldName == "Takistan") then {

    ALIVE_airBuildingTypes = ALIVE_airBuildingTypes + [
        "hangar"
    ];

    ALIVE_militaryParkingBuildingTypes = ALIVE_militaryParkingBuildingTypes + [
        "airport",
        "watchtower",
        "fortified"
    ];

    ALIVE_militarySupplyBuildingTypes = ALIVE_militarySupplyBuildingTypes + [
        "barrack",
        "mil_house",
        "mil_controltower",
        "watchtower",
        "fortified"
    ];

    ALIVE_militaryHQBuildingTypes = ALIVE_militaryHQBuildingTypes + [
        "barrack",
        "mil_house",
        "mil_controltower",
        "miloffices"
    ];

    ALIVE_militaryAirBuildingTypes = ALIVE_militaryAirBuildingTypes + [

    ];

    ALIVE_civilianAirBuildingTypes = ALIVE_civilianAirBuildingTypes + [
        "hangar",
        "runway_beton",
        "runway_end",
        "runway_main"
    ];

    ALIVE_militaryHeliBuildingTypes = ALIVE_militaryHeliBuildingTypes + [
        "heli_h_army"
    ];

    ALIVE_civilianHeliBuildingTypes = ALIVE_civilianHeliBuildingTypes + [
    ];

    ALIVE_militaryBuildingTypes = ALIVE_militaryBuildingTypes + [
        "razorwire",
        "vez",
        "watchtower",
        "fortified"
    ];

    ALIVE_civilianHQBuildingTypes = ALIVE_civilianHQBuildingTypes + [
    ];

    ALIVE_civilianPowerBuildingTypes = ALIVE_civilianPowerBuildingTypes + [
        "powerstation"
    ];

    ALIVE_civilianCommsBuildingTypes = ALIVE_civilianCommsBuildingTypes + [
    ];

    ALIVE_civilianMarineBuildingTypes = ALIVE_civilianMarineBuildingTypes + [
    ];

    ALIVE_civilianRailBuildingTypes = ALIVE_civilianRailBuildingTypes + [
    ];

    ALIVE_civilianFuelBuildingTypes = ALIVE_civilianFuelBuildingTypes + [
        "fuelstation",
        "indpipe",
        "ind_tankbig",
        "fuel_tank_big"
    ];

    ALIVE_civilianConstructionBuildingTypes = ALIVE_civilianConstructionBuildingTypes + [
        "coltan"
    ];

    ALIVE_civilianSettlementBuildingTypes = ALIVE_civilianSettlementBuildingTypes + [
        "house"
    ];

};

// Zargabad
if(_worldName == "Zargabad") then {

    ALIVE_airBuildingTypes = ALIVE_airBuildingTypes + [
        "hangar"
    ];

    ALIVE_militaryParkingBuildingTypes = ALIVE_militaryParkingBuildingTypes + [
        "bunker",
        "barrack"
    ];

    ALIVE_militarySupplyBuildingTypes = ALIVE_militarySupplyBuildingTypes + [
        "barrack",
        "mil_house",
        "mil_controltower"
    ];

    ALIVE_militaryHQBuildingTypes = ALIVE_militaryHQBuildingTypes + [
        "barrack",
        "mil_house",
        "mil_controltower"
    ];

    ALIVE_militaryAirBuildingTypes = ALIVE_militaryAirBuildingTypes + [

    ];

    ALIVE_civilianAirBuildingTypes = ALIVE_civilianAirBuildingTypes + [
        "hangar",
        "runway_beton",
        "runway_end",
        "runway_main",
        "runway_secondary"
    ];

    ALIVE_militaryHeliBuildingTypes = ALIVE_militaryHeliBuildingTypes + [
        "heli_h_army"
    ];

    ALIVE_civilianHeliBuildingTypes = ALIVE_civilianHeliBuildingTypes + [
    ];

    ALIVE_militaryBuildingTypes = ALIVE_militaryBuildingTypes + [
        "vez"
    ];

    ALIVE_civilianHQBuildingTypes = ALIVE_civilianHQBuildingTypes + [
        "a_office01"
    ];

    ALIVE_civilianPowerBuildingTypes = ALIVE_civilianPowerBuildingTypes + [
        "powerstation"
    ];

    ALIVE_civilianCommsBuildingTypes = ALIVE_civilianCommsBuildingTypes + [
    ];

    ALIVE_civilianMarineBuildingTypes = ALIVE_civilianMarineBuildingTypes + [
    ];

    ALIVE_civilianRailBuildingTypes = ALIVE_civilianRailBuildingTypes + [
        "stationhouse"
    ];

    ALIVE_civilianFuelBuildingTypes = ALIVE_civilianFuelBuildingTypes + [
        "fuelstation",
        "indpipe",
        "komin",
        "fuel_tank_big"
    ];

    ALIVE_civilianConstructionBuildingTypes = ALIVE_civilianConstructionBuildingTypes + [
    ];

    ALIVE_civilianSettlementBuildingTypes = ALIVE_civilianSettlementBuildingTypes + [
        "houseblock",
        "house"
    ];

};

// CLAfghan
if(_worldName == "CLAfghan") then {

    ALIVE_airBuildingTypes = ALIVE_airBuildingTypes + [
        "hangar"
    ];

    ALIVE_militaryParkingBuildingTypes = ALIVE_militaryParkingBuildingTypes + [
        "bunker",
        "barrack",
        "guardhouse"
    ];

    ALIVE_militarySupplyBuildingTypes = ALIVE_militarySupplyBuildingTypes + [
        "barrack",
        "mil_house",
        "mil_controltower"
    ];

    ALIVE_militaryHQBuildingTypes = ALIVE_militaryHQBuildingTypes + [
        "barrack",
        "mil_house",
        "mil_controltower"
    ];

    ALIVE_militaryAirBuildingTypes = ALIVE_militaryAirBuildingTypes + [

    ];

    ALIVE_civilianAirBuildingTypes = ALIVE_civilianAirBuildingTypes + [
        "hangar",
        "runway_beton",
        "runway_end",
        "runway_main",
        "runway_secondary"
    ];

    ALIVE_militaryHeliBuildingTypes = ALIVE_militaryHeliBuildingTypes + [
        "heli_h_army"
    ];

    ALIVE_civilianHeliBuildingTypes = ALIVE_civilianHeliBuildingTypes + [
    ];

    ALIVE_militaryBuildingTypes = ALIVE_militaryBuildingTypes + [
        "vez",
        "guardtower",
        "tents",
        "fortified",
        "bunker",
        "guardhouse",
        "fortress"
    ];

    ALIVE_civilianHQBuildingTypes = ALIVE_civilianHQBuildingTypes + [
        "a_office01"
    ];

    ALIVE_civilianPowerBuildingTypes = ALIVE_civilianPowerBuildingTypes + [
        "powerstation"
    ];

    ALIVE_civilianCommsBuildingTypes = ALIVE_civilianCommsBuildingTypes + [
    ];

    ALIVE_civilianMarineBuildingTypes = ALIVE_civilianMarineBuildingTypes + [
    ];

    ALIVE_civilianRailBuildingTypes = ALIVE_civilianRailBuildingTypes + [
        "stationhouse"
    ];

    ALIVE_civilianFuelBuildingTypes = ALIVE_civilianFuelBuildingTypes + [
        "fuelstation",
        "indpipe",
        "komin",
        "fuel_tank_big"
    ];

    ALIVE_civilianConstructionBuildingTypes = ALIVE_civilianConstructionBuildingTypes + [
        "ind_sawmill"
    ];

    ALIVE_civilianSettlementBuildingTypes = ALIVE_civilianSettlementBuildingTypes + [
        "houseblock",
        "house",
        "opxbuildings"
    ];

};

// MCN Hazarkot
if(_worldName == "MCN_HazarKot") then {

    ALIVE_airBuildingTypes = ALIVE_airBuildingTypes + [
    ];

    ALIVE_militaryParkingBuildingTypes = ALIVE_militaryParkingBuildingTypes + [
    ];

    ALIVE_militarySupplyBuildingTypes = ALIVE_militarySupplyBuildingTypes + [
    ];

    ALIVE_militaryHQBuildingTypes = ALIVE_militaryHQBuildingTypes + [
    ];

    ALIVE_militaryAirBuildingTypes = ALIVE_militaryAirBuildingTypes + [

    ];

    ALIVE_civilianAirBuildingTypes = ALIVE_civilianAirBuildingTypes + [
    ];

    ALIVE_militaryHeliBuildingTypes = ALIVE_militaryHeliBuildingTypes + [
    ];

    ALIVE_civilianHeliBuildingTypes = ALIVE_civilianHeliBuildingTypes + [
    ];

    ALIVE_militaryBuildingTypes = ALIVE_militaryBuildingTypes + [
    ];

    ALIVE_civilianHQBuildingTypes = ALIVE_civilianHQBuildingTypes + [
    ];

    ALIVE_civilianPowerBuildingTypes = ALIVE_civilianPowerBuildingTypes + [
    ];

    ALIVE_civilianCommsBuildingTypes = ALIVE_civilianCommsBuildingTypes + [
    ];

    ALIVE_civilianMarineBuildingTypes = ALIVE_civilianMarineBuildingTypes + [
    ];

    ALIVE_civilianRailBuildingTypes = ALIVE_civilianRailBuildingTypes + [
    ];

    ALIVE_civilianFuelBuildingTypes = ALIVE_civilianFuelBuildingTypes + [
    ];

    ALIVE_civilianConstructionBuildingTypes = ALIVE_civilianConstructionBuildingTypes + [
        "ind_coltan_mine"
    ];

    ALIVE_civilianSettlementBuildingTypes = ALIVE_civilianSettlementBuildingTypes + [
        "house"
    ];

};

// Isola Di Capraia
if(_worldName == "isoladicapraia") then {

    ALIVE_airBuildingTypes = ALIVE_airBuildingTypes + [
        "hangar"
    ];

    ALIVE_militaryParkingBuildingTypes = ALIVE_militaryParkingBuildingTypes + [
        "bunker"
    ];

    ALIVE_militarySupplyBuildingTypes = ALIVE_militarySupplyBuildingTypes + [
        "barrack",
        "mil_house",
        "mil_controltower"
    ];

    ALIVE_militaryHQBuildingTypes = ALIVE_militaryHQBuildingTypes + [
        "barrack",
        "mil_house",
        "mil_controltower"
    ];

    ALIVE_militaryAirBuildingTypes = ALIVE_militaryAirBuildingTypes + [

    ];

    ALIVE_civilianAirBuildingTypes = ALIVE_civilianAirBuildingTypes + [
        "ss_hangar",
        "hangar_2",
        "hangar",
        "runway_beton",
        "runway_end",
        "runway_main",
        "runway_secondary"
    ];

    ALIVE_militaryHeliBuildingTypes = ALIVE_militaryHeliBuildingTypes + [
    ];

    ALIVE_civilianHeliBuildingTypes = ALIVE_civilianHeliBuildingTypes + [
    ];

    ALIVE_militaryBuildingTypes = ALIVE_militaryBuildingTypes + [
        "deerstand",
        "vez"
    ];

    ALIVE_civilianHQBuildingTypes = ALIVE_civilianHQBuildingTypes + [
        "a_office01",
        "a_office02",
        "a_municipaloffice"
    ];

    ALIVE_civilianPowerBuildingTypes = ALIVE_civilianPowerBuildingTypes + [
        "pec_",
        "powerstation",
        "trafostanica"
    ];

    ALIVE_civilianCommsBuildingTypes = ALIVE_civilianCommsBuildingTypes + [
        "illuminanttower",
        "vysilac_fm",
        "telek",
        "tvtower"
    ];

    ALIVE_civilianMarineBuildingTypes = ALIVE_civilianMarineBuildingTypes + [
        "crane",
        "lighthouse",
        "nav_pier",
        "pier_",
        "pier"
    ];

    ALIVE_civilianRailBuildingTypes = ALIVE_civilianRailBuildingTypes + [
        "rail_house",
        "rail_station",
        "rail_platform",
        "rails_bridge",
        "stationhouse"
    ];

    ALIVE_civilianFuelBuildingTypes = ALIVE_civilianFuelBuildingTypes + [
        "fuelstation",
        "expedice",
        "indpipe",
        "komin",
        "ind_stack_big",
        "ind_tankbig",
        "fuel_tank_big"
    ];

    ALIVE_civilianConstructionBuildingTypes = ALIVE_civilianConstructionBuildingTypes + [
        "ind_mlyn_01",
        "ind_pec_01",
        "wip",
        "sawmillpen",
        "workshop"
    ];

    ALIVE_civilianSettlementBuildingTypes = ALIVE_civilianSettlementBuildingTypes + [
        "hospital",
        "houseblock",
        "generalstore",
        "house"
    ];

};

// Tigeria
if(_worldName == "tigeria") then {

    ALIVE_airBuildingTypes = ALIVE_airBuildingTypes + [
        "hangar"
    ];

    ALIVE_militaryParkingBuildingTypes = ALIVE_militaryParkingBuildingTypes + [
        "barrack",
        "mil_house",
        "mil_controltower",
        "mil_guardhouse",
        "deerstand"
    ];

    ALIVE_militarySupplyBuildingTypes = ALIVE_militarySupplyBuildingTypes + [
        "barrack",
        "mil_house",
        "mil_controltower",
        "mil_guardhouse"
    ];

    ALIVE_militaryHQBuildingTypes = ALIVE_militaryHQBuildingTypes + [
        "barrack",
        "mil_house",
        "mil_controltower"
    ];

    ALIVE_militaryAirBuildingTypes = ALIVE_militaryAirBuildingTypes + [

    ];

    ALIVE_civilianAirBuildingTypes = ALIVE_civilianAirBuildingTypes + [
        "ss_hangar",
        "hangar_2",
        "hangar",
        "runway_beton",
        "runway_end",
        "runway_main",
        "runway_secondary"
    ];

    ALIVE_militaryHeliBuildingTypes = ALIVE_militaryHeliBuildingTypes + [
    ];

    ALIVE_civilianHeliBuildingTypes = ALIVE_civilianHeliBuildingTypes + [
    ];

    ALIVE_militaryBuildingTypes = ALIVE_militaryBuildingTypes + [
        "deerstand",
        "vez",
        "army_hut",
        "barrack",
        "mil_house",
        "mil_controltower",
        "mil_guardhouse",
        "deerstand"
    ];

    ALIVE_civilianHQBuildingTypes = ALIVE_civilianHQBuildingTypes + [
        "a_office01"
    ];

    ALIVE_civilianPowerBuildingTypes = ALIVE_civilianPowerBuildingTypes + [
        "pec_",
        "powerstation",
        "trafostanica"
    ];

    ALIVE_civilianCommsBuildingTypes = ALIVE_civilianCommsBuildingTypes + [
        "illuminanttower",
        "vysilac_fm",
        "telek",
        "tvtower"
    ];

    ALIVE_civilianMarineBuildingTypes = ALIVE_civilianMarineBuildingTypes + [
        "crane",
        "lighthouse",
        "nav_pier",
        "pier_",
        "pier"
    ];

    ALIVE_civilianRailBuildingTypes = ALIVE_civilianRailBuildingTypes + [
    ];

    ALIVE_civilianFuelBuildingTypes = ALIVE_civilianFuelBuildingTypes + [
        "fuelstation",
        "expedice",
        "indpipe",
        "komin",
        "ind_tankbig"
    ];

    ALIVE_civilianConstructionBuildingTypes = ALIVE_civilianConstructionBuildingTypes + [
        "wip",
        "sawmillpen",
        "workshop"
    ];

    ALIVE_civilianSettlementBuildingTypes = ALIVE_civilianSettlementBuildingTypes + [
        "generalstore",
        "house",
        "domek",
        "dum_",
        "hut0"
    ];

};

// Fata
if(_worldName == "fata") then {

    ALIVE_airBuildingTypes = ALIVE_airBuildingTypes + [
        "hangar"
    ];

    ALIVE_militaryParkingBuildingTypes = ALIVE_militaryParkingBuildingTypes + [
        "barrack",
        "mil_house",
        "mil_guardhouse",
        "deerstand"
    ];

    ALIVE_militarySupplyBuildingTypes = ALIVE_militarySupplyBuildingTypes + [
        "barrack",
        "mil_house",
        "mil_guardhouse",
        "deerstand"
    ];

    ALIVE_militaryHQBuildingTypes = ALIVE_militaryHQBuildingTypes + [
        "barrack",
        "mil_house"
    ];

    ALIVE_militaryAirBuildingTypes = ALIVE_militaryAirBuildingTypes + [

    ];

    ALIVE_civilianAirBuildingTypes = ALIVE_civilianAirBuildingTypes + [
    ];

    ALIVE_militaryHeliBuildingTypes = ALIVE_militaryHeliBuildingTypes + [
    ];

    ALIVE_civilianHeliBuildingTypes = ALIVE_civilianHeliBuildingTypes + [
    ];

    ALIVE_militaryBuildingTypes = ALIVE_militaryBuildingTypes + [
        "deerstand",
        "vez",
        "barrack",
        "mil_house",
        "mil_guardhouse",
        "deerstand",
        "barrier",
        "hlaska",
        "watchtower",
        "hbarrier"
    ];

    ALIVE_civilianHQBuildingTypes = ALIVE_civilianHQBuildingTypes + [
        "a_office01"
    ];

    ALIVE_civilianPowerBuildingTypes = ALIVE_civilianPowerBuildingTypes + [
        "powerstation",
        "trafostanica",
        "ind_coltan_mine"
    ];

    ALIVE_civilianCommsBuildingTypes = ALIVE_civilianCommsBuildingTypes + [
        "vysilac_fm"
    ];

    ALIVE_civilianMarineBuildingTypes = ALIVE_civilianMarineBuildingTypes + [
    ];

    ALIVE_civilianRailBuildingTypes = ALIVE_civilianRailBuildingTypes + [
    ];

    ALIVE_civilianFuelBuildingTypes = ALIVE_civilianFuelBuildingTypes + [
        "fuelstation",
        "ind_tankbig"
    ];

    ALIVE_civilianConstructionBuildingTypes = ALIVE_civilianConstructionBuildingTypes + [
        "wip",
        "ind_coltan_mine"
    ];

    ALIVE_civilianSettlementBuildingTypes = ALIVE_civilianSettlementBuildingTypes + [
        "house"
    ];

};

// Sangin
if(_worldName == "hellskitchen" || _worldName == "hellskitchens") then {

    ALIVE_airBuildingTypes = ALIVE_airBuildingTypes + [
        "hangar"
    ];

    ALIVE_militaryParkingBuildingTypes = ALIVE_militaryParkingBuildingTypes + [
        "barrack",
        "mil_controltower",
        "guardtower",
        "killhouse",
        "watchtower"
    ];

    ALIVE_militarySupplyBuildingTypes = ALIVE_militarySupplyBuildingTypes + [
        "barrack",
        "mil_controltower",
        "guardtower",
        "killhouse"
    ];

    ALIVE_militaryHQBuildingTypes = ALIVE_militaryHQBuildingTypes + [
        "barrack",
        "mil_controltower"
    ];

    ALIVE_militaryAirBuildingTypes = ALIVE_militaryAirBuildingTypes + [

    ];

    ALIVE_civilianAirBuildingTypes = ALIVE_civilianAirBuildingTypes + [
        "ss_hangar",
        "hangar_2",
        "hangar"
    ];

    ALIVE_militaryHeliBuildingTypes = ALIVE_militaryHeliBuildingTypes + [
        "heli_h_army"
    ];

    ALIVE_civilianHeliBuildingTypes = ALIVE_civilianHeliBuildingTypes + [

    ];

    ALIVE_militaryBuildingTypes = ALIVE_militaryBuildingTypes + [
        "barrack",
        "mil_controltower",
        "hesco",
        "guardtower",
        "killhouse",
        "watchtower",
        "nest"
    ];

    ALIVE_civilianHQBuildingTypes = ALIVE_civilianHQBuildingTypes + [
        "a_office01"
    ];

    ALIVE_civilianPowerBuildingTypes = ALIVE_civilianPowerBuildingTypes + [
        "powerstation",
        "trafostanica"
    ];

    ALIVE_civilianCommsBuildingTypes = ALIVE_civilianCommsBuildingTypes + [
        "illuminanttower",
        "vysilac_fm",
        "telek"
    ];

    ALIVE_civilianMarineBuildingTypes = ALIVE_civilianMarineBuildingTypes + [
        "nav_pier",
        "pier_",
        "pier"
    ];

    ALIVE_civilianRailBuildingTypes = ALIVE_civilianRailBuildingTypes + [
    ];

    ALIVE_civilianFuelBuildingTypes = ALIVE_civilianFuelBuildingTypes + [
        "fuelstation",
        "indpipe",
        "ind_tankbig"
    ];

    ALIVE_civilianConstructionBuildingTypes = ALIVE_civilianConstructionBuildingTypes + [
        "wip",
        "sawmillpen",
        "workshop",
        "cementworks"
    ];

    ALIVE_civilianSettlementBuildingTypes = ALIVE_civilianSettlementBuildingTypes + [
        "generalstore",
        "house",
        "dum_",
        "hut"
    ];

};

// Torabora
if(_worldName == "torabora") then {

    ALIVE_airBuildingTypes = ALIVE_airBuildingTypes + [
    ];

    ALIVE_militaryParkingBuildingTypes = ALIVE_militaryParkingBuildingTypes + [
    ];

    ALIVE_militarySupplyBuildingTypes = ALIVE_militarySupplyBuildingTypes + [
    ];

    ALIVE_militaryHQBuildingTypes = ALIVE_militaryHQBuildingTypes + [
    ];

    ALIVE_militaryAirBuildingTypes = ALIVE_militaryAirBuildingTypes + [
    ];

    ALIVE_civilianAirBuildingTypes = ALIVE_civilianAirBuildingTypes + [
    ];

    ALIVE_militaryHeliBuildingTypes = ALIVE_militaryHeliBuildingTypes + [
    ];

    ALIVE_civilianHeliBuildingTypes = ALIVE_civilianHeliBuildingTypes + [
    ];

    ALIVE_militaryBuildingTypes = ALIVE_militaryBuildingTypes + [
    ];

    ALIVE_civilianHQBuildingTypes = ALIVE_civilianHQBuildingTypes + [
    ];

    ALIVE_civilianPowerBuildingTypes = ALIVE_civilianPowerBuildingTypes + [
    ];

    ALIVE_civilianCommsBuildingTypes = ALIVE_civilianCommsBuildingTypes + [
    ];

    ALIVE_civilianMarineBuildingTypes = ALIVE_civilianMarineBuildingTypes + [
    ];

    ALIVE_civilianRailBuildingTypes = ALIVE_civilianRailBuildingTypes + [
    ];

    ALIVE_civilianFuelBuildingTypes = ALIVE_civilianFuelBuildingTypes + [
    ];

    ALIVE_civilianConstructionBuildingTypes = ALIVE_civilianConstructionBuildingTypes + [
        "construction"
    ];

    ALIVE_civilianSettlementBuildingTypes = ALIVE_civilianSettlementBuildingTypes + [
        "house"
    ];

};

// TUP Qom
if(_worldName == "tup_qom") then {

    ALIVE_airBuildingTypes = ALIVE_airBuildingTypes + [
        "hangar"
    ];

    ALIVE_militaryParkingBuildingTypes = ALIVE_militaryParkingBuildingTypes + [
        "barrack"
    ];

    ALIVE_militarySupplyBuildingTypes = ALIVE_militarySupplyBuildingTypes + [
        "barrack",
        "mil_house",
        "mil_controltower",
        "guardhouse"
    ];

    ALIVE_militaryHQBuildingTypes = ALIVE_militaryHQBuildingTypes + [
        "barrack",
        "mil_house",
        "mil_controltower"
    ];

    ALIVE_militaryAirBuildingTypes = ALIVE_militaryAirBuildingTypes + [

    ];

    ALIVE_civilianAirBuildingTypes = ALIVE_civilianAirBuildingTypes + [
        "ss_hangar",
        "hangar_2",
        "hangar",
        "runway_beton",
        "runway_end",
        "runway_main",
        "runway_secondary"
    ];

    ALIVE_militaryHeliBuildingTypes = ALIVE_militaryHeliBuildingTypes + [
        "heli_h_army"
    ];

    ALIVE_civilianHeliBuildingTypes = ALIVE_civilianHeliBuildingTypes + [
    ];

    ALIVE_militaryBuildingTypes = ALIVE_militaryBuildingTypes + [
        "vez",
        "barrack",
        "mil_house",
        "mil_controltower",
        "guardhouse"
    ];

    ALIVE_civilianHQBuildingTypes = ALIVE_civilianHQBuildingTypes + [
        "a_office01",
        "a_office02"
    ];

    ALIVE_civilianPowerBuildingTypes = ALIVE_civilianPowerBuildingTypes + [
        "pec_",
        "powerstation",
        "trafostanica",
        "powerstation"
    ];

    ALIVE_civilianCommsBuildingTypes = ALIVE_civilianCommsBuildingTypes + [
        "illuminanttower",
        "vysilac_fm",
        "telek",
        "tvtower"
    ];

    ALIVE_civilianMarineBuildingTypes = ALIVE_civilianMarineBuildingTypes + [
    ];

    ALIVE_civilianRailBuildingTypes = ALIVE_civilianRailBuildingTypes + [
        "stationhouse"
    ];

    ALIVE_civilianFuelBuildingTypes = ALIVE_civilianFuelBuildingTypes + [
        "fuelstation",
        "expedice",
        "indpipe",
        "komin",
        "ind_stack_big",
        "ind_tankbig",
        "fuel_tank_big"
    ];

    ALIVE_civilianConstructionBuildingTypes = ALIVE_civilianConstructionBuildingTypes + [
        "ind_mlyn_01",
        "wip",
        "workshop",
        "ind_coltan_mine"
    ];

    ALIVE_civilianSettlementBuildingTypes = ALIVE_civilianSettlementBuildingTypes + [
        "hospital",
        "generalstore",
        "house"
    ];

};

// Utes
if(_worldName == "utes") then {

    ALIVE_airBuildingTypes = ALIVE_airBuildingTypes + [
        "hangar"
    ];

    ALIVE_militaryParkingBuildingTypes = ALIVE_militaryParkingBuildingTypes + [
        "barrack"
    ];

    ALIVE_militarySupplyBuildingTypes = ALIVE_militarySupplyBuildingTypes + [
        "barrack",
        "mil_house",
        "mil_controltower",
        "guardhouse"
    ];

    ALIVE_militaryHQBuildingTypes = ALIVE_militaryHQBuildingTypes + [
        "barrack",
        "mil_house",
        "mil_controltower"
    ];

    ALIVE_militaryAirBuildingTypes = ALIVE_militaryAirBuildingTypes + [

    ];

    ALIVE_civilianAirBuildingTypes = ALIVE_civilianAirBuildingTypes + [
        "ss_hangar",
        "hangar_2",
        "hangar"
    ];

    ALIVE_militaryHeliBuildingTypes = ALIVE_militaryHeliBuildingTypes + [
    ];

    ALIVE_civilianHeliBuildingTypes = ALIVE_civilianHeliBuildingTypes + [
    ];

    ALIVE_militaryBuildingTypes = ALIVE_militaryBuildingTypes + [
        "vez",
        "barrack",
        "mil_house",
        "mil_controltower",
        "guardhouse"
    ];

    ALIVE_civilianHQBuildingTypes = ALIVE_civilianHQBuildingTypes + [
    ];

    ALIVE_civilianPowerBuildingTypes = ALIVE_civilianPowerBuildingTypes + [
    ];

    ALIVE_civilianCommsBuildingTypes = ALIVE_civilianCommsBuildingTypes + [
    ];

    ALIVE_civilianMarineBuildingTypes = ALIVE_civilianMarineBuildingTypes + [
        "nav_"
    ];

    ALIVE_civilianRailBuildingTypes = ALIVE_civilianRailBuildingTypes + [
    ];

    ALIVE_civilianFuelBuildingTypes = ALIVE_civilianFuelBuildingTypes + [
    ];

    ALIVE_civilianConstructionBuildingTypes = ALIVE_civilianConstructionBuildingTypes + [
    ];

    ALIVE_civilianSettlementBuildingTypes = ALIVE_civilianSettlementBuildingTypes + [
        "house"
    ];

};

// Nziwasogo
if(_worldName == "pja305") then {

    ALIVE_airBuildingTypes = ALIVE_airBuildingTypes + [
        "hangar"
    ];

    ALIVE_militaryParkingBuildingTypes = ALIVE_militaryParkingBuildingTypes + [
        "fortified"
    ];

    ALIVE_militarySupplyBuildingTypes = ALIVE_militarySupplyBuildingTypes + [
        "barrack",
        "mil_house",
        "mil_controltower",
        "fortified"
    ];

    ALIVE_militaryHQBuildingTypes = ALIVE_militaryHQBuildingTypes + [
        "barrack",
        "mil_house",
        "mil_controltower"
    ];

    ALIVE_militaryAirBuildingTypes = ALIVE_militaryAirBuildingTypes + [

    ];

    ALIVE_civilianAirBuildingTypes = ALIVE_civilianAirBuildingTypes + [
        "ss_hangar",
        "hangar_2",
        "hangar"
    ];

    ALIVE_militaryHeliBuildingTypes = ALIVE_militaryHeliBuildingTypes + [

    ];

    ALIVE_civilianHeliBuildingTypes = ALIVE_civilianHeliBuildingTypes + [

    ];

    ALIVE_militaryBuildingTypes = ALIVE_militaryBuildingTypes + [
        "vez",
        "watchtower",
        "fortified"
    ];

    ALIVE_civilianHQBuildingTypes = ALIVE_civilianHQBuildingTypes + [
        "a_office01",
        "a_office02"
    ];

    ALIVE_civilianPowerBuildingTypes = ALIVE_civilianPowerBuildingTypes + [
        "pec_",
        "powerstation",
        "trafostanica"
    ];

    ALIVE_civilianCommsBuildingTypes = ALIVE_civilianCommsBuildingTypes + [
        "illuminanttower",
        "vysilac_fm",
        "telek"
    ];

    ALIVE_civilianMarineBuildingTypes = ALIVE_civilianMarineBuildingTypes + [
        "crane",
        "wtower",
        "najezd",
        "cargo"
    ];

    ALIVE_civilianRailBuildingTypes = ALIVE_civilianRailBuildingTypes + [
        "stationhouse"
    ];

    ALIVE_civilianFuelBuildingTypes = ALIVE_civilianFuelBuildingTypes + [
        "fuelstation",
        "expedice",
        "indpipe",
        "komin",
        "ind_tankbig",
        "fuel_tank_big"
    ];

    ALIVE_civilianConstructionBuildingTypes = ALIVE_civilianConstructionBuildingTypes + [
        "ind_mlyn_01",
        "ind_pec_01",
        "wip",
        "sawmillpen",
        "workshop"
    ];

    ALIVE_civilianSettlementBuildingTypes = ALIVE_civilianSettlementBuildingTypes + [
        "hospital",
        "dum",
        "shed",
        "hut",
        "house"
    ];

};


/*
 * Custom mappings for unit mods
 * Use these mappings to override difficult unit mod CfgGroup configs
 */


ALIVE_factionCustomMappings = [] call ALIVE_fnc_hashCreate;

// EXAMPLE BLU_F_G CUSTOM CONFIG MAPPING
// ---------------------------------------------------------------------------------------------------------------------
BLU_G_F_mappings = [] call ALIVE_fnc_hashCreate;
[BLU_G_F_mappings, "Side", "WEST"] call ALIVE_fnc_hashSet;
[BLU_G_F_mappings, "GroupSideName", "WEST"] call ALIVE_fnc_hashSet;
[BLU_G_F_mappings, "FactionName", "BLU_G_F"] call ALIVE_fnc_hashSet;
[BLU_G_F_mappings, "GroupFactionName", "Guerilla"] call ALIVE_fnc_hashSet;

BLU_G_F_typeMappings = [] call ALIVE_fnc_hashCreate;
[BLU_G_F_typeMappings, "Air", "Air"] call ALIVE_fnc_hashSet;
[BLU_G_F_typeMappings, "Armored", "Armored"] call ALIVE_fnc_hashSet;
[BLU_G_F_typeMappings, "Infantry", "Infantry"] call ALIVE_fnc_hashSet;
[BLU_G_F_typeMappings, "Mechanized", "Mechanized"] call ALIVE_fnc_hashSet;
[BLU_G_F_typeMappings, "Motorized", "Motorized"] call ALIVE_fnc_hashSet;
[BLU_G_F_typeMappings, "Motorized_MTP", "Motorized_MTP"] call ALIVE_fnc_hashSet;
[BLU_G_F_typeMappings, "SpecOps", "SpecOps"] call ALIVE_fnc_hashSet;
[BLU_G_F_typeMappings, "Support", "Support"] call ALIVE_fnc_hashSet;

[BLU_G_F_mappings, "GroupFactionTypes", BLU_G_F_typeMappings] call ALIVE_fnc_hashSet;
[ALIVE_factionCustomMappings, "BLU_G_F", BLU_G_F_mappings] call ALIVE_fnc_hashSet;
// ---------------------------------------------------------------------------------------------------------------------

// dr Irregulars
// ---------------------------------------------------------------------------------------------------------------------
/*
drIrregulars_mappings = [] call ALIVE_fnc_hashCreate;
[drIrregulars_mappings, "Side", "INDEP"] call ALIVE_fnc_hashSet;
[drIrregulars_mappings, "GroupSideName", "INDEP"] call ALIVE_fnc_hashSet;
[drIrregulars_mappings, "FactionName", "drIrregulars"] call ALIVE_fnc_hashSet;
[drIrregulars_mappings, "GroupFactionName", "drIrregulars"] call ALIVE_fnc_hashSet;

drIrregulars_typeMappings = [] call ALIVE_fnc_hashCreate;
[drIrregulars_typeMappings, "Air", "Air"] call ALIVE_fnc_hashSet;
[drIrregulars_typeMappings, "Armored", "Armored"] call ALIVE_fnc_hashSet;
[drIrregulars_typeMappings, "Infantry", "Infantry"] call ALIVE_fnc_hashSet;
[drIrregulars_typeMappings, "Mechanized", "Mechanized"] call ALIVE_fnc_hashSet;
[drIrregulars_typeMappings, "Motorized", "Motorized"] call ALIVE_fnc_hashSet;
[drIrregulars_typeMappings, "Motorized_MTP", "Motorized_MTP"] call ALIVE_fnc_hashSet;
[drIrregulars_typeMappings, "SpecOps", "SpecOps"] call ALIVE_fnc_hashSet;
[drIrregulars_typeMappings, "Support", "Support"] call ALIVE_fnc_hashSet;

[drIrregulars_mappings, "GroupFactionTypes", drIrregulars_typeMappings] call ALIVE_fnc_hashSet;
[ALIVE_factionCustomMappings, "drIrregulars", drIrregulars_mappings] call ALIVE_fnc_hashSet;

[ALIVE_factionDefaultSupplies, "drIrregulars", ["Box_mas_ru_rifle_Wps_F"]] call ALIVE_fnc_hashSet;
*/
// ---------------------------------------------------------------------------------------------------------------------

// African
// ---------------------------------------------------------------------------------------------------------------------
mas_afr_rebl_o_mappings = [] call ALIVE_fnc_hashCreate;
[mas_afr_rebl_o_mappings, "Side", "EAST"] call ALIVE_fnc_hashSet;
[mas_afr_rebl_o_mappings, "GroupSideName", "EAST"] call ALIVE_fnc_hashSet;
[mas_afr_rebl_o_mappings, "FactionName", "mas_afr_rebl_o"] call ALIVE_fnc_hashSet;
[mas_afr_rebl_o_mappings, "GroupFactionName", "OPF_mas_afr_F_o"] call ALIVE_fnc_hashSet;

mas_afr_rebl_o_typeMappings = [] call ALIVE_fnc_hashCreate;
[mas_afr_rebl_o_typeMappings, "Air", "Air"] call ALIVE_fnc_hashSet;
[mas_afr_rebl_o_typeMappings, "Armored", "Armored"] call ALIVE_fnc_hashSet;
[mas_afr_rebl_o_typeMappings, "Infantry", "Infantry_mas_afr_o"] call ALIVE_fnc_hashSet;
[mas_afr_rebl_o_typeMappings, "Mechanized", "Mechanized"] call ALIVE_fnc_hashSet;
[mas_afr_rebl_o_typeMappings, "Motorized", "Motorized_mas_afr_o"] call ALIVE_fnc_hashSet;
[mas_afr_rebl_o_typeMappings, "Motorized_MTP", "Motorized_MTP"] call ALIVE_fnc_hashSet;
[mas_afr_rebl_o_typeMappings, "SpecOps", "Recon_mas_afr_o"] call ALIVE_fnc_hashSet;
[mas_afr_rebl_o_typeMappings, "Support", "Support"] call ALIVE_fnc_hashSet;

[mas_afr_rebl_o_mappings, "GroupFactionTypes", mas_afr_rebl_o_typeMappings] call ALIVE_fnc_hashSet;
[ALIVE_factionCustomMappings, "mas_afr_rebl_o", mas_afr_rebl_o_mappings] call ALIVE_fnc_hashSet;

[ALIVE_factionDefaultSupplies, "mas_afr_rebl_o", ["Box_mas_ru_rifle_Wps_F"]] call ALIVE_fnc_hashSet;


mas_afr_rebl_i_mappings = [] call ALIVE_fnc_hashCreate;
[mas_afr_rebl_i_mappings, "Side", "INDEP"] call ALIVE_fnc_hashSet;
[mas_afr_rebl_i_mappings, "GroupSideName", "INDEP"] call ALIVE_fnc_hashSet;
[mas_afr_rebl_i_mappings, "FactionName", "mas_afr_rebl_i"] call ALIVE_fnc_hashSet;
[mas_afr_rebl_i_mappings, "GroupFactionName", "IND_mas_afr_F_i"] call ALIVE_fnc_hashSet;

mas_afr_rebl_i_typeMappings = [] call ALIVE_fnc_hashCreate;
[mas_afr_rebl_i_typeMappings, "Air", "Air"] call ALIVE_fnc_hashSet;
[mas_afr_rebl_i_typeMappings, "Armored", "Armored"] call ALIVE_fnc_hashSet;
[mas_afr_rebl_i_typeMappings, "Infantry", "Infantry_mas_afr_i"] call ALIVE_fnc_hashSet;
[mas_afr_rebl_i_typeMappings, "Mechanized", "Mechanized"] call ALIVE_fnc_hashSet;
[mas_afr_rebl_i_typeMappings, "Motorized", "Motorized_mas_afr_i"] call ALIVE_fnc_hashSet;
[mas_afr_rebl_i_typeMappings, "Motorized_MTP", "Motorized_MTP"] call ALIVE_fnc_hashSet;
[mas_afr_rebl_i_typeMappings, "SpecOps", "Recon_mas_afr_i"] call ALIVE_fnc_hashSet;
[mas_afr_rebl_i_typeMappings, "Support", "Support"] call ALIVE_fnc_hashSet;

[mas_afr_rebl_i_mappings, "GroupFactionTypes", mas_afr_rebl_i_typeMappings] call ALIVE_fnc_hashSet;
[ALIVE_factionCustomMappings, "mas_afr_rebl_i", mas_afr_rebl_i_mappings] call ALIVE_fnc_hashSet;

[ALIVE_factionDefaultSupplies, "mas_afr_rebl_i", ["Box_mas_us_rifle_Wps_F"]] call ALIVE_fnc_hashSet;


mas_afr_rebl_b_mappings = [] call ALIVE_fnc_hashCreate;
[mas_afr_rebl_b_mappings, "Side", "WEST"] call ALIVE_fnc_hashSet;
[mas_afr_rebl_b_mappings, "GroupSideName", "WEST"] call ALIVE_fnc_hashSet;
[mas_afr_rebl_b_mappings, "FactionName", "mas_afr_rebl_b"] call ALIVE_fnc_hashSet;
[mas_afr_rebl_b_mappings, "GroupFactionName", "BLU_mas_afr_F_b"] call ALIVE_fnc_hashSet;

mas_afr_rebl_b_typeMappings = [] call ALIVE_fnc_hashCreate;
[mas_afr_rebl_b_typeMappings, "Air", "Air"] call ALIVE_fnc_hashSet;
[mas_afr_rebl_b_typeMappings, "Armored", "Armored"] call ALIVE_fnc_hashSet;
[mas_afr_rebl_b_typeMappings, "Infantry", "Infantry_mas_afr_b"] call ALIVE_fnc_hashSet;
[mas_afr_rebl_b_typeMappings, "Mechanized", "Mechanized"] call ALIVE_fnc_hashSet;
[mas_afr_rebl_b_typeMappings, "Motorized", "Motorized_mas_afr_b"] call ALIVE_fnc_hashSet;
[mas_afr_rebl_b_typeMappings, "Motorized_MTP", "Motorized_MTP"] call ALIVE_fnc_hashSet;
[mas_afr_rebl_b_typeMappings, "SpecOps", "Recon_mas_afr_b"] call ALIVE_fnc_hashSet;
[mas_afr_rebl_b_typeMappings, "Support", "Support"] call ALIVE_fnc_hashSet;

[mas_afr_rebl_b_mappings, "GroupFactionTypes", mas_afr_rebl_b_typeMappings] call ALIVE_fnc_hashSet;
[ALIVE_factionCustomMappings, "mas_afr_rebl_b", mas_afr_rebl_b_mappings] call ALIVE_fnc_hashSet;

[ALIVE_factionDefaultSupplies, "mas_afr_rebl_b", ["Box_mas_us_rifle_Wps_F"]] call ALIVE_fnc_hashSet;
// ---------------------------------------------------------------------------------------------------------------------


// uksf
// ---------------------------------------------------------------------------------------------------------------------
mas_ukf_sftg_mappings = [] call ALIVE_fnc_hashCreate;
[mas_ukf_sftg_mappings, "Side", "WEST"] call ALIVE_fnc_hashSet;
[mas_ukf_sftg_mappings, "GroupSideName", "WEST"] call ALIVE_fnc_hashSet;
[mas_ukf_sftg_mappings, "FactionName", "mas_ukf_sftg"] call ALIVE_fnc_hashSet;
[mas_ukf_sftg_mappings, "GroupFactionName", "BLU_mas_uk_sof_F"] call ALIVE_fnc_hashSet;

mas_ukf_sftg_typeMappings = [] call ALIVE_fnc_hashCreate;
[mas_ukf_sftg_typeMappings, "Air", "Infantry_mas_uk_d"] call ALIVE_fnc_hashSet;
[mas_ukf_sftg_typeMappings, "Armored", "Infantry_mas_uk_g"] call ALIVE_fnc_hashSet;
[mas_ukf_sftg_typeMappings, "Infantry", "Infantry_mas_uk"] call ALIVE_fnc_hashSet;
[mas_ukf_sftg_typeMappings, "Mechanized", "Infantry_mas_uk_w"] call ALIVE_fnc_hashSet;
[mas_ukf_sftg_typeMappings, "Motorized", "Motorized"] call ALIVE_fnc_hashSet;
[mas_ukf_sftg_typeMappings, "Motorized_MTP", "Motorized_mas_uk"] call ALIVE_fnc_hashSet;
[mas_ukf_sftg_typeMappings, "SpecOps", "Infantry_mas_uk_v"] call ALIVE_fnc_hashSet;
[mas_ukf_sftg_typeMappings, "Support", "Support_mas_uk"] call ALIVE_fnc_hashSet;

[mas_ukf_sftg_mappings, "GroupFactionTypes", mas_ukf_sftg_typeMappings] call ALIVE_fnc_hashSet;
[ALIVE_factionCustomMappings, "mas_ukf_sftg", mas_ukf_sftg_mappings] call ALIVE_fnc_hashSet;

[ALIVE_factionDefaultSupplies, "mas_ukf_sftg", ["Box_mas_us_rifle_Wps_F"]] call ALIVE_fnc_hashSet;
// ---------------------------------------------------------------------------------------------------------------------


// ussf
// ---------------------------------------------------------------------------------------------------------------------
mas_usa_delta_mappings = [] call ALIVE_fnc_hashCreate;
[mas_usa_delta_mappings, "Side", "WEST"] call ALIVE_fnc_hashSet;
[mas_usa_delta_mappings, "GroupSideName", "WEST"] call ALIVE_fnc_hashSet;
[mas_usa_delta_mappings, "FactionName", "mas_usa_delta"] call ALIVE_fnc_hashSet;
[mas_usa_delta_mappings, "GroupFactionName", "BLU_mas_usd_delta_F"] call ALIVE_fnc_hashSet;

mas_usa_delta_typeMappings = [] call ALIVE_fnc_hashCreate;
[mas_usa_delta_typeMappings, "Air", "Air"] call ALIVE_fnc_hashSet;
[mas_usa_delta_typeMappings, "Armored", "Armored"] call ALIVE_fnc_hashSet;
[mas_usa_delta_typeMappings, "Infantry", "Infantry_mas_usd"] call ALIVE_fnc_hashSet;
[mas_usa_delta_typeMappings, "Mechanized", "Mechanized"] call ALIVE_fnc_hashSet;
[mas_usa_delta_typeMappings, "Motorized", "Motorized"] call ALIVE_fnc_hashSet;
[mas_usa_delta_typeMappings, "Motorized_MTP", "Infantry_mas_usd_g"] call ALIVE_fnc_hashSet;
[mas_usa_delta_typeMappings, "SpecOps", "SpecOps"] call ALIVE_fnc_hashSet;
[mas_usa_delta_typeMappings, "Support", "Support"] call ALIVE_fnc_hashSet;

[mas_usa_delta_mappings, "GroupFactionTypes", mas_usa_delta_typeMappings] call ALIVE_fnc_hashSet;
[ALIVE_factionCustomMappings, "mas_usa_delta", mas_usa_delta_mappings] call ALIVE_fnc_hashSet;

[ALIVE_factionDefaultSupplies, "mas_usa_delta", ["Box_mas_us_rifle_Wps_F"]] call ALIVE_fnc_hashSet;


mas_usa_devg_mappings = [] call ALIVE_fnc_hashCreate;
[mas_usa_devg_mappings, "Side", "WEST"] call ALIVE_fnc_hashSet;
[mas_usa_devg_mappings, "GroupSideName", "WEST"] call ALIVE_fnc_hashSet;
[mas_usa_devg_mappings, "FactionName", "mas_usa_devg"] call ALIVE_fnc_hashSet;
[mas_usa_devg_mappings, "GroupFactionName", "BLU_mas_usn_seal_F"] call ALIVE_fnc_hashSet;

mas_usa_devg_typeMappings = [] call ALIVE_fnc_hashCreate;
[mas_usa_devg_typeMappings, "Air", "Air"] call ALIVE_fnc_hashSet;
[mas_usa_devg_typeMappings, "Armored", "Infantry_mas_usn_v"] call ALIVE_fnc_hashSet;
[mas_usa_devg_typeMappings, "Infantry", "Infantry_mas_usn"] call ALIVE_fnc_hashSet;
[mas_usa_devg_typeMappings, "Mechanized", "Infantry_mas_usn_d"] call ALIVE_fnc_hashSet;
[mas_usa_devg_typeMappings, "Motorized", "Motorized"] call ALIVE_fnc_hashSet;
[mas_usa_devg_typeMappings, "Motorized_MTP", "Infantry_mas_usn_g"] call ALIVE_fnc_hashSet;
[mas_usa_devg_typeMappings, "SpecOps", "SpecOps"] call ALIVE_fnc_hashSet;
[mas_usa_devg_typeMappings, "Support", "Support"] call ALIVE_fnc_hashSet;

[mas_usa_devg_mappings, "GroupFactionTypes", mas_usa_devg_typeMappings] call ALIVE_fnc_hashSet;
[ALIVE_factionCustomMappings, "mas_usa_devg", mas_usa_devg_mappings] call ALIVE_fnc_hashSet;

[ALIVE_factionDefaultSupplies, "mas_usa_devg", ["Box_mas_us_rifle_Wps_F"]] call ALIVE_fnc_hashSet;


mas_usa_rang_mappings = [] call ALIVE_fnc_hashCreate;
[mas_usa_rang_mappings, "Side", "WEST"] call ALIVE_fnc_hashSet;
[mas_usa_rang_mappings, "GroupSideName", "WEST"] call ALIVE_fnc_hashSet;
[mas_usa_rang_mappings, "FactionName", "mas_usa_rang"] call ALIVE_fnc_hashSet;
[mas_usa_rang_mappings, "GroupFactionName", "BLU_mas_usr_rang_F"] call ALIVE_fnc_hashSet;

mas_usa_rang_typeMappings = [] call ALIVE_fnc_hashCreate;
[mas_usa_rang_typeMappings, "Air", "Air"] call ALIVE_fnc_hashSet;
[mas_usa_rang_typeMappings, "Armored", "Infantry_mas_usr_v"] call ALIVE_fnc_hashSet;
[mas_usa_rang_typeMappings, "Infantry", "Infantry_mas_usr"] call ALIVE_fnc_hashSet;
[mas_usa_rang_typeMappings, "Mechanized", "Infantry_mas_usr_g"] call ALIVE_fnc_hashSet;
[mas_usa_rang_typeMappings, "Motorized", "Motorized"] call ALIVE_fnc_hashSet;
[mas_usa_rang_typeMappings, "Motorized_MTP", "Infantry_mas_usr_d"] call ALIVE_fnc_hashSet;
[mas_usa_rang_typeMappings, "SpecOps", "Infantry_mas_usr_m"] call ALIVE_fnc_hashSet;
[mas_usa_rang_typeMappings, "Support", "Support"] call ALIVE_fnc_hashSet;

[mas_usa_rang_mappings, "GroupFactionTypes", mas_usa_rang_typeMappings] call ALIVE_fnc_hashSet;
[ALIVE_factionCustomMappings, "mas_usa_rang", mas_usa_rang_mappings] call ALIVE_fnc_hashSet;

[ALIVE_factionDefaultSupplies, "mas_usa_rang", ["Box_mas_us_rifle_Wps_F"]] call ALIVE_fnc_hashSet;


mas_usa_usoc_mappings = [] call ALIVE_fnc_hashCreate;
[mas_usa_usoc_mappings, "Side", "WEST"] call ALIVE_fnc_hashSet;
[mas_usa_usoc_mappings, "GroupSideName", "WEST"] call ALIVE_fnc_hashSet;
[mas_usa_usoc_mappings, "FactionName", "mas_usa_usoc"] call ALIVE_fnc_hashSet;
[mas_usa_usoc_mappings, "GroupFactionName", "BLU_mas_usr_supp_F"] call ALIVE_fnc_hashSet;

mas_usa_usoc_typeMappings = [] call ALIVE_fnc_hashCreate;
[mas_usa_usoc_typeMappings, "Air", "Air"] call ALIVE_fnc_hashSet;
[mas_usa_usoc_typeMappings, "Armored", "Armored"] call ALIVE_fnc_hashSet;
[mas_usa_usoc_typeMappings, "Infantry", "Infantry_mas_usn_w"] call ALIVE_fnc_hashSet;
[mas_usa_usoc_typeMappings, "Mechanized", "Mechanized"] call ALIVE_fnc_hashSet;
[mas_usa_usoc_typeMappings, "Motorized", "Motorized"] call ALIVE_fnc_hashSet;
[mas_usa_usoc_typeMappings, "Motorized_MTP", "Motorized_mas_usr"] call ALIVE_fnc_hashSet;
[mas_usa_usoc_typeMappings, "SpecOps", "SpecOps"] call ALIVE_fnc_hashSet;
[mas_usa_usoc_typeMappings, "Support", "Support_mas_usr"] call ALIVE_fnc_hashSet;

[mas_usa_usoc_mappings, "GroupFactionTypes", mas_usa_usoc_typeMappings] call ALIVE_fnc_hashSet;
[ALIVE_factionCustomMappings, "mas_usa_usoc", mas_usa_usoc_mappings] call ALIVE_fnc_hashSet;

[ALIVE_factionDefaultSupplies, "mas_usa_usoc", ["Box_mas_us_rifle_Wps_F"]] call ALIVE_fnc_hashSet;
// ---------------------------------------------------------------------------------------------------------------------


// PMC POMI
// ---------------------------------------------------------------------------------------------------------------------
PMC_POMI_mappings = [] call ALIVE_fnc_hashCreate;
[PMC_POMI_mappings, "Side", "INDEP"] call ALIVE_fnc_hashSet;
[PMC_POMI_mappings, "GroupSideName", "INDEP"] call ALIVE_fnc_hashSet;
[PMC_POMI_mappings, "FactionName", "PMC_POMI"] call ALIVE_fnc_hashSet;
[PMC_POMI_mappings, "GroupFactionName", "PMC_POMI"] call ALIVE_fnc_hashSet;

PMC_POMI_typeMappings = [] call ALIVE_fnc_hashCreate;
[PMC_POMI_typeMappings, "Air", "Air"] call ALIVE_fnc_hashSet;
[PMC_POMI_typeMappings, "Armored", "Armored"] call ALIVE_fnc_hashSet;
[PMC_POMI_typeMappings, "Infantry", "Infantry"] call ALIVE_fnc_hashSet;
[PMC_POMI_typeMappings, "Mechanized", "Mechanized"] call ALIVE_fnc_hashSet;
[PMC_POMI_typeMappings, "Motorized", "Motorized"] call ALIVE_fnc_hashSet;
[PMC_POMI_typeMappings, "Motorized_MTP", "Motorized_MTP"] call ALIVE_fnc_hashSet;
[PMC_POMI_typeMappings, "SpecOps", "SpecOps"] call ALIVE_fnc_hashSet;
[PMC_POMI_typeMappings, "Support", "Support"] call ALIVE_fnc_hashSet;

[PMC_POMI_mappings, "GroupFactionTypes", PMC_POMI_typeMappings] call ALIVE_fnc_hashSet;
[ALIVE_factionCustomMappings, "PMC_POMI", PMC_POMI_mappings] call ALIVE_fnc_hashSet;
// ---------------------------------------------------------------------------------------------------------------------


// SUD RU
// ---------------------------------------------------------------------------------------------------------------------
SUD_RU_mappings = [] call ALIVE_fnc_hashCreate;
[SUD_RU_mappings, "Side", "INDEP"] call ALIVE_fnc_hashSet;
[SUD_RU_mappings, "GroupSideName", "INDEP"] call ALIVE_fnc_hashSet;
[SUD_RU_mappings, "FactionName", "SUD_RU"] call ALIVE_fnc_hashSet;
[SUD_RU_mappings, "GroupFactionName", "SUD_RU"] call ALIVE_fnc_hashSet;

SUD_RU_typeMappings = [] call ALIVE_fnc_hashCreate;
[SUD_RU_typeMappings, "Air", "Air"] call ALIVE_fnc_hashSet;
[SUD_RU_typeMappings, "Armored", "Armored"] call ALIVE_fnc_hashSet;
[SUD_RU_typeMappings, "Infantry", "Infantry"] call ALIVE_fnc_hashSet;
[SUD_RU_typeMappings, "Mechanized", "Mechanized"] call ALIVE_fnc_hashSet;
[SUD_RU_typeMappings, "Motorized", "Motorized"] call ALIVE_fnc_hashSet;
[SUD_RU_typeMappings, "Motorized_MTP", "Motorized_MTP"] call ALIVE_fnc_hashSet;
[SUD_RU_typeMappings, "SpecOps", "SpecOps"] call ALIVE_fnc_hashSet;
[SUD_RU_typeMappings, "Support", "Support"] call ALIVE_fnc_hashSet;

[SUD_RU_mappings, "GroupFactionTypes", SUD_RU_typeMappings] call ALIVE_fnc_hashSet;
[ALIVE_factionCustomMappings, "SUD_RU", SUD_RU_mappings] call ALIVE_fnc_hashSet;
// ---------------------------------------------------------------------------------------------------------------------


// IRON FRONT
// ---------------------------------------------------------------------------------------------------------------------

LIB_LUFTWAFFE_mappings = [] call ALIVE_fnc_hashCreate;
[LIB_LUFTWAFFE_mappings, "Side", "WEST"] call ALIVE_fnc_hashSet;
[LIB_LUFTWAFFE_mappings, "GroupSideName", "WEST"] call ALIVE_fnc_hashSet;
[LIB_LUFTWAFFE_mappings, "FactionName", "LIB_LUFTWAFFE"] call ALIVE_fnc_hashSet;
[LIB_LUFTWAFFE_mappings, "GroupFactionName", "LIB_LUFTWAFFE"] call ALIVE_fnc_hashSet;

LIB_LUFTWAFFE_typeMappings = [] call ALIVE_fnc_hashCreate;
[LIB_LUFTWAFFE_typeMappings, "Air", "LIB_Air"] call ALIVE_fnc_hashSet;
[LIB_LUFTWAFFE_typeMappings, "Armored", "LIB_Medium_Tanks"] call ALIVE_fnc_hashSet;
[LIB_LUFTWAFFE_typeMappings, "Infantry", "Lib_Infantry"] call ALIVE_fnc_hashSet;
[LIB_LUFTWAFFE_typeMappings, "Mechanized", "LIB_Mechanized_Infantry"] call ALIVE_fnc_hashSet;
[LIB_LUFTWAFFE_typeMappings, "Motorized", "LIB_Motorized_Infantry"] call ALIVE_fnc_hashSet;
[LIB_LUFTWAFFE_typeMappings, "Motorized_MTP", "LIB_Motorized_Infantry"] call ALIVE_fnc_hashSet;
[LIB_LUFTWAFFE_typeMappings, "SpecOps", "SpecOps"] call ALIVE_fnc_hashSet;
[LIB_LUFTWAFFE_typeMappings, "Support", "Support"] call ALIVE_fnc_hashSet;

[LIB_LUFTWAFFE_mappings, "GroupFactionTypes", LIB_LUFTWAFFE_typeMappings] call ALIVE_fnc_hashSet;
[ALIVE_factionCustomMappings, "LIB_LUFTWAFFE", LIB_LUFTWAFFE_mappings] call ALIVE_fnc_hashSet;

[ALIVE_factionDefaultSupports, "LIB_LUFTWAFFE", ["LIB_StuG_III_G","LIB_kfz1","LIB_opelblitz_open_y_camo","LIB_opelblitz_tent_y_camo","Lib_sdkfz251","LIB_SdKfz_7","LIB_SdKfz_7_AA","LIB_SdKfz_7_AA","LIB_PzKpfwVI_B","LIB_PzKpfwVI_B_camo","LIB_PzKpfwVI_B","LIB_PzKpfwVI_E","LIB_PzKpfwIV_H","LIB_PzKpfwV","LIB_StuG_III_G","LIB_StuG_III_G_WS"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultSupplies, "LIB_LUFTWAFFE", ["LIB_WeaponsBox_Big_GER","LIB_Mine_Ammo_Box_Ger","LIB_BasicAmmunitionBox_GER","LIB_BasicWeaponsBox_GER","lib_4Rnd_RPzB","LIB_AmmoCrate_Arty_GER","LIB_AmmoCrate_Mortar_GER"]] call ALIVE_fnc_hashSet;


LIB_PANZERWAFFE_mappings = [] call ALIVE_fnc_hashCreate;
[LIB_PANZERWAFFE_mappings, "Side", "WEST"] call ALIVE_fnc_hashSet;
[LIB_PANZERWAFFE_mappings, "GroupSideName", "WEST"] call ALIVE_fnc_hashSet;
[LIB_PANZERWAFFE_mappings, "FactionName", "LIB_PANZERWAFFE"] call ALIVE_fnc_hashSet;
[LIB_PANZERWAFFE_mappings, "GroupFactionName", "LIB_PANZERWAFFE"] call ALIVE_fnc_hashSet;

LIB_PANZERWAFFE_typeMappings = [] call ALIVE_fnc_hashCreate;
[LIB_PANZERWAFFE_typeMappings, "Air", "LIB_Air"] call ALIVE_fnc_hashSet;
[LIB_PANZERWAFFE_typeMappings, "Armored", "LIB_Medium_Tanks"] call ALIVE_fnc_hashSet;
[LIB_PANZERWAFFE_typeMappings, "Infantry", "Lib_Infantry"] call ALIVE_fnc_hashSet;
[LIB_PANZERWAFFE_typeMappings, "Mechanized", "LIB_Mechanized_Infantry"] call ALIVE_fnc_hashSet;
[LIB_PANZERWAFFE_typeMappings, "Motorized", "LIB_Motorized_Infantry"] call ALIVE_fnc_hashSet;
[LIB_PANZERWAFFE_typeMappings, "Motorized_MTP", "LIB_Motorized_Infantry"] call ALIVE_fnc_hashSet;
[LIB_PANZERWAFFE_typeMappings, "SpecOps", "SpecOps"] call ALIVE_fnc_hashSet;
[LIB_PANZERWAFFE_typeMappings, "Support", "Support"] call ALIVE_fnc_hashSet;

[LIB_PANZERWAFFE_mappings, "GroupFactionTypes", LIB_PANZERWAFFE_typeMappings] call ALIVE_fnc_hashSet;
[ALIVE_factionCustomMappings, "LIB_PANZERWAFFE", LIB_PANZERWAFFE_mappings] call ALIVE_fnc_hashSet;

[ALIVE_factionDefaultSupports, "LIB_PANZERWAFFE", ["LIB_StuG_III_G","LIB_kfz1","LIB_opelblitz_open_y_camo","LIB_opelblitz_tent_y_camo","Lib_sdkfz251","LIB_SdKfz_7","LIB_SdKfz_7_AA","LIB_SdKfz_7_AA","LIB_PzKpfwVI_B","LIB_PzKpfwVI_B_camo","LIB_PzKpfwVI_B","LIB_PzKpfwVI_E","LIB_PzKpfwIV_H","LIB_PzKpfwV","LIB_StuG_III_G","LIB_StuG_III_G_WS"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultSupplies, "LIB_PANZERWAFFE", ["LIB_WeaponsBox_Big_GER","LIB_Mine_Ammo_Box_Ger","LIB_BasicAmmunitionBox_GER","LIB_BasicWeaponsBox_GER","lib_4Rnd_RPzB","LIB_AmmoCrate_Arty_GER","LIB_AmmoCrate_Mortar_GER"]] call ALIVE_fnc_hashSet;


LIB_WEHRMACHT_mappings = [] call ALIVE_fnc_hashCreate;
[LIB_WEHRMACHT_mappings, "Side", "WEST"] call ALIVE_fnc_hashSet;
[LIB_WEHRMACHT_mappings, "GroupSideName", "WEST"] call ALIVE_fnc_hashSet;
[LIB_WEHRMACHT_mappings, "FactionName", "LIB_WEHRMACHT"] call ALIVE_fnc_hashSet;
[LIB_WEHRMACHT_mappings, "GroupFactionName", "LIB_WEHRMACHT"] call ALIVE_fnc_hashSet;

LIB_WEHRMACHT_typeMappings = [] call ALIVE_fnc_hashCreate;
[LIB_WEHRMACHT_typeMappings, "Air", "LIB_Air"] call ALIVE_fnc_hashSet;
[LIB_WEHRMACHT_typeMappings, "Armored", "LIB_Medium_Tanks"] call ALIVE_fnc_hashSet;
[LIB_WEHRMACHT_typeMappings, "Infantry", "Lib_Infantry"] call ALIVE_fnc_hashSet;
[LIB_WEHRMACHT_typeMappings, "Mechanized", "LIB_Mechanized_Infantry"] call ALIVE_fnc_hashSet;
[LIB_WEHRMACHT_typeMappings, "Motorized", "LIB_Motorized_Infantry"] call ALIVE_fnc_hashSet;
[LIB_WEHRMACHT_typeMappings, "Motorized_MTP", "LIB_Motorized_Infantry"] call ALIVE_fnc_hashSet;
[LIB_WEHRMACHT_typeMappings, "SpecOps", "SpecOps"] call ALIVE_fnc_hashSet;
[LIB_WEHRMACHT_typeMappings, "Support", "Support"] call ALIVE_fnc_hashSet;

[LIB_WEHRMACHT_mappings, "GroupFactionTypes", LIB_WEHRMACHT_typeMappings] call ALIVE_fnc_hashSet;
[ALIVE_factionCustomMappings, "LIB_WEHRMACHT", LIB_WEHRMACHT_mappings] call ALIVE_fnc_hashSet;

[ALIVE_factionDefaultSupports, "LIB_WEHRMACHT", ["LIB_StuG_III_G","LIB_kfz1","LIB_opelblitz_open_y_camo","LIB_opelblitz_tent_y_camo","Lib_sdkfz251","LIB_SdKfz_7","LIB_SdKfz_7_AA","LIB_SdKfz_7_AA","LIB_PzKpfwVI_B","LIB_PzKpfwVI_B_camo","LIB_PzKpfwVI_B","LIB_PzKpfwVI_E","LIB_PzKpfwIV_H","LIB_PzKpfwV","LIB_StuG_III_G","LIB_StuG_III_G_WS"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultSupplies, "LIB_WEHRMACHT", ["LIB_WeaponsBox_Big_GER","LIB_Mine_Ammo_Box_Ger","LIB_BasicAmmunitionBox_GER","LIB_BasicWeaponsBox_GER","lib_4Rnd_RPzB","LIB_AmmoCrate_Arty_GER","LIB_AmmoCrate_Mortar_GER"]] call ALIVE_fnc_hashSet;


LNRD_Luft_mappings = [] call ALIVE_fnc_hashCreate;
[LNRD_Luft_mappings, "Side", "WEST"] call ALIVE_fnc_hashSet;
[LNRD_Luft_mappings, "GroupSideName", "WEST"] call ALIVE_fnc_hashSet;
[LNRD_Luft_mappings, "FactionName", "LNRD_Luft"] call ALIVE_fnc_hashSet;
[LNRD_Luft_mappings, "GroupFactionName", "LNRD_Luft"] call ALIVE_fnc_hashSet;

LNRD_Luft_typeMappings = [] call ALIVE_fnc_hashCreate;
[LNRD_Luft_typeMappings, "Air", "LIB_Air"] call ALIVE_fnc_hashSet;
[LNRD_Luft_typeMappings, "Armored", "LIB_Medium_Tanks"] call ALIVE_fnc_hashSet;
[LNRD_Luft_typeMappings, "Infantry", "LNRD_Luft_Infantry"] call ALIVE_fnc_hashSet;
[LNRD_Luft_typeMappings, "Mechanized", "LIB_Mechanized_Infantry"] call ALIVE_fnc_hashSet;
[LNRD_Luft_typeMappings, "Motorized", "LIB_Motorized_Infantry"] call ALIVE_fnc_hashSet;
[LNRD_Luft_typeMappings, "Motorized_MTP", "LIB_Motorized_Infantry"] call ALIVE_fnc_hashSet;
[LNRD_Luft_typeMappings, "SpecOps", "SpecOps"] call ALIVE_fnc_hashSet;
[LNRD_Luft_typeMappings, "Support", "Support"] call ALIVE_fnc_hashSet;

[LNRD_Luft_mappings, "GroupFactionTypes", LNRD_Luft_typeMappings] call ALIVE_fnc_hashSet;
[ALIVE_factionCustomMappings, "LNRD_Luft", LNRD_Luft_mappings] call ALIVE_fnc_hashSet;

[ALIVE_factionDefaultSupports, "LNRD_Luft", ["LIB_StuG_III_G","LIB_kfz1","LIB_opelblitz_open_y_camo","LIB_opelblitz_tent_y_camo","Lib_sdkfz251","LIB_SdKfz_7","LIB_SdKfz_7_AA","LIB_SdKfz_7_AA","LIB_PzKpfwVI_B","LIB_PzKpfwVI_B_camo","LIB_PzKpfwVI_B","LIB_PzKpfwVI_E","LIB_PzKpfwIV_H","LIB_PzKpfwV","LIB_StuG_III_G","LIB_StuG_III_G_WS"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultSupplies, "LNRD_Luft", ["LIB_WeaponsBox_Big_GER","LIB_Mine_Ammo_Box_Ger","LIB_BasicAmmunitionBox_GER","LIB_BasicWeaponsBox_GER","lib_4Rnd_RPzB","LIB_AmmoCrate_Arty_GER","LIB_AmmoCrate_Mortar_GER"]] call ALIVE_fnc_hashSet;


SG_STURM_mappings = [] call ALIVE_fnc_hashCreate;
[SG_STURM_mappings, "Side", "WEST"] call ALIVE_fnc_hashSet;
[SG_STURM_mappings, "GroupSideName", "WEST"] call ALIVE_fnc_hashSet;
[SG_STURM_mappings, "FactionName", "SG_STURM"] call ALIVE_fnc_hashSet;
[SG_STURM_mappings, "GroupFactionName", "SG_STURM"] call ALIVE_fnc_hashSet;

SG_STURM_typeMappings = [] call ALIVE_fnc_hashCreate;
[SG_STURM_typeMappings, "Air", "LIB_Air"] call ALIVE_fnc_hashSet;
[SG_STURM_typeMappings, "Armored", "LIB_Medium_Tanks"] call ALIVE_fnc_hashSet;
[SG_STURM_typeMappings, "Infantry", "SG_Infantry"] call ALIVE_fnc_hashSet;
[SG_STURM_typeMappings, "Mechanized", "LIB_Mechanized_Infantry"] call ALIVE_fnc_hashSet;
[SG_STURM_typeMappings, "Motorized", "LIB_Motorized_Infantry"] call ALIVE_fnc_hashSet;
[SG_STURM_typeMappings, "Motorized_MTP", "LIB_Motorized_Infantry"] call ALIVE_fnc_hashSet;
[SG_STURM_typeMappings, "SpecOps", "SpecOps"] call ALIVE_fnc_hashSet;
[SG_STURM_typeMappings, "Support", "Support"] call ALIVE_fnc_hashSet;

[SG_STURM_mappings, "GroupFactionTypes", SG_STURM_typeMappings] call ALIVE_fnc_hashSet;
[ALIVE_factionCustomMappings, "SG_STURM", SG_STURM_mappings] call ALIVE_fnc_hashSet;

[ALIVE_factionDefaultSupports, "SG_STURM", ["LIB_kfz1","LIB_opelblitz_open_y_camo","LIB_opelblitz_tent_y_camo","Lib_sdkfz251","LIB_SdKfz_7","LIB_SdKfz_7_AA","LIB_SdKfz_7_AA","LIB_PzKpfwVI_B","LIB_PzKpfwVI_B_camo","LIB_PzKpfwVI_B","LIB_PzKpfwVI_E","LIB_PzKpfwIV_H","LIB_PzKpfwV","LIB_StuG_III_G","LIB_StuG_III_G_WS"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultSupplies, "SG_STURM", ["LIB_WeaponsBox_Big_GER","LIB_Mine_Ammo_Box_Ger","LIB_BasicAmmunitionBox_GER","LIB_BasicWeaponsBox_GER","lib_4Rnd_RPzB","LIB_AmmoCrate_Arty_GER","LIB_AmmoCrate_Mortar_GER"]] call ALIVE_fnc_hashSet;


LIB_RKKA_mappings = [] call ALIVE_fnc_hashCreate;
[LIB_RKKA_mappings, "Side", "EAST"] call ALIVE_fnc_hashSet;
[LIB_RKKA_mappings, "GroupSideName", "EAST"] call ALIVE_fnc_hashSet;
[LIB_RKKA_mappings, "FactionName", "LIB_RKKA"] call ALIVE_fnc_hashSet;
[LIB_RKKA_mappings, "GroupFactionName", "LIB_RKKA"] call ALIVE_fnc_hashSet;

LIB_RKKA_typeMappings = [] call ALIVE_fnc_hashCreate;
[LIB_RKKA_typeMappings, "Air", "LIB_Air"] call ALIVE_fnc_hashSet;
[LIB_RKKA_typeMappings, "Armored", "LIB_Medium_Tanks"] call ALIVE_fnc_hashSet;
[LIB_RKKA_typeMappings, "Infantry", "Lib_Infantry"] call ALIVE_fnc_hashSet;
[LIB_RKKA_typeMappings, "Mechanized", "LIB_Mechanized_Infantry"] call ALIVE_fnc_hashSet;
[LIB_RKKA_typeMappings, "Motorized", "LIB_Motorized_Infantry"] call ALIVE_fnc_hashSet;
[LIB_RKKA_typeMappings, "Motorized_MTP", "LIB_Motorized_Infantry"] call ALIVE_fnc_hashSet;
[LIB_RKKA_typeMappings, "SpecOps", "SpecOps"] call ALIVE_fnc_hashSet;
[LIB_RKKA_typeMappings, "Support", "Support"] call ALIVE_fnc_hashSet;

[LIB_RKKA_mappings, "GroupFactionTypes", LIB_RKKA_typeMappings] call ALIVE_fnc_hashSet;
[ALIVE_factionCustomMappings, "LIB_RKKA", LIB_RKKA_mappings] call ALIVE_fnc_hashSet;

[ALIVE_factionDefaultSupports, "LIB_RKKA", ["lib_us6_bm13","LIB_SOV_M3_Halftrack","LIB_Scout_m3","Lib_SdKfz251_captured","lib_us6_tent","lib_us6_open","Lib_Willys_MB","lib_zis5v","LIB_JS2_43","LIB_M4A2_SOV","LIB_SU85","LIB_t34_76","LIB_t34_85"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultSupplies, "LIB_RKKA", ["LIB_BasicAmmunitionBox_SU","LIB_Mine_Ammo_Box_Su","LIB_WeaponsBox_Big_SU","LIB_Lone_Big_Box","LIB_BasicWeaponsBox_SU","LIB_AmmoCrate_Mortar_SU"]] call ALIVE_fnc_hashSet;


LIB_USSR_AIRFORCE_mappings = [] call ALIVE_fnc_hashCreate;
[LIB_USSR_AIRFORCE_mappings, "Side", "EAST"] call ALIVE_fnc_hashSet;
[LIB_USSR_AIRFORCE_mappings, "GroupSideName", "EAST"] call ALIVE_fnc_hashSet;
[LIB_USSR_AIRFORCE_mappings, "FactionName", "LIB_USSR_AIRFORCE"] call ALIVE_fnc_hashSet;
[LIB_USSR_AIRFORCE_mappings, "GroupFactionName", "LIB_USSR_AIRFORCE"] call ALIVE_fnc_hashSet;

LIB_USSR_AIRFORCE_typeMappings = [] call ALIVE_fnc_hashCreate;
[LIB_USSR_AIRFORCE_typeMappings, "Air", "LIB_Air"] call ALIVE_fnc_hashSet;
[LIB_USSR_AIRFORCE_typeMappings, "Armored", "LIB_Medium_Tanks"] call ALIVE_fnc_hashSet;
[LIB_USSR_AIRFORCE_typeMappings, "Infantry", "Lib_Infantry"] call ALIVE_fnc_hashSet;
[LIB_USSR_AIRFORCE_typeMappings, "Mechanized", "LIB_Mechanized_Infantry"] call ALIVE_fnc_hashSet;
[LIB_USSR_AIRFORCE_typeMappings, "Motorized", "LIB_Motorized_Infantry"] call ALIVE_fnc_hashSet;
[LIB_USSR_AIRFORCE_typeMappings, "Motorized_MTP", "LIB_Motorized_Infantry"] call ALIVE_fnc_hashSet;
[LIB_USSR_AIRFORCE_typeMappings, "SpecOps", "SpecOps"] call ALIVE_fnc_hashSet;
[LIB_USSR_AIRFORCE_typeMappings, "Support", "Support"] call ALIVE_fnc_hashSet;

[LIB_USSR_AIRFORCE_mappings, "GroupFactionTypes", LIB_USSR_AIRFORCE_typeMappings] call ALIVE_fnc_hashSet;
[ALIVE_factionCustomMappings, "LIB_USSR_AIRFORCE", LIB_USSR_AIRFORCE_mappings] call ALIVE_fnc_hashSet;

[ALIVE_factionDefaultSupports, "LIB_USSR_AIRFORCE", ["lib_us6_bm13","LIB_SOV_M3_Halftrack","LIB_Scout_m3","Lib_SdKfz251_captured","lib_us6_tent","lib_us6_open","Lib_Willys_MB","lib_zis5v","LIB_JS2_43","LIB_M4A2_SOV","LIB_SU85","LIB_t34_76","LIB_t34_85"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultSupplies, "LIB_USSR_AIRFORCE", ["LIB_BasicAmmunitionBox_SU","LIB_Mine_Ammo_Box_Su","LIB_WeaponsBox_Big_SU","LIB_Lone_Big_Box","LIB_BasicWeaponsBox_SU","LIB_AmmoCrate_Mortar_SU"]] call ALIVE_fnc_hashSet;


LIB_USSR_TANK_TROOPS_mappings = [] call ALIVE_fnc_hashCreate;
[LIB_USSR_TANK_TROOPS_mappings, "Side", "EAST"] call ALIVE_fnc_hashSet;
[LIB_USSR_TANK_TROOPS_mappings, "GroupSideName", "EAST"] call ALIVE_fnc_hashSet;
[LIB_USSR_TANK_TROOPS_mappings, "FactionName", "LIB_USSR_TANK_TROOPS"] call ALIVE_fnc_hashSet;
[LIB_USSR_TANK_TROOPS_mappings, "GroupFactionName", "LIB_USSR_TANK_TROOPS"] call ALIVE_fnc_hashSet;

LIB_USSR_TANK_TROOPS_typeMappings = [] call ALIVE_fnc_hashCreate;
[LIB_USSR_TANK_TROOPS_typeMappings, "Air", "LIB_Air"] call ALIVE_fnc_hashSet;
[LIB_USSR_TANK_TROOPS_typeMappings, "Armored", "LIB_Medium_Tanks"] call ALIVE_fnc_hashSet;
[LIB_USSR_TANK_TROOPS_typeMappings, "Infantry", "Lib_Infantry"] call ALIVE_fnc_hashSet;
[LIB_USSR_TANK_TROOPS_typeMappings, "Mechanized", "LIB_Mechanized_Infantry"] call ALIVE_fnc_hashSet;
[LIB_USSR_TANK_TROOPS_typeMappings, "Motorized", "LIB_Motorized_Infantry"] call ALIVE_fnc_hashSet;
[LIB_USSR_TANK_TROOPS_typeMappings, "Motorized_MTP", "LIB_Motorized_Infantry"] call ALIVE_fnc_hashSet;
[LIB_USSR_TANK_TROOPS_typeMappings, "SpecOps", "SpecOps"] call ALIVE_fnc_hashSet;
[LIB_USSR_TANK_TROOPS_typeMappings, "Support", "Support"] call ALIVE_fnc_hashSet;

[LIB_USSR_TANK_TROOPS_mappings, "GroupFactionTypes", LIB_USSR_TANK_TROOPS_typeMappings] call ALIVE_fnc_hashSet;
[ALIVE_factionCustomMappings, "LIB_USSR_TANK_TROOPS", LIB_USSR_TANK_TROOPS_mappings] call ALIVE_fnc_hashSet;

[ALIVE_factionDefaultSupports, "LIB_USSR_TANK_TROOPS", ["lib_us6_bm13","LIB_SOV_M3_Halftrack","LIB_Scout_m3","Lib_SdKfz251_captured","lib_us6_tent","lib_us6_open","Lib_Willys_MB","lib_zis5v","LIB_JS2_43","LIB_M4A2_SOV","LIB_SU85","LIB_t34_76","LIB_t34_85"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultSupplies, "LIB_USSR_TANK_TROOPS", ["LIB_BasicAmmunitionBox_SU","LIB_Mine_Ammo_Box_Su","LIB_WeaponsBox_Big_SU","LIB_Lone_Big_Box","LIB_BasicWeaponsBox_SU","LIB_AmmoCrate_Mortar_SU"]] call ALIVE_fnc_hashSet;


LIB_GUER_mappings = [] call ALIVE_fnc_hashCreate;
[LIB_GUER_mappings, "Side", "GUER"] call ALIVE_fnc_hashSet;
[LIB_GUER_mappings, "GroupSideName", "Guerrila"] call ALIVE_fnc_hashSet;
[LIB_GUER_mappings, "FactionName", "LIB_GUER"] call ALIVE_fnc_hashSet;
[LIB_GUER_mappings, "GroupFactionName", "LIB_GUER"] call ALIVE_fnc_hashSet;

LIB_GUER_typeMappings = [] call ALIVE_fnc_hashCreate;
[LIB_GUER_typeMappings, "Air", "LIB_Air"] call ALIVE_fnc_hashSet;
[LIB_GUER_typeMappings, "Armored", "LIB_Medium_Tanks"] call ALIVE_fnc_hashSet;
[LIB_GUER_typeMappings, "Infantry", "Lib_Infantry"] call ALIVE_fnc_hashSet;
[LIB_GUER_typeMappings, "Mechanized", "LIB_Mechanized_Infantry"] call ALIVE_fnc_hashSet;
[LIB_GUER_typeMappings, "Motorized", "LIB_Motorized_Infantry"] call ALIVE_fnc_hashSet;
[LIB_GUER_typeMappings, "Motorized_MTP", "LIB_Motorized_Infantry"] call ALIVE_fnc_hashSet;
[LIB_GUER_typeMappings, "SpecOps", "SpecOps"] call ALIVE_fnc_hashSet;
[LIB_GUER_typeMappings, "Support", "Support"] call ALIVE_fnc_hashSet;

[LIB_GUER_mappings, "GroupFactionTypes", LIB_GUER_typeMappings] call ALIVE_fnc_hashSet;
[ALIVE_factionCustomMappings, "LIB_GUER", LIB_GUER_mappings] call ALIVE_fnc_hashSet;

[ALIVE_factionDefaultSupports, "LIB_US_TANK_TROOPS", ["LIB_US_GMC_Tent","LIB_US_GMC_Open","LIB_US_Scout_m3","LIB_US_M3_Halftrack","LIB_US_Willys_MB","LIB_M4A3_75","LIB_M4A3_75_Tubes"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultSupplies, "LIB_US_TANK_TROOPS", ["LIB_BasicAmmunitionBox_US","LIB_BasicWeaponsBox_US","LIB_Mine_AmmoBox_US"]] call ALIVE_fnc_hashSet;


LIB_US_AIRFORCE_mappings = [] call ALIVE_fnc_hashCreate;
[LIB_US_AIRFORCE_mappings, "Side", "GUER"] call ALIVE_fnc_hashSet;
[LIB_US_AIRFORCE_mappings, "GroupSideName", "Guerrila"] call ALIVE_fnc_hashSet;
[LIB_US_AIRFORCE_mappings, "FactionName", "LIB_US_AIRFORCE"] call ALIVE_fnc_hashSet;
[LIB_US_AIRFORCE_mappings, "GroupFactionName", "LIB_US_AIRFORCE"] call ALIVE_fnc_hashSet;

LIB_US_AIRFORCE_typeMappings = [] call ALIVE_fnc_hashCreate;
[LIB_US_AIRFORCE_typeMappings, "Air", "LIB_Air"] call ALIVE_fnc_hashSet;
[LIB_US_AIRFORCE_typeMappings, "Armored", "LIB_Medium_Tanks"] call ALIVE_fnc_hashSet;
[LIB_US_AIRFORCE_typeMappings, "Infantry", "Lib_Infantry"] call ALIVE_fnc_hashSet;
[LIB_US_AIRFORCE_typeMappings, "Mechanized", "LIB_Mechanized_Infantry"] call ALIVE_fnc_hashSet;
[LIB_US_AIRFORCE_typeMappings, "Motorized", "LIB_Motorized_Infantry"] call ALIVE_fnc_hashSet;
[LIB_US_AIRFORCE_typeMappings, "Motorized_MTP", "LIB_Motorized_Infantry"] call ALIVE_fnc_hashSet;
[LIB_US_AIRFORCE_typeMappings, "SpecOps", "SpecOps"] call ALIVE_fnc_hashSet;
[LIB_US_AIRFORCE_typeMappings, "Support", "Support"] call ALIVE_fnc_hashSet;

[LIB_US_AIRFORCE_mappings, "GroupFactionTypes", LIB_US_AIRFORCE_typeMappings] call ALIVE_fnc_hashSet;
[ALIVE_factionCustomMappings, "LIB_US_AIRFORCE", LIB_US_AIRFORCE_mappings] call ALIVE_fnc_hashSet;

[ALIVE_factionDefaultSupports, "LIB_US_AIRFORCE", ["LIB_US_GMC_Tent","LIB_US_GMC_Open","LIB_US_Scout_m3","LIB_US_M3_Halftrack","LIB_US_Willys_MB","LIB_M4A3_75","LIB_M4A3_75_Tubes"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultSupplies, "LIB_US_AIRFORCE", ["LIB_BasicAmmunitionBox_US","LIB_BasicWeaponsBox_US","LIB_Mine_AmmoBox_US"]] call ALIVE_fnc_hashSet;


LIB_US_ARMY_mappings = [] call ALIVE_fnc_hashCreate;
[LIB_US_ARMY_mappings, "Side", "GUER"] call ALIVE_fnc_hashSet;
[LIB_US_ARMY_mappings, "GroupSideName", "Guerrila"] call ALIVE_fnc_hashSet;
[LIB_US_ARMY_mappings, "FactionName", "LIB_US_ARMY"] call ALIVE_fnc_hashSet;
[LIB_US_ARMY_mappings, "GroupFactionName", "LIB_US_ARMY"] call ALIVE_fnc_hashSet;

LIB_US_ARMY_typeMappings = [] call ALIVE_fnc_hashCreate;
[LIB_US_ARMY_typeMappings, "Air", "LIB_Air"] call ALIVE_fnc_hashSet;
[LIB_US_ARMY_typeMappings, "Armored", "LIB_Medium_Tanks"] call ALIVE_fnc_hashSet;
[LIB_US_ARMY_typeMappings, "Infantry", "Lib_Infantry"] call ALIVE_fnc_hashSet;
[LIB_US_ARMY_typeMappings, "Mechanized", "LIB_Mechanized_Infantry"] call ALIVE_fnc_hashSet;
[LIB_US_ARMY_typeMappings, "Motorized", "LIB_Motorized_Infantry"] call ALIVE_fnc_hashSet;
[LIB_US_ARMY_typeMappings, "Motorized_MTP", "LIB_Motorized_Infantry"] call ALIVE_fnc_hashSet;
[LIB_US_ARMY_typeMappings, "SpecOps", "SpecOps"] call ALIVE_fnc_hashSet;
[LIB_US_ARMY_typeMappings, "Support", "Support"] call ALIVE_fnc_hashSet;

[LIB_US_ARMY_mappings, "GroupFactionTypes", LIB_US_ARMY_typeMappings] call ALIVE_fnc_hashSet;
[ALIVE_factionCustomMappings, "LIB_US_ARMY", LIB_US_ARMY_mappings] call ALIVE_fnc_hashSet;

[ALIVE_factionDefaultSupports, "LIB_US_ARMY", ["LIB_US_GMC_Tent","LIB_US_GMC_Open","LIB_US_Scout_m3","LIB_US_M3_Halftrack","LIB_US_Willys_MB","LIB_M4A3_75","LIB_M4A3_75_Tubes"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultSupplies, "LIB_US_ARMY", ["LIB_BasicAmmunitionBox_US","LIB_BasicWeaponsBox_US","LIB_Mine_AmmoBox_US"]] call ALIVE_fnc_hashSet;


LIB_US_TANK_TROOPS_mappings = [] call ALIVE_fnc_hashCreate;
[LIB_US_TANK_TROOPS_mappings, "Side", "GUER"] call ALIVE_fnc_hashSet;
[LIB_US_TANK_TROOPS_mappings, "GroupSideName", "Guerrila"] call ALIVE_fnc_hashSet;
[LIB_US_TANK_TROOPS_mappings, "FactionName", "LIB_US_TANK_TROOPS"] call ALIVE_fnc_hashSet;
[LIB_US_TANK_TROOPS_mappings, "GroupFactionName", "LIB_US_TANK_TROOPS"] call ALIVE_fnc_hashSet;

LIB_US_TANK_TROOPS_typeMappings = [] call ALIVE_fnc_hashCreate;
[LIB_US_TANK_TROOPS_typeMappings, "Air", "LIB_Air"] call ALIVE_fnc_hashSet;
[LIB_US_TANK_TROOPS_typeMappings, "Armored", "LIB_Medium_Tanks"] call ALIVE_fnc_hashSet;
[LIB_US_TANK_TROOPS_typeMappings, "Infantry", "Lib_Infantry"] call ALIVE_fnc_hashSet;
[LIB_US_TANK_TROOPS_typeMappings, "Mechanized", "LIB_Mechanized_Infantry"] call ALIVE_fnc_hashSet;
[LIB_US_TANK_TROOPS_typeMappings, "Motorized", "LIB_Motorized_Infantry"] call ALIVE_fnc_hashSet;
[LIB_US_TANK_TROOPS_typeMappings, "Motorized_MTP", "LIB_Motorized_Infantry"] call ALIVE_fnc_hashSet;
[LIB_US_TANK_TROOPS_typeMappings, "SpecOps", "SpecOps"] call ALIVE_fnc_hashSet;
[LIB_US_TANK_TROOPS_typeMappings, "Support", "Support"] call ALIVE_fnc_hashSet;

[LIB_US_TANK_TROOPS_mappings, "GroupFactionTypes", LIB_US_TANK_TROOPS_typeMappings] call ALIVE_fnc_hashSet;
[ALIVE_factionCustomMappings, "LIB_US_TANK_TROOPS", LIB_US_TANK_TROOPS_mappings] call ALIVE_fnc_hashSet;

[ALIVE_factionDefaultSupports, "LIB_US_TANK_TROOPS", ["LIB_US_GMC_Tent","LIB_US_GMC_Open","LIB_US_Scout_m3","LIB_US_M3_Halftrack","LIB_US_Willys_MB","LIB_M4A3_75","LIB_M4A3_75_Tubes"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultSupplies, "LIB_US_TANK_TROOPS", ["LIB_BasicAmmunitionBox_US","LIB_BasicWeaponsBox_US","LIB_Mine_AmmoBox_US"]] call ALIVE_fnc_hashSet;
// ---------------------------------------------------------------------------------------------------------------------
