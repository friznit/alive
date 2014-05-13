#include "\x\alive\addons\x_lib\script_component.hpp"

/*
	Function: ALiVE_fnc_roundDecimal
	Author(s): Naught
	Description:
		Rounds a numerical value to a certain number of decimal places.
	Parameters:
		0 - Decimal number [number]
		1 - Decimal places [number]
	Returns:
		Rounded decimal [number]
*/

private ["_prec"];
_prec = 10^(_this select 1);

round((_this select 0) * _prec) / _prec
