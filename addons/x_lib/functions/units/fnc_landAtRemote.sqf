#include <\x\alive\addons\x_lib\script_component.hpp>
SCRIPT(landAtRemote);

/* ----------------------------------------------------------------------------
Function: ALiVE_fnc_landAtRemote

Description:
Executes landAt on the units remote location automatically

Parameters:
Object - Given unit
Array - position

Returns:
Nothing

Examples:
[_unit, _pos] call ALiVE_fnc_landAtRemote;

See Also:
-

Author:
Highhead
---------------------------------------------------------------------------- */

private ["_unit","_args"];

_unit = [_this, 0, objNull, [objNull]] call BIS_fnc_param;
_args = [_this, 1, 1, [-1]] call bis_fnc_param;

if !(alive _unit) exitwith {diag_log "landAtRemote failed - dead/empty unit"};

//Flag for usage with ALiVE_fnc_unitReadyRemote
_unit setvariable [QGVAR(MOVEDESTINATION),getpos _unit];

if (local _unit) exitwith {
	_unit landAt _args;
};

//if !local send to server to distribute
if !(isServer) then {
    [_this,"ALiVE_fnc_landAtRemote",false,false,true] call BIS_fnc_MP;
} else {
    [_this,"ALiVE_fnc_landAtRemote",owner _unit,false,true] call BIS_fnc_MP;
};
