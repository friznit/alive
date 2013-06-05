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
_result = [_profileHandler] call ALIVE_fnc_simulateProfileMovement;
(end)

See Also:


Author:
ARJay
---------------------------------------------------------------------------- */

private ["_profileHandler","_cycleTime","_profiles","_unitProfile","_active","_waypoints","_currentPosition","_activeWaypoint","_destination","_distance"];

_profileHandler = _this select 0;
_cycleTime = 1;
_profiles = [_profileHandler, "getProfilesByType", "agent"] call ALIVE_fnc_profileHandler;

waituntil {
	{
			_unitProfile = [_profileHandler, "getProfile", _x] call ALIVE_fnc_profileHandler;
			_active = [_unitProfile,"active"] call CBA_fnc_hashGet;
			_unit = [_unitProfile,"unit"] call CBA_fnc_hashGet;
			_waypoints = [_unitProfile,"waypoints"] call CBA_fnc_hashGet;
			_currentPosition = [_unitProfile,"position"] call CBA_fnc_hashGet;
			if(count _waypoints > 0) then {
				_activeWaypoint = _waypoints select 0;
				_destination = [_activeWaypoint,"position"] call CBA_fnc_hashGet;
				_distance = _currentPosition distance _destination;
				if!(_active) then {
					_direction = [_currentPosition, _destination] call BIS_fnc_dirTo;
					_newPosition = [_currentPosition, 2, _direction] call BIS_fnc_relPos;
					if(_distance <= 50) then {
						_waypoints set [0,objNull];
						_waypoints = _waypoints - [objNull];
						diag_log _waypoints;
						[_unitProfile,"waypoints",_waypoints] call CBA_fnc_hashSet;
					};
					[_unitProfile,"position",_newPosition] call CBA_fnc_hashSet;
					[_unitProfile, "debug", false] call ALIVE_fnc_agentProfile;
					[_unitProfile, "debug", true] call ALIVE_fnc_agentProfile;
				} else {
					[_unitProfile,"position",getPos _unit] call CBA_fnc_hashSet;
					[_unitProfile, "debug", false] call ALIVE_fnc_agentProfile;
					[_unitProfile, "debug", true] call ALIVE_fnc_agentProfile;
				};
			}
			
	} forEach _profiles;
	
	sleep _cycleTime;
	false	
};
	