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

if (!isNil QMOD(sys_player) && isDedicated) then {

	private ["_id","_uid","_name","_module", "_result"];

	_module = "players";

	TRACE_1("SYS_PLAYER PLAYER CONNECT", _this);

	_id = _this select 0;
	_name = _this select 1;
	_uid = _this select 2;

	if (_name == "__SERVER__" || _uid == "") exitWith {

		// MOVED TO MODULE INIT

	};

	// Disable user input?
	// Disallow damage?
	// Black Screen?

	// If not server then wait for server to load data, wait for player to connect and player object to get assigned then proceed

	[_uid, _name] spawn {
		private ["_owner","_data","_unit","_uid","_name","_check"];

		_uid = _this select 0;
		_name = _this select 1;

		_unit = objNull;

		_check = MOD(sys_player) getVariable ["init", false];
		// Wait for player module to init
		TRACE_1("Waiting for player module to init",_check);
		waitUntil  {sleep 0.3; _check = MOD(sys_player) getVariable ["init", false]; TRACE_1("Waiting for init",_check); _check};
		sleep 0.2;
		TRACE_1("Player module init complete",_check);

		_check = MOD(sys_player) getVariable [_uid, false];
		// Wait for player data to be loaded by server
		TRACE_1("Waiting for player to connect",_check);
		waitUntil  {sleep 0.3; _check = MOD(sys_player) getVariable [_uid, false]; TRACE_1("Waiting for player",_check); _check};
		sleep 0.2;
		TRACE_1("Player connected",_check);

		// If player connecting then get player data from memory and update player object
		{
			private ["_playerGUID","_tmp"];
			_tmp = _x;
			_playerGUID = getPlayerUID _tmp;
			TRACE_1("Waiting for playable unit to get GUID",_playerGUID);
			waitUntil {sleep 0.3; _playerGUID = getPlayerUID _tmp; TRACE_1("Waiting for GUID",_playerGUID); _playerGUID != ""};
			sleep 0.2;
			TRACE_2("SYS_PLAYER PLAYABLEUNITS CHECK",_playerGUID, _uid);
			if (getPlayerUID _tmp == _uid ) exitwith {
				_unit = _tmp;
				_owner = owner _unit;
				TRACE_2("SYS_PLAYER: PLAYER UNIT FOUND IN PLAYABLEUNITS",_unit, _owner);
			};
		} foreach playableUnits;

		if (isNull _unit) then {
			diag_log[format["SYS_PLAYER: PLAYER UNIT NOT FOUND IN PLAYABLEUNITS(%1)",_name]];

			/// Hmmmm connecting player isn't found...

		} else {

			// Ask player if they want to be restored first?

			// Apply data to player object
			_result = [MOD(sys_player), "getPlayer", [_unit,_owner]] call ALIVE_fnc_player;

			TRACE_1("GETTING PLAYER DATA", _result);

		};
	};
};

// ====================================================================================