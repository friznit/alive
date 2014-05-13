#include "\x\alive\addons\x_lib\script_component.hpp"

/*
	Function: ALiVE_fnc_modDegrees
	Author(s): Naught
	Description:
		Rounds a degree value to 0 <= X <= 360.
	Parameters:
		0 - Degree number [number]
	Returns:
		Modulated degree [number]
*/

(((_this select 0) % 360) + 360) % 360
