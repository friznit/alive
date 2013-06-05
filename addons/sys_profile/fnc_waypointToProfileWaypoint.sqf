#include <\x\alive\addons\sys_profile\script_component.hpp>
SCRIPT(waypointToProfileWaypoint);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_waypointToProfileWaypoint

Description:
Takes a real waypoint and creates a profile waypoint

Parameters:

"waypoint"

Returns:
A profile waypoint

Examples:
(begin example)
_result = [_waypoint] call ALIVE_fnc_waypointToProfileWaypoint;
(end)

See Also:


Author:
ARJay
---------------------------------------------------------------------------- */

private ["_waypoint","_currentWaypoint","_waypoint","_position","_radius","_type","_formation","_behaviour","_combatMode","_speed","_completionRadius","_timeout","_description"];
	
_waypoint = _this select 0;

_position = waypointPosition _waypoint;
_radius = 0;
_type = waypointType _waypoint;
_speed = waypointSpeed _waypoint;
_completionRadius = waypointCompletionRadius _waypoint;
_timeout = waypointTimeout _waypoint;
_formation = waypointFormation _waypoint;
_combatMode = waypointCombatMode _waypoint;
_behaviour = waypointBehaviour _waypoint;
_description = waypointDescription _waypoint;

_profileWaypoint = [] call CBA_fnc_hashCreate;
[_profileWaypoint,"position",_position] call CBA_fnc_hashSet;
[_profileWaypoint,"radius",_radius] call CBA_fnc_hashSet;
[_profileWaypoint,"type",_type] call CBA_fnc_hashSet;
[_profileWaypoint,"speed",_speed] call CBA_fnc_hashSet;
[_profileWaypoint,"completionRadius",_completionRadius] call CBA_fnc_hashSet;
[_profileWaypoint,"timeout",_timeout] call CBA_fnc_hashSet;
[_profileWaypoint,"formation",_formation] call CBA_fnc_hashSet;
[_profileWaypoint,"combatMode",_combatMode] call CBA_fnc_hashSet;
[_profileWaypoint,"behaviour",_behaviour] call CBA_fnc_hashSet;
[_profileWaypoint,"description",_description] call CBA_fnc_hashSet;
[_profileWaypoint,"attachVehicle",""] call CBA_fnc_hashSet;

diag_log _profileWaypoint;

_profileWaypoint