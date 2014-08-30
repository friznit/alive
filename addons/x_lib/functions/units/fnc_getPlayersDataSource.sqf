#include <\x\alive\addons\x_lib\script_component.hpp>
SCRIPT(getPlayersDataSource);

/* ----------------------------------------------------------------------------
Function: ALiVE_fnc_getPlayersDataSource

Description:
Get current players info formatted for a UI datasource

Parameters:


Returns:
Array - Multi dimensional array of values and options

Examples:
(begin example)
_datasource = call ALiVE_fnc_getPlayersDataSource
(end)

Author:
ARJay
 
Peer reviewed:
nil
---------------------------------------------------------------------------- */

private ["_side","_data","_options","_values","_players"];

_side = _this select 0;

_sideNumber = [_side] call ALIVE_fnc_sideTextToNumber;
_data = [];
_options = [];
_values = [];
_players = call BIS_fnc_listPlayers;

{
    _playerSide = side _x;
    _playerSideNumber = [_playerSide] call ALIVE_fnc_sideObjectToNumber;
    if(_sideNumber == _playerSideNumber) then {
        _options set [count _options,format["%1 - %2",name _x, group _x]];
        _values set [count _values,getPlayerUID _x];
    };
} foreach _players;

_data set [0,_options];
_data set [1,_values];

_data
