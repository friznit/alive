#include <\x\alive\addons\sys_player\script_component.hpp>
SCRIPT(getPlayer);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_getPlayer
Description:
Apply player state data to current player object

Parameters:
Object - If Nil, return a new instance. If Object, reference an existing instance.
Array - The selected parameters

Returns:
Hash - Array of player data

Examples:
(begin example)
//
(end)

See Also:
- <ALIVE_fnc_playerInit>
- <ALIVE_fnc_playerMenuDef>

Author:
Tupolov

Peer reviewed:
nil
---------------------------------------------------------------------------- */

private ["_logic","_args","_player","_find","_saveLoadout","_saveHealth","_savePosition","_saveScores","_data","_playerHash","_result","_data"];

_logic = [_this, 0, objNull, [objNull,[]]] call BIS_fnc_param;
_args = [_this, 1, objNull, [objNull,[],"",0,true,false]] call BIS_fnc_param;

_player = _args select 0;
_owner = _args select 1;


	// Grab player data from memory store
	_playerHash = [GVAR(player_data), getPlayerUID _player] call CBA_fnc_hashGet;
	TRACE_1("GET PLAYER", _playerHash);

	// Get save options
	_saveLoadout = _logic getvariable ["saveLoadout","true"];
	_saveHealth = _logic getvariable ["saveHealth","true"];
	_savePosition = _logic getvariable ["savePosition","true"];
	_saveScores = _logic getvariable ["saveScores","true"];

	// Create Data Command Array
	_data = GVAR(UNIT_DATA);

	if (call compile _savePosition) then {
		_data = _data + GVAR(POSITION_DATA);
	};

	if (call compile _saveHealth) then {
		_data = _data + GVAR(HEALTH_DATA);
	};

	if (call compile _saveLoadout) then {
		_data =_data + GVAR(LOADOUT_DATA);
	};

	if (call compile _saveScores) then {
		_data =_data + GVAR(SCORE_DATA);
	};

	TRACE_5("SYS_PLAYER GETPLAYER SETTINGS",_saveLoadout,_saveHealth,_savePosition,_saveScores,count _data);

	// Run data collection commands
	{
		private ["_key","_cmd","_value"];
		_key = _x select 0;
		_value = [_playerHash, _key] call CBA_fnc_hashGet;
		_cmd = _x select 2;

		if (typeName _cmd != "STRING") then {
			// Execute on server
			[_player,_value] call _cmd;

			// or owner client?
			// ["getplayer", [_player]] call CBA_fnc_remoteLocalEvent;

			TRACE_3("SYS_PLAYER GET PLAYER DATA", _player, _key, _value);
		} else {
			TRACE_1("SKIPPING GET PLAYER CMD",_cmd);
		};

	} foreach _data;

	_result = true;

_result;
