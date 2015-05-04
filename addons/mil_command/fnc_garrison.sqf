#include <\x\alive\addons\mil_command\script_component.hpp>
SCRIPT(garrison);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_garrison

Description:
Garrison command for active units, run on spawn of profiles for guarding of objectives via placement modules

Parameters:
Profile - profile
Args - array

Returns:

Examples:
(begin example)
[_profile, "setActiveCommand", ["ALIVE_fnc_garrison","spawn",200]] call ALIVE_fnc_profileEntity;
(end)

See Also:

Author:
Highhead
---------------------------------------------------------------------------- */

private ["_type","_unit","_profile","_pos","_radius","_assignments","_group"];

_profile = [_this, 0, ["",[],[],nil], [[]]] call BIS_fnc_param;
_radius = [_this, 1, 200, [-1]] call BIS_fnc_param;

_pos = [_profile,"position"] call ALiVE_fnc_HashGet;
_type = [_profile,"type",""] call ALiVE_fnc_HashGet;
_assignments = [_profile,"vehicleAssignments",["",[],[],nil]] call ALIVE_fnc_HashGet;

if (isnil "_pos") exitwith {};

[_profile,_radius/3] call ALiVE_fnc_ambientMovement;

waituntil {sleep 0.5; [_profile,"active"] call ALiVE_fnc_HashGet};
sleep 0.3;

if (_type == "entity" && {count (_assignments select 1) == 0}) then {

    _group = _profile select 2 select 13;

    [_group,_pos,_radius,true] call ALIVE_fnc_groupGarrison;

};