#include <\x\alive\addons\x_lib\script_component.hpp>
SCRIPT(sideNumberToText);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_sideNumberToText

Description:
Return side text from side number (config)

Parameters:
Number - side

Returns:
Side

Examples:
(begin example)
// side number to text
_result = 1 call ALIVE_fnc_sideNumberToText;
(end)

See Also:

Author:
ARJay
---------------------------------------------------------------------------- */

private ["_side", "_result"];
	
_side = _this;

switch(_side) do {
	case 0: {
		_result = "EAST";
	};
	case 1: {
		_result = "WEST";
	};	
	case 2: {
		_result = "GUER";
	};
	case 3: {
		_result = "CIV";
	};
};

_result