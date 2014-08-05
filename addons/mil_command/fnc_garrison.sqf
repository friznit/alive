private ["_waypoints","_id","_unit","_profile","_obj","_leader","_pos","_radius","_positions","_assignments","_profileWaypoint","_savepos","_type","_speed","_formation","_behaviour","_type","_objs"];

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