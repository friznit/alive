#include <\x\alive\addons\x_lib\script_component.hpp>
SCRIPT(FiredShot);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_FiredShot

Description:
Behind vehicle that fired looking at target shot

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

private ["_camera", "_target", "_hideTarget", "_duration", "_startTime", "_currentTime", "_eventID","_fov"];

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

if (_target iskindof "MAN") then {
	x = (0.5-(round(random 1)));
	y = -1;
	z = ((eyepos _target) select 2) - ((getposASL _target) select 2);
	_fov = 0.6;
} else {
	x = (3-(round(random 6)));
	y = -9 + random -10;
	z = 1 + random 3;
	_fov = 0.9;
};

_relpos = [x , y, z];
_cam attachTo [_target,_relpos];
_cam camSetTarget (assignedTarget _target);
_cam camSetFOV _fov;
_cam cameraEffect ["INTERNAL", "BACK"];
_cam camCommit 0;

waitUntil { sleep 1; _currentTime = time; ((_currentTime - _startTime) >= _duration)};

