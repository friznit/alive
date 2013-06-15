#include <\x\alive\addons\sys_profile\script_component.hpp>
SCRIPT(vehicleMount);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_vehicleMount

Description:
Mount vehicle by passed vehicle assignment array

Parameters:
Array - assignments array
Vehicle - The vehicle

Returns:

Examples:
(begin example)
// mount all assignments
_result = [[[_unit],[_unit,_unit],[],[]], _vehicle] call ALIVE_fnc_vehicleMount;
(end)

See Also:


Author:
ARJay
---------------------------------------------------------------------------- */

private ["_assignments", "_vehicle", "_driver", "_gunners", "_commander", "_cargo"];
	
_assignments = _this select 0;
_vehicle = _this select 1;
	
// driver
_driver = _assignments select 0;	
{
	[_x] orderGetIn true;
} forEach _driver;

// gunner
_gunners = _assignments select 1;
{
	[_x] orderGetIn true;
} forEach _gunners;

// commander
_commander = _assignments select 2;

{
	[_x] orderGetIn true;
} forEach _commander;

// cargo
_cargo = _assignments select 3;

{
	[_x] orderGetIn true;
} forEach _cargo;