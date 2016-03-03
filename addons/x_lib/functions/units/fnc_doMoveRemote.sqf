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

_unit = [_this, 0, objNull, [objNull]] call BIS_fnc_param;
_pos = [_this, 1, [], [[]]] call bis_fnc_param;

if (!(alive _unit) || {count _pos < 2}) exitwith {diag_log "domoveRemote failed - dead/empty unit"};

//Flag for usage with ALiVE_fnc_unitReadyRemote
_unit setvariable [QGVAR(MOVEDESTINATION),_pos];

if (local _unit) exitwith {
	_unit doMove _pos;
};

//if !local send to server to distribute
if !(isServer) then {
    [_this,"ALiVE_fnc_doMoveRemote",false,false,true] call BIS_fnc_MP;
} else {
    [_this,"ALiVE_fnc_doMoveRemote",owner _unit,false,true] call BIS_fnc_MP;
};
