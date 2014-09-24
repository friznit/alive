#include <\x\alive\addons\x_lib\script_component.hpp>
SCRIPT(chaseWheelShot);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_chaseWheelShot

Description:
Chase wheel shot

Parameters:
Object - camera
Object - target
Scalar - shot duration
Boolean - hide target objects

Returns:


Examples:
(begin example)
[_camera,_target,10,false] call ALIVE_fnc_chaseWheelShot;
(end)

See Also:

Author:
ARJay
---------------------------------------------------------------------------- */

private ["_camera", "_target", "_hideTarget", "_duration", "_i"];

_camera = _this select 0;
_target = _this select 1;
_duration = if(count _this > 3) then {_this select 3} else {5};
_hideTarget = if(count _this > 4) then {_this select 4} else {false};

if(_hideTarget) then
{
    hideObject _target;
};

_i = 0;
while {_i < _duration / 0.1} do
{
    _i = _i + 1;
    _camera attachTo [_target, [-1.4,1,-1]];
    _camera camCommitPrepared 0;
    sleep 0.1;
};