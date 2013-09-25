#include <\x\alive\addons\sys_player\script_component.hpp>
SCRIPT(setPlayer);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_setPlayer
Description:
Get current player object data and save to in memory store

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

_playerHash = [] call CBA_fnc_hashCreate;

	// Get save options
	_saveLoadout = _logic getvariable ["saveLoadout","1"];
	_saveHealth = _logic getvariable ["saveHealth","1"];
	_savePosition = _logic getvariable ["savePosition","1"];
	_saveScores = _logic getvariable ["saveScores","1"];

// Create Data Command Array
_data = GVAR(UNIT_DATA);

TRACE_5("SYS_PLAYER",_saveLoadout,_saveHealth,_savePosition,_saveScores,_data);

if (_savePosition == "1") then {
	_data = _data + GVAR(POSITION_DATA);
};

if (_saveHealth == "1") then {
	_data = _data + GVAR(HEALTH_DATA);
};

if (_saveLoadout == "1") then {
	_data =_data + GVAR(LOADOUT_DATA);
};

if (_saveScores == "1") then {
	_data =_data + GVAR(SCORE_DATA);
};

// Run data collection commands
{
	private ["_key","_cmd","_value"];
	_key = _x select 0;
	_cmd = _x select 1;
	_value = [_player] call _cmd;
	if (isNil "_value") then {
		TRACE_2("SYS_PLAYER ERROR TRYING TO COLLECT PLAYER DATA",_player, _cmd);
		_value = "";
	} else {
		TRACE_3("SYS_PLAYER SET PLAYER DATA",_player, _key, _value);
	};
	[_playerHash, _key, _value] call CBA_fnc_hashSet;
} foreach _data;

// Add player hash to player data
_result = _playerHash;

_result;



