#include "\x\alive\addons\x_lib\script_component.hpp"

/*
	Function: ALiVE_fnc_uErase
	Author(s): Naught
	Description:
		Erases a value from an array (objNull method).
	Parameters:
		0 - Array [array]
		1 - Index to erase [number]
	Returns:
		Array copy [array]
	Notes:
		1. This is faster than ALiVE_fnc_erase.
*/


private ["_arr"];
_arr = _this select 0;

_arr set [(_this select 1), objNull];

(_arr - objNull)
