#include "script_component.hpp"	
SCRIPT(writeData_couchdb);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_writeData_couchdb

Description:
Writes data to an external couchdb (using JSON string)

Parameters:
Object - Data handler logic 
Array - Module (string), Data (array), Async (bool), UID (string)

Returns:
String - Returns a response error or confirmation of write

Examples:
(begin example)
	[ _logic, [ _module, [[key,value],[key,value],[key,value]], _async, _uid ] ] call ALIVE_fnc_writeData;
(end)

Author:
Tupolov
Peer Reviewed:

---------------------------------------------------------------------------- */
private ["_response","_result","_error","_module","_data","_uid","_async","_pairs","_cmd","_json","_logic","_args","_convert","_db"];

_logic = _this select 0;
_args = _this select 1;

// Write data to a data source
// Function is expecting the module name (preferably matching table name for db access) and the key/value pairs where the key would be the column id for a DB or the attribute to a JSON object
// Values should be in string form (use the convertData function)
// Call to external datasource uses an arma2net plugin call
// For SQL this is an INSERT command followed by the column ids and values
// Outgoing calls to callExtension have a check to ensure they do not exceed 16kb
// Avoided using the format command as it has a 2kb limt

// Validate params passed to function

_error = "parameters provided not valid";
ASSERT_DEFINED("_logic", _err);
ASSERT_OP(typeName _logic, == ,"ARRAY", _err);
ASSERT_DEFINED("_args", _err);
ASSERT_OP(typeName _args, == ,"ARRAY", _err);

// Validate args
_module = _args select 0;
_data = _args select 1;

if (count _args > 2) then {
	_async = _args select 2;
} else {
	_async = false;
	_uid = "";
};

if (count _args > 3) then {
	_uid = _args select 3;
	_module = format ["%1/%2", _module, _uid];
};
	
// From data passed create couchDB string

_pairs = "";
_cmd = "";
_json = "";

// Build the JSON command
//_cmd = format ["SendJSON ['POST', '%1', '%2', '%3'", _module, _data, _databaseName];
// ["SendJSON ['POST', 'events', '{key:value,key:value}', 'arma3live']; 

if (!_async) then {
	_cmd = format ["SendJSON [""POST"", ""%1""", _module];
} else {
	_cmd = format ["SendJSONAsync [""POST"", ""%1""", _module];
};

// Create key/value pairs from data
{
	private ["_value","_key","_prefix","_suffix"];
	_key = _x select 0;
	_value = _x select 1;
	
	if (isNil "_value") then {
		_value = "UNKNOWN";
	};
	
	// Convert Values
	
	// Array values need to be nested in array [] brackets
	if (typeName _value == "ARRAY") then {
		_prefix = "[";
		_suffix = "]";
	} else {
		_prefix = " ";
		_suffix = " ";
	};
	
	// Add key and value type to data dictionary
	[ALIVE_DataDictionary, "setDataDictionary", [_key, typeName _value]] call ALIVE_fnc_Data;
	
	// Convert value to string
	_value = [_logic, "convert", [_value]] call ALIVE_fnc_Data;
	
	TRACE_2("SYS DATA VALUE CONVERSION", typename _value, _value);

	// Create key/value pairs
	_pairs = _pairs + """" +  str(_key) + """:" + _prefix + _value + _suffix + ",";
} foreach _data;

_json = _cmd + ", ""{" + _pairs + "}""";

// Get rid of any left over commas
_json = [_json, ",}", "}"] call CBA_fnc_replace; 
_json = [_json, ",]", "]"] call CBA_fnc_replace; 

// Add databaseName
_db = [_logic, "databaseName", "arma3live"] call ALIVE_fnc_hashGet;

// Append cmd with db
_json = _json + format[", ""%1""]", _db];

TRACE_1("COUCH WRITE DATA", _json);

// Send JSON to plugin
if (!_async) then {
	_response = [_json] call ALIVE_fnc_sendToPlugIn; // if you need a returned UID then you have to go with synchronous op
} else {
	_response = [_json] call ALIVE_fnc_sendToPlugInAsync; //SendJSON is an async addin function so does not return a response until asked for a second time.
};

// Need to send the response to restore function
// Then handle response for couch

/*
// Handle result of write
if (typeName _response == "ARRAY") then {
	_result = _response select 0;
} else {
	// Handle data error
	private["_err"];
	_err = format["The Couch database %1 did not respond with %2. The data returned was: %3", _databaseName, typeName _result, _result];
	ERROR_WITH_TITLE(str _logic, _err);
};*/

// Get UID of written record and add to result

_response;