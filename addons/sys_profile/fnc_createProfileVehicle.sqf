#include <\x\alive\addons\sys_profile\script_component.hpp>
SCRIPT(createProfileVehicle);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_createProfileVehicle

Description:
Create profiles based on vehicle type including vehicle crew

Parameters:
String - Vehicle class name
String - Side name
String - Rank
Array - position
Scalar - direction

Returns:
Array of created profiles

Examples:
(begin example)
// create profiles for vehicle class
_result = ["B_Heli_Light_01_F","WEST",getPosATL player] call ALIVE_fnc_createProfileVehicle;
(end)

See Also:

Author:
ARJay
---------------------------------------------------------------------------- */

private ["_vehicleClass","_side","_direction","_spawnGoodPosition","_position","_vehicleID","_profileVehicle"];

_vehicleClass = _this select 0;
_side = _this select 1;
_position = _this select 2;
_direction = if(count _this > 3) then {_this select 3} else {0};
_spawnGoodPosition = if(count _this > 4) then {_this select 4} else {true};
_prefix = if(count _this > 5) then {_this select 5} else {""};

// get counts of current profiles

_vehicleID = [ALIVE_profileHandler, "getNextInsertVehicleID"] call ALIVE_fnc_profileHandler;

// create the profile for the vehicle
								
_profileVehicle = [nil, "create"] call ALIVE_fnc_profileVehicle;
[_profileVehicle, "init"] call ALIVE_fnc_profileVehicle;
[_profileVehicle, "profileID", format["%1-%2",_prefix,_vehicleID]] call ALIVE_fnc_profileVehicle;
[_profileVehicle, "vehicleClass", _vehicleClass] call ALIVE_fnc_profileVehicle;
[_profileVehicle, "position", _position] call ALIVE_fnc_profileVehicle;
[_profileVehicle, "direction", _direction] call ALIVE_fnc_profileVehicle;
[_profileVehicle, "side", _side] call ALIVE_fnc_profileVehicle;
[_profileVehicle, "damage", 0] call ALIVE_fnc_profileVehicle;
[_profileVehicle, "fuel", 1] call ALIVE_fnc_profileVehicle;

if!(_spawnGoodPosition) then {
	[_profileVehicle, "despawnPosition", _position] call ALIVE_fnc_profileVehicle;
};

[ALIVE_profileHandler, "registerProfile", _profileVehicle] call ALIVE_fnc_profileHandler;

_profileVehicle