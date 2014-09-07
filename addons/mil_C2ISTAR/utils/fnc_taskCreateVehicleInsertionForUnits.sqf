#include <\x\alive\addons\mil_C2ISTAR\script_component.hpp>
SCRIPT(taskCreateVehicleInsertionForUnits);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_taskCreateVehicleInsertionForUnits

Description:
Supply some units and will an insertion vehicle for them

Parameters:

Returns:

Examples:
(begin example)
(end)

See Also:

Author:
ARJay
---------------------------------------------------------------------------- */

private ["_taskPosition","_taskSide","_taskFaction","_taskUnits"];

_taskPosition = _this select 0;
_taskSide = _this select 1;
_taskFaction = _this select 2;
_taskUnits = _this select 2;
