/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_restoreData

Description:
Converts Couchdb type strings back into ARMA2 data types, map objects, and created vehicles

Parameters:
Object - datahandler object
String - JSON formatted string

Returns:
Array - key/value pairs

Examples:
(begin example)
// An array of different data types
_result = "ARRAY:[""BOOL:1"",""SCALAR:123.456"",""SIDE:GUER""]" call ALIVE_fnc_restoreData
// returns [true, 123.456, resistance]
(end)

Author:
Tupolov
Wolffy.au
Peer Reviewed:

---------------------------------------------------------------------------- */
#include "script_component.hpp"	
SCRIPT(restoreData_couchdb);

private ["_result","_key","_logic","_input","_hash","_restore"];

_logic = _this select 0;
_input = _this select 1;

_input = _input select 0;

_result = [];

// Convert string to Hash
_hash = [_input] call ALIVE_fnc_parseJSON;
TRACE_1("RESTORE DATA", _hash);

// Restore Data types in hash

// for each pair, process key and value
_restore = {
	
	private ["_type","_data","_tmp"];
	
	_type = [ALIVE_DataDictionary, "getDataDictionary", [_key]] call ALIVE_fnc_Data;
	if (isNil "_type") then {
		_type = "STRING";
	};
	
	TRACE_3("COUCH RESTORE KEY/DATA", _key, _value, _type);

	// Address each data type accordingly
	switch(_type) do {
			case "STRING": {
					_data = _value;
			};
			case "TEXT": {
					_data = text _value;
			};
			case "BOOL": {
					private["_tmp"];
					_tmp = if(parseNumber _value == 0) then {false} else {true};
					_data = _tmp;
			};
			case "SCALAR": {
					_data = parseNumber _value;
			};
			case "SIDE": {
					_data = switch(_value) do {
							case "WEST": {west;};
							case "EAST": {east;};
							case "GUER": {resistance;};
							case "CIV": {civilian;};
							case "LOGIC": {sideLogic;};
					};
			};
			case "ARRAY": {
					private["_tmp"];
					_value = [_value, "any", "nil"] call CBA_fnc_replace;
					_tmp = call compile _value;
					_data = [];
					{
							_data set [count _data, [_logic, "restore", _x] call ALIVE_fnc_Data];
					} forEach _tmp;
			};
			default {
				_data = _value;
			};
	};
	_tmp = [_key,_data];
	_result set [count _result, _tmp];
}; 

[_hash, _restore] call CBA_fnc_hashEachPair;

_result;

