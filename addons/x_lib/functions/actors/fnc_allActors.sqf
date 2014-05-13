#include "\x\alive\addons\x_lib\script_component.hpp"

/*
	Function: ALiVE_fnc_allActors
	Author(s): Naught
	Description:
		Returns all actors in the current mission.
	Parameters:
		0 - Actor group [group] (optional)
	Returns:
		Actor list [array]
*/


private ["_group"];
_group = [_this, 1, ["GROUP"], ALiVE_actors_mainGroup] call ALiVE_fnc_param;

if (!isNil "_group") then
{
	units _group
}
else
{
	LOG_WARNING("ALiVE_fnc_allActors", "Attempted to list actors before the main actor group was created!");
	[]
};
