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

#include "script_component.hpp"

private ["_result","_rev","_dictionaryName"];

TRACE_1("DATA SERVER DISCONNECT", _this);

_result = objNull;

if (_name == "__SERVER__") exitWith {

	_rev = [ALIVE_DataDictionary, "_rev", "MISSING"] call ALIVE_fnc_hashGet;

	TRACE_1("DATA DICTIONARY REVISION",_rev);

	_dictionaryName = format["dictionary_%1_%2", GVAR(GROUP_ID), missionName];

	if (_rev != "MISSING") then {
		// Update data dictionary
		_result = [GVAR(datahandler), "update", ["sys_data", ALIVE_DataDictionary, false, _dictionaryName, _rev] ] call ALIVE_fnc_Data;
	} else {
		// Write data dictionary
		_result = [GVAR(datahandler), "write", ["sys_data", ALIVE_DataDictionary, false, _dictionaryName] ] call ALIVE_fnc_Data;
	};

	TRACE_1("SAVING DATA DICTIONARY",_result);

};

_result;


// ====================================================================================