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

if (!isNil QMOD(sys_player) && isDedicated) then {
	private ["_unit","_id","_uid","_name","_check","_result","_test"];

	_unit = objNull;

	TRACE_1("STATS PLAYER DISCONNECT", _this);

	_id = _this select 0;
	_name = _this select 1;
	_uid = _this select 2;

	if (_name == "__SERVER__") exitWith {

		// If storeToDB is enabled then save player data
		_check = MOD(sys_player) getvariable ["storeToDB",false];
		if (_check && (!isNil "ALIVE_sys_data" && {!ALIVE_sys_data_DISABLED})) then {
			_result = [MOD(sys_player), "savePlayers", [false]] call ALIVE_fnc_player;
			TRACE_1("SAVING PLAYER DATA", _result);
		};
		MOD(sys_player) setVariable ["saved", true];
	};

	{
		if (getPlayerUID _x == _uid) exitwith {
			diag_log[format["SYS_PLAYER: PLAYER UNIT FOUND IN PLAYABLEUNITS (%1)",_x]];
			_unit = _x;
		};
	} foreach playableUnits;

	if (isNull _unit) then {
		private ["_timeDiff","_lastPlayerSaveTime"];
		diag_log["SYS_PLAYER: PLAYER UNIT NOT FOUND IN PLAYABLEUNITS (%1)", _name];
		// Work out when the last player save was and report the difference

		_lastPlayerSaveTime = [MOD(sys_player), "getPlayerSaveTime", [_uid]] call ALIVE_fnc_player;
		_timeDiff = (dateToNumber date) - _lastPlayerSaveTime;
		diag_log format["SYS_PLAYER: Have not saved player state for %2 for %1 seconds", _timeDiff,_name];

	} else {

		if !(_unit getVariable [QGVAR(kicked), false]) then {
			_result = [MOD(sys_player), "setPlayer", [_unit]] call ALIVE_fnc_player;
			TRACE_1("SETTING PLAYER DATA", _result);
		} else {
			_unit setVariable [QGVAR(kicked), false, true];
		};
	};

	MOD(sys_player) setVariable [_uid, false, true];

	_test = MOD(sys_player) getVariable [_uid, false];
	TRACE_1("REMOVING PLAYER GUID FROM LOGIC", _test);

};

// ====================================================================================