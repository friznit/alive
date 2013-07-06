#include <\x\alive\addons\sys_profile\script_component.hpp>
SCRIPT(profileEntity);

/* ----------------------------------------------------------------------------
Function: MAINCLASS
Description:
Entity profile class

Parameters:
Nil or Object - If Nil, return a new instance. If Object, reference an existing instance.
String - The selected function
Array - The selected parameters

Returns:
Any - The new instance or the result of the selected function and parameters

Attributes:
Boolean - debug - Debug enable, disable or refresh
Boolean - state - Store or restore state
String - profileID - Set the profile object id
String - companyID - Set the profile company id
Array - unitClasses - Set the profile class names
Array - position - Set the profile group position
Array - positions - Set the profile units positions
Array - damages - Set the profile units damages
Array - ranks - Set the profile units ranks
String - side - Set the profile side
String - leaderID - Set the profile group leader profile object id
String - vehicleIDs - Set the profile vehicle profile object id
Boolean - active - Flag for if the agents are spawned
Object - unit - Reference to the spawned units
None - unitCount - Returns the count of group units
None - unitIndexes - Returns the count of group units
Array - speedPerSecond - Returns the speed per second array
Hash - addVehicleAssignment - Add a profile vehicle assignment array to the profile waypoint array
None - clearVehicleAssignments - Clear the profile vehicle assignments array
Hash - addWaypoint - Add a profile waypoint object to the profile waypoint array
None - clearWaypoints - Clear the profile waypoint array
Array - mergePositions - Sets the position of all sub units to the passed position
Array - addUnit - Add a unit to the group [_class,_position,_damage]
Scalar - removeUnit - Remove a unit from the group
None - spawn - Spawn the group from the profile data
None - despawn - De-Spawn the group from the profile data

Examples:
(begin example)
// create a profile
_logic = [nil, "create"] call ALIVE_fnc_profileEntity;

// init the profile
_result = [_logic, "init"] call ALIVE_fnc_profileEntity;

// set the profile id
_result = [_logic, "profileID", "agent_01"] call ALIVE_fnc_profileEntity;

// set the profile company id
_result = [_logic, "companyID", "company_01"] call ALIVE_fnc_profileEntity;

// set the unit class of the profile
_result = [_logic, "unitClasses", ["B_Soldier_F","B_Soldier_F"]] call ALIVE_fnc_profileEntity;

// set the profile position
_result = [_logic, "position", getPos player] call ALIVE_fnc_profileEntity;

// set the profile units positions
_result = [_logic, "positions", [getPos player,getPos player]] call ALIVE_fnc_profileEntity;

// set the unit damage of the profile
_result = [_logic, "damages", [true,true]] call ALIVE_fnc_profileEntity;

// set the unit rank of the profile
_result = [_logic, "ranks", ["PRIVATE","CORPORAL"]] call ALIVE_fnc_profileEntity;

// set the profile side
_result = [_logic, "side", "WEST"] call ALIVE_fnc_profileEntity;

// set the vehicle object ids
_result = [_logic, "vehicleIDs", ["vehicle_01","vehicle_02"]] call ALIVE_fnc_profileEntity;

// set the profile is active
_result = [_logic, "active", true] call ALIVE_fnc_profileEntity;

// get the group leader
_result = [_logic, "leader"] call ALIVE_fnc_profileEntity;

// set the profile group
_result = [_logic, "group", _group] call ALIVE_fnc_profileEntity;

// set the profile units object references
_result = [_logic, "units", [_unit,_unit]] call ALIVE_fnc_profileEntity;

// get the profile units count
_result = [_logic, "unitCount"] call ALIVE_fnc_profileEntity;

// get the profile units indexes
_result = [_logic, "unitIndexes"] call ALIVE_fnc_profileEntity;

// get the profile speed per second
_result = [_logic, "speedPerSecond"] call ALIVE_fnc_profileEntity;

// add a vehicle assignment to the profile vehicle assignment array
_result = [_logic, "addVehicleAssignment", _profileVehicleAssignment] call ALIVE_fnc_profileEntity;

// clear all vehicle assignments in the profiles vehicle assignment array
_result = [_logic, "clearVehicleAssignments"] call ALIVE_fnc_profileEntity;

// add a waypoint to the profile waypoint array
_result = [_logic, "addWaypoint", _profileWaypoint] call ALIVE_fnc_profileEntity;

// clear all waypoints in the profiles waypoint array
_result = [_logic, "clearWaypoints"] call ALIVE_fnc_profileEntity;

// set all unit positions to the current profile position
_result = [_logic, "mergePositions"] call ALIVE_fnc_profileEntity;

// add a unit to the group profile
_result = [_logic, "addUnit", ["B_Soldier_F",getPos player,0]] call ALIVE_fnc_profileEntity;

// remove a unit from the group profile by unit index
_result = [_logic, "removeUnit", 1] call ALIVE_fnc_profileEntity;

// spawn the group from the profile
_result = [_logic, "spawn"] call ALIVE_fnc_profileEntity;

// despawn the group from the profile
_result = [_logic, "despawn"] call ALIVE_fnc_profileEntity;

(end)

See Also:

Author:
ARJay

Peer reviewed:
nil
---------------------------------------------------------------------------- */

