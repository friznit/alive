#include <\x\alive\addons\amb_civ_population\script_component.hpp>
SCRIPT(civilianPopulationSystem);

/* ----------------------------------------------------------------------------
Function: MAINCLASS
Description:
Main class for civilian population system initialisation

Parameters:
Nil or Object - If Nil, return a new instance. If Object, reference an existing instance.
String - The selected function
Array - The selected parameters

Returns:
Any - The new instance or the result of the selected function and parameters

Attributes:
Boolean - debug - Debug enable, disable or refresh

Examples:
(begin example)
// create the 
_logic = [nil, "init"] call ALIVE_fnc_civilianPopulationSystem;
(end)

See Also:

Author:
ARJay

Peer reviewed:
nil
---------------------------------------------------------------------------- */

#define SUPERCLASS ALIVE_fnc_baseClassHash
#define MAINCLASS ALIVE_fnc_civilianPopulationSystem

private ["_logic","_operation","_args","_result"];

TRACE_1("civilianPopulationSystem - input",_this);

_logic = [_this, 0, objNull, [objNull,[]]] call BIS_fnc_param;
_operation = [_this, 1, "", [""]] call BIS_fnc_param;
_args = [_this, 2, objNull, [objNull,[],"",0,true,false]] call BIS_fnc_param;
_result = true;

#define MTEMPLATE "ALiVE_CIVILIANPOPULATIONSYSTEM_%1"

