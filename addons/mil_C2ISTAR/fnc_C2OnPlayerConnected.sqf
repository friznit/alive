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

if (isServer) then {

    private ["_id","_name","_uid"];

    _id = _this select 0;
    _name = _this select 1;
    _uid = _this select 2;

    if (_name == "__SERVER__" || _uid == "") exitWith {

        // MOVED TO MODULE INIT

    };

    ["C2 ON PLAYER CONNECTED: %1 %2 %3",_id,_name,_uid] call ALIVE_fnc_dump;

    [_uid] spawn {

        private ["_uid","_unit"];

        _uid = _this select 0;

        _unit = objNull;

        waitUntil {
            sleep 0.3;

            private ["_players","_found","_player","_playerGUID"];

            _players = call BIS_fnc_listPlayers;
            _found = false;

            {
                _player = _x;
                _playerGUID = getPlayerUID _player;

                if (_playerGUID == _uid) exitwith {
                    _unit = _player;
                    _found = true;
                    ["C2 UNIT FOUND IN PLAYABLE UNITS: %1 - %2",_uid,_unit] call ALIVE_fnc_dump;
                };
            } foreach _players;

            ["C2 UNIT FOUND IN PLAYABLE UNITS: %1",_found] call ALIVE_fnc_dump;

            _found

        };

        if !(isNull _unit) then {

            private ["_groupID","_playerID","_event"];

            ["C2 UNIT NOT NULL: %1",_unit] call ALIVE_fnc_dump;

            _groupID = str (group _unit);
            _playerID = getPlayerUID _unit;

            ["C2 ATTEMPTING TO DO TASK SYNC FOR: %1 %2",_groupID,_playerID] call ALIVE_fnc_dump;

            _event = ['TASKS_SYNC', [_playerID,_groupID], "PLAYER"] call ALIVE_fnc_event;

            [ALIVE_eventLog, "addEvent",_event] call ALIVE_fnc_eventLog;

            //[[_event],"ALIVE_fnc_addEventToServer",false,false] spawn BIS_fnc_MP;
            //["server","ALIVE_ADD_EVENT",[[_event],"ALIVE_fnc_addEventToServer"]] call ALiVE_fnc_BUS;
        }else{

            ["C2 UNIT IS NULL??????"] call ALIVE_fnc_dump;

        };
    };
};