#include <\x\alive\addons\x_lib\script_component.hpp>
SCRIPT(chaseAngleShot);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_chaseAngleShot

Description:
Chase angle shot

Parameters:
Object - camera
Object - target
Scalar - shot duration
Boolean - hide target objects

Returns:


Examples:
(begin example)
[_camera,_target,10,false] call ALIVE_fnc_chaseAngleShot;
(end)

See Also:

Author:
ARJay
---------------------------------------------------------------------------- */

private ["_camera", "_target", "_hideTarget", "_duration", "_startTime", "_currentTime", "_eventID"];

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
_dummy attachTo [_target, [10, 10, 0]];

_camera attachTo [_target, [-10,-10,2]];
_camera camSetTarget _dummy;
_camera cameraEffect ["INTERNAL", "BACK"];
_camera camCommit 0;

waitUntil { sleep 1; _currentTime = time; ((_currentTime - _startTime) >= _duration)};

deleteVehicle _dummy;