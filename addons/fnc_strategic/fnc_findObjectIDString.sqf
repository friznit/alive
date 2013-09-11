//#define DEBUG_MODE_FULL
#include <\x\alive\addons\fnc_strategic\script_component.hpp>
SCRIPT(findObjectIDString);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_findObjectIDString

Description:
Returns the Visitor object ID of a map placed object in string format

Parameters:
Object - A map placed object

Returns:
Scalar - Returns the master list

Examples:
(begin example)
// 388c2080# 88544: helipadsquare_f.p3d
_id = _helipad call ALIVE_fnc_findObjectIDString
// returns "88544"
(end)

See Also:
- <ALIVE_fnc_cluster>

Author:
Wolffy.au
Peer Review:
nil
---------------------------------------------------------------------------- */

private ["_tmp","_result"];

TRACE_1("findObjectIDString - input",_this);

// 388c2080# 88544: helipadsquare_f.p3d
_tmp = [_this, 0, objNull, [objNull]] call BIS_fnc_param;

_result = [str _tmp, "# "] call CBA_fnc_split;
if(count _result > 1) then {
	_result = [_result select 1, ": "] call CBA_fnc_split;
	_result = _result select 0;
} else {
	_result = typeOf _tmp;
};

TRACE_1("findObjectIDString - output",_result);
_result;