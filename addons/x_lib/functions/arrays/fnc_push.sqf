#include "\x\alive\addons\x_lib\script_component.hpp"

/*
	Function: ALiVE_fnc_push
	Author(s): Naught
	Description:
		Adds a value to the last of an array.
	Parameters:
		0 - Array [array]
		1 - Value to push [any]
	Returns:
		Array copy [array]
	Notes:
		1. This is faster than ALiVE_fnc_insert.
*/

private ["_arr"];
_arr = _this select 0;

_arr set [(count _arr), (_this select 1)];

_arr
