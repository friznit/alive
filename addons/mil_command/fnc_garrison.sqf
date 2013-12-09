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

_objs = nearestobjects [_pos,["Land_Cargo_Patrol_V1_F","Land_Cargo_Tower_V1_F","Land_Cargo_Tower_V3_F","Land_Cargo_Patrol_V3_F","Land_CarService_F"],_radius];

_units = [_profile,"units"] call ALIVE_fnc_hashGet;
_leader = leader (group (_units select 0));
_units = _units - [_leader];

if ((count _objs > 0) && {count _units > 0} && {_type == "entity"} && {((count (_assignments select 1)) == 0)}) then {
    for "_i" from 0 to (count _objs - 1) do { 
    	_obj = _objs select _i;
    
        switch (typeof _obj) do {
            case ("Land_Cargo_Tower_V3_F") : {_positions = [15,12,8]};
            case ("Land_Cargo_Tower_V1_F") : {_positions = [15,12,8]};
            case ("Land_Cargo_Patrol_V1_F") : {_positions = [1]};
            case ("Land_Cargo_Patrol_V3_F") : {_positions = [1]};
            case ("Land_CarService_F") : {_positions = [2,5]};
        };
        
        {
            if (_foreachIndex > ((count _units)-1)) exitwith {};

        	_unit = _units select (count _units - _foreachIndex - 1);
            _unit setposATL (_obj buildingpos _x);
            _unit setdir (([_unit,_obj] call BIS_fnc_DirTo)-180);
            _unit setUnitPos "UP";
            _unit disableAI "MOVE";
            _units = _units - [_unit];

            sleep 0.03;
        } foreach _positions;
        sleep 0.03;
    };
};