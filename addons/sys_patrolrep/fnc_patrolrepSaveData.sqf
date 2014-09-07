#include <\x\alive\addons\sys_patrolrep\script_component.hpp>
SCRIPT(patrolrepSaveData);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_patrolrepSaveData

Description:
Triggers Saving Data on for SYS patrolrep, triggers and ends Loadingscreen
Needs to run serverside

Parameters:
none

Returns:
Boolean

Examples:
(begin example)
//trigger patrolrep save to DB
call ALIVE_fnc_patrolrepSaveData;
(end)

See Also:
ALIVE_fnc_patrolrepSaveData

Author:
Highhead
---------------------------------------------------------------------------- */

private ["_result"];

if !(isDedicated && {!(isNil "ALIVE_sys_data")} && {!(ALIVE_sys_data_DISABLED)}) exitwith {false};

[["ALiVE_LOADINGSCREEN"],"BIS_fnc_startLoadingScreen",true,false] call BIS_fnc_MP;
[true, "ALiVE SYS patrolrep persistence save data started", "patrolrepper"] call ALIVE_fnc_timer;

_async = false;
_missionName = [missionName, "%20","-"] call CBA_fnc_replace;
_missionName = format["%1_%2", ALIVE_sys_data_GROUP_ID, _missionName];

_data = [MOD(SYS_patrolrep),"state"] call ALiVE_fnc_patrolrep;

if (count (_data select 1) == 0) exitwith {
    [["ALiVE_LOADINGSCREEN"],"BIS_fnc_endLoadingScreen",true,false] call BIS_fnc_MP;
};

["ALiVE SAVE SYS patrolrep DATA NOW - MISSION NAME: %1! PLEASE WAIT...",_missionName] call ALIVE_fnc_dumpMPH;

_data call ALIVE_fnc_inspectHash;

if (isNil QGVAR(DATAHANDLER)) then {
   ["SAVE SYS patrolrep, CREATE DATA HANDLER!"] call ALIVE_fnc_dump;
   GVAR(DATAHANDLER) = [nil, "create"] call ALIVE_fnc_Data;
   [GVAR(DATAHANDLER),"storeType",true] call ALIVE_fnc_Data;
};

_result = [GVAR(DATAHANDLER), "bulkSave", ["sys_patrolrep", _data, _missionName, _async]] call ALIVE_fnc_Data;

[false, "ALiVE SYS patrolrep persistence save data complete","patrolrepper"] call ALIVE_fnc_timer;
["ALiVE SYS patrolrep SAVE DATA RESULT: %1",_result] call ALiVE_fnc_Dump;

[["ALiVE_LOADINGSCREEN"],"BIS_fnc_endLoadingScreen",true,false] call BIS_fnc_MP;

_result