#include <\x\alive\addons\sys_profile\script_component.hpp>
SCRIPT(agentProfile);

/* ----------------------------------------------------------------------------
Function: MAINCLASS
Description:
Base agent profile class. 

Parameters:
Nil or Object - If Nil, return a new instance. If Object, reference an existing instance.
String - The selected function
Array - The selected parameters

Returns:
Any - The new instance or the result of the selected function and parameters

Attributes:
Boolean - debug - Debug enable, disable or refresh
Boolean - state - Store or restore state
String - objectID - Set the profile object id
String - unitClass - Set the profile class name
Array - position - Set the profile position
String - side - Set the profile side
String - groupID - Set the profile group profile object id
String - vehicleID - Set the profile vehicle profile object id
Hash - addWaypoint - Add a profile waypoint object to the porifle waypoint array
None - clearWaypoints - Clear the profile waypoint array
None - spawn - Spawn the unit from the profile data
None - despawn - De-Spawn the unit from the profile data
Boolean - active - Flag for if the agent is spawned
Object - unit - Reference to the spawned unit

Examples:
(begin example)
// create a profile
_logic = [nil, "create"] call ALIVE_fnc_agentProfile;

// init the profile
_result = [_logic, "init"] call ALIVE_fnc_agentProfile;

// set the profile object id
_result = [_logic, "objectID", "agent_01"] call ALIVE_fnc_agentProfile;

// set the unit class of the profile
_result = [_logic, "unitClass", "B_Soldier_F"] call ALIVE_fnc_agentProfile;

// set the profile position
_result = [_logic, "position", getPos player] call ALIVE_fnc_agentProfile;

// set the profile side
_result = [_logic, "side", "WEST"] call ALIVE_fnc_agentProfile;

// set the profile group object id
_result = [_logic, "groupID", "group_01"] call ALIVE_fnc_agentProfile;

// set the profile vehcile object id
_result = [_logic, "vehicleID", "vehicle_01"] call ALIVE_fnc_agentProfile;

// add a waypoint to the profile waypoint array
_result = [_logic, "addWaypoint", _profileWaypoint] call ALIVE_fnc_agentProfile;

// clear all waypoints in the profiles waypoint array
_result = [_logic, "clearWaypoints"] call ALIVE_fnc_agentProfile;

// spawn a unit from the profile
_result = [_logic, "spawn"] call ALIVE_fnc_agentProfile;

// despawn a unit from the profile
_result = [_logic, "despawn"] call ALIVE_fnc_agentProfile;

// set the profile is active
_result = [_logic, "active", true] call ALIVE_fnc_agentProfile;

// set the profile unit object reference
_result = [_logic, "unit", _unit] call ALIVE_fnc_agentProfile;
(end)

See Also:

Author:
ARJay

Peer reviewed:
nil
---------------------------------------------------------------------------- */

#define SUPERCLASS ALIVE_fnc_profile
#define MAINCLASS ALIVE_fnc_agentProfile

private ["_logic","_operation","_args","_result"];

TRACE_1("agentProfile - input",_this);

_logic = [_this, 0, objNull, [[]]] call BIS_fnc_param;
_operation = [_this, 1, "", [""]] call BIS_fnc_param;
_args = [_this, 2, objNull, [objNull,[],"",0,true,false]] call BIS_fnc_param;
_result = true;

#define MTEMPLATE "ALiVE_AGENTPROFILE_%1"

_deleteMarkers = {
		private ["_logic"];
        _logic = _this;
        {
                deleteMarkerLocal _x;
		} forEach ([_logic,"debugMarkers"] call CBA_fnc_hashGet);
};

