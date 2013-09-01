#include <\x\alive\addons\mil_cqb\script_component.hpp>
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
[_logic, "houses", _nonStrategicHouses] call ALiVE_fnc_CQB;
[_logic, "spawnDistance", 500] call ALiVE_fnc_CQB;
[_logic, "active", true] call ALiVE_fnc_CQB;

See Also:
- <ALIVE_fnc_CQBInit>

Author:
Wolffy, Highhead
---------------------------------------------------------------------------- */

#define SUPERCLASS nil
#define MTEMPLATE "ALiVE_CQB_%1"

private ["_logic","_operation","_args"];

PARAMS_1(_logic);
DEFAULT_PARAM(1,_operation,"");
DEFAULT_PARAM(2,_args,nil);

switch(_operation) do {
        default {
                private["_err"];
                _err = format["%1 does not support %2 operation", _logic, _operation];
                ERROR_WITH_TITLE(str _logic,_err);
        };
        case "init": {
            	//Init further mandatory params on all localities
				_CQB_spawn = _logic getvariable ["CQB_spawn_setting",1];
				if (typename (_CQB_spawn) == "STRING") then {_CQB_spawn = call compile _CQB_spawn};
                _logic setVariable ["CQB_spawn", _CQB_spawn];
                
                _factionsStrat = _logic getvariable ["CQB_FACTIONS_STRAT",["OPF_F"]];
				if (typename (_factionsStrat) == "STRING") then {_factionsStrat = call compile _factionsStrat};
                
                _factionsReg = _logic getvariable ["CQB_FACTIONS_REG",["OPF_F"]];
				if (typename (_factionsReg) == "STRING") then {_factionsReg = call compile _factionsReg};
            
	        	CQB_GLOBALDEBUG = _logic getvariable ["CQB_debug_setting",false];
                if (typename (CQB_GLOBALDEBUG) == "STRING") then {CQB_GLOBALDEBUG = call compile CQB_GLOBALDEBUG};

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
                        
                    _strategicTypes = [
                    	//A3
						"Land_Cargo_Patrol_V1_F",
                        "Land_Cargo_HQ_V2_F",
                        "Land_Cargo_House_V2_F",
                        //"Land_Cargo_Patrol_V2_F",
						"Land_MilOffices_V1_F",
						//"Land_dp_smallFactory_F",
						"Land_Cargo_HQ_V1_F",
						//"Land_Radar_F",
						"Land_Airport_Tower_F"
						//"Land_TentHangar_V1_F"
					];
                    
                    _regularTypes = [
                    	"Land_u_Shop_02_V1_F",
                    	"Land_d_House_Big_02_V1_F",
                        "Land_i_House_Big_01_V1_F",
                        "Land_u_House_Small_02_V1_F",
                        "Land_i_House_Big_02_V3_F"
                    ];
                    
                    // Get all enterable houses of strategic types below across the whole map (rest will be regular)
                    //Workaroung until SEP is fixed for Altis
                    //_spawnhouses = call ALiVE_fnc_getAllEnterableHouses;
                    //_spawnhouses = nearestObjects [(getArray (configFile >> "CfgWorlds" >> worldName >> "centerPosition")), _strategicTypes, 2000];
                    //_spawnhouses = (getArray (configFile >> "CfgWorlds" >> worldName >> "centerPosition")) nearObjects ["House_F", 15000];
                    
                    /*
                    _strategicHouses = [];
                    for "_i" from 0 to (count _strategicTypes)-1 do {
                        _tmp = (getArray (configFile >> "CfgWorlds" >> worldName >> "centerPosition")) nearObjects [_strategicTypes select _i, 15000];
                        _strategicHouses = _strategicHouses + _tmp;
                    };
                    
                    _nonStrategicHouses = [];
                    for "_i" from 0 to (count _regularTypes)-1 do {
                        _tmp = (getArray (configFile >> "CfgWorlds" >> worldName >> "centerPosition")) nearObjects [_regularTypes select _i, 15000];
                        _nonStrategicHouses = _nonStrategicHouses + _tmp;
                    };
					*/
                    _Houses = nearestObjects [(getArray (configFile >> "CfgWorlds" >> worldName >> "centerPosition")), _strategicTypes, 15000];
                    _Houses = _Houses + (nearestObjects [(getArray (configFile >> "CfgWorlds" >> worldName >> "centerPosition")), _regularTypes, 15000]);
                    
					//_strategicHouses = nearestObjects [(getArray (configFile >> "CfgWorlds" >> worldName >> "centerPosition")), _strategicTypes, 10000];
                    //_nonStrategicHouses = nearestObjects [(getArray (configFile >> "CfgWorlds" >> worldName >> "centerPosition")), _regularTypes, 10000];
                    
                    _result = [_Houses, _strategicTypes,_regularTypes, "ALIVE_CQB_BL_%1"] call ALiVE_fnc_CQBsortStrategicHouses;
					_Houses = nil;
                    
                    _strategicHouses = _result select 0;
					_nonStrategicHouses = _result select 1;
                    _result = nil;
                    
                    //Set units you dont want to spawn with _logic setVariable ["UnitsBlackList",_UnitsBlackList,true];
                    _UnitsBlackList = [
                    	//A3
                        "O_diver_F",
                        "O_diver_TL_F",
                        "O_diver_exp_F",
                        "O_helipilot_F",
                        "I_diver_F",
                        "I_diver_TL_F",
                        "I_diver_exp_F",
                        "I_crew_F",
                        "I_helicrew_F"
                    ];

					//set default values on main CQB instance
                    //[MOD(CQB), "houses", _strategicHouses + _nonStrategicHouses] call ALiVE_fnc_CQB;
					[MOD(CQB), "factions", _factionsReg + _factionsStrat] call ALiVE_fnc_CQB;
					[MOD(CQB), "spawnDistance", 800] call ALiVE_fnc_CQB;

                    // Create strategic CQB instance
                    _logic = (createGroup sideLogic) createUnit ["LOGIC", [0,0], [], 0, "NONE"];
        			_logic setVariable ["class", ALiVE_fnc_CQB];
                    _logic setVariable ["UnitsBlackList",_UnitsBlackList,true];
					[_logic, "houses", _strategicHouses] call ALiVE_fnc_CQB;
					[_logic, "factions", _factionsStrat] call ALiVE_fnc_CQB;
					[_logic, "spawnDistance", 800] call ALiVE_fnc_CQB;
					_logic setVariable ["debugColor","ColorRed",true];
					_logic setVariable ["debugPrefix","Strategic",true];
					[_logic, "debug", CQB_GLOBALDEBUG] call ALiVE_fnc_CQB;
                    CQB_Strategic = _logic;
                    Publicvariable "CQB_Strategic";
					
					// Create nonstrategic CQB instance
                    _logic = (createGroup sideLogic) createUnit ["LOGIC", [0,0], [], 0, "NONE"];
        			_logic setVariable ["class", ALiVE_fnc_CQB];
                    _logic setVariable ["UnitsBlackList",_UnitsBlackList,true];
					[_logic, "houses", _nonStrategicHouses] call ALiVE_fnc_CQB;
					[_logic, "factions", _factionsReg] call ALiVE_fnc_CQB;
					[_logic, "spawnDistance", 500] call ALiVE_fnc_CQB;
                    _logic setVariable ["debugColor","ColorGreen",true];
					_logic setVariable ["debugPrefix","Regular",true];

                    CQB_Regular = _logic;
                    Publicvariable "CQB_Regular";
                    
                    MOD(CQB) setVariable ["instances",[CQB_Regular,CQB_Strategic],true];
                    [MOD(CQB), "GarbageCollecting", true] call ALiVE_fnc_CQB;
                    MOD(CQB) setVariable ["init", true, true];
                    
                    //diag_log format["Regular logic %1, houses %2",_logic,count _spawnhouses];
                    // and publicVariable Main class to clients
                    
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
                CONTROLLER  - coordination
                - Start CQB Controller on Server
                */

				if (isServer) then {
	                waitUntil {MOD(CQB) getVariable ["init", false]};
					[CQB_Regular, "active", true] call ALiVE_fnc_CQB;
					diag_log ([CQB_Regular, "state"] call ALiVE_fnc_CQB);
	                
					[CQB_Strategic, "active", true] call ALiVE_fnc_CQB;
					diag_log ([CQB_Strategic, "state"] call ALiVE_fnc_CQB);
				};
                
                /*
                VIEW - purely visual
                - initialise menu
                - frequent check to modify menu and display status (ALIVE_fnc_CQBsmenuDef)
                */
                
		TRACE_2("Waiting for CQB PV",isDedicated,isHC);

                if(!isDedicated && !isHC) then {
                    [CQB_Strategic, "debug", CQB_GLOBALDEBUG] call ALiVE_fnc_CQB;
                    [CQB_Regular, "debug", CQB_GLOBALDEBUG] call ALiVE_fnc_CQB;
                };
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
					createmarkerLocal [_m, getPosATL _x];
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
    
	case "factions": {
		if(isNil "_args") then {
			// if no new faction list was provided return current setting
			_args = _logic getVariable ["factions", []];
		} else {
			// if a new faction list was provided set factions settings
			ASSERT_TRUE(typeName _args == "ARRAY",str typeName _args);
			_logic setVariable ["factions", _args, true];
		};
		_args;
	};
    
	case "spawnDistance": {
		if(isNil "_args") then {
			// if no new distance was provided return spawn distance setting
			_args = _logic getVariable ["spawnDistance", 800];
		} else {
			// if a new distance was provided set spawn distance settings
			ASSERT_TRUE(typeName _args == "SCALAR",str typeName _args);			
			_logic setVariable ["spawnDistance", _args, true];
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
			_logic setVariable ["houses", nil, true];
			waitUntil{isNil{(_logic getVariable ["houses",nil])}};

			ASSERT_TRUE(typeName _args == "ARRAY",str typeName _args);
			_logic setVariable ["houses", _args, true];
			
            waitUntil{typeName (_logic getVariable ["houses",[]]) == "ARRAY"};
			
			if (_logic getVariable ["debug", false]) then {
				// mark all strategic and non-strategic houses
				{
					private ["_m"];
					_m = format[MTEMPLATE, _x];
					if(str getMarkerPos _m == "[0,0,0]") then {
						createmarkerLocal [_m, getPosATL _x];
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

			[_logic,"houses",[_house],true,true] call BIS_fnc_variableSpaceAdd;

            if (_logic getVariable ["debug", false]) then {
                format["CQB Population: Adding house %1...", _house] call ALiVE_fnc_logger;
				_m = format[MTEMPLATE, _house];
				if(str getMarkerPos _m == "[0,0,0]") then {
					createmarkerLocal [_m, getPosATL _house];
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

			if(!isNil "_grp") then {
				[_logic, "delGroup", _grp] call ALiVE_fnc_CQB;
			};
			
			[_logic,"houses",[_house],true,true] call BIS_fnc_variableSpaceRemove;

			if (_logic getVariable ["debug", false]) then {
				format["CQB Population: Clearing house %1...", _house] call ALiVE_fnc_logger;
			};
			deleteMarkerLocal format[MTEMPLATE, _house];
		};
	};
    
    case "GarbageCollecting": {
			if(isNil "_args") then {
				// if no arguments provided return current setting
				_args = _logic getVariable ["GarbageCollecting", false];
			} else {
	            // if an argument is provided then execute
	        	ASSERT_TRUE(typeName _args == "BOOL",str typeName _args);
	            _logic setVariable ["GarbageCollecting", _args, true];
				
	            // if false then delete GC
	            if !(_args) exitwith {GC = nil; Publicvariable "GC";};
	            
	            //else run a GC for each instance, until it is deleted
                _spawn = _logic getVariable ["spawnDistance", 800];
	            GC = _args;
				{
		            [_x,_spawn] spawn {
		                _logic = _this select 0;
		                _spawn = _this select 1;
                        
		                while {!(isnil "GC")} do {
		                    sleep 30;
							{
			                   _lead = leader _x;
								if ((local _lead) && (([getPosATL _lead, (_spawn * 2.5)] call ALiVE_fnc_anyPlayersInRange) == 0)) then {[_logic, "delGroup", _x] call ALiVE_fnc_CQB};
							} forEach (_logic getVariable ["groups",[]]);
		                };
					};
	            } foreach (_logic getVariable ["instances",[]]);
		};
        _args;
    };

	case "groups": {
		if(isNil "_args") then {
			// if no new groups list was provided return current setting
			_args = _logic getVariable ["groups", []];
		} else {
				// if a new groups list was provided set groups list
				ASSERT_TRUE(typeName _args == "ARRAY",str typeName _args);
				_logic setVariable ["groups", _args, true];
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
			{_x setVariable ["house",_house]} foreach (units _grp);
            
            //Only public flag leader with house to save PVs
			(leader _grp) setVariable ["house",_house, true];
			
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
			_house = (leader _grp) getVariable "house";
	
            // Update house that group despawned
			_house setVariable ["group",nil, true]; 
    
			// Despawn group
			[_logic,"groups",[_grp],true,true] call BIS_fnc_variableSpaceRemove;
			{
                _x setVariable ["house", nil, true];
				deleteVehicle _x;
			} forEach units _grp;
			
		if (_logic getVariable ["debug", false]) then {
			format["CQB Population: Group %1 deleted from %2...", _grp, owner leader _grp] call ALiVE_fnc_logger;
		};
		format[MTEMPLATE, _house] setMarkerTypeLocal "mil_Dot";
		deleteGroup _grp;
	    };
	};
    
    case "spawnGroup": {
		if(isNil "_args") then {
			// if no units and house was provided return false
			_args = false;
		} else {
			// if a house and unit is provided start spawn process
			ASSERT_TRUE(typeName _args == "OBJECT",str typeName _args);
            
            _house = _args;
            _debug = _logic getVariable ["debug",false];
            
        	_createUnitTypes = {
				private ["_factions","_units","_blacklist"];
				PARAMS_1(_factions);
                _blacklist = _logic getVariable ["UnitsBlackList",[]];
				[_factions, ceil(random 2),_blacklist] call ALiVE_fnc_chooseRandomUnits;
			};
            
            private ["_side"];
            
			// Action: spawn AI
			// this just flags the house as beginning spawning
			// and will be over-written in addHouse
			
			_units = _house getVariable ["unittypes", []];
			// Check: if no units already defined
			if(count _units == 0) then {
				// Action: identify AI unit types
				_units = [(_logic getVariable ["factions", []])] call (_logic getVariable ["_createUnitTypes", _createUnitTypes]);
				_house setVariable ["unittypes", _units, true];
			};

			// Action: restore AI
            
            switch (getNumber(configFile >> "Cfgvehicles" >> _units select 0 >> "side")) do {
                case 0 : {_side = EAST};
                case 1 : {_side = WEST};
                case 2 : {_side = RESISTANCE};
                default {_side = EAST};
            };
            
			_grp = [getPosATL _house,_side, _units] call BIS_fnc_spawnGroup;
										
			if (count units _grp == 0) exitWith {
				if (_debug) then {
					format["CQB Population: Group %1 deleted on creation - no units...", _grp] call ALiVE_fnc_logger;
				};
				[_logic, "delGroup", _grp] call ALiVE_fnc_CQB;
			};
			// position AI
			_positions = [_house] call ALiVE_fnc_getBuildingPositions;
            
            diag_log _positions;
            
			{
		        _pos = (_positions call BIS_fnc_selectRandom);
				_x setPosATL [_pos select 0, _pos select 1, (_pos select 2 + 0.4)];
			} forEach units _grp;
			[_logic, "addGroup", [_house, _grp]] call ALiVE_fnc_CQB;
			
			// TODO Notify controller to start directing
			// TODO this needs to be refactored
			_fsm = "\x\alive\addons\mil_cqb\HousePatrol.fsm";
			_hdl = [_logic,(leader _grp), 50, true, 60] execFSM _fsm;
			(leader _grp) setVariable ["FSM", [_hdl,_fsm], true];
            _args = _grp;
		};
		_args;
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
				private ["_logic","_units","_grp","_positions","_house","_debug","_spawn","_maxgrps","_leader","_createUnitTypes","_despawnGroup","_host","_players","_playerhosts"];
				_logic = _this;
				
				// default functions - can be overridden
				// over-arching spawning loop
					waitUntil{
						sleep (2 + random 1);
                        _debug = _logic getVariable ["debug",false];
						_spawn = _logic getVariable ["spawnDistance", 800];
                        
						{
							// if conditions are right, spawn a group and place them
							_house = _x;
						
							// Check: house doesn't already have AI AND
							// Check: if any players within spawn distance

                            _players = [] call BIS_fnc_listPlayers;
                            _nearplayers = ({((getPosATL _house) distance _x) < _spawn} count _players);
							if ((isNil {_house getVariable "group"}) && {_nearplayers != 0}) then {

                                _playerhosts = [];
                                if (count _players > 0) then {
	                                for "_i" from 0 to (count _players - 1) do {
	                                    _pl = _players select _i;
                                        
                                        //Choose players from List
                                        if !(isnull _pl) then {
                                            
                                            /* AI distribution not working properly yet
                                            _threshold = 10;
                                            _localunits = ({owner _x == owner _pl} count allUnits);
                                            _unitLimit = (ceil (count allUnits / count _players)) + _threshold;
                                            _canHost = (_localunits <= _unitLimit);
                                            diag_log format ["Local units %1 on %2 vs. Unitlimit %3 (near players %4) turns canhost %5 for house %6 on logic %7",_localunits,_pl,_unitLimit,_nearplayers,_canhost,_house,_logic];
                                            */
		                                	_canhost = true;
	                                        
	                                        if ((getPosATL _house distance _pl < _spawn) && _canHost) then {
		                                        _playerhosts set [count _playerhosts,_pl];
		                                    };
                                        } else {
                                            //diag_log format ["CQB Warning: Null object on host (%1) not selected",_pl];
                                        };
	                                };
                                    
                                    if (count _playerhosts > 0) then {
                                		_host = _playerhosts call BIS_fnc_selectRandom;
                                    
	                                    if !(isnull _host) then {
		                                    _house setvariable ["group","preinit",true];
                                            [_host,"CQB",[[_logic, "spawnGroup", _house],{call ALiVE_fnc_CQB}]] call ALiVE_fnc_BUS_RetVal;
                                            sleep 0.1;
	                                    } else {
	                                        diag_log format ["CQB ERROR: Null object on host %1",_host];
	                                    };
                                	} else {
                                        diag_log format ["CQB ERROR: No playerhosts for house %1!",_house];
                                    };
                                } else {
                                    diag_log format ["CQB ERROR: No players in List %1!",_players];
                                };
                            };
						} forEach (_logic getVariable ["houses", []]);
						{
							_grp = _x;
                            _leader = leader _grp;
							
                            // get house in question
							_house = _leader getVariable "house";
                            
                            // Initializing grouphouse locally on all units to save PVs (see addgroup). 
                            // If not all units are flagged with house then flag them;
                            if (({!(isnil {_x getvariable ["house",nil]})} count (units _grp)) != (count units _grp)) then {
                                {_x setvariable ["house",_house]} foreach (units _grp);
                            };
							
							// if group are all dead
							// mark house as cleared
							if ({alive _x} count (units _grp) == 0) then {
								// update central CQB house listings
								[_logic, "clearHouse", _house] call ALiVE_fnc_CQB;
							};
						} forEach (_logic getVariable ["groups",[]]);
                        
                        if (_debug) then {
	                        _remaincount = count (_logic getVariable ["houses", []]);
	                        _housesempty = {(isNil {_x getVariable "group"})} count (_logic getVariable ["houses", []]);
							_activecount = count (_logic getVariable ["groups", []]);
	                        _groupsempty = {(isNil {(leader _x) getVariable "house"})} count (_logic getVariable ["groups", []]);
	                        
	                       format["CQB Population: %1 remaing positions | %2 active positions | inactive houses %3 | groups with no house %4...", _remaincount, _activecount,_housesempty,_groupsempty] call ALiVE_fnc_logger; 
                        };

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