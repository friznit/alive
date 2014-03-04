#include <\x\alive\addons\amb_civ_population\script_component.hpp>
SCRIPT(agentSelectSpeedMode);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_agentSelectSpeedMode

Description:
Set a randomish speed mode on an agent

Parameters:

Object - agent to adjust speed mode of

Returns:

Examples:
(begin example)
_light = [_agent] call ALIVE_fnc_agentSelectSpeedMode
(end)

See Also:

Author:
ARJay
---------------------------------------------------------------------------- */
private ["_agent","_probability","_colour","_brightness","_light"];

_agent = _this select 0;

_probabilityNormal = 0.1;
_probabilityFull = 0.05;

switch(ALIVE_civilianGlobalPosture) do {
    case "ENRAGED": {
        _probabilityNormal = 0.4;
        _probabilityFull = 0.2;
    };
    case "ANGRY": {
        _probabilityNormal = 0.3;
        _probabilityFull = 0.1;
    };
    case "DISCONTENTED": {
        _probabilityNormal = 0.2;
        _probabilityFull = 0.1;
    };
    case "PEACEFUL": {
        _probabilityNormal = 0.1;
        _probabilityFull = 0.05;
    };
};

_diceRoll = random 1;

_agent setSpeedMode "LIMITED";

if(_diceRoll < _probabilityNormal) then {
    _agent setSpeedMode "NORMAL";
};

if(_diceRoll < _probabilityFull) then {
    _agent setSpeedMode "FULL";
};

