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

private ["_logic","_debug","_syncMode","_syncedUnits","_spawnRadius","_spawnTypeJetRadius","_spawnTypeHeliRadius","_activeLimiter","_profileSystem"];

PARAMS_1(_logic);

// Confirm init function available
ASSERT_DEFINED("ALIVE_fnc_profileSystem","Main function missing");



if(isServer) then {

    ["PROFILES INIT"] call ALIVE_fnc_dump;
	
	//waituntil {sleep 1; ["PS WAITING"] call ALIVE_fnc_dump; time > 0};
	
	_debug = _logic getVariable ["debug",false];
	_syncMode = _logic getVariable ["syncronised","ADD"];	
	_syncedUnits = synchronizedObjects _logic;
	_spawnRadius = parseNumber (_logic getVariable ["spawnRadius","1500"]);
    _spawnTypeHeliRadius = parseNumber (_logic getVariable ["spawnTypeHeliRadius","1500"]);
	_spawnTypeJetRadius = parseNumber (_logic getVariable ["spawnTypeJetRadius","0"]);
	_activeLimiter = parseNumber (_logic getVariable ["activeLimiter","30"]);

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
	[_profileSystem, "spawnTypeJetRadius", _spawnTypeJetRadius] call ALIVE_fnc_profileSystem;
	[_profileSystem, "spawnTypeHeliRadius", _spawnTypeHeliRadius] call ALIVE_fnc_profileSystem;
	[_profileSystem, "activeLimiter", _activeLimiter] call ALIVE_fnc_profileSystem;

	[_profileSystem,"start"] call ALIVE_fnc_profileSystem;

	["PROFILES INIT COMPLETE"] call ALIVE_fnc_dump;
};

if(hasInterface) then {
    player addEventHandler ["killed", {
        []spawn {
            _uid = getPlayerUID player;

            ["server","PS",[["KILLED",_uid,player],{call ALIVE_fnc_createProfilesFromPlayers}]] call ALiVE_fnc_BUS;
        };
    }];
    player addEventHandler ["respawn",
    {
        []spawn {
            // wait for player
            waitUntil {sleep 0.3; alive player};
            waitUntil {sleep 0.3; (getPlayerUID player) != ""};

            _uid = getPlayerUID player;

            ["server","PS",[["RESPAWN",_uid,player],{call ALIVE_fnc_createProfilesFromPlayers}]] call ALiVE_fnc_BUS;
        };
    }];
};