#include <\x\alive\addons\sys_profile\script_component.hpp>
SCRIPT(profileSpawner);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_profileSpawner

Description:
Spawns and despawns from profiles based on player distance

Parameters:

Returns:

Examples:
(begin example)
// start the profile spawner
[] call ALIVE_fnc_profileSpawner;
(end)

See Also:

Author:
Highhead
---------------------------------------------------------------------------- */

private ["_profiles"];

waituntil {

	sleep 3;
	_profiles = [ALIVE_profileHandler, "getProfilesByType", "entity"] call ALIVE_fnc_profileHandler;
	sleep 0.1;
	
	{
		private ["_profile", "_position","_active"];
		
		_profile = [ALIVE_profileHandler, "getProfile", _x] call ALIVE_fnc_profileHandler;
		_active = [_profile, "active"] call ALIVE_fnc_hashGet;
		_position = [_profile,"position"] call ALIVE_fnc_hashGet;
		
		if ([_position, 1000] call ALiVE_fnc_anyPlayersInRange > 0) then {
			if!(_active) then {
				[_profile, "spawn"] call ALIVE_fnc_profileEntity;
			};
		} else {
			if(_active) then {
				[_profile, "despawn"] call ALIVE_fnc_profileEntity;
			};
		};
		
		sleep 0.03;
		
	} forEach _profiles;

	false;
};