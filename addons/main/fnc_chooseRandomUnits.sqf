#include <\x\alive\addons\main\script_component.hpp>
SCRIPT(chooseRandomUnits);

/* ----------------------------------------------------------------------------
Function: MSO_fnc_chooseRandomUnits

Description:
Provides up to 4 random infantry unit types

Parameters:
Array - A list of factions
Number - Number of unit types to return

Returns:
Array - A list of random unit types 

Examples:
(begin example)
[["RU","INS"], ceil(random 5)] call MSO_fnc_chooseRandomUnits;
(end)

See Also:
- <MSO_fnc_findVehicleType>
- <MSO_fnc_getBuildingPositions>

Author:
Highhead
---------------------------------------------------------------------------- */

private ["_unittype","_types","_unittypes","_factions"];

DEFAULT_PARAM(0,_factions,[]);
DEFAULT_PARAM(1,_count,1);

_types = [0, _factions call BIS_fnc_selectRandom,"Man"] call ALiVE_fnc_findVehicleType;
_unittypes = [];
for "_i" from 0 to _count do {
	_unittype = _types call BIS_fnc_selectRandom;
	_unittypes set [count _unittypes, _unittype];
};

_unittypes;
