#include <\x\alive\addons\sys_profile\script_component.hpp>
SCRIPT(profileSimulator);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_profileSimulator

Description:
Simulates movement of profiles that have waypoints set

Parameters:

Returns:

Examples:
(begin example)
_result = [] call ALIVE_fnc_profileSimulator;
(end)

See Also:
nothing yet

Author:
ARJay
Highhead
---------------------------------------------------------------------------- */

private ["_debug","_cycleTime","_profiles","_markers","_deleteMarkers","_deleteMarker","_createMarker","_profileIndex","_profiles","_profileBlock","_profile",
	"_entityProfile","_profileType","_profileID","_active","_waypoints","_waypointsCompleted","_currentPosition","_vehiclesInCommandOf","_vehicleCommander",
    "_vehicleCargo","_vehiclesInCargoOf","_activeWaypoint","_type","_speed","_destination","_distance","_speedPerSecondArray","_speedPerSecond","_moveDistance",
    "_vehicleProfile","_vehicleClass","_vehicleAssignments","_speedArray","_direction","_newPosition","_leader","_handleWPcomplete","_statements","_isCycling","_isPlayer","_group"
];

_markers = _this select 0;
_cycleTime = _this select 1;
_debug = if(count _this > 2) then {_this select 2} else {false};

_profiles = [ALIVE_profileHandler, "profiles"] call ALIVE_fnc_hashGet;
//_profileBlock = [ALIVE_arrayBlockHandler,"getNextBlock", ["simulation",_profiles select 2,50]] call ALIVE_fnc_arrayBlockHandler;

_clash = [];
_engaged = [0,0,0];

