//#define DEBUG_MODE_FULL
#include <\x\alive\addons\civ_strategic\script_component.hpp>
SCRIPT(CO);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_CO
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
- <ALIVE_fnc_COInit>

Author:
Wolffy
---------------------------------------------------------------------------- */

#define SUPERCLASS ALIVE_fnc_baseClass
#define MAINCLASS ALIVE_fnc_CO
#define MTEMPLATE "ALiVE_CO_%1"
#define DEFAULT_OBJECTIVES []
#define DEFAULT_OBJECTIVES_HQ []
#define DEFAULT_OBJECTIVES_POWER []
#define DEFAULT_OBJECTIVES_COMMS []
#define DEFAULT_OBJECTIVES_MARINE []
#define DEFAULT_OBJECTIVES_RAIL []
#define DEFAULT_OBJECTIVES_FUEL []
#define DEFAULT_OBJECTIVES_CONSTRUCTION []
#define DEFAULT_OBJECTIVES_SETTLEMENT [] 
#define DEFAULT_TAOR QUOTE("""")
#define DEFAULT_BLACKLIST QUOTE("""")
#define DEFAULT_INIT_TYPE QUOTE(STATIC)
#define DEFAULT_SIZE_FILTER "0"
#define DEFAULT_PRIORITY_FILTER "0"

private ["_logic","_operation","_args","_result"];

