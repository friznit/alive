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

private ["_debug","_cycleTime","_profiles"];

_debug = if(count _this > 0) then {_this select 0} else {false};

_cycleTime = 1;
_profiles = [ALIVE_profileHandler, "getProfilesByType", "entity"] call ALIVE_fnc_profileHandler;


// DEBUG -------------------------------------------------------------------------------------
if(_debug) then {
	["----------------------------------------------------------------------------------------"] call ALIVE_fnc_dump;
	["ALIVE Simulated profile movement - started cycling at %1 second iterations",_cycleTime] call ALIVE_fnc_dump;
};
// DEBUG -------------------------------------------------------------------------------------


waituntil {
	{
        private ["_entityProfile","_profileID","_active","_waypoints","_currentPosition","_vehiclesInCommandOf","_vehicleCommander","_vehicleCargo","_vehiclesInCargoOf","_activeWaypoint","_type",
		"_speed","_destination","_distance","_speedPerSecondArray","_speedPerSecond","_vehicleProfile","_vehicleClass","_vehicleAssignments","_speedArray","_direction","_newPosition","_leader","_handleWPcomplete","_statements"];
					
			_entityProfile = [ALIVE_profileHandler, "getProfile", _x] call ALIVE_fnc_profileHandler;
			_profileID = [_entityProfile, "profileID"] call ALIVE_fnc_hashGet;
            _active = [_entityProfile,"active"] call ALIVE_fnc_hashGet;			
			_waypoints = [_entityProfile,"waypoints"] call ALIVE_fnc_hashGet;
            _waypointsCompleted = [_entityProfile,"waypointsCompleted",[]] call ALIVE_fnc_hashGet;
			_currentPosition = [_entityProfile,"position"] call ALIVE_fnc_hashGet;
			_vehiclesInCommandOf = [_entityProfile,"vehiclesInCommandOf"] call ALIVE_fnc_hashGet;
			_vehiclesInCargoOf = [_entityProfile,"vehiclesInCargoOf"] call ALIVE_fnc_hashGet;
			_speedPerSecondArray = [_entityProfile, "speedPerSecond"] call ALIVE_fnc_hashGet;
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
				
				
				// DEBUG -------------------------------------------------------------------------------------
				if(_debug) then {
					["----------------------------------------------------------------------------------------"] call ALIVE_fnc_dump;
					["ALIVE Simulated profile movement Profile: [%1] WPType: [%2] WPSpeed: [%3] Distance: [%4] MoveSpeed: [%5] SpeedArray: %6",_profileID,_type,_speed,_distance,_speedPerSecond,_speedPerSecondArray] call ALIVE_fnc_dump;
				};
				// DEBUG -------------------------------------------------------------------------------------
				
				
				// entity is not spawned, simulate
				if!(_active) then {					
					
                    switch (_type) do {
                        case "MOVE" : {
                             _direction = [_currentPosition, _destination] call BIS_fnc_dirTo;
							 _newPosition = [_currentPosition, _speedPerSecond, _direction] call BIS_fnc_relPos;
                             _handleWPcomplete = {};

                        };
                        case "CYCLE" : {
                             _direction = [_currentPosition, _destination] call BIS_fnc_dirTo;
							 _newPosition = [_currentPosition, _speedPerSecond, _direction] call BIS_fnc_relPos;
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
                    if(_distance <= (_speedPerSecond * 2)) then {
                        _waypointsCompleted set [count _waypointsCompleted,_activeWaypoint];
						_waypoints set [0,objNull];
						_waypoints = _waypoints - [objNull];
                        if (call compile (_statements select 0)) then {call compile (_statements select 1)};
                        
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
	} forEach _profiles;
	
	sleep _cycleTime;
	false	
};