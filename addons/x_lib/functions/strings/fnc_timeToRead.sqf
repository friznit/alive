#include "\x\alive\addons\x_lib\script_component.hpp"

/*
	Function: ALiVE_fnc_timeToRead
	Author(s): Naught
	Description:
		Calculates a rough estimate on how long it will take a reader to
		read a string of text, in seconds. Uses 19 characters per second.
	Parameters:
		0 - String [string]
	Returns:
		Time to read in seconds [number]
*/

count(toArray(_this select 0)) / 19;