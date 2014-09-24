#include <\x\alive\addons\x_lib\script_component.hpp>
SCRIPT(setCameraAngle);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_setCameraAngle

Description:
Set Camera Angle

Parameters:
Array - position
String - starting camera angle DEFAULT,LOW,EYE,HIGH,BIRDS_EYE,UAV,SATELITE

Returns:


Examples:
(begin example)
_camera = [_position,"HIGH"] call ALIVE_fnc_setCameraAngle;
(end)

See Also:

Author:
ARJay
---------------------------------------------------------------------------- */

private ["_position", "_angle", "_Y"];

_position = _this select 0;
_angle = _this select 1;

switch(_angle) do
{
    case "DEFAULT":
        {

        };
    case "LOW":
        {
            _Y = _position select 2;
            _position set [2,_Y+1];
        };
    case "EYE":
        {
            _Y = _position select 2;
            _position set [2,_Y+1.3];
        };
    case "HIGH":
        {
            _Y = _position select 2;
            _position set [2,_Y+2];
        };
    case "BIRDS_EYE":
        {
            _Y = _position select 2;
            _position set [2,_Y+20];
        };
    case "UAV":
        {
            _Y = _position select 2;
            _position set [2,_Y+100];
        };
    case "SATELITE":
        {
            _Y = _position select 2;
            _position set [2,_Y+500];
        };

};

_position