#include <\x\alive\addons\main\script_component.hpp>
SCRIPT(getRandomPositionLand);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_getRandomPositionLand

Description:
Get a random position on land

Parameters:
Array - position
Scalar - distance

Returns:

Examples:
(begin example)
//
_result = [getPos player, 300] call ALIVE_fnc_getRandomPositionLand;
(end)

See Also:

Author:
ARJay
---------------------------------------------------------------------------- */

private ["_position","_distance","_direction","_bestPositions"];

_position = _this select 0;
_distance = _this select 1;

_direction = random 360;
_position = [_position, _distance, _direction] call BIS_fnc_relPos;

if(surfaceIsWater [_position select 0,_position select 1]) then
{
    // handy! http://forums.bistudio.com/showthread.php?93897-selectBestPlaces-(do-it-yourself-documentation)
    _bestPositions = selectbestplaces [[_position select 0,_position select 1],200,"(1 + houses)",10,1];

    _position = _bestPositions select 0;
    _position = _position select 0;
    _position set [count _position, 0];
};

_position
