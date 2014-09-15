#include <\x\alive\addons\mil_OPCOM\script_component.hpp>
SCRIPT(OPCOMSaveData);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_OPCOMSaveData

Description:
Triggers Saving Data on all running OPCOM instances, triggers and ends Loadingscreen
Needs to run serverside

Parameters:
none

Returns:
Boolean

Examples:
(begin example)
//trigger OPCOM save from DB
call ALIVE_fnc_OPCOMSaveData;
(end)

See Also:
ALIVE_fnc_OPCOMSaveData

Author:
Highhead
---------------------------------------------------------------------------- */

private ["_result"];

if !(isServer) exitwith {};

_result = [];

[true, "ALiVE OPCOM - Saving data", "opper"] call ALIVE_fnc_timer;

	{
        if ([_x,"persistent",false] call ALIVE_fnc_HashGet) then {
			_result set [count _result,[([_x,"saveData"] call ALIVE_fnc_OPCOM)]];
        };
	} foreach OPCOM_INSTANCES;

[false, "ALiVE OPCOM - Save data complete","opper"] call ALIVE_fnc_timer;

_result