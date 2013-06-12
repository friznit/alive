#include <\x\alive\addons\main\script_component.hpp>
SCRIPT(hashCreate);

/* ----------------------------------------------------------------------------
Function: ALiVE_fnc_hashCreate

Description:
Wrapper for CBA_fnc_hashCreate

Parameters:

Returns:
Array - The new hash

Examples:
(begin example)
_result = [] call ALiVE_fnc_hashCreate;
(end)

See Also:

Author:
ARJay
---------------------------------------------------------------------------- */
private ["_result"];

_result = [] call CBA_fnc_hashCreate;

_result
