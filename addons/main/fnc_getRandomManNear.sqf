#include <\x\alive\addons\main\script_component.hpp>
SCRIPT(getRandomManNear);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_getRandomManNear

Description:
Get a random man near position in radius

Parameters:
Array - position
Scalar - distance

Returns:
Array - empty if none found, 1 unit within if found

Examples:
(begin example)
//
_result = [getPos player, 300] call ALIVE_fnc_getRandomManNear;
(end)

See Also:

Author:
ARJay
---------------------------------------------------------------------------- */

private ["_position","_distance","_near","_result","_man"];

_position = _this select 0;
_distance = _this select 1;

_near = [];
_result = [];

{
    if(_position distance position _x < _distance) then {
        _near set [count _near, _x];
    }
} forEach (_position nearObjects ["Man",_distance]);

if(count _near > 0) then {
    _man = _near call BIS_fnc_selectRandom;
    _result = [_man];
};

_result