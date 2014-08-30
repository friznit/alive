#include <\x\alive\addons\mil_C2ISTAR\script_component.hpp>
SCRIPT(C2OnPlayerConnected);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_C2OnPlayerConnected
Description:

On connection of player

Parameters:

Returns:

See Also:

Author:
ARJay

Peer Reviewed:
nil
---------------------------------------------------------------------------- */
private ["_id","_name","_uid"];

_id = _this select 0;
_name = _this select 1;
_uid = _this select 2;

["ON PLAYER CONNECTED: %1 %2 %3",_id,_name,_uid] call ALIVE_fnc_dump;

[_uid] spawn {

    private ["_uid","_unit","_player","_playerGUID","_groupID","_playerID"];

    _uid = _this select 0;

    _unit = objNull;

    _players = call BIS_fnc_listPlayers;

    {
        _player = _x;
        _playerGUID = getPlayerUID _player;

        ["PLAYABLE UNIT UID: %1 - %2",_player,_playerGUID] call ALIVE_fnc_dump;

        waitUntil {
            sleep 0.3;
            _playerGUID = getPlayerUID _player;
            ["WAITING FOR PLAYER UID... %1",_playerGUID] call ALIVE_fnc_dump;
            _playerGUID != ""
        };
        sleep 0.2;

        ["CHECKING UID AGAINST PLAYABLE UNITS: %1 - %2",_playerGUID,_uid] call ALIVE_fnc_dump;

        if (_playerGUID == _uid ) exitwith {
            _unit = _player;
            ["UNIT FOUND IN PLAYABLE UNITS: %1 - %2 : %3",_playerGUID,_uid,_unit] call ALIVE_fnc_dump;
        };
    } foreach _players;

    if !(isNull _unit) then {

        ["UNIT NOT NULL: %1",_unit] call ALIVE_fnc_dump;

        _groupID = str (group _unit);
        _playerID = getPlayerUID _unit;

        ["ATTEMPTING TO DO TASK SYNC FOR: %1 %2",_groupID,_playerID] call ALIVE_fnc_dump;

        _event = ['TASKS_SYNC', [_playerID,_groupID], "PLAYER"] call ALIVE_fnc_event;

        [[_event],"ALIVE_fnc_addEventToServer",false,false] spawn BIS_fnc_MP;
        //["server","ALIVE_ADD_EVENT",[[_event],"ALIVE_fnc_addEventToServer"]] call ALiVE_fnc_BUS;
    };
};