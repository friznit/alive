#include <\x\alive\addons\sys_profile\script_component.hpp>
SCRIPT(vehicleDismount);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_vehicleDismount

Description:
Dismount from vehicle by passed vehicle assignment array

Parameters:
Array - assignments array
Vehicle - The vehicle
Boolean - gunners dismount

Returns:

Examples:
(begin example)
// dismount all assignments
_result = [[[_unit],[_unit,_unit],[],[]], _vehicle] call ALIVE_fnc_vehicleDismount;

// dismount all assignments except gunners
_result = [[[_unit],[_unit,_unit],[],[]], _vehicle, false] call ALIVE_fnc_vehicleDismount;
(end)

See Also:


Author:
ARJay
---------------------------------------------------------------------------- */

private ["_assignments", "_vehicle", "_gunnersDismount", "_driver", "_gunners", "_commander", "_cargo"];
	
_assignments = _this select 0;
_vehicle = _this select 1;
_gunnersDismount = if(count _this > 2) then {_this select 2} else {true};

// driver
_driver = _assignments select 0;	
{
	//unassignVehicle _x;
	[_x] orderGetIn false;
} forEach _driver;

// gunner
if(_gunnersDismount) then
{
	_gunners = _assignments select 1;
	{
		//unassignVehicle _x;
		[_x] orderGetIn false;
	} forEach _gunners;
};

// commander
_commander = _assignments select 2;

{
	//unassignVehicle _x;
	[_x] orderGetIn false;
} forEach _commander;

// cargo
_cargo = _assignments select 3;

{
	//unassignVehicle _x;
	[_x] orderGetIn false;
} forEach _cargo;