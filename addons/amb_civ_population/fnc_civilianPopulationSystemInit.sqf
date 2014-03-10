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

private ["_logic","_debug","_spawnRadius","_spawnTypeJetRadius","_spawnTypeHeliRadius","_activeLimiter","_hostilityWest","_hostilityEast","_hostilityIndep"];

PARAMS_1(_logic);

// Confirm init function available
ASSERT_DEFINED("ALIVE_fnc_civilianPopulationSystem","Main function missing");

["ALiVE [%1] %2 INIT",(getNumber(configfile >> "CfgVehicles" >>  typeOf _logic >> "functionPriority")),typeof _logic] call ALIVE_fnc_dump;

if(isServer) then {
	
	//waituntil {sleep 1; ["PS WAITING"] call ALIVE_fnc_dump; time > 0};
	
	_debug = _logic getVariable ["debug",false];
	_spawnRadius = parseNumber (_logic getVariable ["spawnRadius","1500"]);
    _spawnTypeHeliRadius = parseNumber (_logic getVariable ["spawnTypeHeliRadius","1500"]);
	_spawnTypeJetRadius = parseNumber (_logic getVariable ["spawnTypeJetRadius","0"]);
	_activeLimiter = parseNumber (_logic getVariable ["activeLimiter","30"]);
	_hostilityWest = parseNumber (_logic getVariable ["hostilityWest","0"]);
	_hostilityEast = parseNumber (_logic getVariable ["hostilityEast","0"]);
	_hostilityIndep = parseNumber (_logic getVariable ["hostilityIndep","0"]);
	ALIVE_civilianHostility = [] call ALIVE_fnc_hashCreate;
	[ALIVE_civilianHostility, "WEST", _hostilityWest] call ALIVE_fnc_hashSet;
	[ALIVE_civilianHostility, "EAST", _hostilityEast] call ALIVE_fnc_hashSet;
	[ALIVE_civilianHostility, "INDEP", _hostilityIndep] call ALIVE_fnc_hashSet;

    if(_debug == "true") then {
        _debug = true;
    }else{
        _debug = false;
    };

	ALIVE_civilianPopulationSystem = [nil, "create"] call ALIVE_fnc_civilianPopulationSystem;
	[ALIVE_civilianPopulationSystem, "init"] call ALIVE_fnc_civilianPopulationSystem;
	[ALIVE_civilianPopulationSystem, "debug", _debug] call ALIVE_fnc_civilianPopulationSystem;
	[ALIVE_civilianPopulationSystem, "spawnRadius", _spawnRadius] call ALIVE_fnc_civilianPopulationSystem;
	[ALIVE_civilianPopulationSystem, "spawnTypeJetRadius", _spawnTypeJetRadius] call ALIVE_fnc_civilianPopulationSystem;
	[ALIVE_civilianPopulationSystem, "spawnTypeHeliRadius", _spawnTypeHeliRadius] call ALIVE_fnc_civilianPopulationSystem;
	[ALIVE_civilianPopulationSystem, "activeLimiter", _activeLimiter] call ALIVE_fnc_civilianPopulationSystem;

	[ALIVE_civilianPopulationSystem,"start"] call ALIVE_fnc_civilianPopulationSystem;
};

["ALiVE [%1] %2 INIT COMPLETE",(getNumber(configfile >> "CfgVehicles" >>  typeOf _logic >> "functionPriority")),typeof _logic] call ALIVE_fnc_dump;