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

private ["_distance","_debug","_entityProfiles","_vehicleProfiles"];

_distance = if(count _this > 0) then {_this select 0} else {1000};
_debug = if(count _this > 1) then {_this select 1} else {false};


// DEBUG -------------------------------------------------------------------------------------
if(_debug) then {
	["----------------------------------------------------------------------------------------"] call ALIVE_fnc_dump;
	["ALIVE Profile spawner started"] call ALIVE_fnc_dump;
};
// DEBUG -------------------------------------------------------------------------------------


waituntil {

	sleep 3;
	_profiles = [ALIVE_profileHandler, "getProfiles"] call ALIVE_fnc_profileHandler;
	sleep 0.1;
	
	{
		private ["_profile","_profileID","_profileType","_position","_active"];
		
		_profile = _x;
		_profileID = [_profile,"profileID"] call ALIVE_fnc_hashGet;
		_profileType = [_profile,"type"] call ALIVE_fnc_hashGet;
		_active = [_profile, "active"] call ALIVE_fnc_hashGet;
		
		if(_active) then {
			if(_profileType == "vehicle") then {
				_vehicle = [_profile,"vehicle"] call ALIVE_fnc_hashGet;
				_position = getPosATL _vehicle;
			}else{
				_leader = [_profile,"leader"] call ALIVE_fnc_hashGet;
				_position = getPosATL _leader;
			};
		}else{
			_position = [_profile,"position"] call ALIVE_fnc_hashGet;
		};		
		
		if ([_position, _distance] call ALiVE_fnc_anyPlayersInRange > 0) then {
			
			if!(_active) then {
			
				
				// DEBUG -------------------------------------------------------------------------------------
				if(_debug) then {
					["----------------------------------------------------------------------------------------"] call ALIVE_fnc_dump;
					["ALIVE Profile spawner - spawn [%1]",_profileID] call ALIVE_fnc_dump;
				};
				// DEBUG -------------------------------------------------------------------------------------
					
			
				switch(_profileType) do {
						case "entity": {
							[_profile, "spawn"] call ALIVE_fnc_profileEntity;
						};
						case "mil": {
							[_profile, "spawn"] call ALIVE_fnc_profileMil;
						};
						case "civ": {
							[_profile, "spawn"] call ALIVE_fnc_profileCiv;
						};
						case "vehicle": {
							[_profile, "spawn"] call ALIVE_fnc_profileVehicle;
						};
				};
			};
		} else {
			
			if(_active) then {
			
			
				// DEBUG -------------------------------------------------------------------------------------
				if(_debug) then {
					["----------------------------------------------------------------------------------------"] call ALIVE_fnc_dump;
					["ALIVE Profile spawner - despawn [%1]",_profileID] call ALIVE_fnc_dump;
				};
				// DEBUG -------------------------------------------------------------------------------------
			
			
				switch(_profileType) do {
						case "entity": {
							[_profile, "despawn"] call ALIVE_fnc_profileEntity;
						};
						case "mil": {
							[_profile, "despawn"] call ALIVE_fnc_profileMil;
						};
						case "civ": {
							[_profile, "despawn"] call ALIVE_fnc_profileCiv;
						};
						case "vehicle": {
							[_profile, "despawn"] call ALIVE_fnc_profileVehicle;
						};
				};
			};
		};
		
		sleep 0.03;
		
	} forEach (_profiles select 2);

	false;
};