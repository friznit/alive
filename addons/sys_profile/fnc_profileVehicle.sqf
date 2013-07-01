#include <\x\alive\addons\sys_profile\script_component.hpp>
SCRIPT(profileVehicle);

/* ----------------------------------------------------------------------------
Function: MAINCLASS
Description:
Vehicle profile class

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
Array - vehicleClass - Set the profile class name
String - side - Set the profile side
Array - position - Set the profile position
Scalar - direction - Set the profile direction
Array - damage - Set the profile damage, format is array returned from ALIVE_fnc_vehicleGetDamage
Scalar - fuel - Set the profile fuel
Array - ammo - Set the profile ammo, format is array returned from ALIVE_fnc_vehicleGetAmmo
Boolean - active - Flag for if the agents are spawned
Object - vehicle - Reference to the spawned vehicle
None - spawn - Spawn the vehicle from the profile data
None - despawn - De-Spawn the vehicle from the profile data

Examples:
(begin example)
// create a profile
_logic = [nil, "create"] call ALIVE_fnc_profileVehicle;

// init the profile
_result = [_logic, "init"] call ALIVE_fnc_profileVehicle;

// set the profile profile id
_result = [_logic, "profileID", "agent_01"] call ALIVE_fnc_profileVehicle;

// set the vehicle class of the profile
_result = [_logic, "vehicleClass", "B_MRAP_01_hmg_F"] call ALIVE_fnc_profileVehicle;

// set the unit position of the profile
_result = [_logic, "position", getPos player] call ALIVE_fnc_profileVehicle;

// set the unit direction of the profile
_result = [_logic, "direction", 180] call ALIVE_fnc_profileVehicle;

// set the unit damage of the profile
_result = [_logic, "damage", _damage] call ALIVE_fnc_profileVehicle;

// set the profile side
_result = [_logic, "side", "WEST"] call ALIVE_fnc_profileVehicle;

// set the unit fuel of the profile
_result = [_logic, "fuel", 1] call ALIVE_fnc_profileVehicle;

// set the unit ammo of the profile
_result = [_logic, "ammo", _ammo] call ALIVE_fnc_profileVehicle;

// set the profile is active
_result = [_logic, "active", true] call ALIVE_fnc_profileVehicle;

// set the profile vehicle object reference
_result = [_logic, "vehicle", _unit] call ALIVE_fnc_profileVehicle;

// spawn a vehicle from the profile
_result = [_logic, "spawn"] call ALIVE_fnc_profileVehicle;

// despawn a vehicle from the profile
_result = [_logic, "despawn"] call ALIVE_fnc_profileVehicle;
(end)

See Also:

Author:
ARJay

Peer reviewed:
nil
---------------------------------------------------------------------------- */

#define SUPERCLASS ALIVE_fnc_profile
#define MAINCLASS ALIVE_fnc_profileVehicle

private ["_logic","_operation","_args","_result"];

TRACE_1("profileVehicle - input",_this);

_logic = [_this, 0, objNull, [objNull,[]]] call BIS_fnc_param;
_operation = [_this, 1, "", [""]] call BIS_fnc_param;
_args = [_this, 2, objNull, [objNull,[],"",0,true,false]] call BIS_fnc_param;
_result = true;

#define MTEMPLATE "ALiVE_PROFILEVEHICLE_%1"

_deleteMarkers = {
		private ["_logic"];
        _logic = _this;
        {
                deleteMarkerLocal _x;
		} forEach ([_logic,"debugMarkers", []] call ALIVE_fnc_hashGet);
};

