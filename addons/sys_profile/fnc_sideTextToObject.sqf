#include <\x\alive\addons\sys_profile\script_component.hpp>
SCRIPT(sideTextToObject);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_sideTextToObject

Description:
Return side object from side text

Parameters:
String - side

Returns:
Side

Examples:
(begin example)
// side text to object
_result = ["EAST"] call ALIVE_fnc_sideTextToObject;
(end)

See Also:

Author:
ARJay
---------------------------------------------------------------------------- */

private ["_side", "_result"];
	
_side = _this select 0;

switch(_side) do {
	case "WEST": {
		_result = west;
	};
	case "EAST": {
		_result = east;
	};
	case "GUER": {
		_result = resistance;
	};
	case "CIV": {
		_result = civ;
	};
};

_result