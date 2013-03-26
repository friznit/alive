#include <\x\alive\addons\nme_CQB\script_component.hpp>
SCRIPT(CQB);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_CQB
Description:
XXXXXXXXXX

Parameters:
Nil or Object - If Nil, return a new instance. If Object, reference an existing instance.
String - The selected function
Array - The selected parameters

Returns:
Any - The new instance or the result of the selected function and parameters

Attributes:
Boolean - debug - Debug enabled
Boolean - enabled - Enabled or disable module

Parameters:
none

Description:
CQB Module! Detailed description to follow

Examples:
[_logic, "factions", ["OPF_F"] call ALiVE_fnc_CQB;

See Also:
- <ALIVE_fnc_CQBInit>

Author:
Wolffy, Highhead
---------------------------------------------------------------------------- */

#define SUPERCLASS nil
#define MTEMPLATE "ALiVE_CQB_%1"
#define MSO_FACTIONS ["OPF_F"]

private ["_logic","_operation","_args"];

PARAMS_1(_logic);
DEFAULT_PARAM(1,_operation,"");
DEFAULT_PARAM(2,_args,nil);

//Init further mandatory params on all localities
CQB_spawn = call compile (_logic getvariable ["CQB_spawn_setting",1]);
_debug = call compile (_logic getvariable ["CQB_debug_setting",false]);

switch(_operation) do {
        default {
                private["_err"];
                _err = format["%1 does not support %2 operation", _logic, _operation];
                ERROR_WITH_TITLE(str _logic,_err);
        };
        case "init": {
                /*
                MODEL - no visual just reference data
                - server side object only
				- enabled/disabled
                */
                
                // Ensure only one module is used
                if (isServer && !(isNil QMOD(CQB))) exitWith {
                        ERROR_WITH_TITLE(str _logic, localize "STR_ALIVE_CQB_ERROR1");
                };
                
                if (isServer) then {
                    // if server, initialise module game logic
                    MOD(CQB) = _logic;
                    MOD(CQB) setVariable ["super", SUPERCLASS];
                    MOD(CQB) setVariable ["class", ALIVE_fnc_CQB];
                        
				    // Get all enterable houses across the map
					_spawnhouses = call ALiVE_fnc_getAllEnterableHouses;
                    _strategicTypes = [
                    	//A3
						"Land_Cargo_Patrol_V1_F",
						"Land_MilOffices_V1_F",
						"Land_dp_smallFactory_F",
						"Land_Cargo_HQ_V1_F",
						"Land_Radar_F",
						"Land_Airport_Tower_F",
						"Land_TentHangar_V1_F"
					];
                    _result = [_spawnhouses, _strategicTypes, "BIS_ZORA_%1"] call ALiVE_fnc_CQBsortStrategicHouses;
					_strategicHouses = _result select 0;
					_nonStrategicHouses = _result select 1;

					//set default values on main CQB instance
                    [MOD(CQB), "houses", _spawnhouses] call ALiVE_fnc_CQB;
					[MOD(CQB), "factions", MSO_FACTIONS] call ALiVE_fnc_CQB;
					[MOD(CQB), "spawnDistance", 800] call ALiVE_fnc_CQB;

                    // Create strategic CQB instance
                    _logic = (createGroup sideLogic) createUnit ["LOGIC", [0,0], [], 0, "NONE"];
        			_logic setVariable ["class", ALiVE_fnc_CQB];

					[_logic, "houses", _strategicHouses] call ALiVE_fnc_CQB;
					[_logic, "factions", MSO_FACTIONS] call ALiVE_fnc_CQB;
					[_logic, "spawnDistance", 800] call ALiVE_fnc_CQB;
                    
					_logic setVariable ["debugColor","ColorRed",true];
					_logic setVariable ["debugPrefix","Strategic",true];
					[_logic, "debug", _debug] call ALiVE_fnc_CQB;
                    GVAR(strategic) = _logic;
					
					// Create nonstrategic CQB instance
                    _logic = (createGroup sideLogic) createUnit ["LOGIC", [0,0], [], 0, "NONE"];
        			_logic setVariable ["class", ALiVE_fnc_CQB];
                    
					[_logic, "houses", _nonStrategicHouses] call ALiVE_fnc_CQB;
					[_logic, "factions", MSO_FACTIONS] call ALiVE_fnc_CQB;
					[_logic, "spawnDistance", 500] call ALiVE_fnc_CQB;
                    
                    _logic setVariable ["debugColor","ColorGreen",true];
					_logic setVariable ["debugPrefix","Regular",true];
					[_logic, "debug", _debug] call ALiVE_fnc_CQB;
					GVAR(regular) = _logic;
                    
                    MOD(CQB) setVariable ["instances",[GVAR(regular),GVAR(strategic)],true];
                    MOD(CQB) setVariable ["init", true, true];
                    
                    diag_log format["Regular logic %1, houses %2",_logic,count _spawnhouses];
                    // and publicVariable to clients
                    publicVariable QMOD(CQB);
                    diag_log "CQB Init finished";
            } else {
                    // if client clean up client side game logics as they will transfer
                    // to servers on client disconnect
            };
                
		TRACE_2("After module init",MOD(CQB),MOD(CQB) getVariable "init");

                // and wait for game logic to initialise
                // TODO merge into lazy evaluation
                waitUntil {!isNil QMOD(CQB)};
                waitUntil {MOD(CQB) getVariable ["init", false]};        

                /*
                VIEW - purely visual
                - initialise menu
                - frequent check to modify menu and display status (ALIVE_fnc_CQBsmenuDef)
                */
                
		TRACE_2("Waiting for CQB PV",isDedicated,isHC);

                if(!isDedicated && !isHC) then {
					waitUntil {MOD(CQB) getVariable ["init", false]};
					[GVAR(regular), "active", true] call ALiVE_fnc_CQB;
					diag_log ([GVAR(regular), "state"] call ALiVE_fnc_CQB);
                    
					[GVAR(strategic), "active", true] call ALiVE_fnc_CQB;
					diag_log ([GVAR(strategic), "state"] call ALiVE_fnc_CQB);
                };
                
                /*
                CONTROLLER  - coordination
                - 
                */
        };
        
        case "destroy": {
                if (isServer) then {
                        // if server
                        _logic setVariable ["super", nil];
                        _logic setVariable ["class", nil];
                        _logic setVariable ["init", nil];
                        // and publicVariable to clients
                        MOD(CQB) = _logic;
                        publicVariable QMOD(CQB);
                };
                
                if(!isDedicated && !isHC) then {
                        // TODO: remove 
                };
        };
        
        case "debug": {
		if(isNil "_args") then {
			_args = _logic getVariable ["debug", false];
		} else {
			_logic setVariable ["debug", _args];
		};                
		ASSERT_TRUE(typeName _args == "BOOL",str _args);		
		
		{
			deleteMarkerLocal format[MTEMPLATE, _x];
		} forEach (_logic getVariable ["houses", []]);
		
		if(_args) then {
			// mark all strategic and non-strategic houses
			{
				private ["_m"];
				_m = format[MTEMPLATE, _x];
				if(str getMarkerPos _m == "[0,0,0]") then {
					createMarkerLocal [_m, getPosATL _x];
					_m setMarkerShapeLocal "Icon";
					_m setMarkerSizeLocal [1,1];
					if (isNil {_x getVariable "group"}) then {
						_m setMarkerTypeLocal "mil_dot";
					} else{
						// mark active houses
						_m setMarkerTypeLocal "Waypoint";
					};
					_m setMarkerColorLocal (_logic getVariable ["debugColor","ColorGreen"]);
					_m setMarkerTextLocal (_logic getVariable ["debugPrefix","CQB"]);
				};
			} forEach (_logic getVariable ["houses", []]);
			
			private["_activecount","_remaincount","_cqbai"];
			_remaincount = count (_logic getVariable ["houses", []]);
			_activecount = count (_logic getVariable ["groups", []]);
			_cqbai = 0;
			{
				if (local leader _x) then {
					_cqbai = _cqbai + count units _x;
				};
			} forEach (_logic getVariable ["groups",[]]);
			format["CQB Population: %1 remaing positions | %2 active positions | %3 local CQB AI...", _remaincount, _activecount, _cqbai] call ALiVE_fnc_logger;        
		};
		_args;
	};
       
	case "state": {
		private["_state","_data"];
		
		if(isNil "_args") then {
			_state = [] call CBA_fnc_hashCreate;
			// Save state
			{
				[_state, _x, _logic getVariable _x] call CBA_fnc_hashSet;
			} forEach ["spawnDistance", "factions"];
			
			_data = [];
			{
				_data set [count _data,[
					getPosATL _x,
					typeOf _x,
					_x getVariable "unittypes"
				]];
			} forEach (_logic getVariable "houses");
			
			[_state, "houses", _data] call CBA_fnc_hashSet;                        
			
			_state;
		} else {
			private["_houses","_groups"];
			_groups = _logic getVariable ["groups",[]];
			{
				[_logic, "delGroup", _x] call ALiVE_fnc_CQB;
			} forEach _groups;
			_logic setVariable ["groups",[]];
			_houses = _logic getVariable ["houses",[]];
			if (isServer) then {
				// Restore state
				[_logic, "spawnDistance", [_args, "spawnDistance"] call CBA_fnc_hashGet] call ALiVE_fnc_CQB;
				[_logic, "factions", [_args, "factions"] call CBA_fnc_hashGet] call ALiVE_fnc_CQB;
				
				// houses and groups
				_data = [];
				{
					private["_house"];
					_house = (_x select 0) nearestObject (_x select 1);
					_house setVariable ["unittypes", _x select 2, true];
					_data set [count _data, _house];
				} forEach ([_args, "houses"] call CBA_fnc_hashGet);
				[_logic, "houses", _data] call ALiVE_fnc_CQB;
			};
		};		
	};
    
	case "factions": {
		if(isNil "_args") then {
			// if no new faction list was provided return current setting
			_args = _logic getVariable ["factions", []];
		} else {
			if(isServer) then {
				// if a new faction list was provided set factions settings
				ASSERT_TRUE(typeName _args == "ARRAY",str typeName _args);
				_logic setVariable ["factions", _args, true];
			};
		};
		_args;
	};
    
	case "spawnDistance": {
		if(isNil "_args") then {
			// if no new distance was provided return spawn distance setting
			_args = _logic getVariable ["spawnDistance", 800];
		} else {
			if(isServer) then {
				// if a new distance was provided set spawn distance settings
				ASSERT_TRUE(typeName _args == "SCALAR",str typeName _args);			
				_logic setVariable ["spawnDistance", _args, true];
			};
		};
		_args;
	}; 
	
	case "houses": {
		if(!isNil "_args") then {
			if (_logic getVariable ["debug", false]) then {
				{
					deleteMarkerLocal format[MTEMPLATE, _x];
				} forEach (_logic getVariable ["houses", []]);
			};
			
			// Un-initialise any previous settings for
			if(isServer) then {
				_logic setVariable ["houses", nil, true];
			};
			waitUntil{isNil{(_logic getVariable ["houses",nil])}};
			
			if(isServer) then {
				ASSERT_TRUE(typeName _args == "ARRAY",str typeName _args);
				_logic setVariable ["houses", _args, true];
			};
			waitUntil{typeName (_logic getVariable ["houses",[]]) == "ARRAY"};
			
			if (_logic getVariable ["debug", false]) then {
				// mark all strategic and non-strategic houses
				{
					private ["_m"];
					_m = format[MTEMPLATE, _x];
					if(str getMarkerPos _m == "[0,0,0]") then {
						createMarkerLocal [_m, getPosATL _x];
						_m setMarkerShapeLocal "Icon";
						_m setMarkerSizeLocal [1,1];
						if (isNil {_x getVariable "group"}) then {
							_m setMarkerTypeLocal "mil_Dot";
						} else{
							// mark active houses
							_m setMarkerTypeLocal "Waypoint";
						};
						_m setMarkerColorLocal (_logic getVariable ["debugColor","ColorGreen"]);
						_m setMarkerTextLocal (_logic getVariable ["debugPrefix","CQB"]);
					};
				} forEach (_logic getVariable ["houses", []]);
			};
		};
		
		_logic getVariable ["houses", []];
	};
    
	case "addHouse": {
		if(!isNil "_args") then {
			ASSERT_TRUE(typeName _args == "OBJECT",str typeName _args);
			private ["_house","_m"];
			_house = _args;
			if(isServer) then {
				[_logic,"houses",[_house],true,true] call BIS_fnc_variableSpaceAdd;
			};
            if (_logic getVariable ["debug", false]) then {
                format["CQB Population: Adding house %1...", _house] call ALiVE_fnc_logger;
				_m = format[MTEMPLATE, _house];
				if(str getMarkerPos _m == "[0,0,0]") then {
					createMarkerLocal [_m, getPosATL _house];
					_m setMarkerShapeLocal "Icon";
					_m setMarkerSizeLocal [1,1];
					_m setMarkerTypeLocal "mil_Dot";
					_m setMarkerColorLocal (_logic getVariable ["debugColor","ColorGreen"]);
					_m setMarkerTextLocal (_logic getVariable ["debugPrefix","CQB"]);
				};
			};
		};
	};
    
	case "clearHouse": {
		if(!isNil "_args") then {
			ASSERT_TRUE(typeName _args == "OBJECT",str typeName _args);
			private ["_house","_grp"];
			_house = _args;
			// delete the group
			_grp = _house getVariable "group";
			if(isServer) then {
				if(!isNil "_grp") then {
					[_logic, "delGroup", _grp] call ALiVE_fnc_CQB;
				};
				
				[_logic,"houses",[_house],true] call BIS_fnc_variableSpaceRemove;
			};
			if (_logic getVariable ["debug", false]) then {
				format["CQB Population: Clearing house %1...", _house] call ALiVE_fnc_logger;
			};
			deleteMarkerLocal format[MTEMPLATE, _house];
		};
	};

	case "groups": {
		if(isNil "_args") then {
			// if no new groups list was provided return current setting
			_args = _logic getVariable ["groups", []];
		} else {
			if(isServer) then {
				// if a new groups list was provided set groups list
				ASSERT_TRUE(typeName _args == "ARRAY",str typeName _args);
				_logic setVariable ["groups", _args, true];
			};
		};
		_args;
	};	 

	case "addGroup": {
		if(!isNil "_args") then {
				private ["_house","_grp"];
				ASSERT_TRUE(typeName _args == "ARRAY",str typeName _args);
				_house = ARG_1(_args,0);
				ASSERT_TRUE(typeName _house == "OBJECT",str typeName _house);
				_grp = ARG_1(_args,1);
				ASSERT_TRUE(typeName _grp == "GROUP",str typeName _grp);
				
				// if a house is not enterable, you can't spawn AI on it
				if (!([_house] call ALiVE_fnc_isHouseEnterable)) exitWith {
					[_logic, "clearHouse", _house] call ALiVE_fnc_CQB;
				};
				
				[_logic,"groups",[_grp],true,true] call BIS_fnc_variableSpaceAdd;
				_house setVariable ["group", _grp, true];
				_grp setVariable ["house",_house, true];
				
		                        if (_logic getVariable ["debug", false]) then {
		                                format["CQB Population: Group %1 created on %2", _grp, owner leader _grp] call ALiVE_fnc_logger;
			};
			// mark active houses
			format[MTEMPLATE, _house] setMarkerTypeLocal "Waypoint";
		};
	};

	case "delGroup": {
		if(!isNil "_args") then {
			ASSERT_TRUE(typeName _args == "GROUP",str typeName _args);
			private ["_grp","_house"];
			_grp = _args;
			_house = _grp getVariable "house";
			
			// Update house that group despawned
			_house setVariable ["group",nil, true];
			// Despawn group
			_grp setVariable ["house", nil, true];
			[_logic,"groups",[_grp],true] call BIS_fnc_variableSpaceRemove;
			{
				_x setDamage 1;
				deleteVehicle _x;
			} forEach units _grp;
			
	                        if (_logic getVariable ["debug", false]) then {
	                                format["CQB Population: Group %1 deleted from %2...", _grp, owner leader _grp] call ALiVE_fnc_logger;
		};
		format[MTEMPLATE, _house] setMarkerTypeLocal "mil_Dot";
		deleteGroup _grp;
	    };
	};

	case "active": {
	if(isNil "_args") exitWith {
		_logic getVariable ["active", false];
	};
	
	ASSERT_TRUE(typeName _args == "BOOL",str _args);		
	
	// xor check args is different to current debug setting
	if(
		((_args || (_logic getVariable ["active", false])) &&
		!(_args && (_logic getVariable ["active", false])))
	) then {
		ASSERT_TRUE(typeName _args == "BOOL",str _args);
		_logic setVariable ["active", _args];
		
		// if active
		if (_args) then {
			
			// spawn loop
			_logic spawn {
				private ["_logic","_units","_grp","_positions","_house","_debug","_spawn","_maxgrps","_leader","_createUnitTypes","_despawnGroup"];
				_logic = _this;
				
				// default functions - can be overridden
				// HH's create random units
				_createUnitTypes = {
					private ["_factions"];
					PARAMS_1(_factions);
					[_factions, ceil(random 2)] call ALiVE_fnc_chooseRandomUnits;
				};
				
				// default immediate group deletion
				_despawnGroup = {
					private["_logic","_grp"];
					PARAMS_2(_logic,_grp);
					// update central CQB group listing
					[_logic, "delGroup", _grp] call ALiVE_fnc_CQB;
				};
				
				// over-arching spawning loop
					waitUntil{
						sleep (2 + random 1);
						{
							// if conditions are right, spawn a group and place them
							_house = _x;
							_debug = _logic getVariable ["debug",false];
							_spawn = _logic getVariable ["spawnDistance", 800];
                            _CQBmaxgrps = 144;
						
							// Check: house doesn't already have AI AND
							// Check: if any players within spawn distance AND
							if (
								(isNil {_house getVariable "group"}) &&
								{([getPosATL _house, _spawn] call ALiVE_fnc_anyPlayersInRange) != 0} &&
								{!isDedicated}
							) then {
								
								// Action: spawn AI
								// this just flags the house as beginning spawning
								// and will be over-written in addHouse
								_house setVariable ["group", "preinit", true];
								
								_units = _house getVariable ["unittypes", []];
								// Check: if no units already defined
								if(count _units == 0) then {
									// Action: identify AI unit types
									_units = [(_logic getVariable ["factions", []])] call (_logic getVariable ["_createUnitTypes", _createUnitTypes]);
									_house setVariable ["unittypes", _units, true];
								};
								
								// Check: that the player isn't already hosting too many AI AND
								// Check: that the player isn't already hosting too many groups simultaneously
								if (
									(call ALiVE_fnc_isAbleToHost) &&
									{{local leader _x} count (_logic getVariable ["groups",[]]) < _CQBmaxgrps}
								) then {
									// Action: restore AI
									_grp = [getPosATL _house, east, _units] call BIS_fnc_spawnGroup;
									
									if (count units _grp == 0) exitWith {
										if (_debug) then {
											format["CQB Population: Group %1 deleted on creation - no units...", _grp] call ALiVE_fnc_logger;
										};
										[_logic, "delGroup", _grp] call ALiVE_fnc_CQB;
									};
									// position AI
									_positions = [_house] call ALiVE_fnc_getBuildingPositions;
									{
										_x setPosATL (_positions call BIS_fnc_selectRandom);
									} forEach units _grp;
									[_logic, "addGroup", [_house, _grp]] call ALiVE_fnc_CQB;
									
									// TODO Notify controller to start directing
									// TODO this needs to be refactored
									//[_house, _grp] spawn ALiVE_fnc_CQBmovegroup;
									{
										private["_fsm","_hdl"];
										_fsm = "\x\alive\addons\nme_CQB\HousePatrol.fsm";
										_hdl = [_x, 20, true, 120] execFSM _fsm;
										_x setVariable ["FSM", [_hdl,_fsm], true];
									} forEach units _grp;
								};
							};
						} forEach (_logic getVariable ["houses", []]);
						{
							_grp = _x;
							// get house in question
							_house = _x getVariable "house";
							
							// if group are all dead
							// mark house as cleared
							if (count (units _grp) == 0 && isServer) then {
								// update central CQB house listings
								[_logic, "clearHouse", _house] call ALiVE_fnc_CQB;
							} else {
								// if CQB-units are local (orphaned to server or clientside) and
								// all players are out of range and house is still active
								// despawn group but house not cleared
								_leader = leader _grp;
								if (
									local _leader &&
									{([getPosATL _house, _spawn * 1.1] call ALiVE_fnc_anyPlayersInRange) == 0}
								) then {
									// HH to over-ride to send back to home and delete
									// default is to delete
									[_logic,_grp] call (_logic getVariable ["_despawnGroup", _despawnGroup]);
								};
							};
						} forEach (_logic getVariable ["groups",[]]);
						!([_logic,"active"] call ALiVE_fnc_CQB);
					}; // end over-arching spawning loop
					
					// clean up groups if deactivated
					{
						[_logic, "delGroup", _x] call ALiVE_fnc_CQB;
					} forEach (_logic getVariable ["groups",[]]);
				}; // end spawn loop
			}; // end if active
		};
	};
};
