#include <\x\alive\addons\sys_profile\script_component.hpp>
SCRIPT(createProfilesCrewedVehicle);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_createProfilesCrewedVehicle

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
_result = ["B_Heli_Light_01_F","WEST",getPosATL player] call ALIVE_fnc_createProfilesCrewedVehicle;
(end)

See Also:

Author:
ARJay
---------------------------------------------------------------------------- */

private ["_vehicleClass","_side","_rank","_direction","_spawnGoodPosition","_position","_groupProfiles","_groupUnits","_groupVehicles","_class","_rank","_vehicle","_vehicleType"];

_vehicleClass = _this select 0;
_side = _this select 1;
_rank = _this select 2;
_position = _this select 3;
_direction = if(count _this > 4) then {_this select 4} else {0};
_spawnGoodPosition = if(count _this > 5) then {_this select 5} else {true};
_prefix = if(count _this > 6) then {_this select 6} else {""};

// get counts of current profiles

_vehicleID = [ALIVE_profileHandler, "getNextInsertVehicleID"] call ALIVE_fnc_profileHandler;
_entityID = [ALIVE_profileHandler, "getNextInsertEntityID"] call ALIVE_fnc_profileHandler;


// create the entity profile

_groupProfiles = [];

private ["_entityID","_side","_profileEntity","_classes","_positions","_damages","_ranks","_unit"];

_profileEntity = [nil, "create"] call ALIVE_fnc_profileEntity;
[_profileEntity, "init"] call ALIVE_fnc_profileEntity;
[_profileEntity, "profileID", format["%1-%2",_prefix,_entityID]] call ALIVE_fnc_profileEntity;
[_profileEntity, "position", _position] call ALIVE_fnc_profileEntity;
[_profileEntity, "side", _side] call ALIVE_fnc_profileEntity;

if!(_spawnGoodPosition) then {
	[_profileEntity, "despawnPosition", _position] call ALIVE_fnc_profileEntity;
};

_groupProfiles set [count _groupProfiles, _profileEntity];
[ALIVE_profileHandler, "registerProfile", _profileEntity] call ALIVE_fnc_profileHandler;


// instantiate static vehicle position data
if(isNil "ALIVE_vehiclePositions") then {
	[] call ALIVE_fnc_staticVehicleEmptyPositionData;
};

private ["_vehicleID","_vehicleClass","_crew","_profileVehicle","_vehiclePositions","_countCrewPositions"];

_vehicleKind = _vehicleClass call ALIVE_fnc_vehicleGetKindOf;

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

if(_vehicleKind == "Plane" || _vehicleKind == "Helicopter") then {
	[_profileVehicle, "spawnType", ["preventDespawn"]] call ALIVE_fnc_profileVehicle;
};

if!(_spawnGoodPosition) then {
	[_profileVehicle, "despawnPosition", _position] call ALIVE_fnc_profileVehicle;
};

_groupProfiles set [count _groupProfiles, _profileVehicle];	
[ALIVE_profileHandler, "registerProfile", _profileVehicle] call ALIVE_fnc_profileHandler;

// create crew members for the vehicle

_crew = _vehicleClass call ALIVE_fnc_configGetVehicleCrew;
_vehiclePositions = [ALIVE_vehiclePositions,_vehicleClass] call ALIVE_fnc_hashGet;
_countCrewPositions = 0;

// count all non cargo positions
for "_i" from 0 to count _vehiclePositions -2 do {
	_countCrewPositions = _countCrewPositions + (_vehiclePositions select _i);
};

// for all crew positions add units to the entity group
for "_i" from 0 to _countCrewPositions -1 do {		
	[_profileEntity, "addUnit", [_crew,_position,0,_rank]] call ALIVE_fnc_profileEntity;
};

[_profileEntity,_profileVehicle] call ALIVE_fnc_createProfileVehicleAssignment;


_groupProfiles