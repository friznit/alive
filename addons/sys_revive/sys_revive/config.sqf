/** Configuration file **/

/** LANGUAGE - Language selection ("en" for english, "fr" for french, or other if you create your own "XX_strings_lang.sqf" file) **/
REV_CFG_langage = "en";

/** NUMBER OF REVIVES - Maximal number of revives for a player **/
REV_CFG_Number_Revives = 999;

/** ALLOW RESPAWN - True to permits the player to respawn at the "respawn_xxx" marker when he has no more revive credits or if there is no medic to revive **/
REV_CFG_Allow_Respawn = true;

/** ALLOW SPECTATOR CAM - True to allow the players who are out of the game (no more revive credits and respawn at camp forbidden) to view the game in camera mode **/
REV_CFG_Spectator_Cam = true;

/** SHOW MARKER - True to show a marker on map on the position of players who are waiting for being revived **/
REV_CFG_Show_Player_Marker = true;

/** STILL INJURED AFTER REVIVE - True to keep the revived player slightly injured. So there would be a need to be healed by a ("real") medic or a MASH (more "realistic") **/
REV_CFG_Injured_On_Revive = true;

/** ALLOW TO DRAG BODY - True to allow any player to drag unconscious bodies. The value can be changed with an external script at any time with an instant effect **/
REV_CFG_Allow_To_Drag_Body = true;

/** Revive classnames **/ //TODO: needs to be revised
REV_CFG_Classnames_That_Can_Revive = [];
REV_CFG_Player_Slots_That_Can_Revive = [];
REV_CFG_All_Medic_Can_Revive = true;

//TODO: needs to be revised
/**
 * ALLOW TO REVIVE (system with three variables)
 * There are different ways to define who can revive unconscious bodies.
 * 
 * The variable REV_CFG_Classnames_That_Can_Revive contains the list of classnames (i.e. the types of soldiers) who can revive.
 * To allow every soldiers to revive, you can write : REV_CFG_Classnames_That_Can_Revive = ["CAManBase"];
 * To allow USMC officers and medics, you can write : REV_CFG_Classnames_That_Can_Revive = ["USMC_Soldier_Officer", "USMC_Soldier_Medic"];
 * To not use the classnames to specify who can revive, you can write an empty list : REV_CFG_Classnames_That_Can_Revive = [];
 * 
 * The variable REV_CFG_Player_Slots_That_Can_Revive contains the list of named slots (or units) who can revive.
 * For example, consider that you have two playable units named "medic1" and "medic2" in your mission editor.
 * To allow these two medics to revive, you can write : REV_CFG_Player_Slots_That_Can_Revive = [medic1, medic2];
 * To not use the slots list to specify who can revive, you can write an empty list : REV_CFG_Player_Slots_That_Can_Revive = [];
 * 
 * The variable REV_CFG_All_Medic_Can_Revive is a boolean to allow all medics to revive.
 * 
 * These three variables can be used together. The players who can revive are the union of the allowed players for each variable.
 * For example, if you set :
 *   REV_CFG_Classnames_That_Can_Revive = ["USMC_Soldier_Officer"];
 *   REV_CFG_Player_Slots_That_Can_Revive = [special_slot1, special_slot2];
 *   REV_CFG_All_Medic_Can_Revive = true;
 * then all the medics, all the "USMC_Soldier_Officer" and the players at special_slot1, special_slot1 can revive.
 * If a player "appears" in two categories (e.g. he is an "USMC_Soldier_Officer" at the slot named "special_slot2"),
 * it is not a matter. He will be allowed to revive without problem.
 * 
 * The value of the three variables can be changed with an external script at any time with an instant effect.
 * 
 */
 