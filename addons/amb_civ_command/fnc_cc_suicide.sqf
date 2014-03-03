#include <\x\alive\addons\amb_civ_command\script_component.hpp>
SCRIPT(cc_suicide);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_cc_suicide

Description:
Suicide Bomber command for civilians

Parameters:
Profile - profile
Args - array

Returns:

Examples:
(begin example)
//
_result = [_agent, []] call ALIVE_fnc_cc_suicide;
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

	    private ["_target"];

		// DEBUG -------------------------------------------------------------------------------------
		if(_debug) then {
			["ALiVE Managed Script Command - [%1] state: %2",_agentID,_state] call ALIVE_fnc_dump;
		};
		// DEBUG -------------------------------------------------------------------------------------

		_agent setVariable ["ALIVE_agentBusy", true, false];

		_target = [_agentData, getPosASL _agent, 300] call ALIVE_fnc_getAgentEnemyNear;

		if(count _target == 0) then {
		    _target = [getPosASL _agent, 300] call ALIVE_fnc_getRandomPlayerNear;
		};

        if(count _target > 0) then {
            _target = _target select 0;
            [_agent] call ALIVE_fnc_agentSelectSpeedMode;
            _agent doMove getPosASL _target;

            _nextState = "travel";
            _nextStateArgs = [_target];

            [_commandState, _agentID, [_agentData, [_commandName,"managed",_args,_nextState,_nextStateArgs]]] call ALIVE_fnc_hashSet;
        }else{
            _nextState = "done";
            [_commandState, _agentID, [_agentData, [_commandName,"managed",_args,_nextState,_nextStateArgs]]] call ALIVE_fnc_hashSet;
        };
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

            if(_agent distance _target > 5) then {
                [_agent] call ALIVE_fnc_agentSelectSpeedMode;
                _agent doMove getPosASL _target;
            }else{

                _object = "GrenadeHand" createVehicle (getPos _agent);
                _object attachTo [_agent,[-0.02,-0.07,0.042],"rightHand"];

                _nextState = "done";
                [_commandState, _agentID, [_agentData, [_commandName,"managed",_args,_nextState,_nextStateArgs]]] call ALIVE_fnc_hashSet;
            };
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