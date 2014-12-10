//#define DEBUG_MODE_FULL
#include <\x\alive\addons\civ_placement\script_component.hpp>
SCRIPT(CP);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_CP
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
#define MAINCLASS ALIVE_fnc_CP
#define MTEMPLATE "ALiVE_CP_%1"
#define DEFAULT_SIZE "100"
#define DEFAULT_WITH_PLACEMENT true
#define DEFAULT_OBJECTIVES []
#define DEFAULT_TAOR []
#define DEFAULT_BLACKLIST []
#define DEFAULT_SIZE_FILTER "160"
#define DEFAULT_PRIORITY_FILTER "0"
#define DEFAULT_TYPE QUOTE(RANDOM)
#define DEFAULT_WITH_PLACEMENT true
#define DEFAULT_FACTION QUOTE(OPF_F)
#define DEFAULT_CLUSTER_TYPE QUOTE(All)
#define DEFAULT_NO_TEXT ""
#define DEFAULT_READINESS_LEVEL "1"
#define DEFAULT_RB "10"

private ["_logic","_operation","_args","_result"];

TRACE_1("CP - input",_this);

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
			ASSERT_TRUE([_args] call ALIVE_fnc_isHash,str _args);

			// Restore state
			{
				[_logic, _x, [_args, _x] call ALIVE_fnc_hashGet] call MAINCLASS;
			} forEach _simple_operations;
		};
	};
	// Determine size of enemy force - valid values are: BN, CY and PL
	case "size": {
		_result = [_logic,_operation,_args,DEFAULT_SIZE] call ALIVE_fnc_OOsimpleOperation;
	};
	// Determine type of enemy force - valid values are: "Random","Armored","Mechanized","Motorized","Infantry","Air
	case "type": {
		_result = [_logic,_operation,_args,DEFAULT_TYPE,["Random","Armored","Mechanized","Motorized","Infantry","Air"]] call ALIVE_fnc_OOsimpleOperation;
		if(_result == "Random") then {
			// Randomly pick an type
			_result = ["Armored","Mechanized","Motorized","Infantry","Air"] call BIS_fnc_selectRandom;
			_logic setVariable ["type", _result];
		};
	};
	case "customInfantryCount": {
        _result = [_logic,_operation,_args,DEFAULT_NO_TEXT] call ALIVE_fnc_OOsimpleOperation;
    };
    case "customMotorisedCount": {
        _result = [_logic,_operation,_args,DEFAULT_NO_TEXT] call ALIVE_fnc_OOsimpleOperation;
    };
    case "customMechanisedCount": {
        _result = [_logic,_operation,_args,DEFAULT_NO_TEXT] call ALIVE_fnc_OOsimpleOperation;
    };
    case "customArmourCount": {
        _result = [_logic,_operation,_args,DEFAULT_NO_TEXT] call ALIVE_fnc_OOsimpleOperation;
    };
    case "customSpecOpsCount": {
        _result = [_logic,_operation,_args,DEFAULT_NO_TEXT] call ALIVE_fnc_OOsimpleOperation;
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
	// Determine type of clusters to use
    case "clusterType": {
        _result = [_logic,_operation,_args,DEFAULT_CLUSTER_TYPE,["All","HQ","Power","Comms","Fuel","Marine","Construction","Settlement"]] call ALIVE_fnc_OOsimpleOperation;
    };
	// Return the Size filter
	case "sizeFilter": {
		_result = [_logic,_operation,_args,DEFAULT_SIZE_FILTER] call ALIVE_fnc_OOsimpleOperation;
	};
	// Return the Priority filter
	case "priorityFilter": {
		_result = [_logic,_operation,_args,DEFAULT_PRIORITY_FILTER] call ALIVE_fnc_OOsimpleOperation;
	};
    // Return the Readiness Level
	case "readinessLevel": {
		_result = [_logic,_operation,_args,DEFAULT_READINESS_LEVEL] call ALIVE_fnc_OOsimpleOperation;
	};

    // Return placement setting
    case "withPlacement": {
        if (isnil "_args" || {isnull _args}) then {
            _args = _logic getvariable ["withPlacement",DEFAULT_WITH_PLACEMENT];
        };

        if (isnil "_args") exitwith {_result = DEFAULT_WITH_PLACEMENT};

        if (typename _args == "STRING") then {_args = call compile _args};
        if (typename _args == "BOOL") then {_args = _args};

        _result = [_logic,_operation,_args,DEFAULT_WITH_PLACEMENT] call ALIVE_fnc_OOsimpleOperation;
	};

	// Return the objectives as an array of clusters
	case "objectives": {
		_result = [_logic,_operation,_args,DEFAULT_OBJECTIVES] call ALIVE_fnc_OOsimpleOperation;
	};
	// Return the HQ objectives as an array of clusters
	case "objectivesHQ": {
		_result = [_logic,_operation,_args,DEFAULT_OBJECTIVES_HQ] call ALIVE_fnc_OOsimpleOperation;
	};
	// Return the Power objectives as an array of clusters
	case "objectivesPower": {
		_result = [_logic,_operation,_args,DEFAULT_OBJECTIVES_POWER] call ALIVE_fnc_OOsimpleOperation;
	};
	// Return the Comms objectives as an array of clusters
	case "objectivesComms": {
		_result = [_logic,_operation,_args,DEFAULT_OBJECTIVES_COMMS] call ALIVE_fnc_OOsimpleOperation;
	};
	// Return the MARINE objectives as an array of clusters
	case "objectivesMarine": {
		_result = [_logic,_operation,_args,DEFAULT_OBJECTIVES_MARINE] call ALIVE_fnc_OOsimpleOperation;
	};
	// Return the RAIL objectives as an array of clusters
	case "objectivesRail": {
		_result = [_logic,_operation,_args,DEFAULT_OBJECTIVES_RAIL] call ALIVE_fnc_OOsimpleOperation;
	};
	// Return the FUEL objectives as an array of clusters
	case "objectivesFuel": {
		_result = [_logic,_operation,_args,DEFAULT_OBJECTIVES_FUEL] call ALIVE_fnc_OOsimpleOperation;
	};
	// Return the CONSTRUCTION objectives as an array of clusters
	case "objectivesConstruction": {
		_result = [_logic,_operation,_args,DEFAULT_OBJECTIVES_CONSTRUCTION] call ALIVE_fnc_OOsimpleOperation;
	};
	// Return the SETTLEMENT objectives as an array of clusters
	case "objectivesSettlement": {
		_result = [_logic,_operation,_args,DEFAULT_OBJECTIVES_SETTLEMENT] call ALIVE_fnc_OOsimpleOperation;
	};
    case "roadBlocks": {
		_result = [_logic,_operation,_args,DEFAULT_RB] call ALIVE_fnc_OOsimpleOperation;
	};
	// Main process
	case "init": {
        if (isServer) then {

			// if server, initialise module game logic
			_logic setVariable ["super", SUPERCLASS];
			_logic setVariable ["class", MAINCLASS];
			_logic setVariable ["moduleType", "ALIVE_CP"];
			_logic setVariable ["startupComplete", false];
			TRACE_1("After module init",_logic);

			[_logic, "taor", _logic getVariable ["taor", DEFAULT_TAOR]] call MAINCLASS;
			[_logic, "blacklist", _logic getVariable ["blacklist", DEFAULT_TAOR]] call MAINCLASS;

            if !(["ALiVE_sys_profile"] call ALiVE_fnc_isModuleAvailable) exitwith {
                ["Profile System module not placed! Exiting..."] call ALiVE_fnc_DumpR;
                _logic setVariable ["startupComplete", true];
            };

            waituntil {!(isnil "ALiVE_ProfileHandler") && {[ALiVE_ProfileSystem,"startupComplete",false] call ALIVE_fnc_hashGet}};

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

			private ["_debug","_clusterType","_placement","_worldName","_file","_clusters","_cluster","_taor","_taorClusters","_blacklist",
			"_sizeFilter","_priorityFilter","_blacklistClusters","_center","_faction","_error"];

			_debug = [_logic, "debug"] call MAINCLASS;
			_faction = [_logic, "faction"] call MAINCLASS;

			if(_debug) then {
				["----------------------------------------------------------------------------------------"] call ALIVE_fnc_dump;
				["ALIVE CP - Startup"] call ALIVE_fnc_dump;
				[true] call ALIVE_fnc_timer;
			};


            if(isNil "ALIVE_clustersCiv" && isNil "ALIVE_loadedCivClusters") then {
                _worldName = toLower(worldName);
                _file = format["\x\alive\addons\civ_placement\clusters\clusters.%1_civ.sqf", _worldName];
                call compile preprocessFileLineNumbers _file;
                ALIVE_loadedCIVClusters = true;
            };
			waituntil {!(isnil "ALIVE_loadedCIVClusters") && {ALIVE_loadedCIVClusters}};
			waituntil {!(isnil "ALIVE_profileSystemInit")};

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
                    //_error = true;
                };

                if(!(_clusterVersion == _version) || !(_clusterBuild == _build)) then {
                    _message = format["Warning: This version of ALiVE is build for A3 version: %1.%2. The server is running version: %3.%4. Please contact your server administrator and update to the latest ALiVE release version.",_clusterVersion, _clusterBuild, _version, _build];
                    [_message] call ALIVE_fnc_dump;
                    //_error = true;
                };

                /*
                if (!(isnil "_message") && {isnil QGVAR(CLUSTERWARNING_DISPLAYED)}) then {
                    GVAR(CLUSTERWARNING_DISPLAYED) = true;
                    //[_message] spawn BIS_fnc_guiMessage;
                    [[_message],"BIS_fnc_guiMessage",nil,true] spawn BIS_fnc_MP;
                };
                */
            };

            if!(_error) then {
                _clusterType = [_logic, "clusterType"] call MAINCLASS;
                _placement = [_logic, "withPlacement"] call MAINCLASS;
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

                switch(_clusterType) do {
                    case "All": {
                        _clusters = ALIVE_clustersCiv select 2;
                        _clusters = [_clusters,_sizeFilter,_priorityFilter] call ALIVE_fnc_copyClusters;
                        _clusters = [_clusters, _taor] call ALIVE_fnc_clustersInsideMarker;
                        _clusters = [_clusters, _blacklist] call ALIVE_fnc_clustersOutsideMarker;
                        {
                            [_x, "debug", [_logic, "debug"] call MAINCLASS] call ALIVE_fnc_cluster;
                        } forEach _clusters;
                        [_logic, "objectives", _clusters] call MAINCLASS;
                    };
                    case "HQ": {
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
                            [_logic, "objectives", _clusters] call MAINCLASS;
                        };
                    };
                    case "Power": {
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
                            [_logic, "objectives", _clusters] call MAINCLASS;
                        };
                    };
                    case "Comms": {
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
                            [_logic, "objectives", _clusters] call MAINCLASS;
                        };
                    };
                    case "Marine": {
                        ["SF: %1, %2", _sizeFilter, typeName _sizeFilter] call ALIVE_fnc_dump;
                        if(_sizeFilter == 160) then {
                            _sizeFilter = 0;
                        };
                        if !(isnil "ALIVE_clustersCivMarine") then {
                            _clusters = ALIVE_clustersCivMarine select 2;
                            _clusters = [_clusters,_sizeFilter,_priorityFilter] call ALIVE_fnc_copyClusters;
                            _clusters = [_clusters, _taor] call ALIVE_fnc_clustersInsideMarker;
                            _clusters = [_clusters, _blacklist] call ALIVE_fnc_clustersOutsideMarker;
                            {
                                [_x, "debug", [_logic, "debug"] call MAINCLASS] call ALIVE_fnc_cluster;
                            } forEach _clusters;
                            [_logic, "objectives", _clusters] call MAINCLASS;
                        };
                    };
                    case "Rail": {
                        if(_sizeFilter == 160) then {
                            _sizeFilter = 0;
                        };
                        if !(isnil "ALIVE_clustersCivRail") then {
                            _clusters = ALIVE_clustersCivRail select 2;
                            _clusters = [_clusters,_sizeFilter,_priorityFilter] call ALIVE_fnc_copyClusters;
                            _clusters = [_clusters, _taor] call ALIVE_fnc_clustersInsideMarker;
                            _clusters = [_clusters, _blacklist] call ALIVE_fnc_clustersOutsideMarker;
                            {
                                [_x, "debug", [_logic, "debug"] call MAINCLASS] call ALIVE_fnc_cluster;
                            } forEach _clusters;
                            [_logic, "objectives", _clusters] call MAINCLASS;
                        };
                    };
                    case "Fuel": {
                        if(_sizeFilter == 160) then {
                            _sizeFilter = 0;
                        };
                        if !(isnil "ALIVE_clustersCivFuel") then {
                            _clusters = ALIVE_clustersCivFuel select 2;
                            _clusters = [_clusters,_sizeFilter,_priorityFilter] call ALIVE_fnc_copyClusters;
                            _clusters = [_clusters, _taor] call ALIVE_fnc_clustersInsideMarker;
                            _clusters = [_clusters, _blacklist] call ALIVE_fnc_clustersOutsideMarker;
                            {
                                [_x, "debug", [_logic, "debug"] call MAINCLASS] call ALIVE_fnc_cluster;
                            } forEach _clusters;
                            [_logic, "objectives", _clusters] call MAINCLASS;
                        };
                    };
                    case "Construction": {
                        if(_sizeFilter == 160) then {
                            _sizeFilter = 0;
                        };
                        if !(isnil "ALIVE_clustersCivConstruction") then {
                            _clusters = ALIVE_clustersCivConstruction select 2;
                            _clusters = [_clusters,_sizeFilter,_priorityFilter] call ALIVE_fnc_copyClusters;
                            _clusters = [_clusters, _taor] call ALIVE_fnc_clustersInsideMarker;
                            _clusters = [_clusters, _blacklist] call ALIVE_fnc_clustersOutsideMarker;
                            {
                                [_x, "debug", [_logic, "debug"] call MAINCLASS] call ALIVE_fnc_cluster;
                            } forEach _clusters;
                            [_logic, "objectives", _clusters] call MAINCLASS;
                        };
                    };
                    case "Settlement": {
                        if !(isnil "ALIVE_clustersCivSettlement") then {
                             _clusters = ALIVE_clustersCivSettlement select 2;
                             _clusters = [_clusters,_sizeFilter,_priorityFilter] call ALIVE_fnc_copyClusters;
                             _clusters = [_clusters, _taor] call ALIVE_fnc_clustersInsideMarker;
                             _clusters = [_clusters, _blacklist] call ALIVE_fnc_clustersOutsideMarker;
                             {
                                  [_x, "debug", [_logic, "debug"] call MAINCLASS] call ALIVE_fnc_cluster;
                             } forEach _clusters;
                             [_logic, "objectives", _clusters] call MAINCLASS;
                          };
                    };
                };

                // DEBUG -------------------------------------------------------------------------------------
                if(_debug) then {
                    ["ALIVE CP - Startup completed"] call ALIVE_fnc_dump;
                    ["ALIVE CP - Count clusters %1",count _clusters] call ALIVE_fnc_dump;
                    [] call ALIVE_fnc_timer;
                };
                // DEBUG -------------------------------------------------------------------------------------

                if(_placement) then {

                    if!(ALIVE_loadProfilesPersistent) then {

                        if(count _clusters > 0) then {
                            // start placement
                            [_logic, "placement"] call MAINCLASS;
                        }else{
                            ["ALIVE CP [%1] - Warning no locations found for placement, you need to inclcude civilian locations within the TAOR marker",_faction] call ALIVE_fnc_dumpR;

                            // set module as started
                            _logic setVariable ["startupComplete", true];
                        };

                    }else{

                        // DEBUG -------------------------------------------------------------------------------------
                        if(_debug) then { ["ALIVE CP - Profiles are persistent, no creation of profiles"] call ALIVE_fnc_dump; };
                        // DEBUG -------------------------------------------------------------------------------------

                        // set module as started
                        _logic setVariable ["startupComplete", true];

                    };
                }else{

                    // DEBUG -------------------------------------------------------------------------------------
                    if(_debug) then { ["ALIVE CP - Objectives Only"] call ALIVE_fnc_dump; };
                    // DEBUG -------------------------------------------------------------------------------------

                    // set module as started
                    _logic setVariable ["startupComplete", true];

                };
            }else{
                // errors
                _logic setVariable ["startupComplete", true];
            };
        };
	};
	// Placement
	case "placement": {
        if (isServer) then {

			private ["_debug","_clusters","_cluster","_size","_type",
			"_faction","_ambientVehicleAmount","_placeHelis","_factionConfig","_factionSideNumber","_side","_countProfiles","_vehicleClass",
			"_position","_direction","_unitBlackist","_vehicleBlacklist","_groupBlacklist","_heliClasses","_nodes","_airClasses","_node",
			"_customInfantryCount","_customMotorisedCount","_customMechanisedCount","_customArmourCount","_customSpecOpsCount","_file"];


			_debug = [_logic, "debug"] call MAINCLASS;

			// DEBUG -------------------------------------------------------------------------------------
			if(_debug) then {
				["----------------------------------------------------------------------------------------"] call ALIVE_fnc_dump;
				["ALIVE CP - Placement"] call ALIVE_fnc_dump;
				[true] call ALIVE_fnc_timer;
			};
			// DEBUG -------------------------------------------------------------------------------------


            //waituntil {sleep 5; (!(isnil {([_logic, "objectives"] call MAINCLASS)}) && {count ([_logic, "objectives"] call MAINCLASS) > 0})};

			_clusters = [_logic, "objectives"] call MAINCLASS;

			_customInfantryCount = [_logic, "customInfantryCount"] call MAINCLASS;

            if(_customInfantryCount == "") then {
                _customInfantryCount = 666;
            }else{
                _customInfantryCount = parseNumber _customInfantryCount;
            };

            _customMotorisedCount = [_logic, "customMotorisedCount"] call MAINCLASS;

            if(_customMotorisedCount == "") then {
                _customMotorisedCount = 666;
            }else{
                _customMotorisedCount = parseNumber _customMotorisedCount;
            };

            _customMechanisedCount = [_logic, "customMechanisedCount"] call MAINCLASS;

            if(_customMechanisedCount == "") then {
                _customMechanisedCount = 666;
            }else{
                _customMechanisedCount = parseNumber _customMechanisedCount;
            };

            _customArmourCount = [_logic, "customArmourCount"] call MAINCLASS;

            if(_customArmourCount == "") then {
                _customArmourCount = 666;
            }else{
                _customArmourCount = parseNumber _customArmourCount;
            };

            _customSpecOpsCount = [_logic, "customSpecOpsCount"] call MAINCLASS;

            if(_customSpecOpsCount == "") then {
                _customSpecOpsCount = 666;
            }else{
                _customSpecOpsCount = parseNumber _customSpecOpsCount;
            };

			_type = [_logic, "type"] call MAINCLASS;
			_faction = [_logic, "faction"] call MAINCLASS;
            _size = parseNumber([_logic, "size"] call MAINCLASS);
            _roadBlocks = parsenumber([_logic, "roadBlocks"] call MAINCLASS);

			_factionConfig = (configFile >> "CfgFactionClasses" >> _faction);
			_factionSideNumber = getNumber(_factionConfig >> "side");
			_side = _factionSideNumber call ALIVE_fnc_sideNumberToText;
			_countProfiles = 0;


			// DEBUG -------------------------------------------------------------------------------------
			if(_debug) then {
				["ALIVE CP [%1] - Size: %2 Type: %3 SideNum: %4 Side: %5 Faction: %6",_faction,_size,_type,_factionSideNumber,_side,_faction] call ALIVE_fnc_dump;
			};
			// DEBUG -------------------------------------------------------------------------------------


			// Load static data

			if(isNil "ALiVE_STATIC_DATA_LOADED") then {
				_file = "\x\alive\addons\main\static\staticData.sqf";
				call compile preprocessFileLineNumbers _file;
			};

			// Spawn the main force

			private ["_countArmored","_countMechanized","_countMotorized","_countInfantry",
			"_countAir","_countSpecOps","_groups","_motorizedGroups","_infantryGroups","_group","_groupPerCluster","_totalCount","_center","_size","_position",
			"_groupCount","_clusterCount"];

			// DEBUG -------------------------------------------------------------------------------------
			if(_debug) then {
				["ALIVE CP [%1] - Size: %2",_faction,_size] call ALIVE_fnc_dump;
			};
			// DEBUG -------------------------------------------------------------------------------------


			_countArmored = 0;
			_countMechanized = 0;
			_countMotorized = 0;
			_countInfantry = 0;
			_countAir = 0;
			_countSpecOps = 0;

			// Force Composition
			switch(_type) do {
                case "Armored": {
                    _countArmored = floor((_size / 20) * 0.5);
                    _countMechanized = floor((_size / 12) * random(0.2));
                    _countMotorized = floor((_size / 12) * random(0.2));
                    _countInfantry = floor((_size / 10) * 0.5);
                    _countAir = floor((_size / 30) * random(0.1));
                    _countSpecOps = floor((_size / 25) * 0.5);
                };
                case "Mechanized": {
                    _countMechanized = floor((_size / 12) * 0.5);
                    _countArmored = floor((_size / 20) * random(0.2));
                    _countMotorized = floor((_size / 12) * random(0.2));
                    _countInfantry = floor((_size / 10) * 0.5);
                    _countAir = floor((_size / 30) * random(0.1));
                    _countSpecOps = floor((_size / 25) * 0.5);
                };
                case "Motorized": {
                    _countMotorized = floor((_size / 12) * 0.5);
                    _countMechanized = floor((_size / 12) * random(0.2));
                    _countArmored = floor((_size / 20) * random(0.2));
                    _countInfantry = floor((_size / 10) * 0.5);
                    _countAir = floor((_size / 30) * random(0.1));
                    _countSpecOps = floor((_size / 25) * 0.5);
                };
                case "Infantry": {
                    _countInfantry = floor((_size / 10) * 0.8);
                    _countMotorized = floor((_size / 12) * random(0.2));
                    _countMechanized = floor((_size / 12) * random(0.2));
                    _countArmored = floor((_size / 20) * random(0.2));
                    _countAir = floor((_size / 30) * random(0.1));
                    _countSpecOps = floor((_size / 25) * 0.5);
                };
                case "Air": {
                    _countAir = floor((_size / 30) * 0.5);
                    _countInfantry = floor((_size / 10) * 0.5);
                    _countMotorized = floor((_size / 12) * random(0.2));
                    _countMechanized = floor((_size / 12) * random(0.2));
                    _countArmored = floor((_size / 20) * random(0.2));
                    _countSpecOps = floor((_size / 25) * 0.5);
                };
                case "Specops": {
                    _countAir = floor((_size / 30) * 0.5);
                    _countInfantry = floor((_size / 10) * 0.5);
                    _countMotorized = floor((_size / 12) * random(0.2));
                    _countMechanized = floor((_size / 12) * random(0.2));
                    _countArmored = floor((_size / 20) * random(0.2));
                    _countSpecOps = floor((_size / 10) * 0.5);
                };
            };

            if!(_customInfantryCount == 666) then {
                _countInfantry = _customInfantryCount;
            };

            if!(_customMotorisedCount == 666) then {
                _countMotorized = _customMotorisedCount;
            };

            if!(_customMechanisedCount == 666) then {
                _countMechanized = _customMechanisedCount;
            };

            if!(_customArmourCount == 666) then {
                _countArmored = _customArmourCount;
            };

            if!(_customSpecOpsCount == 666) then {
                _countSpecOps = _customSpecOpsCount;
            };


			// DEBUG -------------------------------------------------------------------------------------
			if(_debug) then {
				["ALIVE CP [%1] - Main force creation ",_faction] call ALIVE_fnc_dump;
				["Count Armor: %1",_countArmored] call ALIVE_fnc_dump;
				["Count Mech: %1",_countMechanized] call ALIVE_fnc_dump;
				["Count Motor: %1",_countMotorized] call ALIVE_fnc_dump;
				["Count Air: %1",_countAir] call ALIVE_fnc_dump;
				["Count Infantry: %1",_countInfantry] call ALIVE_fnc_dump;
				["Count Spec Ops: %1",_countSpecOps] call ALIVE_fnc_dump;
			};
			// DEBUG -------------------------------------------------------------------------------------


			// Assign groups
			_groups = [];

			for "_i" from 0 to _countArmored -1 do {
				_group = ["Armored",_faction] call ALIVE_fnc_configGetRandomGroup;
				if!(_group == "FALSE") then {
					_groups set [count _groups, _group];
				};
			};

			for "_i" from 0 to _countMechanized -1 do {
				_group = ["Mechanized",_faction] call ALIVE_fnc_configGetRandomGroup;
				if!(_group == "FALSE") then {
					_groups set [count _groups, _group];
				}
			};

			if(_countMotorized > 0) then {

                _motorizedGroups = [];

                for "_i" from 0 to _countMotorized -1 do {
                    _group = ["Motorized",_faction] call ALIVE_fnc_configGetRandomGroup;
                    if!(_group == "FALSE") then {
                        _motorizedGroups set [count _motorizedGroups, _group];
                    };
                };

                if(count _motorizedGroups == 0) then {
                    for "_i" from 0 to _countMotorized -1 do {
                        _group = ["Motorized_MTP",_faction] call ALIVE_fnc_configGetRandomGroup;
                        if!(_group == "FALSE") then {
                            _motorizedGroups set [count _motorizedGroups, _group];
                        };
                    };
                };

                _groups = _groups + _motorizedGroups;
            };

			_infantryGroups = [];
            for "_i" from 0 to _countInfantry -1 do {
                _group = ["Infantry",_faction] call ALIVE_fnc_configGetRandomGroup;
                if!(_group == "FALSE") then {
                    _infantryGroups set [count _infantryGroups, _group];
                }
            };

            _groups = _groups + _infantryGroups;

			for "_i" from 0 to _countAir -1 do {
				_group = ["Air",_faction] call ALIVE_fnc_configGetRandomGroup;
				if!(_group == "FALSE") then {
					_groups set [count _groups, _group];
				};
			};

			for "_i" from 0 to _countSpecOps -1 do {
                _group = ["SpecOps",_faction] call ALIVE_fnc_configGetRandomGroup;
                if!(_group == "FALSE") then {
                    _groups set [count _groups, _group];
                };
            };

			_groups = _groups - ALiVE_PLACEMENT_GROUPBLACKLIST;
			_infantryGroups = _infantryGroups - ALiVE_PLACEMENT_GROUPBLACKLIST;


			// Position and create groups
			_groupCount = count _groups;
			_clusterCount = count _clusters;
			_groupPerCluster = floor(_groupCount / _clusterCount);
			_totalCount = 0;

            _readiness = parseNumber([_logic, "readinessLevel"] call MAINCLASS);
            _readiness = (1 - _readiness) * _groupCount;

			ALIVE_Roadblock_Locations = [];

			{
                private ["_guardGroup","_guards","_center","_size"];

				_center = [_x, "center"] call ALIVE_fnc_hashGet;
				_size = [_x, "size"] call ALIVE_fnc_hashGet;

				if(count _infantryGroups > 0) then {
                    _guardGroup = _infantryGroups call BIS_fnc_selectRandom;
                    _guards = [_guardGroup, _center, random(360), true, _faction] call ALIVE_fnc_createProfilesFromGroupConfig;

                    //ARJay, here we could place the default patrols/garrisons instead of the static garrisson if you like to (same is in CIV MP)
                    {
                        if (([_x,"type"] call ALiVE_fnc_HashGet) == "entity") then {
                            [_x, "setActiveCommand", ["ALIVE_fnc_garrison","spawn",200]] call ALIVE_fnc_profileEntity;
                        };
                    } foreach _guards;
                };

				if(_totalCount < _groupCount) then {
                    private ["_profiles","_command","_position","_garrisonPos"];

                    _command = "ALIVE_fnc_ambientMovement";

                    if (_totalCount < _readiness ) then {
                        _command = "ALIVE_fnc_garrison";
                        _garrisonPos = [_center, 50] call CBA_fnc_RandPos;
                    };

					if(_groupPerCluster > 0) then {

						for "_i" from 0 to _groupPerCluster -1 do {
							_group = _groups select _totalCount;

                            if (isnil "_garrisonPos") then {
                                _position = [_center, ((_size/2) + random(500)), random(360)] call BIS_fnc_relPos;
                            } else {
                                _position = [_garrisonPos, 50] call CBA_fnc_RandPos;
                            };

							if!(surfaceIsWater _position) then {
							    _profiles = [_group, _position, random(360), true, _faction] call ALIVE_fnc_createProfilesFromGroupConfig;
                                {
                                    if (([_x,"type"] call ALiVE_fnc_HashGet) == "entity") then {
                        				[_x, "setActiveCommand", [_command,"spawn",200]] call ALIVE_fnc_profileEntity;
                                    };
                                } foreach _profiles;

                                _countProfiles = _countProfiles + count _profiles;
                                _totalCount = _totalCount + 1;
							};
						};

					}else{
						_group = _groups select _totalCount;

                        if (isnil "_garrisonPos") then {
                            _position = [_center, (_size + random(500)), random(360)] call BIS_fnc_relPos;
                        } else {
                            _position = [_garrisonPos, 50] call CBA_fnc_RandPos;
                        };

						if!(surfaceIsWater _position) then {
                            _profiles = [_group, _position, random(360), true, _faction] call ALIVE_fnc_createProfilesFromGroupConfig;
                            {
                                if (([_x,"type"] call ALiVE_fnc_HashGet) == "entity") then {
                    				[_x, "setActiveCommand", [_command,"spawn",200]] call ALIVE_fnc_profileEntity;
                                };
                            } foreach _profiles;

                            _countProfiles = _countProfiles + count _profiles;
                            _totalCount = _totalCount + 1;
                        };
					};
				};

                if (!isnil "ALIVE_fnc_createRoadblock" && {random 60 < _roadBlocks}) then {

            		private ["_rb"];

            		_rb = [];
            		_rb pushback _center;
            		_rb pushback _size;

            		ALIVE_Roadblock_Locations pushback _rb;

                };

			} forEach _clusters;

			ALIVE_Roadblocks = [];
			// Start Roadblock spawn checker
			[_logic] spawn {
				while {count ALIVE_Roadblock_Locations > 0} do {
					private ["_timer"];
					_timer = time;
					{
						private ["_position","_size","_roadblocks","_spawn"];
						_logic = _this select 0;
						_position  = _x select 0;
						_size = _x select 1;
						_roadBlocks = parsenumber([_logic, "roadBlocks"] call MAINCLASS);
						_spawn = false;
						if ([_position, ALIVE_spawnRadius,ALIVE_spawnRadiusJet,ALIVE_spawnRadiusHeli] call ALiVE_fnc_anyPlayersInRangeIncludeAir) then {
						    _spawn = true;
						}else{
				            if ([_position, ALIVE_spawnRadiusJet] call ALiVE_fnc_anyAutonomousInRange > 0) then {
				                _spawn = true;
				            };
						};

						if (_spawn) then {
							[_position, _size+150, ceil (_roadblocks / 10)] call ALiVE_fnc_createRoadblock;
							ALIVE_Roadblock_Locations set [_foreachIndex, -1];
							ALIVE_Roadblock_Locations = ALIVE_Roadblock_Locations - [-1];
						};

					} foreach ALIVE_Roadblock_Locations;
					diag_log format ["RB timer: %1 secs", time - _timer];
					sleep 1;
				};
			};


			// DEBUG -------------------------------------------------------------------------------------
			if(_debug) then {
				["ALIVE CP - Total profiles created: %1",_countProfiles] call ALIVE_fnc_dump;
				["ALIVE CP - Placement completed"] call ALIVE_fnc_dump;
				[] call ALIVE_fnc_timer;
				["----------------------------------------------------------------------------------------"] call ALIVE_fnc_dump;
			};
			// DEBUG -------------------------------------------------------------------------------------

			// set module as started
            _logic setVariable ["startupComplete", true];

		};
	};
};

TRACE_1("CP - output",_result);
_result;
