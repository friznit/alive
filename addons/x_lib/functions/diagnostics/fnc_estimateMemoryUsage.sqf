#include "\x\alive\addons\x_lib\script_component.hpp"

/*
	Function: ALiVE_fnc_estimateMemoryUsage
	Author(s): Naught
	Description:
		Estimates the uncompressed memory usage of some data value.
	Parameters:
		0 - Data [any]
	Returns:
		Memory usage in bytes [number]
	Notes:
		1. Will freeze the game on large data values, so use with caution.
*/

count toArray(str(_this select 0))
