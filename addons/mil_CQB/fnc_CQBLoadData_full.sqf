#include <\x\alive\addons\mil_CQB\script_component.hpp>
SCRIPT(CQBLoadData);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_CQBLoadData

Description:
Triggers Loading Data on all running CQB instances, triggers and ends Loadingscreen
Needs to run serverside

Parameters:
none

Returns:
Boolean

Examples:
(begin example)
//trigger CQB load from DB
call ALIVE_fnc_CQBLoadData;
(end)

See Also:
ALIVE_fnc_CQBSaveData

Author:
Highhead
---------------------------------------------------------------------------- */

if !(isDedicated && {!(isNil "ALIVE_sys_data")} && {!(ALIVE_sys_data_DISABLED)} && {call compile (MOD(CQB) getvariable ["CQB_persistent","false"])}) exitwith {};

private ["_data","_instances"];

[true, "ALiVE CQB persistence load data started", "cqbper"] call ALIVE_fnc_timer;

_async = false;
_missionName = [missionName, " ","-"] call CBA_fnc_replace;
_missionName = format["%1_%2", ALIVE_sys_data_GROUP_ID, _missionName];

_datahandler = [nil, "create"] call ALIVE_fnc_Data;
[_datahandler,"storeType",true] call ALIVE_fnc_Data;
_data = [_datahandler, "load", ["mil_cqb", _missionName, _async]] call ALIVE_fnc_Data;

if (!(isnil "_this") && {typeName _this == "BOOL"} && {!_this}) exitwith {
    [false, "ALiVE CQB persistence load data complete", "cqbper"] call ALIVE_fnc_timer;
    _data
};

_data call ALIVE_fnc_inspectHash;

_instances = (ALiVE_CQB getVariable ["instances",[CQB_Regular,CQB_Strategic]]);

{[_x,"active",false] call ALiVE_fnc_CQB} foreach _instances;
{
	private ["_state","_logic"];
	_logic  = _x;
	_state = [_logic,"state"] call ALiVE_fnc_CQB;
	
	["ALiVE LOAD CQB DATA APPLYING STATE!"] call ALIVE_fnc_dumpMPH;
	[_state,"houses",_data] call ALiVE_fnc_HashSet;
	
	_state call ALIVE_fnc_inspectHash;
	
	[_logic,"state",_state] call ALiVE_fnc_CQB;
} foreach (ALiVE_CQB getVariable ["instances",[CQB_Regular,CQB_Strategic]]);
{[_x,"active",true] call ALiVE_fnc_CQB} foreach _instances;

[false, "ALiVE CQB persistence load data completed and applied","cqbper"] call ALIVE_fnc_timer;

_data