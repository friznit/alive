//#define DEBUG_MODE_FULL
#include <\x\alive\addons\mil_strategic\script_component.hpp>
SCRIPT(SEP);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_SEP
Description:
Initial placement of enemy based on clustered targets within the AO.
In a persisted situation, the stance, etc would change during gameplay
and be persisted as well, restoring if the mission is restarted ie params
within editor module ignored.

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
[_logic, "faction", "OPF_F"] call ALiVE_fnc_SEP;

See Also:
- <ALIVE_fnc_SEPInit>

Author:
Wolffy
---------------------------------------------------------------------------- */

#define SUPERCLASS ALIVE_fnc_baseClass
#define MAINCLASS ALIVE_fnc_SEP
#define MTEMPLATE "ALiVE_SEP_%1"
#define DEFAULT_TARGETS QUOTE(ALL)
#define DEFAULT_SIZE QUOTE(CY)
#define DEFAULT_TYPE QUOTE(RANDOM)
#define DEFAULT_FACTION QUOTE(OPF_F)
#define DEFAULT_OBJECTIVES []
#define DEFAULT_TAOR QUOTE("""")
#define DEFAULT_BLACKLIST QUOTE("""")

private ["_logic","_operation","_args","_createMarkers","_deleteMarkers","_result","_hq_loc","_types","_clusters_tmp","_hq_loc_array","_clusters_air2","_clusters_heli2","_size","_type","_veh_obj_array"];

TRACE_1("SEP - input",_this);

_logic = [_this, 0, objNull, [objNull]] call BIS_fnc_param;
_operation = [_this, 1, "", [""]] call BIS_fnc_param;
_args = [_this, 2, objNull, [objNull,[],"",0,true,false]] call BIS_fnc_param;
_result = true;

_deleteMarkers = {
	/*
	private ["_logic"];
	_logic = _this;
	{
		deleteMarkerLocal _x;
	} forEach (_logic getVariable ["debugMarkers", []]);
	*/
};

