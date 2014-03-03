#include <\x\alive\addons\amb_civ_command\script_component.hpp>
SCRIPT(selectCivilianCommand);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_selectCivilianCommand

Description:
Select the next civilian command for an agent

Parameters:
Array - agent

Returns:

Examples:
(begin example)
//
_result = [_agent] call ALIVE_fnc_selectCivilianCommand;
(end)

See Also:

Author:
ARJay
---------------------------------------------------------------------------- */

private ["_agentData","_debug","_agent","_dayState","_command","_probability","_timeProbability","_diceRoll","_args"];

_agentData = _this select 0;
_debug = if(count _this > 1) then {_this select 1} else {false};

_agent = _agentData select 2 select 5;

_dayState = ALIVE_currentEnvironment select 0;

if(isNil "ALIVE_civCommands") then {
    ALIVE_civCommands = [] call ALIVE_fnc_hashCreate;

    /*
    [ALIVE_civCommands, "randomMovement", ["ALIVE_fnc_cc_randomMovement", "managed", [0.35,0.01,0.01], [100]]] call ALIVE_fnc_hashSet;
    [ALIVE_civCommands, "idle", ["ALIVE_fnc_cc_idle", "managed", [0.1,0.1,0.1], [10,30]]] call ALIVE_fnc_hashSet;
    [ALIVE_civCommands, "suicide", ["ALIVE_fnc_cc_suicide", "managed", [1,0.15,0.2], [30,90]]] call ALIVE_fnc_hashSet;
    [ALIVE_civCommands, "rogue", ["ALIVE_fnc_cc_rogue", "managed", [1,0.15,0.2], [30,90]]] call ALIVE_fnc_hashSet;
    */

    ///*
    [ALIVE_civCommands, "idle", ["ALIVE_fnc_cc_idle", "managed", [0.1,0.1,0.1], [10,30]]] call ALIVE_fnc_hashSet;
    [ALIVE_civCommands, "randomMovement", ["ALIVE_fnc_cc_randomMovement", "managed", [0.35,0.01,0.01], [100]]] call ALIVE_fnc_hashSet;
    [ALIVE_civCommands, "journey", ["ALIVE_fnc_cc_journey", "managed", [0.2,0.5,0.2], []]] call ALIVE_fnc_hashSet;
    [ALIVE_civCommands, "housework", ["ALIVE_fnc_cc_housework", "managed", [0.25,0.5,0.2], []]] call ALIVE_fnc_hashSet;
    [ALIVE_civCommands, "sleep", ["ALIVE_fnc_cc_sleep", "managed", [0,0.1,0.9], [300,1000]]] call ALIVE_fnc_hashSet;
    [ALIVE_civCommands, "campfire", ["ALIVE_fnc_cc_campfire", "managed", [0,0.25,0.2], [60,300]]] call ALIVE_fnc_hashSet;
    [ALIVE_civCommands, "observe", ["ALIVE_fnc_cc_observe", "managed", [0.2,0.15,0.2], [30,90]]] call ALIVE_fnc_hashSet;
    [ALIVE_civCommands, "suicide", ["ALIVE_fnc_cc_suicide", "managed", [0.1,0.15,0.2], [30,90]]] call ALIVE_fnc_hashSet;
    [ALIVE_civCommands, "rogue", ["ALIVE_fnc_cc_rogue", "managed", [0.1,0.15,0.2], [30,90]]] call ALIVE_fnc_hashSet;
    [ALIVE_civCommands, "startMeeting", ["ALIVE_fnc_cc_startMeeting", "managed", [0.2,0.1,0.01], []]] call ALIVE_fnc_hashSet;
    [ALIVE_civCommands, "startGathering", ["ALIVE_fnc_cc_startGathering", "managed", [0.1,0.01,0], [30,90]]] call ALIVE_fnc_hashSet;
    //*/
};

if(_agent getVariable ["ALIVE_agentMeetingRequested",false]) exitWith {
    [_agentData, "setActiveCommand", ["ALIVE_fnc_cc_joinMeeting", "managed",[30,90]]] call ALIVE_fnc_civilianAgent;
};

if(_agent getVariable ["ALIVE_agentGatheringRequested",false]) exitWith {
    [_agentData, "setActiveCommand", ["ALIVE_fnc_cc_joinGathering", "managed",[]]] call ALIVE_fnc_civilianAgent;
};

if(count (ALIVE_civCommands select 1) > 0) then {
    _command = (ALIVE_civCommands select 2) call BIS_fnc_selectRandom;
    _probability = _command select 2;

    switch(_dayState) do {
        case "DAY": {
            _timeProbability = _probability select 0;
        };
        case "EVENING": {
            _timeProbability = _probability select 1;
        };
        case "NIGHT": {
            _timeProbability = _probability select 2;
        };
    };

    _diceRoll = random 1;

    // DEBUG -------------------------------------------------------------------------------------
    if(_debug) then {
        _agentID = _agentData select 2 select 3;
        ["----------------------------------------------------------------------------------------"] call ALIVE_fnc_dump;
        ["ALIVE Select Civilian Command [%1]", _agentID] call ALIVE_fnc_dump;
        ["ALIVE Select Civilian Command - Time of day: %1", _dayState] call ALIVE_fnc_dump;
        ["ALIVE Select Civilian Command - Dice roll: %1 Current Probability: %2 Command: %3", _diceRoll, _timeProbability, _command select 0] call ALIVE_fnc_dump;
    };
    // DEBUG -------------------------------------------------------------------------------------

    if(_diceRoll < _timeProbability) then {
        _args = + _command select 3;
        [_agentData, "setActiveCommand", [_command select 0, _command select 1,_args]] call ALIVE_fnc_civilianAgent;
    }else{
        if(random 1 > 0.6) then {
            switch(_dayState) do {
                case "DAY": {
                    _command = [ALIVE_civCommands, "randomMovement"] call ALIVE_fnc_hashGet;
                };
                case "EVENING": {
                    _command = [ALIVE_civCommands, "housework"] call ALIVE_fnc_hashGet;
                };
                case "NIGHT": {
                    _command = [ALIVE_civCommands, "sleep"] call ALIVE_fnc_hashGet;
                };
            };
            _args = + _command select 3;
            [_agentData, "setActiveCommand", [_command select 0, _command select 1,_args]] call ALIVE_fnc_civilianAgent;
        }else{
            _command = [ALIVE_civCommands, "idle"] call ALIVE_fnc_hashGet;
            _args = + _command select 3;
            [_agentData, "setActiveCommand", [_command select 0, _command select 1,_args]] call ALIVE_fnc_civilianAgent;
        };
    }
};