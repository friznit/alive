#include <\x\alive\addons\x_lib\script_component.hpp>
SCRIPT(doMoveRemote);

/* ----------------------------------------------------------------------------
Function: ALiVE_fnc_doMoveRemote

Description:
Executes doMove on the units remote location automatically

Parameters:
Object - Given unit
Array - position

Returns:
Nothing

Examples:
[_unit, _pos] call ALiVE_fnc_doMoveRemote;

See Also:
-

Author:
Highhead
---------------------------------------------------------------------------- */

private ["_unit","_pos"];

_unit = _this select 0;
_pos = _this select 1;

if (local _unit) exitwith {
	_unit doMove _pos;
};

//if !local send to server to distribute
if !(isServer) then {
    [_this,"ALiVE_fnc_doMoveRemote",false,false] spawn BIS_fnc_MP;
} else {
    [_this,"ALiVE_fnc_doMoveRemote",owner _unit,false] spawn BIS_fnc_MP;
};