{
	_entityProfile = _x;

	_profileType = _entityProfile select 2 select 5; //[_profile,"type"] call ALIVE_fnc_hashGet;
				
	if(_profileType == "entity") then {
		_profileID = _entityProfile select 2 select 4; //[_profile,"profileID"] call ALIVE_fnc_hashGet;
		_active = _entityProfile select 2 select 1; //[_profile, "active"] call ALIVE_fnc_hashGet;	
		_waypoints = _entityProfile select 2 select 16; //[_entityProfile,"waypoints"] call ALIVE_fnc_hashGet;
		_waypointsCompleted = _entityProfile select 2 select 17; //[_entityProfile,"waypointsCompleted",[]] call ALIVE_fnc_hashGet;
		_currentPosition = _entityProfile select 2 select 2; //[_entityProfile,"position"] call ALIVE_fnc_hashGet;
		_vehiclesInCommandOf = _entityProfile select 2 select 8; //[_entityProfile,"vehiclesInCommandOf"] call ALIVE_fnc_hashGet;
		_vehiclesInCargoOf = _entityProfile select 2 select 9; //[_entityProfile,"vehiclesInCargoOf"] call ALIVE_fnc_hashGet;
		_speedPerSecondArray = _entityProfile select 2 select 22; //[_entityProfile, "speedPerSecond"] call ALIVE_fnc_hashGet;
		_isCycling = _entityProfile select 2 select 25; //[_entityProfile, "speedPerSecond"] call ALIVE_fnc_hashGet;
		_side = _entityProfile select 2 select 3; //[_entityProfile, "side"] call ALIVE_fnc_hashGet;
		_positions = _entityProfile select 2 select 18; //[_entityProfile, "positions"] call ALIVE_fnc_hashGet;
		_isPlayer = _entityProfile select 2 select 30; //[_entityProfile, "isPlayer"] call ALIVE_fnc_hashGet;
        _locked = [_entityProfile, "locked",false] call ALIVE_fnc_HashGet;
        _vehicleCommander = false;
		_vehicleCargo = false;
        _isAir = nil;
        _collect = nil;
        _collected = false;
					
		// if entity is commanding a vehicle/s
		if(count _vehiclesInCommandOf > 0) then {
			_vehicleCommander = true;
			
            // check if moving air unit
            {
                private ["_entry"];
                
                _entry = [ALiVE_ProfileHandler,"getProfile",_x] call ALiVE_fnc_ProfileHandler;

                if!(isNil "_entry") then {
					if (
						[_entry,"engineOn",false] call ALiVE_fnc_HashGet &&
						{([_entry,"vehicleClass",""] call ALiVE_fnc_HashGet) isKindOf "Air"}
						) then {
							_isAir = true
					};
				};
            } foreach _vehiclesInCommandOf;
		};
        	
		// if entity is cargo of vehicle/s
		if(count _vehiclesInCargoOf > 0) then {	
			_vehicleCargo = true;
		};
        
        // Collect fighting units
        {
            if (
            	!(isnil "_x") &&
				{((_x select 2 select 2) distance _currentPosition < 200)} &&
				{(_x select 2 select 5) == "entity"} &&
                {!((_x select 2 select 3) in ["CIV",_side])} &&
				{!((_side == "CIV"))}
            ) exitwith {_collect = true};
         } foreach (_profiles select 2);
        
		if (isnil "_isAir" && {!isnil "_collect"}) then {
		   
			_clash pushback [_profileID,_currentPosition,_side,_vehiclesInCommandOf];
			
			switch (_side) do {
				case ("WEST") : {_engaged set [0,(_engaged select 0) + (count _positions)]};
				case ("EAST") : {_engaged set [1,(_engaged select 1) + (count _positions)]};
				case ("GUER") : {_engaged set [2,(_engaged select 2) + (count _positions)]};
			};
            
            _collected = true;
		};
             
		// entity has waypoints assigned and entity is not in cargo of a vehicle
		if(count _waypoints > 0 && {!_locked} && {!(_vehicleCargo)} && {!(_isPlayer)}) then {
						
			// entity is not spawned, simulate
			if!(_active) then {
						
				_activeWaypoint = _waypoints select 0;
				_type = [_activeWaypoint,"type"] call ALIVE_fnc_hashGet;
				_speed = [_activeWaypoint,"speed"] call ALIVE_fnc_hashGet;
				_destination = [_activeWaypoint,"position"] call ALIVE_fnc_hashGet;
				_statements = [_activeWaypoint,"statements"] call ALIVE_fnc_hashGet;
				_distance = _currentPosition distance _destination;
										
				switch(_speed) do {
					case "LIMITED": {_speedPerSecond = _speedPerSecondArray select 0};
					case "NORMAL": {_speedPerSecond = _speedPerSecondArray select 1};
					case "FULL": {_speedPerSecond = _speedPerSecondArray select 2};
					case default {_speedPerSecond = _speedPerSecondArray select 1};
				};
							
				_moveDistance = floor(_speedPerSecond * _cycleTime);
				_direction = 0;
				
				// DEBUG -------------------------------------------------------------------------------------
				if(_debug) then {
					//["----------------------------------------------------------------------------------------"] call ALIVE_fnc_dump;
					//["ALIVE Simulated profile movement Profile: [%1] WPType: [%2] WPSpeed: [%3] Distance: [%4] MoveSpeed: [%5] SpeedArray: %6",_profileID,_type,_speed,_distance,_speedPerSecond,_speedPerSecondArray] call ALIVE_fnc_dump;
					//[_entityProfile,_activeWaypoint] call _createMarker;
				};
				// DEBUG -------------------------------------------------------------------------------------
				
				if (!_collected && {!(isnil "_currentPosition")} && {count _currentPosition > 0} && {!(isnil "_destination")} && {count _destination > 0}) then {
                        
						//else simulate them
						//Match 2D since some profiles dont have a _pos select 2 defined
						_currentPosition set [2,0];
						_destination set [2,0];
						_executeStatements = false;
						
						switch (_type) do {
							case "MOVE" : {
								_direction = [_currentPosition, _destination] call BIS_fnc_dirTo;
								_newPosition = [_currentPosition, _moveDistance, _direction] call BIS_fnc_relPos;
								_handleWPcomplete = {};
			
							};
							case "CYCLE" : {
								_direction = [_currentPosition, _destination] call BIS_fnc_dirTo;
								_newPosition = [_currentPosition, _moveDistance, _direction] call BIS_fnc_relPos;
								_handleWPcomplete = {
									_waypoints = _waypoints + _waypointsCompleted;
									_waypointsCompleted = [];
								};
							};
							default {
								_newPosition = _currentPosition;
								_handleWPcomplete = {};
							};
						};
						
						// distance to wp destination within completion radius
						if(_distance <= (_moveDistance * 2)) then {

							if(_isCycling) then {
								_waypointsCompleted pushback _activeWaypoint;
							};
							
							_waypoints set [0,objNull];
							_waypoints = _waypoints - [objNull];
										
							[] call _handleWPcomplete; _executeStatements = true;
							
							[_entityProfile,"waypoints",_waypoints] call ALIVE_fnc_hashSet;
							
							if(_isCycling) then {
								[_entityProfile,"waypointsCompleted",_waypointsCompleted] call ALIVE_fnc_hashSet;
							};
						};
													
						if(_vehicleCommander) then {
							// if entity is in command of a vehicle (not cargo)                            
							[_entityProfile,"hasSimulated",true] call ALIVE_fnc_hashSet;
							{							
								_vehicleProfile = [ALiVE_ProfileHandler,"getProfile",_x] call ALiVE_fnc_ProfileHandler;
								
								if !(isnil "_vehicleProfile") then {
                                    
	                                // turn engineOn virtually
	                            	// move all entities within the vehicle
									// set the vehicle position and merge all assigned entities positions

									//["PROFILE SIM SIMMED ENTITY %1 IN COMMAND OF %2 SET VEHICLE POS: %3",_entityProfile select 2 select 4,_vehicleProfile select 2 select 4,_newPosition] call ALIVE_fnc_dump;
                                    
									[_vehicleProfile,"hasSimulated",true] call ALIVE_fnc_hashSet;
									[_vehicleProfile,"engineOn",true] call ALIVE_fnc_profileVehicle;
									[_vehicleProfile,"position",_newPosition] call ALIVE_fnc_profileVehicle;
									[_vehicleProfile,"direction",_direction] call ALIVE_fnc_profileVehicle;
									[_vehicleProfile,"mergePositions"] call ALIVE_fnc_profileVehicle;
								};
							} forEach _vehiclesInCommandOf;										
						}else{

							//["PROFILE SIM SIMMED ENTITY %1 NOT IN COMMAND SET ENTITY POS: %2",_entityProfile select 2 select 4,_newPosition] call ALIVE_fnc_dump;

							// set the entity position and merge all unit positions to group position
							[_entityProfile,"hasSimulated",true] call ALIVE_fnc_hashSet;
							[_entityProfile,"position",_newPosition] call ALIVE_fnc_profileEntity;
							[_entityProfile,"mergePositions"] call ALIVE_fnc_profileEntity;
						};
                        
                        // Execute statements at the end, needs review of any variables in hashes
                        if (_executeStatements) then {if ((typeName _statements == "ARRAY") && {call compile (_statements select 0)}) then {call compile (_statements select 1)}};
				} else {
					//["Profile-Simulator corrupted profile detected %1: _currentPosition %2 _destination %3 _collected: %4",_profileID,_currentPosition,_destination,_collected] call ALIVE_fnc_dump;
				};
						
			// entity is spawned, update positions
			} else {

			    _group = _entityProfile select 2 select 13;

				_leader = leader _group; //_leader = [_profile,"leader"] call ALIVE_fnc_hashGet;
				_newPosition = getPosATL _leader;
				_position = _entityProfile select 2 select 2; //_leader = [_profile,"position"] call ALIVE_fnc_hashGet;

				if (!(isnil "_newPosition") && {count _newPosition > 0} && {!(isnil "_position")} && {count _position > 0}) then {
				
					_moveDistance = _newPosition distance _position;
					
					if(_moveDistance > 10) then {

						if(_vehicleCommander) then {
							// if in command of vehicle move all entities within the vehicle						
							// set the vehicle position and merge all assigned entities positions
							
							//_leader = _entityProfile select 2 select 10; //_leader = [_profile,"leader"] call ALIVE_fnc_hashGet;

							_newPosition = getPosATL vehicle _leader;
							
							{
								_vehicleProfile = [ALiVE_ProfileHandler,"getProfile",_x] call ALiVE_fnc_ProfileHandler;

								//["PROFILE SIM SPAWNED ENTITY %1 IN COMMAND OF %2 SET VEHICLE POS: %3",_entityProfile select 2 select 4,_vehicleProfile select 2 select 4,_newPosition] call ALIVE_fnc_dump;
								
								if !(isnil "_vehicleProfile") then {				
									[_vehicleProfile,"position",_newPosition] call ALIVE_fnc_profileVehicle;
									[_vehicleProfile,"mergePositions"] call ALIVE_fnc_profileVehicle;
								};
							} forEach _vehiclesInCommandOf;												
						} else {
							//_leader = _entityProfile select 2 select 10; //_leader = [_profile,"leader"] call ALIVE_fnc_hashGet;
							_newPosition = getPosATL _leader;

							//["PROFILE SIM SPAWNED ENTITY %1 NOT IN COMMAND SET ENTITY POS: %2",_entityProfile select 2 select 4,_newPosition] call ALIVE_fnc_dump;
						
							// set the entity position and merge all unit positions to group position
							[_entityProfile,"position",_newPosition] call ALIVE_fnc_profileEntity;
							[_entityProfile,"mergePositions"] call ALIVE_fnc_profileEntity;
						};			
					};
				} else {
					["Profile-Simulator corrupted spawned profile detected %1: _newPosition %2 _position %3",_profileID,_newPosition,_position] call ALIVE_fnc_dump;
				};
			};
		} else {

            // the profile has no waypoints
		    if(!(_vehicleCargo) && !(_isPlayer)) then {

                _group = _entityProfile select 2 select 13; //_leader = [_profile,"leader"] call ALIVE_fnc_hashGet;
                //_group = group _leader;

                // but the profile has waypoints set, but not but ALiVE
                // eg Zeus
                if((!isNull _group) && {currentWaypoint _group < count waypoints _group && currentWaypoint _group > 0}) then {
                    //["S1: %1 %2", currentWaypoint _group, count waypoints _group] call ALIVE_fnc_dump;

                    _newPosition = getPosATL _leader;
                    _position = _entityProfile select 2 select 2; //_leader = [_profile,"position"] call ALIVE_fnc_hashGet;

                    if (!(isnil "_newPosition") && {count _newPosition > 0} && {!(isnil "_position")} && {count _position > 0}) then {

                        _moveDistance = _newPosition distance _position;

                        if(_moveDistance > 10) then {

                            if(_vehicleCommander) then {
                                // if in command of vehicle move all entities within the vehicle
                                // set the vehicle position and merge all assigned entities positions

                                //_leader = _entityProfile select 2 select 10; //_leader = [_profile,"leader"] call ALIVE_fnc_hashGet;

                                _leader = leader _group;

                                _newPosition = getPosATL vehicle _leader;

                                {
                                    _vehicleProfile = [ALiVE_ProfileHandler,"getProfile",_x] call ALiVE_fnc_ProfileHandler;

                                    //["PROFILE SIM SPAWNED NO WAYPOINTS ENTITY %1 IN COMMAND OF %2 SET VEHICLE POS: %3",_entityProfile select 2 select 4,_vehicleProfile select 2 select 4,_newPosition] call ALIVE_fnc_dump;

                                    if !(isnil "_vehicleProfile") then {
                                        [_vehicleProfile,"position",_newPosition] call ALIVE_fnc_profileVehicle;
                                        [_vehicleProfile,"mergePositions"] call ALIVE_fnc_profileVehicle;
                                    };
                                } forEach _vehiclesInCommandOf;
                            } else {

                                //_leader = _entityProfile select 2 select 10; //_leader = [_profile,"leader"] call ALIVE_fnc_hashGet;

                                _leader = leader _group;

                                _newPosition = getPosATL _leader;

                                //["PROFILE SIM SPAWNED NO WAYPOINTS ENTITY %1 NOT IN COMMAND SET ENTITY POS: %2",_entityProfile select 2 select 4,_newPosition] call ALIVE_fnc_dump;

                                // set the entity position and merge all unit positions to group position
                                [_entityProfile,"position",_newPosition] call ALIVE_fnc_profileEntity;
                                [_entityProfile,"mergePositions"] call ALIVE_fnc_profileEntity;
                            };
                        };
                    } else {
                    	["Profile-Simulator corrupted profile detected %1: _newPosition %2 _position %3",_profileID,_newPosition,_position] call ALIVE_fnc_dump;
                    };
                };
		    };

		    // entity is player entity
            if(_isPlayer) then {

                _leader = _entityProfile select 2 select 10; //_leader = [_profile,"leader"] call ALIVE_fnc_hashGet;
                _newPosition = getPosATL _leader;
                _position = _entityProfile select 2 select 2; //_leader = [_profile,"position"] call ALIVE_fnc_hashGet;

				//Positions are valid
				if (!(isnil "_newPosition") && {str(_newPosition) != "[0,0,0]"} && {!(isnil "_position")} && {str(_position) != "[0,0,0]"}) then {

                     _moveDistance = _newPosition distance _position;

                     if(_moveDistance > 10) then {
                         if(_vehicleCommander) then {
                             // if in command of vehicle move all entities within the vehicle
                             // set the vehicle position and merge all assigned entities positions

                             _leader = _entityProfile select 2 select 10; //_leader = [_profile,"leader"] call ALIVE_fnc_hashGet;
                             _newPosition = getPosATL vehicle _leader;

                             {
                                 _vehicleProfile = [ALiVE_ProfileHandler,"getProfile",_x] call ALiVE_fnc_ProfileHandler;

                                 if !(isnil "_vehicleProfile") then {
                                     [_vehicleProfile,"position",_newPosition] call ALIVE_fnc_profileVehicle;
                                     [_vehicleProfile,"mergePositions"] call ALIVE_fnc_profileVehicle;
                                 };
                             } forEach _vehiclesInCommandOf;
                         } else {
                             _leader = _entityProfile select 2 select 10; //_leader = [_profile,"leader"] call ALIVE_fnc_hashGet;
                             _newPosition = getPosATL _leader;

                             // set the entity position and merge all unit positions to group position
                             [_entityProfile,"position",_newPosition] call ALIVE_fnc_profileEntity;
                             [_entityProfile,"mergePositions"] call ALIVE_fnc_profileEntity;
                         };
                     };
                     
                //Positions are invalid (due to missing player object or corrupted profile)
				} else {
                     ["DISCONNECT"] call ALIVE_fnc_createProfilesFromPlayers;
				};
            };
        };
	};
} forEach (_profiles select 2);

