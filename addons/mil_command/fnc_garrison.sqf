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

private ["_waypoints","_id","_unit","_profile","_obj","_leader","_pos","_radius","_positions","_assignments","_group"];

_profile = _this select 0;
_args = _this select 1;
_debug = true;

_radius = _args;

_pos = [_profile,"position"] call ALiVE_fnc_HashGet;
_id = [_profile,"profileID"] call ALiVE_fnc_HashGet;
_type = [_profile,"type"] call ALiVE_fnc_HashGet;
_waypoints = [_profile,"waypoints",[]] call ALiVE_fnc_HashGet;
_assignments = [_profile,"vehicleAssignments"] call ALIVE_fnc_hashGet;

if (isnil "_pos") exitwith {};

[_profile,70] call ALiVE_fnc_ambientMovement;

waituntil {sleep 0.5; [_profile,"active"] call ALiVE_fnc_HashGet};
sleep 0.3;

if (_type == "entity" && ((count (_assignments select 1)) == 0)) then {

    _group = _profile select 2 select 13;

    [_group,_pos,200,true] call ALIVE_fnc_groupGarrison;

};