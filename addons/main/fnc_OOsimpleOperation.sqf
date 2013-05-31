#include <\x\alive\addons\main\script_component.hpp>
SCRIPT(OOsimpleOperation);

/* ----------------------------------------------------------------------------
Function: ALiVE_fnc_OOsimpleOperation

Description:
Provides simple set/get code for objects

Parameters:
Object - Reference an existing instance.
String - The selected function operation
Any - The selected parameter(s)
Any - Default value
Array - List of valid values (optional)

Returns:
Any - Returns the validated value

Examples:
(begin example)
_result = [
	_logic,
	_operation,
	_args,
	"SYM",
	["ASYM","SYM"]
] call ALIVE_fnc_OOsimpleOperation;
(end)

Author:
Wolffy.au
Peer Reviewed:
nil
---------------------------------------------------------------------------- */

private ["_logic","_operation","_args","_default","_choices"];
PARAMS_4(_logic,_operation,_args,_default);
DEFAULT_PARAM(4,_choices,[]);

_limited = false;

// are the option choices empty?
if(typeName _choices == "ARRAY" &&
	{count _choices > 0}) then {
	_limited = true;
};

// is _args objNull (default)?
// is _args the right typeName?
if(
	(typeName _args == "OBJECT" && {isNull _args}) ||
	{typeName _args != typeName _default}
) then {
	// if so, grab the default value
	_args = _logic getVariable [_operation, _default];
};

if(_limited) then {
	// check if _args is one of the choices
	// otherwise default
	if(!(_args in _choices)) then {_args = _default;};
};

// set final value
_logic setVariable [_operation, _args];

// if debug enabled, log message
if (_logic getVariable ["debug", false]) then {
	diag_log PFORMAT_2(_fnc_scriptNameParent,_operation,_args);
};

// return value
_args;
