/*
 * Initialize INS_revive system (ACE mod).
 * 
 * Copyleft 2013 naong
 * 
 * This program is free software under the terms of the GNU General Public License version 3.
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

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

// Remote execution
if !(GVAR_is_arma3) then {
	INS_REV_FNCT_remote_exec =
	{
		private ["_unit", "_command", "_parameter"];
		_unit = _this select 1 select 0;
		_command = _this select 1 select 1;
		_parameter = _this select 1 select 2;
		
		if (local _unit) then 
		{
			switch (_command) do
			{
				case "switchMove": {_unit switchMove _parameter;};
				case "setDir": {_unit setDir _parameter;};
				case "playMove": {_unit playMove _parameter;};
				case "playMoveNow": {_unit playMoveNow _parameter;};
			};
		};
	};
	"INS_REV_remote_exec" addPublicVariableEventHandler INS_REV_FNCT_remote_exec;
};

// Load language string
call compile preprocessFile format ["INS_revive\revive\%1_strings_lang.sqf", INS_REV_CFG_language];

// Call functions
call compile preprocessFile "INS_revive\revive\functions.sqf";
waitUntil {!isNil "INS_REV_FNCT_init_completed"};
if (GVAR_is_arma3) then {
	call compile preprocessFile "INS_revive\revive\functions_a3.sqf";
	waitUntil {!isNil "INS_REV_FNCT_a3_init_completed"};
};
if (GVAR_is_arma2oa) then {
	call compile preprocessFile "INS_revive\revive\functions_a2oa.sqf";
	waitUntil {!isNil "INS_REV_FNCT_a2oa_init_completed"};
};
if (GVAR_is_arma2) then {
	call compile preprocessFile "INS_revive\revive\functions_a2.sqf";
	waitUntil {!isNil "INS_REV_FNCT_a2_init_completed"};
};

// Start serverside player marker
if (isServer && INS_REV_CFG_player_marker_serverSide) then {
	// Set makers when player dead
	INS_REV_thread_draw_dead_marker = [] spawn INS_REV_FNCT_draw_dead_marker;
};

if (!isDedicated) then
{
	// Initailize revive
	[] spawn {
		// Set thread
		INS_REV_thread_exec_wait_revive = [] spawn {};	// On killed wating revive thread
		INS_REV_thread_dead_camera = [] spawn {};		// On killed dead camera thread
		
		// Wait until player initialized
		waitUntil {!(isNull player)};
		
		// Set makers when player dead (client side)
		if (!INS_REV_CFG_player_marker_serverSide) then {
			INS_REV_thread_draw_dead_marker = [] spawn INS_REV_FNCT_draw_dead_marker;
		};
		
		// Initialize Player Loadout
/*
		if (GVAR_is_arma3) then {
			// Arma 3
			_loadout = [player] call INS_REV_FNCT_get_loadout;
			INS_REV_GVAR_player_loadout = _loadout;
		} else {
			// Arma 2 oa
			if (GVAR_is_arma2oa) then {
				INS_REV_GVAR_player_loadout = [player] call INS_REV_FNCT_get_loadout_a2oa;
			};
		};
*/		
		// Memorize player's body before dead
		INS_REV_GVAR_body_before_dead = player;
		
		// Add event handler
		player addEventHandler ["killed", INS_REV_FNCT_onKilled];
		["ace_sys_wounds_rev", {call INS_REV_FNCT_onKilled}] call CBA_fnc_addEventhandler;
		
		sleep 0.5;
		
		// Initialize Variable
		player setVariable ["INS_REV_PVAR_is_unconscious", false, true];
		player setVariable ["INS_REV_PVAR_isTeleport", false, true];
		player setVariable ["INS_REV_PVAR_playerSide", side player, true];
		player setVariable ["INS_REV_PVAR_playerGroup", group player, true];
		player setVariable ["INS_REV_PVAR_playerGroupColor", [player] call INS_REV_FNCT_get_group_color, true];
		player setVariable ["INS_REV_PVAR_who_taking_care_of_injured", nil, true];
		
		// JIP Process
		if (isJIP) then {
			switch (INS_REV_CFG_JIP_Teleport_Action) do {
				case 1: {
					call INS_REV_FNCT_init_teleport_to_teamate;
				};
				case 2: {
					player setVariable ["INS_REV_PVAR_isTeleport", true, true];
					[player, player] call INS_REV_FNCT_onKilled;
				};
			};
		};
	};
};