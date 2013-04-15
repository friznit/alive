#include <\x\alive\addons\main\script_component.hpp>
SCRIPT(chooseRandomUnits);

/* ----------------------------------------------------------------------------
Function: ALiVE_fnc_chooseRandomUnits

Description:
Provides up to 4 random infantry unit types

Parameters:
Array - A list of factions
Number - Number of unit types to return
(Optional) Array - Blacklist of given units

Returns:
Array - A list of random unit types 

Examples:
(begin example)
[["RU","INS"], ceil(random 5),["RU_Pilot","RU_SoldierAT]] call ALiVE_fnc_chooseRandomUnits;
(end)

See Also:
- <ALiVE_fnc_findVehicleType>
- <ALiVE_fnc_getBuildingPositions>

Author:
Highhead
---------------------------------------------------------------------------- */

private ["_unittype","_types","_unittypes","_factions","_blacklist"];

DEFAULT_PARAM(0,_factions,[]);
DEFAULT_PARAM(1,_count,1);
DEFAULT_PARAM(2,_blacklist,[]);

if (!(typename _factions == "ARRAY") || !(typename _count == "SCALAR") || !(typename _blacklist == "ARRAY")) then {
	format["ALiVE Main ALiVE_fnc_chooseRandomUnits probably failes due to wrong params given! Factions (Array): %1 | Max. units (Number): %2 | Blacklist (Array): %3", _factions, _count, _blacklist] call ALiVE_fnc_logger;    
};

_types = [0, _factions call BIS_fnc_selectRandom,"Man"] call ALiVE_fnc_findVehicleType;
_unittypes = [];
for "_i" from 0 to _count do {
	while {_unittype = _types call BIS_fnc_selectRandom; (_unittype in _blacklist)} do {true};
	_unittypes set [count _unittypes, _unittype];
};

_unittypes;
