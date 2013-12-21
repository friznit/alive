#include <\x\alive\addons\sys_profile\script_component.hpp>
SCRIPT(profile_onPlayerConnected);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_profile_onPlayerConnected

Description:
Profile system on player connected event handler

Parameters:

Returns:

Examples:
(begin example)
// on player connected event handler
[] call ALIVE_fnc_profile_onPlayerConnected;
(end)

See Also:

Author:
ARJay
---------------------------------------------------------------------------- */

private ["_id","_name","_uid"];

_id = _this select 0;
_name = _this select 1;
_uid = _this select 2;

if(isServer) then {

    [_uid] spawn {

        private ["_uid","_unit","_player","_playerGUID"];

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
            ["ALIVE CONNECT: uid:%1",_uid] call ALIVE_fnc_dump;
            ["CONNECT",_uid,_unit] call ALIVE_fnc_createProfilesFromPlayers;
        };
    };
};