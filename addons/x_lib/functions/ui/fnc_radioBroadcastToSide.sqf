#include <\x\alive\addons\x_lib\script_component.hpp>
SCRIPT(radioBroadcastToSide);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_radioBroadcastToSide

Description:
Broadcast radio messages including to all friendly sides, with HQ is desired
Only for use with BIS_fnc_MP

Parameters:
String - side
Array - the message in format for ALIVE_fnc_radioBroadcast

Returns:

Examples:
(begin example)

// send a message to all BLUFOR players from HQ
_radioBroadcast = [player,"Hello World","side",WEST,false,false,false,true,"HQ"];
["WEST",_radioBroadcast] call ALIVE_fnc_radioBroadcastToSide;

(end)

See Also:

Author:
ARJay
---------------------------------------------------------------------------- */
private ["_side","_radioBroadcast","_sideNumber","_players","_playerSide","_playerSideNumber"];

_side = _this select 0;
_radioBroadcast = _this select 1;

_sideNumber = [_side] call ALIVE_fnc_sideTextToNumber;

_players = call BIS_fnc_listPlayers;

{
    _playerSide = side _x;
    _playerSideNumber = [_playerSide] call ALIVE_fnc_sideObjectToNumber;
    if(_sideNumber == _playerSideNumber) then {
        if(isDedicated) then {
            [_radioBroadcast,"ALIVE_fnc_radioBroadcast",_x,false,false] spawn BIS_fnc_MP;
        }else{
            _radioBroadcast call ALIVE_fnc_radioBroadcast;
        };
    };
} foreach _players;
