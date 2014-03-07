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

        private ["_target","_homePosition","_positions","_position"];

        // DEBUG -------------------------------------------------------------------------------------
        if(_debug) then {
            ["ALiVE Managed Script Command - [%1] state: %2",_agentID,_state] call ALIVE_fnc_dump;
        };
        // DEBUG -------------------------------------------------------------------------------------

        _agent setVariable ["ALIVE_agentBusy", true, false];

        _target = [getPosASL _agent, 50] call ALIVE_fnc_getAgentEnemyNear;

        if(count _target > 0) then {

            _target = _target select 0;

            _homePosition = _agentData select 2 select 10;
            _positions = [_homePosition,5] call ALIVE_fnc_findIndoorHousePositions;

            if(count _positions > 0) then {
                _position = _positions call BIS_fnc_arrayPop;
                [_agent] call ALIVE_fnc_agentSelectSpeedMode;
                _agent doMove _position;

                _nextStateArgs = [_target];

                _nextState = "arm";
                [_commandState, _agentID, [_agentData, [_commandName,"managed",_args,_nextState,_nextStateArgs]]] call ALIVE_fnc_hashSet;
            }else{
                _nextState = "done";
                [_commandState, _agentID, [_agentData, [_commandName,"managed",_args,_nextState,_nextStateArgs]]] call ALIVE_fnc_hashSet;
            };
        }else{
            _nextState = "done";
            [_commandState, _agentID, [_agentData, [_commandName,"managed",_args,_nextState,_nextStateArgs]]] call ALIVE_fnc_hashSet;
        };
    };
    case "arm":{

        private ["_bomb1","_bomb2","_bomb3"];

        // DEBUG -------------------------------------------------------------------------------------
        if(_debug) then {
            ["ALiVE Managed Script Command - [%1] state: %2",_agentID,_state] call ALIVE_fnc_dump;
        };
        // DEBUG -------------------------------------------------------------------------------------

        if(unitReady _agent) then {

            _bomb1 = "DemoCharge_Remote_Ammo" createVehicle [0,0,0];
            _bomb2 = "DemoCharge_Remote_Ammo" createVehicle  [0,0,0];
            _bomb3 = "DemoCharge_Remote_Ammo" createVehicle  [0,0,0];

            sleep 0.01;

            _bomb1 attachTo [_agent, [-0.1,0.1,0.15],"Pelvis"];
            _bomb1 setVectorDirAndUp [[0.5,0.5,0],[-0.5,0.5,0]];
            _bomb1 setPosATL (getPosATL _bomb1);

            _bomb2 attachTo [_agent, [0,0.15,0.15],"Pelvis"];
            _bomb2 setVectorDirAndUp [[1,0,0],[0,1,0]];
            _bomb2 setPosATL (getPosATL _bomb2);

            _bomb3 attachTo [_agent, [0.1,0.1,0.15],"Pelvis"];
            _bomb3 setVectorDirAndUp [[0.5,-0.5,0],[0.5,0.5,0]];
            _bomb3 setPosATL (getPosATL _bomb3);

            _agent setVariable ["ALIVE_agentSuicide", true, false];

            _nextStateArgs = _args + [_bomb1, _bomb2, _bomb3];

            _nextState = "target";
            [_commandState, _agentID, [_agentData, [_commandName,"managed",_args,_nextState,_nextStateArgs]]] call ALIVE_fnc_hashSet;
        };
    };
	case "target":{

	    private ["_target","_bomb1","_bomb2","_bomb3"];

		// DEBUG -------------------------------------------------------------------------------------
		if(_debug) then {
			["ALiVE Managed Script Command - [%1] state: %2",_agentID,_state] call ALIVE_fnc_dump;
		};
		// DEBUG -------------------------------------------------------------------------------------

		_target = _args select 0;
		_bomb1 = _args select 1;
        _bomb2 = _args select 2;
        _bomb3 = _args select 3;

        if!(isNull _target) then {

            _agent setSpeedMode "FULL";

            _handle = [_agent, _target, _bomb1, _bomb2, _bomb3] spawn {

                private ["_agent","_target","_bomb1","_bomb2","_bomb3","_diceRoll"];

                _agent = _this select 0;
                _target = _this select 1;
                _bomb1 = _this select 2;
                _bomb2 = _this select 3;
                _bomb3 = _this select 4;

                waituntil {sleep 0.5; _agent doMove getPosASL _target; (_agent distance _target < 8) || !(alive _agent)};

                deleteVehicle _bomb1;
                deleteVehicle _bomb2;
                deleteVehicle _bomb3;

                _diceRoll = random 1;

                if(_diceRoll > 0.7) then {
                    _object = "HelicopterExploSmall" createVehicle (getPos _agent);
                    _object attachTo [_agent,[-0.02,-0.07,0.042],"rightHand"];
                };
            };

            [_agent, _target] call ALIVE_fnc_addToEnemyGroup;

            _agent setCombatMode "RED";
            _agent setBehaviour "AWARE";

            _nextStateArgs = _args + [_handle];

            _nextState = "travel";
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
        _handle = _args select 4;

        _nextStateArgs = _args;

        if(!(alive _target) || !(alive _target)) then {
            terminate _handle;
            _nextState = "done";
            [_commandState, _agentID, [_agentData, [_commandName,"managed",_args,_nextState,_nextStateArgs]]] call ALIVE_fnc_hashSet;
        };

        if(scriptDone _handle) then {
            _nextState = "done";
            [_commandState, _agentID, [_agentData, [_commandName,"managed",_args,_nextState,_nextStateArgs]]] call ALIVE_fnc_hashSet;
        };
	};
	case "done":{

	     private ["_bomb1","_bomb2","_bomb3"];

		// DEBUG -------------------------------------------------------------------------------------
		if(_debug) then {
			["ALiVE Managed Script Command - [%1] state: %2",_agentID,_state] call ALIVE_fnc_dump;
		};
		// DEBUG -------------------------------------------------------------------------------------

        if(count _args > 1) then {
            _bomb1 = _args select 1;
            _bomb2 = _args select 2;
            _bomb3 = _args select 3;

            if!(isNull _bomb1) then { deleteVehicle _bomb1 };
            if!(isNull _bomb2) then { deleteVehicle _bomb2 };
            if!(isNull _bomb3) then { deleteVehicle _bomb3 };
        };

		_agent setVariable ["ALIVE_agentBusy", false, false];

        if(alive _agent) then {
            _agent setCombatMode "WHITE";
            _agent setBehaviour "SAFE";
            _agent setSkill 0.1;
        };

		_nextState = "complete";
		_nextStateArgs = [];

		[_commandState, _agentID, [_agentData, [_commandName,"managed",_args,_nextState,_nextStateArgs]]] call ALIVE_fnc_hashSet;
	};
};