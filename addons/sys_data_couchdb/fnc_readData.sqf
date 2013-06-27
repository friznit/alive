/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_readData

Description:
Reads data from an external datasource (SQL, JSON, Text File)

Parameters:
String - Database name
String - Module name 
Array - Array of key/value unique identifiers

Returns:
String - Returns a response error or data

Examples:
(begin example)
	
(end)

Author:
Tupolov
Peer Reviewed:

---------------------------------------------------------------------------- */
#include "script_component.hpp"	
SCRIPT(readData_couchdb);

private ["_response"];

// Avoided using the format command as it has a 2kb limt

PARAMS_3(_databaseName, _module, _params);

TRACE_3("ReadData CouchDB -", [_params] call CBA_fnc_strLen, _params, typeName _params);

//validate params?

private ["_pairs","_cmd","_json"];

_cmd = format ["SendJSON [""POST"", ""%1""", _module];
{
	_pairs = _pairs + "'" + (_x select 0) + "'" + ":" + "'" + (_x select 1) + "'" + ","; 
} foreach _params;
_json = _cmd + ", '{" + _pairs + "}']";

// Get rid of any left over commas
_json = [_json, ",}", "}"] call CBA_fnc_replace;

// Send JSON to plugin
_response = [_json] call ALIVE_fnc_sendToPlugIn;

_result = [_response] call ALIVE_fnc_restoreData_couchdb;

/*
	// Handle data error
	private["_err"];
	_err = format["The Couch database %1 did not respond with %2. The data returned was: %3", _databaseName, typeName _result, _result];
	ERROR_WITH_TITLE(str _logic, _err);
*/

_result;
		

