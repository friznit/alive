#include <\x\alive\addons\mil_convoy\script_component.hpp>

private ["_logic","_intensity"];

_logic = _this select 0;
_intensity = _logic getvariable ["conv_intensity_setting",1];

for "_j" from 1 to _intensity do {
        [_logic,_j] spawn {
                private ["_timeout","_startpos","_roadRadius","_destpos","_destroada","_destroad","_endpos","_endroad","_grp","_front","_facs","_wp","_j","_convoyLocs","_debug","_sleep","_type","_starttime","_locations","_pos","_size","_list"];
                
                _logic = _this select 0;
                _j = _this select 1;
                
                _intensity = _logic getvariable ["conv_intensity_setting",1];
				_safeArea = _logic getvariable ["conv_safearea_setting",2000];
				_factionsConvoy = _logic getvariable ["conv_factions_setting","OPF_F"];
				_debug = _logic getvariable ["conv_debug_setting",false];
                
                _convoyLocs = [];
                _roadRadius = 500;

                for "_i" from 0 to ((count synchronizedObjects _logic)-1) do {
					private ["_mod"];
					
					_mod = (synchronizedObjects _logic) select _i;
					
					if ((typeof _mod) in ["ALiVE_mil_OPCOM"]) then {
							waituntil {!(isnil "OPCOM_INSTANCES") && {[OPCOM_INSTANCES select 0,"startupComplete",false] call ALiVE_fnc_HashGet}};
							waituntil {sleep 2; _convoyLocs = [_factionsConvoy,"idle"] call ALiVE_fnc_OPCOMpositions; ["Convoy faction %1 is waiting for secured OPCOM positions...",_factionsConvoy] call ALiVE_fnc_DumpR; count _convoyLocs >= 4};
				    } else {
					    
					};
				};
				if (count _convoyLocs < 4) then {
					_locations = nearestLocations [getArray (configFile >> "CfgWorlds" >> worldName >> "centerPosition"), ["StrongPointArea","Strategic","CityCenter","FlatAreaCity","Airport","NameCity","NameCityCapital","NameVillage","NameMarine","BorderCrossing"],30000];
					_roadRadius = 1500;
                    {
					   _pos = position _x;
					   _size = size _x;
					                                           
					   if (_size select 0 > _size select 1) then {_size = _size select 0} else {_size = _size select 1};
					      _convoyLocs set [count _convoyLocs,_pos];
					} foreach _locations;
				};

				if (count _convoyLocs < 3) exitwith {
                    ["No convoy locs found for faction %1! Using map locations!",_factionsConvoy] call ALiVE_fnc_DumpR;
                };
                
                _timeout = if(_debug) then {[30, 30, 30];} else {[30, 120, 300];};
                
				while {_intensity > 0} do {
                        //ALIVEPROFILERSTART("Convoys")
						private ["_swag","_leader","_dir","_startroad","_list","_startroada"];
						// Select a start position outside of player safe zone and not near base
						
                        while {
                            _startroada = _convoyLocs call BIS_fnc_selectRandom;
							_list = (_startroada nearRoads _roadRadius);
                            _startroad = _list call BIS_fnc_selectRandom;
                            _pos = getposATL _startroad;
							[position _startroad] call ALIVE_fnc_intrigger;
						} do {};

                        _startpos =  getposATL _startroad; 
                        _convoyLocs = _convoyLocs - [_startroada];
                        
                        diag_log format["_startpos: %1", _startpos];
                        
                        _destroada = _convoyLocs call BIS_fnc_selectRandom;
                        _list = (_destroada nearRoads _roadRadius);
                        _destroad = _list call BIS_fnc_selectRandom;
                        _destpos = getposATL _destroad;
                        diag_log format["_destpos: %1", _destpos];
                        
                        _endroada = _convoyLocs call BIS_fnc_selectRandom;
                        _list = (_endroada nearRoads _roadRadius);
                        _endroad = _list call BIS_fnc_selectRandom;
                        _endpos = getposATL _endroad;
                         diag_log format["_endpos: %1", _endpos];
						
						if (_debug) then {
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
                        while {isNil "_grp"} do {
                                _front = [["Motorized","Mechanized","Armored"],[16,4,1]] call ALIVE_fnc_selectRandom;
                                _facs = _factionsConvoy;
                                _grp = [_logic,_startpos,_front,_facs] call ALIVE_fnc_randomGroup;
                        };
                                                
						// Set direction so pointing towards destination
						//_dir = getdir _startroad;
                        _dir = [_startpos, _endpos] call BIS_fnc_dirTo;
						
						_leader = leader _grp;
						_leader setdir _dir;
						_grp setFormation "FILE";
						
                        switch(_front) do {
                                case "Motorized": {
                                        for "_i" from 0 to (1 + floor(random 2)) do {
										private "_veh";
											_veh = [_logic,_startpos, _dir, _grp] call ALIVE_fnc_AddVehicle;
                                        };
                                };
                                case "Mechanized": {
                                        for "_i" from 0 to (1 + floor(random 2)) do {
											private "_veh";
											_veh = [_logic,_startpos, _dir, _grp] call ALIVE_fnc_AddVehicle;
                                        };
	                                    if(random 1 > 0.66) then {
											private "_veh";
											_veh = [_logic,_startpos, _dir, _grp] call ALIVE_fnc_AddVehicle;
										};
                                };
                                case "Armored": {
                                        for "_i" from 0 to (1 + floor(random 2)) do {
											private "_veh";
											_veh = [_logic,_startpos, _dir, _grp] call ALIVE_fnc_AddVehicle;
                                        };
                                        if(random 1 > 0.33) then {
											private "_veh";
											_veh = [_logic,_startpos, _dir, _grp] call ALIVE_fnc_AddVehicle;
										};
                                };
                        };
                        
						// Add some trucks!
						if(random 1 > 0.25) then {
							for "_i" from 0 to (1 + ceil(random 2)) do {
								private "_veh";
								_veh = [_logic,_startpos, _dir, _grp, "Truck_F"] call ALIVE_fnc_AddVehicle;
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
						if (_debug) then {
							diag_log format["ALIVE-%1 Convoy: %3 deleting %2", time, _grp, _j];
						};
						{deleteVehicle (vehicle _x); deleteVehicle _x;} forEach units _grp;
						deletegroup _grp;

                        _sleep = if(_debug) then {30;} else {random 300;};
                        sleep _sleep;                
                };
        };
};
["ALIVE-%1 Convoy: convoys(%3)", time, _intensity] call ALiVE_fnc_Dump;