_createMarkers = {
	/*
	private ["_logic","_markers","_m","_max","_nodes","_center"];
	_logic = _this;
	_markers = [];
	_nodes = _logic getVariable ["nodes", []];
	
	if(count _nodes > 0) then {
		// mark all nodes
		{
			_m = format[MTEMPLATE, _x];
			if(str getMarkerPos _m == "[0,0,0]") then {
				_m = createMarkerLocal [_m, getPosATL _x];
				_m setMarkerShapeLocal "Icon";
				_m setMarkerSizeLocal [0.5,0.5];
				_m setMarkerTypeLocal "mil_dot";
				_markers set [count _markers, _m];
			} else {
				_m setMarkerPosLocal (getPosATL _x);
			};
			_m setMarkerColorLocal (_logic getVariable ["debugColor","ColorYellow"]);
		} forEach _nodes;
		
		_center = [_logic, "center"] call MAINCLASS;
		_m = createMarkerLocal [format[MTEMPLATE, _logic], _center];
		_m setMarkerShapeLocal "Icon";
		_m setMarkerSizeLocal [1, 1];
		_m setMarkerTypeLocal "mil_dot";
		_m setMarkerColorLocal (_logic getVariable ["debugColor","ColorYellow"]);
		_m setMarkerTextLocal format[MTEMPLATE, _logic];
		_markers set [count _markers, _m];
		
		_m = createMarkerLocal [(format[MTEMPLATE, _logic] + "_size"), _center];
		_max = [_logic, "size"] call MAINCLASS;
		_m setMarkerShapeLocal "Ellipse";
		_m setMarkerSizeLocal [_max, _max];
		_m setMarkerColorLocal (_logic getVariable ["debugColor","ColorYellow"]);
		_m setMarkerAlphaLocal 0.5;
		_markers set [count _markers, _m];
		
		_logic setVariable ["debugMarkers", _markers];
	};
	*/
};

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
		_logic call _deleteMarkers;
		
		if(_args) then {
			//_logic call _createMarkers;
		};
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
			
			/*
			// nodes
			_data = [];
			{
				_data set [count _data, [
					_x call _findObjectID,
					position _x
				]];
			} forEach (_logic getVariable ["nodes",[]]);
			_result = [_state, "nodes", _data] call ALIVE_fnc_hashSet;
			*/
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
			
			/*
			// nodes
			_data = [];
			_nodes = [_args, "nodes"] call ALIVE_fnc_hashGet;
			{
				private["_node"];
				_node = (_x select 1) nearestObject (_x select 0);
				_data set [count _data, _node];
			} forEach _nodes;
			[_logic, "nodes", _data] call MAINCLASS;
			*/
		};		
	};        
	// Determine infrastructure targettings - valid values are: MIL, CIV and ALL
	case "targets": {
		_result = [_logic,_operation,_args,DEFAULT_TARGETS,["MIL","CIV","ALL"]] call ALIVE_fnc_OOsimpleOperation;
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
	// Return the objectives as an array of clusters
	case "objectives": {
		_result = [_logic,_operation,_args,DEFAULT_OBJECTIVES] call ALIVE_fnc_OOsimpleOperation;
	};
	// Return TAOR marker
	case "taor": {
		_result = [_logic,_operation,_args,DEFAULT_TAOR] call ALIVE_fnc_OOsimpleOperation;
	};
	// Return the Blacklist marker
	case "blacklist": {
		_result = [_logic,_operation,_args,DEFAULT_BLACKLIST] call ALIVE_fnc_OOsimpleOperation;
	};
	// Main process
	case "init": {
		private ["_obj_array","_clusters_hq","_clusters","_clusters_air","_clusters_heli","_clusters_veh"];
		/*
		MODEL - no visual just reference data
		- force size and composition
		- HQ and other forces locations
		- 
		*/
		
		// if server, initialise module game logic
		_logic setVariable ["super", SUPERCLASS];
		_logic setVariable ["class", MAINCLASS];
		TRACE_1("After module init",_logic);
		
		/*
		CONTROLLER  - coordination
		*/
		
		// Find HQ locations
		"SEP - Searching HQ locations" call ALiVE_fnc_logger;
		_types = [];
		if(([_logic, "targets"] call MAINCLASS) in ["MIL","ALL"]) then {
			_types = _types + ["barrack","cargo_hq_","miloffices","mil_house","mil_controltower"];
		};
		if(([_logic, "targets"] call MAINCLASS) in ["CIV","ALL"]) then {
			_types = _types + ["barrack","miloffices","mil_controltower","a_municipaloffice","a_office01","a_office02","airport_tower"];
		};
		_clusters_hq = [_logic, _types] call ALIVE_fnc_findTargets;
		{
			[_x, "type", "MIL"] call ALIVE_fnc_cluster;
			[_x, "priority", 50] call ALIVE_fnc_cluster;
			[_x, "debugColor", "ColorRed"] call ALIVE_fnc_hashSet;
		} forEach _clusters_hq;

		_clusters = +_clusters_hq;

		// Idenitfy targets with hangers for military fixed wing air
		// - Optionally use hangers for military vehicle assets
		// - Calculate number of fixed wing air assets
		"SEP - Searching airfield locations" call ALiVE_fnc_logger;
		_types = ["tenthangar","mil_hangar"];
		_clusters_air = [_logic, _types] call ALIVE_fnc_findTargets;
		{
			[_x, "type", "MIL"] call ALIVE_fnc_cluster;
			[_x, "priority", 20] call ALIVE_fnc_cluster;
			[_x, "debugColor", "ColorOrange"] call ALIVE_fnc_hashSet;
		} forEach _clusters_air;
		
		// Idenitfy targets with hangers for civilian fixed wing air
		// - Optionally use hangers for military vehicle assets
		// - Calculate number of fixed wing air assets
		_types = ["ss_hangar","hangar_2"];
		_clusters_air2 = [_logic, _types] call ALIVE_fnc_findTargets;
		{
			[_x, "type", "CIV"] call ALIVE_fnc_cluster;
			[_x, "priority", 10] call ALIVE_fnc_cluster;
			[_x, "debugColor", "ColorOrange"] call ALIVE_fnc_hashSet;
		} forEach _clusters_air2;
		// Consolidate all hangar clusters
		//_clusters_air = [_clusters_air,_clusters_air2] call ALIVE_fnc_consolidateClusters;
		// Consolidate hangar clusters with main clusters
		//_clusters = [_clusters, _clusters_air] call ALIVE_fnc_consolidateClusters;
		_clusters = _clusters + _clusters_air + _clusters_air2;
		_clusters = [_clusters] call ALIVE_fnc_consolidateClusters;

		// Idenitfy targets with helipads for military rotary wing air
		// - Calculate number of rotary wing air assets
		"SEP - Searching helipad locations" call ALiVE_fnc_logger;
		_types = ["helipadempty","helipadsquare","heli_h_army"];
		_clusters_heli = [_logic, _types] call ALIVE_fnc_findTargets;
		{
			[_x, "type", "MIL"] call ALIVE_fnc_cluster;
			[_x, "priority", 20] call ALIVE_fnc_cluster;
			[_x, "debugColor", "ColorYellow"] call ALIVE_fnc_hashSet;
		} forEach _clusters_heli;
		
		// Idenitfy targets with helipads for civilian rotary wing air
		// - Calculate number of rotary wing air assets
		_types = ["helipadempty","heli_h_civil","heli_h_rescue"];
		_clusters_heli2 = [_logic, _types] call ALIVE_fnc_findTargets;
		{
			[_x, "type", "CIV"] call ALIVE_fnc_cluster;
			[_x, "priority", 10] call ALIVE_fnc_cluster;
			[_x, "debugColor", "ColorYellow"] call ALIVE_fnc_hashSet;
		} forEach _clusters_heli2;
		// Consolidate all helipad clusters
		//_clusters_heli = [_clusters_heli,_clusters_heli2] call ALIVE_fnc_consolidateClusters;
		// Consolidate helipad clusters with main clusters
		//_clusters = [_clusters, _clusters_heli] call ALIVE_fnc_consolidateClusters;
		_clusters = _clusters + _clusters_heli + _clusters_heli2;
		_clusters = [_clusters] call ALIVE_fnc_consolidateClusters;

		// Identify targets with sheds for military vehicles assets
		// - Calculate number of military vehicles assets
		"SEP - Searching vehicle locations" call ALiVE_fnc_logger;
		_types = ["shed_big","shed_small"];
		_clusters_veh = [_logic, _types] call ALIVE_fnc_findTargets;
		{
			[_x, "type", "CIV"] call ALIVE_fnc_cluster;
			[_x, "priority", 10] call ALIVE_fnc_cluster;
			[_x, "debugColor", "ColorGreen"] call ALIVE_fnc_hashSet;
		} forEach _clusters_veh;
		//_clusters = [_clusters, _clusters_veh] call ALIVE_fnc_consolidateClusters;
		_clusters = _clusters + _clusters_veh;
		_clusters = [_clusters] call ALIVE_fnc_consolidateClusters;

		// Collate targets and their priorities
		"SEP - Searching military locations" call ALiVE_fnc_logger;
		if(([_logic, "targets"] call MAINCLASS) in ["MIL","ALL"]) then {
			// Military targets
			_types = [
				"bunker",
				"cargo_house_",
				"cargo_patrol_",
				"hbarrier",
				"mil_wall",
				"mil_wired",
				"razorwire"
			];
			_clusters_tmp = [_logic, _types] call ALIVE_fnc_findTargets;
			{
				[_x, "debugColor", "ColorGreen"] call ALIVE_fnc_hashSet;
			} forEach _clusters_tmp;
			//_clusters = [_clusters, _clusters_tmp] call ALIVE_fnc_consolidateClusters;
			_clusters = _clusters + _clusters_tmp;
			_clusters = [_clusters] call ALIVE_fnc_consolidateClusters;
		};

		"SEP - Searching civilian locations" call ALiVE_fnc_logger;
		if(([_logic, "targets"] call MAINCLASS) in ["CIV","ALL"]) then {                        
			// Civilian targets
			_types = [
				"airport_tower",
				"communication_f",
				"dp_",
				"fuel",
				"lighthouse_",
				"pier_f",
				"radar",
				"runway_beton",
				"runway_end",
				"runway_main",
				"runwayold",
				"spp_",
				"ttowerbig_",
				"valve"
			];
			_clusters_tmp = [_logic, _types] call ALIVE_fnc_findTargets;
			{
				[_x, "debugColor", "ColorOrange"] call ALIVE_fnc_hashSet;
			} forEach _clusters_tmp;
			//_clusters = [_clusters,_clusters_tmp] call ALIVE_fnc_consolidateClusters;
			_clusters = _clusters + _clusters_tmp;
			_clusters = [_clusters] call ALIVE_fnc_consolidateClusters;
		};

		"SEP - Consolidating Clusters" call ALiVE_fnc_logger;
		_clusters = [_clusters] call ALIVE_fnc_consolidateClusters;
		"SEP - Locations Completed" call ALiVE_fnc_logger;
		{
			[_x, "debug", [_logic, "debug"] call MAINCLASS] call ALIVE_fnc_cluster;
		} forEach _clusters;
		[_logic, "objectives", _clusters] call MAINCLASS;
		_result = _clusters;
/*
		diag_log _clusters;
		_force = ["#CBA_HASH#",
		["size","type","hq","subs"],
		["CY","MECH", "coy_hq", // "ARMOR","MECH","MOTOR","LIGHT","AIRBORNE","MARINE"
		["PL","MECH", "pl_hq", 
		[],
		["PL","MECH", "pl_hq",
		["PL","MECH", "pl_hq",
		["PL","MECH", "pl_hq", // for MECH, "ARMOR","MECH","MOTOR","LIGHT","AIRBORNE","MARINE"
		*/
		// Compose force 
		_size = [_logic, "size"] call MAINCLASS;
		_type = [_logic, "type"] call MAINCLASS;
		
		// TODO
		if(_size == "BN") then {
			switch(_type) do {
				//["ARMOR","MECH","MOTOR","LIGHT","AIRBORNE","MARINE"]
				case "BN": {
				};
			};
		};
		
		// Calculate remaining infantry for company
		// Randomly/appropriately choose remaining Platoons and their Squad make up
		// Place the entire PL somewhere and let them sort themselves out from there using OPCOM                
		
		switch(_size) do {
			case "BN": {
				/*
				// TODO
				// Find BN HQ location
				// - Confirm HQ loc is not outside TAOR or inside Blacklist - otherwise redo
				_hq_loc = [_obj_array, position _logic, 2500] call ALIVE_fnc_findHQ;
				// - Set HQ targets with the highest priority
				{
					if(_hq_loc in ([_x,"nodes"] call ALIVE_fnc_cluster)) then {
						[_x, "type", "MIL"] call ALIVE_fnc_cluster;
						[_x, "priority", 99] call ALIVE_fnc_cluster;
						[_x, "debugColor", "ColorBlack"] call ALIVE_fnc_hashSet;
						[_x, "debug", [_logic, "debug"] call MAINCLASS] call ALIVE_fnc_cluster;
					};
				} forEach _clusters_hq;
				
				// - Place and persist (TODO) clutter objects
				[_hq_loc] call ALIVE_fnc_randomFurnishings;
				
				// - Place BN HQ at location
				private["_m"];
				_m = createMarkerLocal ["hq_loc", position _hq_loc];
				_m setMarkerShapeLocal "Icon";
				_m setMarkerSizeLocal [3, 3];
				_m setMarkerTypeLocal "o_hq";
				[_logic, "debugMarkers", [_m]] call BIS_fnc_variableSpaceAdd;
				
				// - Consolidate HQ loc with targets
				*/
			};
			case "CY": {
/*
				// Continue to find Coy HQ location
				_hq_loc = [_hq_loc_array, position _logic, 2500] call ALIVE_fnc_findHQ;
				_hq_loc_array = _hq_loc_array - [_hq_loc];
				
				// - Place Coy HQ at location
				private["_m"];
				_m = createMarkerLocal ["hq_loc", position _hq_loc];
				_m setMarkerShapeLocal "Icon";
				_m setMarkerSizeLocal [2, 2];
				_m setMarkerTypeLocal "o_hq";
				[_logic, "debugMarkers", [_m]] call BIS_fnc_variableSpaceAdd;
				
				// - Set HQ targets with the next highest priority
				{
					if(_hq_loc in ([_x,"nodes"] call ALIVE_fnc_cluster)) then {
						[_x, "priority", 99] call ALIVE_fnc_cluster;
						[_x,"debugColor", "ColorBlack"] call ALIVE_fnc_hashSet;
						[_x, "debug"] call ALIVE_fnc_cluster;
					};
				} forEach _clusters;
				
				// - Place clutter objects
				// - Choose HQ squad
				switch(_type) do {
					case "ARMOR": {
					};
					case "MECH": {
						_pl1_loc = (_air_obj_array + _veh_obj_array) call BIS_fnc_selectRandom;
						
						{
							if(_pl1_loc in ([_x,"nodes"] call ALIVE_fnc_cluster)) then {
								[_x, "debugColor", "ColorBlack"] call ALIVE_fnc_hashSet;
								[_x, "debug", [_logic, "debug"] call MAINCLASS] call ALIVE_fnc_cluster;
							};
						} forEach _clusters;
						
						// - Place PL1 at location
						private["_m"];
						_m = createMarkerLocal ["pl1_loc", position _pl1_loc];
						_m setMarkerShapeLocal "Icon";
						_m setMarkerSizeLocal [1, 1];
						_m setMarkerTypeLocal "o_mech_inf";
						[_logic, "debugMarkers", [_m]] call BIS_fnc_variableSpaceAdd;
					};
					case "MOTOR": {
					};
					case "LIGHT": {
					};
					case "AIRBORNE": {
					};
					case "MARINE": {
					};
					case "BN": {
					};
				};
*/
				// - Consolidate HQ loc with targets
				// Repeat as required
			};
		};		
		// If fixed wing assets available
		// - Create squadron (offensive or transport)
		// - Place near hangers
		// If rotary wing assets available
		// - Create squadron (offensive or transport)
		// - Place on helipads
		// If military vehicles available
		// - Create platoons (offensive or transport)
		// - Place near sheds
		"SEP - Initialisation Completed" call ALiVE_fnc_logger;
		
		/*
		VIEW - purely visual
		*/
		
	};
};

TRACE_1("SEP - output",_result);
_result;
