#include <\x\alive\addons\sys_profile\script_component.hpp>
SCRIPT(simulationController);

/* ----------------------------------------------------------------------------
Function: MAINCLASS
Description:
Simulation controller 

Parameters:
Nil or Object - If Nil, return a new instance. If Object, reference an existing instance.
String - The selected function
Array - The selected parameters

Returns:
Any - The new instance or the result of the selected function and parameters

Attributes:
Boolean - debug - Debug enable, disable or refresh
Boolean - state - Store or restore state of analysis

Examples:
(begin example)
// create the simulation controller
_logic = [nil, "create"] call ALIVE_fnc_simulationController;
(end)

See Also:

Author:
ARJay

Peer reviewed:
nil
---------------------------------------------------------------------------- */

#define SUPERCLASS ALIVE_fnc_baseClassHash
#define MAINCLASS ALIVE_fnc_simulationController

private ["_logic","_operation","_args","_result","_deleteMarkers","_deleteMarker","_createMarker"];

TRACE_1("simulationController - input",_this);

_logic = [_this, 0, objNull, [objNull,[]]] call BIS_fnc_param;
_operation = [_this, 1, "", [""]] call BIS_fnc_param;
_args = [_this, 2, objNull, [objNull,[],"",0,true,false]] call BIS_fnc_param;
_result = true;

#define MTEMPLATE "ALiVE_SIMULATION_%1"



_createMarker = {
	private ["_profile","_waypoint","_markers","_m","_position","_profileID","_debugColor","_profileSide","_markerLabel"];
	_profile = _this select 0;
	_waypoint = _this select 1;
	
	_profile call _deleteMarker;
	
	_markers = [_logic,"debugMarkers"] call ALIVE_fnc_hashGet;

	_position = [_waypoint,"position"] call ALIVE_fnc_hashGet;
	_profileID = [_profile,"profileID"] call ALIVE_fnc_hashGet;
	_profileSide = [_profile,"side"] call ALIVE_fnc_hashGet;
	_markerLabel = format["%1 destination", _profileID];
	
	switch(_profileSide) do {
		case "EAST":{
			_debugColor = "ColorRed";
		};
		case "WEST":{
			_debugColor = "ColorBlue";
		};
		case "CIV":{
			_debugColor = "ColorYellow";
		};
		case "GUER":{
			_debugColor = "ColorGreen";
		};
		default {
			_debugColor = "ColorGreen";
		};
	};

	if(count _position > 0) then {
		_m = createMarkerLocal [format["MARKER_%1",_profileID], _position];
		_m setMarkerShapeLocal "ICON";
		_m setMarkerSizeLocal [1, 1];
		_m setMarkerTypeLocal "waypoint";
		_m setMarkerColorLocal _debugColor;
		_m setMarkerTextLocal format["%1 destination",_profileID];

		[_markers,_profileID,_m] call ALIVE_fnc_hashSet;
	};
};

