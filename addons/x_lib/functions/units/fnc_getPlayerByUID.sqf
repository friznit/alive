#include <\x\alive\addons\x_lib\script_component.hpp>
SCRIPT(getPlayerByUID);

/* ----------------------------------------------------------------------------
Function: ALiVE_fnc_getPlayerByUID

Description:
Get a player object by UID

Parameters:
STRING - UID

Returns:
Object - Player object

Examples:
(begin example)
_player = ["234234"] call ALiVE_fnc_getPlayerByUID
(end)

Author:
ARJay
 
Peer reviewed:
nil
---------------------------------------------------------------------------- */

private ["_playerUID","_player","_players"];

_playerUID = _this select 0;

_players = call BIS_fnc_listPlayers;

["PLAYER ID: %1",_playerUID] call ALIVE_fnc_dump;

_player = objNull;
{
    ["TEST UID: %1",getPlayerUID _x] call ALIVE_fnc_dump;
    if (getPlayerUID _x == _playerUID) exitWith {
        _player = _x;
    };
} forEach _players;

_player