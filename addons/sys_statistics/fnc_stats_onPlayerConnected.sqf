/*
 * Filename:
 * fnc_stats_onPlayerConnected.sqf
 *
 * Description:
 * handled onPlayerConnected event for sys_statistics, reading player stats profile
 *
 * Created by Tupolov
 * Creation date: 06/07/2013
 *
 * */

// ====================================================================================
// MAIN

#include "script_component.hpp"

if (GVAR(ENABLED) && isDedicated) then {
	private ["_owner","_data","_unit","_id","_uid","_name","_module"];

	_unit = objNull;
	_module = "players";

	TRACE_1("STATS PLAYER CONNECT", _this);

	_id = _this select 0;
	_name = _this select 1;
	_uid = _this select 2;

	if (_name == "__SERVER__" || _uid == "") exitWith {};

	{
		if (getPlayerUID _x == _uid) exitwith {
			diag_log[format["SYS_STATS: PLAYER UNIT FOUND IN PLAYABLEUNITS (%1)",_x]];
			_unit = _x;
			_owner = owner _unit;
		};
	} foreach playableUnits;

	// Cater for non player situations
	if (_uid == "") exitWith {
		diag_log["SYS_STATS: PLAYER DOES NOT HAVE UID, EXITING."];
	};


	if (isNull _unit) then {
		diag_log["SYS_STATS: PLAYER UNIT NOT FOUND IN PLAYABLEUNITS"];

		/// Hmmmm connecting player isn't found...

	} else {

		_data = [GVAR(datahandler), "read", [_module, [], _uid] ] call ALIVE_fnc_data;

		// Send Data
		STATS_PLAYER_PROFILE = _data;
		_owner publicVariableClient "STATS_PLAYER_PROFILE";

		TRACE_3("SENDING PROFILE DATA TO CLIENT", _owner, _data, _unit);

		// Set player startTime
		[GVAR(PlayerStartTime), getPlayerUID _unit, diag_tickTime] call ALIVE_fnc_hashSet;

		// Add an EH for your player object on everyone's locality - (Thanks BIS!)
		// Call is persistent so that all players are synced to any JIPs
		[[_unit], "ALIVE_fnc_addHandleHeal", true, true, true] spawn BIS_fnc_MP;

	};

};

// ====================================================================================