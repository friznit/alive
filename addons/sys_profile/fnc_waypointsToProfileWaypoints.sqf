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

private ["_profile","_group","_waypoints","_profileWaypoint"];

_profile = _this select 0;
_group = _this select 1;

_waypoints = waypoints _group;

if(currentWaypoint _group < count waypoints _group) then {
	for "_i" from (currentWaypoint _group) to (count _waypoints)-1 do
	{
		_profileWaypoint = [(_waypoints select _i)] call ALIVE_fnc_waypointToProfileWaypoint;
		[_profile, "addWaypoint", _profileWaypoint] call ALIVE_fnc_profileEntity;
	};
};