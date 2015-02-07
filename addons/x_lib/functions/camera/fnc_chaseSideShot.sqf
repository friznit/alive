#include <\x\alive\addons\x_lib\script_component.hpp>
SCRIPT(chaseSideShot);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_chaseSideShot

Description:
Chase side shot

Parameters:
Object - camera
Object - target
Scalar - shot duration
Boolean - hide target objects

Returns:


Examples:
(begin example)
[_camera,_target,10,false] call ALIVE_fnc_chaseSideShot;
(end)

See Also:

Author:
ARJay
---------------------------------------------------------------------------- */

private ["_camera", "_target", "_hideTarget", "_duration", "_startTime", "_currentTime", "_eventID", "_x", "_dummy"];

_camera = _this select 0;
_target = _this select 1;
_duration = if(count _this > 2) then {_this select 2} else {5};
_hideTarget = if(count _this > 3) then {_this select 3} else {false};

if(_hideTarget) then
{
    hideObject _target;
};

_startTime = time;
_currentTime = _startTime;

_dummy = "Sign_Sphere100cm_F" createVehicle [0,0,0];

If (random 1 > 0.5) then {
	_x = -10;
	_dummy attachTo [_target, [10, 3, 0]];
} else {
	_x = 10;
	_dummy attachTo [_target, [-10, 3, 0]];
};

_camera attachTo [_target, [_x,0,0.5]];
_camera camSetTarget _dummy;
_camera cameraEffect ["INTERNAL", "BACK"];
_camera camCommit 0;

waitUntil { sleep 1; _currentTime = time; ((_currentTime - _startTime) >= _duration)};

deleteVehicle _dummy;