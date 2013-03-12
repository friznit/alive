/* ----------------------------------------------------------------------------
Function: CBA_fnc_defaultParam

Description:
	Gets a value from parameters list (usually _this) with a default.

Example (direct use of function):
(begin code)
	private "_frog";
	_frog = [_this, 2, 12] call CBA_fnc_defaultParam;
(end code)

Example (macro):
(begin code)
	#include "script_component.hpp"
	DEFAULT_PARAM(2,_frog,12);
(end code)

Parameters:
	_params - Array of parameters, usually _this [Array]
	_index - Parameter index in the params array [Integer: >= 0]
	_defaultValue - Value to use if the array is too short [Any]

Returns:
	Value of parameter [Any]
---------------------------------------------------------------------------- */
#define DEBUG_MODE_NORMAL
#include "script_component.hpp"

SCRIPT(defaultParam);

// -----------------------------------------------------------------------------
PARAMS_3(_params,_index,_defaultValue);

private "_value";

if (not isNil "_defaultValue") then
{
	_value = _defaultValue;
};

if (not isNil "_params") then
{
	if ((typeName _params) == "ARRAY") then
	{
		if ((count _params) > (_index)) then
		{
			if (not isNil { _params select (_index) }) then
			{
				_value = _params select (_index);
			};
		};
	};
};

// Return.
if (isNil "_value") then
{
	nil;
} else {
	_value;
};
