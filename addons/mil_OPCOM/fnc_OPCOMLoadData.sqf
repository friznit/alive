#include <\x\alive\addons\mil_OPCOM\script_component.hpp>
SCRIPT(OPCOMLoadData);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_OPCOMLoadData

Description:
Triggers Loading Data on all running OPCOM instances, triggers and ends Loadingscreen
Needs to run serverside

Parameters:
none

Returns:
Boolean

Examples:
(begin example)
//trigger OPCOM load from DB
call ALIVE_fnc_OPCOMLoadData;
(end)

See Also:
ALIVE_fnc_OPCOMSaveData

Author:
Highhead
---------------------------------------------------------------------------- */

private ["_result"];

if !(isServer) exitwith {};

_result = [];

[["ALiVE_LOADINGSCREEN"],"BIS_fnc_startLoadingScreen",true,false] call BIS_fnc_MP;
[true] call ALiVE_fnc_timer;
	{
        if ([_x,"persistent",false] call ALIVE_fnc_HashGet) then {
			_result set [count _result,[([_x,"loadData"] call ALIVE_fnc_OPCOM)]];
        };
	} foreach OPCOM_INSTANCES;
[] call ALiVE_fnc_timer;
{["ALiVE OPCOM LOAD DATA RESULT: %1",_x] call ALiVE_fnc_Dump} foreach _result;

[["ALiVE_LOADINGSCREEN"],"BIS_fnc_endLoadingScreen",true,false] call BIS_fnc_MP;

_result