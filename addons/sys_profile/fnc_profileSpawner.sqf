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

private ["_side","_spawnDistance","_debug","_entityProfiles","_vehicleProfiles"];

_side = _this select 0;
_spawnDistance = if(count _this > 1) then {_this select 1} else {1000};
_debug = if(count _this > 2) then {_this select 2} else {false};

_profiles = [ALIVE_profileHandler, "getProfilesBySideFull", _side] call ALIVE_fnc_profileHandler;

{
	private ["_profile","_profileID","_profileType","_position","_spawn","_active"];

	_profile = _x;
	_active = _profile select 2 select 1; //[_profile, "active"] call ALIVE_fnc_hashGet;
	
	if!(_active) then {
		
		_profileID = _profile select 2 select 4; //[_profile,"profileID"] call ALIVE_fnc_hashGet;
		_profileType = _profile select 2 select 5; //[_profile,"type"] call ALIVE_fnc_hashGet;
		_position = _profile select 2 select 2; //_position = [_profile,"position"] call ALIVE_fnc_hashGet;

		_spawn = false;
		if ([_position, _spawnDistance] call ALiVE_fnc_anyPlayersInRange > 0) then {
		    _spawn = true;
		}else{
            if ([_position, _spawnDistance] call ALiVE_fnc_anyAutonomousInRange > 0) then {
                _spawn = true;
            };
		};
		
		if (_spawn) then {
				
			// DEBUG -------------------------------------------------------------------------------------
			if(_debug) then {
				//["----------------------------------------------------------------------------------------"] call ALIVE_fnc_dump;
				//["ALIVE Profile spawner - spawn [%1]",_profileID] call ALIVE_fnc_dump;			
			};
			// DEBUG -------------------------------------------------------------------------------------					
			
			switch(_profileType) do {
					case "entity": {
						[_profile, "spawn"] call ALIVE_fnc_profileEntity;
					};
					case "vehicle": {
						[_profile, "spawn"] call ALIVE_fnc_profileVehicle;
					};
			};
			
			sleep 0.05;
		};
	}
} forEach (_profiles select 2);