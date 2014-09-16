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

private ["_admin","_result","_data","_async","_missionName","_message"];

_admin = _this select 0;

if !(isDedicated && {!(isNil "ALIVE_sys_data")} && {!(ALIVE_sys_data_DISABLED)}) exitwith {};

if(ALiVE_SYS_DATA_DEBUG_ON) then {
    [true, "ALiVE CQB - Saving data", "cqbper"] call ALIVE_fnc_timer;
};

_async = false;
_missionName = [missionName, "%20","-"] call CBA_fnc_replace;
_missionName = format["%1_%2", ALIVE_sys_data_GROUP_ID, _missionName];

_keys = [];
_values = [];
_data = [] call ALiVE_fnc_HashCreate;
{
    if (call compile (_x getvariable ["CQB_persistent","false"])) then {
		_state = [_x,"state"] call ALiVE_fnc_CQB;
	    _type = [_state,"instancetype"] call AliVE_fnc_HashGet;
	    _id = format["CQB_%1_%2",_type,_foreachIndex];
	
	    [_state,"houses"] call ALiVE_fnc_HashRem;
	
		[_data,_id,_state] call ALiVE_fnc_HashSet;
    };
} foreach (MOD(CQB) getVariable ["instances",[]]);

if (count (_data select 1) == 0) exitwith {
    //[["ALiVE_LOADINGSCREEN"],"BIS_fnc_endLoadingScreen",true,false] call BIS_fnc_MP;
};

_message = format["ALiVE CQB - Preparing to save %1 CQB locations..",count(_data select 1)];
[["updateList",_message],"ALIVE_fnc_mainTablet",_admin,false,false] spawn BIS_fnc_MP;

if(ALiVE_SYS_DATA_DEBUG_ON) then {
    ["ALiVE SAVE CQB DATA NOW - MISSION NAME: %1! PLEASE WAIT...",_missionName] call ALIVE_fnc_dump;
    _data call ALIVE_fnc_inspectHash;
};


if (isNil QGVAR(DATAHANDLER)) then {

    if(ALiVE_SYS_DATA_DEBUG_ON) then {
        ["SAVE CQB, CREATE DATA HANDLER!"] call ALIVE_fnc_dump;
    };

    GVAR(DATAHANDLER) = [nil, "create"] call ALIVE_fnc_Data;
    [GVAR(DATAHANDLER),"storeType",true] call ALIVE_fnc_Data;
};

_result = [GVAR(DATAHANDLER), "bulkSave", ["mil_cqb", _data, _missionName, _async]] call ALIVE_fnc_Data;


_message = format["ALiVE CQB - Save Result: %1",_result];
[["updateList",_message],"ALIVE_fnc_mainTablet",_admin,false,false] spawn BIS_fnc_MP;


if(ALiVE_SYS_DATA_DEBUG_ON) then {
    [false, "ALiVE CQB - Save data complete","cqbper"] call ALIVE_fnc_timer;
    ["ALiVE CQB SAVE DATA RESULT: %1",_result] call ALiVE_fnc_Dump;
};

_result