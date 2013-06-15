#include <\x\alive\addons\sys_profile\script_component.hpp>
SCRIPT(vehicleGetEmptyPositions);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_vehicleGetEmptyPositions

Description:
Get an array of empty positions for the vehicle

Parameters:
Vehicle - The vehicle

Returns:
Array of empty positions

Examples:
(begin example)
// get empty positions array
_result = [_vehicle] call ALIVE_fnc_vehicleGetEmptyPositions;
(end)

See Also:

Author:
ARJay
---------------------------------------------------------------------------- */

private ["_vehicle", "_count", "_positions"];
	
_vehicle = _this select 0;

_positions = [0,0,0,0];

if (locked _vehicle != 2 && alive _vehicle) then
{	
	_positions set [0, _vehicle emptyPositions "Driver"];
	_positions set [1, _vehicle emptyPositions "Gunner"];
	_positions set [2, _vehicle emptyPositions "Commander"];
	_positions set [3, _vehicle emptyPositions "Cargo"];
};

_positions