switch(_operation) do {
    case "init": {
        if (isServer) then {
                // if server, initialise module game logic
                [_logic,"super",SUPERCLASS] call ALIVE_fnc_hashSet;
                [_logic,"class",MAINCLASS] call ALIVE_fnc_hashSet;
                [_logic,"moduleType","ALIVE_civilianPopulationSystem"] call ALIVE_fnc_hashSet;
                [_logic,"startupComplete",false] call ALIVE_fnc_hashSet;
                //TRACE_1("After module init",_logic);

                [_logic,"debug",false] call ALIVE_fnc_hashSet;
                [_logic,"spawnRadius",1000] call ALIVE_fnc_hashSet;
                [_logic,"spawnTypeJetRadius",1000] call ALIVE_fnc_hashSet;
                [_logic,"spawnTypeHeliRadius",1000] call ALIVE_fnc_hashSet;
                [_logic,"activeLimiter",30] call ALIVE_fnc_hashSet;
                [_logic,"spawnCycleTime",5] call ALIVE_fnc_hashSet;
                [_logic,"despawnCycleTime",1] call ALIVE_fnc_hashSet;
        };
    };
    case "start": {

        private["_debug","_spawnRadius","_spawnTypeJetRadius","_spawnTypeHeliRadius",
        "_activeLimiter","_spawnCycleTime","_despawnCycleTime"];

        if (isServer) then {

            waituntil {!(isnil "ALIVE_sectorGrid")};

            _debug = [_logic,"debug",false] call ALIVE_fnc_hashGet;
            _spawnRadius = [_logic,"spawnRadius"] call ALIVE_fnc_hashGet;
            _spawnTypeJetRadius = [_logic,"spawnTypeJetRadius"] call ALIVE_fnc_hashGet;
            _spawnTypeHeliRadius = [_logic,"spawnTypeHeliRadius"] call ALIVE_fnc_hashGet;
            _activeLimiter = [_logic,"activeLimiter"] call ALIVE_fnc_hashGet;
            _spawnCycleTime = [_logic,"spawnCycleTime"] call ALIVE_fnc_hashGet;
            _despawnCycleTime = [_logic,"despawnCycleTime"] call ALIVE_fnc_hashGet;

            // DEBUG -------------------------------------------------------------------------------------
            if(_debug) then {
                ["----------------------------------------------------------------------------------------"] call ALIVE_fnc_dump;
                ["ALIVE CivilianPopulationSystem - Startup"] call ALIVE_fnc_dump;
            };
            // DEBUG -------------------------------------------------------------------------------------

            // create the cluster handler
            ALIVE_clusterHandler = [nil, "create"] call ALIVE_fnc_clusterHandler;
            [ALIVE_clusterHandler, "init"] call ALIVE_fnc_clusterHandler;
            [ALIVE_clusterHandler, "debug", _debug] call ALIVE_fnc_clusterHandler;

            // create the agent handler
            ALIVE_agentHandler = [nil, "create"] call ALIVE_fnc_agentHandler;
            [ALIVE_agentHandler, "init"] call ALIVE_fnc_agentHandler;

            // create command router
            ALIVE_civCommandRouter = [nil, "create"] call ALIVE_fnc_civCommandRouter;
            [ALIVE_civCommandRouter, "init"] call ALIVE_fnc_civCommandRouter;
            [ALIVE_civCommandRouter, "debug", _debug] call ALIVE_fnc_civCommandRouter;

            // turn on debug again to see the state of the agent handler, and set debug on all a agents
            [ALIVE_agentHandler, "debug", _debug] call ALIVE_fnc_agentHandler;

            // DEBUG -------------------------------------------------------------------------------------
            if(_debug) then {
                ["ALIVE CivilianPopulationSystem - Startup completed"] call ALIVE_fnc_dump;
                ["ALIVE Cluster handler created"] call ALIVE_fnc_dump;
                ["ALIVE Agent handler created"] call ALIVE_fnc_dump;
                ["ALIVE Civ command router created"] call ALIVE_fnc_dump;
                ["ALIVE Active Limit: %1", _activeLimiter] call ALIVE_fnc_dump;
                ["ALIVE Spawn Radius: %1", _spawnRadius] call ALIVE_fnc_dump;
                ["ALIVE Spawn in Jet Radius: %1",_spawnTypeJetRadius] call ALIVE_fnc_dump;
                ["ALIVE Spawn in Heli Radius: %1",_spawnTypeHeliRadius] call ALIVE_fnc_dump;
                ["ALIVE Spawn Cycle Time: %1", _spawnCycleTime] call ALIVE_fnc_dump;
                ["ALIVE Initial civilian hostility settings:"] call ALIVE_fnc_dump;
                ALIVE_civilianHostility call ALIVE_fnc_inspectHash;

                ["----------------------------------------------------------------------------------------"] call ALIVE_fnc_dump;
            };
            // DEBUG -------------------------------------------------------------------------------------

            // set module as started
            [_logic,"startupComplete",true] call ALIVE_fnc_hashSet;

            // start the cluster activator
            _clusterActivatorFSM = [_logic,_spawnRadius,_spawnTypeJetRadius,_spawnTypeHeliRadius,_spawnCycleTime,_activeLimiter] execFSM "\x\alive\addons\amb_civ_population\clusterActivator_v2.fsm";
            [_logic,"activator_FSM",_clusterActivatorFSM] call ALIVE_fnc_hashSet;

        };
    };
    case "destroy": {
        [_logic, "debug", false] call MAINCLASS;
        if (isServer) then {
            [_logic, "destroy"] call SUPERCLASS;

            _profileSimulatorFSM = [_logic, "simulator_FSM"] call ALiVE_fnc_HashGet;
            _profileSimulatorFSM setFSMVariable ["_destroy",true];

            _profileSpawnerFSM = [_logic, "simulator_FSM"] call ALiVE_fnc_HashGet;
            _profileSpawnerFSM setFSMVariable ["_destroy",true];

        };
    };
    case "debug": {
        if(typeName _args != "BOOL") then {
                _args = [_logic,"debug"] call ALIVE_fnc_hashGet;
        } else {
                [_logic,"debug",_args] call ALIVE_fnc_hashSet;
        };
        ASSERT_TRUE(typeName _args == "BOOL",str _args);

        _result = _args;
    };
    case "spawnRadius": {
        if(typeName _args == "SCALAR") then {
                [_logic,"spawnRadius",_args] call ALIVE_fnc_hashSet;
                ALIVE_spawnRadius = _args;
        };
        _result = [_logic,"spawnRadius"] call ALIVE_fnc_hashGet;
    };
    case "spawnTypeJet": {
        if(typeName _args != "BOOL") then {
                _args = [_logic,"spawnTypeJet"] call ALIVE_fnc_hashGet;
        } else {
                [_logic,"spawnTypeJet",_args] call ALIVE_fnc_hashSet;
        };
        ASSERT_TRUE(typeName _args == "BOOL",str _args);

        _result = _args;
    };
    case "spawnTypeJetRadius": {
        if(typeName _args == "SCALAR") then {
                [_logic,"spawnTypeJetRadius",_args] call ALIVE_fnc_hashSet;
                ALIVE_spawnRadius = _args;
        };
        _result = [_logic,"spawnTypeJetRadius"] call ALIVE_fnc_hashGet;
    };
    case "spawnTypeHeli": {
        if(typeName _args != "BOOL") then {
                _args = [_logic,"spawnTypeHeli"] call ALIVE_fnc_hashGet;
        } else {
                [_logic,"spawnTypeHeli",_args] call ALIVE_fnc_hashSet;
        };
        ASSERT_TRUE(typeName _args == "BOOL",str _args);

        _result = _args;
    };
    case "spawnTypeHeliRadius": {
        if(typeName _args == "SCALAR") then {
                [_logic,"spawnTypeHeliRadius",_args] call ALIVE_fnc_hashSet;
                ALIVE_spawnRadius = _args;
        };
        _result = [_logic,"spawnTypeHeliRadius"] call ALIVE_fnc_hashGet;
    };
    case "activeLimiter": {
        if(typeName _args == "SCALAR") then {
                [_logic,"activeLimiter",_args] call ALIVE_fnc_hashSet;
        };
        _result = [_logic,"activeLimiter"] call ALIVE_fnc_hashGet;
    };
    case "state": {
        private["_state"];

        if(typeName _args != "ARRAY") then {

                // Save state

                _state = [] call ALIVE_fnc_hashCreate;

                // BaseClassHash CHANGE
                // loop the class hash and set vars on the state hash
                {
                    if(!(_x == "super") && !(_x == "class")) then {
                        [_state,_x,[_logic,_x] call ALIVE_fnc_hashGet] call ALIVE_fnc_hashSet;
                    };
                } forEach (_logic select 1);

                _result = _state;

        } else {
                ASSERT_TRUE(typeName _args == "ARRAY",str typeName _args);

                // Restore state

                // BaseClassHash CHANGE
                // loop the passed hash and set vars on the class hash
                {
                    [_logic,_x,[_args,_x] call ALIVE_fnc_hashGet] call ALIVE_fnc_hashSet;
                } forEach (_args select 1);
        };
    };
    default {
        _result = [_logic, _operation, _args] call SUPERCLASS;
    };
};
TRACE_1("civilianPopulationSystem - output",_result);
_result;