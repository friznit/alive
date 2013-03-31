#include <\x\alive\addons\fnc_strategic\script_component.hpp>
SCRIPT(findNearHousePositions);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_findNearHousePositions

Description:
Provide a list of house positions in the area

Parameters:
Array - Position
Number - Radius to search

Returns:
Array - A list of building positions

Examples:
(begin example)
// find nearby houses
_bldgpos = [_pos,50] call ALIVE_fnc_findNearHousePositions;
(end)

See Also:
- <ALIVE_fnc_getBuildingPositions>
- <ALIVE_fnc_findIndoorHousePositions>

Author:
Highhead
---------------------------------------------------------------------------- */

private ["_pos","_radius","_positions","_nearbldgs"];

PARAMS_2(_pos,_radius);
_positions = [];
_nearbldgs = nearestObjects [_pos, ["House"], _radius];
{
	_positions = _positions + ([_x] call ALIVE_fnc_getBuildingPositions);
} forEach _nearbldgs;

_positions;
