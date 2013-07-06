#include <\x\alive\addons\sys_profile\script_component.hpp>
SCRIPT(profileWaypointsToWaypoints);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_profileWaypointsToWaypoints

Description:
Takes profile waypoints and creates a real waypoints

Parameters:
Array - profile waypoints
Group - The group

Returns:

Examples:
(begin example)
_result = [_profileWaypoints, _group] call ALIVE_fnc_profileWaypointsToWaypoints;
(end)

See Also:


Author:
ARJay
---------------------------------------------------------------------------- */

private ["_waypoints","_group","_waypointCount"];
	
_waypoints = _this select 0;
_group = _this select 1;

if(count _waypoints > 0) then {
	_waypointCount = 0;
	{
		if(_waypointCount == 0) then {
			[_x, _group, true] call ALIVE_fnc_profileWaypointToWaypoint;
		} else {
			[_x, _group] call ALIVE_fnc_profileWaypointToWaypoint;
		};
		_waypointCount = _waypointCount + 1;
	} forEach _waypoints;
};