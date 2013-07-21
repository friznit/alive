#include <\x\alive\addons\sys_profile\script_component.hpp>
SCRIPT(vehicleAssignmentsToProfileVehicleAssignments);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_vehicleAssignmentsToProfileVehicleAssignments

Description:
Read a real vehicles assignments and return a profileVehicle assignments

Parameters:
Vehicle - The vehicle

Returns:

Examples:
(begin example)
// read all real vehicle assignments of a vehicle
[_vehicle] call ALIVE_fnc_vehicleAssignmentsToProfileVehicleAssignments;
(end)

See Also:

Author:
ARJay
---------------------------------------------------------------------------- */

private ["_profile","_profileType","_profileID","_profileActive","_vehicle","_groupsInVehicle","_group","_units","_vehiclesUnitsIn","_leader",
"_entityID","_entityProfile","_entityProfileActive","_assignment","_vehicleAssignments","_vehicleID","_vehicleProfile","_vehicleProfileActive"];

_profile = _this select 0;

_profileType = [_profile,"type"] call ALIVE_fnc_hashGet;
_profileID = [_profile,"profileID"] call ALIVE_fnc_hashGet;
_profileActive = [_profile,"active"] call ALIVE_fnc_hashGet;

if(_profileType == "vehicle") then {

	_vehicle = [_profile,"vehicle"] call ALIVE_fnc_hashGet;	
	_groupsInVehicle = _vehicle call ALIVE_fnc_vehicleGetGroupsWithin;
	
	/*
	["VA TO PVA : %1",_profileID] call ALIVE_fnc_dump;	
	["GROUPS IN VEHICLE: %1",_groupsInVehicle] call ALIVE_fnc_dump;
	*/
	
	{
		_group = _x;
		_leader = leader _group;
		_entityID = _leader getVariable "profileID";
		_entityProfile = [ALIVE_profileHandler, "getProfile", _entityID] call ALIVE_fnc_profileHandler;
		_entityProfileActive = [_entityProfile,"active"] call ALIVE_fnc_hashGet;
		
		_assignment = [_vehicle, _group] call ALIVE_fnc_vehicleAssignmentToProfileVehicleAssignment;
		_vehicleAssignments = [_profileID,_entityID,_assignment];			
		
		[_profile, "addVehicleAssignment", _vehicleAssignments] call ALIVE_fnc_profileVehicle;
		
		if(_entityProfileActive) then {
			[_entityProfile,"despawn"] call ALIVE_fnc_profileEntity;
		};	
		
	} forEach _groupsInVehicle;
	
} else {
	
	_units = [_profile,"units"] call ALIVE_fnc_hashGet;
	_group = group (_units select 0);
	_vehiclesUnitsIn = _units call ALIVE_fnc_unitArrayGetVehiclesWithin;
	
	/*
	["VA TO PVA : %1",_profileID] call ALIVE_fnc_dump;
	["UNITS : %1",_units] call ALIVE_fnc_dump;
	["GROUP : %1",_group] call ALIVE_fnc_dump;
	["VEHICLES UNITS IN: %1",_vehiclesUnitsIn] call ALIVE_fnc_dump;
	*/
	
	{
		_vehicle = _x;
		_vehicleID = _vehicle getVariable "profileID";
		_vehicleProfile = [ALIVE_profileHandler, "getProfile", _vehicleID] call ALIVE_fnc_profileHandler;
		_vehicleProfileActive = [_vehicleProfile,"active"] call ALIVE_fnc_hashGet;
		
		_assignment = [_vehicle, _group] call ALIVE_fnc_vehicleAssignmentToProfileVehicleAssignment;
		_vehicleAssignments = [_vehicleID,_profileID,_assignment];			
		
		[_profile, "addVehicleAssignment", _vehicleAssignments] call ALIVE_fnc_profileEntity;
		
		if(_vehicleProfileActive) then {
			[_vehicleProfile,"despawn"] call ALIVE_fnc_profileVehicle;
		};			
	} forEach _vehiclesUnitsIn;
		
};