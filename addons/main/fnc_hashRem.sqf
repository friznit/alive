#include <\x\alive\addons\main\script_component.hpp>
SCRIPT(hashRem);

/* ----------------------------------------------------------------------------
Function: ALiVE_fnc_hashRem

Description:
Wrapper for CBA_fnc_hashRem

Parameters:
Array - The hash
String - The key to remove

Returns:

Examples:
(begin example)
_result = [_hash, "key"] call ALiVE_fnc_hashRem;
(end)

See Also:

Author:
ARJay
---------------------------------------------------------------------------- */
private ["_hash","_key","_result"];

_hash = _this select 0;
_key = _this select 1;

_result = [_hash, _key] call CBA_fnc_hashRem;

_result
