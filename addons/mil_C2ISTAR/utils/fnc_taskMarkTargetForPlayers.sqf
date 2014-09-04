#include <\x\alive\addons\mil_C2ISTAR\script_component.hpp>
SCRIPT(taskMarkTargetForPlayers);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_taskMarkTargetForPlayers

Description:
Mark a target units position for players

Parameters:

Returns:

Examples:
(begin example)
(end)

See Also:

Author:
ARJay
---------------------------------------------------------------------------- */

private ["_taskID","_target","_taskPlayers","_targetPosition","_targetSide","_colour","_player"];

_taskID = _this select 0;
_target = _this select 1;
_taskPlayers = _this select 2;

_targetPosition = position _target;
_targetSide = side _target;

switch(_targetSide) do {
    case EAST:{
        _colour = "ColorRed";
    };
    case WEST:{
        _colour = "ColorBlue";
    };
    case CIVILIAN:{
        _colour = "ColorYellow";
    };
    case RESISTANCE:{
        _colour = "ColorGreen";
    };
};

{
    _player = [_x] call ALIVE_fnc_getPlayerByUID;

    if !(isNull _player) then {
        if(isDedicated) then {
            [[_targetPosition,_taskID,_colour],"ALIVE_fnc_taskCreateMarker",_player,false,false] spawn BIS_fnc_MP;
        }else{
            [_targetPosition,_taskID,_colour] call ALIVE_fnc_taskCreateMarker;
        };
    };

} forEach _taskPlayers;