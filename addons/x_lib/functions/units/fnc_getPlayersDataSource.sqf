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

private ["_data","_options","_values","_players"];

_data = [];
_options = [];
_values = [];
_players = call BIS_fnc_listPlayers;

{
    _options set [count _options,name _x];
    _values set [count _values,getPlayerUID _x];
} foreach _players;

_data set [0,_options];
_data set [1,_values];

_data
