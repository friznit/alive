#include "script_component.hpp"
SCRIPT(bulkLoadData_couchdb);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_bulkLoadData_couchdb

Description:
Loads multiple records from a table using the bulk read API

Parameters:
Object - Data handler logic
Array - Module (string), mission key (string), Async (bool)

Returns:
String - Returns a CBA Hash of data

Examples:
(begin example)
	_result = [_logic, "bulkload", ["sys_player", _missionKey, _ondisconnect]] call ALIVE_fnc_Data;
(end)

Author:
Tupolov
Peer Reviewed:

---------------------------------------------------------------------------- */
private ["_response","_result","_error","_module","_data","_missionKey","_indexDoc","_index","_flag"];

_logic = _this select 0;
_args = _this select 1;

_module = _args select 0;
_missionKey  = _args select 1;
_flag = _args select 2;

TRACE_3("loadData", _logic, _args, _flag);

// Read in index document for unique mission key (for this module)
_indexDoc = [_logic, "read", [_module, [], _missionKey]] call ALIVE_fnc_Data;

TRACE_1("Load IndexDoc",_indexDoc);

if (typeName _indexDoc == "ARRAY") then {

	// Set the index revision on the module data handler for purposes of saving a new index later
	_indexRev = [_indexDoc, "_rev"] call CBA_fnc_hashGet;
	[_logic,"indexRev",_indexRev] call CBA_fnc_hashSet;

	_data = [] call CBA_fnc_hashCreate;

	// Grab index
	_index = [_indexDoc, "index"] call CBA_fnc_hashGet; // Should be an array of key values
	TRACE_1("Load index", _index);

	// Send bulkread request (send array of doc ids)

	_data = [_logic, "bulkRead", [_module, _missionKey, _index]] call ALIVE_fnc_Data;

	// Return data as hash
	_result = _data;
} else {
	_result = false;
};

_result;