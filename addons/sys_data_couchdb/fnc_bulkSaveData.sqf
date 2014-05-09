#include "script_component.hpp"
SCRIPT(bulkSaveData_couchdb);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_bulkSaveData_couchdb

Description:
Saves multiple records to a table using CouchDB Bulk API

Parameters:
Object - Data handler logic
Array - Module (string), Data (CBA Hash), mission key (string), Async (bool) optional

Returns:
String - Returns a response error or confirmation of write

Examples:
(begin example)
	_result = [_logic, "save", ["sys_player", GVAR(player_data), _missionKey, _ondisconnect]] call ALIVE_fnc_Data;
(end)

Author:
Tupolov
Peer Reviewed:

---------------------------------------------------------------------------- */
private ["_result","_error","_module","_data","_async","_missionKey","_saveData", "_indexRev","_indexDoc","_index","_newIndexDoc","_createIndex","_indexArray"];

_logic = _this select 0;
_args = _this select 1;

_module = _args select 0;
_data = _args select 1;
_missionKey  = _args select 2;
_async = _args select 3;

TRACE_3("Saving data", _logic, _args);

_result = "";

// For each record in the store, save the data to a document in the module table, unique key is the mission key + document key

// Save Docs
TRACE_3("Saving Data", _data);
_response = [_logic, "bulkWrite", [_module, _data, _async, _missionKey] ] call ALIVE_fnc_Data;

TRACE_1("", _response);

_result = _response;


// Create/Overwrite Index ==========================

// Create new Index
_indexArray = [];

_createIndex = {
	_indexArray set [count _indexArray, _key];
};
[_data, _createIndex] call CBA_fnc_hashEachPair;

// Create the index doc record
_newIndexDoc = [] call CBA_fnc_hashCreate;
[_newIndexDoc, "_id", _missionKey] call CBA_fnc_hashSet;

// If exists, get revision number so we can overwrite it
_indexRev = [_logic, "indexRev", ""] call CBA_fnc_hashGet;
if (_indexRev != "") then {
	[_newIndexDoc, "_rev", _indexRev] call CBA_fnc_hashSet;
};

[_newIndexDoc, "index", _indexArray] call CBA_fnc_hashSet;

TRACE_1("Save Data new index", _newIndexDoc);
// Write new index
[_logic, "write", [_module, _newIndexDoc, _async, _missionKey]] call ALIVE_fnc_Data;

//=============================================


_result;