#include <\x\alive\addons\mil_cqb\script_component.hpp>
SCRIPT(inArea);

/* ----------------------------------------------------------------------------
Function: ALiVE_fnc_inArea

Description:
	Checks to see if a vehicle is within a marker area.
	From A3 1.58 the functionality will be replaced with inArea command.

Parameters:
	0 - Unit/Vehicle [object] or position [array]
	1 - Marker [string]

Returns:
	Object in area [bool]

Attributes:
	N/A

Examples:
	[player,_marker] call ALiVE_fnc_inArea

See Also:

Author:
	Olsen, Highhead
---------------------------------------------------------------------------- */

private["_object", "_objectPosition", "_marker", "_pos", "_xSize", "_ySize", "_radius", "_result", "_x", "_y", "_temp"];

// diag_log str(_this);

_object = _this select 0;
_marker = _this select 1;

switch (typeName _object) do {
	case "ARRAY" : {_objectPosition = _object;};
	case "LOCATION" : {_objectPosition = getpos _object;};
	default {_objectPosition = getposASL _object;};
};

_pos = markerPos _marker;
_xSize = (markerSize _marker) select 0;
_ySize = (markerSize _marker) select 1;
_radius = _xSize;

if (_ySize > _xSize) then
{
	_radius = _ySize;
};

_result = false;

if ((_objectPosition distance _pos) <= (_radius * 1.5)) then
{
	_x = _objectPosition select 0;
	_y = _objectPosition select 1;
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
			if ((_objectPosition distance _pos) <= _radius) then
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

/*
Preperation for 1.58
//Comment code above and only use the below (inArea understands pos-array & object and marker & trigger

_object inArea _marker
*/

_result
