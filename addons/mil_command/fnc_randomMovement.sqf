private ["_waypoints","_profile","_pos","_radius","_profileWaypoint","_savepos"];

_profile = _this select 0;
_args = _this select 1;
_debug = true;

_radius = _args;

_pos = [_profile,"position"] call ALiVE_fnc_HashGet;
_waypoints = [_profile,"waypoints",[]] call ALiVE_fnc_HashGet;

if (count _waypoints == 0) then {
	for "_i" from 0 to 4 do {
        			_pos = [_pos,_radius] call CBA_fnc_RandPos;
                    _type = "MOVE";

                    if (_i == 0) then {_savepos = _pos};
                    if (_i == 4) then {_pos = _savepos; _type = "CYCLE"};
                                        
                    _profileWaypoint = [_pos, 50] call ALIVE_fnc_createProfileWaypoint;
                    [_profileWaypoint,"type",_type] call ALIVE_fnc_hashSet;
                    
	                [_profile, "addWaypoint", _profileWaypoint] call ALIVE_fnc_profileEntity;
	};
};