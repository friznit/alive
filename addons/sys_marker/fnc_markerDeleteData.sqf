#include <\x\alive\addons\sys_marker\script_component.hpp>
SCRIPT(markerDeleteData);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_markerDeleteData

Description:
Triggers deleting Data on running SYS marker instances, triggers and ends Loadingscreen
Needs to run serverside

Parameters:
none

Returns:
Boolean

Examples:
(begin example)
//trigger SYS marker load from DB
[] call ALIVE_fnc_markerDeleteData;
(end)

See Also:
ALIVE_fnc_markerSaveData

Author:
Highhead
---------------------------------------------------------------------------- */

if !(isDedicated && {!(isNil "ALIVE_sys_data")} && {!(ALIVE_sys_data_DISABLED)}) exitwith {false};

private ["_data","_async","_missionName","_docid","_rev","_markerName","_markerHash"];

_markerName = _this select 0;
_markerHash = _this select 1;

_async = true;
_missionName = [missionName, "%20","-"] call CBA_fnc_replace;
_missionName = format["%1_%2", ALIVE_sys_data_GROUP_ID, _missionName];
_docid = _missionName + "-" + _markerName;

_rev = [_markerHash, "_rev", "MISSING"] call ALIVE_fnc_hashGet;

if (_rev == "MISSING") exitWith {false};

_data = [GVAR(DATAHANDLER), "delete", ["sys_marker", _async, _docid, _rev]] call ALIVE_fnc_Data;

_data