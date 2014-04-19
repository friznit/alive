#include <\x\alive\addons\sys_revive\script_component.hpp>
SCRIPT(revive);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_revive
Description:
Creates the server side object to store settings

Parameters:
Nil or Object - If Nil, return a new instance. If Object, reference an existing instance.
String - The selected function
Array - The selected parameters

Returns:
Any - The new instance or the result of the selected function and parameters

Attributes:
Boolean - debug - Debug enabled
Boolean - enabled - Enabled or disable module

Parameters:
none

The popup menu will change to show status as functions are enabled and disabled.

Examples:
(begin example)
// Create instance by placing editor module and specifiying name myModule
(end)

See Also:
- <ALIVE_fnc_reviveInit>


Author:
Raptor
---------------------------------------------------------------------------- */

#define SUPERCLASS nil

private ["_logic","_operation","_args"];

PARAMS_1(_logic);
DEFAULT_PARAM(1,_operation,"");
DEFAULT_PARAM(2,_args,[]);

switch(_operation) do {
        case "init": {                
		/*
		MODEL - no visual just reference data
		- server side object only
		- enabled/disabled
		*/
		
		// Ensure only one module is used
		if (isServer && !(isNil QMOD(revive))) exitWith {
			ERROR_WITH_TITLE(str _logic, localize "STR_ALIVE_REVIVE_ERROR1");
		};
		if ((isServer) and (!isDedicated)) then {
			MOD(revive) = _logic;
			publicVariable QMOD(revive);

			// if server, initialise module game logic
			_logic setVariable ["super", SUPERCLASS];
			_logic setVariable ["class", ALIVE_fnc_revive];
			_logic setVariable ["init", true, true];
			REV_Debug = call compile (_logic getvariable ["rev_debug_setting","false"]);
			// REV_Language = call compile (_logic getvariable ["rev_language_setting","English"]);
			REV_VAR_ReviveMode = _logic getvariable ["rev_mode_setting",1];
			REV_VAR_BleedOutTime = _logic getvariable ["rev_bleedout_setting",300];
			REV_VAR_isBulletproof = call compile (_logic getvariable ["rev_bulletproof_setting","false"]);
			REV_VAR_isNeutral = call compile (_logic getvariable ["rev_neutral_setting","true"]);
			REV_VAR_SP_PlayableUnits = call compile (_logic getvariable ["rev_playableunits_setting","true"]);
			REV_VAR_TeamKillNotifications = call compile (_logic getvariable ["rev_notifyplayers_setting","true"]);
			REV_VAR_NumRevivesAllowed = _logic getvariable ["rev_lives_setting",999];
			REV_VAR_ReviveDamage = call compile (_logic getvariable ["rev_injured_setting","true"]);
			REV_VAR_Suicide = call compile (_logic getvariable ["rev_allow_suicide_setting","true"]);
			REV_VAR_AllowDrag = call compile (_logic getvariable ["rev_drag_body_setting","true"]);
			// REV_VAR_AllowCarry = call compile (_logic getvariable ["rev_carry_body_setting","false"]);
			// REV_VAR_Spectate = call compile (_logic getvariable ["rev_spectator_setting","false"]);
			REV_VAR_BulletEffects = call compile (_logic getvariable ["rev_bullet_effects_setting","true"]);
			REV_VAR_Show_Player_Marker = call compile (_logic getvariable ["rev_player_marker_setting","true"]);
			// and publicVariable to clients
			// publicVariable "REV_Debug";
		} else {
			// if client, clean up client side game logics as they will transfer to servers on client disconnect
			// deleteVehicle _logic;
		};
		// and wait for game logic to initialise
		// TODO merge into lazy evaluation
		waitUntil {!isNil QMOD(revive)};
		waitUntil {MOD(revive) getVariable ["init", false]};        

		/*
		VIEW - purely visual
		- initialise 
		*/
		// Waituntil {!(isnil "REV_Debug")};
		call ALIVE_fnc_reviveScript;
	};
	case "destroy": {
		if ((isServer) and (!isDedicated)) then {
			// if server
			_logic setVariable ["super", nil];
			_logic setVariable ["class", nil];
			_logic setVariable ["init", nil];
			// and publicVariable to clients
			MOD(revive) = _logic;
			publicVariable QMOD(revive);
		};
	};
	default {
		private["_err"];
		_err = format["%1 does not support %2 operation", _logic, _operation];
		ERROR_WITH_TITLE(str _logic,_err);
	};
};

