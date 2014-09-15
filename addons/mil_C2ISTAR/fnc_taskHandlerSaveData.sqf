#include <\x\alive\addons\mil_C2ISTAR\script_component.hpp>
SCRIPT(taskHandlerSaveData);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_taskHandlerSaveData

Description:
Save task persistence state via sys_data

Parameters:

Returns:
Boolean

Examples:
(begin example)
// save tasks data
_result = call ALIVE_fnc_taskHandlerSaveData;
(end)

See Also:
ALIVE_fnc_taskHandlerLoadData

Author:
ARJay
---------------------------------------------------------------------------- */

private ["_result","_data","_async","_missionName"];

if !(isDedicated && {!(isNil "ALIVE_sys_data")} && {!(ALIVE_sys_data_DISABLED)}) exitwith {false};

[true, "ALiVE TASK HANDLER - Saving data", "taskHandlerper"] call ALIVE_fnc_timer;

_async = false;
_missionName = [missionName, "%20","-"] call CBA_fnc_replace;
_missionName = format["%1_%2_TASK", ALIVE_sys_data_GROUP_ID, _missionName];

_data = [ALIVE_taskHandler,"exportTaskData"] call ALIVE_fnc_taskHandler;

if (count (_data select 1) == 0) exitwith {
    //[["ALiVE_LOADINGSCREEN"],"BIS_fnc_endLoadingScreen",true,false] call BIS_fnc_MP;
};

["ALiVE SAVE TASK HANDLER DATA NOW - MISSION NAME: %1! PLEASE WAIT...",_missionName] call ALIVE_fnc_dumpMPH;

_data call ALIVE_fnc_inspectHash;

if (isNil QGVAR(DATAHANDLER)) then {
   ["SAVE TASK HANDLER, CREATE DATA HANDLER!"] call ALIVE_fnc_dump;
   GVAR(DATAHANDLER) = [nil, "create"] call ALIVE_fnc_Data;
   [GVAR(DATAHANDLER),"storeType",true] call ALIVE_fnc_Data;
};

_result = [GVAR(DATAHANDLER), "bulkSave", ["sys_tasks", _data, _missionName, _async]] call ALIVE_fnc_Data;

[false, "ALiVE TASK HANDLER - Save data complete","taskHandlerper"] call ALIVE_fnc_timer;
["ALiVE TASK HANDLER SAVE DATA RESULT: %1",_result] call ALiVE_fnc_Dump;


_result