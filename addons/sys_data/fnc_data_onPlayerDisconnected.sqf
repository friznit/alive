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

private ["_name","_result","_rev"];

TRACE_1("DATA SERVER DISCONNECT", _this);

_name = _this select 1;

if (_name == "__SERVER__") exitWith {

	_rev = [ALIVE_DataDictionary, "_rev", "MISSING"] call ALIVE_fnc_hashGet;

	TRACE_1("DATA DICTIONARY REVISION",_rev);
	
	if (_rev != "MISSING") then {
		// Update data dictionary
		_result = [GVAR(datahandler), "update", ["sys_data", ALIVE_DataDictionary, false, "dictionary", _rev] ] call ALIVE_fnc_Data;
	} else {
		// Write data dictionary
		_result = [GVAR(datahandler), "write", ["sys_data", ALIVE_DataDictionary, false, "dictionary"] ] call ALIVE_fnc_Data;
	};
	
	TRACE_1("SAVING DATA DICTIONARY",_result);

};
	
			


// ====================================================================================