TRACE_1("CO - input",_this);

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
	// Return TAOR marker
	case "taor": {
		_result = [_logic,_operation,_args,DEFAULT_TAOR] call ALIVE_fnc_OOsimpleOperation;
	};
	// Return the Blacklist marker
	case "blacklist": {
		_result = [_logic,_operation,_args,DEFAULT_BLACKLIST] call ALIVE_fnc_OOsimpleOperation;
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
	// Main process
	case "init": {
        if (isServer) then {
			private ["_initType"];
						
			// if server, initialise module game logic
			_logic setVariable ["super", SUPERCLASS];
			_logic setVariable ["class", MAINCLASS];
			TRACE_1("After module init",_logic);			
			
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
        };
	};
	// Static Init
	case "initStatic": {
        if (isServer) then {
		
			[true] call ALIVE_fnc_timer;
		
			private ["_worldName","_file","_clusters","_cluster","_taor","_taorClusters","_blacklist",
			"_sizeFilter","_priorityFilter","_blacklistClusters","_center"];
			
			if(isNil "ALIVE_clustersCiv" && isNil "ALIVE_loadedCivClusters") then {				
				_worldName = toLower(worldName);			
				_file = format["\x\alive\addons\fnc_strategic\clusters\clusters.%1_civ.sqf", _worldName];				
				call compile preprocessFileLineNumbers _file;
				ALIVE_loadedCIVClusters = true;
			};
			
			//waituntil {sleep 0.1; !(isnil "ALIVE_loadedCIVClusters")};
			
			_taor = [_logic, "taor"] call ALIVE_fnc_MO;
			_blacklist = [_logic, "blacklist"] call ALIVE_fnc_MO;
			_sizeFilter = parseNumber([_logic, "sizeFilter"] call ALIVE_fnc_MO);
			_priorityFilter = parseNumber([_logic, "priorityFilter"] call ALIVE_fnc_MO);
			
			
			_clusters = ALIVE_clustersCiv;
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
			
			
			private ["_HQClusters","_powerClusters","_commsClusters","_marineClusters","_railClusters","_fuelClusters","_constructionClusters"];
			
			
			_HQClusters = ALIVE_clustersCivHQ;
			_HQClusters = [_HQClusters,_sizeFilter,_priorityFilter] call ALIVE_fnc_copyClusters;
			_HQClusters = [_HQClusters, _taor] call ALIVE_fnc_clustersInsideMarker;
			_HQClusters = [_HQClusters, _blacklist] call ALIVE_fnc_clustersOutsideMarker;
			/*
			{
				[_x, "debug", [_logic, "debug"] call MAINCLASS] call ALIVE_fnc_cluster;
			} forEach _HQClusters;
			*/
			[_logic, "objectivesHQ", _HQClusters] call MAINCLASS;			
			
			
			_powerClusters = ALIVE_clustersCivPower;
			_powerClusters = [_powerClusters,_sizeFilter,_priorityFilter] call ALIVE_fnc_copyClusters;
			_powerClusters = [_powerClusters, _taor] call ALIVE_fnc_clustersInsideMarker;
			_powerClusters = [_powerClusters, _blacklist] call ALIVE_fnc_clustersOutsideMarker;
			/*
			{
				[_x, "debug", [_logic, "debug"] call MAINCLASS] call ALIVE_fnc_cluster;
			} forEach _powerClusters;
			*/
			[_logic, "objectivesPower", _powerClusters] call MAINCLASS;
			
			
			_commsClusters = ALIVE_clustersCivComms;
			_commsClusters = [_commsClusters,_sizeFilter,_priorityFilter] call ALIVE_fnc_copyClusters;
			_commsClusters = [_commsClusters, _taor] call ALIVE_fnc_clustersInsideMarker;
			_commsClusters = [_commsClusters, _blacklist] call ALIVE_fnc_clustersOutsideMarker;
			/*
			{
				[_x, "debug", [_logic, "debug"] call MAINCLASS] call ALIVE_fnc_cluster;
			} forEach _commsClusters;
			*/
			[_logic, "objectivesComms", _commsClusters] call MAINCLASS;
			
			
			_marineClusters = ALIVE_clustersCivMarine;
			_marineClusters = [_marineClusters,_sizeFilter,_priorityFilter] call ALIVE_fnc_copyClusters;
			_marineClusters = [_marineClusters, _taor] call ALIVE_fnc_clustersInsideMarker;
			_marineClusters = [_marineClusters, _blacklist] call ALIVE_fnc_clustersOutsideMarker;
			/*
			{
				[_x, "debug", [_logic, "debug"] call MAINCLASS] call ALIVE_fnc_cluster;
			} forEach _marineClusters;
			*/
			[_logic, "objectivesMarine", _marineClusters] call MAINCLASS;
			
			
			_railClusters = ALIVE_clustersCivMarine;
			_railClusters = [_railClusters,_sizeFilter,_priorityFilter] call ALIVE_fnc_copyClusters;
			_railClusters = [_railClusters, _taor] call ALIVE_fnc_clustersInsideMarker;
			_railClusters = [_railClusters, _blacklist] call ALIVE_fnc_clustersOutsideMarker;
			/*
			{
				[_x, "debug", [_logic, "debug"] call MAINCLASS] call ALIVE_fnc_cluster;
			} forEach _railClusters;
			*/
			[_logic, "objectivesRail", _railClusters] call MAINCLASS;
			
			
			_fuelClusters = ALIVE_clustersCivMarine;
			_fuelClusters = [_fuelClusters,_sizeFilter,_priorityFilter] call ALIVE_fnc_copyClusters;
			_fuelClusters = [_fuelClusters, _taor] call ALIVE_fnc_clustersInsideMarker;
			_fuelClusters = [_fuelClusters, _blacklist] call ALIVE_fnc_clustersOutsideMarker;
			/*
			{
				[_x, "debug", [_logic, "debug"] call MAINCLASS] call ALIVE_fnc_cluster;
			} forEach _fuelClusters;
			*/
			[_logic, "objectivesFuel", _fuelClusters] call MAINCLASS;
			
			
			_constructionClusters = ALIVE_clustersCivConstruction;
			_constructionClusters = [_constructionClusters,_sizeFilter,_priorityFilter] call ALIVE_fnc_copyClusters;
			_constructionClusters = [_constructionClusters, _taor] call ALIVE_fnc_clustersInsideMarker;
			_constructionClusters = [_constructionClusters, _blacklist] call ALIVE_fnc_clustersOutsideMarker;
			/*
			{
				[_x, "debug", [_logic, "debug"] call MAINCLASS] call ALIVE_fnc_cluster;
			} forEach _constructionClusters;
			*/
			[_logic, "objectivesConstruction", _constructionClusters] call MAINCLASS;
			
			
			_settlementClusters = ALIVE_clustersCivSettlement;
			_settlementClusters = [_settlementClusters,_sizeFilter,_priorityFilter] call ALIVE_fnc_copyClusters;
			_settlementClusters = [_settlementClusters, _taor] call ALIVE_fnc_clustersInsideMarker;
			_settlementClusters = [_settlementClusters, _blacklist] call ALIVE_fnc_clustersOutsideMarker;
			/*
			{
				[_x, "debug", [_logic, "debug"] call MAINCLASS] call ALIVE_fnc_cluster;
			} forEach _settlementClusters;
			*/
			[_logic, "objectivesSettlement", _settlementClusters] call MAINCLASS;
			
			
			[] call ALIVE_fnc_timer;
			
        };
	};
	// Generate Static Data
	case "generateStaticData": {
        if (isServer) then {
		
			private ["_objectives","_objectivesHQ","_objectivesPower","_objectivesComms","_objectivesMarine",
			"_objectivesRail","_objectivesFuel","_objectivesConstruction","_objectivesSettlement","_worldName","_objectivesName","_exportString","_result"];

			_objectives = [_logic, "objectives"] call MAINCLASS;
			_objectivesHQ = [_logic, "objectivesHQ"] call MAINCLASS;
			_objectivesPower = [_logic, "objectivesPower"] call MAINCLASS;
			_objectivesComms = [_logic, "objectivesComms"] call MAINCLASS;
			_objectivesMarine = [_logic, "objectivesMarine"] call MAINCLASS;
			_objectivesRail = [_logic, "objectivesRail"] call MAINCLASS;
			_objectivesFuel = [_logic, "objectivesFuel"] call MAINCLASS;
			_objectivesConstruction = [_logic, "objectivesConstruction"] call MAINCLASS;
			_objectivesSettlement = [_logic, "objectivesSettlement"] call MAINCLASS;
			_worldName = toLower(worldName);
			
			["HQ: %1",_objectivesHQ] call ALIVE_fnc_dump;
			["PO: %1",_objectivesPower] call ALIVE_fnc_dump;
			["CO: %1",_objectivesComms] call ALIVE_fnc_dump;
			["MA: %1",_objectivesMarine] call ALIVE_fnc_dump;
			["FU: %1",_objectivesFuel] call ALIVE_fnc_dump;
			
			_exportString = '';
			
			_objectivesName = 'ALIVE_clustersCiv';
			_result = [_objectives, _objectivesName] call ALIVE_fnc_staticClusterOutput;
			
			_exportString = _result;
			
			if(count _objectivesHQ > 0) then {
				["HQ"] call ALIVE_fnc_dump;
				_objectivesName = 'ALIVE_clustersCivHQ';
				_result = [_objectivesHQ, _objectivesName] call ALIVE_fnc_staticClusterOutput;				
				_exportString = _exportString + _result;
			};
			
			if(count _objectivesPower > 0) then {
				["POWER"] call ALIVE_fnc_dump;
				_objectivesName = 'ALIVE_clustersCivPower';
				_result = [_objectivesPower, _objectivesName] call ALIVE_fnc_staticClusterOutput;			
				_exportString = _exportString + _result;
			};
			
			if(count _objectivesComms > 0) then {
				["COMMS"] call ALIVE_fnc_dump;
				_objectivesName = 'ALIVE_clustersCivComms';
				_result = [_objectivesComms, _objectivesName] call ALIVE_fnc_staticClusterOutput;				
				_exportString = _exportString + _result;
			};
			
			if(count _objectivesMarine > 0) then {
				["MARINE"] call ALIVE_fnc_dump;
				_objectivesName = 'ALIVE_clustersCivMarine';
				_result = [_objectivesMarine, _objectivesName] call ALIVE_fnc_staticClusterOutput;
				_exportString = _exportString + _result;
			};
			
			if(count _objectivesRail > 0) then {
				["RAIL"] call ALIVE_fnc_dump;
				_objectivesName = 'ALIVE_clustersCivRail';
				_result = [_objectivesRail, _objectivesName] call ALIVE_fnc_staticClusterOutput;
				_exportString = _exportString + _result;
			};	
			
			if(count _objectivesFuel > 0) then {
				["FUEL"] call ALIVE_fnc_dump;
				_objectivesName = 'ALIVE_clustersCivFuel';
				_result = [_objectivesFuel, _objectivesName] call ALIVE_fnc_staticClusterOutput;
				_exportString = _exportString + _result;
			};
			
			if(count _objectivesConstruction > 0) then {
				["CON"] call ALIVE_fnc_dump;
				_objectivesName = 'ALIVE_clustersCivConstruction';
				_result = [_objectivesConstruction, _objectivesName] call ALIVE_fnc_staticClusterOutput;
				_exportString = _exportString + _result;
			};
			
			if(count _objectivesSettlement > 0) then {
				["SET"] call ALIVE_fnc_dump;
				_objectivesName = 'ALIVE_clustersCivSettlement';
				_result = [_objectivesSettlement, _objectivesName] call ALIVE_fnc_staticClusterOutput;
				_exportString = _exportString + _result;
			};
			
			copyToClipboard _exportString;
			["Civilian Objectives generation complete, results have been copied to the clipboard"] call ALIVE_fnc_dump;
			["Should be pasted in file: fnc_strategic\clusters\clusters.%1_civ.sqf", _worldName] call ALIVE_fnc_dump;
			
        };
	};
	// Dynamic init
	case "initDynamic": {
        if (isServer) then {
			private ["_obj_array","_types","_clusters","_clusters_tmp","_size"];
			
			/*
			"ColorBlack"
			"ColorRed"
			"ColorRedAlpha"
			"ColorGreen"
			"ColorGreenAlpha"
			"ColorBlue"
			"ColorYellow"
			"ColorOrange"
			"ColorWhite"
			"ColorPink"
			"ColorBrown"
			"ColorKhaki"
			*/
			
			
			// Find HQ locations
			// ------------------------------------------------------------------
			private ["_clusters_hq"];
			
			"CO - Searching HQ locations" call ALiVE_fnc_logger;
			
			_types = [
				"a_municipaloffice",
				"a_office01",
				"a_office02",
				"airport_tower"
			];

			_clusters_hq = [_logic, _types] call ALIVE_fnc_findTargets;
			_clusters_hq = [_clusters_hq, "CIV", 50, "ColorBlack"] call ALIVE_fnc_setTargets;
			_clusters_hq = [_clusters_hq] call ALIVE_fnc_consolidateClusters;
						
			// Store the categorised clusters on the logic
			[_logic, "objectivesHQ", [_clusters_hq] call ALIVE_fnc_copyClusters] call MAINCLASS;		
			
			_clusters = +_clusters_hq;
			
			
			
			// Find civ power
			// ------------------------------------------------------------------
			private ["_clusters_power"];
			
			"CO - Searching Power locations" call ALiVE_fnc_logger;
			
			_types = [
				//"_dam_",
				"_pec_",
				"powerstation",
				"spp_",
				"trafostanica"
			];
			_clusters_power = [_logic, _types] call ALIVE_fnc_findTargets;
			_clusters_power = [_clusters_power, "CIV", 40, "ColorYellow"] call ALIVE_fnc_setTargets;
			
			// Consolidate locations
			_clusters_power = [_clusters_power] call ALIVE_fnc_consolidateClusters;
			
			// Store the categorised clusters on the logic
			[_logic, "objectivesPower", [_clusters_power] call ALIVE_fnc_copyClusters] call MAINCLASS;
			
			_clusters = _clusters + _clusters_power;
			_clusters = [_clusters] call ALIVE_fnc_consolidateClusters;
			
			
			
			// Find civ comms
			// ------------------------------------------------------------------
			private ["_clusters_comms"];
			
			"CO - Searching Comms locations" call ALiVE_fnc_logger;
			
			_types = [
				"communication_f",
				"vysilac_fm",
				"ttowerbig_"
			];
			_clusters_comms = [_logic, _types] call ALIVE_fnc_findTargets;
			_clusters_comms = [_clusters_comms, "CIV", 40, "ColorWhite"] call ALIVE_fnc_setTargets;
			
			// Consolidate locations
			_clusters_comms = [_clusters_comms] call ALIVE_fnc_consolidateClusters;
			
			// Store the categorised clusters on the logic
			[_logic, "objectivesComms", [_clusters_comms] call ALIVE_fnc_copyClusters] call MAINCLASS;
			
			_clusters = _clusters + _clusters_comms;
			_clusters = [_clusters] call ALIVE_fnc_consolidateClusters;
			
			
			
			// Find civ marine
			// ------------------------------------------------------------------
			private ["_clusters_marine"];
			
			"CO - Searching Marine locations" call ALiVE_fnc_logger;
			
			_types = [
				"crane",
				"lighthouse",
				"nav_pier",
				"pier_",
				"wtower"
			];
			_clusters_marine = [_logic, _types] call ALIVE_fnc_findTargets;
			_clusters_marine = [_clusters_marine, "CIV", 30, "ColorBlue"] call ALIVE_fnc_setTargets;
			
			// Consolidate locations
			_clusters_marine = [_clusters_marine] call ALIVE_fnc_consolidateClusters;
			
			// Store the categorised clusters on the logic
			[_logic, "objectivesMarine", [_clusters_marine] call ALIVE_fnc_copyClusters] call MAINCLASS;
			
			// Consolidate locations
			_clusters = _clusters + _clusters_marine;
			_clusters = [_clusters] call ALIVE_fnc_consolidateClusters;
			
			
			
			// Find civ rail
			// ------------------------------------------------------------------
			private ["_clusters_rail"];
			
			"CO - Searching Rail locations" call ALiVE_fnc_logger;
			
			_types = [
				"rail_house",
				"stationhouse"
			];
			_clusters_rail = [_logic, _types] call ALIVE_fnc_findTargets;
			_clusters_rail = [_clusters_rail, "CIV", 10, "ColorKhaki"] call ALIVE_fnc_setTargets;
			
			// Consolidate locations
			_clusters_rail = [_clusters_rail] call ALIVE_fnc_consolidateClusters;
			
			// Store the categorised clusters on the logic
			[_logic, "objectivesRail", [_clusters_rail] call ALIVE_fnc_copyClusters] call MAINCLASS;
			
			// Consolidate locations
			_clusters = _clusters + _clusters_rail;
			_clusters = [_clusters] call ALIVE_fnc_consolidateClusters;
			
			
			
			// Find civ fuel
			// ------------------------------------------------------------------
			private ["_clusters_fuel"];
			
			"CO - Searching Fuel locations" call ALiVE_fnc_logger;
			
			_types = [
				"fuelstation",
				"_oil_",
				"dp_",
				"IndPipe"
			];
			_clusters_fuel = [_logic, _types] call ALIVE_fnc_findTargets;
			_clusters_fuel = [_clusters_fuel, "CIV", 30, "ColorOrange"] call ALIVE_fnc_setTargets;
			
			// Consolidate locations
			_clusters_fuel = [_clusters_fuel] call ALIVE_fnc_consolidateClusters;
			
			// Store the categorised clusters on the logic
			[_logic, "objectivesFuel", [_clusters_fuel] call ALIVE_fnc_copyClusters] call MAINCLASS;
			
			// Consolidate locations
			_clusters = _clusters + _clusters_fuel;
			_clusters = [_clusters] call ALIVE_fnc_consolidateClusters;
			
			
			
			// Find civ construction
			// ------------------------------------------------------------------
			private ["_clusters_construction"];
			
			"CO - Searching Construction locations" call ALiVE_fnc_logger;
			
			_types = [
				"wip"
			];
			_clusters_construction = [_logic, _types] call ALIVE_fnc_findTargets;
			_clusters_construction = [_clusters_construction, "CIV", 10, "ColorPink"] call ALIVE_fnc_setTargets;
			
			// Consolidate locations
			_clusters_construction = [_clusters_construction] call ALIVE_fnc_consolidateClusters;
			
			// Store the categorised clusters on the logic
			[_logic, "objectivesConstruction", [_clusters_construction] call ALIVE_fnc_copyClusters] call MAINCLASS;
			
			// Consolidate locations
			_clusters = _clusters + _clusters_construction;
			_clusters = [_clusters] call ALIVE_fnc_consolidateClusters;
			
			
			
			// Find civ settlements
			// ------------------------------------------------------------------
			private ["_clusters_settlement"];
			
			"CO - Searching Settlement locations" call ALiVE_fnc_logger;
			
			_types = [
				"households"
			];
			_clusters_settlement = [_logic, _types] call ALIVE_fnc_findTargets;
			_clusters_settlement = [_clusters_settlement, "CIV", 0, "ColorGreen"] call ALIVE_fnc_setTargets;
			
			// Consolidate locations
			_clusters_settlement = [_clusters_settlement] call ALIVE_fnc_consolidateClusters;
			
			// Store the categorised clusters on the logic
			[_logic, "objectivesSettlement", [_clusters_settlement] call ALIVE_fnc_copyClusters] call MAINCLASS;
			
			// Consolidate locations
			_clusters = _clusters + _clusters_settlement;
			_clusters = [_clusters] call ALIVE_fnc_consolidateClusters;
			
			
			
			
			
			// Final Consolidation 
			// ------------------------------------------------------------------
			"CO - Consolidating Clusters" call ALiVE_fnc_logger;
			_clusters = [_clusters] call ALIVE_fnc_consolidateClusters;
			"CO - Locations Completed" call ALiVE_fnc_logger;
			
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

TRACE_1("CO - output",_result);
_result;
