private ["_locations","_pos","_size"];

_convoyLocs= [];
 _locations = nearestLocations [getArray (configFile >> "CfgWorlds" >> worldName >> "centerPosition"), ["StrongPointArea","Strategic","CityCenter","FlatAreaCity","Airport","NameCity","NameCityCapital","NameVillage","NameMarine","BorderCrossing"],30000];
 diag_log ["Locations: %1", _locations];
{
   _pos = position _x;
   _size = size _x;
                                           
   if (_size select 0 > _size select 1) then {_size = _size select 0} else {_size = _size select 1};
      _convoyLocs set [count _convoyLocs,[_pos,_size]];
} foreach _locations;

 diag_log ["_convoyLocs: %1", _convoyLocs];
 _count = (count _convoyLocs);
  diag_log ["_count: %1", _count];

/*{
if (count _convoyLocs == 0) exitwith {
	diag_log ["ALiVE-%1 Convoy: Exiting due to lack of destinations near roads.", time];
};*/
// Set the number of convoys
_convoynumber = CONVOY_intensity;
 diag_log format["_convoynumber: %1", _convoynumber];
if (_convoynumber > count _convoyLocs) then {
	_convoynumber = count _convoyLocs;
};
if (isNil "convoy_safearea") then {convoy_safearea = 2000;};

