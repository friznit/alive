#include <\x\alive\addons\main\script_component.hpp>
SCRIPT(hashSet);

/* ----------------------------------------------------------------------------
Function: ALiVE_fnc_hashSet

Description:
Wrapper for CBA_fnc_hashSet

Parameters:
Array - The hash
String - The key to set value of
Mixed - The value to store

Returns:
Array - The hash

Examples:
(begin example)
_result = [_hash, "key", "value"] call ALiVE_fnc_hashSet;
(end)

See Also:

Author:
ARJay
---------------------------------------------------------------------------- */
private ["_hash","_key","_value","_result"];

_hash = _this select 0;
_key = _this select 1;
_value = _this select 2;

_result = [_hash, _key, _value] call CBA_fnc_hashSet;

_result
