#include <\x\alive\addons\mil_command\script_component.hpp>
SCRIPT(ambientMovement);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_ambientMovement

Description:
Ambient movement command for active profiles

Parameters:
Profile - profile
Args - array

Returns:

Examples:
(begin example)
[_profile, "setActiveCommand", ["ALIVE_fnc_ambientMovement","spawn",200]] call ALIVE_fnc_profileEntity;
(end)

See Also:

Author:
Highhead
---------------------------------------------------------------------------- */

private ["_waypoints","_id","_unit","_profile","_vehiclesInCommandOf","_vehiclesInCargoOf","_obj","_leader","_pos","_radius","_positions","_assignments","_profileWaypoint","_savepos","_type","_speed","_formation","_behaviour","_type","_objs"];

_profile = _this select 0;
_args = _this select 1;
_debug = true;

_radius = _args;

_pos = [_profile,"position"] call ALiVE_fnc_HashGet;
_id = [_profile,"profileID"] call ALiVE_fnc_HashGet;
_waypoints = [_profile,"waypoints",[]] call ALiVE_fnc_HashGet;
_vehiclesInCommandOf = [_profile,"vehiclesInCommandOf",[]] call ALIVE_fnc_HashGet;

_inAir = false;
if (count _vehiclesInCommandOf > 0) then {
	{
		_vehicleProfile = [ALIVE_profileHandler, "getProfile", _x] call ALIVE_fnc_profileHandler;
        
        if !(isnil "_vehicleProfile") then {
			_vehicleObjectType = _vehicleProfile select 2 select 6; //[_profile,"objectType"] call ALIVE_fnc_hashGet;

			if (_vehicleObjectType == "Plane" || {_vehicleObjectType == "Helicopter"}) then {
				_inAir = true;
			};
        };
	} forEach _vehiclesInCommandOf;
};

if (_inAir) exitwith {};

if (count _waypoints == 0) then {
	for "_i" from 0 to 4 do {
        _pos = [_pos,_radius] call CBA_fnc_RandPos;
        _type = "MOVE";
        _speed = "LIMITED";
        _formation = "COLUMN";
        _behaviour = "SAFE";


        if (_i == 0) then {_savepos = _pos};
        if (_i == 4) then {_pos = _savepos; _type = "CYCLE"};

        _profileWaypoint = [_pos, 50] call ALIVE_fnc_createProfileWaypoint;
        [_profileWaypoint,"type",_type] call ALIVE_fnc_hashSet;
        [_profileWaypoint,"speed",_speed] call ALIVE_fnc_hashSet;
        [_profileWaypoint,"formation",_formation] call ALIVE_fnc_hashSet;
        [_profileWaypoint,"behaviour",_behaviour] call ALIVE_fnc_hashSet;
        [_profileWaypoint,"statements",["true","_disableSimulation = true;"]] call ALIVE_fnc_hashSet;

        //_profileWaypoint call ALIVE_fnc_inspectHash;

        [_profile, "addWaypoint", _profileWaypoint] call ALIVE_fnc_profileEntity;
        sleep 0.2;
	};
};
