#include <\x\alive\addons\x_lib\script_component.hpp>
SCRIPT(isEnemyNear);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_isEnemyNear

Description:
Returns if there are any nearby enemy

Parameters:
Array - position
String - side text
Scalar - radius

Returns:

Examples:
(begin example)
// are there any enemies of WEST side within 1000 meters?
_result = [_position, "WEST", 1000] call ALIVE_fnc_isEnemyNear;
(end)

See Also:

Author:
ARJay
---------------------------------------------------------------------------- */

private ["_position","_side","_radius","_found","_enemySides","_entities","_entitySide"];

_position = _this select 0;
_side = _this select 1;
_radius = if(count _this > 2) then {_this select 2} else {500};

_side = [_side] call ALIVE_fnc_sideTextToObject;
_found = false;
_enemySides = [];

if(_side getFriend east < 0.6) then {
    _enemySides set [count _enemySides,east];
};

if(_side getFriend west < 0.6) then {
    _enemySides set [count _enemySides,west];
};

if(_side getFriend resistance < 0.6) then {
    _enemySides set [count _enemySides,resistance];
};

if(_side getFriend civilian < 0.6) then {
    _enemySides set [count _enemySides,civilian];
};

["ENEMY SIDES: %1",_enemySides] call ALIVE_fnc_dump;

_entities = _position nearEntities ["Man", _radius];

if(count _entities > 0) then {
    {
        _entitySide = side _x;
        if(_entitySide in _enemySides) exitWith {
            _found = true;
            ["FOUND ENEMY: %1",_entitySide] call ALIVE_fnc_dump;
        };
    } forEach _entities;
};

_found