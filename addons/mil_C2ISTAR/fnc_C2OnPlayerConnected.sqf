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


[_uid] spawn {

    private ["_uid","_unit","_player","_playerGUID","_groupID","_playerID"];

    _uid = _this select 0;

    _unit = objNull;

    {
        _player = _x;
        _playerGUID = getPlayerUID _player;
        waitUntil {sleep 0.3; _playerGUID = getPlayerUID _player; _playerGUID != ""};
        sleep 0.2;

        if (_playerGUID == _uid ) exitwith {
            _unit = _player;
        };
    } foreach playableUnits;

    if !(isNull _unit) then {

        _groupID = str (group _unit);
        _playerID = getPlayerUID _unit;

        _event = ['TASKS_SYNC', [_playerID,_groupID], "PLAYER"] call ALIVE_fnc_event;

        [[_event],"ALIVE_fnc_addEventToServer",false,false] spawn BIS_fnc_MP;
        //["server","ALIVE_ADD_EVENT",[[_event],"ALIVE_fnc_addEventToServer"]] call ALiVE_fnc_BUS;
    };
};