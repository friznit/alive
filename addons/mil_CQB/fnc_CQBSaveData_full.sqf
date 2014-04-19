#include <\x\alive\addons\mil_CQB\script_component.hpp>
SCRIPT(CQBSaveData);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_CQBSaveData

Description:
Triggers Saving Data on all running CQB instances, triggers and ends Loadingscreen
Needs to run serverside

Parameters:
none

Returns:
Boolean

Examples:
(begin example)
//trigger CQB save from DB
call ALIVE_fnc_CQBSaveData;
(end)

See Also:
ALIVE_fnc_CQBSaveData

Author:
Highhead
---------------------------------------------------------------------------- */

private ["_result"];

if !(isDedicated && {!(isNil "ALIVE_sys_data")} && {!(ALIVE_sys_data_DISABLED)} && {call compile (MOD(CQB) getvariable ["CQB_persistent","false"])}) exitwith {};

[["ALiVE_LOADINGSCREEN"],"BIS_fnc_startLoadingScreen",true,false] call BIS_fnc_MP;
[true, "ALiVE CQB persistence save data started", "cqbper"] call ALIVE_fnc_timer;

_async = false;
_missionName = [missionName, " ","-"] call CBA_fnc_replace;
_missionName = format["%1_%2", ALIVE_sys_data_GROUP_ID, _missionName];

_keys = [];
_values = [];
_data = [] call ALiVE_fnc_HashCreate;
{
	_state = [_x,"state"] call ALiVE_fnc_CQB;
	_houses = [_state,"houses"] call ALiVE_fnc_HashGet;

	_keys = _keys + (_houses select 1);
	_values = _values + (_houses select 2);
	
	_data set [1,_keys];
	_data set [2,_values];
} foreach (ALiVE_CQB getVariable ["instances",[CQB_Regular,CQB_Strategic]]);

["ALiVE SAVE CQB DATA NOW - MISSION NAME: %1! PLEASE WAIT...",_missionName] call ALIVE_fnc_dumpMPH;

_data call ALIVE_fnc_inspectHash;
_datahandler = [nil, "create"] call ALIVE_fnc_Data;
[_datahandler,"storeType",true] call ALIVE_fnc_Data;

_result = [_datahandler, "save", ["mil_cqb", _data, _missionName, _async]] call ALIVE_fnc_Data;

[false, "ALiVE CQB persistence save data complete","cqbper"] call ALIVE_fnc_timer;
["ALiVE CQB SAVE DATA RESULT: %1",_result] call ALiVE_fnc_Dump;

[["ALiVE_LOADINGSCREEN"],"BIS_fnc_endLoadingScreen",true,false] call BIS_fnc_MP;

_result