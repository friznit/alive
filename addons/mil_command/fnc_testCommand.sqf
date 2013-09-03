#include <\x\alive\addons\mil_command\script_component.hpp>
SCRIPT(testCommand);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_testCommand

Description:
Test Command Script for active profiles

Parameters:
Profile - profile
Args - array

Returns:

Examples:
(begin example)
//
_result = [_profile, []] call ALIVE_fnc_testCommand;
(end)

See Also:

Author:
ARJay
---------------------------------------------------------------------------- */

private ["_profile","_args"];

_profile = _this select 0;	
_args = _this select 1;

_leader = _profile select 2 select 10;
_group = _profile select 2 select 13;
_units = _profile select 2 select 21;

waituntil {
	
	["Test Spawned Command Action"] call ALIVE_fnc_dump;
	
	sleep 5;
	
	false 
};
