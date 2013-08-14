#include <\x\alive\addons\sys_profile\script_component.hpp>
SCRIPT(simulateProfileMovement);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_simulateProfileMovement

Description:
Simulates movement of profiles that have waypoints set

Parameters:

Returns:

Examples:
(begin example)
_result = [] call ALIVE_fnc_simulateProfileMovement;
(end)

See Also:
nothing yet

Author:
ARJay
Highhead
---------------------------------------------------------------------------- */

private ["_debug","_cycleTime","_profiles","_markers","_deleteMarkers","_deleteMarker","_createMarker"];

_debug = if(count _this > 0) then {_this select 0} else {false};

_cycleTime = 10;
//_profiles = [ALIVE_profileHandler, "getProfilesByType", "entity"] call ALIVE_fnc_profileHandler;
_markers = [] call ALIVE_fnc_hashCreate;


// DEBUG -------------------------------------------------------------------------------------
if(_debug) then {
	["----------------------------------------------------------------------------------------"] call ALIVE_fnc_dump;
	["ALIVE Simulated profile movement - started cycling at %1 second iterations",_cycleTime] call ALIVE_fnc_dump;
};
// DEBUG -------------------------------------------------------------------------------------


_deleteMarkers = {
	{
		deleteMarkerLocal _x;
	} forEach (_markers select 2);
	_markers = [] call ALIVE_fnc_hashCreate;
};

_deleteMarker = {
	private ["_profile","_m","_profileID"];
	_profile = _this;
	
	_profileID = [_profile,"profileID"] call ALIVE_fnc_hashGet;
	
	_profileIndex = _markers select 1;
	if(_profileID in _profileIndex) then {	
		_m = [_markers,_profileID] call ALIVE_fnc_hashGet;			
		deleteMarkerLocal _m;		
		[_markers,_profileID] call ALIVE_fnc_hashRem;
	};
};

_createMarker = {
	private ["_profile","_waypoint","_m","_position","_profileID","_debugColor","_profileSide","_markerLabel"];
	_profile = _this select 0;
	_waypoint = _this select 1;
	
	_entityProfile call _deleteMarker;

	_position = [_waypoint,"position"] call ALIVE_fnc_hashGet;
	_profileID = [_profile,"profileID"] call ALIVE_fnc_hashGet;
	_profileSide = [_profile,"side"] call ALIVE_fnc_hashGet;
	_markerLabel = format["%1 destination", _profileID];
	
	switch(_profileSide) do {
		case "EAST":{
			_debugColor = "ColorRed";
		};
		case "WEST":{
			_debugColor = "ColorBlue";
		};
		case "CIV":{
			_debugColor = "ColorYellow";
		};
		case "GUER":{
			_debugColor = "ColorGreen";
		};
		default {
			_debugColor = "ColorGreen";
		};
	};

	if(count _position > 0) then {
		_m = createMarkerLocal [format["MARKER_%1",_profileID], _position];
		_m setMarkerShapeLocal "ICON";
		_m setMarkerSizeLocal [1, 1];
		_m setMarkerTypeLocal "waypoint";
		_m setMarkerColorLocal _debugColor;
		_m setMarkerTextLocal format["%1 destination",_profileID];

		[_markers,_profileID,_m] call ALIVE_fnc_hashSet;
	};
};


