//#define DEBUG_MODE_FULL
#include <\x\alive\addons\amb_civ_placement\script_component.hpp>
SCRIPT(AMBCP);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_AMBCP
Description:
Civitary objectives 

Parameters:
Nil or Object - If Nil, return a new instance. If Object, reference an existing instance.
String - The selected function
Array - The selected parameters

Returns:
Any - The new instance or the result of the selected function and parameters

Attributes:
Nil - init - Intiate instance
Nil - destroy - Destroy instance
Boolean - debug - Debug enabled
Array - state - Save and restore module state
Array - faction - Faction associated with module

Examples:

See Also:
- <ALIVE_fnc_CPInit>

Author:
Wolffy
ARJay
---------------------------------------------------------------------------- */

#define SUPERCLASS ALIVE_fnc_baseClass
#define MAINCLASS ALIVE_fnc_AMBCP
#define MTEMPLATE "ALiVE_AMBCP_%1"
#define DEFAULT_SIZE "100"
#define DEFAULT_OBJECTIVES []
#define DEFAULT_TAOR []
#define DEFAULT_BLACKLIST []
#define DEFAULT_SIZE_FILTER "160"
#define DEFAULT_PRIORITY_FILTER "0"
#define DEFAULT_FACTION QUOTE(CIV_F)
#define DEFAULT_AMBIENT_VEHICLE_AMOUNT "1"

private ["_logic","_operation","_args","_result"];

