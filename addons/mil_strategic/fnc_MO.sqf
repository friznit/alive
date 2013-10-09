//#define DEBUG_MODE_FULL
#include <\x\alive\addons\mil_strategic\script_component.hpp>
SCRIPT(MO);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_MO
Description:
Military objectives 

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
- <ALIVE_fnc_MOInit>

Author:
Wolffy
---------------------------------------------------------------------------- */

#define SUPERCLASS ALIVE_fnc_baseClass
#define MAINCLASS ALIVE_fnc_MO
#define MTEMPLATE "ALiVE_MO_%1"
#define DEFAULT_OBJECTIVES []
#define DEFAULT_OBJECTIVES_HQ []
#define DEFAULT_OBJECTIVES_AIR []
#define DEFAULT_OBJECTIVES_HELI []
#define DEFAULT_OBJECTIVES_VEHICLE []
#define DEFAULT_TAOR []
#define DEFAULT_BLACKLIST []
#define DEFAULT_INIT_TYPE QUOTE(STATIC)
#define DEFAULT_SIZE_FILTER "0"
#define DEFAULT_PRIORITY_FILTER "0"

private ["_logic","_operation","_args","_result"];

TRACE_1("MO - input",_this);

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
			_logic setVariable ["moduleType", "ALIVE_MO"];
			
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
	// Return TAOR marker
	case "taor": {
		if(typeName _args == "STRING") then {
			_logic setVariable [_operation, call compile _args];
			
			/*
			_args = [_args, ","] call CBA_fnc_split;
			if(count _args > 0) then {
				_logic setVariable [_operation, _args];
			};
			*/
		};
		if(typeName _args == "ARRAY") then {		
			_logic setVariable [_operation, _args];
		};
		_result = _logic getVariable [_operation, DEFAULT_TAOR];
		/*
		if(typeName _result == "STRING") then {
			_result = [];
		};
		*/		
	};
	// Return the Blacklist marker
	case "blacklist": {
		if(typeName _args == "STRING") then {
			_logic setVariable [_operation, call compile _args];
			
			/*
			_args = [_args, ","] call CBA_fnc_split;
			if(count _args > 0) then {
				_logic setVariable [_operation, _args];
			};
			*/
		};
		if(typeName _args == "ARRAY") then {		
			_logic setVariable [_operation, _args];
		};
		_result = _logic getVariable [_operation, DEFAULT_BLACKLIST];
		/*
		if(typeName _result == "STRING") then {
			_result = [];
		};
		*/		
	};
	// Return the Size filter
	case "sizeFilter": {
		_result = [_logic,_operation,_args,DEFAULT_SIZE_FILTER] call ALIVE_fnc_OOsimpleOperation;
	};
	// Return the Priority filter
	case "priorityFilter": {
		_result = [_logic,_operation,_args,DEFAULT_PRIORITY_FILTER] call ALIVE_fnc_OOsimpleOperation;
	};
	// Return the Init Type
	case "initType": {
		_result = [_logic,_operation,_args,DEFAULT_INIT_TYPE,["STATIC","DYNAMIC","GENERATE"]] call ALIVE_fnc_OOsimpleOperation;
	};
	// Return the objectives as an array of clusters
	case "objectives": {
		_result = [_logic,_operation,_args,DEFAULT_OBJECTIVES] call ALIVE_fnc_OOsimpleOperation;
	};
	// Return the HQ objectives as an array of clusters
	case "objectivesHQ": {
		_result = [_logic,_operation,_args,DEFAULT_OBJECTIVES_HQ] call ALIVE_fnc_OOsimpleOperation;
	};
	// Return the AIR objectives as an array of clusters
	case "objectivesAir": {
		_result = [_logic,_operation,_args,DEFAULT_OBJECTIVES_AIR] call ALIVE_fnc_OOsimpleOperation;
	};
	// Return the Heli objectives as an array of clusters
	case "objectivesHeli": {
		_result = [_logic,_operation,_args,DEFAULT_OBJECTIVES_HELI] call ALIVE_fnc_OOsimpleOperation;
	};
	// Main process
	case "init": {
        if (isServer) then {
			private ["_initType"];
						
			// if server, initialise module game logic
			_logic setVariable ["super", SUPERCLASS];
			_logic setVariable ["class", MAINCLASS];
			_logic setVariable ["moduleType", "ALIVE_MO"];
			_logic setVariable ["startupComplete", false];
			TRACE_1("After module init",_logic);

			[_logic, "taor", _logic getVariable ["taor", DEFAULT_TAOR]] call MAINCLASS;
			[_logic, "blacklist", _logic getVariable ["blacklist", DEFAULT_TAOR]] call MAINCLASS;

			[_logic,"register"] call MAINCLASS;			
        } else {
            {deleteMarkerLocal _x} foreach (call compile (_logic getVariable ["taor", DEFAULT_TAOR]));
            {deleteMarkerLocal _x} foreach (call compile (_logic getVariable ["blacklist", DEFAULT_TAOR]));            
        };
	};
	case "register": {
		
			private["_registration","_moduleType"];
		
			_moduleType = _logic getVariable "moduleType";
			_registration = [_logic,_moduleType];
	
			if(isNil "ALIVE_registry") then {
				ALIVE_registry = [nil, "create"] call ALIVE_fnc_registry;
				[ALIVE_registry, "init"] call ALIVE_fnc_registry;			
			};

			[ALIVE_registry,"register",_registration] call ALIVE_fnc_registry;
	};
	// Main process
	case "start": {
        if (isServer) then {
			private ["_initType"];
			
			_initType = [_logic, "initType"] call MAINCLASS;
			
			switch(_initType) do {
				case "STATIC":{
					[_logic, "initStatic"] call MAINCLASS;
				};
				case "DYNAMIC":{
					[_logic, "initDynamic"] call MAINCLASS;
				};
				case "GENERATE":{
					[_logic, "initDynamic"] call MAINCLASS;
					[_logic, "generateStaticData"] call MAINCLASS;
				};
			};		

			// set module as started
			_logic setVariable ["startupComplete", true];
        };
	};
	// Static Init
	case "initStatic": {
        if (isServer) then {
		
			private ["_debug","_worldName","_file","_clusters","_cluster","_taor","_taorClusters","_blacklist",
			"_sizeFilter","_priorityFilter","_blacklistClusters","_center"];
			
			_debug = [_logic, "debug"] call MAINCLASS;
			
			// DEBUG -------------------------------------------------------------------------------------
			if(_debug) then {
				["----------------------------------------------------------------------------------------"] call ALIVE_fnc_dump;
				["ALIVE MO - Startup"] call ALIVE_fnc_dump;
				[true] call ALIVE_fnc_timer;
			};
			// DEBUG -------------------------------------------------------------------------------------
			
								
			if(isNil "ALIVE_clustersMil" && isNil "ALIVE_loadedMilClusters") then {
				_worldName = toLower(worldName);			
				_file = format["\x\alive\addons\mil_strategic\clusters\clusters.%1_mil.sqf", _worldName];				
				call compile preprocessFileLineNumbers _file;
				ALIVE_loadedMilClusters = true;
			};
			
			_taor = [_logic, "taor"] call ALIVE_fnc_MO;
			_blacklist = [_logic, "blacklist"] call ALIVE_fnc_MO;
			_sizeFilter = parseNumber([_logic, "sizeFilter"] call ALIVE_fnc_MO);
			_priorityFilter = parseNumber([_logic, "priorityFilter"] call ALIVE_fnc_MO);
			
			
			_clusters = ALIVE_clustersMil select 2;
			_clusters = [_clusters,_sizeFilter,_priorityFilter] call ALIVE_fnc_copyClusters;
			// cull clusters outside of TAOR marker if defined
			_clusters = [_clusters, _taor] call ALIVE_fnc_clustersInsideMarker;
			// cull clusters inside of Blacklist marker if defined
			_clusters = [_clusters, _blacklist] call ALIVE_fnc_clustersOutsideMarker;
			///*
			// switch on debug for all clusters if debug on
			{
				[_x, "debug", [_logic, "debug"] call MAINCLASS] call ALIVE_fnc_cluster;
			} forEach _clusters;
			//*/
			// store the clusters on the logic
			[_logic, "objectives", _clusters] call MAINCLASS;
			
			
			private ["_HQClusters","_airClusters","_heliClusters"];
			
			
			_HQClusters = ALIVE_clustersMilHQ select 2;
			_HQClusters = [_HQClusters,_sizeFilter,_priorityFilter] call ALIVE_fnc_copyClusters;
			_HQClusters = [_HQClusters, _taor] call ALIVE_fnc_clustersInsideMarker;
			_HQClusters = [_HQClusters, _blacklist] call ALIVE_fnc_clustersOutsideMarker;
			/*
			{
				[_x, "debug", [_logic, "debug"] call MAINCLASS] call ALIVE_fnc_cluster;
			} forEach _HQClusters;
			*/
			[_logic, "objectivesHQ", _HQClusters] call MAINCLASS;			
			
			
			_airClusters = ALIVE_clustersMilAir select 2;
			_airClusters = [_airClusters,_sizeFilter,_priorityFilter] call ALIVE_fnc_copyClusters;
			_airClusters = [_airClusters, _taor] call ALIVE_fnc_clustersInsideMarker;
			_airClusters = [_airClusters, _blacklist] call ALIVE_fnc_clustersOutsideMarker;
			/*
			{
				[_x, "debug", [_logic, "debug"] call MAINCLASS] call ALIVE_fnc_cluster;
			} forEach _airClusters;
			*/
			[_logic, "objectivesAir", _airClusters] call MAINCLASS;
			
			
			_heliClusters = ALIVE_clustersMilHeli select 2;
			_heliClusters = [_heliClusters,_sizeFilter,_priorityFilter] call ALIVE_fnc_copyClusters;
			_heliClusters = [_heliClusters, _taor] call ALIVE_fnc_clustersInsideMarker;
			_heliClusters = [_heliClusters, _blacklist] call ALIVE_fnc_clustersOutsideMarker;
			/*
			{
				[_x, "debug", [_logic, "debug"] call MAINCLASS] call ALIVE_fnc_cluster;
			} forEach _heliClusters;
			*/
			[_logic, "objectivesHeli", _heliClusters] call MAINCLASS;
			
			
			// DEBUG -------------------------------------------------------------------------------------
			if(_debug) then {
				["ALIVE CO - Startup completed"] call ALIVE_fnc_dump;
				[] call ALIVE_fnc_timer;
				["----------------------------------------------------------------------------------------"] call ALIVE_fnc_dump;
			};
			// DEBUG -------------------------------------------------------------------------------------
			
			
        };
	};
	// Generate Static Data
	case "generateStaticData": {
        if (isServer) then {
		
			private ["_objectives","_objectivesHQ","_objectivesAir","_objectivesHeli","_worldName","_objectivesName","_exportString","_result","_clusterCount"];

			_objectives = [_logic, "objectives"] call MAINCLASS;
			_objectivesHQ = [_logic, "objectivesHQ"] call MAINCLASS;
			_objectivesAir = [_logic, "objectivesAir"] call MAINCLASS;
			_objectivesHeli = [_logic, "objectivesHeli"] call MAINCLASS;
			_worldName = toLower(worldName);
			
			_exportString = '';
			_clusterCount = 0;
			
			_objectivesName = 'ALIVE_clustersMil';
			_result = [_objectives, _objectivesName, _clusterCount] call ALIVE_fnc_staticClusterOutput;
			
			_clusterCount = _clusterCount + count _objectives;
			
			_exportString = _result;
			
			if(count _objectivesHQ > 0) then {
				_objectivesName = 'ALIVE_clustersMilHQ';
				_result = [_objectivesHQ, _objectivesName, _clusterCount] call ALIVE_fnc_staticClusterOutput;				
				_exportString = _exportString + _result;
			};
			
			_clusterCount = _clusterCount + count _objectivesHQ;
			
			if(count _objectivesAir > 0) then {
				_objectivesName = 'ALIVE_clustersMilAir';
				_result = [_objectivesAir, _objectivesName, _clusterCount] call ALIVE_fnc_staticClusterOutput;			
				_exportString = _exportString + _result;
			};
			
			_clusterCount = _clusterCount + count _objectivesAir;
			
			if(count _objectivesHeli > 0) then {
				_objectivesName = 'ALIVE_clustersMilHeli';
				_result = [_objectivesHeli, _objectivesName, _clusterCount] call ALIVE_fnc_staticClusterOutput;				
				_exportString = _exportString + _result;
			};
			
			_clusterCount = _clusterCount + count _objectivesHeli;	
			
			copyToClipboard _exportString;
			["Military Objectives generation complete, results have been copied to the clipboard"] call ALIVE_fnc_dump;
			["Should be pasted in file: fnc_strategic\clusters\clusters.%1_mil.sqf", _worldName] call ALIVE_fnc_dump;
			
        };
	};
	// Dynamic init
	case "initDynamic": {
        if (isServer) then {
			private ["_obj_array","_types","_clusters","_clusters_tmp","_size"];
			
			
			// Find HQ locations
			// ------------------------------------------------------------------
			private ["_clusters_hq"];
			
			"MO - Searching HQ locations" call ALiVE_fnc_logger;
			
			_types = [
				"barrack",
				"cargo_hq_",
				"miloffices",
				"mil_house",
				"mil_controltower",
				"barrack",
				"miloffices",
				"mil_controltower",
				"cargo_tower"
			];

			_clusters_hq = [_logic, _types] call ALIVE_fnc_findTargets;
			_clusters_hq = [_clusters_hq, "MIL", 50, "ColorRed"] call ALIVE_fnc_setTargets;
			_clusters_hq = [_clusters_hq] call ALIVE_fnc_consolidateClusters;
						
			// Store the categorised clusters on the logic
			[_logic, "objectivesHQ", [_clusters_hq] call ALIVE_fnc_copyClusters] call MAINCLASS;		
			
			_clusters = +_clusters_hq;
			
			
			// Find mil air locations
			// ------------------------------------------------------------------
			private ["_clusters_mil_air","_clusters_civ_air","_clusters_air"];
			
			"MO - Searching airfield locations" call ALiVE_fnc_logger;
			_types = [
				"tenthangar",
				"mil_hangar"				
			];
			_clusters_mil_air = [_logic, _types] call ALIVE_fnc_findTargets;
			_clusters_mil_air = [_clusters_mil_air, "MIL", 20, "ColorOrange"] call ALIVE_fnc_setTargets;
			
			// Find civ air locations
			_types = [
				"ss_hangar",
				"hangar_2",
				"hangar",				
				"runway_beton",
				"runway_end",
				"runway_main",
				"runway_secondary",
				"runwayold"
			];
			_clusters_civ_air = [_logic, _types] call ALIVE_fnc_findTargets;
			_clusters_civ_air = [_clusters_civ_air, "MIL", 10, "ColorOrange"] call ALIVE_fnc_setTargets;
			
			// Consolidate locations
			_clusters_air = _clusters_mil_air + _clusters_civ_air;
			_clusters_air = [_clusters_air] call ALIVE_fnc_consolidateClusters;
			
			// Store the categorised clusters on the logic
			[_logic, "objectivesAir", [_clusters_air] call ALIVE_fnc_copyClusters] call MAINCLASS;				
			
			_clusters = _clusters + _clusters_air;
			_clusters = [_clusters] call ALIVE_fnc_consolidateClusters;
			
						
	
			// Find mil heli locations
			// ------------------------------------------------------------------
			private ["_clusters_mil_heli","_clusters_civ_heli"];
			
			"MO - Searching helipad locations" call ALiVE_fnc_logger;
			_types = [
				"helipadempty",
				"helipadsquare",
				"heli_h_army"
			];
			_clusters_mil_heli = [_logic, _types] call ALIVE_fnc_findTargets;
			_clusters_mil_heli = [_clusters_mil_heli, "MIL", 20, "ColorYellow"] call ALIVE_fnc_setTargets;
			
			// Find civ heli locations
			_types = [
				"helipadempty",
				"heli_h_civil",
				"heli_h_rescue"
			];
			_clusters_civ_heli = [_logic, _types] call ALIVE_fnc_findTargets;
			_clusters_civ_heli = [_clusters_civ_heli, "MIL", 10, "ColorYellow"] call ALIVE_fnc_setTargets;

			// Consolidate locations
			_clusters_heli = _clusters_mil_heli + _clusters_civ_heli;
			_clusters_heli = [_clusters_heli] call ALIVE_fnc_consolidateClusters;
						
			// Store the categorised clusters on the logic
			[_logic, "objectivesHeli", [_clusters_heli] call ALIVE_fnc_copyClusters] call MAINCLASS;
			
			_clusters = _clusters + _clusters_heli;
			_clusters = [_clusters] call ALIVE_fnc_consolidateClusters;
			
					
			
			// Find general military locations
			// ------------------------------------------------------------------
			private ["_clusters_mil"];
			
			"MO - Searching military locations" call ALiVE_fnc_logger;
			
			// Military targets
			_types = [
				"airport_tower",
				"airport",
				"radar",
				"bunker",
				"cargo_house_v",
				"cargo_patrol_",
				"research",
				"deerstand",
				"hbarrier",
				"mil_wall",
				"fortification",
				//"mil_wired",
				"razorwire",
				"dome",
				"vez"
			];
			_clusters_mil = [_logic, _types] call ALIVE_fnc_findTargets;
			_clusters_mil = [_clusters_mil, "MIL", 0, "ColorGreen"] call ALIVE_fnc_setTargets;
			
			// Consolidate locations
			_clusters = _clusters + _clusters_mil;
			_clusters = [_clusters] call ALIVE_fnc_consolidateClusters;
			
			
			
			// Final Consolidation 
			// ------------------------------------------------------------------
			"MO - Consolidating Clusters" call ALiVE_fnc_logger;
			_clusters = [_clusters] call ALIVE_fnc_consolidateClusters;
			"MO - Locations Completed" call ALiVE_fnc_logger;
			
			
			// Generate parking positions
			// ------------------------------------------------------------------
			
			"MO - Generating Parking Positions" call ALiVE_fnc_logger;
			[true] call ALIVE_fnc_timer;
			_types = [
				"airport",
				"bunker",
				"cargo_house_v",
				"cargo_patrol_",
				"research"
			];
			[_clusters,_types] call ALIVE_fnc_generateParkingPositions;
			[] call ALIVE_fnc_timer;
			
			
			
			// switch on debug for all clusters
			{
				[_x, "debug", [_logic, "debug"] call MAINCLASS] call ALIVE_fnc_cluster;
			} forEach _clusters;
			
			// store the clusters on the logic
			[_logic, "objectives", _clusters] call MAINCLASS;			
			
			_result = _clusters;			
			
        };
	};
};

TRACE_1("MO - output",_result);
_result;
