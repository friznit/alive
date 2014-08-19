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

["KNOCK KNOCK?"] call ALIVE_fnc_dump;

if(isServer) then {

    ["HELLLO?"] call ALIVE_fnc_dump;

    [_uid] spawn {

        private ["_uid","_unit","_player","_playerGUID","_group"];

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

            _group = group _unit;

            ["PLAYER CONNECTED!!! UNIT: %1 GROUP: %2",_unit,_group] call ALIVE_fnc_dump;
        };
    };
};