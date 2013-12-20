#include <\x\alive\addons\sys_profile\script_component.hpp>
SCRIPT(profileSystemInit);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_profileSystemInit
Description:
Creates the server side object to store settings

Parameters:
_this select 0: OBJECT - Reference to module

Returns:
Nil

See Also:

Author:
ARjay
Peer Reviewed:
nil
---------------------------------------------------------------------------- */

private ["_logic","_debug","_plotSectors","_syncMode","_spawnRadius","_activeLimiter","_syncedUnits","_profileSystem"];

PARAMS_1(_logic);

// Confirm init function available
ASSERT_DEFINED("ALIVE_fnc_profileSystem","Main function missing");

if(isServer) then {
	
	//waituntil {sleep 1; ["PS WAITING"] call ALIVE_fnc_dump; time > 0};
	
	_debug = _logic getVariable ["debug",false];
	_syncMode = _logic getVariable ["syncronised","ADD"];	
	_syncedUnits = synchronizedObjects _logic;
	_spawnRadius = parseNumber (_logic getVariable ["spawnRadius","1000"]);
	_activeLimiter = parseNumber (_logic getVariable ["activeLimiter","30"]);

	["ALIVE Active Limit: %1", _activeLimiter] call ALIVE_fnc_dump;

	if(_debug == "true") then {
		_debug = true;
	}else{
		_debug = false;
	};

	_profileSystem = [nil, "create"] call ALIVE_fnc_profileSystem;
	[_profileSystem, "init"] call ALIVE_fnc_profileSystem;
	[_profileSystem, "debug", _debug] call ALIVE_fnc_profileSystem;
	[_profileSystem, "syncMode", _syncMode] call ALIVE_fnc_profileSystem;
	[_profileSystem, "syncedUnits", _syncedUnits] call ALIVE_fnc_profileSystem;
	[_profileSystem, "spawnRadius", _spawnRadius] call ALIVE_fnc_profileSystem;
	[_profileSystem, "activeLimiter", _activeLimiter] call ALIVE_fnc_profileSystem;
	[_profileSystem, "register"] call ALIVE_fnc_profileSystem;
};

if(hasInterface) then {
    player addEventHandler ["killed", {
        (_this select 0) setVariable ["profileID", nil, true];
        (_this select 0) setVariable ["profileIndex", nil, true];
        
        ["server","PS",[[],{call ALIVE_fnc_createProfilesFromPlayers}]] call ALiVE_fnc_BUS;
    }];
    player addEventHandler ["respawn",
    {
        []spawn {
            // wait for player
            waitUntil {alive player};
            ["server","PS",[[],{call ALIVE_fnc_createProfilesFromPlayers}]] call ALiVE_fnc_BUS;
        };
    }];
};