_createMarkers = {
        private ["_logic","_markers","_m","_position","_dimensions","_debugColor","_id"];
        _logic = _this;
        _markers = [];

		_position = [_logic,"position"] call ALIVE_fnc_hashGet;
		_debugColor = [_logic,"debugColor","ColorGreen"] call ALIVE_fnc_hashGet;
		_profileID = [_logic,"profileID"] call ALIVE_fnc_hashGet;

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
						[_logic,"debug",false] call ALIVE_fnc_hashSet;
						[_logic,"fuel",1] call ALIVE_fnc_hashSet;
						[_logic,"ammo",[]] call ALIVE_fnc_hashSet;
						[_logic,"engineOn",false] call ALIVE_fnc_hashSet;
						[_logic,"damage",[]] call ALIVE_fnc_hashSet;
						[_logic,"canMove",true] call ALIVE_fnc_hashSet;
						[_logic,"canFire",true] call ALIVE_fnc_hashSet;
						[_logic,"needReload",0] call ALIVE_fnc_hashSet;
						[_logic,"type","vehicle"] call ALIVE_fnc_hashSet;
						[_logic,"active",false] call ALIVE_fnc_hashSet;
						[_logic,"vehicleAssignments",[]] call ALIVE_fnc_hashSet;
						[_logic,"entitiesInCommandOf",[]] call ALIVE_fnc_hashSet;
						[_logic,"entitiesInCargoOf",[]] call ALIVE_fnc_hashSet;
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
		case "vehicleClass": {
				if(typeName _args == "STRING") then {
						[_logic,"vehicleClass",_args] call ALIVE_fnc_hashSet;						
						[_logic,"vehicleType",_args call ALIVE_fnc_vehicleGetKindOf] call ALIVE_fnc_hashSet;
                };
				_result = [_logic,"vehicleClass"] call ALIVE_fnc_hashGet;
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
		case "direction": {
				if(typeName _args == "SCALAR") then {
						[_logic,"direction",_args] call ALIVE_fnc_hashSet;
                };
				_result = [_logic,"direction"] call ALIVE_fnc_hashGet;
        };
		case "damage": {
				if(typeName _args == "ARRAY") then {
						[_logic,"damage",_args] call ALIVE_fnc_hashSet;
                };
				_result = [_logic,"damage"] call ALIVE_fnc_hashGet;
        };
		case "side": {
				if(typeName _args == "STRING") then {
						[_logic,"side",_args] call ALIVE_fnc_hashSet;
                };
				_result = [_logic,"side"] call ALIVE_fnc_hashGet;
        };
		case "fuel": {
				if(typeName _args == "SCALAR") then {
						[_logic,"fuel",_args] call ALIVE_fnc_hashSet;
                };
				_result = [_logic,"fuel"] call ALIVE_fnc_hashGet;
        };
		case "ammo": {
				if(typeName _args == "ARRAY") then {
						[_logic,"ammo",_args] call ALIVE_fnc_hashSet;
                };
				_result = [_logic,"ammo"] call ALIVE_fnc_hashGet;
        };
		case "engineOn": {
				if(typeName _args == "BOOL") then {
						[_logic,"engineOn",_args] call ALIVE_fnc_hashSet;
                };
				_result = [_logic,"engineOn"] call ALIVE_fnc_hashGet;
        };
		case "canFire": {
				if(typeName _args == "BOOL") then {
						[_logic,"canFire",_args] call ALIVE_fnc_hashSet;
                };
				_result = [_logic,"canFire"] call ALIVE_fnc_hashGet;
        };
		case "canMove": {
				if(typeName _args == "BOOL") then {
						[_logic,"canMove",_args] call ALIVE_fnc_hashSet;
                };
				_result = [_logic,"canMove"] call ALIVE_fnc_hashGet;
        };
		case "needReload": {
				if(typeName _args == "SCALAR") then {
						[_logic,"needReload",_args] call ALIVE_fnc_hashSet;
                };
				_result = [_logic,"needReload"] call ALIVE_fnc_hashGet;
        };
		case "active": {
				if(typeName _args == "BOOL") then {
						[_logic,"active",_args] call ALIVE_fnc_hashSet;
                };
				_result = [_logic,"active"] call ALIVE_fnc_hashGet;
        };
		case "vehicle": {
				if(typeName _args == "OBJECT") then {
						[_logic,"vehicle",_args] call ALIVE_fnc_hashSet;
                };
				_result = [_logic,"vehicle"] call ALIVE_fnc_hashGet;
        };
		case "vehicleType": {
				if(typeName _args == "STRING") then {
						[_logic,"vehicleType",_args] call ALIVE_fnc_hashSet;
                };
				_result = [_logic,"vehicleType"] call ALIVE_fnc_hashGet;
        };
		case "addVehicleAssignment": {
				private ["_assignments","_units","_unit","_group"];

				if(typeName _args == "ARRAY") then {
						_assignments = [_logic,"vehicleAssignments"] call ALIVE_fnc_hashGet;
						_assignments set [count _assignments, _args];
						
						// take assignments and determine if this entity is in command of any of them
						[_logic,"entitiesInCommandOf",_assignments call ALIVE_fnc_profileVehicleAssignmentsGetInCommand] call ALIVE_fnc_hashSet;
						
						// take assignments and determine if this entity is in cargo of any of them
						[_logic,"entitiesInCargoOf",_assignments call ALIVE_fnc_profileVehicleAssignmentsGetInCargo] call ALIVE_fnc_hashSet;
                };
		};
		case "clearVehicleAssignments": {
				private ["_units","_unit","_group"];

				[_logic,"vehicleAssignments",[]] call ALIVE_fnc_hashSet;
				[_logic,"entitiesInCommandOf",[]] call ALIVE_fnc_hashSet;
				[_logic,"entitiesInCargoOf",[]] call ALIVE_fnc_hashSet;
				
		};
		case "mergePositions": {
				private ["_position","_assignments"];

				_position = [_logic,"position"] call ALIVE_fnc_hashGet;				
				_assignments = [_logic,"vehicleAssignments"] call ALIVE_fnc_hashGet;
				
				if(count _assignments > 0) then {
					[_assignments,_position] call ALIVE_fnc_profileVehicleAssignmentsSetAllPositions;
				};
		};
		case "spawn": {
				private ["_side","_vehicleClass","_vehicleType","_position","_direction","_damage","_fuel","_ammo","_engineOn","_profileID","_active","_vehicleAssignments","_special","_vehicle","_eventID"];

				_vehicleClass = [_logic,"vehicleClass"] call ALIVE_fnc_hashGet;
				_vehicleType = [_logic,"vehicleType"] call ALIVE_fnc_hashGet;
				_position = [_logic,"position"] call ALIVE_fnc_hashGet;
				_direction = [_logic,"direction"] call ALIVE_fnc_hashGet;
				_damage = [_logic,"damage"] call ALIVE_fnc_hashGet;
				_fuel = [_logic,"fuel"] call ALIVE_fnc_hashGet;
				_ammo = [_logic,"ammo"] call ALIVE_fnc_hashGet;
				_engineOn = [_logic,"engineOn"] call ALIVE_fnc_hashGet;
				_profileID = [_logic,"profileID"] call ALIVE_fnc_hashGet;
				_active = [_logic,"active"] call ALIVE_fnc_hashGet;
				_vehicleAssignments = [_logic,"vehicleAssignments"] call ALIVE_fnc_hashGet;

				// not already active
				if!(_active) then {

					// spawn the unit
					if((_position select 2)>5 && _engineOn && (_vehicleType=="Helicopter" || _vehicleType=="Plane")) then {
						_special = "FLY";
					}else{
						_special = "NONE";
					};
					
					_vehicle = createVehicle [_vehicleClass, _position, [], 0, _special];
					_vehicle setPos _position;
					_vehicle setDir _direction;
					_vehicle setFuel _fuel;
					_vehicle engineOn _engineOn;
					_vehicle setVehicleVarName _profileID;

					if(count _damage > 0) then {
						[_vehicle, _damage] call ALIVE_fnc_vehicleSetDamage;
					};

					if(count _ammo > 0) then {
						[_vehicle, _ammo] call ALIVE_fnc_vehicleSetAmmo;
					};

					// set profile id on the unit
					_vehicle setVariable ["profileID", _profileID];

					// killed event handler
					_eventID = _vehicle addEventHandler["Killed", ALIVE_fnc_profileKilledEventHandler];

					// set profile as active and store a reference to the unit on the profile
					[_logic,"vehicle",_vehicle] call ALIVE_fnc_hashSet;
					[_logic,"active",true] call ALIVE_fnc_hashSet;

					// create vehicle assignments from profile vehicle assignments
					if(count _vehicleAssignments > 0) then {
						{
							[_x, _logic] call ALIVE_fnc_profileVehicleAssignmentToVehicleAssignment;
						} forEach _vehicleAssignments;
					};
				};
		};
		case "despawn": {
				private ["_active","_vehicle","_profileID"];

				_active = [_logic,"active"] call ALIVE_fnc_hashGet;
				_vehicle = [_logic,"vehicle"] call ALIVE_fnc_hashGet;
				_profileID = [_logic,"profileID"] call ALIVE_fnc_hashGet;

				// not already inactive
				if(_active) then {

					// update profile before despawn
					[_logic,"position", getPosATL _vehicle] call ALIVE_fnc_hashSet;
					[_logic,"direction", getDir _vehicle] call ALIVE_fnc_hashSet;
					[_logic,"damage", _vehicle call ALIVE_fnc_vehicleGetDamage] call ALIVE_fnc_hashSet;
					[_logic,"fuel", fuel _vehicle] call ALIVE_fnc_hashSet;
					[_logic,"ammo", _vehicle call ALIVE_fnc_vehicleGetAmmo] call ALIVE_fnc_hashSet;
					[_logic,"engineOn", isEngineOn _vehicle] call ALIVE_fnc_hashSet;
					[_logic,"canFire", canFire _vehicle] call ALIVE_fnc_hashSet;
					[_logic,"canMove", canMove _vehicle] call ALIVE_fnc_hashSet;
					[_logic,"needReload", needReload _vehicle] call ALIVE_fnc_hashSet;
					[_logic,"vehicle",objNull] call ALIVE_fnc_hashSet;
					[_logic,"active",false] call ALIVE_fnc_hashSet;

					// delete
					deleteVehicle _vehicle;
				};
		};
		case "handleDeath": {
				[_logic,"damage",1] call ALIVE_fnc_hashSet;
		};
        default {
                _result = [_logic, _operation, _args] call SUPERCLASS;
        };
};
TRACE_1("profileVehicle - output",_result);
_result;