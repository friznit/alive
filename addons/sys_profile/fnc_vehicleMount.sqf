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

private ["_assignments","_vehicle","_driver","_gunners","_commander","_cargo","_turret","_turrets","_unit","_turretPath"];
	
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

// turrets
_turret = _assignments select 3;

if(count _turret > 0) then {
	// get turrets for this class ignoring gunner and commander turrets
	_turrets = [typeOf _vehicle, true, true] call ALIVE_fnc_configGetVehicleTurretPositions;
	
	for "_i" from 0 to (count _turret)-1 do {
		_unit = _turret select _i;
		_turretPath = _turrets call BIS_fnc_arrayPop;
		_unit assignAsTurret [_vehicle, _turretPath];
	};
};

// cargo
_cargo = _assignments select 4;

{
	[_x] orderGetIn true;
} forEach _cargo;