#include <\x\alive\addons\amb_civ_command\script_component.hpp>
SCRIPT(cc_joinGathering);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_cc_joinGathering

Description:
Start gathering command for civilians

Parameters:
Profile - profile
Args - array

Returns:

Examples:
(begin example)
//
_result = [_agent, []] call ALIVE_fnc_cc_joinGathering;
(end)

See Also:

Author:
ARJay
---------------------------------------------------------------------------- */

private ["_agentData","_commandState","_commandName","_args","_state","_debug","_agentID","_agent","_nextState","_nextStateArgs"];

_agentData = _this select 0;
_commandState = _this select 1;
_commandName = _this select 2;
_args = _this select 3;
_state = _this select 4;
_debug = _this select 5;

_agentID = _agentData select 2 select 3;
_agent = _agentData select 2 select 5;

_nextState = _state;
_nextStateArgs = [];


// DEBUG -------------------------------------------------------------------------------------
if(_debug) then {
	["ALiVE Managed Script Command - [%1] called args: %2",_agentID,_args] call ALIVE_fnc_dump;
};
// DEBUG -------------------------------------------------------------------------------------	

switch (_state) do {
	case "init":{

	    private ["_position","_target"];

		// DEBUG -------------------------------------------------------------------------------------
		if(_debug) then {
			["ALiVE Managed Script Command - [%1] state: %2",_agentID,_state] call ALIVE_fnc_dump;
		};
		// DEBUG -------------------------------------------------------------------------------------

		_agent setVariable ["ALIVE_agentBusy", true, false];

        _target = _agent getVariable "ALIVE_agentGatheringTarget";
        _position = [getPosASL _target, random 5, random 360] call BIS_fnc_relPos;
        [_agent] call ALIVE_fnc_agentSelectSpeedMode;
        _agent doMove _position;

        _nextState = "travel";
        _nextStateArgs = [_target];

        [_commandState, _agentID, [_agentData, [_commandName,"managed",_args,_nextState,_nextStateArgs]]] call ALIVE_fnc_hashSet;
	};
	case "travel":{
        private ["_target"];

        // DEBUG -------------------------------------------------------------------------------------
        if(_debug) then {
            ["ALiVE Managed Script Command - [%1] state: %2",_agentID,_state] call ALIVE_fnc_dump;
        };
        // DEBUG -------------------------------------------------------------------------------------

        _target = _args select 0;

        if(unitReady _agent) then {

            _agent lookAt _target;
            _target lookAt _agent;

            if!(_agent distance _target < 5) then {
                if(random 1 < 0.5) then {
                    [_agent,"acts_PointingLeftUnarmed"] call ALIVE_fnc_switchMove;
                }else{
                    [_agent,"acts_StandingSpeakingUnarmed"] call ALIVE_fnc_switchMove;
                };
            };

            _nextState = "wait";
            _nextStateArgs = _args;

            [_commandState, _agentID, [_agentData, [_commandName,"managed",_args,_nextState,_nextStateArgs]]] call ALIVE_fnc_hashSet;
        };
	};
	case "wait":{

        // DEBUG -------------------------------------------------------------------------------------
        if(_debug) then {
            ["ALiVE Managed Script Command - [%1] state: %2",_agentID,_state] call ALIVE_fnc_dump;
        };
        // DEBUG -------------------------------------------------------------------------------------

        if(_agent getVariable ["ALIVE_agentGatheringComplete",false]) then {
            _agent playMove "";
            _nextState = "done";
            [_commandState, _agentID, [_agentData, [_commandName,"managed",_args,_nextState,_nextStateArgs]]] call ALIVE_fnc_hashSet;
        };
    };
	case "done":{
	
		// DEBUG -------------------------------------------------------------------------------------
		if(_debug) then {
			["ALiVE Managed Script Command - [%1] state: %2",_agentID,_state] call ALIVE_fnc_dump;
		};
		// DEBUG -------------------------------------------------------------------------------------

		_agent setVariable ["ALIVE_agentBusy", false, false];
		
		_nextState = "complete";
		_nextStateArgs = [];
		
		[_commandState, _agentID, [_agentData, [_commandName,"managed",_args,_nextState,_nextStateArgs]]] call ALIVE_fnc_hashSet;
	};
};