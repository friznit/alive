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

private ["_debug","_cycleTime","_profiles","_markers","_deleteMarkers","_deleteMarker","_createMarker"];

_markers = _this select 0;
_cycleTime = _this select 1;
_debug = if(count _this > 2) then {_this select 2} else {false};

_deleteMarkers = {
	{
		deleteMarkerLocal _x;
	} forEach (_markers select 2);
	_markers = [] call ALIVE_fnc_hashCreate;
};

_deleteMarker = {
	private ["_profile","_m","_profileID"];
	_profile = _this;
	
	_profileID = [_profile,"profileID"] call ALIVE_fnc_hashGet;
	
	_profileIndex = _markers select 1;
	if(_profileID in _profileIndex) then {	
		_m = [_markers,_profileID] call ALIVE_fnc_hashGet;			
		deleteMarkerLocal _m;		
		[_markers,_profileID] call ALIVE_fnc_hashRem;
	};
};

_createMarker = {
	private ["_profile","_waypoint","_m","_label","_position","_profileID","_debugColor","_profileSide","_markerLabel"];
	_profile = _this select 0;
	_waypoint = _this select 1;
	
	_entityProfile call _deleteMarker;

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
		_m = createMarker [format["SIM_MARKER_%1",_profileID], _position];
		_m setMarkerShape "ICON";
		_m setMarkerSize [1, 1];
		_m setMarkerType "waypoint";
		_m setMarkerColor _debugColor;
		
		_label = [_profileID, "_"] call CBA_fnc_split;
		_m setMarkerText format["%1",_label select ((count _label) - 1)];

		[_markers,_profileID,_m] call ALIVE_fnc_hashSet;
	};
};


