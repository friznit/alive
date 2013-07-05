#include <\x\alive\addons\sys_profile\script_component.hpp>
SCRIPT(vehicleGetGroupsWithin);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_vehicleGetGroupsWithin

Description:
Returns groups inside a vehicle

Parameters:
Vehicle - The vehicle object or classname

Returns:

Examples:
(begin example)
_result = _vehicle call ALIVE_fnc_vehicleGetGroupsWithin;
(end)

See Also:

Author:
ARJay
---------------------------------------------------------------------------- */

private ["_vehicle","_result","_group"];
	
_vehicle = _this;

_result = [];

{
	_group = group _x;
	if!(_group in _result) then {
		_result set [count _result, _group];
	};
} forEach (crew _vehicle);

_result