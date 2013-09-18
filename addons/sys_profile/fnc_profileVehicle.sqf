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

private ["_logic","_operation","_args","_result","_deleteMarkers","_createMarkers"];

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
                deleteMarker _x;
		} forEach ([_logic,"debugMarkers", []] call ALIVE_fnc_hashGet);
};

_createMarkers = {
        private ["_logic","_markers","_m","_position","_profileID","_debugColor","_debugIcon","_debugAlpha","_profileSide","_vehicleType","_profileActive","_typePrefix"];
        _logic = _this;
        _markers = [];

		_position = [_logic,"position"] call ALIVE_fnc_hashGet;
		_profileID = [_logic,"profileID"] call ALIVE_fnc_hashGet;
		_profileSide = [_logic,"side"] call ALIVE_fnc_hashGet;
		_vehicleType = [_logic,"objectType"] call ALIVE_fnc_hashGet;
		_profileActive = [_logic,"active"] call ALIVE_fnc_hashGet;
		
		switch(_profileSide) do {
			case "EAST":{
				_debugColor = "ColorRed";
				_typePrefix = "o";
			};
			case "WEST":{
				_debugColor = "ColorBlue";
				_typePrefix = "b";
			};
			case "CIV":{
				_debugColor = "ColorYellow";
				_typePrefix = "n";
			};
			case "GUER":{
				_debugColor = "ColorGreen";
				_typePrefix = "n";
			};
			default {
				_debugColor = [_logic,"debugColor","ColorGreen"] call ALIVE_fnc_hashGet;
				_typePrefix = "n";
			};
		};
		
		switch(_vehicleType) do {
			case "Car":{
				_debugIcon = format["%1_recon",_typePrefix];
			};
			case "Tank":{
				_debugIcon = format["%1_armor",_typePrefix];
			};
			case "Armored":{
				_debugIcon = format["%1_armor",_typePrefix];
			};
			case "Truck":{
				_debugIcon = format["%1_recon",_typePrefix];
			};
			case "Ship":{
				_debugIcon = format["%1_unknown",_typePrefix];
			};
			case "Helicopter":{
				_debugIcon = format["%1_air",_typePrefix];
			};
			case "Plane":{
				_debugIcon = format["%1_plane",_typePrefix];
			};
			case "StaticWeapon":{
				_debugIcon = format["%1_mortar",_typePrefix];
			};
			default {
				_debugIcon = "hd_dot";
			};
		};
		
		_debugAlpha = 0.5;
		if(_profileActive) then {
			_debugAlpha = 1;
		};
		
        if(count _position > 0) then {
				_m = createMarker [format[MTEMPLATE, _profileID], _position];
				_m setMarkerShape "ICON";
				_m setMarkerSize [1, 1];
				_m setMarkerType _debugIcon;
				_m setMarkerColor _debugColor;
				_m setMarkerAlpha _debugAlpha;
				
				/*
				_label = [_profileID, "_"] call CBA_fnc_split;
				_m setMarkerText format["v%1",_label select 1];
				*/
				
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
						
						// init the super class
						[_logic, "init"] call SUPERCLASS;

						// set defaults
						[_logic,"type","vehicle"] call ALIVE_fnc_hashSet;
						[_logic,"entitiesInCommandOf",[]] call ALIVE_fnc_hashSet; // select 2 select 8
						[_logic,"entitiesInCargoOf",[]] call ALIVE_fnc_hashSet; // select 2 select 9
						[_logic,"vehicle",objNull] call ALIVE_fnc_hashSet; // select 2 select 10
						[_logic,"vehicleClass",""] call ALIVE_fnc_hashSet; // select 2 select 11
						[_logic,"direction",""] call ALIVE_fnc_hashSet; // select 2 select 12
						[_logic,"fuel",1] call ALIVE_fnc_hashSet; // select 2 select 13
						[_logic,"ammo",[]] call ALIVE_fnc_hashSet; // select 2 select 14
						[_logic,"engineOn",false] call ALIVE_fnc_hashSet; // select 2 select 15
						[_logic,"damage",[]] call ALIVE_fnc_hashSet; // select 2 select 16
						[_logic,"canMove",true] call ALIVE_fnc_hashSet; // select 2 select 17
						[_logic,"canFire",true] call ALIVE_fnc_hashSet; // select 2 select 18
						[_logic,"needReload",0] call ALIVE_fnc_hashSet; // select 2 select 19
						[_logic,"despawnPosition",[0,0]] call ALIVE_fnc_hashSet; // select 2 select 20
						[_logic,"hasSimulated",false] call ALIVE_fnc_hashSet; // select 2 select 21
						[_logic,"spawnType",[]] call ALIVE_fnc_hashSet; // select 2 select 22
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
		case "active": {
				if(typeName _args == "BOOL") then {
						[_logic,"active",_args] call ALIVE_fnc_hashSet;
                };
				_result = [_logic,"active"] call ALIVE_fnc_hashGet;
        };
		case "profileID": {
				if(typeName _args == "STRING") then {
						[_logic,"profileID",_args] call ALIVE_fnc_hashSet;
                };
				_result = [_logic,"profileID"] call ALIVE_fnc_hashGet;
        };
		case "side": {
				if(typeName _args == "STRING") then {
						[_logic,"side",_args] call ALIVE_fnc_hashSet;
                };
				_result = [_logic,"side"] call ALIVE_fnc_hashGet;
        };
		case "objectType": {
				if(typeName _args == "STRING") then {
						[_logic,"objectType",_args] call ALIVE_fnc_hashSet;
                };
				_result = [_logic,"objectType"] call ALIVE_fnc_hashGet;
        };
		case "vehicleClass": {
				if(typeName _args == "STRING") then {
						[_logic,"vehicleClass",_args] call ALIVE_fnc_hashSet;						
						[_logic,"objectType",_args call ALIVE_fnc_vehicleGetKindOf] call ALIVE_fnc_hashSet;
                };
				_result = _logic select 2 select 11; //[_logic,"vehicleClass"] call ALIVE_fnc_hashGet;
        };
		case "position": {
				if(typeName _args == "ARRAY") then {
				
						if(count _args == 2) then  {
							_args set [count _args, 0];
						};
				
						[_logic,"position",_args] call ALIVE_fnc_hashSet;
						
						if([_logic,"debug"] call ALIVE_fnc_hashGet) then {
							[_logic,"debug",true] call MAINCLASS;
						};
						
						// store position on handler position index						
						_profileID = _logic select 2 select 4; //[_logic,"profileID"] call ALIVE_fnc_hashGet;
						[ALIVE_profileHandler, "setPosition", [_profileID, _args]] call ALIVE_fnc_profileHandler;
                };
				_result = [_logic,"position"] call ALIVE_fnc_hashGet;
        };
		case "despawnPosition": {
				if(typeName _args == "ARRAY") then {
						[_logic,"despawnPosition",_args] call ALIVE_fnc_hashSet;
                };
				_result = [_logic,"despawnPosition"] call ALIVE_fnc_hashGet;
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
		case "vehicle": {
				if(typeName _args == "OBJECT") then {
						[_logic,"vehicle",_args] call ALIVE_fnc_hashSet;
                };
				_result = [_logic,"vehicle"] call ALIVE_fnc_hashGet;
        };
		case "spawnType": {
				if(typeName _args == "ARRAY") then {
						[_logic,"spawnType",_args] call ALIVE_fnc_hashSet;
                };
				_result = [_logic,"spawnType"] call ALIVE_fnc_hashGet;
        };
		case "addVehicleAssignment": {
				private ["_assignments","_key","_units","_unit","_group"];

				if ((typeName _args == "ARRAY") && {!(isnil {_args select 1})}) then {
						_assignments = _logic select 2 select 7; //[_logic,"vehicleAssignments"] call ALIVE_fnc_hashGet;
						_key = _args select 1;
						[_assignments, _key, _args] call ALIVE_fnc_hashSet;
						
						// take assignments and determine if this entity is in command of any of them
						[_logic,"entitiesInCommandOf",[_assignments,_logic] call ALIVE_fnc_profileVehicleAssignmentsGetInCommand] call ALIVE_fnc_hashSet;
						
						// take assignments and determine if this entity is in cargo of any of them
						[_logic,"entitiesInCargoOf",[_assignments,_logic] call ALIVE_fnc_profileVehicleAssignmentsGetInCargo] call ALIVE_fnc_hashSet;
                };
		};
		case "clearVehicleAssignments": {
				[_logic,"vehicleAssignments",[] call ALIVE_fnc_hashCreate] call ALIVE_fnc_hashSet;
				[_logic,"entitiesInCommandOf",[]] call ALIVE_fnc_hashSet;
				[_logic,"entitiesInCargoOf",[]] call ALIVE_fnc_hashSet;				
		};
		case "mergePositions": {
				private ["_position","_assignments"];
				
				_profileID = _logic select 2 select 4; //[_logic,"profileID"] call ALIVE_fnc_hashGet;	
				_position = _logic select 2 select 2; //[_logic,"position"] call ALIVE_fnc_hashGet;	
				_assignments = _logic select 2 select 7; //[_logic,"vehicleAssignments"] call ALIVE_fnc_hashGet;
				
				if(count (_assignments select 1) > 0) then {
					[_assignments,_position] call ALIVE_fnc_profileVehicleAssignmentsSetAllPositions;
				};
		};
		case "spawn": {
				private ["_debug","_side","_vehicleClass","_vehicleType","_position","_direction","_damage","_fuel","_ammo","_engineOn","_profileID","_active","_vehicleAssignments","_special","_vehicle","_eventID"];

				_debug = _logic select 2 select 0; //[_logic,"debug"] call ALIVE_fnc_hashGet;
				_vehicleClass = _logic select 2 select 11; //[_logic,"vehicleClass"] call ALIVE_fnc_hashGet;
				_vehicleType = _logic select 2 select 6; //[_logic,"objectType"] call ALIVE_fnc_hashGet;
				_position = _logic select 2 select 2; //[_logic,"position"] call ALIVE_fnc_hashGet;
				_direction = _logic select 2 select 12; //[_logic,"direction"] call ALIVE_fnc_hashGet;
				_damage = _logic select 2 select 16; //[_logic,"damage"] call ALIVE_fnc_hashGet;
				_fuel = _logic select 2 select 13; //[_logic,"fuel"] call ALIVE_fnc_hashGet;
				_ammo = _logic select 2 select 14; //[_logic,"ammo"] call ALIVE_fnc_hashGet;
				_engineOn = _logic select 2 select 15; //[_logic,"engineOn"] call ALIVE_fnc_hashGet;
				_profileID = _logic select 2 select 4; //[_logic,"profileID"] call ALIVE_fnc_hashGet;
				_active = _logic select 2 select 1; //[_logic,"active"] call ALIVE_fnc_hashGet;
				_vehicleAssignments = _logic select 2 select 7; //[_logic,"vehicleAssignments"] call ALIVE_fnc_hashGet;

				// not already active
				if!(_active) then {
				
					// determine a suitable spawn position
					//[true] call ALIVE_fnc_timer;
					[_logic] call ALIVE_fnc_profileGetGoodSpawnPosition;
					//[] call ALIVE_fnc_timer;

					// spawn the unit
					if(_engineOn && (_vehicleType=="Helicopter" || _vehicleType=="Plane")) then {
						if((_position select 2) < 50) then {
							_position set [2,50];
						};
						_special = "FLY";
					}else{
						_special = "NONE";
						_position set [2,0];
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
					[_vehicleAssignments, _logic] call ALIVE_fnc_profileVehicleAssignmentsToVehicleAssignments;
					
					// store the profile id on the active profiles index
					[ALIVE_profileHandler,"setActive",_profileID] call ALIVE_fnc_profileHandler;
					
					// DEBUG -------------------------------------------------------------------------------------
					if(_debug) then {
						//["Profile [%1] Spawn - class: %2 type: %3 pos: %4",_profileID,_vehicleClass,_vehicleType,_position] call ALIVE_fnc_dump;
						[_logic,"debug",true] call MAINCLASS;
					};
					// DEBUG -------------------------------------------------------------------------------------
				};
		};
		case "despawn": {
				private ["_debug","_active","_vehicle","_profileID","_position","_despawnPrevented","_linked","_spawnType"];
				
				_debug = _logic select 2 select 0; //[_logic,"debug"] call ALIVE_fnc_hashGet;
				_active = _logic select 2 select 1; //[_logic,"active"] call ALIVE_fnc_hashGet;
				_vehicle = _logic select 2 select 10; //[_logic,"vehicle"] call ALIVE_fnc_hashGet;
				_profileID = _logic select 2 select 4; //[_logic,"profileID"] call ALIVE_fnc_hashGet;

				// not already inactive
				if(_active) then {
				
					// if any linked profiles have despawn prevented
					_despawnPrevented = false;
					_linked = [_logic] call ALIVE_fnc_vehicleAssignmentsGetLinkedProfiles;
					//_linked call ALIVE_fnc_inspectHash;
					if(count (_linked select 1) > 1) then {
						{
							_spawnType = [_x,"spawnType"] call ALIVE_fnc_hashGet;
							if(count _spawnType > 0) then {
								if(_spawnType select 0 == "preventDespawn") then {
									_despawnPrevented = true;
								};
							}
						} forEach (_linked select 2);
					};
					
					if!(_despawnPrevented) then {
					
						[_logic,"active",false] call ALIVE_fnc_hashSet;
						
						// update profile vehicle assignments before despawn
						[_logic,"clearVehicleAssignments"] call MAINCLASS;					
						[_logic] call ALIVE_fnc_vehicleAssignmentsToProfileVehicleAssignments;
						
						_position = getPosATL _vehicle;
						
						// update profile before despawn
						[_logic,"position", _position] call ALIVE_fnc_hashSet;
						[_logic,"despawnPosition", _position] call ALIVE_fnc_hashSet;
						[_logic,"direction", getDir _vehicle] call ALIVE_fnc_hashSet;
						[_logic,"damage", _vehicle call ALIVE_fnc_vehicleGetDamage] call ALIVE_fnc_hashSet;
						[_logic,"fuel", fuel _vehicle] call ALIVE_fnc_hashSet;
						[_logic,"ammo", _vehicle call ALIVE_fnc_vehicleGetAmmo] call ALIVE_fnc_hashSet;
						[_logic,"engineOn", isEngineOn _vehicle] call ALIVE_fnc_hashSet;
						[_logic,"canFire", canFire _vehicle] call ALIVE_fnc_hashSet;
						[_logic,"canMove", canMove _vehicle] call ALIVE_fnc_hashSet;
						[_logic,"needReload", needReload _vehicle] call ALIVE_fnc_hashSet;
						[_logic,"vehicle",objNull] call ALIVE_fnc_hashSet;

						// delete
						deleteVehicle _vehicle;
						
						// store the profile id on the in active profiles index
						[ALIVE_profileHandler,"setInActive",_profileID] call ALIVE_fnc_profileHandler;
						
						// DEBUG -------------------------------------------------------------------------------------
						if(_debug) then {
							//["Profile [%1] Despawn - pos: %2",_profileID,_position] call ALIVE_fnc_dump;
							[_logic,"debug",true] call MAINCLASS;
						};
						// DEBUG -------------------------------------------------------------------------------------
					
					};
				};
		};
		case "handleDeath": {
				[_logic,"damage",1] call ALIVE_fnc_hashSet;
				
				// remove all assignments for this vehicle
				[_logic] call ALIVE_fnc_removeProfileVehicleAssignments;
		};
        default {
                _result = [_logic, _operation, _args] call SUPERCLASS;
        };
};
TRACE_1("profileVehicle - output",_result);
_result;