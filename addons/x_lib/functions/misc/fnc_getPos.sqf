#include "\x\alive\addons\x_lib\script_component.hpp"

/*
	Function: ALiVE_fnc_getPos
	Author(s): Naught
	Description:
		Gets the position of a thing.
	Parameters:
		0 - Thing [object:marker:array]
	Returns:
		Position [array]
*/

private ["_thing"];
_thing = _this select 0;

switch (typeName _thing) do
{
	case "OBJECT": {getPos _thing};
	case "STRING": {getMarkerPos _thing};
	case "ARRAY": {getWPPos _thing};
	default {[0,0,0]};
};
