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

private ["_profileEntity","_profileVehicle","_vehicleID","_entityID","_vehicleClass","_unitCount","_emptyPositionData","_vehicleAssignments","_unitAssignments","_assignments","_assignedCount","_assignment","_emptyCount"];
	
_profileEntity = _this select 0;
_profileVehicle = _this select 1;

_entityID = [_profileEntity, "profileID"] call ALIVE_fnc_hashGet;
_unitCount = [_profileEntity, "unitCount"] call ALIVE_fnc_profileEntity;
_vehicleID = [_profileVehicle, "profileID"] call ALIVE_fnc_hashGet;
_vehicleClass = [_profileVehicle, "vehicleClass"] call ALIVE_fnc_hashGet;

if(isNil "ALIVE_vehiclePositions") then {
	[] call ALIVE_fnc_staticVehicleEmptyPositionData;
};

_emptyPositionData = [ALIVE_vehiclePositions, _vehicleClass] call ALIVE_fnc_hashGet;

_vehicleAssignments = [] call ALIVE_fnc_hashCreate;
_unitAssignments = [] call ALIVE_fnc_hashCreate;

scopeName "main";

_assignments = [[],[],[],[]];
_assignedCount = 0;

["unit count:%1",_unitCount] call ALIVE_fnc_dump;

for "_i" from 0 to (count _emptyPositionData)-1 do {

	_assignment = _assignments select _i;
	_emptyCount = _emptyPositionData select _i;
	
	["i:%1 empty count:%2",_i,_emptyCount] call ALIVE_fnc_dump;
	
	for "_j" from 0 to (_emptyCount)-1 do {
	
		["j:%1 assigned count:%2",_j,_assignedCount] call ALIVE_fnc_dump;
	
		if(_unitCount == _assignedCount && _assignedCount > 0) then {
			breakTo "main";
		};
		
		_assignment set [count _assignment, _assignedCount];
		
		_assignedCount = _assignedCount + 1;
	};
};

[_vehicleAssignments, _vehicleID, _assignments] call ALIVE_fnc_hashSet;
[_unitAssignments, _entityID, _assignments] call ALIVE_fnc_hashSet;

diag_log _vehicleAssignments;
diag_log _unitAssignments;