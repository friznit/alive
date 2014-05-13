#include "\x\alive\addons\x_lib\script_component.hpp"

/*
	Function: ALiVE_fnc_inArea
	Author(s): Olsen
	Description:
		Checks to see if a vehicle is within a marker area.
	Parameters:
		0 - Unit/Vehicle [object]
		1 - Marker [string]
	Returns:
		Object in area [bool]
*/

private["_object", "_marker", "_pos", "_xSize", "_ySize", "_radius", "_result", "_x", "_y", "_temp"];
_object = _this select 0;
_marker = _this select 1;

_pos = markerPos _marker;
_xSize = (markerSize _marker) select 0;
_ySize = (markerSize _marker) select 1;
_radius = _xSize;

if (_ySize > _xSize) then
{
	_radius = _ySize;
};

_result = false;

if ((_object distance _pos) <= (_radius * 1.5)) then
{
	_x = (getPosASL _object) select 0;
	_y = (getPosASL _object) select 1;
	_angle = markerDir _marker;
	_x = _x - (_pos select 0);
	_y = _y - (_pos select 1);
	
	if (_angle != 0) then
	{
		_temp = _x * cos(_angle) - _y * sin(_angle);
		_y = _x * sin(_angle) + _y * cos(_angle);
		_x = _temp;
	};	
	
	if ((markerShape _marker) == "ELLIPSE") then
	{
		if (_xSize == _ySize) then
		{
			if ((_object distance _pos) <= _radius) then
			{
				_result = true;	
			};
		}
		else
		{
			if (((_x ^ 2) / (_xSize ^ 2) + (_y ^ 2) / (_ySize ^ 2)) <= 1) then
			{
				_result = true;
			};
		};
	}
	else
	{
		if ((abs _x) <= _xSize && (abs _y) <= _ySize) then
		{
			_result = true;
		};
	};
};

_result
