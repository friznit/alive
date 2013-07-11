/* ----------------------------------------------------------------------------
Function: ALIVE_sys_data_couchdb_fnc_convertData

Description:
Converts ARMA2 data types into CouchDB key/value (JSON) strings

Parameters:
Any - String, Bool, Array, Side, Scalar, Object

Returns:
String - Returns Couchdb value (key/value if an array)

Examples:
(begin example)
// A string data type
_result = "This is a test" call ALIVE_fnc_convertData
// returns string "STRING:This is a test"

// A numerical data type
_result = 123.456 call ALIVE_fnc_convertData
// returns string "SCALAR:123.456"

// An array of different data types
_result = [true, 123.456, resistance] call ALIVE_fnc_convertData
// returns string "ARRAY:[""BOOL:1"",""SCALAR:123.456"",""SIDE:GUER""]"

(end)

Author:
Tupolov
Wolffy.au
Peer Reviewed:

---------------------------------------------------------------------------- */
#include "script_component.hpp"	
SCRIPT(convertData_couchdb);

private ["_result","_convert","_logic","_data","_input"];

_logic = _this select 0;
_input = _this select 1;

_data = _input select 0;
_result = nil;

if(isNil "_data") exitWith {
	"ConvertData <null> type" call ALIVE_fnc_logger;
};

TRACE_2("ConvertData ", typeName _data, _data);

if (typeName _data == "OBJECT") then {
	_data = str(_data);
};

switch(typeName _data) do {
	case "SCALAR": {
		_result = str(_data);
	};
	case "BOOL": {
		private["_tmp"];
		_tmp = if(_data) then {"true"} else {"false"};
		_result = format["""""%1""""", _tmp]; // double quotes around string
	};
	case "SIDE": {
		_result = format["""""%1""""", _data]; // double quotes around string
	};
	case "ARRAY": {
		private ["_pairs"];
		_pairs = "";
		TRACE_2("ARRAY CONVERSION DATA", _data, typeName _data);
		{
			private ["_value","_key","_prefix","_suffix"];
			
			TRACE_2("ARRAY CONVERSION X", _x, typeName _x);
			
			if (typeName (_x select 0) == "STRING") then { // This is a key value pair
				_key = _x select 0;
				TRACE_2("ARRAY CONVERSION KEY: ", typename _key, _key);
				
				_value = _x select 1;
				TRACE_2("ARRAY CONVERSION VALUE", typename _value, _value);
				
				// Convert Values
				
				// Array values need to be nested in array [] brackets
				if (typeName _value == "ARRAY") then {
					_prefix = "[";
					_suffix = "]";
				} else {
					if (isNil "_value") then {
						_value = "UNKNOWN";
					};
					_prefix = "";
					_suffix = "";
				};
				
				_value = [_logic, "convert", [_value]] call ALIVE_fnc_Data;
				TRACE_2("ARRAY CONVERTED VALUE", typename _value, _value);

				// Create key/value pairs
				_pairs = _pairs + """" +  str(_key) + """:" + _prefix + _value + _suffix + ",";
				if (true) exitWith {TRACE_2("ARRAY CONVERSION PAIR", typename _pairs, _pairs);};
			} else { // most likely another array of values
				private ["_tmp"];
				TRACE_2("NESTED ARRAY CONVERSION", typename _x, _x);
				_prefix = "{";
				_suffix = "}";
				_tmp = [_logic, "convert", [_x]] call ALIVE_fnc_Data;
				TRACE_2("NESTED ARRAY CONVERSION TMP", typename _tmp, _tmp);
				_pairs = _pairs + _prefix + _tmp + _suffix + ",";
				TRACE_2("NESTED ARRAY CONVERSION PAIR", typename _pairs, _pairs)
			};		
		} foreach _data;
		
		_result = _pairs;

		// Get rid of any left over commas
		_result = [_result, ",}", "}"] call CBA_fnc_replace;
		TRACE_2("ARRAY CONVERSION RESULT", typename _result, _result);
	};
	default {
		if ([_data] call CBA_fnc_strLen == 0) then {
			_data = "UNKNOWN";
		};
		_result = format["""""%1""""", _data]; // double quotes around string
	};
};

_result;
