#include <\x\alive\addons\main\script_component.hpp>
SCRIPT(setCuratorPosition);

/* ----------------------------------------------------------------------------
Function: ALiVE_fnc_setCuratorPosition

Description:
Called from player over the BUS to set curator camera position

Parameters:
Array - Position

Author:
ARJay

Peer Reviewed:
---------------------------------------------------------------------------- */

private ["_positionX","_positionY","_positionZ","_uid"];
_positionX = _this select 0;
_positionY = _this select 1;
_positionZ = _this select 2;
_uid = _this select 3;

//["POSX: %1 POSY: %2 POSZ: %3 UID: %4",_positionX, _positionY, _positionZ, _uid] call ALIVE_fnc_dump;

if(isNil "ALIVE_curatorPositions") then {
    ALIVE_curatorPositions = [] call ALIVE_fnc_hashCreate;
};

[ALIVE_curatorPositions, _uid, [_positionX, _positionY, _positionZ]] call ALIVE_fnc_hashSet;