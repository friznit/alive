#include <\x\alive\addons\sys_profile\script_component.hpp>
SCRIPT(profileVehicleAssignmentsGetInCommand);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_profileVehicleAssignmentsGetInCommand

Description:
Takes a entity profile vehicle assignment and return an array of vehicle profile ids that the entity is in command of

Parameters:
Array - Vehicle assignments

Returns:

Examples:
(begin example)
// get vehicles the entity is in commmand of
_result = [_vehicleAssignments] call ALIVE_fnc_profileVehicleAssignmentsGetInCommand;
(end)

See Also:

Author:
ARJay
---------------------------------------------------------------------------- */

private ["_assignments","_result","_vehicle","_assignment","_drivers","_commander","_inControlVehicle"];

_assignments = _this;

_result = [];
			
{
	_vehicle = (_x select 1) select 0;
	_assignment = (_x select 2) select 0;
	_drivers = count(_assignment select 0);
	_commander = count(_assignment select 2);
	
	_inControlVehicle = false;
					
	if(_drivers > 0) then {
		_inControlVehicle = true;
	};
	
	if(_commander > 0) then {
		_inControlVehicle = true;
	};
	
	if(_inControlVehicle) then {
		_result set [count _result, _vehicle]
	};				
	
} forEach _assignments;

_result