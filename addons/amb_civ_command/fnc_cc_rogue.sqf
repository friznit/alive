#include <\x\alive\addons\amb_civ_command\script_component.hpp>
SCRIPT(cc_rogue);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_cc_suicide

Description:
Rogue agent command for civilians

Parameters:
Profile - profile
Args - array

Returns:

Examples:
(begin example)
//
_result = [_agent, []] call ALIVE_fnc_cc_rogue;
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

        private ["_homePosition","_positions","_position"];

        // DEBUG -------------------------------------------------------------------------------------
        if(_debug) then {
            ["ALiVE Managed Script Command - [%1] state: %2",_agentID,_state] call ALIVE_fnc_dump;
        };
        // DEBUG -------------------------------------------------------------------------------------

        _agent setVariable ["ALIVE_agentBusy", true, false];

        _homePosition = _agentData select 2 select 10;

        _positions = [_homePosition,5] call ALIVE_fnc_findIndoorHousePositions;

        if(count _positions > 0) then {
            _position = _positions call BIS_fnc_arrayPop;
            [_agent] call ALIVE_fnc_agentSelectSpeedMode;
            _agent doMove _position;

            _nextState = "travel";
            [_commandState, _agentID, [_agentData, [_commandName,"managed",_args,_nextState,_nextStateArgs]]] call ALIVE_fnc_hashSet;
        }else{
            _nextState = "done";
            [_commandState, _agentID, [_agentData, [_commandName,"managed",_args,_nextState,_nextStateArgs]]] call ALIVE_fnc_hashSet;
        };
    };
    case "travel":{

        private ["_faction","_weapons","_weaponGroup","_weapon","_ammo"];

        // DEBUG -------------------------------------------------------------------------------------
        if(_debug) then {
            ["ALiVE Managed Script Command - [%1] state: %2",_agentID,_state] call ALIVE_fnc_dump;
        };
        // DEBUG -------------------------------------------------------------------------------------

        if(unitReady _agent) then {

            //arm
            _faction = _agentData select 2 select 7;
            _weapons = [ALIVE_civilianWeapons, _faction] call ALIVE_fnc_hashGet;

            if(count _weapons == 0) then {
                _weapons = [ALIVE_civilianWeapons, "CIV"] call ALIVE_fnc_hashGet;
            };

            if(count _weapons > 0) then {
                _weaponGroup = _weapons call BIS_fnc_selectRandom;
                _weapon = _weaponGroup select 0;
                _ammo = _weaponGroup select 1;

                _agent addWeapon _weapon;
                _agent addMagazine _ammo;
                _agent addMagazine _ammo;

                _nextState = "target";
                [_commandState, _agentID, [_agentData, [_commandName,"managed",_args,_nextState,_nextStateArgs]]] call ALIVE_fnc_hashSet;
            }else{

                _nextState = "done";
                [_commandState, _agentID, [_agentData, [_commandName,"managed",_args,_nextState,_nextStateArgs]]] call ALIVE_fnc_hashSet;
            };
        };
    };
	case "target":{

	    private ["_minTimeout","_maxTimeout","_target","_timeout","_timer"];

		// DEBUG -------------------------------------------------------------------------------------
		if(_debug) then {
			["ALiVE Managed Script Command - [%1] state: %2",_agentID,_state] call ALIVE_fnc_dump;
		};
		// DEBUG -------------------------------------------------------------------------------------

		_agent setVariable ["ALIVE_agentBusy", true, false];

        _target = [getPosASL _agent, 50] call ALIVE_fnc_getAgentEnemyNear;

        /*
        if(count _target == 0) then {
            _target = [getPosASL _agent, 300] call ALIVE_fnc_getRandomPlayerNear;
        };
        */

        if(count _target > 0) then {

            _agent setSkill 0.3 + random 0.5;

            _target = _target select 0;
            [_agent] call ALIVE_fnc_agentSelectSpeedMode;
            _agent doMove getPosASL _target;

            [_agent, _target] call ALIVE_fnc_addToEnemyGroup;

            _agent setCombatMode "RED";
            _agent setBehaviour "AWARE";

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

            if((isNull _target) || !(alive _target)) then {
                _nextState = "done";
                [_commandState, _agentID, [_agentData, [_commandName,"managed",_args,_nextState,_nextStateArgs]]] call ALIVE_fnc_hashSet;
            };

            if(_agent distance _target > 20) then {
                _agent addRating -10000;
                [_agent] call ALIVE_fnc_agentSelectSpeedMode;
                _agent doMove getPosASL _target;
            }else{

                _agent doTarget _target;

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