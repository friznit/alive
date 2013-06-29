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


Author:
ARJay
---------------------------------------------------------------------------- */

private ["_cycleTime","_profiles"];

_cycleTime = 1;
_profiles = [ALIVE_profileHandler, "getProfilesByType", "entity"] call ALIVE_fnc_profileHandler;

waituntil {
	{
        private ["_unitProfile","_active","_waypoints","_currentPosition","_activeWaypoint","_destination","_distance","_direction","_newPosition","_leader","_profileID","_handleWPcomplete"];
			_unitProfile = [ALIVE_profileHandler, "getProfile", _x] call ALIVE_fnc_profileHandler;
			_profileID = [_unitProfile, "profileID"] call ALIVE_fnc_hashGet;
            _active = [_unitProfile,"active"] call ALIVE_fnc_hashGet;			
			_waypoints = [_unitProfile,"waypoints"] call ALIVE_fnc_hashGet;
            _waypointsCompleted = [_unitProfile,"waypointsCompleted",[]] call ALIVE_fnc_hashGet;
			_currentPosition = [_unitProfile,"position"] call ALIVE_fnc_hashGet;
            
			if(count _waypoints > 0) then {
				_activeWaypoint = _waypoints select 0;
                _activeType = [_activeWaypoint,"type"] call ALIVE_fnc_hashGet;
				_destination = [_activeWaypoint,"position"] call ALIVE_fnc_hashGet;
				_distance = _currentPosition distance _destination;
				if!(_active) then {
					
                    switch (_activeType) do {
                        case "MOVE" : {
                             _direction = [_currentPosition, _destination] call BIS_fnc_dirTo;
							 _newPosition = [_currentPosition, 3, _direction] call BIS_fnc_relPos;
                             _handleWPcomplete = {};

                        };
                        case "CYCLE" : {
                             _direction = [_currentPosition, _destination] call BIS_fnc_dirTo;
							 _newPosition = [_currentPosition, 3, _direction] call BIS_fnc_relPos;
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
                    
                    if(_distance <= 20) then {
                        _waypointsCompleted set [count _waypointsCompleted,_activeWaypoint];
						_waypoints set [0,objNull];
						_waypoints = _waypoints - [objNull];
                        
                        [] call _handleWPcomplete;
                        
                        [_unitProfile,"waypoints",_waypoints] call ALIVE_fnc_hashSet;
                    	[_unitProfile,"waypointsCompleted",_waypointsCompleted] call ALIVE_fnc_hashSet;
					};
                    
					[_unitProfile,"position",_newPosition] call ALIVE_fnc_profileEntity;
					[_unitProfile,"mergePositions"] call ALIVE_fnc_profileEntity;
				} else {
					_leader = [_unitProfile,"leader"] call ALIVE_fnc_hashGet;
					[_unitProfile,"position",getPosATL _leader] call ALIVE_fnc_profileEntity;
					[_unitProfile,"mergePositions"] call ALIVE_fnc_profileEntity;
				};
			};
		[_unitProfile, "debug", true] call ALIVE_fnc_profileEntity;
	} forEach _profiles;
	
	sleep _cycleTime;
	false	
};
	