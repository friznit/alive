#include "\x\alive\addons\x_lib\script_component.hpp"

/*
	Function: ALiVE_fnc_insert
	Author(s): Naught
	Description:
		Inserts a value into the array at a specified index.
	Parameters:
		0 - Array [array]
		1 - Insert index [number]
		2 - Insert value [any]
	Returns:
		Array copy [array]
	Notes:
		1. This is slower than ALiVE_fnc_push.
		2. The lower the index, the higher the recursion.
*/

private ["_arr", "_idx", "_arrCount"];
_arr = _this select 0;
_idx = _this select 1;
_arrCount = count _arr;

for "_i" from 1 to (_arrCount - _idx) do
{
	private ["_offset"];
	_offset = _arrCount - _i;
	
	_arr set [(_offset + 1), _offset];
};

_arr set [_idx, (_this select 2)];

_arr
