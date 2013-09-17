/*
 * Filename:
 * fnc_player_onPlayerDisconnected.sqf
 *
 * Description:
 * handled onPlayerDisconnected event for sys_player, saving player data when they disconnect
 *
 * Created by Tupolov
 * Creation date: 06/08/2013
 *
 * */

// ====================================================================================
// MAIN

#include "script_component.hpp"

if (!isNil(ALIVE_fnc_player) && isDedicated) then {
	private ["_unit","_id","_uid","_name","_check","_result"];

	_unit = objNull;

	TRACE_1("STATS PLAYER DISCONNECT", _this);

	_id = _this select 0;
	_name = _this select 1;
	_uid = _this select 2;

	if (_name == "__SERVER__") exitWith {

		// If storetoDB is enabled then save player data
		_check = [ALIVE_PlayerSystem,"storeToDB",[],true] call ALIVE_fnc_OOsimpleOperation;
		if (_check) then {
			_result = [ALIVE_PlayerSystem, "savePlayers", []] call ALIVE_fnc_player;
			TRACE_1("SAVING PLAYER DATA", _result);
		};
	};

	{
		if (getPlayerUID _x == _uid) exitwith {
			diag_log[format["SYS_PLAYER: PLAYER UNIT FOUND IN PLAYABLEUNITS (%1)",_x]];
			_unit = _x;
		};
	} foreach playableUnits;

	if (isNull _unit) then {
		private ["_timeDiff","_lastPlayerSaveTime"];
		diag_log["SYS_PLAYER: PLAYER UNIT NOT FOUND IN PLAYABLEUNITS"];
		// Work out when the last player save was and report the difference

		_lastPlayerSaveTime = [ALIVE_PlayerSystem, "getPlayerSaveTime", [_uid]] call ALIVE_fnc_player;
		_timeDiff = _lastPlayerSaveTime - time;
		diag_log["SYS_PLAYER: Have not saved player state for %2 for %1 seconds", _timeDiff,_name];

	} else {

		// Set player data to in memory store

		_result = [ALIVE_PlayerSystem, "setPlayer", [_unit]] call ALIVE_fnc_player;
		TRACE_1("SETTING PLAYER DATA", _result);
	};

};

// ====================================================================================