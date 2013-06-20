#include <\x\alive\addons\sys_debug\script_component.hpp>
SCRIPT(inspectHash);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_inspectHash

Description:
Inspect an hash to the RPT

Parameters:

Returns:

Examples:
(begin example)
// inspect config class
[_hash] call ALIVE_fnc_inspectHash;
(end)

See Also:

Author:
ARJay
---------------------------------------------------------------------------- */

private ["_target","_text","_key","_value"];
	
_target = _this;

_text = " ------------------ Inspecting Hash -------------------- ";
[_text] call ALIVE_fnc_dump;
{
	_key = _x;
	_value = [_target,_key] call ALIVE_fnc_hashGet;
	["k: %1 v: %2",_key,_value] call ALIVE_fnc_dump;
} forEach (_target select 1);

_text = " ------------------ Inspection Complete -------------------- ";
[_text] call ALIVE_fnc_dump;