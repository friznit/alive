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
#define DEFAULT_BLACKLIST []

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
                //Initialise module game logic on all localities (clientside spawn)
                _logic setVariable ["super", SUPERCLASS];
                _logic setVariable ["class", ALIVE_fnc_CQB];
                
                TRACE_1("After module init",_logic);

            	//Init further mandatory params on all localities
				_CQB_spawn = _logic getvariable ["CQB_spawn_setting",1];
				if (typename (_CQB_spawn) == "STRING") then {_CQB_spawn = call compile _CQB_spawn};
                _logic setVariable ["CQB_spawn", _CQB_spawn];
                
                _CQB_density = _logic getvariable ["CQB_DENSITY",1000];
				if (typename (_CQB_density) == "STRING") then {_CQB_density = call compile _CQB_density};
                _logic setVariable ["CQB_DENSITY", _CQB_density];
                
                _factionsStrat = _logic getvariable ["CQB_FACTIONS_STRAT","OPF_F"];
                _factionsStrat = [_logic,"factions",_factionsStrat] call ALiVE_fnc_CQB;
                
                _factionsReg = _logic getvariable ["CQB_FACTIONS_REG","OPF_F"];
                _factionsReg = [_logic,"factions",_factionsReg] call ALiVE_fnc_CQB;
                
                _useDominantFaction = _logic getvariable ["CQB_UseDominantFaction","true"];
				if (typename (_useDominantFaction) == "STRING") then {_useDominantFaction = call compile _useDominantFaction};
                
                _CQB_Locations = _logic getvariable ["CQB_LOCATIONTYPE","towns"];
                
                [_logic, "blacklist", _logic getVariable ["blacklist", DEFAULT_BLACKLIST]] call ALiVE_fnc_CQB;
            
	        	CQB_GLOBALDEBUG = _logic getvariable ["CQB_debug_setting",false];
                if (typename (CQB_GLOBALDEBUG) == "STRING") then {CQB_GLOBALDEBUG = call compile CQB_GLOBALDEBUG};

                /*
                MODEL - no visual just reference data
                - server side object only
				- enabled/disabled
                */
                
                // Ensure only one module is used on server
                if (isServer && {!(isNil QMOD(CQB))}) exitWith {
                        ERROR_WITH_TITLE(str _logic, localize "STR_ALIVE_CQB_ERROR1");
                };
                
                if (isServer) then {
                    // if server, initialise module game logic
                    MOD(CQB) = _logic;
                    MOD(CQB) setVariable ["super", SUPERCLASS];
                    MOD(CQB) setVariable ["class", ALIVE_fnc_CQB];
                    
                    _logic setVariable ["startupComplete", false,true];

					//Implement when ready (not 0.5.6 yet if undiscussed)
					/*
                    // Load static data
                    if(isNil "ALIVE_unitBlackist") then {
                        _file = "\x\alive\addons\fnc_strategic\static\staticData.sqf";
                        call compile preprocessFileLineNumbers _file;
                    };

                    _strategicTypes = ALIVE_CQBStrategicTypes;
                    _UnitsBlackList = ALIVE_CQBUnitBlacklist;
                    */
                    
                    //Define strategic buildings
                    _strategicTypes = [
                    	//A3
						"Land_Cargo_Patrol_V1_F",
                        "Land_Cargo_Patrol_V2_F",
                        "Land_Cargo_House_V1_F",
                        "Land_Cargo_House_V2_F",
                        "Land_Cargo_Tower_V3_F",
                        "Land_Airport_Tower_F",
						"Land_Cargo_HQ_V1_F",
                        "Land_Cargo_HQ_V2_F",
                        "Land_MilOffices_V1_F",
                        "Land_Offices_01_V1_F",
                        "Land_Research_HQ_F",
                        "Land_CarService_F",
                        "Land_Hospital_main_F",
                        "Land_dp_smallFactory_F",
						"Land_Radar_F",
						"Land_TentHangar_V1_F",
                        
                        //A2
                        "Land_A_TVTower_Base",
						"Land_Dam_ConcP_20",
						"Land_Ind_Expedice_1",
						"Land_Ind_SiloVelke_02",
						"Land_Mil_Barracks",
						"Land_Mil_Barracks_i",
						"Land_Mil_Barracks_L",
						"Land_Mil_Guardhouse",
						"Land_Mil_House",
						"Land_Fort_Watchtower",
						"Land_Vysilac_FM",
						"Land_SS_hangar",
						"Land_telek1",
						"Land_vez",
						"Land_A_FuelStation_Shed",
						"Land_watertower1",
						"Land_trafostanica_velka",
						"Land_Ind_Oil_Tower_EP1",
						"Land_A_Villa_EP1",
						"Land_fortified_nest_small_EP1",
                        "Land_Mil_Barracks_i_EP1",
						"Land_fortified_nest_big_EP1",
						"Land_Fort_Watchtower_EP1",
						"Land_Ind_PowerStation_EP1",
						"Land_Ind_PowerStation"
                    ];
                    
                    //Set units you dont want to spawn with _logic setVariable ["UnitsBlackList",_UnitsBlackList,true];
                    _UnitsBlackList = [
                    	//A3
						"B_Helipilot_F",
						"B_diver_F",
						"B_diver_TL_F",
						"B_diver_exp_F",
						"B_RangeMaster_F",
						"B_crew_F",
						"B_Pilot_F",
						"B_helicrew_F",
						
						"O_helipilot_F",
						"O_diver_F",
						"O_diver_TL_F",
						"O_diver_exp_F",
						"O_crew_F",
						"O_Pilot_F",
						"O_helicrew_F",
						"O_UAV_AI",
						
						"I_crew_F",
						"I_helipilot_F",
						"I_helicrew_F",
						"I_diver_F",
						"I_diver_exp_F",
						"I_diver_TL_F",
						"I_pilot_F",
						"I_Story_Colonel_F"
                    ];
                    
                    //Get all enterable houses of strategic types below across the whole map (rest will be regular)
                    //_spawnhouses = call ALiVE_fnc_getAllEnterableHouses;
              
                    private ["_collection","_objectives","_pos","_size"];

                    _collection = [];
                    if (count synchronizedObjects _logic > 0) then {
                        _objectives = [];
                        for "_i" from 0 to ((count synchronizedObjects _logic)-1) do {
							private ["_obj"];
                        
                        	waituntil {sleep 5; _obj = nil; _obj = [(synchronizedObjects _logic) select _i,"objectives",objNull,[]] call ALIVE_fnc_OOsimpleOperation; (!(isnil "_obj") && {count _obj > 0})};
                        	_objectives = _objectives + _obj;
                        };
                        {
                            _pos = [_x,"center"] call ALiVE_fnc_HashGet;
                            _size = [_x,"size"] call ALiVE_fnc_HashGet;
                            
                            _collection set [count _collection,[_pos,_size]];
                        } foreach _objectives;
                    } else {
                        switch (_CQB_Locations) do {
                            case ("towns") : {
		                        _objectives = nearestLocations [getArray (configFile >> "CfgWorlds" >> worldName >> "centerPosition"), ["NameCityCapital","NameCity","NameVillage","NameLocal","Hill"],20000];
		                        {
		                            _pos = position _x;
		                            _size = size _x;
		                            
		                            if (_size select 0 > _size select 1) then {_size = _size select 0} else {_size = _size select 1};
		                            
		                            _collection set [count _collection,[_pos,_size]];
		                        } foreach _objectives;
                            };
                            case ("all") : {
                                _collection set [count _collection,[getArray (configFile >> "CfgWorlds" >> worldName >> "centerPosition"),30000]];
                            };
                            default {};
                        };
                    };
                    
                    _houses_reg = [];
                    _houses_strat = [];
                    {
                        private ["_houses_tmp","_pos","_size"];
                        _time = time;
                        _pos = _x select 0;
                        _size = _x select 1;

                        _houses_reg_tmp = nearestObjects [_pos, ["house"], _size];
                        _houses_strat_tmp = nearestObjects [_pos, _strategicTypes, _size];
                        
                        _houses_reg = _houses_reg + _houses_reg_tmp;
                        _houses_strat = _houses_strat + _houses_strat_tmp;
                        
                        //player sidechat format["Search for houses at %1 finished! Time taken %2",_x,time - _time];
                        //diag_log format["Search for houses at %1 finished! Time taken %2",_x,time - _time];
                    } foreach _collection;
                    
                    _houses = _houses_reg + _houses_strat;
                    
                    _result = [_houses,_strategicTypes,_CQB_density,[_logic, "blacklist"] call ALiVE_fnc_CQB] call ALiVE_fnc_CQBsortStrategicHouses;
                    _strategicHouses = _result select 0;
					_nonStrategicHouses = _result select 1;

					//set default values on main CQB instance
                    [MOD(CQB), "houses", _houses] call ALiVE_fnc_CQB;
                    [MOD(CQB), "factions", _factionsStrat + _factionsReg] call ALiVE_fnc_CQB;
					[MOD(CQB), "spawnDistance", 1000] call ALiVE_fnc_CQB;

                    // Create strategic CQB instance
                    _logic = (createGroup sideLogic) createUnit ["LOGIC", [0,0], [], 0, "NONE"];
        			_logic setVariable ["class", ALiVE_fnc_CQB];
                    _logic setVariable ["UnitsBlackList",_UnitsBlackList,true];
					[_logic, "houses", _strategicHouses] call ALiVE_fnc_CQB;
					[_logic, "factions", _factionsStrat] call ALiVE_fnc_CQB;
					[_logic, "spawnDistance", 1000] call ALiVE_fnc_CQB;
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
					[_logic, "spawnDistance", 700] call ALiVE_fnc_CQB;
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

                    if (isServer) then {
                        _logic setVariable ["startupComplete", true];
                    };
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
				
            //Client?
            if(!isDedicated && !isHC) then {
                [CQB_Strategic, "debug", CQB_GLOBALDEBUG] call ALiVE_fnc_CQB;
                [CQB_Regular, "debug", CQB_GLOBALDEBUG] call ALiVE_fnc_CQB;
                
                //Delete markers
                [MOD(CQB), "blacklist", MOD(CQB) getVariable ["blacklist", DEFAULT_BLACKLIST]] call ALiVE_fnc_CQB;
        		{deleteMarkerLocal _x} foreach (MOD(CQB) getVariable ["blacklist", DEFAULT_BLACKLIST]);
            };
        };
        
        case "blacklist": {
            if !(isnil "_args") then {
				if(typeName _args == "STRING") then {
                    if !(_args == "") then {
						_args = [_args, " ", ""] call CBA_fnc_replace;
						_args = [_args, ","] call CBA_fnc_split;
						if(count _args > 0) then {
							_logic setVariable [_operation, _args];
						};
                    } else {
                        _logic setVariable [_operation, []];
                    };
				} else {
					if(typeName _args == "ARRAY") then {		
						_logic setVariable [_operation, _args];
					};
	            };
            };
            _args = _logic getVariable [_operation, DEFAULT_BLACKLIST];
            
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
			["CQB Population: %1 remaing positions | %2 active positions | %3 local CQB AI...", _remaincount, _activecount, _cqbai] call ALiVE_fnc_Dump;        
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
			_args = _logic getVariable [_operation, []];
		} else {
			if(typeName _args == "STRING") then {
	            if !(_args == "") then {
					_args = [_args, " ", ""] call CBA_fnc_replace;
                    _args = [_args, "[", ""] call CBA_fnc_replace;
                    _args = [_args, "]", ""] call CBA_fnc_replace;
                    _args = [_args, """", ""] call CBA_fnc_replace;
					_args = [_args, ","] call CBA_fnc_split;
					if(count _args > 0) then {
						_logic setVariable [_operation, _args];
					};
	            } else {
	                _logic setVariable [_operation, []];
	            };
			} else {
				if(typeName _args == "ARRAY") then {		
					_logic setVariable [_operation, _args];
				};
	        };
			_args = _logic getVariable [_operation, []];
        };
        _logic setVariable [_operation, _args, true];
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
                ["CQB Population: Adding house %1...", _house] call ALiVE_fnc_Dump;
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

			if (!(isNil "_grp") && {({alive _x} count (units _grp) == 0)}) then {
                
                //Remove group from list but dont delete bodies (done by GC)
                if (_logic getVariable ["debug", false]) then {
					["CQB Population: Removing group %1...", _grp] call ALiVE_fnc_Dump;
				};
				[_logic,"groups",[_grp],true,true] call BIS_fnc_variableSpaceRemove;
                
                //Remove house from list
                if (_logic getVariable ["debug", false]) then {
					["CQB Population: Clearing house %1...", _house] call ALiVE_fnc_Dump;
				};
                [_logic,"houses",[_house],true,true] call BIS_fnc_variableSpaceRemove;
                
			} else {
                ["CQB Population Warning: Group %1 is still alive! Removing...", _grp] call ALiVE_fnc_Dump;
                
                [_logic, "delGroup", _grp] call ALiVE_fnc_CQB;
                [_logic,"houses",[_house],true,true] call BIS_fnc_variableSpaceRemove;
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
	        	["CQB Population: Group %1 created on %2", _grp, owner leader _grp] call ALiVE_fnc_Dump;
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
            if !(isnil "_house") then {
                _house setVariable ["group",nil, true];
                format[MTEMPLATE, _house] setMarkerTypeLocal "mil_Dot";
            };
            
            // Despawn group
            if (_logic getVariable ["debug", false]) then {
				["CQB Population: Deleting group %1 from %2...", _grp, owner leader _grp] call ALiVE_fnc_Dump;
			};
            
			[_logic,"groups",[_grp],true,true] call BIS_fnc_variableSpaceRemove;
			{deleteVehicle _x} forEach units _grp;
            deleteGroup _grp;
	    };
	};
    
    case "spawnGroup": {
		if(isNil "_args") then {
			// if no units and house was provided return false
			_args = false;
		} else {
			// if a house and unit is provided start spawn process
			ASSERT_TRUE(typeName _args == "ARRAY",str typeName _args);
            
            private ["_faction","_houseFaction"];
            
            _house = _args select 0;
            _faction = _args select 1;
            
            _debug = _logic getVariable ["debug",false];
            
        	_createUnitTypes = {
				private ["_factions","_units","_blacklist","_faction","_houseFaction"];
				PARAMS_1(_factions);
                _blacklist = _logic getVariable ["UnitsBlackList",[]];
				[_factions, ceil(random 2),_blacklist] call ALiVE_fnc_chooseRandomUnits;
			};
            
            private ["_side"];
            
			// Action: spawn AI
			// this just flags the house as beginning spawning
			// and will be over-written in addHouse
			
			_units = _house getVariable ["unittypes", []];
            _houseFaction = _house getVariable ["faction", (_logic getvariable ["factions",["OPF_F"]]) call BIS_fnc_SelectRandom];

			// Check: if no units already defined
			if ((count _units == 0) || {!(_houseFaction == _faction)}) then {
				// Action: identify AI unit types
				_units = [[_faction]] call (_logic getVariable ["_createUnitTypes", _createUnitTypes]);
				_house setVariable ["unittypes", _units, true];
                _house setVariable ["faction", _faction, true];
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
					["CQB Population: Group %1 deleted on creation - no units...", _grp] call ALiVE_fnc_Dump;
				};
				[_logic, "delGroup", _grp] call ALiVE_fnc_CQB;
			};
			// position AI
			_positions = [_house] call ALiVE_fnc_getBuildingPositions;
            if (count _positions == 0) exitwith {_grp};
            
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
				private ["_logic","_units","_grp","_positions","_house","_debug","_spawn","_maxgrps","_leader","_createUnitTypes","_despawnGroup","_host","_players","_playerhosts","_faction","_useDominantFaction"];
				_logic = _this;
                
				
				// default functions - can be overridden
				// over-arching spawning loop
					waitUntil{
						sleep (2 + random 1);
                        _debug = _logic getVariable ["debug",false];
						_spawn = _logic getVariable ["spawnDistance", 800];
                        _useDominantFaction = call compile (MOD(CQB) getvariable ["CQB_UseDominantFaction","true"]);
                        
						{
							// if conditions are right, spawn a group and place them
							_house = _x;
						
							// Check: house doesn't already have AI AND
							// Check: if any players within spawn distance

                            _players = [] call BIS_fnc_listPlayers;
                            _nearplayers = ({(((getposATL _x) select 2) < 10) && {((getPosATL _house) distance _x) < _spawn}} count _players);
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
                                            
                                            if (_useDominantFaction) then {
                                            	_faction = [getposATL _house, 500] call ALiVE_fnc_getDominantFaction;
                                            	if (isnil "_faction") then {_faction = (_logic getvariable ["factions",["OPF_F"]]) call BIS_fnc_SelectRandom};
                                            } else {
                                                _faction = (_logic getvariable ["factions",["OPF_F"]]) call BIS_fnc_SelectRandom;
                                            };
                                            
                                            [_host,"CQB",[[_logic, "spawnGroup", [_house,_faction]],{call ALiVE_fnc_CQB}]] call ALiVE_fnc_BUS;
                                            
                                            ["CQB Population: Group creation triggered on client %1 for house %2 and dominantfaction %3...",_host,_house,_faction] call ALiVE_fnc_Dump;
                                            sleep 0.1;
	                                    } else {
	                                        ["CQB ERROR: Null object on host %1",_host] call ALiVE_fnc_DumpR;
	                                    };
                                	} else {
                                        ["CQB ERROR: No playerhosts for house %1!",_house] call ALiVE_fnc_DumpR;
                                    };
                                } else {
                                    ["CQB ERROR: No players in List %1!",_players] call ALiVE_fnc_DumpR;
                                };
                            };
						} forEach (_logic getVariable ["houses", []]);
						{
							_grp = _x;
                            
                            if !(isnil "_grp") then { 
	                            _leader = leader _grp;
								
	                            // get house in question
								_house = _leader getVariable ["house",(_grp getvariable "house")];
	                            
	                            //If house is defined then... (can be disabled due to "object streaming")
	                            if !(isnil "_house") then {
	                               
		                            // Initializing grouphouse locally on all units to save PVs (see addgroup). 
		                            // If not all units are flagged with house then flag them;
		                            if (({!(isnil {_x getvariable ["house",nil]})} count (units _grp)) != (count units _grp)) then {
		                                {_x setvariable ["house",_house]} foreach (units _grp); _grp setvariable ["house",_house];
		                            };
									
									// if group are all dead
									// mark house as cleared
									if ({alive _x} count (units _grp) == 0) then {
		                                
		                                if (isnil "_house") exitwith {["CQB ERROR: _House didnt exist, when trying to clear it!"] call ALiVE_fnc_DumpR};
										
		                                // update central CQB house listings
										[_logic, "clearHouse", _house] call ALiVE_fnc_CQB;
									};
	                            } else {
	                                ["CQB ERROR: No House was defined for CQB group %1! Count units in group that have _house set: %2", _grp, {!(isnil {_x getvariable ["house",nil]})} count (units _grp)] call ALiVE_fnc_DumpR;
									[_logic, "delGroup", _grp] call ALiVE_fnc_CQB;
	                            };
                            } else {
                            	["CQB ERROR: No Group was defined! Moving on..."] call ALiVE_fnc_DumpR;
                            };
                            
						} forEach (_logic getVariable ["groups",[]]);
                        
                        if (_debug) then {
	                        _remaincount = count (_logic getVariable ["houses", []]);
	                        _housesempty = {(isNil {_x getVariable "group"})} count (_logic getVariable ["houses", []]);
							_activecount = count (_logic getVariable ["groups", []]);
	                        _groupsempty = {(isNil {(leader _x) getVariable "house"})} count (_logic getVariable ["groups", []]);
	                        
	                       ["CQB Population: %1 remaing positions | %2 active positions | inactive houses %3 | groups with no house %4...", _remaincount, _activecount,_housesempty,_groupsempty] call ALiVE_fnc_Dump; 
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
if !(isnil "_args") then {_args} else {nil};