//#define DEBUG_MPDE_FULL
#include <\x\alive\addons\mil_logistics\script_component.hpp>
SCRIPT(ML);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_ML
Description:
Military objectives 

Parameters:
Nil or Object - If Nil, return a new instance. If Object, reference an existing instance.
String - The selected function
Array - The selected parameters

Returns:
Any - The new instance or the result of the selected function and parameters

Attributes:
Nil - init - Initiate instance
Nil - destroy - Destroy instance
Boolean - debug - Debug enabled
Array - state - Save and restore module state
Array - faction - Faction associated with module

Examples:
[_logic, "debug", true] call ALiVE_fnc_ML;

See Also:
- <ALIVE_fnc_MLInit>

Author:
ARJay
---------------------------------------------------------------------------- */

#define SUPERCLASS ALIVE_fnc_baseClass
#define MAINCLASS ALIVE_fnc_ML
#define MTEMPLATE "ALiVE_ML_%1"
#define DEFAULT_INTEL_CHANCE "0.1"

private ["_logic","_operation","_args","_result"];

TRACE_1("ML - input",_this);

_logic = [_this, 0, objNull, [objNull]] call BIS_fnc_param;
_operation = [_this, 1, "", [""]] call BIS_fnc_param;
_args = [_this, 2, objNull, [objNull,[],"",0,true,false]] call BIS_fnc_param;
_result = true;

