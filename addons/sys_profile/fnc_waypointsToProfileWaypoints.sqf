#include <\x\alive\addons\sys_profile\script_component.hpp>
SCRIPT(waypointsToProfileWaypoints);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_waypointsToProfileWaypoints

Description:
Takes real waypoints and creates profile waypoints

Parameters:
Array - The waypoints

Returns:

Examples:
(begin example)
_result = [_profile, _group] call ALIVE_fnc_waypointsToProfileWaypoints;
(end)

See Also:

Author:
ARJay
---------------------------------------------------------------------------- */

private ["_profile","_group","_isCycling","_waypoints","_profileWaypoint"];

_profile = _this select 0;
_group = _this select 1;

_isCycling = _profile select 2 select 25;

_waypoints = waypoints _group;

if(_isCycling) then {
	// if the entity has a cycle waypoint need to get all completed waypoints and 
	// stick them in the end of the waypoints array
	
	for "_i" from (currentWaypoint _group) to (count _waypoints)-1 do
	{
		_profileWaypoint = [(_waypoints select _i)] call ALIVE_fnc_waypointToProfileWaypoint;
		_profilePosition = [_profileWaypoint,"position"] call ALIVE_fnc_hashGet;
		if(_profilePosition select 0 > 0 && _profilePosition select 1 > 0) then {
			[_profile, "addWaypoint", _profileWaypoint] call ALIVE_fnc_profileEntity;
		};
	};
	
	for "_i" from 1 to (currentWaypoint _group)-1 do {
		_profileWaypoint = [(_waypoints select _i)] call ALIVE_fnc_waypointToProfileWaypoint;
		_profilePosition = [_profileWaypoint,"position"] call ALIVE_fnc_hashGet;
		if(_profilePosition select 0 > 0 && _profilePosition select 1 > 0) then {
			[_profile, "addWaypoint", _profileWaypoint] call ALIVE_fnc_profileEntity;
		};
	};
	
} else {

	// convert any non completed waypoints to profile waypoints
	if(currentWaypoint _group < count waypoints _group) then {
		for "_i" from (currentWaypoint _group) to (count _waypoints)-1 do
		{
			_profileWaypoint = [(_waypoints select _i)] call ALIVE_fnc_waypointToProfileWaypoint;
			_profilePosition = [_profileWaypoint,"position"] call ALIVE_fnc_hashGet;
			if(_profilePosition select 0 > 0 && _profilePosition select 1 > 0) then {
				[_profile, "addWaypoint", _profileWaypoint] call ALIVE_fnc_profileEntity;
			};
		};
	};
};