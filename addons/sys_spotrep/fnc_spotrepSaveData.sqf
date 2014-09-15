#include <\x\alive\addons\sys_spotrep\script_component.hpp>
SCRIPT(spotrepSaveData);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_spotrepSaveData

Description:
Triggers Saving Data on for SYS spotrep, triggers and ends Loadingscreen
Needs to run serverside

Parameters:
none

Returns:
Boolean

Examples:
(begin example)
//trigger spotrep save to DB
call ALIVE_fnc_spotrepSaveData;
(end)

See Also:
ALIVE_fnc_spotrepSaveData

Author:
Highhead
---------------------------------------------------------------------------- */

private ["_result"];

if !(isDedicated && {!(isNil "ALIVE_sys_data")} && {!(ALIVE_sys_data_DISABLED)}) exitwith {false};

[true, "ALiVE SYS SPOTREP - Saving data", "spotrepper"] call ALIVE_fnc_timer;

_async = false;
_missionName = [missionName, "%20","-"] call CBA_fnc_replace;
_missionName = format["%1_%2", ALIVE_sys_data_GROUP_ID, _missionName];

_data = [MOD(SYS_spotrep),"state"] call ALiVE_fnc_spotrep;

if (count (_data select 1) == 0) exitwith {
    //[["ALiVE_LOADINGSCREEN"],"BIS_fnc_endLoadingScreen",true,false] call BIS_fnc_MP;
};

["ALiVE SAVE SYS SPOTREP DATA NOW - MISSION NAME: %1! PLEASE WAIT...",_missionName] call ALIVE_fnc_dumpMPH;

_data call ALIVE_fnc_inspectHash;

if (isNil QGVAR(DATAHANDLER)) then {
   ["SAVE SYS SPOTREP, CREATE DATA HANDLER!"] call ALIVE_fnc_dump;
   GVAR(DATAHANDLER) = [nil, "create"] call ALIVE_fnc_Data;
   [GVAR(DATAHANDLER),"storeType",true] call ALIVE_fnc_Data;
};

_result = [GVAR(DATAHANDLER), "bulkSave", ["sys_spotrep", _data, _missionName, _async]] call ALIVE_fnc_Data;

[false, "ALiVE SYS SPOTREP - Save data complete","spotrepper"] call ALIVE_fnc_timer;
["ALiVE SYS SPOTREP SAVE DATA RESULT: %1",_result] call ALiVE_fnc_Dump;


_result