//Count total clashing forces (single profiles)
_engagedTotal = (_engaged select 0) + (_engaged select 1) + (_engaged select 2);

//Simulate death
_toBekilled = [];
{
    private ["_engagedOwn","_surviveFactor"];
    
    _profileID = _x select 0;
    _currentPosition = _x select 1;
    _side = _x select 2;
    _vehiclesInCommandOf = _x select 3;
    
    _factor1 = 0.2;
    _factor2 = 0;
    
     switch (_side) do {
        case ("WEST") : {_engagedOwn = _engaged select 0};
        case ("EAST") : {_engagedOwn = _engaged select 1};
        case ("GUER") : {_engagedOwn = _engaged select 2; _side = "INDEPENDENT"};
    };
    
    _killFactor = random 1;
    
    if (count _vehiclesInCommandOf > 0) then {_killFactor = _killFactor - 0.15};
    if (_engagedTotal > 0) then {
        _surviveFactor = (_engagedOwn/_engagedTotal)-(random 0.25);
    } else {
		_surviveFactor = random 1;
    };

    _enemiesNear = (({_sideInternal = _x select 2; if (_sideInternal == "GUER") then {_sideInternal = "INDEPENDENT"}; ((_x select 1) distance _currentPosition < 200) && {((call compile _side) getfriend (call compile _sideInternal)) < 0.6}} count _clash) > 0);
	
    //["Profile %1 | K: %2 | S: %3 | E: %4",_profileID,_killFactor,_surviveFactor,_enemiesNear] call ALiVE_fnc_DumpH;

    // Enemy sides near, chance of death by weighting
    if ((_killFactor > _surviveFactor) && {_enemiesNear}) then {
        _clash set [_foreachIndex,["",[0,0,0],""]];
        _toBekilled pushback _profileID;
    };
} foreach _clash;