switch(_operation) do {
	default {
		_result = [_logic, _operation, _args] call SUPERCLASS;
	};
	case "destroy": {
		[_logic, "debug", false] call MAINCLASS;
		if (isServer) then {
			// if server
			_logic setVariable ["super", nil];
			_logic setVariable ["class", nil];

			[_logic, "destroy"] call SUPERCLASS;
		};
		
	};
	case "debug": {
		if (typeName _args == "BOOL") then {
			_logic setVariable ["debug", _args];
		} else {
			_args = _logic getVariable ["debug", false];
		};
		if (typeName _args == "STRING") then {
				if(_args == "true") then {_args = true;} else {_args = false;};
				_logic setVariable ["debug", _args];
		};
		ASSERT_TRUE(typeName _args == "BOOL",str _args);

		_result = _args;
	};        
	case "state": {
		private["_state","_data","_nodes","_simple_operations"];
		/*
		_simple_operations = ["targets", "size","type","faction"];
		
		if(typeName _args != "ARRAY") then {
			_state = [] call CBA_fnc_hashCreate;
			// Save state
			{
				[_state, _x, _logic getVariable _x] call ALIVE_fnc_hashSet;
			} forEach _simple_operations;

			if ([_logic, "debug"] call MAINCLASS) then {
				diag_log PFORMAT_2(QUOTE(MAINCLASS), _operation,_state);
			};
			_result = _state;
		} else {
			ASSERT_TRUE([_args] call CBA_fnc_isHash,str _args);
			
			// Restore state
			{
				[_logic, _x, [_args, _x] call ALIVE_fnc_hashGet] call MAINCLASS;
			} forEach _simple_operations;
		};
		*/		
	};
	// Main process
	case "init": {
        if (isServer) then {
			// if server, initialise module game logic
			_logic setVariable ["super", SUPERCLASS];
			_logic setVariable ["class", MAINCLASS];
			_logic setVariable ["moduleType", "ALIVE_ML"];
			_logic setVariable ["startupComplete", false];
			
			_logic setVariable ["intelligenceObtained", [] call ALIVE_fnc_hashCreate];
			TRACE_1("After module init",_logic);

			[_logic,"register"] call MAINCLASS;			
        };
	};
	case "register": {
		
			private["_registration","_moduleType"];
		
			_moduleType = _logic getVariable "moduleType";
			_registration = [_logic,_moduleType,["SYNCED"]];
	
			if(isNil "ALIVE_registry") then {
				ALIVE_registry = [nil, "create"] call ALIVE_fnc_registry;
				[ALIVE_registry, "init"] call ALIVE_fnc_registry;			
			};

			[ALIVE_registry,"register",_registration] call ALIVE_fnc_registry;
	};
	// Main process
	case "start": {
        if (isServer) then {
		
			private ["_debug","_modules","_module","_activeAnalysisJobs"];
			
			_debug = [_logic, "debug"] call MAINCLASS;			
			
			
			// DEBUG -------------------------------------------------------------------------------------
			if(_debug) then {
				["----------------------------------------------------------------------------------------"] call ALIVE_fnc_dump;
				["ALIVE ML - Startup"] call ALIVE_fnc_dump;
			};
			// DEBUG -------------------------------------------------------------------------------------
				
				
			_modules = [];
					
			for "_i" from 0 to ((count synchronizedObjects _logic)-1) do {
				_module = (synchronizedObjects _logic) select _i;
				_module = _module getVariable "handler";
				_modules set [count _modules, _module];
			};
			
			
			// DEBUG -------------------------------------------------------------------------------------
			if(_debug) then {
				["ALIVE ML - Startup completed"] call ALIVE_fnc_dump;
				["----------------------------------------------------------------------------------------"] call ALIVE_fnc_dump;
			};
			// DEBUG -------------------------------------------------------------------------------------
			
			
			_logic setVariable ["startupComplete", true];
			
			if(count _modules > 0) then {
				[_logic, "monitor", _modules] call MAINCLASS;
			}else{
				["ALIVE ML - Warning no OPCOM modules synced to Military Logistics module, nothing to do.."] call ALIVE_fnc_dumpR;
			};					
        };
	};
	// Main process
	case "monitor": {
        if (isServer) then {
		
			private ["_debug","_modules","_module","_modulesObjectives","_moduleSide","_moduleFactions","_moduleFactionBreakdowns","_faction","_factionBreakdown","_objectives"];
			
			_modules = _args;
			
			_debug = [_logic, "debug"] call MAINCLASS;
			_modulesObjectives = [];
			
			// get objectives and modules settings from syncronised OPCOM instances
			{
				_module = _x;
				_moduleSide = [_module,"side"] call ALiVE_fnc_HashGet;
				_moduleFactions = [_module,"factions"] call ALiVE_fnc_HashGet;
                _moduleFactionBreakdowns = [] call ALIVE_fnc_hashCreate;

                // loop through module factions and get a breakdown of
                // faction force composition from the profile handler
                {
				    _faction = _x;

				    _factionBreakdown = [ALIVE_profileHandler,"getFactionBreakdown",_faction] call ALIVE_fnc_profileHandler;
                    [_moduleFactionBreakdowns, _faction, _factionBreakdown] call ALIVE_fnc_hashSet;


                    // DEBUG -------------------------------------------------------------------------------------
                    if(_debug) then {
                        ["ALIVE ML - [%1] Initial faction breakdown", _faction] call ALIVE_fnc_dump;
				        _factionBreakdown call ALIVE_fnc_inspectHash;
				    };
				    // DEBUG -------------------------------------------------------------------------------------


				} forEach _moduleFactions;

				_objectives = [];

				waituntil {
					sleep 10;
					_objectives = nil;
					_objectives = [_module,"objectives"] call ALIVE_fnc_hashGet;
					(!(isnil "_objectives") && {count _objectives > 0})
				};
				
				_modulesObjectives set [count _modulesObjectives, [_moduleSide,_moduleFactions,_moduleFactionBreakdowns,_objectives]];
				
			} forEach _modules;

			// spawn monitoring loop
			
			[_logic, _debug, _modulesObjectives] spawn {
			
				private ["_debug","_modulesObjectives","_moduleSide","_moduleFactions","_initialFactionBreakdowns",
				"_objectives","_reserve","_faction","_factionBreakdown","_initialFactionBreakdown","_currentTotalProfiles","_initialTotalProfiles","_profileDeficit"];
				
				_logic = _this select 0;
				_debug = _this select 1;
				_modulesObjectives = _this select 2;

				// Load static data

                if(isNil "ALIVE_unitBlackist") then {
                    _file = "\x\alive\addons\mil_placement\static\staticData.sqf";
                    call compile preprocessFileLineNumbers _file;
                };
								
				waituntil {
					sleep (10);
					
					{
						_moduleSide = _x select 0;
						_moduleFactions = _x select 1;
						_initialFactionBreakdowns = _x select 2;
						_objectives = _x select 3;

						{

                            _reserve = [];

                            // sort objective states
                            {
                                _tacom_state = '';
                                if("tacom_state" in (_x select 1)) then {
                                    _tacom_state = [_x,"tacom_state"] call ALIVE_fnc_hashGet;
                                };

                                /*
                                _id = [_x,"objectiveID"] call ALIVE_fnc_hashGet;
                                _x call ALIVE_fnc_inspectHash;
                                ["OBJ: %1 state: %2",_id, _tacom_state] call ALIVE_fnc_dump;
                                */

                                switch(_tacom_state) do {
                                    case "reserve":{
                                        _reserve set [count _reserve, [_moduleSide, _x]];
                                    };
                                };

                            } forEach _objectives;

                            // have locations to resupply
                            if(count _reserve > 0) then {


                                // DEBUG -------------------------------------------------------------------------------------
                                if(_debug) then {
                                    /*
                                    ["----------------------------------------------------------------------------------------"] call ALIVE_fnc_dump;
                                    ["ALIVE ML - %1 reserved clusters found for side, checking if re-inforcements required %2", count _reserve, _moduleSide] call ALIVE_fnc_dump;
                                    */
                                };
                                // DEBUG -------------------------------------------------------------------------------------

                                // loop through module factions and get a breakdown of
                                // faction force composition from the profile handler
                                {
                                    _faction = _x;

                                    _factionBreakdown = [ALIVE_profileHandler,"getFactionBreakdown",_faction] call ALIVE_fnc_profileHandler;
                                    _initialFactionBreakdown = [_initialFactionBreakdowns,_faction] call ALIVE_fnc_hashGet;

                                    _currentTotalProfiles = [_factionBreakdown, "total"] call ALIVE_fnc_hashGet;
                                    _initialTotalProfiles = [_initialFactionBreakdown, "total"] call ALIVE_fnc_hashGet;


                                    // DEBUG -------------------------------------------------------------------------------------
                                    if(_debug) then {
                                        /*
                                        ["ALIVE ML - [%1] Initial faction breakdown", _faction] call ALIVE_fnc_dump;
                                        _initialFactionBreakdown call ALIVE_fnc_inspectHash;
                                        ["ALIVE ML - [%1] Current faction breakdown", _faction] call ALIVE_fnc_dump;
                                        _factionBreakdown call ALIVE_fnc_inspectHash;
                                        */
                                    };
                                    // DEBUG -------------------------------------------------------------------------------------


                                    // the faction has suffered losses
                                    if(_currentTotalProfiles < _initialTotalProfiles) then {

                                        _profileDeficit = _initialTotalProfiles - _currentTotalProfiles;

                                        // DEBUG -------------------------------------------------------------------------------------
                                        if(_debug) then {
                                            ["----------------------------------------------------------------------------------------"] call ALIVE_fnc_dump;
                                            ["ALIVE ML - [%1] Has suffered losses. current force strength: %2 initial force strength: %3 ", _faction, _currentTotalProfiles, _initialTotalProfiles] call ALIVE_fnc_dump;
                                        };
                                        // DEBUG -------------------------------------------------------------------------------------

                                        private ["_entitiesDeficit","_vehiclesDeficit","_entitiesDeficit","_carDeficit","_tankDeficit","_armorDeficit","_truckDeficit",
                                        "_group","_groups","_groupCount","_clusterCount","_groupPerCluster","_countProfiles","_totalCount"];

                                        // calculate force deficit of current forces in comparison to initial forces
                                        _entitiesDeficit = ([_initialFactionBreakdown, "entity"] call ALIVE_fnc_hashGet) - ([_factionBreakdown, "entity"] call ALIVE_fnc_hashGet);
                                        _vehiclesDeficit = ([_initialFactionBreakdown, "vehicle"] call ALIVE_fnc_hashGet) - ([_factionBreakdown, "vehicle"] call ALIVE_fnc_hashGet);
                                        _entitiesDeficit = _entitiesDeficit - _vehiclesDeficit;
                                        _carDeficit = ([_initialFactionBreakdown, "car"] call ALIVE_fnc_hashGet) - ([_factionBreakdown, "car"] call ALIVE_fnc_hashGet);
                                        _tankDeficit = ([_initialFactionBreakdown, "tank"] call ALIVE_fnc_hashGet) - ([_factionBreakdown, "tank"] call ALIVE_fnc_hashGet);
                                        _armorDeficit = ([_initialFactionBreakdown, "armor"] call ALIVE_fnc_hashGet) - ([_factionBreakdown, "armor"] call ALIVE_fnc_hashGet);
                                        _truckDeficit = ([_initialFactionBreakdown, "truck"] call ALIVE_fnc_hashGet) - ([_factionBreakdown, "truck"] call ALIVE_fnc_hashGet);

                                        ["Group deficits %1 Entities %2 Vehciles %3 Car %4 Tank %5 Armor %6 Truck",_entitiesDeficit,_vehiclesDeficit,_carDeficit,_tankDeficit,_armorDeficit,_truckDeficit] call ALIVE_fnc_dump;

                                        // generate groups list
                                        _groups = [];
                                        _totalCount = 0;

                                        for "_i" from 0 to _entitiesDeficit -1 do {
                                            _group = ["Infantry",_faction] call ALIVE_fnc_configGetRandomGroup;
                                            if!(_group == "FALSE") then {
                                                _groups set [count _groups, _group];
                                            }
                                        };

                                        for "_i" from 0 to _tankDeficit -1 do {
                                            _group = ["Armored",_faction] call ALIVE_fnc_configGetRandomGroup;
                                            if!(_group == "FALSE") then {
                                                _groups set [count _groups, _group];
                                            };
                                        };

                                        for "_i" from 0 to _armorDeficit -1 do {
                                            _group = ["Mechanized",_faction] call ALIVE_fnc_configGetRandomGroup;
                                            if!(_group == "FALSE") then {
                                                _groups set [count _groups, _group];
                                            }
                                        };

                                        for "_i" from 0 to _carDeficit -1 do {
                                            _group = ["Motorized",_faction] call ALIVE_fnc_configGetRandomGroup;
                                            if!(_group == "FALSE") then {
                                                _groups set [count _groups, _group];
                                            };
                                        };

                                        _groups = _groups - ALIVE_groupBlacklist;

                                        _groupCount = count _groups;

                                        _clusterCount = count _reserve;
                                        _groupPerCluster = floor(_groupCount / _clusterCount);
                                        _countProfiles = 0;
                                        _totalCount = 0;

                                        // dont want to spawn too many groups on objectives if
                                        // not many are held
                                        if(_groupPerCluster > 5) then {
                                            _groupPerCluster = 2;
                                        };

                                        // place new groups around objectives
                                        {
                                            private ["_objective","_id","_center","_size","_sector","_sectorData","_profiles"];

                                            _objective = _x select 1;
                                            _id = [_objective,"objectiveID"] call ALIVE_fnc_hashGet;
                                            _center = [_objective,"center"] call ALIVE_fnc_hashGet;
                                            _size = [_objective,"size"] call ALIVE_fnc_hashGet;
                                            _sector = [ALIVE_sectorGrid, "positionToSector", _center] call ALIVE_fnc_sectorGrid;
                                            _sectorData = [_sector, "data"] call ALIVE_fnc_hashGet;

                                            // TODO: check if there are any players in the sector
                                            /*
                                            if("active" in (_sectorData select 1)) then {
                                                _active = [_sectorData, "active"] call ALIVE_fnc_hashGet;
                                                if(count _active > 0 ) then {
                                                    ["player in sector"] call ALIVE_fnc_dump;
                                                };
                                            };
                                            */

                                            if(_totalCount < _groupCount) then {

                                                if(_groupPerCluster > 0) then {

                                                    for "_i" from 0 to _groupPerCluster -1 do {
                                                        _group = _groups select _totalCount;
                                                        _position = [_center, (_size + random(500)), random(360)] call BIS_fnc_relPos;
                                                        _profiles = [_group, _position, random(360), true, _faction] call ALIVE_fnc_createProfilesFromGroupConfig;

                                                        _countProfiles = _countProfiles + count _profiles;
                                                        _totalCount = _totalCount + 1;
                                                    };

                                                }else{
                                                    _group = _groups select _totalCount;
                                                    _position = [_center, (_size + random(500)), random(360)] call BIS_fnc_relPos;
                                                    _profiles = [_group, _position, random(360), true, _faction] call ALIVE_fnc_createProfilesFromGroupConfig;

                                                    _countProfiles = _countProfiles + count _profiles;
                                                    _totalCount = _totalCount + 1;
                                                };
                                            };
                                        } forEach _reserve;


                                        // DEBUG -------------------------------------------------------------------------------------
                                        if(_debug) then {
                                            ["ALIVE ML - Total profiles created: %1",_countProfiles] call ALIVE_fnc_dump;
                                            ["ALIVE ML - Reinforcement completed"] call ALIVE_fnc_dump;
                                            //[] call ALIVE_fnc_timer;
                                            ["----------------------------------------------------------------------------------------"] call ALIVE_fnc_dump;
                                        };
                                        // DEBUG -------------------------------------------------------------------------------------

                                    };

                                } forEach _moduleFactions;


                            }else{


                                // DEBUG -------------------------------------------------------------------------------------
                                if(_debug) then {
                                    ["----------------------------------------------------------------------------------------"] call ALIVE_fnc_dump;
                                    ["ALIVE ML - no reserved clusters for side, cannot re-inforce %1", _moduleSide] call ALIVE_fnc_dump;
                                };
                                // DEBUG -------------------------------------------------------------------------------------


                            };

						} forEach _moduleFactions;
						
					} forEach _modulesObjectives;
					
					false 
				};
			};
		};		
	};
};

TRACE_1("ML - output",_result);
_result;