waituntil {

	sleep 0.5;
	_profiles = [ALIVE_profileHandler, "getProfiles"] call ALIVE_fnc_profileHandler;
	sleep 0.1;

	{
        private ["_entityProfile","_profileID","_active","_waypoints","_currentPosition","_vehiclesInCommandOf","_vehicleCommander",
		"_vehicleCargo","_vehiclesInCargoOf","_activeWaypoint","_type","_speed","_destination","_distance","_speedPerSecondArray",
		"_speedPerSecond","_moveDistance","_vehicleProfile","_vehicleClass","_vehicleAssignments","_speedArray","_direction","_newPosition","_leader",
		"_handleWPcomplete","_statements"];

		_entityProfile = _x;
		_profileType = _entityProfile select 2 select 5; //[_profile,"type"] call ALIVE_fnc_hashGet;
		
		if(_profileType == "entity") then {
		
			if(count _entityProfile > 0) then {
				
				_profileID = _entityProfile select 2 select 4; //[_profile,"profileID"] call ALIVE_fnc_hashGet;
				_active = _entityProfile select 2 select 1; //[_profile, "active"] call ALIVE_fnc_hashGet;	
				_waypoints = _entityProfile select 2 select 16; //[_entityProfile,"waypoints"] call ALIVE_fnc_hashGet;
				_waypointsCompleted = _entityProfile select 2 select 17; //[_entityProfile,"waypointsCompleted",[]] call ALIVE_fnc_hashGet;
				_currentPosition = _entityProfile select 2 select 2; //[_entityProfile,"position"] call ALIVE_fnc_hashGet;
				_vehiclesInCommandOf = _entityProfile select 2 select 8; //[_entityProfile,"vehiclesInCommandOf"] call ALIVE_fnc_hashGet;
				_vehiclesInCargoOf = _entityProfile select 2 select 9; //[_entityProfile,"vehiclesInCargoOf"] call ALIVE_fnc_hashGet;
				_speedPerSecondArray = _entityProfile select 2 select 22; //[_entityProfile, "speedPerSecond"] call ALIVE_fnc_hashGet;
				_vehicleCommander = false;
				_vehicleCargo = false;
				
				// if entity is commanding a vehicle/s
				if(count _vehiclesInCommandOf > 0) then {
					_vehicleCommander = true;				
				};
				
				// if entity is cargo of vehicle/s
				if(count _vehiclesInCargoOf > 0) then {
					_vehicleCargo = true;
				};
							
				// entity has waypoints assigned and entity is not in cargo of a vehicle
				if(count _waypoints > 0 && !(_vehicleCargo)) then {
					
					// entity is not spawned, simulate
					if!(_active) then {					
					
						_activeWaypoint = _waypoints select 0;
						_type = [_activeWaypoint,"type"] call ALIVE_fnc_hashGet;
						_speed = [_activeWaypoint,"speed"] call ALIVE_fnc_hashGet;
						_destination = [_activeWaypoint,"position"] call ALIVE_fnc_hashGet;
						_statements = [_activeWaypoint,"statements"] call ALIVE_fnc_hashGet;
						_distance = _currentPosition distance _destination;				
										
						switch(_speed) do {
							case "LIMITED": { _speedPerSecond = _speedPerSecondArray select 0; };
							case "NORMAL": { _speedPerSecond = _speedPerSecondArray select 1; };
							case "FULL": { _speedPerSecond = _speedPerSecondArray select 2; };
							case default { _speedPerSecond = _speedPerSecondArray select 1; };
						};		

						_moveDistance = floor(_speedPerSecond * _cycleTime);
					
						// DEBUG -------------------------------------------------------------------------------------
						if(_debug) then {
							//["----------------------------------------------------------------------------------------"] call ALIVE_fnc_dump;
							//["ALIVE Simulated profile movement Profile: [%1] WPType: [%2] WPSpeed: [%3] Distance: [%4] MoveSpeed: [%5] SpeedArray: %6",_profileID,_type,_speed,_distance,_speedPerSecond,_speedPerSecondArray] call ALIVE_fnc_dump;
							[_entityProfile,_activeWaypoint] call _createMarker;
						};
						// DEBUG -------------------------------------------------------------------------------------
						
						switch (_type) do {
							case "MOVE" : {
								 _direction = [_currentPosition, _destination] call BIS_fnc_dirTo;
								 _newPosition = [_currentPosition, _moveDistance, _direction] call BIS_fnc_relPos;
								 _handleWPcomplete = {};

							};
							case "CYCLE" : {
								 _direction = [_currentPosition, _destination] call BIS_fnc_dirTo;
								 _newPosition = [_currentPosition, _moveDistance, _direction] call BIS_fnc_relPos;
								 _handleWPcomplete = {
									_waypoints = _waypoints + _waypointsCompleted;
									_waypointsCompleted = [];
								};
							};
							default {
								_newPosition = _currentPosition;
								_handleWPcomplete = {};
							};
						};
						
						// distance to wp destination within completion radius
						if(_distance <= (_moveDistance * 2)) then {
						
							// DEBUG -------------------------------------------------------------------------------------
							if(_debug) then {
								_entityProfile call _deleteMarker;
							};
							// DEBUG -------------------------------------------------------------------------------------
							
							_waypointsCompleted set [count _waypointsCompleted,_activeWaypoint];
							_waypoints set [0,objNull];
							_waypoints = _waypoints - [objNull];
							
							//Needs review of any variables in hashes
							if ((typeName _statements == "ARRAY") && {call compile (_statements select 0)}) then {call compile (_statements select 1)};
							
							[] call _handleWPcomplete;
							
							[_entityProfile,"waypoints",_waypoints] call ALIVE_fnc_hashSet;
							[_entityProfile,"waypointsCompleted",_waypointsCompleted] call ALIVE_fnc_hashSet;
						};
						
											
						if(_vehicleCommander) then {
							// if in command of vehicle move all entities within the vehicle						
							// set the vehicle position and merge all assigned entities positions
							{
								_vehicleProfile = [ALIVE_profileHandler, "getProfile", _x] call ALIVE_fnc_profileHandler;
								[_vehicleProfile,"position",_newPosition] call ALIVE_fnc_profileVehicle;
								[_vehicleProfile,"mergePositions"] call ALIVE_fnc_profileVehicle;
							} forEach _vehiclesInCommandOf;												
						}else{
							// set the entity position and merge all unit positions to group position
							[_entityProfile,"position",_newPosition] call ALIVE_fnc_profileEntity;
							[_entityProfile,"mergePositions"] call ALIVE_fnc_profileEntity;
						};
					
					// entity is spawned, update positions
					} else {
					
						_leader = [_entityProfile,"leader"] call ALIVE_fnc_hashGet;
						_newPosition = getPosATL _leader;
					
						if(_vehicleCommander) then {
							// if in command of vehicle move all entities within the vehicle						
							// set the vehicle position and merge all assigned entities positions
							{
								_vehicleProfile = [ALIVE_profileHandler, "getProfile", _x] call ALIVE_fnc_profileHandler;
								[_vehicleProfile,"position",_newPosition] call ALIVE_fnc_profileVehicle;
								[_vehicleProfile,"mergePositions"] call ALIVE_fnc_profileVehicle;
							} forEach _vehiclesInCommandOf;												
						} else {
							// set the entity position and merge all unit positions to group position
							_leader = [_entityProfile,"leader"] call ALIVE_fnc_hashGet;
							[_entityProfile,"position",_newPosition] call ALIVE_fnc_profileEntity;
							[_entityProfile,"mergePositions"] call ALIVE_fnc_profileEntity;
						};
					};
				};
			};
		};
	} forEach (_profiles select 2);
	
	sleep _cycleTime;
	false	
};