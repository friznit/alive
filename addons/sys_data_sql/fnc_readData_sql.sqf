/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_readData

Description:
Reads data from an external datasource (SQL, JSON, Text File)

Parameters:
String - Database name
String - Module name 
Array - Array of key/value unique identifiers

Returns:
String - Returns a response error

Examples:
(begin example)
	
(end)

Author:
Tupolov
Peer Reviewed:

---------------------------------------------------------------------------- */
#include <script_macros_core.hpp>
SCRIPT(readData);

private ["_response","_module","_params"];

// Read data from a data source
// Function is expecting the module name (preferably matching table name for db access) and the key/value pairs where the key would be the column id for a DB to identify the data required
// Values should be in string form (use the convertData function)
// Call to external datasource uses an arma2net plugin call
// For SQL this is a SELECT command followed by the filters
// Outgoing calls to callExtension have a check to ensure they do not exceed 16kb
// Avoided using the format command as it has a 2kb limt

PARAMS_3(_databaseName, _module, _params);

TRACE_3("ReadData SQL -", [_params] call CBA_fnc_strLen, _params, typeName _params);

//validate params?

private ["_uid","_cmd","_sql"];
			
_uid = "";

// Build the SQL command
_cmd = format ["Arma2NETMySQLCommand ['%1', 'SELECT * FROM %2 WHERE ", _databaseName, _module];
{
	_uid = _uid + (_x select 0) + "=" + (_x select 1) + " AND ";
} foreach _params;
_sql = _cmd + _uid + "']";

// Get rid of any ,) in the string
_sql = [_sql, "AND ']", "']"] call CBA_fnc_replace;

// Send the SQL command to the plugin
_response = [_sql] call ALIVE_fnc_sendToPlugIn;

if (typeName _response == "ARRAY") then {
	_result = [_response select 0] call ALIVE_fnc_restoreData_sql;
} else {
	
};
_result;