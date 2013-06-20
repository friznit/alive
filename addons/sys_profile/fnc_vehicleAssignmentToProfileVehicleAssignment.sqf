#include <\x\alive\addons\sys_profile\script_component.hpp>
SCRIPT(vehicleAssignmentToProfileVehicleAssignment);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_vehicleAssignmentToProfileVehicleAssignment

Description:
Takes a vehicle assignment and creates a profile vehicle assignment

Parameters:
Array - Vehicle assignment

Returns:


Examples:
(begin example)
// get empty positions
_result = _vehicleAssignment call ALIVE_fnc_vehicleAssignmentToProfileVehicleAssignment;
(end)

See Also:

Author:
ARJay
---------------------------------------------------------------------------- */

private ["_vehicleAssignment"];

_vehicleAssignment = _this;

