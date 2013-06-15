#include <\x\alive\addons\sys_profile\script_component.hpp>
SCRIPT(vehicleMoveIn);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_vehicleMoveIn

Description:
Move in vehicle by passed vehicle assignment array

Parameters:
Array - assignments array
Vehicle - The vehicle

Returns:

Examples:
(begin example)
// move in all assignments
_result = [[[_unit],[_unit,_unit],[],[]], _vehicle] call ALIVE_fnc_vehicleMoveIn;
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
	_x moveInDriver _vehicle;
} forEach _driver;

// gunner
_gunners = _assignments select 1;

{
	_x moveInGunner _vehicle;
} forEach _gunners;

// commander
_commander = _assignments select 2;

{
	_x moveInCommander _vehicle;
} forEach _commander;

// cargo
_cargo = _assignments select 3;

{
	_x moveInCargo _vehicle;
} forEach _cargo;