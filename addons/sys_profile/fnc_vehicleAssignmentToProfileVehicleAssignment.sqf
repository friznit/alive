#include <\x\alive\addons\sys_profile\script_component.hpp>
SCRIPT(vehicleAssignmentToProfileVehicleAssignment);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_vehicleAssignmentToProfileVehicleAssignment

Description:
Read a real vehicles assignments and return a profileVehicle assignment

Parameters:
Vehicle - The vehicle
Group - The group

Returns:
assignments array

Examples:
(begin example)
// read group assignments for vehicle
_result = [_vehicle, _group] call ALIVE_fnc_vehicleAssignmentToProfileVehicleAssignment;
(end)

See Also:

Author:
ARJay
---------------------------------------------------------------------------- */

private ["_vehicle","_group","_units","_unitIndex","_assignments","_inVehicle","_assignedRole","_assignedRoleName","_cargo","_turret",
"_assignedTurret","_turretConfig","_turretIsGunner","_turretIsCommander","_isTurret","_gunner","_commander"];

_vehicle = _this select 0;
_group = _this select 1;

_units = units _group;
_unitIndex = 0;

_assignments = [[],[],[],[],[]];

{
	_inVehicle = (vehicle _x);
	
	if(_inVehicle == _vehicle) then {
	
		_assignedRole = assignedVehicleRole _x;
		_assignedRoleName = _assignedRole select 0;
		
		switch(_assignedRoleName) do {
			case "Driver":{
				_assignments set [0, [_unitIndex]];
			};
			case "Cargo":{
				_cargo = _assignments select 4;
				_cargo set [count _cargo,_unitIndex];
				_assignments set [4, _cargo];
			};
			case "Turret":{
				_assignedTurret = _assignedRole select 1;
				_turretConfig = [_vehicle, _assignedTurret] call CBA_fnc_getTurret;
				_turretIsGunner = getNumber(_turretConfig >> "primaryGunner");
				_turretIsCommander = getNumber(_turretConfig >> "primaryObserver");
				_isTurret = true;
				
				if(_turretIsGunner == 1) then {
					_gunner = _assignments select 1;
					_gunner set [count _gunner,_unitIndex];
					_assignments set [1, _gunner];
					_isTurret = false;
				};
				
				if(_turretIsCommander == 2) then {
					_commander = _assignments select 1;
					_commander set [count _commander,_unitIndex];
					_assignments set [2, _commander];
					_isTurret = false;
				};
				
				if(_isTurret) then {
					_turret = _assignments select 3;
					_turret set [count _turret,_unitIndex];
					_assignments set [3, _turret];
				};			
			};
		};
	};	
	_unitIndex = _unitIndex + 1;
} forEach _units;

_assignments