//#define DEBUG_MPDE_FULL
#include <\x\alive\addons\mil_strategic\script_component.hpp>
SCRIPT(MP);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_MP
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
[_logic, "faction", "OPF_F"] call ALiVE_fnc_MP;

See Also:
- <ALIVE_fnc_MPInit>

Author:
Wolffy
---------------------------------------------------------------------------- */

#define SUPERCLASS ALIVE_fnc_baseClass
#define MAINCLASS ALIVE_fnc_MP
#define MTEMPLATE "ALiVE_MP_%1"
#define DEFAULT_SIZE QUOTE(CY)
#define DEFAULT_TYPE QUOTE(RANDOM)
#define DEFAULT_FACTION QUOTE(OPF_F)
#define DEFAULT_TAOR QUOTE("""")
#define DEFAULT_BLACKLIST QUOTE("""")
#define DEFAULT_OBJECTIVES []
#define DEFAULT_OBJECTIVES_HQ []
#define DEFAULT_OBJECTIVES_AIR []
#define DEFAULT_OBJECTIVES_HELI []
#define DEFAULT_OBJECTIVES_VEHICLE []

private ["_logic","_operation","_args","_result"];

TRACE_1("MP - input",_this);

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
		_result = [_logic,_operation,_args,DEFAULT_SIZE,["BN","PL","CY"]] call ALIVE_fnc_OOsimpleOperation;
	};
	// Determine type of enemy force - valid values are: RANDOM, ARMOR, MECH, MOTOR, LIGHT, AIRBORNE and MARINE
	case "type": {
		_result = [_logic,_operation,_args,DEFAULT_TYPE,["RANDOM","ARMOR","MECH","MOTOR","LIGHT","AIRBORNE","MARINE"]] call ALIVE_fnc_OOsimpleOperation;
		if(_result == "RANDOM") then {
			// Randomly pick an type
			_result = ["ARMOR","MECH","MOTOR","LIGHT","AIRBORNE","MARINE"] call BIS_fnc_selectRandom;
			_logic setVariable ["type", _result];
		};
	};
	// Determine force faction
	case "faction": {
		_result = [_logic,_operation,_args,DEFAULT_FACTION,[] call BIS_fnc_getFactions] call ALIVE_fnc_OOsimpleOperation;
	};
	// Return TAOR marker
	case "taor": {
		_result = [_logic,_operation,_args,DEFAULT_TAOR] call ALIVE_fnc_OOsimpleOperation;
	};
	// Return the Blacklist marker
	case "blacklist": {
		_result = [_logic,_operation,_args,DEFAULT_BLACKLIST] call ALIVE_fnc_OOsimpleOperation;
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
	// Return the Vehicle objectives as an array of clusters
	case "objectivesVehicle": {
		_result = [_logic,_operation,_args,DEFAULT_OBJECTIVES_VEHICLE] call ALIVE_fnc_OOsimpleOperation;
	};
	// Main process
	case "init": {
        if (isServer) then {
		
			private ["_worldName","_file","_clusters","_cluster","_taor","_taorClusters","_blacklist","_blacklistClusters","_center"];
								
			if(isNil "ALIVE_clustersMil") then {			
				_worldName = toLower(worldName);			
				_file = format["\x\alive\addons\fnc_strategic\clusters\clusters.%1_mil.sqf", _worldName];				
				call compile preprocessFileLineNumbers _file;
			};
			
			_taor = [_logic, "taor"] call ALIVE_fnc_MO;
			_blacklist = [_logic, "blacklist"] call ALIVE_fnc_MO;
			
			_clusters = ALIVE_clustersMil;
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
			
			
			private ["_HQClusters","_airClusters","_heliClusters","_vehicleClusters"];
			
			
			_HQClusters = ALIVE_clustersMilHQ;
			_HQClusters = [_HQClusters, _taor] call ALIVE_fnc_clustersInsideMarker;
			_HQClusters = [_HQClusters, _blacklist] call ALIVE_fnc_clustersOutsideMarker;
			/*
			{
				[_x, "debug", [_logic, "debug"] call MAINCLASS] call ALIVE_fnc_cluster;
			} forEach _HQClusters;
			*/
			[_logic, "objectivesHQ", _HQClusters] call MAINCLASS;			
			
			
			_airClusters = ALIVE_clustersMilAir;
			_airClusters = [_airClusters, _taor] call ALIVE_fnc_clustersInsideMarker;
			_airClusters = [_airClusters, _blacklist] call ALIVE_fnc_clustersOutsideMarker;
			/*
			{
				[_x, "debug", [_logic, "debug"] call MAINCLASS] call ALIVE_fnc_cluster;
			} forEach _airClusters;
			*/
			[_logic, "objectivesAir", _airClusters] call MAINCLASS;
			
			
			_heliClusters = ALIVE_clustersMilHeli;
			_heliClusters = [_heliClusters, _taor] call ALIVE_fnc_clustersInsideMarker;
			_heliClusters = [_heliClusters, _blacklist] call ALIVE_fnc_clustersOutsideMarker;
			/*
			{
				[_x, "debug", [_logic, "debug"] call MAINCLASS] call ALIVE_fnc_cluster;
			} forEach _heliClusters;
			*/
			[_logic, "objectivesHeli", _heliClusters] call MAINCLASS;
			
			
			_vehicleClusters = ALIVE_clustersMilVehicle;
			_vehicleClusters = [_vehicleClusters, _taor] call ALIVE_fnc_clustersInsideMarker;
			_vehicleClusters = [_vehicleClusters, _blacklist] call ALIVE_fnc_clustersOutsideMarker;
			/*
			{
				[_x, "debug", [_logic, "debug"] call MAINCLASS] call ALIVE_fnc_cluster;
			} forEach _vehicleClusters;
			*/
			[_logic, "objectivesVehicle", _vehicleClusters] call MAINCLASS;
			
        };
	};
};

TRACE_1("MP - output",_result);
_result;
