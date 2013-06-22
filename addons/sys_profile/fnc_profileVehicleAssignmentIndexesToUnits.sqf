#include <\x\alive\addons\sys_profile\script_component.hpp>
SCRIPT(profileVehicleAssignmentIndexesToUnits);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_profileVehicleAssignmentIndexesToUnits

Description:
Takes a profile vehicle assignment unit index array and returns the array as units

Parameters:
Array - Vehicle assignment indexes
Array - Unit array

Returns:

Examples:
(begin example)
// convert assignment indexes to units
_result = [_vehicleAssignmentIndexes,_unitArray] call ALIVE_fnc_profileVehicleAssignmentIndexesToUnits;
(end)

See Also:

Author:
ARJay
---------------------------------------------------------------------------- */

private ["_indexes","_units","_index","_assignments","_assignment"];

_indexes = _this select 0;
_units = _this select 1;

_assignments = [[],[],[],[],[]];

for "_i" from 0 to (count _indexes)-1 do {
	_assignment = _assignments select _i;
	{
		_assignment set [count _assignment, _units select _x];
	} forEach (_indexes select _i);
};

_assignments