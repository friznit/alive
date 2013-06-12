#include <\x\alive\addons\main\script_component.hpp>
SCRIPT(hashGet);

/* ----------------------------------------------------------------------------
Function: ALiVE_fnc_hashGet

Description:
Wrapper for CBA_fnc_hashGet

Parameters:
Array - The hash
String - The key to get value of
Mixed - The default value to return if key not found

Returns:
Mixed - The value

Examples:
(begin example)
// get from hash key
_result = [_hash, "key"] call ALiVE_fnc_hashGet;

// get from hash key with default value
_result = [_hash, "key", "value"] call ALiVE_fnc_hashGet;
(end)

See Also:

Author:
ARJay
---------------------------------------------------------------------------- */
private ["_hash","_key","_default","_result"];

_hash = _this select 0;
_key = _this select 1;

// check for default value
if(count _this > 2) then {
	_default = _this select 2;
	if([_hash, _key] call CBA_fnc_hashHasKey) then {
		_result = [_hash, _key] call CBA_fnc_hashGet;
	}else{
		_result = _default;
	};
}else{
	_result = [_hash, _key] call CBA_fnc_hashGet;
};

_result