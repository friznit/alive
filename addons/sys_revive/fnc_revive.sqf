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
[VRC]Raps
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
		if (isServer) then {
			MOD(revive) = _logic;
			publicVariable QMOD(revive);

			// if server, initialise module game logic
			_logic setVariable ["super", SUPERCLASS];
			_logic setVariable ["class", ALIVE_fnc_revive];
			_logic setVariable ["init", true, true];
			// REVIVE_DEBUG = call compile (_logic getvariable ["revive_debug_setting","false"]);
			REVIVE_LANG = call compile (_logic getvariable ["revive_language_setting","false"]);
			REVIVE_LIVES = call compile (_logic getvariable ["revive_lives_setting","false"]);
			REVIVE_ALLOW_RESPAWN = call compile (_logic getvariable ["revive_allow_respawn","false"]);
			REVIVE_SPECTATOR = call compile (_logic getvariable ["revive_spectator","false"]);
			REVIVE_MARKER = call compile (_logic getvariable ["revive_player_marker","false"]);
			REVIVE_INJURED = call compile (_logic getvariable ["revive_injured","false"]);
			REVIVE_DRAG = call compile (_logic getvariable ["revive_drag_body","false"]);
			REVIVE_CARRY = call compile (_logic getvariable ["revive_carry_body","false"]);
			// and publicVariable to clients
			// publicVariable "REVIVE_DEBUG";
		} else {
			// if client clean up client side game logics as they will transfer
			// to servers on client disconnect
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
		// Waituntil {!(isnil "REVIVE_DEBUG")};
		call ALIVE_fnc_reviveScript;
	};
	case "destroy": {
		if (isServer) then {
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

