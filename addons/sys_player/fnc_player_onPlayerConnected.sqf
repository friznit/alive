/*
 * Filename:
 * fnc_player_onPlayerConnected.sqf
 *
 * Description:
 * handled onPlayerConnected event for sys_player
 *
 * Created by Tupolov
 * Creation date: 06/08/2013
 *
 * */

// ====================================================================================
// MAIN

#include "script_component.hpp"

if (!isNil(ALIVE_fnc_player) && isDedicated) then {

	private ["_owner","_data","_unit","_id","_uid","_name","_module","_check"];

	_unit = objNull;
	_module = "players";

	TRACE_1("SYS_PLAYER PLAYER CONNECT", _this);

	_id = _this select 0;
	_name = _this select 1;
	_uid = _this select 2;

	if (_name == "__SERVER__") exitWith {
		// If server connects, load all player data from database

		_result = [ALIVE_PlayerSystem, "loadPlayers", []] call ALIVE_fnc_player;
		TRACE_1("LOADING PLAYER DATA", _result);
		// Set true that player data has been loaded
		ALIVE_PlayerSystem setVariable ["loaded", true, true];

	};

	// If not server then wait for server to load data then proceed
	_check = ALIVE_PlayerSystem getVariable ["loaded", false];

	// Disable user input?
	// Disallow damage?
	// Black Screen?

	TRACE_1("Waiting for player data to load",_check);
	while  {!_check} do {
		_check = ALIVE_PlayerSystem getVariable ["loaded", false];
	};
	TRACE_1("Player data to loaded",_check);

	// If player connecting then get player data from memory and update player object
	{
		private "_player";
		_player = getPlayerUID _x;
		TRACE_2("SYS_PLAYER PLAYABLEUNITS CHECK",_player, _uid);
		if (getPlayerUID _x == _uid) exitwith {
			diag_log[format["SYS_PLAYER: PLAYER UNIT FOUND IN PLAYABLEUNITS (%1)",_x]];
			_unit = _x;
			_owner = owner _unit;
		};
	} foreach playableUnits;

	if (isNull _unit) then {
		diag_log[format["SYS_PLAYER: PLAYER UNIT NOT FOUND IN PLAYABLEUNITS(%1)",_name]];

		/// Hmmmm connecting player isn't found...

	} else {

		_result = [ALIVE_PlayerSystem, "getPlayer", [_unit,_owner]] call ALIVE_fnc_player;

		TRACE_1("GETTING PLAYER DATA", _result);

	};

};

// ====================================================================================