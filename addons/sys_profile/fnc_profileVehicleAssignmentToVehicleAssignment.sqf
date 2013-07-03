#include <\x\alive\addons\sys_profile\script_component.hpp>
SCRIPT(profileVehicleAssignmentToVehicleAssignment);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_profileVehicleAssignmentToVehicleAssignment

Description:
Takes a profile vehicle assignment and creates real vehicle assignment

Parameters:
Array - Profile vehicle assignment
Array - Profile

Returns:

Examples:
(begin example)
// get empty positions
_result = _vehicleAssignment call ALIVE_fnc_profileVehicleAssignmentToVehicleAssignment;
(end)

See Also:

Author:
ARJay
---------------------------------------------------------------------------- */

private ["_vehicleAssignment","_profile","_profileType","_vehicle","_units","_vehicleProfileID","_vehicleProfile"];

_vehicleAssignment = _this select 0;
_profile = _this select 1;

_profileType = [_profile,"type"] call ALIVE_fnc_hashGet;

if(_profileType == "vehicle") then {

	_vehicle = [_profile,"vehicle"] call ALIVE_fnc_hashGet;	
	_entityProfileID = _vehicleAssignment select 1;
	_entityProfile = [ALIVE_profileHandler, "getProfile", _entityProfileID] call ALIVE_fnc_profileHandler;
	_entityProfileActive = [_entityProfile,"active"] call ALIVE_fnc_hashGet;
	
	/*
	[" "] call ALIVE_fnc_dump;
	["entity id: %1",_entityProfileID] call ALIVE_fnc_dump;
	_entityProfile call ALIVE_fnc_inspectHash;
	["entity active: %1",_entityProfileActive] call ALIVE_fnc_dump;
	*/
	
	if!(_entityProfileActive) then {
		[_entityProfile,"spawn"] call ALIVE_fnc_profileEntity;
	} else {
		_units = [_entityProfile,"units"] call ALIVE_fnc_hashGet;
		
		/*
		[" "] call ALIVE_fnc_dump;
		["VEH: %1",_vehicle] call ALIVE_fnc_dump;
		["UNI: %1",_units] call ALIVE_fnc_dump;
		["ASS: %1",_vehicleAssignment] call ALIVE_fnc_dump;
		*/
		
		_indexes = _vehicleAssignment;
		
		_vehicleAssignment = [_indexes,_units] call ALIVE_fnc_profileVehicleAssignmentIndexesToUnits;
		
		//["VEH ASS: %1",_vehicleAssignment] call ALIVE_fnc_dump;
		
		[_vehicleAssignment, _vehicle] call ALIVE_fnc_vehicleMoveIn;
	};
	
} else {

	_units = [_profile,"units"] call ALIVE_fnc_hashGet;
	_vehicleProfileID = _vehicleAssignment select 0;
	_vehicleProfile = [ALIVE_profileHandler, "getProfile", _vehicleProfileID] call ALIVE_fnc_profileHandler;
	_vehicleProfileActive = [_vehicleProfile,"active"] call ALIVE_fnc_hashGet;
	
	/*
	[" "] call ALIVE_fnc_dump;
	["vehicle id: %1",_vehicleProfileID] call ALIVE_fnc_dump;
	_vehicleProfile call ALIVE_fnc_inspectHash;
	["vehicle active: %1",_vehicleProfileActive] call ALIVE_fnc_dump;
	*/
	
	if!(_vehicleProfileActive) then {
		[_vehicleProfile,"spawn"] call ALIVE_fnc_profileVehicle;
	} else {
		_vehicle = [_vehicleProfile,"vehicle"] call ALIVE_fnc_hashGet;
		
		/*
		[" "] call ALIVE_fnc_dump;
		["VEH: %1",_vehicle] call ALIVE_fnc_dump;
		["UNI: %1",_units] call ALIVE_fnc_dump;
		["ASS: %1",_vehicleAssignment] call ALIVE_fnc_dump;
		*/
		
		_indexes = _vehicleAssignment;
		
		_vehicleAssignment = [_indexes,_units] call ALIVE_fnc_profileVehicleAssignmentIndexesToUnits;
		
		//["VEH ASS: %1",_vehicleAssignment] call ALIVE_fnc_dump;
		
		[_vehicleAssignment, _vehicle] call ALIVE_fnc_vehicleMoveIn;
	};
	
};