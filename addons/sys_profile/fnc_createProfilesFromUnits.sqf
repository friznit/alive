#include <\x\alive\addons\sys_profile\script_component.hpp>
SCRIPT(createProfilesFromUnits);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_createProfilesFromUnits

Description:
Create profiles for all units on the map that don't have profiles

Parameters:

Returns:

Examples:
(begin example)
// get profiles from all map placed units
[] call ALIVE_fnc_createProfilesFromUnits;
(end)

See Also:

Author:
Highhead
---------------------------------------------------------------------------- */

private ["_debug","_groups","_entityCount","_vehicleCount","_group","_leader","_units","_inVehicle","_unitClasses","_positions","_ranks","_damages","_vehicle"];

_debug = if(count _this > 0) then {_this select 0} else {false};

_groups = allGroups;
_entityCount = 0;
_vehicleCount = 0;


// DEBUG -------------------------------------------------------------------------------------
if(_debug) then {
	["----------------------------------------------------------------------------------------"] call ALIVE_fnc_dump;
	["ALIVE Create profiles from map groups"] call ALIVE_fnc_dump;
	[true] call ALIVE_fnc_timer;
};
// DEBUG -------------------------------------------------------------------------------------


{
	_group = _x;
	_leader = leader _group;
	_units = units _group;
	_inVehicle = !(vehicle _leader == _leader);
		
	if((_leader getVariable ["profileID",""] == "") && !(isPlayer _leader)) then {
	
		_unitClasses = [];
		_positions = [];
		_ranks = [];
		_damages = [];
			
		{
			_unitClasses set [count _unitClasses, typeOf _x];
			_positions set [count _positions, getPosATL _x];
			_ranks set [count _ranks, rank _x];
			_damages set [count _damages, getDammage _x];
		} foreach (_units);
		
		_profileEntity = [nil, "create"] call ALIVE_fnc_profileEntity;
		[_profileEntity, "init"] call ALIVE_fnc_profileEntity;
		[_profileEntity, "profileID", format["entity_%1",_entityCount]] call ALIVE_fnc_profileEntity;
		[_profileEntity, "unitClasses", _unitClasses] call ALIVE_fnc_profileEntity;
		[_profileEntity, "position", getPosATL _leader] call ALIVE_fnc_profileEntity;
		[_profileEntity, "positions", _positions] call ALIVE_fnc_profileEntity;
		[_profileEntity, "damages", _damages] call ALIVE_fnc_profileEntity;
		[_profileEntity, "ranks", _ranks] call ALIVE_fnc_profileEntity;
		[_profileEntity, "side", str(side _leader)] call ALIVE_fnc_profileEntity;
		
		[ALIVE_profileHandler, "registerProfile", _profileEntity] call ALIVE_fnc_profileHandler;
			   
		{
			_profileWaypoint = [_x] call ALIVE_fnc_waypointToProfileWaypoint;
			[_profileEntity, "addWaypoint", _profileWaypoint] call ALIVE_fnc_profileEntity;
		} forEach (waypoints _group);
		
		if (_inVehicle) then {
		
			_vehicle = (vehicle _leader);
			
			if((_vehicle getVariable ["profileID",""]) == "") then {
			
				_vehicle setVariable ["profileID",format["vehicle_%1",_vehicleCount]];
								
				_profileVehicle = [nil, "create"] call ALIVE_fnc_profileVehicle;
				[_profileVehicle, "init"] call ALIVE_fnc_profileVehicle;
				[_profileVehicle, "profileID", format["vehicle_%1",_vehicleCount]] call ALIVE_fnc_profileVehicle;
				[_profileVehicle, "vehicleClass", typeOf _vehicle] call ALIVE_fnc_profileVehicle;
				[_profileVehicle, "position", getPosATL _vehicle] call ALIVE_fnc_profileVehicle;
				[_profileVehicle, "direction", getDir _vehicle] call ALIVE_fnc_profileVehicle;
				[_profileVehicle, "damage", _vehicle call ALIVE_fnc_vehicleGetDamage] call ALIVE_fnc_profileVehicle;
				[_profileVehicle, "fuel", fuel _vehicle] call ALIVE_fnc_profileVehicle;
				[_profileVehicle, "ammo", _vehicle call ALIVE_fnc_vehicleGetAmmo] call ALIVE_fnc_profileVehicle;
				[_profileVehicle, "engineOn", isEngineOn _vehicle] call ALIVE_fnc_profileVehicle;
				[_profileVehicle, "canFire", canFire _vehicle] call ALIVE_fnc_profileVehicle;
				[_profileVehicle, "canMove", canMove _vehicle] call ALIVE_fnc_profileVehicle;
				[_profileVehicle, "needReload", needReload _vehicle] call ALIVE_fnc_profileVehicle;
				[_profileVehicle, "side", str(side _vehicle)] call ALIVE_fnc_profileVehicle;
				
				[ALIVE_profileHandler, "registerProfile", _profileVehicle] call ALIVE_fnc_profileHandler;
				
			} else {
				_profileVehicle = [ALIVE_profileHandler, "getProfile", _vehicle getVariable "profileID"] call ALIVE_fnc_profileHandler;
			};
			
			[_profileEntity,_profileVehicle] call ALIVE_fnc_createProfileVehicleAssignment;
			
			_vehicleCount = _vehicleCount + 1;
		};		
		
		_entityCount = _entityCount + 1;
	
	};
	
} forEach _groups;


