/*
 * Initialize INS_revive sytem
 * 
 * Copyleft 2013 naong
 * 
 * This program is free software under the terms of the GNU General Public License version 3.
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

// Load Config File
#include "config.sqf"

// Set JIP variable
if (isNil "isJIP") then {
	isJIP = false;
	player setVariable ["isJIP", false, true];
} else {
	if (isJIP) then {
		player setVariable ["isJIP", true, true];
	} else {
		player setVariable ["isJIP", false, true];
	};
};

// Check for Arma 3 or 2
GVAR_is_arma3 = false;
if (isClass (configfile >> "CfgAddons" >> "PreloadAddons" >> "A3")) then {
    GVAR_is_arma3 = true;
};

// Check for Arma 2 OA
GVAR_is_arma2oa = false;
if (isClass (configthreade >> "CfgVehicles" >> "BAF_Soldier_MTP")) then {
	GVAR_is_arma2oa = true;
};

// Check Ace Mode
if (isServer) then {
	if (isClass(configFile >> "CfgPatches" >> "ace_main")) then { 
		PVAR_isAce = true;	publicvariable "PVAR_isAce";
	} else {
		PVAR_isAce = false;	publicvariable "PVAR_isAce";
	};
};

// INS_revive Initializing
waitUntil {!isNil "PVAR_isAce"};
if (PVAR_isAce) then {
	ace_wounds_prevtime = 6000;								publicVariable "ace_wounds_prevtime";
	ace_sys_wounds_withSpect = false;						publicVariable "ace_sys_wounds_withSpect";

	ace_sys_eject_fnc_weaponcheck = {};						publicVariable "ace_sys_eject_fnc_weaponcheck";  //disable aircraft weapon removal
	ace_sys_wounds_enabled = true;							publicVariable "ace_sys_wounds_enabled";
	ace_sys_wounds_noai = false;							publicVariable "ace_sys_wounds_noai";
	ace_sys_wounds_leftdam = 0;								publicVariable "ace_sys_wounds_leftdam";
	ace_sys_wounds_all_medics = true;						publicVariable "ace_sys_wounds_all_medics";
	ace_sys_wounds_no_rpunish = true;						publicVariable "ace_sys_wounds_no_rpunish";
	ace_sys_wounds_auto_assist_any = true;					publicVariable "ace_sys_wounds_auto_assist_any";
	ace_sys_wounds_ai_movement_bloodloss = true;			publicVariable "ace_sys_wounds_ai_movement_bloodloss";
	ace_sys_wounds_player_movement_bloodloss = true;		publicVariable "ace_sys_wounds_player_movement_bloodloss";
	ace_sys_wounds_auto_assist = true;						publicVariable "ace_sys_wounds_auto_assist";

	ace_sys_aitalk_enabled = true;							publicVariable "ace_sys_aitalk_enabled";
	ace_sys_aitalk_radio_enabled = true;					publicVariable "ace_sys_aitalk_radio_enabled";
	ace_sys_aitalk_talkforplayer = true;					publicVariable "ace_sys_aitalk_talkforplayer";

	ace_ifak_capacity = 6;									publicVariable "ace_ifak_capacity"; //medical gear slots
	
	Call Compile preprocessFileLineNumbers "INS_revive\revive\init_ace.sqf";
} else {
	Call Compile preprocessFileLineNumbers "INS_revive\revive\init_vanilla.sqf";
};

// INS_revive settings dialog
// if (GVAR_is_arma3) then {
	// [] execVM "INS_revive\setting_dialog\init.sqf";
// };

// Admin Reserved Slot
// if (INS_REV_CFG_reserved_slot) then {
	// [] execVM "INS_revive\reserved_slot\reserved_slot.sqf";
// };
