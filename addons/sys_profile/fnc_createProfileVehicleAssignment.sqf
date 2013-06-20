#include <\x\alive\addons\sys_profile\script_component.hpp>
SCRIPT(createProfileVehicleAssignment);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_createProfileVehicleAssignment

Description:
Creates a vehicle assignment array for the group and vehicle

Parameters:
Array - Entity profile
Array - Vehicle profile

Returns:
A vehicle assignment array

Examples:
(begin example)
// vehicle assignment
_result = [_profileEntity,_profileVehicle] call ALIVE_fnc_createProfileVehicleAssignment;
(end)

See Also:

Author:
ARJay
---------------------------------------------------------------------------- */

private ["_profileEntity","_profileVehicle","_entityID","_unitIndexes","_currentEntityAssignments","_vehicleID","_usedIndexes","_unitCount","_emptyPositionData",
"_vehicleAssignments","_unitAssignments","_assignments","_assignedCount","_assignment","_emptyCount"];
	
_profileEntity = _this select 0;
_profileVehicle = _this select 1;

_entityID = [_profileEntity, "profileID"] call ALIVE_fnc_hashGet;
_unitIndexes = [_profileEntity, "unitIndexes"] call ALIVE_fnc_profileEntity;
_currentEntityAssignments = [_profileEntity, "vehicleAssignments"] call ALIVE_fnc_hashGet;
_vehicleID = [_profileVehicle, "profileID"] call ALIVE_fnc_hashGet;

// get indexes of units that are already assigned to vehicles
_usedIndexes = _currentEntityAssignments call ALIVE_fnc_profileVehicleAssignmentGetUsedIndexes;
_unitIndexes = _unitIndexes - _usedIndexes;
_unitCount = count _unitIndexes;

// get empty position data for the vehicle
_emptyPositionData = _profileVehicle call ALIVE_fnc_profileVehicleAssignmentGetEmptyPositions;

/*
["used indexes:%1",_usedIndexes] call ALIVE_fnc_dump;
["unit indexes:%1",_unitIndexes] call ALIVE_fnc_dump;
["unit count:%1",_unitCount] call ALIVE_fnc_dump;
["empty position data:%1",_emptyPositionData] call ALIVE_fnc_dump;
*/

_vehicleAssignments = [] call ALIVE_fnc_hashCreate;
_unitAssignments = [] call ALIVE_fnc_hashCreate;
_assignments = [[],[],[],[]];
_assignedCount = 0;

scopeName "main";

for "_i" from 0 to (count _emptyPositionData)-1 do {
	_assignment = _assignments select _i;
	_emptyCount = _emptyPositionData select _i;

	for "_j" from 0 to (_emptyCount)-1 do {
	
		if(_unitCount == _assignedCount && _assignedCount > 0) then {
			breakTo "main";
		};			
		_assignment set [count _assignment, _unitIndexes select _assignedCount];			
		_assignedCount = _assignedCount + 1;			
	};
};

[_vehicleAssignments, _vehicleID, _assignments] call ALIVE_fnc_hashSet;
[_unitAssignments, _entityID, _assignments] call ALIVE_fnc_hashSet;

/*
["vehicle assignment:%1",_vehicleAssignments] call ALIVE_fnc_dump;
["vehicle assignment:%1",_unitAssignments] call ALIVE_fnc_dump;
*/

[_profileEntity, "addVehicleAssignment", _vehicleAssignments] call ALIVE_fnc_profileEntity;
[_profileVehicle, "addVehicleAssignment", _unitAssignments] call ALIVE_fnc_profileVehicle;