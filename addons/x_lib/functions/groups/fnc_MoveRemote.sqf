#include <\x\alive\addons\x_lib\script_component.hpp>
SCRIPT(MoveRemote);

/* ----------------------------------------------------------------------------
Function: ALiVE_fnc_MoveRemote

Description:
Executes Move on a groups remote location automatically

Parameters:
Group - Given group
Array - position

Returns:
Nothing

Examples:
[_group, _pos] call ALiVE_fnc_MoveRemote;

See Also:
-

Author:
Highhead
---------------------------------------------------------------------------- */

private ["_group","_pos"];

_group = _this select 0;
_pos = _this select 1;

//Flag group with destination
_group setvariable [QGVAR(MOVEDESTINATION),_pos];

if (local _group) exitwith {
	_group move _pos;
};

//if !local send to server to distribute
if !(isServer) then {
    [_this,"ALiVE_fnc_MoveRemote",false,false] spawn BIS_fnc_MP;
} else {
    [_this,"ALiVE_fnc_MoveRemote",owner _group,false] spawn BIS_fnc_MP;
};

