private ["_waypoints","_profile","_pos","_radius","_profileWaypoint","_savepos","_type","_speed","_formation","_behaviour"];

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
                    
	                [_profile, "addWaypoint", _profileWaypoint] call ALIVE_fnc_profileEntity;
                    sleep 0.2;
	};
};