#include <\x\alive\addons\mil_command\script_component.hpp>
SCRIPT(managedGarrison);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_managedGarrison

Description:
Managed garrison command

Parameters:
Profile - profile
Args - array

Returns:

Examples:
(begin example)
//
_result = [_profile, []] call ALIVE_fnc_managedGarrison;
(end)

See Also:

Author:
ARJay
---------------------------------------------------------------------------- */

private ["_profile","_commandState","_commandName","_args","_state","_debug","_profileID","_leader","_group",
"_units","_nextState","_nextStateArgs","_garrisonPosition","_garrisonRadius"];

_profile = _this select 0;
_commandState = _this select 1;
_commandName = _this select 2;
_args = _this select 3;
_state = _this select 4;
_debug = _this select 5;

_profileID = _profile select 2 select 4;
_leader = _profile select 2 select 10;
_group = _profile select 2 select 13;
_units = _profile select 2 select 21;

_nextState = _state;
_nextStateArgs = [];

_garrisonPosition = _args select 0;
_garrisonRadius = _args select 1;

switch (_state) do {
	case "init":{
	
		private ["_distanceToGarrison"];

		_distanceToGarrison = _leader distance _garrisonPosition;

		if(_distanceToGarrison > 50) then {
		    _group addWaypoint [_garrisonPosition, 10];

		    _nextState = "travel";
            _nextStateArgs = _args;

		}else{
            _nextState = "garrison";
            _nextStateArgs = _args;
		};

		[_commandState, _profileID, [_profile, [_commandName,"managed",_args,_nextState,_nextStateArgs]]] call ALIVE_fnc_hashSet;
	};
	case "travel":{

		private ["_currentWaypoint","_waypoints","_waypointCount"];

		_currentWaypoint = currentWaypoint _group;
		_waypoints = waypoints _group;
		_waypointCount = count _waypoints;

		if(_currentWaypoint == _waypointCount) then {
            _nextState = "garrison";
            _nextStateArgs = _args;

            [_commandState, _profileID, [_profile, [_commandName,"managed",_args,_nextState,_nextStateArgs]]] call ALIVE_fnc_hashSet;
		};

	};
	case "garrison":{

		[_group,_garrisonPosition,_garrisonRadius,false] call ALIVE_fnc_groupGarrison;
		
		_nextState = "complete";
		_nextStateArgs = [];
		
		[_commandState, _profileID, [_profile, [_commandName,"managed",_args,_nextState,_nextStateArgs]]] call ALIVE_fnc_hashSet;
	};
};