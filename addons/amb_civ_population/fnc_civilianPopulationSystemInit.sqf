#include <\x\alive\addons\amb_civ_population\script_component.hpp>
SCRIPT(civilianPopulationSystemInit);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_civilianPopulationSystemInit
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

private ["_logic","_debug","_syncMode","_syncedUnits","_spawnRadius","_spawnTypeJetRadius","_spawnTypeHeliRadius","_activeLimiter","_persistent","_profileSystem"];

PARAMS_1(_logic);

// Confirm init function available
ASSERT_DEFINED("ALIVE_fnc_civilianPopulationSystem","Main function missing");



if(isServer) then {

    ["AMB_CIV_POPULATION INIT"] call ALIVE_fnc_dump;
	
	//waituntil {sleep 1; ["PS WAITING"] call ALIVE_fnc_dump; time > 0};
	
	_debug = _logic getVariable ["debug",false];
	_spawnRadius = parseNumber (_logic getVariable ["spawnRadius","1500"]);
    _spawnTypeHeliRadius = parseNumber (_logic getVariable ["spawnTypeHeliRadius","1500"]);
	_spawnTypeJetRadius = parseNumber (_logic getVariable ["spawnTypeJetRadius","0"]);
	_activeLimiter = parseNumber (_logic getVariable ["activeLimiter","30"]);

    if(_debug == "true") then {
        _debug = true;
    }else{
        _debug = false;
    };

	_civilianPopulationSystem = [nil, "create"] call ALIVE_fnc_civilianPopulationSystem;
	[_civilianPopulationSystem, "init"] call ALIVE_fnc_civilianPopulationSystem;
	[_civilianPopulationSystem, "debug", _debug] call ALIVE_fnc_civilianPopulationSystem;
	[_civilianPopulationSystem, "spawnRadius", _spawnRadius] call ALIVE_fnc_civilianPopulationSystem;
	[_civilianPopulationSystem, "spawnTypeJetRadius", _spawnTypeJetRadius] call ALIVE_fnc_civilianPopulationSystem;
	[_civilianPopulationSystem, "spawnTypeHeliRadius", _spawnTypeHeliRadius] call ALIVE_fnc_civilianPopulationSystem;
	[_civilianPopulationSystem, "activeLimiter", _activeLimiter] call ALIVE_fnc_civilianPopulationSystem;

	[_civilianPopulationSystem,"start"] call ALIVE_fnc_civilianPopulationSystem;

	["AMB_CIV_POPULATION INIT COMPLETE"] call ALIVE_fnc_dump;
};