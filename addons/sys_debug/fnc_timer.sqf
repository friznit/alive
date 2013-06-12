#include <\x\alive\addons\sys_debug\script_component.hpp>
SCRIPT(timer);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_timer

Description:
Timer function

Parameters:
Boolean - start the timer

Returns:

Examples:
(begin example)
// timer start
[true] call ALIVE_fnc_timer;

// timer stop
[] call ALIVE_fnc_timer;
(end)

See Also:

Author:
ARJay
---------------------------------------------------------------------------- */

ALIVE_timeStart = 0;

private ["_start","_endTimer"];
	
_start = if(count _this > 0) then {_this select 0} else {false};

if(_start) then {
	ALIVE_timeStart = diag_tickTime;
	["[TIMER STARTED]"] call ALIVE_fnc_dump;
} else {
	_endTimer = diag_tickTime - ALIVE_timeStart;
	["[TIMER ENDED : %1]",_endTimer] call ALIVE_fnc_dump;	
};