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
    
waituntil {sleep 0.5; [_profile,"active"] call ALiVE_fnc_HashGet};
sleep 0.3;

_objs = nearestobjects [_pos,["Land_Cargo_Patrol_V1_F","Land_Cargo_Tower_V1_F","Land_Cargo_Tower_V3_F","Land_Cargo_Patrol_V3_F"],_radius];
_units = [_profile,"units"] call ALIVE_fnc_hashGet;
_leader = leader (group (_units select 0));
_units = _units - [_leader];

if ((count _objs > 0) && {count _units > 0} && {_type == "entity"} && {((count (_assignments select 1)) == 0)}) then {
    for "_i" from 0 to (count _objs - 1) do { 
    	_obj = _objs select _i;
    
        switch (typeof _obj) do {
            case ("Land_Cargo_Tower_V3_F") : {_positions = [15,12,8,2,3,7]};
            case ("Land_Cargo_Tower_V1_F") : {_positions = [15,12,8,2,3,7]};
            case ("Land_Cargo_Patrol_V1_F") : {_positions = [1]};
            case ("Land_Cargo_Patrol_V3_F") : {_positions = [1]};
        };
        
        {
            if (_foreachIndex > ((count _units)-1)) exitwith {};

        	_unit = _units select (count _units - _foreachIndex - 1);
            _unit setposATL (_obj buildingpos _x);
            _unit setdir (random 360);
            _unit disableAI "MOVE";
            _units = _units - [_unit];

            sleep 0.03;
        } foreach _positions;
        sleep 0.03;
    };
};

/*
//Workaround until several mil_commands are possible - send rest on patrol
if (count _units > 0) then {
    if (count _waypoints == 0) then {
	for "_i" from 0 to 4 do {
        private ["_pos","_type","_speed","_formation","_behaviour","_profileWaypoint"];
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
                    sleep 0.03;
	};
};
*/