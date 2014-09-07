#include <\x\alive\addons\mil_C2ISTAR\script_component.hpp>
SCRIPT(taskCreateBombardment);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_taskCreateBombardment

Description:
Create a bombardment directed at an object

Parameters:

Returns:

Examples:
(begin example)

// Spawns small explosions in a random area around the target
[player,"EXPLOSION_SMALL"] call ALIVE_fnc_taskCreateBombardment;

// Spawns missile strikes in a random area around the target, also with random timings
[player,"MISSILE_STRIKE_SMALL",10,30,true,10] call ALIVE_fnc_taskCreateBombardment;

// Spawns large bombs in a random area around the target, also with random timings
[spawnTarget1,"EXPLOSION_LARGE",10,30,true,20] call ALIVE_fnc_taskCreateBombardment;
(end)

See Also:

Author:
ARJay
---------------------------------------------------------------------------- */

private ["_target","_type","_count","_distance","_randomTiming","_randomTimingMax","_position","_object"];

_target = _this select 0;
_type = _this select 1;
_count = if(count _this > 2) then {_this select 2} else {5};
_distance = if(count _this > 3) then {_this select 3} else {100};
_randomTiming = if(count _this > 4) then {_this select 4} else {false};
_randomTimingMax = if(count _this > 5) then {_this select 5} else {10};

for "_i" from 0 to _count-1 do
{
    if(_randomTiming) then
    {
        [_target, _type, _distance] spawn {

            private["_target","_type","_distance"];

            _target = _this select 0;
            _type = _this select 1;
            _distance = _this select 2;

            sleep random 10;

            _object = [_target, _type] call ALIVE_fnc_taskCreateExplosiveProjectile;
            _position = [position _object, random _distance, random 360] call BIS_fnc_relPos;
            _object setPos _position;
        };
    }
    else
    {
        _object = [_target, _type] call ALIVE_fnc_taskCreateExplosiveProjectile;
        _position = [position _object, random _distance, random 360] call BIS_fnc_relPos;
        _object setPos _position;
    };
};