switch(_operation) do {
        case "init": {                
                /*
                MODEL - no visual just reference data
                - nodes
                - center
                - size
                */
                
                if (isServer) then {
                        // if server, initialise module game logic
						// nil these out they add a lot of code to the hash..
						[_logic,"super"] call ALIVE_fnc_hashRem;
						[_logic,"class"] call ALIVE_fnc_hashRem;
                        //TRACE_1("After module init",_logic);
						
						[_logic,"index", 0] call ALIVE_fnc_hashSet;
						[_logic,"debugMarkers", [] call ALIVE_fnc_hashCreate] call ALIVE_fnc_hashSet;
                };
                
                /*
                VIEW - purely visual
                */
                
                /*
                CONTROLLER  - coordination
                */
        };
		case "getNextBlock": {
				private ["_blockLimit","_currentIndex","_profiles","_limit","_block"];
				
				_blockLimit = _args select 0;
				
				_currentIndex = [_logic,"index"] call ALIVE_fnc_hashGet;
				
				_profiles = [ALIVE_profileHandler, "getProfilesByType", "entity"] call ALIVE_fnc_profileHandler;
				_limit = count _profiles;
				
				if((_currentIndex + _blockLimit) >= _limit) then {
					[_logic,"index",0] call ALIVE_fnc_hashSet;
				}else{
					_limit = _currentIndex + _blockLimit;
					[_logic,"index",_limit] call ALIVE_fnc_hashSet;
				};
				
				_block = [];
				for "_i" from _currentIndex to (_limit)-1 do {
					_block set [count _block, _profiles select _i];
				};
				
				_result = _block;
		};
		case "simulateEntitiy": {
		
				private ["_entityProfile","_cycleTime","_debug","_profileID","_active","_waypoints","_waypointsCompleted","_currentPosition","_vehiclesInCommandOf","_vehicleCommander","_vehicleCargo",
				"_vehiclesInCargoOf","_activeWaypoint","_type","_speed","_destination","_distance","_speedPerSecondArray","_speedPerSecond","_moveDistance","_vehicleProfile",
				"_vehicleClass","_vehicleAssignments","_speedArray","_direction","_newPosition","_leader","_handleWPcomplete","_statements"];
				
				_entityProfile = _args select 0;
				_cycleTime = _args select 1;
				
				_debug = [_logic, "debug"] call ALIVE_fnc_hashGet;
				
				_profileID = _entityProfile select 2 select 4; //[_profile,"profileID"] call ALIVE_fnc_hashGet;
				_active = _entityProfile select 2 select 1; //[_profile, "active"] call ALIVE_fnc_hashGet;	
				_waypoints = _entityProfile select 2 select 16; //[_entityProfile,"waypoints"] call ALIVE_fnc_hashGet;
				_waypointsCompleted = _entityProfile select 2 select 17; //[_entityProfile,"waypointsCompleted",[]] call ALIVE_fnc_hashGet;
				_currentPosition = _entityProfile select 2 select 2; //[_entityProfile,"position"] call ALIVE_fnc_hashGet;
				_vehiclesInCommandOf = _entityProfile select 2 select 8; //[_entityProfile,"vehiclesInCommandOf"] call ALIVE_fnc_hashGet;
				_vehiclesInCargoOf = _entityProfile select 2 select 9; //[_entityProfile,"vehiclesInCargoOf"] call ALIVE_fnc_hashGet;
				_speedPerSecondArray = _entityProfile select 2 select 22; //[_entityProfile, "speedPerSecond"] call ALIVE_fnc_hashGet;
				_vehicleCommander = false;
				_vehicleCargo = false;
				
				// if entity is commanding a vehicle/s
				if(count _vehiclesInCommandOf > 0) then {
					_vehicleCommander = true;				
				};
				
				// if entity is cargo of vehicle/s
				if(count _vehiclesInCargoOf > 0) then {
					_vehicleCargo = true;
				};
							
				// entity has waypoints assigned and entity is not in cargo of a vehicle
				if(count _waypoints > 0 && !(_vehicleCargo)) then {
					
					// entity is not spawned, simulate
					if!(_active) then {					
					
						_activeWaypoint = _waypoints select 0;
						_type = [_activeWaypoint,"type"] call ALIVE_fnc_hashGet;
						_speed = [_activeWaypoint,"speed"] call ALIVE_fnc_hashGet;
						_destination = [_activeWaypoint,"position"] call ALIVE_fnc_hashGet;
						_statements = [_activeWaypoint,"statements"] call ALIVE_fnc_hashGet;
						_distance = _currentPosition distance _destination;
										
						switch(_speed) do {
							case "LIMITED": { _speedPerSecond = _speedPerSecondArray select 0; };
							case "NORMAL": { _speedPerSecond = _speedPerSecondArray select 1; };
							case "FULL": { _speedPerSecond = _speedPerSecondArray select 2; };
							case default { _speedPerSecond = _speedPerSecondArray select 1; };
						};
						
						_moveDistance = floor(_speedPerSecond * _cycleTime);
					
						// DEBUG -------------------------------------------------------------------------------------
						if(_debug) then {
							//["----------------------------------------------------------------------------------------"] call ALIVE_fnc_dump;
							//["ALIVE Simulated profile movement Profile: [%1] WPType: [%2] WPSpeed: [%3] Distance: [%4] MoveSpeed: [%5] SpeedArray: %6",_profileID,_type,_speed,_distance,_speedPerSecond,_speedPerSecondArray] call ALIVE_fnc_dump;
							[_entityProfile,_activeWaypoint] call _createMarker;
						};
						// DEBUG -------------------------------------------------------------------------------------
						
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
						
							// DEBUG -------------------------------------------------------------------------------------
							if(_debug) then {
								_entityProfile call _deleteMarker;
							};
							// DEBUG -------------------------------------------------------------------------------------
							
							_waypointsCompleted set [count _waypointsCompleted,_activeWaypoint];
							_waypoints set [0,objNull];
							_waypoints = _waypoints - [objNull];
							
							//Needs review of any variables in hashes
							if ((typeName _statements == "ARRAY") && {call compile (_statements select 0)}) then {call compile (_statements select 1)};
							
							[] call _handleWPcomplete;
							
							[_entityProfile,"waypoints",_waypoints] call ALIVE_fnc_hashSet;
							[_entityProfile,"waypointsCompleted",_waypointsCompleted] call ALIVE_fnc_hashSet;
						};
						
											
						if(_vehicleCommander) then {
							// if in command of vehicle move all entities within the vehicle						
							// set the vehicle position and merge all assigned entities positions
							{
								_vehicleProfile = [ALIVE_profileHandler, "getProfile", _x] call ALIVE_fnc_profileHandler;
								[_vehicleProfile,"position",_newPosition] call ALIVE_fnc_profileVehicle;
								[_vehicleProfile,"mergePositions"] call ALIVE_fnc_profileVehicle;
							} forEach _vehiclesInCommandOf;												
						}else{
							// set the entity position and merge all unit positions to group position
							[_entityProfile,"position",_newPosition] call ALIVE_fnc_profileEntity;
							[_entityProfile,"mergePositions"] call ALIVE_fnc_profileEntity;
						};
					
					// entity is spawned, update positions
					} else {
					
						_leader = _entityProfile select 2 select 10; //_leader = [_profile,"leader"] call ALIVE_fnc_hashGet;
						_newPosition = getPosATL _leader;
					
						if(_vehicleCommander) then {
							// if in command of vehicle move all entities within the vehicle						
							// set the vehicle position and merge all assigned entities positions
							{
								_vehicleProfile = [ALIVE_profileHandler, "getProfile", _x] call ALIVE_fnc_profileHandler;
								[_vehicleProfile,"position",_newPosition] call ALIVE_fnc_profileVehicle;
								[_vehicleProfile,"mergePositions"] call ALIVE_fnc_profileVehicle;
							} forEach _vehiclesInCommandOf;												
						} else {
							// set the entity position and merge all unit positions to group position
							[_entityProfile,"position",_newPosition] call ALIVE_fnc_profileEntity;
							[_entityProfile,"mergePositions"] call ALIVE_fnc_profileEntity;
						};
					};
				};             
        };
        case "destroy": {                
                [_logic, "debug", false] call MAINCLASS;
                if (isServer) then {
					[_logic, "destroy"] call SUPERCLASS;
                };                
        };
		 case "deleteMarkers": {                
                {
					deleteMarkerLocal _x;
				} forEach (([_logic,"debugMarkers"] call ALIVE_fnc_hashGet) select 2);               
        };
		 case "deleteMarker": {                
                [_logic, "debug", false] call MAINCLASS;
                _profile = _args;
			
				_markers = [_logic,"debugMarkers"] call ALIVE_fnc_hashGet;
				
				_profileID = [_profile,"profileID"] call ALIVE_fnc_hashGet;
				
				_markerIndex = _markers select 1;
				if(_profileID in _markerIndex) then {
					_m = [_markers,_profileID] call ALIVE_fnc_hashGet;
					deleteMarkerLocal _m;
					[_markers,_profileID] call ALIVE_fnc_hashRem;
				};              
        };
		 case "createMarker": {                
                private ["_profile","_waypoint","_markers","_m","_position","_profileID","_debugColor","_profileSide","_markerLabel"];
				_profile = _args select 0;
				_waypoint = _args select 1;
				
				[_logic,"deleteMarker",_profile] call MAINCLASS;
				
				_markers = [_logic,"debugMarkers"] call ALIVE_fnc_hashGet;

				_position = [_waypoint,"position"] call ALIVE_fnc_hashGet;
				_profileID = [_profile,"profileID"] call ALIVE_fnc_hashGet;
				_profileSide = [_profile,"side"] call ALIVE_fnc_hashGet;
				_markerLabel = format["%1 destination", _profileID];
				
				switch(_profileSide) do {
					case "EAST":{
						_debugColor = "ColorRed";
					};
					case "WEST":{
						_debugColor = "ColorBlue";
					};
					case "CIV":{
						_debugColor = "ColorYellow";
					};
					case "GUER":{
						_debugColor = "ColorGreen";
					};
					default {
						_debugColor = "ColorGreen";
					};
				};

				if(count _position > 0) then {
					_m = createMarkerLocal [format["MARKER_%1",_profileID], _position];
					_m setMarkerShapeLocal "ICON";
					_m setMarkerSizeLocal [1, 1];
					_m setMarkerTypeLocal "waypoint";
					_m setMarkerColorLocal _debugColor;
					_m setMarkerTextLocal format["%1 destination",_profileID];

					[_markers,_profileID,_m] call ALIVE_fnc_hashSet;
				};                
        };
		
        case "debug": {
                if(typeName _args != "BOOL") then {
						_args = [_logic,"debug"] call ALIVE_fnc_hashGet;
                } else {
						[_logic,"debug",_args] call ALIVE_fnc_hashSet;
                };                
                ASSERT_TRUE(typeName _args == "BOOL",str _args);
                
                _result = _args;
        };
		case "state": {
				private["_state"];
                
				if(typeName _args != "ARRAY") then {
						
						// Save state
				
                        _state = [] call ALIVE_fnc_hashCreate;
						
						// BaseClassHash CHANGE 
						// loop the class hash and set vars on the state hash
						{
							if(!(_x == "super") && !(_x == "class")) then {
								[_state,_x,[_logic,_x] call ALIVE_fnc_hashGet] call ALIVE_fnc_hashSet;
							};
						} forEach (_logic select 1);
                       
                        _result = _state;
						
                } else {
						ASSERT_TRUE(typeName _args == "ARRAY",str typeName _args);

                        // Restore state
						
						// BaseClassHash CHANGE 
						// loop the passed hash and set vars on the class hash
                        {
							[_logic,_x,[_args,_x] call ALIVE_fnc_hashGet] call ALIVE_fnc_hashSet;
						} forEach (_args select 1);
                };
        };
        default {
                _result = [_logic, _operation, _args] call SUPERCLASS;
        };
};
TRACE_1("profile - output",_result);
_result;