//remove profile
{
	_profile = [ALIVE_profileHandler, "getProfile",_x] call ALIVE_fnc_profileHandler;
	
	if (!(isnil "_profile") && {!(_profile select 2 select 1)}) then {

            _vehiclesInCommandOf = _profile select 2 select 8;
            _units = _profile select 2 select 11;
            _deathToll = floor(random(count _units));
            
            //To be looked at, "removeUnit" seems to leave null entries in units array (also tested with foreach)
        	for "_i" from 0 to _deathToll do {
                if (_i > _deathToll) exitwith {};
                [_profile, "removeUnit", _i] call ALiVE_fnc_profileEntity;
            };
            
            if (count (_profile select 2 select 11) == 0) then {
                //["Deleting %1!",[_profile,"profileID",""] call ALiVE_fnc_HashGet] call ALiVE_fnc_DumpR;
                
	            // log event
	            _position = _profile select 2 select 2;
	            _faction = _profile select 2 select 29;
	            _side = _profile select 2 select 3;
                _event = ['PROFILE_KILLED', [_position,_faction,_side],"ProfileSimulator"] call ALIVE_fnc_event;
                _eventID = [ALIVE_eventLog, "addEvent",_event] call ALIVE_fnc_eventLog;
                
                // Remove vehicles
                if (count _vehiclesInCommandOf > 0) then {{[ALIVE_profileHandler, "unregisterProfile", [ALIVE_profileHandler, "getProfile", _x] call ALIVE_fnc_profileHandler] call ALIVE_fnc_profileHandler} foreach _vehiclesInCommandOf};
				
                // Remove entity	
				[ALIVE_profileHandler, "unregisterProfile", _profile] call ALIVE_fnc_profileHandler;
            };
    };
} foreach _toBekilled;