private ["_profiles","_profileBlock","_profile","_entityProfile","_profileType","_profileID","_active","_waypoints","_waypointsCompleted","_currentPosition","_vehiclesInCommandOf","_vehicleCommander","_vehicleCargo",
	"_vehiclesInCargoOf","_activeWaypoint","_type","_speed","_destination","_distance","_speedPerSecondArray","_speedPerSecond","_moveDistance","_vehicleProfile",
	"_vehicleClass","_vehicleAssignments","_speedArray","_direction","_newPosition","_leader","_handleWPcomplete","_statements","_isCycling"];

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
    
    // if near profiles of other sides are near collect to clashing groups
    if (({((_x select 2 select 2) distance _currentPosition < 200) && {!((_x select 2 select 3) == _side)} && {(_x select 2 select 5) == "entity"}} count (_profiles select 2)) > 0) then {
       
        _clash set [count _clash,[_profileID,_currentPosition,_side,(count _positions),_vehiclesInCommandOf]];
        
        switch (_side) do {
            case ("WEST") : {_engaged set [0,(_engaged select 0) + (count _positions)]};
            case ("EAST") : {_engaged set [1,(_engaged select 1) + (count _positions)]};
            case ("GUER") : {_engaged set [2,(_engaged select 2) + (count _positions)]};
        };
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
				_direction = 0;
				
				// DEBUG -------------------------------------------------------------------------------------
				if(_debug) then {
					//["----------------------------------------------------------------------------------------"] call ALIVE_fnc_dump;
					//["ALIVE Simulated profile movement Profile: [%1] WPType: [%2] WPSpeed: [%3] Distance: [%4] MoveSpeed: [%5] SpeedArray: %6",_profileID,_type,_speed,_distance,_speedPerSecond,_speedPerSecondArray] call ALIVE_fnc_dump;
					[_entityProfile,_activeWaypoint] call _createMarker;
				};
				// DEBUG -------------------------------------------------------------------------------------
				
				if (!(isnil "_currentPosition") && {count _currentPosition > 0} && {!(isnil "_destination")} && {count _destination > 0}) then {
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
							
						if(_isCycling) then {
							_waypointsCompleted set [count _waypointsCompleted,_activeWaypoint];
						};
						
						_waypoints set [0,objNull];
						_waypoints = _waypoints - [objNull];
									
						//Needs review of any variables in hashes
						if ((typeName _statements == "ARRAY") && {call compile (_statements select 0)}) then {call compile (_statements select 1)};
									
						[] call _handleWPcomplete;			
						
						[_entityProfile,"waypoints",_waypoints] call ALIVE_fnc_hashSet;
						
						if(_isCycling) then {
							[_entityProfile,"waypointsCompleted",_waypointsCompleted] call ALIVE_fnc_hashSet;
						};
					};
								
													
					if(_vehicleCommander) then {
						// if in command of vehicle move all entities within the vehicle						
						// set the vehicle position and merge all assigned entities positions
						{
							[_entityProfile,"hasSimulated",true] call ALIVE_fnc_hashSet;
							_vehicleProfile = [ALIVE_profileHandler, "getProfile", _x] call ALIVE_fnc_profileHandler;
                            
                            if !(isnil "_vehicleProfile") then {
								[_vehicleProfile,"position",_newPosition] call ALIVE_fnc_profileVehicle;
								[_vehicleProfile,"direction",_direction] call ALIVE_fnc_profileVehicle;
								[_vehicleProfile,"mergePositions"] call ALIVE_fnc_profileVehicle;
                            };
						} forEach _vehiclesInCommandOf;										
					}else{
						// set the entity position and merge all unit positions to group position
						[_entityProfile,"hasSimulated",true] call ALIVE_fnc_hashSet;
						[_entityProfile,"position",_newPosition] call ALIVE_fnc_profileEntity;
						[_entityProfile,"mergePositions"] call ALIVE_fnc_profileEntity;
					};
	            } else {
	            	diag_log format ["Profile-Simulator corrupted profile detected %3: _currentPosition %1 _destination %2",_currentPosition,_destination,_entityProfile];
	            };
						
			// entity is spawned, update positions
			} else {
			
				_leader = _entityProfile select 2 select 10; //_leader = [_profile,"leader"] call ALIVE_fnc_hashGet;
				_newPosition = getPosATL _leader;
				_position = _entityProfile select 2 select 2; //_leader = [_profile,"position"] call ALIVE_fnc_hashGet;
				
	            if (!(isnil "_newPosition") && {count _newPosition > 0} && {!(isnil "_position")} && {count _position > 0}) then {
	            
					_moveDistance = _newPosition distance _position;
					
					if(_moveDistance > 10) then {					
						if(_vehicleCommander) then {
							// if in command of vehicle move all entities within the vehicle						
							// set the vehicle position and merge all assigned entities positions
							
							_leader = _entityProfile select 2 select 10; //_leader = [_profile,"leader"] call ALIVE_fnc_hashGet;
							_newPosition = getPosATL vehicle _leader;
							
							{
								_vehicleProfile = [ALIVE_profileHandler, "getProfile", _x] call ALIVE_fnc_profileHandler;
                                
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
	            } else {
	            	diag_log format ["Profile-Simulator corrupted profile detected %3: _newPosition %1 _position %2",_newPosition,_position,_entityProfile];
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
    private ["_engagedOwn"];
    
    _profileID = _x select 0;
    _currentPosition = _x select 1;
    _side = _x select 2;
    _positions = _x select 3;
    _vehiclesInCommandOf = _x select 4;
    
    _factor1 = 0;
    _factor2 = 0;
    
     switch (_side) do {
        case ("WEST") : {_engagedOwn = _engaged select 0};
        case ("EAST") : {_engagedOwn = _engaged select 1};
        case ("GUER") : {_engagedOwn = _engaged select 2; _side = "INDEPENDENT"};
    };
    
    if (count _vehiclesInCommandOf > 0) then {_factor1 = 0.3};
    _factor2 = _engagedOwn / _engagedTotal;
    _weighting = _factor1 + _factor2;

    // Enemy sides near, chance of death by weighting
    if ((({_sideInternal = _x select 2; if (_sideInternal == "GUER") then {_sideInternal = "INDEPENDENT"}; ((_x select 1) distance _currentPosition < 200) && {((call compile _side) getfriend (call compile _sideInternal)) < 0.6}} count _clash) > 0) && (random 1 > _weighting)) then {
        _clash set [_foreachIndex,["",[0,0,0],""]];
        _toBekilled set [count _toBekilled,_profileID];
    };
} foreach _clash;

//remove profile
{
    _profileID = _x;
	_profile = [ALIVE_profileHandler, "getProfile", _profileID] call ALIVE_fnc_profileHandler;
	
	if (!(isnil "_profile") && {!(_profile select 2 select 1)}) then {
        	//player sidechat format["Group %1 killed in simulated combat!",_profileID];
            _vehiclesInCommandOf = _profile select 2 select 8;
            
            if (count _vehiclesInCommandOf > 0) then {
                {
                    //player sidechat format["Vehicle %1 destroyed!",_x];
                    _vehicleProfile = [ALIVE_profileHandler, "getProfile", _x] call ALIVE_fnc_profileHandler;
                    [ALIVE_profileHandler, "unregisterProfile", _vehicleProfile] call ALIVE_fnc_profileHandler;
                } foreach _vehiclesInCommandOf;
            };

			[ALIVE_profileHandler, "unregisterProfile", _profile] call ALIVE_fnc_profileHandler;
    };
} foreach _toBekilled;
