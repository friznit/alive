/*
 * Filename:
 * fnc_data_onPlayerDisconnected.sqf
 *
 * Description:
 * handled onPlayerDisconnected event for sys_data, saving dictionary data when the server disconnects
 *
 * Created by Tupolov
 * Creation date: 06/07/2013
 *
 * */

// ====================================================================================
// MAIN

#include <\x\alive\addons\sys_data\script_component.hpp>
SCRIPT(data_onPlayerDisconnected);

private ["_result","_rev","_dictionaryName"];

TRACE_1("DATA SERVER DISCONNECT", _this);

_result = objNull;

if (_name == "__SERVER__") exitWith {

	// Save mission date / time

	TRACE_2("LOGIC STATE MISSION", MOD(sys_data), MOD(sys_data) getVariable "saveDateTime");

	if (MOD(sys_data) getVariable ["saveDateTime","true"] == "true") then {

		[GVAR(mission_data), "date", date] call ALIVE_fnc_hashSet;

		_missionName = format["%1_%2", GVAR(GROUP_ID), missionName];

		_result = [GVAR(datahandler), "write", ["sys_data", GVAR(mission_data), false, _missionName] ] call ALIVE_fnc_Data;
	};

	// Save Data Dictionary

	_dictionaryName = format["dictionary_%1_%2", GVAR(GROUP_ID), missionName];

	_result = [GVAR(datahandler), "write", ["sys_data", ALIVE_DataDictionary, false, _dictionaryName] ] call ALIVE_fnc_Data;

	TRACE_1("SAVING DATA DICTIONARY",_result);

};

_result;


// ====================================================================================