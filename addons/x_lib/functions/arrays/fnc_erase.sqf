#include "\x\alive\addons\x_lib\script_component.hpp"

/*
	Function: ALiVE_fnc_erase
	Author(s): Naught
	Description:
		Erases a value from an array (preserves order).
	Parameters:
		0 - Array [array]
		1 - Index to erase [number]
	Returns:
		Array copy [array]
	Notes:
		1. This is slower than ALiVE_fnc_uErase.
*/

private ["_arr", "_arrCount"];
_arr = _this select 0;
_arrCount = count _arr;

for "_i" from (_this select 1) to (_arrCount - 2) do
{
	_arr set [_i, (_arr select (_i + 1))];
};

_arr resize (_arrCount - 1);

_arr
