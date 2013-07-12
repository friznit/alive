/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_parseJSON

Description:
	Parses a JSON string into a nested array/Hash structure.

	See also: <CBA_fnc_parseJSON>

Parameters:
	_string - JSON formatted string [String].

Returns:
	Data structure taken from the string, or nil if file had syntax errors.

Author:
	Tupolov (from Spooner's original parseJSON CBA function)
---------------------------------------------------------------------------- */

#include "script_component.hpp"

#define ASCII_HASH 35
#define ASCII_LEFT_BRACKET 91
#define ASCII_LEFT_CURLY_BRACKET 123
#define ASCII_RIGHT_BRACKET 93
#define ASCII_RIGHT_CURLY_BRACKET 125
#define ASCII_COMMA 44
#define ASCII_COLON 58
#define ASCII_QUOTES 34

#define JSON_MODE_STRING 0
#define JSON_MODE_ASSOC_KEY 1
#define JSON_MODE_ASSOC_VALUE 2
#define JSON_MODE_ARRAY 3

#define JSON_TYPE_UNKNOWN 0
#define JSON_TYPE_SCALAR 1
#define JSON_TYPE_ARRAY 2
#define JSON_TYPE_ASSOC 3

#define ASCII_JSON_COMMENT ASCII_HASH
#define ASCII_JSON_ASSOC ASCII_COLON
#define ASCII_JSON_ARRAY ASCII_LEFT_BRACKET
#define ASCII_JSON_HASH ASCII_LEFT_CURLY_BRACKET

SCRIPT(parseJSON);

// -----------------------------------------------------------------------------

private "_raiseError";
_raiseError =
{
	PARAMS_4(_message,_JSON,_pos,_lines);

	private ["_errorBlock", "_i", "_lastLine", "_lastChar"];

	_lastLine = _lines select ((count _lines) - 1);
	_lastChar = _lastLine select ((count _lastLine) - 1);
	_lastLine resize ((count _lastLine) - 1);

	PUSH(_lastLine,ASCII_VERTICAL_BAR);
	PUSH(_lastLine,ASCII_HASH);
	PUSH(_lastLine,ASCII_VERTICAL_BAR);
	PUSH(_lastLine,_lastChar);

	_pos = _pos + 1;
	while { _pos < (count _JSON) } do {
		_char = _JSON select _pos;

		if (_char in [ASCII_JSON_COMMENT, ASCII_CR, ASCII_NEWLINE]) exitWith {};

		PUSH(_lastLine,_char);

		_pos = _pos + 1;
	};

	_errorBlock = "";
	for [{ _i = 0 max ((count _lines) - 6) }, { _i < (count _lines)}, { _i = _i + 1 }] do {
		_errorBlock = _errorBlock + format ["\n%1: %2", [_i + 1, 3] call CBA_fnc_formatNumber,
			toString (_lines select _i)];
	};

	_message = format ["%1, in ""%2"" at line %3:\n%4", _message,
		_file, count _lines, _errorBlock];

	ERROR_WITH_TITLE("CBA JSON parser error",_message);
};

private "_parse";
_parse =
{
	PARAMS_4(_JSON,_pos,_indent,_lines);

	private ["_error", "_currentIndent", "_key", "_value", "_return","_mode", "_dataType", "_data","_lineBreaks"];

	_error = false;
	_currentIndent = _indent max 0;
	_key = [];
	_value = [];
	_return = false;
	_mode = JSON_MODE_STRING;
	_dataType = JSON_TYPE_UNKNOWN;
	_lineBreaks = [ASCII_COMMA,ASCII_RIGHT_BRACKET,ASCII_RIGHT_CURLY_BRACKET];
	// _data is initially undefined.

	TRACE_3("Parsing JSON data item",_currentIndent,_pos,count _lines);

	while { (_pos < ((count _JSON) - 1)) and (not _error) and (not _return) } do
	{
		_pos = _pos + 1;
		_char = _JSON select _pos;
		
		if (_char == ASCII_QUOTES) then
		{
			// Skip quotation marks 
			// TRACE_1("FOUND QUOTE, SKIPPING",_char);
			
		} else {
			
			switch (_mode) do
			{
				case JSON_MODE_ARRAY:
				{
					if (_char in _lineBreaks) then
					{
						_value = [toString _value] call CBA_fnc_trim;

						// If remainder of line is blank, assume
						// multi-line data.
						if (([_value] call CBA_fnc_strLen) == 0) then
						{
							private ["_retVal"];

							_retVal = ([_JSON, _pos, _currentIndent, _lines] call _parse);
							_pos = _retVal select 0;
							_value = _retVal select 1;
							_error = _retVal select 2;
						};

						if (not _error) then
						{
							TRACE_1("Added Array element",_value);
							PUSH(_data,_value);
							_mode = JSON_MODE_STRING;
						};
					} else {
						PUSH(_value,_char);
					};
				};
				case JSON_MODE_ASSOC_KEY:
				{
					if (_char in _lineBreaks) then
					{
						["Unexpected new-line, when expecting ':'",
								_JSON, _pos, _lines] call _raiseError;
							_error = true;
					} else {
						switch (_char) do
						{
							case ASCII_JSON_ASSOC:
							{
								_key = [toString _key] call CBA_fnc_trim;
								_mode = JSON_MODE_ASSOC_VALUE;
								TRACE_1("Adding key",_key);
							};
							default
							{
								PUSH(_key,_char);
								//TRACE_1("Adding key",_key);
							};
						};
					};
				};
				case JSON_MODE_ASSOC_VALUE:
				{
					if (_char in _lineBreaks) then
					{
						_value = [toString _value] call CBA_fnc_trim;

						// If remainder of line is blank, assume
						// multi-line data.
						if (([_value] call CBA_fnc_strLen) == 0) then
						{
							private ["_retVal"];

							_retVal = ([_JSON, _pos, _currentIndent, _lines] call _parse);
							_pos = _retVal select 0;
							_value = _retVal select 1;
							_error = _retVal select 2;
						};

						if (not _error) then
						{
							TRACE_1("Added Hash element",_value);
							[_data, _key, _value] call ALIVE_fnc_hashSet;
							_mode = JSON_MODE_STRING;
						};
					} else {
						PUSH(_value,_char);
						//TRACE_1("Adding value",_value);
					};
				};
				case JSON_MODE_STRING:
				{

					switch (_char) do
					{
						case ASCII_JSON_HASH:
						{
							_currentIndent = _currentIndent + 1;
							TRACE_2("Indented",_indent,_currentIndent);
						};
						case ASCII_JSON_ASSOC:
						{
							["Can't start a line with ':'",
								_JSON, _pos, _lines] call _raiseError;
							_error = true;
						};
						case ASCII_JSON_ARRAY:
						{
							TRACE_2("Array element found",_indent,_currentIndent);

							if (_currentIndent > _indent) then
							{
								if (_dataType == JSON_TYPE_UNKNOWN) then
								{
									TRACE_2("Starting new Array",count _lines,_indent);

									_data = [];
									_dataType = JSON_TYPE_ARRAY;

									_indent = _currentIndent;

									_value = [];
									_mode = JSON_MODE_ARRAY;
								} else {
									//TRACE_2("BLAH",_indent,_currentIndent);
									_error = true;
								};
							}
							else{if (_currentIndent < _indent) then
							{
								// Ignore and pass down the stack.
								TRACE_2("End of Array",count _lines,_indent);
								_pos = _pos - 1;
								_return = true;
							} else {
								if (_dataType == JSON_TYPE_ARRAY) then
								{
									TRACE_2("New element of Array",count _lines,_indent);
									_value = [];
									_mode = JSON_MODE_ARRAY;
								} else {
									//TRACE_3("BLEHH",_dataType,_indent,_currentIndent);
									_error = true;
								};
							}; };
						};
						default // Anything else must be the start of an associative key.
						{
							if (_currentIndent > _indent) then
							{
								if (_dataType == JSON_TYPE_UNKNOWN) then
								{
									TRACE_2("Starting new Hash",count _lines,_indent);

									_data = [] call ALIVE_fnc_hashCreate;
									_dataType = JSON_TYPE_ASSOC;

									_indent = _currentIndent;

									_key = [_char];
									_value = [];
									_mode = JSON_MODE_ASSOC_KEY;
								} else {
									//TRACE_3("BLAH",_dataType,_indent,_currentIndent);
									_error = true;
								};
							} else {
								if (_currentIndent < _indent) then
								{
									// Ignore and pass down the stack.
									TRACE_2("End of Hash",count _lines,_indent);
									_pos = _pos - 1;
									_return = true;
								} else {
									if (_dataType == JSON_TYPE_ASSOC) then
									{
										TRACE_2("New element of Hash",count _lines,_indent);
										_key = [_char];
										_value = [];
										_mode = JSON_MODE_ASSOC_KEY;
									} else {
										//TRACE_3("BLEH",_dataType,_indent,_currentIndent);
										_error = true;
									};
								}; 
							};
						};
					};
				};
			};
		};
	};

	TRACE_4("Parsed JSON data item",_indent,_pos,_error,count _lines);

	[_pos, _data, _error]; // Return.
};

// ----------------------------------------------------------------------------

PARAMS_1(_string);

private ["_JSONString", "_JSON", "_outerData", "_lineBreaks"];
_JSONString = _string;
_JSON = toArray _JSONString;

TRACE_2("Parsing JSON string",_string,count _JSON);

_pos = -1;

_retVal = ([_JSON, _pos, -1, [[]]] call _parse);
_pos = _retVal select 0;
_value = _retVal select 1;
_error = _retVal select 2;
TRACE_2("Parsed",_pos,_error);

if (_error) then
{
	nil; // Return.
} else {
	_value; // Return.
};
