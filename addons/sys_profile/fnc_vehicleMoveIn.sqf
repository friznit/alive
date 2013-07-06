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

private ["_assignments","_vehicle","_driver","_gunners","_commander","_cargo","_turret","_turrets","_unit","_turretPath"];
	
_assignments = _this select 0;
_vehicle = _this select 1;

// driver
_driver = _assignments select 0;

{
	_x assignAsDriver _vehicle;
	_x moveInDriver _vehicle;
} forEach _driver;

// gunner
_gunners = _assignments select 1;

{
	_x assignAsGunner _vehicle;
	_x moveInGunner _vehicle;
} forEach _gunners;

// commander
_commander = _assignments select 2;

{
	_x assignAsCommander _vehicle;
	_x moveInCommander _vehicle;
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
		_unit moveInTurret [_vehicle, _turretPath];
	};
};

// cargo
_cargo = _assignments select 4;

{
	_x assignAsCargo _vehicle;
	_x moveInCargo _vehicle;
} forEach _cargo;