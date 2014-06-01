/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_bulkReadData

Description:
Reads data from an external datasource (couchdb) and coverts to a hash of documents (key/value pairs)

Parameters:
Object - data handler object
Array - Array of module name (string) and then unique identifer (string)

Returns:
Array - Returns a response error or data in the form of key value pairs

Examples:
(begin example)
	[ _logic, [ _module, [_uids] ] ] call ALIVE_fnc_readData;
(end)

Author:
Tupolov
Peer Reviewed:

---------------------------------------------------------------------------- */
#include "script_component.hpp"
SCRIPT(readData_couchdb);

private ["_response","_result","_error","_module","_data","_pairs","_cmd","_json","_logic","_args","_convert","_db","_key"];

// Avoided using the format command as it has a 2kb limt

_logic = _this select 0;
_args = _this select 1;

_error = "parameters provided not valid";
ASSERT_DEFINED("_logic", _err);
ASSERT_OP(typeName _logic, == ,"ARRAY", _err);
ASSERT_DEFINED("_args", _err);
ASSERT_OP(typeName _args, == ,"ARRAY", _err);

// Validate args
_module = _args select 0;
_key = _args select 1;
_uids = _args select 2;

_cmd = format ["SendJSON [""POST"", ""%1/_all_docs?include_docs=true""", _module];

// Add mission key to each doc
{
	private ["_temp"];
	_temp = _key + "-" + _x;
	_uids set [_forEachIndex, _temp];
} foreach _uids;

// Use the index array to create a JSON string of doc ids
_data = ", ""{""keys"":" + str(_uids) + "}""";
_cmd = _cmd + _data;

// Add databaseName
_db = [_logic, "databaseName", "arma3live"] call ALIVE_fnc_hashGet;

// Append cmd with db
_json = _cmd + format[", ""%1""]", _db];

TRACE_1("COUCH BULK READ DATA", _json);

// Send JSON to plugin
_response = [_json] call ALIVE_fnc_sendToPlugIn;

TRACE_1("COUCH RESPONSE", _response);

// From response create key/value pair arrays
if (_response != "ERROR" && _response != "UNAUTHORISED!") then {

	// Now poll data stack until all documents are collected
	_result = [] call ALiVE_fnc_hashCreate;
	_json = format ["pollDataStack [""%1""]", _module];
	While {!isnull _response} do {
		private ["_tempDoc","_id"];
		_response = [_json] call ALIVE_fnc_sendToPlugIn;
		if (!isnull _response) then{
			_tempDoc = [_logic, "restore", [_response]] call ALIVE_fnc_Data;
			_id = [_tempDoc,"_id"] call ALiVE_fnc_hashGet;
			[_result, _tempDoc, _id] call ALiVE_fnc_hashSet;
		};
	};

} else {
	_result = _response;
};
TRACE_2("COUCH BULK READ", _response, _result);

/*
	// Handle data error
	private["_err"];
	_err = format["The Couch database %1 did not respond with %2. The data returned was: %3", _databaseName, typeName _result, _result];
	ERROR_WITH_TITLE(str _logic, _err);
*/

_result;