for "_j" from 1 to _convoynumber do {
	
        [_j, _convoyLocs, CONVOY_GLOBALDEBUG] spawn {
                private ["_timeout","_startpos","_destpos","_destroada","_destroad","_endpos","_endroad","_grp","_front","_facs","_wp","_j","_convoyLocs","_debug","_sleep","_type","_starttime"];
                _j = _this select 0;
                _convoyLocs = _this select 1;
                _debug = _this select 2;
                
                waituntil {!(isnil "OPCOM_INSTANCES") && {[OPCOM_INSTANCES select 0,"startupComplete",false] call ALiVE_fnc_HashGet}};
				waituntil {sleep 2; _convoyLocs = [factionsConvoy,"idle"] call ALiVE_fnc_OPCOMpositions; ["Convoy faction %1 is waiting for positions...",factionsConvoy] call ALiVE_fnc_DumpR; count _convoyLocs > 2};
                
				if (count _convoyLocs < 2) exitwith {["No convoy locs found for faction %1",factionsConvoy] call ALiVE_fnc_DumpR};
                
                _timeout = if(_debug) then {[30, 30, 30];} else {[30, 120, 300];};
                
				while{CONVOY_intensity > 0} do {
                        //ALIVEPROFILERSTART("Convoys")
						private ["_swag","_leader","_dir","_startroad","_list","_startroada"];
						// Select a start position outside of player safe zone and not near base
						while { 
                            _startroada = _convoyLocs call BIS_fnc_selectRandom;
                            diag_log format["_startroada: %1", _startroada];
							_list = (_startroada nearRoads 500);
                             diag_log format["_list: %1", _list];
                           _startroad = _list select (round random (count _list));
                            diag_log format["_startroad: %1", _startroad];
                            _pos = position _startroad;
                            diag_log format["_pos: %1", _pos];
							[position _startroad] call ALIVE_fnc_intrigger;
						} do {};
                        _convoyLocs = _convoyLocs - [_startroada];
						_startpos =  position _startroad; 
                        
                        _destroada = _convoyLocs call BIS_fnc_selectRandom;
                        _convoyLocs = _convoyLocs - [_destroada];
                        _list = (_destroada nearRoads 500);
                        _destroad = _list select (round random (count _list));

                        _destpos = position _destroad;
                        
                        diag_log format["_destpos: %1", _destpos];
                        _endroada = _convoyLocs call BIS_fnc_selectRandom;
                        _convoyLocs = _convoyLocs - [_endroada];
                        _list = (_endroada nearRoads 500);
                        _endroad = _list select (round random (count _list));
                          diag_log format["_endroad: %1", _endroad];
                        _endpos = position _endroad;
                         diag_log format["_endpos: %1", _endpos];
						
						if (CONVOY_GLOBALDEBUG) then {
							private ["_t","_c"];
							_t = format["convoy_%1", floor(random 10000)];
							_c = format["convoy_%1", floor(random 10000)];
							[_c, _startpos, "Icon", [1,1], "TYPE:", "mil_start", "TEXT:", _t,"GLOBAL"] call CBA_fnc_createMarker;
							_c = format["convoy_%1", floor(random 10000)];
							[_c, _destpos, "Icon", [1,1], "TYPE:", "mil_pickup", "TEXT:", _t,"GLOBAL"] call CBA_fnc_createMarker;
							_c = format["convoy_%1", floor(random 10000)];
							[_c, _endpos, "Icon", [1,1], "TYPE:", "mil_end", "TEXT:", _t,"GLOBAL"] call CBA_fnc_createMarker;
						};
						
                        _grp = nil;
                        _front = "";
                        while{isNil "_grp"} do {
                                _front = [["Motorized","Mechanized","Armored"],[16,4,1]] call ALIVE_fnc_selectRandom;
                                _facs = factionsConvoy;
                                 diag_log format["_facs: %1", _facs];
                                _grp = [_startpos, _front, _facs] call ALIVE_fnc_randomGroup;
                        };
                                                
						// Set direction so pointing towards destination
						_dir = getdir _startroad;
						
						_leader = leader _grp;
						_leader setdir _dir;
						_grp setFormation "FILE";
						
                        switch(_front) do {
                                case "Motorized": {
                                        for "_i" from 0 to (1 + floor(random 2)) do {
										private "_veh";
											_veh = [_startpos, _dir, _grp] call ALIVE_fnc_AddVehicle;
                                        };
                                };
                                case "Mechanized": {
                                        for "_i" from 0 to (1 + floor(random 2)) do {
											private "_veh";
											_veh = [_startpos, _dir, _grp] call ALIVE_fnc_AddVehicle;
                                        };
	                                    if(random 1 > 0.66) then {
											private "_veh";
											_veh = [_startpos, _dir, _grp] call ALIVE_fnc_AddVehicle;
										};
                                };
                                case "Armored": {
                                        for "_i" from 0 to (1 + floor(random 2)) do {
											private "_veh";
											_veh = [_startpos, _dir, _grp] call ALIVE_fnc_AddVehicle;
                                        };
                                        if(random 1 > 0.33) then {
											private "_veh";
											_veh = [_startpos, _dir, _grp] call ALIVE_fnc_AddVehicle;
										};
                                };
                        };
                        
						// Add some trucks!
						if(random 1 > 0.25) then {
							for "_i" from 0 to (1 + ceil(random 2)) do {
								private "_veh";
								_veh = [_startpos, _dir, _grp, "Truck_F"] call ALIVE_fnc_AddVehicle;
							};
						};
						
						diag_log format["ALIVE-%1 Convoy: #%2 %3 %4 %5 %6 units:%7", time, _j, _startpos, _destpos, _endpos, _front, count (units _grp)];
												
						_starttime = time;
						
                        {_x setSkill 0.2;} forEach units _grp;
                        
                        _wp = _grp addwaypoint [_startpos, 0];
                        _wp setWaypointFormation "FILE";
                        _wp setWaypointSpeed "LIMITED";
                        _wp setWaypointBehaviour "SAFE";
                        _wp setWaypointTimeout _timeout;
                        
                        _wp = _grp addwaypoint [_destpos, 0];
                        _wp setWaypointFormation "FILE";
                        _wp setWaypointSpeed "LIMITED";
                        _wp setWaypointBehaviour "SAFE";
                        _wp setWaypointTimeout _timeout;
                        
                        _wp = _grp addwaypoint [_endpos, 0];
                        _wp setWaypointFormation "FILE";
                        _wp setWaypointSpeed "LIMITED";
                        _wp setWaypointBehaviour "SAFE";
                        _wp setWaypointTimeout _timeout;
                        
                        _wp = _grp addwaypoint [_destpos, 0];
                        _wp setWaypointFormation "FILE";
                        _wp setWaypointSpeed "LIMITED";
                        _wp setWaypointBehaviour "SAFE";
                        _wp setWaypointTimeout _timeout;
                        
                        _wp = _grp addwaypoint [_startpos, 0];
                        _wp setWaypointFormation "FILE";
                        _wp setWaypointSpeed "LIMITED";
                        _wp setWaypointBehaviour "SAFE";
                        _wp setWaypointTimeout _timeout;
                        
                        _wp = _grp addwaypoint [_startpos, 0];
                        _wp setWaypointFormation "FILE";
                        _wp setWaypointSpeed "LIMITED";
                        _wp setWaypointBehaviour "SAFE";
                        _wp setWaypointType "CYCLE";

                         waitUntil{sleep 60; (!(_grp call CBA_fnc_isAlive) || (time > (_starttime + 3600)))};   
						
						// Delete convoy
						if (CONVOY_GLOBALDEBUG) then {
							diag_log format["ALIVE-%1 Convoy: %3 deleting %2", time, _grp, _j];
						};
						{deleteVehicle (vehicle _x); deleteVehicle _x;} forEach units _grp;
						deletegroup _grp;

                        _sleep = if(CONVOY_GLOBALDEBUG) then {30;} else {random 300;};
                        sleep _sleep;                
                };
        };
};
diag_log format["ALIVE-%1 Convoy: destinations(%2) convoys(%3)", time, count _convoyLocs, _convoynumber];