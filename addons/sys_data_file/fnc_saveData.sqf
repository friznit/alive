#include "script_component.hpp"
SCRIPT(saveData_couchdb);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_saveData_couchdb

Description:
Saves multiple records to a table

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

// For each record in the store, save the data to a mission module file, unique key is the record key

// Create mission module file
_filedetails = [] call alive_fnc_hashcreate;
[_filedetails, "module", _module] call alive_fnc_hashset;
[_filedetails, "mission", missionName] call alive_fnc_hashset;
[_filedetails, "key", _missionkey] call alive_fnc_hashset;

// Open file
[_logic, "write", [_module, "{ 'filedetails': ", _async, _missionkey, true] ] call ALIVE_fnc_Data;

// Store file details
[_logic, "write", [_module, _filedetails, _async, _missionkey, false] ] call ALIVE_fnc_Data;

// Open data
[_logic, "write", [_module, ",'data':{", _async, _missionkey, false] ] call ALIVE_fnc_Data;

_saveData = {
	private ["_documentID","_response"];

	TRACE_3("Saving Data", _key, _value);

	_response = [_logic, "write", [_module, _value, _async, _key] ] call ALIVE_fnc_Data;

	_result = _result + "," + _response;
};

// For each hash, write to File
[_data, _saveData] call CBA_fnc_hashEachPair;

// Close Data
[_logic, "write", [_module, "}", _async, _missionkey, false] ] call ALIVE_fnc_Data;

// Close File
[_logic, "write", [_module, "}", _async, _missionkey, false] ] call ALIVE_fnc_Data;
//=============================================


_result;