TRACE_1("AMBCP - input",_this);

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
	};        
	// Determine force faction
	case "faction": {
		_result = [_logic,_operation,_args,DEFAULT_FACTION,[] call BIS_fnc_getFactions] call ALIVE_fnc_OOsimpleOperation;
	};
	// Return TAOR marker
	case "taor": {
		if(typeName _args == "STRING") then {
			_args = [_args, " ", ""] call CBA_fnc_replace;
			_args = [_args, ","] call CBA_fnc_split;
			if(count _args > 0) then {
				_logic setVariable [_operation, _args];
			};
		};
		if(typeName _args == "ARRAY") then {		
			_logic setVariable [_operation, _args];
		};
		_result = _logic getVariable [_operation, DEFAULT_TAOR];
	};
	// Return the Blacklist marker
	case "blacklist": {
		if(typeName _args == "STRING") then {
			_args = [_args, " ", ""] call CBA_fnc_replace;
			_args = [_args, ","] call CBA_fnc_split;
			if(count _args > 0) then {
				_logic setVariable [_operation, _args];
			};
		};
		if(typeName _args == "ARRAY") then {		
			_logic setVariable [_operation, _args];
		};
		_result = _logic getVariable [_operation, DEFAULT_BLACKLIST];		
	};
	// Return the Size filter
	case "sizeFilter": {
		_result = [_logic,_operation,_args,DEFAULT_SIZE_FILTER] call ALIVE_fnc_OOsimpleOperation;
	};
	// Return the Priority filter
	case "priorityFilter": {
		_result = [_logic,_operation,_args,DEFAULT_PRIORITY_FILTER] call ALIVE_fnc_OOsimpleOperation;
	};
	// Return the Ambient Vehicle Amount
    case "ambientVehicleAmount": {
        _result = [_logic,_operation,_args,DEFAULT_AMBIENT_VEHICLE_AMOUNT] call ALIVE_fnc_OOsimpleOperation;
    };
	// Return the objectives as an array of clusters
	case "objectives": {
		_result = [_logic,_operation,_args,DEFAULT_OBJECTIVES] call ALIVE_fnc_OOsimpleOperation;
	};
	// Return the HQ objectives as an array of clusters
	case "objectivesHQ": {
		_result = [_logic,_operation,_args,DEFAULT_OBJECTIVES] call ALIVE_fnc_OOsimpleOperation;
	};
	// Return the Power objectives as an array of clusters
	case "objectivesPower": {
		_result = [_logic,_operation,_args,DEFAULT_OBJECTIVES] call ALIVE_fnc_OOsimpleOperation;
	};
	// Return the Comms objectives as an array of clusters
	case "objectivesComms": {
		_result = [_logic,_operation,_args,DEFAULT_OBJECTIVES] call ALIVE_fnc_OOsimpleOperation;
	};
	// Return the MARINE objectives as an array of clusters
	case "objectivesMarine": {
		_result = [_logic,_operation,_args,DEFAULT_OBJECTIVES] call ALIVE_fnc_OOsimpleOperation;
	};
	// Return the RAIL objectives as an array of clusters
	case "objectivesRail": {
		_result = [_logic,_operation,_args,DEFAULT_OBJECTIVES] call ALIVE_fnc_OOsimpleOperation;
	};
	// Return the FUEL objectives as an array of clusters
	case "objectivesFuel": {
		_result = [_logic,_operation,_args,DEFAULT_OBJECTIVES] call ALIVE_fnc_OOsimpleOperation;
	};
	// Return the CONSTRUCTION objectives as an array of clusters
	case "objectivesConstruction": {
		_result = [_logic,_operation,_args,DEFAULT_OBJECTIVES] call ALIVE_fnc_OOsimpleOperation;
	};
	// Return the SETTLEMENT objectives as an array of clusters
	case "objectivesSettlement": {
		_result = [_logic,_operation,_args,DEFAULT_OBJECTIVES] call ALIVE_fnc_OOsimpleOperation;
	};
	// Main process
	case "init": {
        if (isServer) then {
						
			// if server, initialise module game logic
			_logic setVariable ["super", SUPERCLASS];
			_logic setVariable ["class", MAINCLASS];
			_logic setVariable ["moduleType", "ALIVE_AMBCP"];
			_logic setVariable ["startupComplete", false];
			TRACE_1("After module init",_logic);

			[_logic, "taor", _logic getVariable ["taor", DEFAULT_TAOR]] call MAINCLASS;
			[_logic, "blacklist", _logic getVariable ["blacklist", DEFAULT_TAOR]] call MAINCLASS;

            /*
            if !(["ALiVE_sys_profile"] call ALiVE_fnc_isModuleAvailable) then {
                ["Profile System module not placed! Exiting..."] call ALiVE_fnc_DumpR;
            };
            waituntil {!(isnil "ALiVE_ProfileHandler")};
            */
            
            [_logic,"start"] call MAINCLASS;
        } else {
            [_logic, "taor", _logic getVariable ["taor", DEFAULT_TAOR]] call MAINCLASS;
            [_logic, "blacklist", _logic getVariable ["blacklist", DEFAULT_TAOR]] call MAINCLASS;
            {_x setMarkerAlpha 0} foreach (_logic getVariable ["taor", DEFAULT_TAOR]);
            {_x setMarkerAlpha 0} foreach (_logic getVariable ["blacklist", DEFAULT_TAOR]);            
        };
	};
    case "start": {
        if (isServer) then {
		
			private ["_debug","_clusterType","_worldName","_file","_clusters","_cluster","_taor","_taorClusters","_blacklist",
			"_sizeFilter","_priorityFilter","_blacklistClusters","_center"];
						
			_debug = [_logic, "debug"] call MAINCLASS;
			
			if(_debug) then {
				["----------------------------------------------------------------------------------------"] call ALIVE_fnc_dump;
				["ALIVE AMBCP - Startup"] call ALIVE_fnc_dump;
				[true] call ALIVE_fnc_timer;
			};
			
			
			if(isNil "ALIVE_clustersCiv" && isNil "ALIVE_loadedCivClusters") then {				
				_worldName = toLower(worldName);			
				_file = format["\x\alive\addons\civ_placement\clusters\clusters.%1_civ.sqf", _worldName];				
				call compile preprocessFileLineNumbers _file;
				ALIVE_loadedCIVClusters = true;
			};
            
			//Only spawn warning on version mismatch since map index changes were reduced
            //uncomment //_error = true; below for exit
			_error = false;
            if!(isNil "ALIVE_clusterBuild") then {
                private ["_clusterVersion","_clusterBuild","_clusterType","_version","_build","_message"];

                _clusterVersion = ALIVE_clusterBuild select 2;
                _clusterBuild = ALIVE_clusterBuild select 3;
                _clusterType = ALIVE_clusterBuild select 4;
                _version = productVersion select 2;
                _build = productVersion select 3;

                if!(_clusterType == 'Stable') then {
                    _message = "Warning ALiVE requires the STABLE game build";
                    [_message] call ALIVE_fnc_dump;
                    [_message] spawn BIS_fnc_guiMessage;
                    [[_message],"BIS_fnc_guiMessage",nil,true] spawn BIS_fnc_MP;
                    //_error = true;
                };

                if(!(_clusterVersion == _version) || !(_clusterBuild == _build)) then {
                    _message = format["Warning this version of ALiVE is only compatible with A3 version: %1.%2. The server is running version: %3.%4. Please contact your server administrator and update to the latest ALiVE release version.",_clusterVersion, _clusterBuild, _version, _build];
                    [_message] call ALIVE_fnc_dump;
                    [_message] spawn BIS_fnc_guiMessage;
                    [[_message],"BIS_fnc_guiMessage",nil,true] spawn BIS_fnc_MP;
                    //_error = true;
                };
            };

            if!(_error) then {
                _taor = [_logic, "taor"] call MAINCLASS;
                _blacklist = [_logic, "blacklist"] call MAINCLASS;
                _sizeFilter = parseNumber([_logic, "sizeFilter"] call MAINCLASS);
                _priorityFilter = parseNumber([_logic, "priorityFilter"] call MAINCLASS);

                // check markers for existance
                private ["_marker","_counter"];

                if(count _taor > 0) then {
                    _counter = 0;
                    {
                        _marker =_x;
                        if!(_marker call ALIVE_fnc_markerExists) then {
                            _taor = _taor - [_taor select _counter];
                        }else{
                            _counter = _counter + 1;
                        };
                    } forEach _taor;
                };

                if(count _blacklist > 0) then {
                    _counter = 0;
                    {
                        _marker =_x;
                        if!(_marker call ALIVE_fnc_markerExists) then {
                            _blacklist = _blacklist - [_blacklist select _counter];
                        }else{
                            _counter = _counter + 1;
                        };
                    } forEach _blacklist;
                };

                private ["_clusters"];

                _clusters = DEFAULT_OBJECTIVES;


                if(!(worldName == "Altis") && _sizeFilter == 160) then {
                    _sizeFilter = 0;
                };
                _clusters = ALIVE_clustersCiv select 2;
                _clusters = [_clusters,_sizeFilter,_priorityFilter] call ALIVE_fnc_copyClusters;
                _clusters = [_clusters, _taor] call ALIVE_fnc_clustersInsideMarker;
                _clusters = [_clusters, _blacklist] call ALIVE_fnc_clustersOutsideMarker;
                {
                    [_x, "debug", [_logic, "debug"] call MAINCLASS] call ALIVE_fnc_cluster;
                } forEach _clusters;
                [_logic, "objectives", _clusters] call MAINCLASS;


                if !(isnil "ALIVE_clustersCivSettlement") then {
                     _clusters = ALIVE_clustersCivSettlement select 2;
                     _clusters = [_clusters,_sizeFilter,_priorityFilter] call ALIVE_fnc_copyClusters;
                     _clusters = [_clusters, _taor] call ALIVE_fnc_clustersInsideMarker;
                     _clusters = [_clusters, _blacklist] call ALIVE_fnc_clustersOutsideMarker;
                     {
                          [_x, "debug", [_logic, "debug"] call MAINCLASS] call ALIVE_fnc_cluster;
                     } forEach _clusters;
                     [_logic, "objectivesSettlement", _clusters] call MAINCLASS;
                };


                if !(isnil "ALIVE_clustersCivHQ") then {
                    if(_sizeFilter == 160) then {
                        _sizeFilter = 0;
                    };
                    _clusters = ALIVE_clustersCivHQ select 2;
                    _clusters = [_clusters,_sizeFilter,_priorityFilter] call ALIVE_fnc_copyClusters;
                    _clusters = [_clusters, _taor] call ALIVE_fnc_clustersInsideMarker;
                    _clusters = [_clusters, _blacklist] call ALIVE_fnc_clustersOutsideMarker;
                    {
                        [_x, "debug", [_logic, "debug"] call MAINCLASS] call ALIVE_fnc_cluster;
                    } forEach _clusters;
                    [_logic, "objectivesHQ", _clusters] call MAINCLASS;
                };


                if !(isnil "ALIVE_clustersCivPower") then {
                    if(_sizeFilter == 160) then {
                        _sizeFilter = 0;
                    };
                    _clusters = ALIVE_clustersCivPower select 2;
                    _clusters = [_clusters,_sizeFilter,_priorityFilter] call ALIVE_fnc_copyClusters;
                    _clusters = [_clusters, _taor] call ALIVE_fnc_clustersInsideMarker;
                    _clusters = [_clusters, _blacklist] call ALIVE_fnc_clustersOutsideMarker;
                    {
                        [_x, "debug", [_logic, "debug"] call MAINCLASS] call ALIVE_fnc_cluster;
                    } forEach _clusters;
                    [_logic, "objectivesPower", _clusters] call MAINCLASS;
                };


                if !(isnil "ALIVE_clustersCivComms") then {
                    if(_sizeFilter == 160) then {
                        _sizeFilter = 0;
                    };
                    _clusters = ALIVE_clustersCivComms select 2;
                    _clusters = [_clusters,_sizeFilter,_priorityFilter] call ALIVE_fnc_copyClusters;
                    _clusters = [_clusters, _taor] call ALIVE_fnc_clustersInsideMarker;
                    _clusters = [_clusters, _blacklist] call ALIVE_fnc_clustersOutsideMarker;
                    {
                        [_x, "debug", [_logic, "debug"] call MAINCLASS] call ALIVE_fnc_cluster;
                    } forEach _clusters;
                    [_logic, "objectivesComms", _clusters] call MAINCLASS;
                };


                if !(isnil "ALIVE_clustersCivMarine") then {
                    if(_sizeFilter == 160) then {
                        _sizeFilter = 0;
                    };
                    _clusters = ALIVE_clustersCivMarine select 2;
                    _clusters = [_clusters,_sizeFilter,_priorityFilter] call ALIVE_fnc_copyClusters;
                    _clusters = [_clusters, _taor] call ALIVE_fnc_clustersInsideMarker;
                    _clusters = [_clusters, _blacklist] call ALIVE_fnc_clustersOutsideMarker;
                    {
                        [_x, "debug", [_logic, "debug"] call MAINCLASS] call ALIVE_fnc_cluster;
                    } forEach _clusters;
                    [_logic, "objectivesMarine", _clusters] call MAINCLASS;
                };


                if !(isnil "ALIVE_clustersCivRail") then {
                    if(_sizeFilter == 160) then {
                        _sizeFilter = 0;
                    };
                    _clusters = ALIVE_clustersCivRail select 2;
                    _clusters = [_clusters,_sizeFilter,_priorityFilter] call ALIVE_fnc_copyClusters;
                    _clusters = [_clusters, _taor] call ALIVE_fnc_clustersInsideMarker;
                    _clusters = [_clusters, _blacklist] call ALIVE_fnc_clustersOutsideMarker;
                    {
                        [_x, "debug", [_logic, "debug"] call MAINCLASS] call ALIVE_fnc_cluster;
                    } forEach _clusters;
                    [_logic, "objectivesRail", _clusters] call MAINCLASS;
                };


                if !(isnil "ALIVE_clustersCivFuel") then {
                    if(_sizeFilter == 160) then {
                        _sizeFilter = 0;
                    };
                    _clusters = ALIVE_clustersCivFuel select 2;
                    _clusters = [_clusters,_sizeFilter,_priorityFilter] call ALIVE_fnc_copyClusters;
                    _clusters = [_clusters, _taor] call ALIVE_fnc_clustersInsideMarker;
                    _clusters = [_clusters, _blacklist] call ALIVE_fnc_clustersOutsideMarker;
                    {
                        [_x, "debug", [_logic, "debug"] call MAINCLASS] call ALIVE_fnc_cluster;
                    } forEach _clusters;
                    [_logic, "objectivesFuel", _clusters] call MAINCLASS;
                };


                if !(isnil "ALIVE_clustersCivConstruction") then {
                    if(_sizeFilter == 160) then {
                        _sizeFilter = 0;
                    };
                    _clusters = ALIVE_clustersCivConstruction select 2;
                    _clusters = [_clusters,_sizeFilter,_priorityFilter] call ALIVE_fnc_copyClusters;
                    _clusters = [_clusters, _taor] call ALIVE_fnc_clustersInsideMarker;
                    _clusters = [_clusters, _blacklist] call ALIVE_fnc_clustersOutsideMarker;
                    {
                        [_x, "debug", [_logic, "debug"] call MAINCLASS] call ALIVE_fnc_cluster;
                    } forEach _clusters;
                    [_logic, "objectivesConstruction", _clusters] call MAINCLASS;
                };


                // DEBUG -------------------------------------------------------------------------------------
                if(_debug) then {
                    ["ALIVE AMBCP - Startup completed"] call ALIVE_fnc_dump;
                    ["ALIVE AMBCP - Count clusters %1",count _clusters] call ALIVE_fnc_dump;
                    [] call ALIVE_fnc_timer;
                };
                // DEBUG -------------------------------------------------------------------------------------


                _clusters = [_logic, "objectives"] call MAINCLASS;

                if(count _clusters > 0) then {
                    // start registration
                    [_logic, "registration"] call MAINCLASS;
                }else{
                    ["ALIVE AMBCP - Warning no locations found for placement, you need to include civilian locations within the TAOR marker"] call ALIVE_fnc_dumpR;

                    // set module as started
                    _logic setVariable ["startupComplete", true];
                };

            }else{
                // errors
                _logic setVariable ["startupComplete", true];
            };
        };
	};
	// Registration
    case "registration": {
        if (isServer) then {

            private ["_debug","_clusters","_cluster","_clustersSettlement","_clustersHQ","_clustersPower","_clustersComms","_clustersMarine","_clustersRail","_clustersFuel","_clustersConstruction"];

            _debug = [_logic, "debug"] call MAINCLASS;


            // DEBUG -------------------------------------------------------------------------------------
            if(_debug) then {
                ["----------------------------------------------------------------------------------------"] call ALIVE_fnc_dump;
                ["ALIVE AMBCP - Registration"] call ALIVE_fnc_dump;
                [true] call ALIVE_fnc_timer;
            };
            // DEBUG -------------------------------------------------------------------------------------


            _clusters = [_logic, "objectives"] call MAINCLASS;
            _clustersSettlement = [_logic, "objectivesSettlement", _clusters] call MAINCLASS;
            _clustersHQ = [_logic, "objectivesHQ", _clusters] call MAINCLASS;
            _clustersPower = [_logic, "objectivesPower", _clusters] call MAINCLASS;
            _clustersComms = [_logic, "objectivesComms", _clusters] call MAINCLASS;
            _clustersMarine = [_logic, "objectivesMarine", _clusters] call MAINCLASS;
            _clustersRail = [_logic, "objectivesRail", _clusters] call MAINCLASS;
            _clustersFuel = [_logic, "objectivesFuel", _clusters] call MAINCLASS;
            _clustersConstruction = [_logic, "objectivesConstruction", _clusters] call MAINCLASS;

            if(count _clustersSettlement > 0) then {
                {
                    [ALIVE_clusterHandler, "registerCluster", _x] call ALIVE_fnc_clusterHandler;
                } forEach _clustersSettlement;
            };

            // DEBUG -------------------------------------------------------------------------------------
            if(_debug) then {
                [ALIVE_clusterHandler, "debug", true] call ALIVE_fnc_clusterHandler;
            };

            // start placement
            [_logic, "placement"] call MAINCLASS;

        };
    };
	// Placement
	case "placement": {
        if (isServer) then {

			private ["_debug","_clusters","_cluster","_clustersSettlement","_clustersHQ","_clustersPower","_clustersComms","_clustersMarine",
			"_clustersRail","_clustersFuel","_clustersConstruction","_ambientVehicleAmount","_vehicleClass",
			"_faction","_factionConfig","_factionSideNumber","_side","_sideObject","_nodes","_node","_buildings"];

			_debug = [_logic, "debug"] call MAINCLASS;		
			
			// DEBUG -------------------------------------------------------------------------------------
			if(_debug) then {
				["----------------------------------------------------------------------------------------"] call ALIVE_fnc_dump;
				["ALIVE AMBCP - Placement"] call ALIVE_fnc_dump;
				[true] call ALIVE_fnc_timer;
			};
			// DEBUG -------------------------------------------------------------------------------------			
			
		
            //waituntil {sleep 5; (!(isnil {([_logic, "objectives"] call MAINCLASS)}) && {count ([_logic, "objectives"] call MAINCLASS) > 0})};
			
			_clusters = [_logic, "objectives"] call MAINCLASS;
			_clustersSettlement = [_logic, "objectivesSettlement", _clusters] call MAINCLASS;
			_clustersHQ = [_logic, "objectivesHQ", _clusters] call MAINCLASS;
			_clustersPower = [_logic, "objectivesPower", _clusters] call MAINCLASS;
			_clustersComms = [_logic, "objectivesComms", _clusters] call MAINCLASS;
			_clustersMarine = [_logic, "objectivesMarine", _clusters] call MAINCLASS;
			_clustersRail = [_logic, "objectivesRail", _clusters] call MAINCLASS;
			_clustersFuel = [_logic, "objectivesFuel", _clusters] call MAINCLASS;
			_clustersConstruction = [_logic, "objectivesConstruction", _clusters] call MAINCLASS;
			
			_faction = [_logic, "faction"] call MAINCLASS;
			_ambientVehicleAmount = parseNumber([_logic, "ambientVehicleAmount"] call MAINCLASS);
			
			_factionConfig = (configFile >> "CfgFactionClasses" >> _faction);
			_factionSideNumber = getNumber(_factionConfig >> "side");
			_side = _factionSideNumber call ALIVE_fnc_sideNumberToText;
			_sideObject = [_side] call ALIVE_fnc_sideTextToObject;

			
			// DEBUG -------------------------------------------------------------------------------------
			if(_debug) then {
				["ALIVE AMBCP [%1] SideNum: %2 Side: %3 Faction: %4",_faction,_factionSideNumber,_side,_faction] call ALIVE_fnc_dump;
			};
			// DEBUG -------------------------------------------------------------------------------------			
			
			
			// Load static data
			
			if(isNil "ALIVE_unitBlackist") then {
				_file = "\x\alive\addons\main\static\staticData.sqf";
				call compile preprocessFileLineNumbers _file;
			};

			// Spawn ambient vehicles

            private ["_countLandUnits","_carClasses","_landClasses","_supportCount","_supportMax","_supportClasses","_types",
            "_countBuildings","_parkingChance","_usedPositions","_building","_parkingPosition","_positionOK","_supportPlacement"];

            _countLandUnits = 0;

            //["AMB VEH AMOUNT: %1", _ambientVehicleAmount] call ALIVE_fnc_dump;

            //["CIV BUILDING TYPES: %1", ALIVE_civilianParkingBuildingTypes] call ALIVE_fnc_dump;

            /*

            if(_ambientVehicleAmount > 0) then {

                _carClasses = [0,_faction,"Car"] call ALiVE_fnc_findVehicleType;
                _landClasses = _carClasses - ALIVE_vehicleBlacklist;

                _supportClasses = [ALIVE_factionDefaultSupports,_faction,[]] call ALIVE_fnc_hashGet;

                //["SUPPORT CLASSES: %1",_supportClasses] call ALIVE_fnc_dump;

                // if no supports found for the faction use side supplies
                if(count _supportClasses == 0) then {
                    _supportClasses = [ALIVE_sideDefaultSupports,_side] call ALIVE_fnc_hashGet;
                };

                if(count _landClasses == 0) then {
                    _landClasses = _landClasses + _supportClasses;
                }else{
                    _landClasses = _landClasses - _supportClasses;
                };

                //["LAND CLASSES: %1",_landClasses] call ALIVE_fnc_dump;

                if(count _landClasses > 0) then {

                    {

                        _supportCount = 0;
                        _supportMax = 0;

                        _nodes = [_x, "nodes"] call ALIVE_fnc_hashGet;

                        //["NODES: %1",_nodes] call ALIVE_fnc_dump;

                        _buildings = [_nodes, ALIVE_civilianParkingBuildingTypes] call ALIVE_fnc_findBuildingsInClusterNodes;

                        //["BUILDINGS: %1",_buildings] call ALIVE_fnc_dump;

                        _countBuildings = count _buildings;
                        _parkingChance = 0.1 * _ambientVehicleAmount;

                        //["COUNT BUILDINGS: %1",_countBuildings] call ALIVE_fnc_dump;
                        //["CHANCE: %1",_parkingChance] call ALIVE_fnc_dump;

                        if(_countBuildings > 50) then {
                            _supportMax = 3;
                            _parkingChance = 0.1 * _ambientVehicleAmount;
                        };

                        if(_countBuildings > 40 && _countBuildings < 50) then {
                            _supportMax = 2;
                            _parkingChance = 0.2 * _ambientVehicleAmount;
                        };

                        if(_countBuildings > 30 && _countBuildings < 41) then {
                            _supportMax = 2;
                            _parkingChance = 0.3 * _ambientVehicleAmount;
                        };

                        if(_countBuildings > 20 && _countBuildings < 31) then {
                            _supportMax = 1;
                            _parkingChance = 0.4 * _ambientVehicleAmount;
                        };

                        if(_countBuildings > 10 && _countBuildings < 21) then {
                            _supportMax = 1;
                            _parkingChance = 0.5 * _ambientVehicleAmount;
                        };

                        if(_countBuildings > 0 && _countBuildings < 11) then {
                            _supportMax = 0;
                            _parkingChance = 0.6 * _ambientVehicleAmount;
                        };

                        //["SUPPORT MAX: %1",_supportMax] call ALIVE_fnc_dump;
                        //["CHANCE: %1",_parkingChance] call ALIVE_fnc_dump;

                        _usedPositions = [];

                        {
                            if(random 1 < _parkingChance) then {

                                _building = _x;


                                ["SUPPORT CLASSES: %1",_supportClasses] call ALIVE_fnc_dump;
                                ["LAND CLASSES: %1",_landClasses] call ALIVE_fnc_dump;

                                _supportPlacement = false;
                                if(_supportCount < _supportMax) then {
                                    _supportPlacement = true;
                                    _vehicleClass = _supportClasses call BIS_fnc_selectRandom;
                                }else{
                                    _vehicleClass = _landClasses call BIS_fnc_selectRandom;
                                };

                                ["SUPPORT PLACEMENT: %1",_supportPlacement] call ALIVE_fnc_dump;
                                ["VEHICLE CLASS: %1",_vehicleClass] call ALIVE_fnc_dump;

                                _parkingPosition = [_vehicleClass,_building,true] call ALIVE_fnc_getParkingPosition;
                                _positionOK = true;

                                {
                                    _position = _x select 0;
                                    if((_parkingPosition select 0) distance _position < 10) then {
                                        _positionOK = false;
                                    };
                                } forEach _usedPositions;

                                //["POS OK: %1",_positionOK] call ALIVE_fnc_dump;

                                if(_positionOK) then {
                                    [_vehicleClass,_side,_faction,_parkingPosition select 0,_parkingPosition select 1,false,_faction] call ALIVE_fnc_createProfileVehicle;

                                    _countLandUnits = _countLandUnits + 1;

                                    _usedPositions set [count _usedPositions, _parkingPosition];

                                    if(_supportPlacement) then {
                                        _supportCount = _supportCount + 1;
                                    };
                                };
                            };

                        } forEach _buildings;

                    } forEach _clusters;
                };
            };

            */

            private ["_spawnChance","_civClasses","_clusterID","_nodes","_buildings","_countBuildings","_building","_unitClass","_agentID","_buildingPosition","_agent","_clusterGroup"];

            _civClasses = [0,_faction,"Man"] call ALiVE_fnc_findVehicleType;

            //["CIV Classes: %1",_civClasses] call ALIVE_fnc_dump;

            if(count _civClasses > 0) then {

                {
                    _clusterID = [_x, "clusterID"] call ALIVE_fnc_hashGet;
                    _nodes = [_x, "nodes"] call ALIVE_fnc_hashGet;

                    //["NODES: %1",_nodes] call ALIVE_fnc_dump;

                    _buildings = [_nodes, ALIVE_civilianParkingBuildingTypes] call ALIVE_fnc_findBuildingsInClusterNodes;

                    //["BUILDINGS: %1",_buildings] call ALIVE_fnc_dump;

                    _countBuildings = count _buildings;

                    _spawnChance = 0.1;

                    if(_countBuildings > 50) then {
                        _spawnChance = 0.1;
                    };

                    if(_countBuildings > 40 && _countBuildings < 50) then {
                        _spawnChance = 0.2;
                    };

                    if(_countBuildings > 30 && _countBuildings < 41) then {
                        _spawnChance = 0.3;
                    };

                    if(_countBuildings > 20 && _countBuildings < 31) then {
                        _spawnChance = 0.5;
                    };

                    if(_countBuildings > 10 && _countBuildings < 21) then {
                        _spawnChance = 0.7;
                    };

                    if(_countBuildings > 0 && _countBuildings < 11) then {
                        _spawnChance = 0.8;
                    };

                    {

                        if(random 1 < _spawnChance) then {

                            _building = _x;

                            _unitClass = _civClasses call BIS_fnc_selectRandom;
                            _agentID = format["agent_%1",[ALIVE_agentHandler, "getNextInsertID"] call ALIVE_fnc_agentHandler];

                            _buildingPosition = getPos _building;

                            _agent = [nil, "create"] call ALIVE_fnc_civilianAgent;
                            [_agent, "init"] call ALIVE_fnc_civilianAgent;
                            [_agent, "agentID", _agentID] call ALIVE_fnc_civilianAgent;
                            [_agent, "agentClass", _unitClass] call ALIVE_fnc_civilianAgent;
                            [_agent, "position", _buildingPosition] call ALIVE_fnc_civilianAgent;
                            [_agent, "side", _side] call ALIVE_fnc_civilianAgent;
                            [_agent, "faction", _faction] call ALIVE_fnc_civilianAgent;
                            [_agent, "homeCluster", _clusterID] call ALIVE_fnc_civilianAgent;
                            [_agent, "homePosition", _buildingPosition] call ALIVE_fnc_civilianAgent;

                            [_agent] call ALIVE_fnc_selectCivilianCommand;

                            [ALIVE_agentHandler, "registerAgent", _agent] call ALIVE_fnc_agentHandler;
                        };

                    } forEach _buildings;

                } forEach _clustersSettlement;
            };


            //[ALIVE_agentHandler, "debug", true] call ALIVE_fnc_agentHandler;


            // DEBUG -------------------------------------------------------------------------------------
            if(_debug) then {
                ["ALIVE AMBCP [%1] - Ambient land units placed: %2",_faction,_countLandUnits] call ALIVE_fnc_dump;
            };
            // DEBUG -------------------------------------------------------------------------------------

			// DEBUG -------------------------------------------------------------------------------------
			if(_debug) then {
				["ALIVE AMBCP - Placement completed"] call ALIVE_fnc_dump;
				[] call ALIVE_fnc_timer;
				["----------------------------------------------------------------------------------------"] call ALIVE_fnc_dump;
			};
			// DEBUG -------------------------------------------------------------------------------------

			// set module as started
            _logic setVariable ["startupComplete", true];
			
		};
	};
};

TRACE_1("AMBCP - output",_result);
_result;