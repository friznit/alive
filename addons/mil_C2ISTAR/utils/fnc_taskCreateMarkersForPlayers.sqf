#include <\x\alive\addons\mil_C2ISTAR\script_component.hpp>
SCRIPT(taskCreateMarkersForPlayers);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_taskCreateMarkersForPlayers

Description:
Mark a position for players

Parameters:

Returns:

Examples:
(begin example)
(end)

See Also:

Author:
ARJay
---------------------------------------------------------------------------- */

private ["_taskPosition","_taskSide","_taskID","_taskPlayers","_taskType","_colour","_markerDefinition","_player"];

_taskPosition = _this select 0;
_taskSide = _this select 1;
_taskPlayers = _this select 2;
_taskID = _this select 3;
_taskType = _this select 4;

switch(_taskSide) do {
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

_markerDefinition = [];

switch(_taskType) do {
    case "HVT":{
        _markerDefinition = [_taskPosition,_taskID,_colour,"HVT","mil_objective",[1,1],1,"ICON"];
    };
};

{
    _player = [_x] call ALIVE_fnc_getPlayerByUID;

    if !(isNull _player) then {
        if(isDedicated) then {
            [_markerDefinition,"ALIVE_fnc_taskCreateMarker",_player,false,false] spawn BIS_fnc_MP;
        }else{
            _markerDefinition call ALIVE_fnc_taskCreateMarker;
        };
    };

} forEach _taskPlayers;