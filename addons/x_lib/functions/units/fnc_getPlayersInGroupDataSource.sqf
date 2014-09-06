#include <\x\alive\addons\x_lib\script_component.hpp>
SCRIPT(getPlayersInGroupDataSource);

/* ----------------------------------------------------------------------------
Function: ALiVE_fnc_getPlayersInGroupDataSource

Description:
Get players in the passed players group info formatted for a UI datasource

Parameters:
STRING - player UID


Returns:
Array - Multi dimensional array of values and options

Examples:
(begin example)
_datasource = [_playerUID] call ALiVE_fnc_getPlayersInGroupDataSource
(end)

Author:
ARJay
 
Peer reviewed:
nil
---------------------------------------------------------------------------- */

private ["_data","_options","_values","_players","_group"];

_playerUID = _this select 0;

_data = [];
_options = [];
_values = [];
_players = call BIS_fnc_listPlayers;

scopeName "main";

{
    if(_playerUID == getPlayerUID _x) then {
        _group = group _x;
        breakTo "main";
    };
} foreach _players;

if!(isNil "_group") then {
    {
        if(isPlayer _x) then {
            _options set [count _options,format["%1 - %2",name _x, group _x]];
            _values set [count _values,getPlayerUID _x];
        };
    } foreach (units _group);
};

_data set [0,_options];
_data set [1,_values];

_data
