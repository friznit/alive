#include <\x\alive\addons\sys_profile\script_component.hpp>
SCRIPT(createProfilesFromGroupConfig);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_createProfilesFromGroupConfig

Description:
Create profiles based on definitions found in CfgGroups

Parameters:
String - Group class name from CfgGroups
Array - position
Scalar - direction

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

private ["_groupClass","_position","_direction","_spawnGoodPosition","_config","_groupName","_groupProfiles","_groupUnits","_groupVehicles","_class","_rank","_vehicle","_vehicleType"];

_groupClass = _this select 0;
_position = _this select 1;
_direction = if(count _this > 2) then {_this select 2} else {0};
_spawnGoodPosition = if(count _this > 3) then {_this select 3} else {true};
_prefix = if(count _this > 4) then {_this select 4} else {""};

_groupProfiles = [];

//["Group Class: %1",_groupClass] call ALIVE_fnc_dump;

_config = _groupClass call ALIVE_fnc_configGetGroup;

//["Group Config: %1 %2",_config,_groupClass] call ALIVE_fnc_dump;

if(count _config > 0) then {

	//["CFG: %1",_config] call ALIVE_fnc_dump;

	_groupName = getText(_config >> "name");
	_groupSide = getNumber(_config >> "side");
	_groupUnits = [];
	_groupVehicles = [];

	// loop through the config for the group
	for "_i" from 0 to count _config -1 do {
		_class = (_config select _i);
		if(isClass _class) then {
			_rank = getText(_class >> "rank");
			_vehicle = getText(_class >> "vehicle");
			_vehicleType = _vehicle call ALIVE_fnc_configGetVehicleClass;
			
			//["CGROUP Name: %1 VehicleType: %2",_groupName,_vehicleType] call ALIVE_fnc_dump;
			
			// seperate vehicles and units in the group
			if((_vehicleType == "Car")||(_vehicleType == "Truck")||(_vehicleType == "Tank")||(_vehicleType == "Armored")||(_vehicleType == "Ship")||(_vehicleType == "Air")) then {
				_groupVehicles set [count _groupVehicles, [_vehicle,_rank]];			
			} else {
				_groupUnits set [count _groupUnits, [_vehicle,_rank]];
			};		
		};
	};

	//["CGROUP Vehicles: %1 Units: %2",_groupVehicles,_groupUnits] call ALIVE_fnc_dump;


	// get counts of current profiles

	_entityID = [ALIVE_profileHandler, "getNextInsertEntityID"] call ALIVE_fnc_profileHandler;


	// create the group entity profile

	private ["_entityID","_side","_profileEntity","_classes","_positions","_damages","_ranks","_unit"];

	_side = _groupSide call ALIVE_fnc_sideNumberToText;

	_profileEntity = [nil, "create"] call ALIVE_fnc_profileEntity;
	[_profileEntity, "init"] call ALIVE_fnc_profileEntity;
	[_profileEntity, "profileID", format["%1-%2",_prefix,_entityID]] call ALIVE_fnc_profileEntity;
	[_profileEntity, "position", _position] call ALIVE_fnc_profileEntity;
	[_profileEntity, "side", _side] call ALIVE_fnc_profileEntity;
	[_profileEntity, "objectType", _groupClass] call ALIVE_fnc_profileEntity;

	if!(_spawnGoodPosition) then {
		[_profileEntity, "despawnPosition", _position] call ALIVE_fnc_profileEntity;
	};

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
		_vehicleID = [ALIVE_profileHandler, "getNextInsertVehicleID"] call ALIVE_fnc_profileHandler;
		_vehicleClass = _vehicle select 0;
		_vehicleRank = _vehicle select 1;
		
		//["V: %1 %2",_vehicle,_vehicleClass] call ALIVE_fnc_dump;
										
		_profileVehicle = [nil, "create"] call ALIVE_fnc_profileVehicle;
		[_profileVehicle, "init"] call ALIVE_fnc_profileVehicle;
		[_profileVehicle, "profileID", format["%1-%2",_prefix,_vehicleID]] call ALIVE_fnc_profileVehicle;
		[_profileVehicle, "vehicleClass", _vehicleClass] call ALIVE_fnc_profileVehicle;
		[_profileVehicle, "position", _position] call ALIVE_fnc_profileVehicle;
		[_profileVehicle, "direction", 0] call ALIVE_fnc_profileVehicle;
		[_profileVehicle, "side", _side] call ALIVE_fnc_profileVehicle;
		[_profileVehicle, "damage", 0] call ALIVE_fnc_profileVehicle;
		[_profileVehicle, "fuel", 1] call ALIVE_fnc_profileVehicle;
		
		if!(_spawnGoodPosition) then {
			[_profileVehicle, "despawnPosition", _position] call ALIVE_fnc_profileVehicle;
		};
		
		_groupProfiles set [count _groupProfiles, _profileVehicle];	
		[ALIVE_profileHandler, "registerProfile", _profileVehicle] call ALIVE_fnc_profileHandler;
		
		// create crew members for the vehicle
		
		_crew = _vehicleClass call ALIVE_fnc_configGetVehicleCrew;
		_vehiclePositions = [ALIVE_vehiclePositions,_vehicleClass] call ALIVE_fnc_hashGet;
		_countCrewPositions = 0;
		
		//["VP: %1 %2",_vehiclePositions, count _vehiclePositions] call ALIVE_fnc_dump;
		
		// count all non cargo positions
		for "_i" from 0 to count _vehiclePositions -2 do {
			_countCrewPositions = _countCrewPositions + (_vehiclePositions select _i);
		};
		
		// for all crew positions add units to the entity group
		for "_i" from 0 to _countCrewPositions -1 do {		
			[_profileEntity, "addUnit", [_crew,_position,0,_vehicleRank]] call ALIVE_fnc_profileEntity;
		};
		
		[_profileEntity,_profileVehicle] call ALIVE_fnc_createProfileVehicleAssignment;

	} forEach _groupVehicles;

	// create the group units

	{
		_unit = _x;
		_class = _unit select 0;
		_rank = _unit select 1;
		[_profileEntity, "addUnit", [_class,_position,0,_rank]] call ALIVE_fnc_profileEntity;
	} forEach _groupUnits;
	
};

_groupProfiles