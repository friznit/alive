#include <\x\alive\addons\mil_logistics\script_component.hpp>
SCRIPT(MLSaveData);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_MLSaveData

Description:
Save mil logistics persistence state via sys_data

Parameters:

Returns:
Boolean

Examples:
(begin example)
// save logistics data
_result = call ALIVE_fnc_MLSaveData;
(end)

See Also:
ALIVE_fnc_MLLoadData

Author:
ARJay
---------------------------------------------------------------------------- */

private ["_result","_data","_async","_missionName"];

if !(isDedicated && {!(isNil "ALIVE_sys_data")} && {!(ALIVE_sys_data_DISABLED)}) exitwith {false};

[["ALiVE_LOADINGSCREEN"],"BIS_fnc_startLoadingScreen",true,false] call BIS_fnc_MP;
[true, "ALiVE MIL LOGISTICS persistence save data started", "mlper"] call ALIVE_fnc_timer;

_async = false;
_missionName = [missionName, "%20","-"] call CBA_fnc_replace;
_missionName = format["%1_%2_FORCE_POOL", ALIVE_sys_data_GROUP_ID, _missionName];

_data = ALIVE_globalForcePool;

if (count (_data select 1) == 0) exitwith {
    [["ALiVE_LOADINGSCREEN"],"BIS_fnc_endLoadingScreen",true,false] call BIS_fnc_MP;
};

["ALiVE SAVE MIL LOGISTICS DATA NOW - MISSION NAME: %1! PLEASE WAIT...",_missionName] call ALIVE_fnc_dumpMPH;

_data call ALIVE_fnc_inspectHash;

if (isNil QGVAR(DATAHANDLER)) then {
   ["SAVE MIL LOGISTICS, CREATE DATA HANDLER!"] call ALIVE_fnc_dump;
   GVAR(DATAHANDLER) = [nil, "create"] call ALIVE_fnc_Data;
   [GVAR(DATAHANDLER),"storeType",true] call ALIVE_fnc_Data;
};

_result = [GVAR(DATAHANDLER), "write", ["mil_logistics", _data, _async, _missionName]] call ALIVE_fnc_Data;

[false, "ALiVE MIL LOGISTICS persistence save data complete","mlper"] call ALIVE_fnc_timer;
["ALiVE MIL LOGISTICS SAVE DATA RESULT: %1",_result] call ALiVE_fnc_Dump;

[["ALiVE_LOADINGSCREEN"],"BIS_fnc_endLoadingScreen",true,false] call BIS_fnc_MP;

_result