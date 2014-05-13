#include <\x\alive\addons\x_lib\script_component.hpp>
SCRIPT(debugBuildingPositions);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_debugBuildingPositions

Description:
Inspect building positions using debug markers

Parameters:

Returns:

Examples:
(begin example)
// inspect config class
[_object] call ALIVE_fnc_debugBuildingPositions;
(end)

See Also:

Author:
ARJay
---------------------------------------------------------------------------- */

private ["_building","_count","_position","_positions"];
	
_building = _this select 0;

_count = 0;
while {str(_building buildingPos _count) != "[0,0,0]"} do {
	_count = _count + 1;
};

_positions = [];

for "_i" from 0 to (_count-1) do {
	_positions set [count _positions, _building buildingPos _i];
};

{
	[_x] call ALIVE_fnc_spawnDebugMarker;
} forEach _positions;