_createMarkers = {
        private ["_logic","_markers","_m","_position","_dimensions","_debugColor","_id"];
        _logic = _this;
        _markers = [];
        
		_position = [_logic,"position"] call CBA_fnc_hashGet;
		_debugColor = [_logic,"debugColor"] call CBA_fnc_hashGet;
		_objectID = [_logic,"objectID"] call CBA_fnc_hashGet;
		
        if(count _position > 0) then {				
				_m = createMarkerLocal [format[MTEMPLATE, _objectID], _position];
				_m setMarkerShapeLocal "ICON";
				_m setMarkerSizeLocal [1, 1];
				_m setMarkerTypeLocal "hd_dot";
				_m setMarkerColorLocal _debugColor;
                _m setMarkerTextLocal _objectID;	
				
				_markers set [count _markers, _m];
				
				[_logic,"debugMarkers",_markers] call CBA_fnc_hashSet;
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
						//[_logic,"super",SUPERCLASS] call CBA_fnc_hashSet;
						//[_logic,"class",MAINCLASS] call CBA_fnc_hashSet;
                        //TRACE_1("After module init",_logic);
						
						// set defaults
						[_logic,"debugColor","ColorGreen"] call CBA_fnc_hashSet;
						[_logic,"type","agent"] call CBA_fnc_hashSet;
						[_logic,"groupID",""] call CBA_fnc_hashSet;
						[_logic,"waypoints",[]] call CBA_fnc_hashSet;
						[_logic,"active",false] call CBA_fnc_hashSet;
						[_logic,"unit",objNull] call CBA_fnc_hashSet;		
                };
                
                /*
                VIEW - purely visual
                */
                
                /*
                CONTROLLER  - coordination
                */
        };
		case "debug": {
                if(typeName _args != "BOOL") then {
						_args = [_logic,"debug"] call CBA_fnc_hashGet;
                } else {
						[_logic,"debug",_args] call CBA_fnc_hashSet;
                };                
                ASSERT_TRUE(typeName _args == "BOOL",str _args);
				
				 _logic call _deleteMarkers;
                
                if(_args) then {
                        _logic call _createMarkers;
                };
                
                _result = _args;
        };
		case "objectID": {
				if(typeName _args == "STRING") then {
						[_logic,"objectID",_args] call CBA_fnc_hashSet;
                };
				_result = [_logic,"objectID"] call CBA_fnc_hashGet;
        };
		case "unitClass": {
				if(typeName _args == "STRING") then {
						[_logic,"unitClass",_args] call CBA_fnc_hashSet;
                };
				_result = [_logic,"unitClass"] call CBA_fnc_hashGet;
        };
		case "position": {
				if(typeName _args == "ARRAY") then {
						[_logic,"position",_args] call CBA_fnc_hashSet;
                };
				_result = [_logic,"position"] call CBA_fnc_hashGet;
        };
		case "side": {
				if(typeName _args == "STRING") then {
						[_logic,"side",_args] call CBA_fnc_hashSet;
                };
				_result = [_logic,"side"] call CBA_fnc_hashGet;
        };
		case "sideObject": {
				private ["_side"];
				_side = [_logic,"side"] call CBA_fnc_hashGet;
				switch(_side) do {
					case "WEST": {
						_result = west;
					};
					case "EAST": {
						_result = east;
					};
					case "GUER": {
						_result = guer;
					};
					case "CIV": {
						_result = civ;
					};
				};
        };
		case "groupID": {
				if(typeName _args == "STRING") then {
						[_logic,"groupID",_args] call CBA_fnc_hashSet;
                };
				_result = [_logic,"groupID"] call CBA_fnc_hashGet;
        };
		case "vehicleID": {
				if(typeName _args == "STRING") then {
						[_logic,"groupID",_args] call CBA_fnc_hashSet;
                };
				_result = [_logic,"groupID"] call CBA_fnc_hashGet;
        };
		case "addWaypoint": {
				private ["_waypoints"];
				
				if(typeName _args == "ARRAY") then {
						_waypoints = [_logic,"waypoints"] call CBA_fnc_hashGet;
						_waypoints set [count _waypoints, _args];
                };
				_result = [_logic,"waypoints"] call CBA_fnc_hashGet;
		};
		case "clearWaypoints": {
				[_logic,"waypoints",[]] call CBA_fnc_hashSet;
		};
		case "spawn": {
				private ["_profileHandler","_side","_unitClass","_position","_objectID","_groupID","_waypoints","_group","_unit","_groupProfile","_unitClasses","_unitStatus","_unitCount","_units","_waypointCount"];
				
				if(typeName _args == "ARRAY") then {
				
					_profileHandler = _args;				
				
					_side = [_logic, "sideObject"] call MAINCLASS;
					_unitClass = [_logic,"unitClass"] call CBA_fnc_hashGet;
					_position = [_logic,"position"] call CBA_fnc_hashGet;
					_objectID = [_logic,"objectID"] call CBA_fnc_hashGet;
					_groupID = [_logic,"groupID"] call CBA_fnc_hashGet;
					_waypoints = [_unitProfile,"waypoints"] call CBA_fnc_hashGet;
					
					_group = createGroup _side;
					_unit = _group createUnit [_unitClass, _position, [], 0 , "NONE"];
					_unit setVehicleVarName _objectID;
					_unit setPos _position;
					
					[_logic,"unit",_unit] call CBA_fnc_hashSet;
					[_logic,"active",true] call CBA_fnc_hashSet;
					
					// group
					if!(_groupID == "") then {
						_groupProfile = [_profileHandler, "getProfile", _groupID] call ALIVE_fnc_profileHandler;
						
						_unitClasses = [_groupProfile,"unitClasses"] call CBA_fnc_hashGet;
						_unitStatus = [_groupProfile,"unitStatus"] call CBA_fnc_hashGet;
						_unitCount = 0;
						_units = [];
						
						{
							// ignore dead status
							if(_unitStatus select _unitCount) then {
								_unit = _group createUnit [_x, _position, [], 0 , "NONE"];
								_unit setVehicleVarName format["%1_g_%2",_objectID, _unitCount];
								_units set [_unitCount, _unit];
								_unitCount = _unitCount + 1;
							};
						} forEach _unitClasses;
						
						[_groupProfile, "units", _units] call ALIVE_fnc_groupProfile;
						[_groupProfile, "active", true] call ALIVE_fnc_groupProfile;
					};
					
					// waypoints
					if(count _waypoints > 0) then {
						_waypointCount = 0;						
						{
							if(_waypointCount == 0) then {
								[_x, _group, true] call ALIVE_fnc_profileWaypointToWaypoint;
							} else {
								[_x, _group] call ALIVE_fnc_profileWaypointToWaypoint;
							};
							_waypointCount = _waypointCount + 1;
						} forEach _waypoints;						
					};
					
					_result = _unit;
				};	
		};
		case "despawn": {
				private ["_profileHandler","_active","_unit","_objectID","_groupID","_waypoints","_profileWaypoint","_group","_groupProfile","_units"];
				
				if(typeName _args == "ARRAY") then {
				
					_profileHandler = _args;				
				
					_active = [_logic,"active"] call CBA_fnc_hashGet;
					_unit = [_logic,"unit"] call CBA_fnc_hashGet;
					_objectID = [_logic,"objectID"] call CBA_fnc_hashGet;
					_groupID = [_logic,"groupID"] call CBA_fnc_hashGet;
					
					[_logic,"position", getPos _unit] call CBA_fnc_hashSet;
					
					_group = group _unit;
					
					// waypoints
					//_profileWaypoints = [waypoints _group, currentWaypoint _group] call ALIVE_fnc_waypointToProfileWaypoint;					
										
					[_logic, "clearWaypoints"] call MAINCLASS;
					_waypoints = waypoints _group;
					
					if(currentWaypoint _group < count waypoints _group) then {
						for "_i" from (currentWaypoint _group) to (count _waypoints)-1 do
						{
							_profileWaypoint = [(_waypoints select _i)] call ALIVE_fnc_waypointToProfileWaypoint;
							[_logic, "addWaypoint", _profileWaypoint] call MAINCLASS;
						};
					};
										
					deleteVehicle _unit;
					
					[_logic,"unit",objNull] call CBA_fnc_hashSet;
					[_logic,"active",false] call CBA_fnc_hashSet;
					
					if!(_groupID == "") then {
						_groupProfile = [_profileHandler, "getProfile", _groupID] call ALIVE_fnc_profileHandler;
						
						_units = [_groupProfile,"units"] call CBA_fnc_hashGet;
						
						{
							deleteVehicle _x;
						} forEach _units;
						
						[_groupProfile, "units", []] call ALIVE_fnc_groupProfile;
						[_groupProfile, "active", false] call ALIVE_fnc_groupProfile;
					};
					
					deleteGroup _group;
				};
		};		
		case "active": {
				if(typeName _args == "BOOL") then {
						[_logic,"active",_args] call CBA_fnc_hashSet;
                };
				_result = [_logic,"active"] call CBA_fnc_hashGet;
        };
		case "unit": {
				if(typeName _args == "OBJECT") then {
						[_logic,"unit",_args] call CBA_fnc_hashSet;
                };
				_result = [_logic,"unit"] call CBA_fnc_hashGet;
        };
        default {
                _result = [_logic, _operation, _args] call SUPERCLASS;
        };
};
TRACE_1("agentProfile - output",_result);
_result;