#define SUPERCLASS ALIVE_fnc_profile
#define MAINCLASS ALIVE_fnc_profileEntity

private ["_logic","_operation","_args","_result"];

TRACE_1("profileEntity - input",_this);

_logic = [_this, 0, objNull, [objNull,[]]] call BIS_fnc_param;
_operation = [_this, 1, "", [""]] call BIS_fnc_param;
_args = [_this, 2, objNull, [objNull,[],"",0,true,false]] call BIS_fnc_param;
_result = true;

#define MTEMPLATE "ALiVE_PROFILEENTITY_%1"

_deleteMarkers = {
		private ["_logic"];
        _logic = _this;
        {
                deleteMarkerLocal _x;
		} forEach ([_logic,"debugMarkers", []] call ALIVE_fnc_hashGet);
};

_createMarkers = {
        private ["_logic","_markers","_m","_position","_dimensions","_debugColor","_profileID","_profileSide"];
        _logic = _this;
        _markers = [];

		_position = [_logic,"position"] call ALIVE_fnc_hashGet;
		_profileID = [_logic,"profileID"] call ALIVE_fnc_hashGet;
		_profileSide = [_logic,"side"] call ALIVE_fnc_hashGet;
		
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
				_debugColor = [_logic,"debugColor","ColorGreen"] call ALIVE_fnc_hashGet;
			};
		};

        if(count _position > 0) then {
				_m = createMarkerLocal [format[MTEMPLATE, _profileID], _position];
				_m setMarkerShapeLocal "ICON";
				_m setMarkerSizeLocal [1, 1];
				_m setMarkerTypeLocal "hd_dot";
				_m setMarkerColorLocal _debugColor;
                _m setMarkerTextLocal _profileID;

				_markers set [count _markers, _m];

				[_logic,"debugMarkers",_markers] call ALIVE_fnc_hashSet;
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

						// set defaults
						[_logic,"group",objNull] call ALIVE_fnc_hashSet;
						[_logic,"debug",false] call ALIVE_fnc_hashSet;
						[_logic,"type","entity"] call ALIVE_fnc_hashSet;
						[_logic,"companyID",""] call ALIVE_fnc_hashSet;						
						[_logic,"groupID",""] call ALIVE_fnc_hashSet;
						[_logic,"waypoints",[]] call ALIVE_fnc_hashSet;
						[_logic,"waypointsCompleted",[]] call ALIVE_fnc_hashSet;
						[_logic,"active",false] call ALIVE_fnc_hashSet;
						[_logic,"unitCount",0] call ALIVE_fnc_hashSet;
						[_logic,"units",[]] call ALIVE_fnc_hashSet;
						[_logic,"vehicleAssignments",[] call ALIVE_fnc_hashCreate] call ALIVE_fnc_hashSet;
						[_logic,"vehiclesInCommandOf",[]] call ALIVE_fnc_hashSet;
						[_logic,"vehiclesInCargoOf",[]] call ALIVE_fnc_hashSet;
						[_logic,"speedPerSecond","Man" call ALIVE_fnc_vehicleGetSpeedPerSecond] call ALIVE_fnc_hashSet;
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
						_args = [_logic,"debug"] call ALIVE_fnc_hashGet;
                } else {
						[_logic,"debug",_args] call ALIVE_fnc_hashSet;
                };
                ASSERT_TRUE(typeName _args == "BOOL",str _args);

				 _logic call _deleteMarkers;

                if(_args) then {
                        _logic call _createMarkers;
                };

                _result = _args;
        };
		case "profileID": {
				if(typeName _args == "STRING") then {
						[_logic,"profileID",_args] call ALIVE_fnc_hashSet;
                };
				_result = [_logic,"profileID"] call ALIVE_fnc_hashGet;
        };
		case "companyID": {
				if(typeName _args == "STRING") then {
						[_logic,"companyID",_args] call ALIVE_fnc_hashSet;
                };
				_result = [_logic,"companyID"] call ALIVE_fnc_hashGet;
        };
		case "unitClasses": {
				if(typeName _args == "ARRAY") then {
						[_logic,"unitClasses",_args] call ALIVE_fnc_hashSet;
                };
				_result = [_logic,"unitClasses"] call ALIVE_fnc_hashGet;
        };
		case "position": {
				if(typeName _args == "ARRAY") then {
						[_logic,"position",_args] call ALIVE_fnc_hashSet;
						
						if([_logic,"debug"] call ALIVE_fnc_hashGet) then {
							[_logic,"debug",true] call MAINCLASS;
						};
                };
				_result = [_logic,"position"] call ALIVE_fnc_hashGet;
        };
		case "positions": {
				if(typeName _args == "ARRAY") then {
						[_logic,"positions",_args] call ALIVE_fnc_hashSet;
                };
				_result = [_logic,"positions"] call ALIVE_fnc_hashGet;
        };
		case "damages": {
				if(typeName _args == "ARRAY") then {
						[_logic,"damages",_args] call ALIVE_fnc_hashSet;
                };
				_result = [_logic,"damages"] call ALIVE_fnc_hashGet;
        };
		case "ranks": {
				if(typeName _args == "ARRAY") then {
						[_logic,"ranks",_args] call ALIVE_fnc_hashSet;
                };
				_result = [_logic,"ranks"] call ALIVE_fnc_hashGet;
        };
		case "side": {
				if(typeName _args == "STRING") then {
						[_logic,"side",_args] call ALIVE_fnc_hashSet;
                };
				_result = [_logic,"side"] call ALIVE_fnc_hashGet;
        };
		case "vehicleIDs": {
				if(typeName _args == "ARRAY") then {
						[_logic,"vehicleIDs",_args] call ALIVE_fnc_hashSet;
                };
				_result = [_logic,"vehicleIDs"] call ALIVE_fnc_hashGet;
        };
		case "active": {
				if(typeName _args == "BOOL") then {
						[_logic,"active",_args] call ALIVE_fnc_hashSet;
                };
				_result = [_logic,"active"] call ALIVE_fnc_hashGet;
        };
		case "leader": {
				if(typeName _args == "OBJECT") then {
						[_logic,"leader",_args] call ALIVE_fnc_hashSet;
                };
				_result = [_logic,"leader"] call ALIVE_fnc_hashGet;
        };
		case "group": {
				if(typeName _args == "OBJECT") then {
						[_logic,"group",_args] call ALIVE_fnc_hashSet;
                };
				_result = [_logic,"group"] call ALIVE_fnc_hashGet;
        };
		case "units": {
				if(typeName _args == "ARRAY") then {
						[_logic,"units",_args] call ALIVE_fnc_hashSet;
                };
				_result = [_logic,"units"] call ALIVE_fnc_hashGet;
        };
		case "unitCount": {
				private ["_unitClasses","_unitCount"];
				_unitClasses = [_logic,"unitClasses"] call ALIVE_fnc_hashGet;
				_unitCount = count _unitClasses;
				[_logic,"unitCount",_unitCount] call ALIVE_fnc_hashSet;

				_result = _unitCount;
        };
		case "unitIndexes": {
				private ["_unitIndexes","_unitCount"];
				_unitCount = [_logic, "unitCount"] call MAINCLASS;
				_unitIndexes = [];
				for "_i" from 0 to _unitCount-1 do {
					_unitIndexes set [_i, _i];
				};

				_result = _unitIndexes;
        };
		case "speedPerSecond": {				
				if(typeName _args == "ARRAY") then {
						[_logic,"speedPerSecond",_args] call ALIVE_fnc_hashSet;
                };
				_result = [_logic,"speedPerSecond"] call ALIVE_fnc_hashGet;
        };
		case "addVehicleAssignment": {
				private ["_assignments","_key"];

				if(typeName _args == "ARRAY") then {
						_assignments = [_logic,"vehicleAssignments"] call ALIVE_fnc_hashGet;
						_key = _args select 0;
						[_assignments, _key, _args] call ALIVE_fnc_hashSet;
						
						// take assignments and determine if this entity is in command of any of them
						[_logic,"vehiclesInCommandOf",[_assignments,_logic] call ALIVE_fnc_profileVehicleAssignmentsGetInCommand] call ALIVE_fnc_hashSet;
						
						// take assignments and determine if this entity is in cargo of any of them
						[_logic,"vehiclesInCargoOf",[_assignments,_logic] call ALIVE_fnc_profileVehicleAssignmentsGetInCargo] call ALIVE_fnc_hashSet;
						
						// take assignments and determine the max speed per second for the entire group
						[_logic,"speedPerSecond",[_assignments,_logic] call ALIVE_fnc_profileVehicleAssignmentsGetSpeedPerSecond] call ALIVE_fnc_hashSet;

						if([_logic,"active"] call ALIVE_fnc_hashGet) then {
							[_args, _logic] call ALIVE_fnc_profileVehicleAssignmentToVehicleAssignment;
						};
                };
		};
		case "clearVehicleAssignments": {
				[_logic,"vehicleAssignments",[] call ALIVE_fnc_hashCreate] call ALIVE_fnc_hashSet;
				[_logic,"vehiclesInCommandOf",[]] call ALIVE_fnc_hashSet;
				[_logic,"vehiclesInCargoOf",[]] call ALIVE_fnc_hashSet;
		};
		case "addWaypoint": {
				private ["_waypoints","_units","_unit","_group"];

				if(typeName _args == "ARRAY") then {
						_waypoints = [_logic,"waypoints"] call ALIVE_fnc_hashGet;
						_waypoints set [count _waypoints, _args];

						if([_logic,"active"] call ALIVE_fnc_hashGet) then {
							_units = [_logic,"units"] call ALIVE_fnc_hashGet;
							_unit = _units select 0;
							_group = group _unit;
							[_args, _group] call ALIVE_fnc_profileWaypointToWaypoint;
						}
                };
		};
		case "clearWaypoints": {
				private ["_units","_unit","_group"];

				[_logic,"waypoints",[]] call ALIVE_fnc_hashSet;

				if([_logic,"active"] call ALIVE_fnc_hashGet) then {
						_units = [_logic,"units"] call ALIVE_fnc_hashGet;
						_unit = _units select 0;
						_group = group _unit;
						while { count (waypoints _group) > 0 } do
						{
							deleteWaypoint ((waypoints _group) select 0);
						};
				}
		};
		case "mergePositions": {
				private ["_position","_unitCount","_positions"];

				_position = [_logic,"position"] call ALIVE_fnc_hashGet;
				_unitCount = [_logic,"unitCount"] call MAINCLASS;
				_positions = [_logic,"positions"] call ALIVE_fnc_hashGet;

				for "_i" from 0 to _unitCount-1 do
				{
						_positions set [_i, _position];
				};
		};
		case "addUnit": {
				private ["_class","_position","_damage","_rank","_unitIndex","_unitClasses","_positions","_damages","_ranks"];

				if(typeName _args == "ARRAY") then {
						_class = _args select 0;
						_position = _args select 1;
						_damage = _args select 2;
						_rank = _args select 3;
						_unitClasses = [_logic,"unitClasses"] call ALIVE_fnc_hashGet;
						_positions = [_logic,"positions"] call ALIVE_fnc_hashGet;
						_damages = [_logic,"damages"] call ALIVE_fnc_hashGet;
						_ranks = [_logic,"ranks"] call ALIVE_fnc_hashGet;

						_unitIndex = count _unitClasses;

						_unitClasses set [_unitIndex, _class];
						_positions set [_unitIndex, _position];
						_damages set [_unitIndex, _damage];
						_ranks set [_unitIndex, _rank];
                };
		};
		case "removeUnit": {
				private ["_unitIndex","_unitClass","_damages","_ranks","_units","_unitClasses","_positions"];

				if(typeName _args == "SCALAR") then {
						_unitIndex = _args;
						_unitClasses = [_logic,"unitClasses"] call ALIVE_fnc_hashGet;
						_positions = [_logic,"positions"] call ALIVE_fnc_hashGet;
						_damages = [_logic,"damages"] call ALIVE_fnc_hashGet;
						_ranks = [_logic,"ranks"] call ALIVE_fnc_hashGet;

						_unitClasses set [_unitIndex, objNull];
						_unitClasses = _unitClasses - [objNull];
						_positions set [_unitIndex, objNull];
						_positions = _positions - [objNull];
						_damages set [_unitIndex, objNull];
						_damages = _damages - [objNull];
						_ranks set [_unitIndex, objNull];
						_ranks = _ranks - [objNull];

						[_logic,"unitClasses",_unitClasses] call ALIVE_fnc_hashSet;
						[_logic,"positions",_positions] call ALIVE_fnc_hashSet;
						[_logic,"damages",_damages] call ALIVE_fnc_hashSet;
						[_logic,"ranks",_ranks] call ALIVE_fnc_hashSet;

						if([_logic,"active"] call ALIVE_fnc_hashGet) then {
							_units = [_logic,"units"] call ALIVE_fnc_hashGet;
							_units set [_unitIndex, objNull];
							_units = _units - [objNull];
							[_logic,"units",_units] call ALIVE_fnc_hashSet;
						};
						
						_result = true;
						if(count(_unitClasses) == 0) then {
							_result = false;
						};
                };
		};
		case "removeUnitByObject": {
				private ["_units","_unitIndex"];
		
				if(typeName _args == "OBJECT") then {
					_units = [_logic,"units"] call ALIVE_fnc_hashGet;
					_unitIndex = 0;
					{
						if(_x == _args) then {
							_result = [_logic, "removeUnit", _unitIndex] call MAINCLASS;
						};
						_unitIndex = _unitIndex + 1;
					} forEach _units;
				};
		};
		case "spawn": {
				private ["_side","_sideObject","_unitClasses","_unitClass","_position","_positions","_damage","_damages","_ranks","_rank",
				"_profileID","_active","_waypoints","_vehicleAssignments","_group","_unitPosition","_eventID","_waypointCount","_unitCount","_units","_unit"];

				_profileID = [_logic,"profileID"] call ALIVE_fnc_hashGet;
				_side = [_logic, "side"] call MAINCLASS;
				_sideObject = [_side] call ALIVE_fnc_sideTextToObject;
				_unitClasses = [_logic,"unitClasses"] call ALIVE_fnc_hashGet;
				_position = [_logic,"position"] call ALIVE_fnc_hashGet;
				_positions = [_logic,"positions"] call ALIVE_fnc_hashGet;
				_damages = [_logic,"damages"] call ALIVE_fnc_hashGet;
				_ranks = [_logic,"ranks"] call ALIVE_fnc_hashGet;
				_active = [_logic,"active"] call ALIVE_fnc_hashGet;
				_waypoints = [_logic,"waypoints"] call ALIVE_fnc_hashGet;
				_vehicleAssignments = [_logic,"vehicleAssignments"] call ALIVE_fnc_hashGet;
				_unitCount = 0;
				_units = [];

				// not already active
				if!(_active) then {

					_group = createGroup _sideObject;

					{
						// ignore dead status
						if(_damages select _unitCount < 1) then {
							_unitPosition = _positions select _unitCount;
							_damage = _damages select _unitCount;
							_rank = _ranks select _unitCount;
							_unit = _group createUnit [_x, _unitPosition, [], 5 , "NONE"];
							_unit setVehicleVarName format["%1_%2",_profileID, _unitCount];
							_unit setDamage _damage;
							_unit setRank _rank;

							// set profile id on the unit
							_unit setVariable ["profileID", _profileID];
							_unit setVariable ["profileIndex", _unitCount];

							// killed event handler
							_eventID = _unit addEventHandler["Killed", ALIVE_fnc_profileKilledEventHandler];

							_units set [_unitCount, _unit];
						} else {
							_units set [_unitCount, objNull];
						};
						_unitCount = _unitCount + 1;
					} forEach _unitClasses;

					// set group profile as active and store references to units on the profile
					[_logic,"leader", leader _group] call ALIVE_fnc_hashSet;
					[_logic,"group", _group] call ALIVE_fnc_hashSet;
					[_logic,"units", _units] call ALIVE_fnc_hashSet;
					[_logic,"active", true] call ALIVE_fnc_hashSet;

					// create waypoints from profile waypoints
					[_waypoints, _group] call ALIVE_fnc_profileWaypointsToWaypoints;

					// create vehicle assignments from profile vehicle assignments
					[_vehicleAssignments, _logic] call ALIVE_fnc_profileVehicleAssignmentsToVehicleAssignments;
				};
		};
		case "despawn": {
				private ["_group","_leader","_units","_positions","_damages","_ranks","_active","_profileID","_unitCount","_waypoints",
				"_profileWaypoint","_unit","_vehicle","_vehicleID","_profileVehicle","_profileVehicleAssignments","_assignments","_vehicleAssignments"];

				_group = [_logic,"group"] call ALIVE_fnc_hashGet;
				_leader = [_logic,"leader"] call ALIVE_fnc_hashGet;
				_units = [_logic,"units"] call ALIVE_fnc_hashGet;
				_positions = [_logic,"positions"] call ALIVE_fnc_hashGet;
				_damages = [_logic,"damages"] call ALIVE_fnc_hashGet;
				_ranks = [_logic,"ranks"] call ALIVE_fnc_hashGet;
				_active = [_logic,"active"] call ALIVE_fnc_hashGet;
				_profileID = [_logic,"profileID"] call ALIVE_fnc_hashGet;
				_unitCount = 0;

				// not already inactive
				if(_active) then {

					[_logic, "active", false] call ALIVE_fnc_hashSet;

					// update profile waypoints before despawn
					[_logic, "clearWaypoints"] call MAINCLASS;
					[_logic,_group] call ALIVE_fnc_waypointsToProfileWaypoints;
					
					// update profile vehicle assignments before despawn
					[_logic, "clearVehicleAssignments"] call MAINCLASS;					
					[_logic] call ALIVE_fnc_vehicleAssignmentsToProfileVehicleAssignments;
					
					// update the profiles position
					[_logic, "position", getPosATL _leader] call ALIVE_fnc_hashSet;

					// delete units
					{
						_unit = _x;
						if!(isNull _unit) then {
							_positions set [_unitCount, getPosATL _unit];
							_damages set [_unitCount, getDammage _unit];
							_ranks set [_unitCount, rank _unit];
							deleteVehicle _unit;
						};
						_unitCount = _unitCount + 1;
					} forEach _units;

					// delete group
					deleteGroup _group;

					[_logic,"leader", objNull] call ALIVE_fnc_hashSet;
					[_logic,"positions", _positions] call ALIVE_fnc_hashSet;
					[_logic,"damages", _damages] call ALIVE_fnc_hashSet;
					[_logic,"group", objNull] call ALIVE_fnc_hashSet;
					[_logic,"units", []] call ALIVE_fnc_hashSet;
				};
		};
		case "handleDeath": {
				if(typeName _args == "OBJECT") then {
					_result = [_logic, "removeUnitByObject", _args] call MAINCLASS;
				};
		};
        default {
                _result = [_logic, _operation, _args] call SUPERCLASS;
        };
};
TRACE_1("profileEntity - output",_result);
_result;