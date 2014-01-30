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
	"O_diver_F",
	"O_diver_TL_F",
	"O_diver_exp_F",
	"O_helipilot_F",
	"O_UAV_AI",
	"B_diver_F",
	"B_diver_TL_F",
	"B_diver_exp_F",
	"B_Helipilot_F",
	"B_RangeMaster_F",
	"B_helipilot_F",
	"B_UAV_AI",
	"I_helicrew_F",
	"I_diver_F",
	"I_diver_TL_F",
	"I_diver_exp_F",
	"I_crew_F"
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


/*
 * CP MP building types for cluster generation
 */

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


/*
 * Custom building types for specific maps
 * Add to default building lists for specific maps
 */


_worldName = worldName;


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
        "Land_lib_Mil_Barracks",
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
        "Dom",
        "dum",
        "kulna",
        "statek",
        "afbar",
        "Panelak",
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

// Nziwasogo
if(_worldName == "pja305") then {

    /*
    ALIVE_militaryParkingBuildingTypes = ALIVE_militaryParkingBuildingTypes + [
        "army",
        "vez"
    ];

    ALIVE_militarySupplyBuildingTypes = ALIVE_militarySupplyBuildingTypes + [
        "army"
    ];

    ALIVE_militaryHQBuildingTypes = ALIVE_militaryHQBuildingTypes + [
        "Land_lib_Mil_Barracks",
        "mesto3"
    ];

    ALIVE_militaryBuildingTypes = ALIVE_militaryBuildingTypes + [
        "vez",
        "hlaska"
    ];

    ALIVE_civilianHQBuildingTypes = ALIVE_civilianHQBuildingTypes + [
        "rohova"
    ];
    */

    ALIVE_civilianSettlementBuildingTypes = ALIVE_civilianSettlementBuildingTypes + [
        "dum",
        "Shed",
        "hut",
        "House",
        "Dom"
    ];


    ALIVE_civilianMarineBuildingTypes = ALIVE_civilianMarineBuildingTypes + [
        "najezd",
        "cargo"
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
