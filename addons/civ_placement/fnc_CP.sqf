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
#define DEFAULT_OBJECTIVES_HQ []
#define DEFAULT_OBJECTIVES_POWER []
#define DEFAULT_OBJECTIVES_COMMS []
#define DEFAULT_OBJECTIVES_MARINE []
#define DEFAULT_OBJECTIVES_RAIL []
#define DEFAULT_OBJECTIVES_FUEL []
#define DEFAULT_OBJECTIVES_CONSTRUCTION []
#define DEFAULT_OBJECTIVES_SETTLEMENT [] 
#define DEFAULT_TAOR []
#define DEFAULT_BLACKLIST []
#define DEFAULT_SIZE_FILTER "0"
#define DEFAULT_PRIORITY_FILTER "0"
#define DEFAULT_TYPE QUOTE(RANDOM)
#define DEFAULT_FACTION QUOTE(OPF_F)

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
			ASSERT_TRUE([_args] call CBA_fnc_isHash,str _args);
			
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
	case "withPlacement": {
		if (typeName _args == "BOOL") then {
			_logic setVariable ["withPlacement", _args];
		} else {
			_args = _logic getVariable ["withPlacement", false];
		};
		if (typeName _args == "STRING") then {
			if(_args == "true") then {_args = true;} else {_args = false;};
			_logic setVariable ["withPlacement", _args];
		};
		ASSERT_TRUE(typeName _args == "BOOL",str _args);

		_result = _args;
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
						
			// if server, initialise module game logic
			_logic setVariable ["super", SUPERCLASS];
			_logic setVariable ["class", MAINCLASS];
			_logic setVariable ["moduleType", "ALIVE_CP"];
			_logic setVariable ["startupComplete", false];
			TRACE_1("After module init",_logic);

			[_logic, "taor", _logic getVariable ["taor", DEFAULT_TAOR]] call MAINCLASS;
			[_logic, "blacklist", _logic getVariable ["blacklist", DEFAULT_TAOR]] call MAINCLASS;

			[_logic,"register"] call MAINCLASS;			
        } else {
            [_logic, "taor", _logic getVariable ["taor", DEFAULT_TAOR]] call MAINCLASS;
            [_logic, "blacklist", _logic getVariable ["blacklist", DEFAULT_TAOR]] call MAINCLASS;
            {deleteMarkerLocal _x} foreach (_logic getVariable ["taor", DEFAULT_TAOR]);
            {deleteMarkerLocal _x} foreach (_logic getVariable ["blacklist", DEFAULT_TAOR]);            
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
	// Static Init
	case "start": {
        if (isServer) then {
		
			private ["_debug","_placement","_worldName","_file","_clusters","_cluster","_taor","_taorClusters","_blacklist",
			"_sizeFilter","_priorityFilter","_blacklistClusters","_center"];
						
			_debug = [_logic, "debug"] call MAINCLASS;
			
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
			
			_placement = [_logic, "withPlacement"] call MAINCLASS;
			_taor = [_logic, "taor"] call MAINCLASS;
			_blacklist = [_logic, "blacklist"] call MAINCLASS;
			_sizeFilter = parseNumber([_logic, "sizeFilter"] call MAINCLASS);
			_priorityFilter = parseNumber([_logic, "priorityFilter"] call MAINCLASS);
			
			_clusters = ALIVE_clustersCiv select 2;
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

			_HQClusters = DEFAULT_OBJECTIVES_HQ;
			_powerClusters = DEFAULT_OBJECTIVES_POWER;
			_commsClusters = DEFAULT_OBJECTIVES_COMMS;
			_marineClusters = DEFAULT_OBJECTIVES_MARINE;
			_railClusters = DEFAULT_OBJECTIVES_RAIL;
			_fuelClusters = DEFAULT_OBJECTIVES_FUEL;
			_constructionClusters = DEFAULT_OBJECTIVES_CONSTRUCTION;
			_settlementClusters = DEFAULT_OBJECTIVES_SETTLEMENT;
            
            if !(isnil "ALIVE_clustersCivHQ") then {
				_HQClusters = ALIVE_clustersCivHQ select 2;
				_HQClusters = [_HQClusters,_sizeFilter,_priorityFilter] call ALIVE_fnc_copyClusters;
				_HQClusters = [_HQClusters, _taor] call ALIVE_fnc_clustersInsideMarker;
				_HQClusters = [_HQClusters, _blacklist] call ALIVE_fnc_clustersOutsideMarker;
				/*
				{
					[_x, "debug", [_logic, "debug"] call MAINCLASS] call ALIVE_fnc_cluster;
				} forEach _HQClusters;
				*/
			};
			
            if !(isnil "ALIVE_clustersCivPower") then {
				_powerClusters = ALIVE_clustersCivPower select 2;
				_powerClusters = [_powerClusters,_sizeFilter,_priorityFilter] call ALIVE_fnc_copyClusters;
				_powerClusters = [_powerClusters, _taor] call ALIVE_fnc_clustersInsideMarker;
				_powerClusters = [_powerClusters, _blacklist] call ALIVE_fnc_clustersOutsideMarker;
				/*
				{
					[_x, "debug", [_logic, "debug"] call MAINCLASS] call ALIVE_fnc_cluster;
				} forEach _powerClusters;
				*/
			};
			
            if !(isnil "ALIVE_clustersCivComms") then {
				_commsClusters = ALIVE_clustersCivComms select 2;
				_commsClusters = [_commsClusters,_sizeFilter,_priorityFilter] call ALIVE_fnc_copyClusters;
				_commsClusters = [_commsClusters, _taor] call ALIVE_fnc_clustersInsideMarker;
				_commsClusters = [_commsClusters, _blacklist] call ALIVE_fnc_clustersOutsideMarker;
				/*
				{
					[_x, "debug", [_logic, "debug"] call MAINCLASS] call ALIVE_fnc_cluster;
				} forEach _commsClusters;
				*/
			};
			
            if !(isnil "ALIVE_clustersCivMarine") then {
				_marineClusters = ALIVE_clustersCivMarine select 2;
				_marineClusters = [_marineClusters,_sizeFilter,_priorityFilter] call ALIVE_fnc_copyClusters;
				_marineClusters = [_marineClusters, _taor] call ALIVE_fnc_clustersInsideMarker;
				_marineClusters = [_marineClusters, _blacklist] call ALIVE_fnc_clustersOutsideMarker;
				/*
				{
					[_x, "debug", [_logic, "debug"] call MAINCLASS] call ALIVE_fnc_cluster;
				} forEach _marineClusters;
				*/
			};
			
            if !(isnil "ALIVE_clustersCivRail") then {
				_railClusters = ALIVE_clustersCivRail select 2;
				_railClusters = [_railClusters,_sizeFilter,_priorityFilter] call ALIVE_fnc_copyClusters;
				_railClusters = [_railClusters, _taor] call ALIVE_fnc_clustersInsideMarker;
				_railClusters = [_railClusters, _blacklist] call ALIVE_fnc_clustersOutsideMarker;
				/*
				{
					[_x, "debug", [_logic, "debug"] call MAINCLASS] call ALIVE_fnc_cluster;
				} forEach _railClusters;
				*/
			};
			
            if !(isnil "ALIVE_clustersCivFuel") then {
				_fuelClusters = ALIVE_clustersCivFuel select 2;
				_fuelClusters = [_fuelClusters,_sizeFilter,_priorityFilter] call ALIVE_fnc_copyClusters;
				_fuelClusters = [_fuelClusters, _taor] call ALIVE_fnc_clustersInsideMarker;
				_fuelClusters = [_fuelClusters, _blacklist] call ALIVE_fnc_clustersOutsideMarker;
				/*
				{
					[_x, "debug", [_logic, "debug"] call MAINCLASS] call ALIVE_fnc_cluster;
				} forEach _fuelClusters;
				*/
			};
			
            if !(isnil "ALIVE_clustersCivConstruction") then {
				_constructionClusters = ALIVE_clustersCivConstruction select 2;
				_constructionClusters = [_constructionClusters,_sizeFilter,_priorityFilter] call ALIVE_fnc_copyClusters;
				_constructionClusters = [_constructionClusters, _taor] call ALIVE_fnc_clustersInsideMarker;
				_constructionClusters = [_constructionClusters, _blacklist] call ALIVE_fnc_clustersOutsideMarker;
				/*
				{
					[_x, "debug", [_logic, "debug"] call MAINCLASS] call ALIVE_fnc_cluster;
				} forEach _constructionClusters;
				*/
			};
			
            if !(isnil "ALIVE_clustersCivSettlement") then {
				_settlementClusters = ALIVE_clustersCivSettlement select 2;
				_settlementClusters = [_settlementClusters,_sizeFilter,_priorityFilter] call ALIVE_fnc_copyClusters;
				_settlementClusters = [_settlementClusters, _taor] call ALIVE_fnc_clustersInsideMarker;
				_settlementClusters = [_settlementClusters, _blacklist] call ALIVE_fnc_clustersOutsideMarker;
				/*
				{
					[_x, "debug", [_logic, "debug"] call MAINCLASS] call ALIVE_fnc_cluster;
				} forEach _settlementClusters;
				*/
			};
            
            [_logic, "objectivesHQ", _HQClusters] call MAINCLASS;
            [_logic, "objectivesPower", _powerClusters] call MAINCLASS;
            [_logic, "objectivesComms", _commsClusters] call MAINCLASS;
            [_logic, "objectivesMarine", _marineClusters] call MAINCLASS;
			[_logic, "objectivesRail", _railClusters] call MAINCLASS;
            [_logic, "objectivesFuel", _fuelClusters] call MAINCLASS;
            [_logic, "objectivesConstruction", _constructionClusters] call MAINCLASS;
            [_logic, "objectivesSettlement", _settlementClusters] call MAINCLASS;
            			
			// DEBUG -------------------------------------------------------------------------------------
			if(_debug) then {
				["ALIVE CP - Startup completed"] call ALIVE_fnc_dump;
				["ALIVE CP - Count clusters %1",count _clusters] call ALIVE_fnc_dump;
				["ALIVE CP - Count power clusters %1",count _powerClusters] call ALIVE_fnc_dump;
				["ALIVE CP - Count comms clusters %1",count _commsClusters] call ALIVE_fnc_dump;
				["ALIVE CP - Count marine clusters %1",count _marineClusters] call ALIVE_fnc_dump;		
				["ALIVE CP - Count rail clusters %1",count _railClusters] call ALIVE_fnc_dump;		
				["ALIVE CP - Count fuel clusters %1",count _fuelClusters] call ALIVE_fnc_dump;		
				["ALIVE CP - Count construction clusters %1",count _constructionClusters] call ALIVE_fnc_dump;		
				["ALIVE CP - Count settlement clusters %1",count _settlementClusters] call ALIVE_fnc_dump;
				[] call ALIVE_fnc_timer;
			};
			// DEBUG -------------------------------------------------------------------------------------
			
			if(_placement) then {
				if(count _clusters > 0) then {
					// start placement
					[_logic, "placement"] call MAINCLASS;
				}else{
					["ALIVE CP - Warning no usuable locations found for placement, you need to inlcude civilian locations within the TAOR marker"] call ALIVE_fnc_dumpR;
					// set module as started
					_logic setVariable ["startupComplete", true];
				};
			}else{
				_logic setVariable ["startupComplete", true];
			};
			
        };
	};
	// Placement
	case "placement": {		
        if (isServer) then {
			
			
			private ["_debug","_clusters","_cluster","_HQClusters","_powerClusters","_commsClusters","_marineClusters","_railClusters",
			"_fuelClusters","_constructionClusters","_settlementClusters","_countHQClusters","_countPowerClusters","_countCommsClusters",
			"_countMarineClusters","_countRailClusters","_countFuelClusters","_countConstructionClusters","_countSettlementClusters","_size","_type",
			"_faction","_ambientVehicleAmount","_placeHelis","_factionConfig","_factionSideNumber","_side","_countProfiles","_vehicleClass",
			"_position","_direction","_unitBlackist","_vehicleBlacklist","_groupBlacklist","_heliClasses","_nodes","_airClasses","_node"];
            
		
			_debug = [_logic, "debug"] call MAINCLASS;		
			
			// DEBUG -------------------------------------------------------------------------------------
			if(_debug) then {
				["----------------------------------------------------------------------------------------"] call ALIVE_fnc_dump;
				["ALIVE CP - Placement"] call ALIVE_fnc_dump;
				[true] call ALIVE_fnc_timer;
			};
			// DEBUG -------------------------------------------------------------------------------------			
			
		
            waituntil {sleep 5; (!(isnil {([_logic, "objectives"] call MAINCLASS)}) && {count ([_logic, "objectives"] call MAINCLASS) > 0})};
			
			_clusters = [_logic, "objectives"] call MAINCLASS;
			_HQClusters = [_logic, "objectivesHQ"] call MAINCLASS;
			_powerClusters = [_logic, "objectivesPower"] call MAINCLASS;
			_commsClusters = [_logic, "objectivesComms"] call MAINCLASS;
			_marineClusters = [_logic, "objectivesMarine"] call MAINCLASS;
			_railClusters = [_logic, "objectivesRail"] call MAINCLASS;
			_fuelClusters = [_logic, "objectivesFuel"] call MAINCLASS;
			_constructionClusters = [_logic, "objectivesConstruction"] call MAINCLASS;
			_settlementClusters = [_logic, "objectivesSettlement"] call MAINCLASS;			
			
			_countHQClusters = count _HQClusters;
			_countPowerClusters = count _powerClusters;
			_countCommsClusters = count _commsClusters;
			_countMarineClusters = count _marineClusters;
			_countRailClusters = count _railClusters;			
			_countFuelClusters = count _fuelClusters;			
			_countConstructionClusters = count _constructionClusters;			
			_countSettlementClusters = count _settlementClusters;			
			
			_size = parseNumber([_logic, "size"] call MAINCLASS);
			_type = [_logic, "type"] call MAINCLASS;
			_faction = [_logic, "faction"] call MAINCLASS;
			
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
			
			if(isNil "ALIVE_unitBlackist") then {
				_file = "\x\alive\addons\mil_placement\static\staticData.sqf";				
				call compile preprocessFileLineNumbers _file;
			};
			
			
			// Spawn the main force
			
			private ["_countArmored","_countMechanized","_countMotorized","_countInfantry",
			"_countAir","_groups","_group","_groupPerCluster","_totalCount","_center","_size","_position",
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
			
			// Force Composition			
			switch(_type) do {
				case "Armored": {					
					_countArmored = floor((_size / 20) * 0.5);
					_countMechanized = floor((_size / 12) * random(0.2));
					_countMotorized = floor((_size / 12) * random(0.2));
					_countInfantry = floor((_size / 10) * 0.5);
					_countAir = floor((_size / 30) * random(0.1));
				};
				case "Mechanized": {
					_countMechanized = floor((_size / 12) * 0.5);
					_countArmored = floor((_size / 20) * random(0.2));
					_countMotorized = floor((_size / 12) * random(0.2));
					_countInfantry = floor((_size / 10) * 0.5);
					_countAir = floor((_size / 30) * random(0.1));
				};
				case "Motorized": {
					_countMotorized = floor((_size / 12) * 0.5);
					_countMechanized = floor((_size / 12) * random(0.2));
					_countArmored = floor((_size / 20) * random(0.2));
					_countInfantry = floor((_size / 10) * 0.5);
					_countAir = floor((_size / 30) * random(0.1));
				};
				case "Infantry": {
					_countInfantry = floor((_size / 10) * 0.8);
					_countMotorized = floor((_size / 12) * random(0.2));
					_countMechanized = floor((_size / 12) * random(0.2));
					_countArmored = floor((_size / 20) * random(0.2));
					_countAir = floor((_size / 30) * random(0.1));
				};
				case "Air": {
					_countAir = floor((_size / 30) * 0.5);
					_countInfantry = floor((_size / 10) * 0.5);
					_countMotorized = floor((_size / 12) * random(0.2));
					_countMechanized = floor((_size / 12) * random(0.2));
					_countArmored = floor((_size / 20) * random(0.2));
				};
			};
			
			
			// DEBUG -------------------------------------------------------------------------------------
			if(_debug) then {
				["ALIVE CP [%1] - Main force creation ",_faction] call ALIVE_fnc_dump;
				["Count Armor: %1",_countArmored] call ALIVE_fnc_dump;
				["Count Mech: %1",_countMechanized] call ALIVE_fnc_dump;
				["Count Motor: %1",_countMotorized] call ALIVE_fnc_dump;
				["Count Air: %1",_countAir] call ALIVE_fnc_dump;
				["Count Infantry: %1",_countInfantry] call ALIVE_fnc_dump;
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
			
			for "_i" from 0 to _countMotorized -1 do {
				_group = ["Motorized",_faction] call ALIVE_fnc_configGetRandomGroup;
				if!(_group == "FALSE") then {
					_groups set [count _groups, _group];
				};
			};
			
			for "_i" from 0 to _countInfantry -1 do {
				_group = ["Infantry",_faction] call ALIVE_fnc_configGetRandomGroup;
				if!(_group == "FALSE") then {
					_groups set [count _groups, _group];
				}
			};
			
			for "_i" from 0 to _countAir -1 do {
				_group = ["Air",_faction] call ALIVE_fnc_configGetRandomGroup;
				if!(_group == "FALSE") then {
					_groups set [count _groups, _group];
				};
			};
			
			_groups = _groups - ALIVE_groupBlacklist;

			
			// Position and create groups
			_groupCount = count _groups;
			_clusterCount = count _clusters;
			_groupPerCluster = floor(_groupCount / _clusterCount);		
			_totalCount = 0;
			
			{
                private ["_guardGroup","_guards","_center","_size"];
                		
				_center = [_x, "center"] call ALIVE_fnc_hashGet;
				_size = [_x, "size"] call ALIVE_fnc_hashGet;
				
				_guardGroup = [ALIVE_factionDefaultGuards,_faction] call ALIVE_fnc_hashGet;                
                _guards = [_guardGroup, _center, random(360), true, _faction] call ALIVE_fnc_createProfilesFromGroupConfig;
				
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
			} forEach _clusters;
		
		
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