// DEBUG -------------------------------------------------------------------------------------
if(_debug) then {
	["----------------------------------------------------------------------------------------"] call ALIVE_fnc_dump;
	["ALIVE Create profiles from map groups Complete - entity profiles created: [%1] vehicle profiles created: [%2]",_entityCount,_vehicleCount] call ALIVE_fnc_dump;
	[] call ALIVE_fnc_timer;
	[true] call ALIVE_fnc_timer;
	["ALIVE Deleting existing groups"] call ALIVE_fnc_dump;
};
// DEBUG -------------------------------------------------------------------------------------


_deleteEntityCount = 0;
_deleteVehicleCount = 0;

{
	_group = _x;
	_leader = leader _group;
	_units = units _group;
	_inVehicle = !(vehicle _leader == _leader);
	
	if!(isPlayer _leader) then {
	
		if (_inVehicle) then {
			_vehicle = (vehicle _leader);
			
			deleteVehicle _vehicle;
			
			_deleteVehicleCount = _deleteVehicleCount + 1;
		};
		
		{
			deleteVehicle _x;
		} forEach (_units);

		deleteGroup _group;
		
		_deleteEntityCount = _deleteEntityCount + 1;
	};
} forEach _groups;

_vehicles = vehicles;


// DEBUG -------------------------------------------------------------------------------------
if(_debug) then {
	["----------------------------------------------------------------------------------------"] call ALIVE_fnc_dump;
	["ALIVE Deleting existing groups Complete - groups deleted: [%1] vehicles deleted: [%2]",_deleteEntityCount,_deleteVehicleCount] call ALIVE_fnc_dump;
	[] call ALIVE_fnc_timer;
	[true] call ALIVE_fnc_timer;
	["ALIVE Create profiles from map empty vehicles"] call ALIVE_fnc_dump;
};
// DEBUG -------------------------------------------------------------------------------------

_vehicleCount = 0;

{
	_vehicle = _x;
	
	if((_vehicle getVariable ["profileID",""]) == "") then {
					
		_profileVehicle = [nil, "create"] call ALIVE_fnc_profileVehicle;
		[_profileVehicle, "init"] call ALIVE_fnc_profileVehicle;
		[_profileVehicle, "profileID", format["vehicle_%1",_vehicleCount]] call ALIVE_fnc_profileVehicle;
		[_profileVehicle, "vehicleClass", typeOf _vehicle] call ALIVE_fnc_profileVehicle;
		[_profileVehicle, "position", getPosATL _vehicle] call ALIVE_fnc_profileVehicle;
		[_profileVehicle, "direction", getDir _vehicle] call ALIVE_fnc_profileVehicle;
		[_profileVehicle, "damage", _vehicle call ALIVE_fnc_vehicleGetDamage] call ALIVE_fnc_profileVehicle;
		[_profileVehicle, "fuel", fuel _vehicle] call ALIVE_fnc_profileVehicle;
		[_profileVehicle, "ammo", _vehicle call ALIVE_fnc_vehicleGetAmmo] call ALIVE_fnc_profileVehicle;
		[_profileVehicle, "engineOn", isEngineOn _vehicle] call ALIVE_fnc_profileVehicle;
		[_profileVehicle, "canFire", canFire _vehicle] call ALIVE_fnc_profileVehicle;
		[_profileVehicle, "canMove", canMove _vehicle] call ALIVE_fnc_profileVehicle;
		[_profileVehicle, "needReload", needReload _vehicle] call ALIVE_fnc_profileVehicle;
		[_profileVehicle, "side", str(side _vehicle)] call ALIVE_fnc_profileVehicle;
		
		[ALIVE_profileHandler, "registerProfile", _profileVehicle] call ALIVE_fnc_profileHandler;
		
		_vehicleCount = _vehicleCount + 1;
				
		deleteVehicle _vehicle;
		
	};
	
} forEach _vehicles;


// DEBUG -------------------------------------------------------------------------------------
if(_debug) then {
	["----------------------------------------------------------------------------------------"] call ALIVE_fnc_dump;
	["ALIVE Create profiles from map empty vehicles Complete - vehicles profiles created: [%1]",_vehicleCount] call ALIVE_fnc_dump;
	[] call ALIVE_fnc_timer;
};
// DEBUG -------------------------------------------------------------------------------------