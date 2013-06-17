// Configuration file

// RESPAWN LOCATION list
// You can define vehicle or object
INS_REV_CFG_list_of_respawn_locations_blufor = ["base","mobile_1","air_1","boat_1"];
INS_REV_CFG_list_of_respawn_locations_opfor = ["base2","car_1"];
INS_REV_CFG_list_of_respawn_locations_civ = [];
INS_REV_CFG_list_of_respawn_locations_guer = [];

// Admin reserved slot
// You can reserve admin slot/
INS_REV_CFG_reserved_slot = true;
INS_REV_CFG_reserved_slot_units = ["admin"];

// LANGUAGE
// Language selection ("en" for english, you can create your own "XX_strings_lang.sqf" file)
INS_REV_CFG_language = "en";


/**
 * ALLOW TO REVIVE (system with three variables)
 * There are different ways to define who can revive unconscious bodies.
 * 
 * The variable INS_REV_CFG_list_of_classnames_who_can_revive contains the list of classnames (i.e. the types of soldiers) who can revive.
 * To allow every soldiers to revive, you can write : INS_REV_CFG_list_of_classnames_who_can_revive = ["CAManBase"];
 * To allow USMC officers and medics, you can write : INS_REV_CFG_list_of_classnames_who_can_revive = ["USMC_Soldier_Officer", "USMC_Soldier_Medic"];
 * To not use the classnames to specify who can revive, you can write an empty list : INS_REV_CFG_list_of_classnames_who_can_revive = [];
 * To know the different classnames of soldiers, you can visit this page : http://browser.six-projects.net/cfg_vehicles/tree?utf8=%E2%9C%93&version=67
 * 
 * The variable INS_REV_CFG_list_of_slots_who_can_revive contains the list of named slots (or units) who can revive.
 * For example, consider that you have two playable units named "medic1" and "medic2" in your mission editor.
 * To allow these two medics to revive, you can write : INS_REV_CFG_list_of_slots_who_can_revive = [medic1, medic2];
 * To not use the slots list to specify who can revive, you can write an empty list : INS_REV_CFG_list_of_slots_who_can_revive = [];
 * 
 * The variable INS_REV_CFG_all_medics_can_revive is a boolean to allow all medics to revive.
 * 
 * These three variables can be used together. The players who can revive are the union of the allowed players for each variable.
 * For example, if you set :
 *   INS_REV_CFG_all_player_can_revive = false;
 *   INS_REV_CFG_all_medics_can_revive = true;
 *   INS_REV_CFG_list_of_classnames_who_can_revive = ["USMC_Soldier_Officer"];
 *   INS_REV_CFG_list_of_slots_who_can_revive = [special_slot1, special_slot2];
 * then all the medics, all the "USMC_Soldier_Officer" and the players at special_slot1, special_slot1 can revive.
 * If a player "appears" in two categories (e.g. he is an "USMC_Soldier_Officer" at the slot named "special_slot2"),
 * it is not a matter. He will be allowed to revive without problem.
 * 
 * The value of the three variables can be changed with an external script at any time with an instant effect.
 */
//
//INS_REV_CFG_all_player_can_revive = true;	// Overrided by decription.ext parameter
//INS_REV_CFG_all_medics_can_revive = true;	// Overrided by decription.ext parameter
INS_REV_CFG_list_of_classnames_who_can_revive = [];
INS_REV_CFG_list_of_slots_who_can_revive = [];


// Validate Config
#include "validate_cfg.sqf"
