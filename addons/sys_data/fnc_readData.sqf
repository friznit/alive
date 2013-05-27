/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_readData

Description:
Reads data from an external datasource (SQL, JSON, Text File)

Parameters:
String - Module name 
Array - Array of key/value unique identifiers

Returns:
String - Returns a response error

Examples:
(begin example)
	[ _module, [ [key,value],[key,value],[key,value] ] ] call ALIVE_fnc_readData;
(end)

Author:
Tupolov
Peer Reviewed:
Wolffy.au 24 Oct 2012
---------------------------------------------------------------------------- */
#include <script_macros_core.hpp>
SCRIPT(writeData);

private ["_debug","_response","_module","_params"];
_debug = false;

// Read data from a data source
// Function is expecting the module name (preferably matching table name for db access) and the key/value pairs where the key would be the column id for a DB or the attribute to a JSON object that identify the data required
// Values should be in string form (use the convertData function)
// Call to external datasource uses an arma2net plugin call
// For SQL this is a SELECT command followed by the filters
// Outgoing calls to callExtension have a check to ensure they do not exceed 16kb
// Avoided using the format command as it has a 2kb limt

PARAMS_2(_datasource, _module, _params);

if (_debug) then {
    format["ReadData - Len:%1 Params:(%3)  Type:%2", [_params] call CBA_fnc_strLen, _params, typeName _params] call ALIVE_fnc_logger;
};

// _datasource = SQL|JSON|TEXT|MEMORY

switch(_datasource) do {
        case "SQL": {
			private ["_uid","_cmd","_sql"];
			
			_uid = "";

			// Build the SQL command
			_cmd = format ["Arma2NETMySQLCommand ['%1', 'SELECT * FROM %2 WHERE ", SQL_DATABASE_NAME, _module];
			{
				_uid = _uid + (_x select 0) + "=" + (_x select 1) + " AND ";
			} foreach _params;
			_sql = _cmd + _uid + "']";

			// Get rid of any ,) in the string
			_sql = [_sql, "AND ']", "']"] call CBA_fnc_replace;
			
			// Send the SQL command to the plugin
			_response = [_sql] call ALIVE_fnc_sendToPlugIn;
		};
		
		case "JSON": {
			private ["_pairs","_cmd","_json"];
		
			_pairs = "";
			// Build the JSON command
			//_cmd = format ["GetJSON ['%1', '%2'", JSON_URL, _module];
			
			_cmd = format ["SendJSON [""POST"", ""%1""", _module];
			{
				_pairs = _pairs + "'" + (_x select 0) + "'" + ":" + "'" + (_x select 1) + "'" + ","; // each key/value needs to be wrapped in quotes, not sure how to do this
			} foreach _params;
			_json = _cmd + ", '{" + _pairs + "}']";
			
			// Get rid of any left over commas
			_json = [_json, ",}", "}"] call CBA_fnc_replace;
			
			// Send JSON to plugin
			_response = [_json] call ALIVE_fnc_sendToPlugIn;
		}
};

_response;