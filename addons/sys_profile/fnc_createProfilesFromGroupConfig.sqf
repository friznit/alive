#include <\x\alive\addons\sys_profile\script_component.hpp>
SCRIPT(createProfilesFromGroupConfig);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_createProfilesFromGroupConfig

Description:
Create profiles based on definitions found in CfgGroups

Parameters:
String - Group class name from CfgGroups
Array - position

Returns:
Array of created profiles

Examples:
(begin example)
// create profiles from group config
_result = ["OIA_InfWepTeam",getPosATL player] call ALIVE_fnc_createProfilesFromGroupConfig;
(end)

See Also:

Author:
ARJay
---------------------------------------------------------------------------- */

private ["_groupClass","_position","_config","_groupName","_groupProfiles","_groupUnits","_groupVehicles","_class","_rank","_vehicle","_vehicleType"];

_groupClass = _this select 0;
_position = _this select 1;

_config = _groupClass call ALIVE_fnc_configGetGroup;
_groupName = getText(_config >> "name");
_groupSide = getNumber(_config >> "side");
_groupProfiles = [];
_groupUnits = [];
_groupVehicles = [];

// loop through the config for the group
for "_i" from 0 to count _config -1 do {
	_class = (_config select _i);
	if(isClass _class) then {
		_rank = getText(_class >> "rank");
		_vehicle = getText(_class >> "vehicle");
		_vehicleType = _vehicle call ALIVE_fnc_configGetVehicleClass;
		
		// seperate vehicles and units in the group
		if((_vehicleType == "Car")||(_vehicleType == "Truck")||(_vehicleType == "Tank")||(_vehicleType == "Ship")||(_vehicleType == "Air")) then {
			_groupVehicles set [count _groupVehicles, [_vehicle,_rank]];			
		} else {
			_groupUnits set [count _groupUnits, [_vehicle,_rank]];
		};		
	};
};


// get counts of current profiles

private ["_entityProfiles","_vehicleProfiles","_countEntities","_countVehicles"];

_entityProfiles = [ALIVE_profileHandler, "getProfilesByType", "entity"] call ALIVE_fnc_profileHandler;
_vehicleProfiles = [ALIVE_profileHandler, "getProfilesByType", "entity"] call ALIVE_fnc_profileHandler;
_countEntities = count(_entityProfiles);
_countVehicles = count(_vehicleProfiles);


// create the group entity profile

private ["_entityID","_side","_profileEntity","_classes","_positions","_damages","_ranks","_unit"];

_entityID = format["entity_%1",_countEntities];
_side = _groupSide call ALIVE_fnc_sideNumberToText;

_profileEntity = [nil, "create"] call ALIVE_fnc_profileEntity;
[_profileEntity, "init"] call ALIVE_fnc_profileEntity;
[_profileEntity, "profileID", _entityID] call ALIVE_fnc_profileEntity;
[_profileEntity, "position", _position] call ALIVE_fnc_profileEntity;
[_profileEntity, "side", _side] call ALIVE_fnc_profileEntity;

_groupProfiles set [count _groupProfiles, _profileEntity];
[ALIVE_profileHandler, "registerProfile", _profileEntity] call ALIVE_fnc_profileHandler;


// if there are vehicles for this group

// instantiate static vehicle position data
if(isNil "ALIVE_vehiclePositions") then {
	[] call ALIVE_fnc_staticVehicleEmptyPositionData;
};

private ["_vehicleID","_vehicleClass","_vehicleRank","_crew","_profileVehicle","_vehiclePositions","_countCrewPositions"];

{
	// create the profile for the vehicle
	
	_vehicle = _x;	
	_vehicleID = format["vehicle_%1",_countVehicles];
	_vehicleClass = _vehicle select 0;
	_vehicleRank = _vehicle select 1;
									
	_profileVehicle = [nil, "create"] call ALIVE_fnc_profileVehicle;
	[_profileVehicle, "init"] call ALIVE_fnc_profileVehicle;
	[_profileVehicle, "profileID", _vehicleID] call ALIVE_fnc_profileVehicle;
	[_profileVehicle, "vehicleClass", _vehicleClass] call ALIVE_fnc_profileVehicle;
	[_profileVehicle, "position", _position] call ALIVE_fnc_profileVehicle;
	[_profileVehicle, "direction", 0] call ALIVE_fnc_profileVehicle;
	[_profileVehicle, "side", _side] call ALIVE_fnc_profileVehicle;
	[_profileVehicle, "damage", 0] call ALIVE_fnc_profileVehicle;
	[_profileVehicle, "fuel", 1] call ALIVE_fnc_profileVehicle;
	
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
		[_profileEntity, "addUnit", [_crew,_position,0,_vehicleRank]] call ALIVE_fnc_profileEntity;
	};
	
	[_profileEntity,_profileVehicle] call ALIVE_fnc_createProfileVehicleAssignment;
	
	_countVehicles = _countVehicles + 1;

} forEach _groupVehicles;

// create the group units

{
	_unit = _x;
	_class = _unit select 0;
	_rank = _unit select 1;
	[_profileEntity, "addUnit", [_class,_position,0,_rank]] call ALIVE_fnc_profileEntity;
} forEach _groupUnits;


_groupProfiles