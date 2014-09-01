#include <\x\alive\addons\x_lib\script_component.hpp>
SCRIPT(getPlayerByUIDOnConnect);

/* ----------------------------------------------------------------------------
Function: ALiVE_fnc_getPlayerByUIDOnConnect

Description:
Get a player object by UID, specifically for on player connect

Parameters:
STRING - UID

Returns:
Object - Player object

Examples:
(begin example)
_player = ["234234"] call ALiVE_fnc_getPlayerByUIDOnConnect
(end)

Author:
ARJay
 
Peer reviewed:
nil
---------------------------------------------------------------------------- */

private ["_playerUID","_player","_players"];

_playerUID = _this select 0;

_unit = objNull;

waitUntil {
    sleep 0.3;

    private ["_players","_found","_player","_playerGUID"];

    _players = call BIS_fnc_listPlayers;
    _found = false;

    {
        _player = _x;
        _currentUID = getPlayerUID _player;

        if (_currentUID == _playerUID) exitwith {
            _unit = _player;
            _found = true;
        };
    } foreach _players;

    _found

};

_unit