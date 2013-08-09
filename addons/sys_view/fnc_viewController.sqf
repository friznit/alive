#include <\x\alive\addons\sys_profile\script_component.hpp>
SCRIPT(viewController);

/* ----------------------------------------------------------------------------
Function: MAINCLASS
Description:
View controller 

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
// create the view controller
_logic = [nil, "create"] call ALIVE_fnc_viewController;
(end)

See Also:

Author:
ARJay

Peer reviewed:
nil
---------------------------------------------------------------------------- */

#define SUPERCLASS ALIVE_fnc_baseClassHash
#define MAINCLASS ALIVE_fnc_viewController

private ["_logic","_operation","_args","_result"];

TRACE_1("viewController - input",_this);

_logic = [_this, 0, objNull, [objNull,[]]] call BIS_fnc_param;
_operation = [_this, 1, "", [""]] call BIS_fnc_param;
_args = [_this, 2, objNull, [objNull,[],"",0,true,false]] call BIS_fnc_param;
_result = true;

#define MTEMPLATE "ALiVE_VIEW_%1"

_deleteMarkers = {
	private ["_logic"];
	
	_logic = _this;
	{
			deleteMarkerLocal _x;
	} forEach (([_logic,"debugMarkers"] call ALIVE_fnc_hashGet) select 2);
};

_deleteMarker = {
	private ["_profile","_markers","_m","_profileID","_markerIndex"];
	
	_profile = _this;
	
	_markers = [_logic,"debugMarkers"] call ALIVE_fnc_hashGet;
	
	_profileID = [_profile,"profileID"] call ALIVE_fnc_hashGet;
	
	_markerIndex = _markers select 1;
	if(_profileID in _markerIndex) then {
		_m = [_markers,_profileID] call ALIVE_fnc_hashGet;
		deleteMarkerLocal _m;		
		[_markers,_profileID] call ALIVE_fnc_hashRem;
	};
};

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
						
						[_logic,"spawnDistance", 1000] call ALIVE_fnc_hashSet;
						
						[_logic,"debugMarkers", [] call ALIVE_fnc_hashCreate] call ALIVE_fnc_hashSet;
                };
                
                /*
                VIEW - purely visual
                */
                
                /*
                CONTROLLER  - coordination
                */
        };
		case "spawnProfile": {
		
				private ["_profile","_debug","_distance","_profileID","_profileType","_position","_active","_vehicle","_leader"];
				
				_profile = _args select 0;
								
				_debug = [_logic, "debug"] call ALIVE_fnc_hashGet;
				_distance = [_logic, "spawnDistance"] call ALIVE_fnc_hashGet;
		
				_profileID = [_profile,"profileID"] call ALIVE_fnc_hashGet;
				_profileType = [_profile,"type"] call ALIVE_fnc_hashGet;
				_active = [_profile, "active"] call ALIVE_fnc_hashGet;
				
				if(_active) then {
					if(_profileType == "vehicle") then {
						_vehicle = [_profile,"vehicle"] call ALIVE_fnc_hashGet;
						_position = getPosATL _vehicle;
					}else{
						_leader = [_profile,"leader"] call ALIVE_fnc_hashGet;
						_position = getPosATL _leader;
					};
				}else{
					_position = [_profile,"position"] call ALIVE_fnc_hashGet;
				};		
				
				if ([_position, _distance] call ALiVE_fnc_anyPlayersInRange > 0) then {
					
					if!(_active) then {
					
						
						// DEBUG -------------------------------------------------------------------------------------
						if(_debug) then {
							["----------------------------------------------------------------------------------------"] call ALIVE_fnc_dump;
							["ALIVE Profile spawner - spawn [%1]",_profileID] call ALIVE_fnc_dump;
						};
						// DEBUG -------------------------------------------------------------------------------------
							
					
						switch(_profileType) do {
								case "entity": {
									[_profile, "spawn"] call ALIVE_fnc_profileEntity;
								};
								case "mil": {
									[_profile, "spawn"] call ALIVE_fnc_profileMil;
								};
								case "civ": {
									[_profile, "spawn"] call ALIVE_fnc_profileCiv;
								};
								case "vehicle": {
									[_profile, "spawn"] call ALIVE_fnc_profileVehicle;
								};
						};
					};
				} else {
					
					if(_active) then {
					
					
						// DEBUG -------------------------------------------------------------------------------------
						if(_debug) then {
							["----------------------------------------------------------------------------------------"] call ALIVE_fnc_dump;
							["ALIVE Profile spawner - despawn [%1]",_profileID] call ALIVE_fnc_dump;
						};
						// DEBUG -------------------------------------------------------------------------------------
					
					
						switch(_profileType) do {
								case "entity": {
									[_profile, "despawn"] call ALIVE_fnc_profileEntity;
								};
								case "mil": {
									[_profile, "despawn"] call ALIVE_fnc_profileMil;
								};
								case "civ": {
									[_profile, "despawn"] call ALIVE_fnc_profileCiv;
								};
								case "vehicle": {
									[_profile, "despawn"] call ALIVE_fnc_profileVehicle;
								};
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