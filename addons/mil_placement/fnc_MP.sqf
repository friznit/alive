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
#define DEFAULT_TAOR []
#define DEFAULT_BLACKLIST []
#define DEFAULT_OBJECTIVES []
#define DEFAULT_OBJECTIVES_HQ []
#define DEFAULT_OBJECTIVES_AIR []
#define DEFAULT_OBJECTIVES_HELI []
#define DEFAULT_OBJECTIVES_VEHICLE []
#define DEFAULT_SIZE_FILTER "0"
#define DEFAULT_PRIORITY_FILTER "0"
#define DEFAULT_AMBIENT_VEHICLE_AMOUNT "1"

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
			// if server, initialise module game logic
			_logic setVariable ["super", SUPERCLASS];
			_logic setVariable ["class", MAINCLASS];
			_logic setVariable ["moduleType", "ALIVE_MP"];
			_logic setVariable ["startupComplete", false];
			TRACE_1("After module init",_logic);

			[_logic, "taor", _logic getVariable ["taor", DEFAULT_TAOR]] call MAINCLASS;
			[_logic, "blacklist", _logic getVariable ["blacklist", DEFAULT_TAOR]] call MAINCLASS;

			[_logic,"register"] call MAINCLASS;			
        };
	};
	case "register": {
		
			private["_registration","_moduleType"];
		
			_moduleType = _logic getVariable "moduleType";
			_registration = [_logic,_moduleType,["ALIVE_profileHandler"]];
	
			if(isNil "ALIVE_registry") then {
				ALIVE_registry = [nil, "create"] call ALIVE_fnc_registry;
				[ALIVE_registry, "init"] call ALIVE_fnc_registry;			
			};

			[ALIVE_registry,"register",_registration] call ALIVE_fnc_registry;
	};
	// Main process
	case "start": {
        if (isServer) then {
		
			private ["_debug","_worldName","_file","_clusters","_cluster","_taor","_taorClusters","_blacklist",
			"_sizeFilter","_priorityFilter","_blacklistClusters","_center"];
			
			_debug = [_logic, "debug"] call MAINCLASS;			
			
			// DEBUG -------------------------------------------------------------------------------------
			if(_debug) then {
				["----------------------------------------------------------------------------------------"] call ALIVE_fnc_dump;
				["ALIVE MP - Startup"] call ALIVE_fnc_dump;
				[true] call ALIVE_fnc_timer;
			};
			// DEBUG -------------------------------------------------------------------------------------
			
								
			if(isNil "ALIVE_clustersMil" && isNil "ALIVE_loadedMilClusters") then {
				_worldName = toLower(worldName);			
				_file = format["\x\alive\addons\mil_strategic\clusters\clusters.%1_mil.sqf", _worldName];				
				call compile preprocessFileLineNumbers _file;
				ALIVE_loadedMilClusters = true;
				
				// instantiate static vehicle position data
				if(isNil "ALIVE_groupConfig") then {
					[] call ALIVE_fnc_groupGenerateConfigData;
				};
			};
			
			
			_taor = [_logic, "taor"] call ALIVE_fnc_MP;
			_blacklist = [_logic, "blacklist"] call ALIVE_fnc_MP;
			_sizeFilter = parseNumber([_logic, "sizeFilter"] call ALIVE_fnc_MP);
			_priorityFilter = parseNumber([_logic, "priorityFilter"] call ALIVE_fnc_MP);
			
			
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
			
			
			private ["_HQClusters","_airClusters","_heliClusters","_vehicleClusters"];
			
			waituntil {!(isnil "ALIVE_clustersMilHQ") && {!(isnil "ALIVE_clustersMilAir")} && {!(isnil "ALIVE_clustersMilHeli")}};
            
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
				["ALIVE MP - Startup completed"] call ALIVE_fnc_dump;
				["ALIVE MP - Count clusters %1",count _clusters] call ALIVE_fnc_dump;
				["ALIVE MP - Count air clusters %1",count _airClusters] call ALIVE_fnc_dump;
				["ALIVE MP - Count heli clusters %1",count _heliClusters] call ALIVE_fnc_dump;		
				[] call ALIVE_fnc_timer;
			};
			// DEBUG -------------------------------------------------------------------------------------
			
			
			if(count _clusters > 0) then {
				// start placement
				[_logic, "placement"] call MAINCLASS;
			}else{
				["ALIVE MP - Warning no usuable locations found for placement, you need to inlcude military locations within the TAOR marker"] call ALIVE_fnc_dumpR;
				// set module as started
				_logic setVariable ["startupComplete", true];
			};
        };
	};
	// Placement
	case "placement": {
        if (isServer) then {
		
			private ["_debug","_clusters","_cluster","_HQClusters","_airClusters","_heliClusters","_vehicleClusters",
			"_countHQClusters","_countAirClusters","_countHeliClusters","_size","_type","_faction","_ambientVehicleAmount",
			"_factionConfig","_factionSideNumber","_side","_countProfiles","_vehicleClass","_position","_direction","_unitBlackist",
			"_vehicleBlacklist","_groupBlacklist","_heliClasses","_nodes","_airClasses","_node","_forceMax"];
            
		
			_debug = [_logic, "debug"] call MAINCLASS;		
			
			// DEBUG -------------------------------------------------------------------------------------
			if(_debug) then {
				["----------------------------------------------------------------------------------------"] call ALIVE_fnc_dump;
				["ALIVE MP - Placement"] call ALIVE_fnc_dump;
				[true] call ALIVE_fnc_timer;
			};
			// DEBUG -------------------------------------------------------------------------------------			
			
		
            waituntil {sleep 5; (!(isnil {([_logic, "objectives"] call MAINCLASS)}) && {count ([_logic, "objectives"] call MAINCLASS) > 0})};
			
			_clusters = [_logic, "objectives"] call MAINCLASS;
			_HQClusters = [_logic, "objectivesHQ"] call MAINCLASS;
			_airClusters = [_logic, "objectivesAir"] call MAINCLASS;
			_heliClusters = [_logic, "objectivesHeli"] call MAINCLASS;
			_vehicleClusters = [_logic, "objectivesVehicle"] call MAINCLASS;
			
			_countHQClusters = count _HQClusters;
			_countAirClusters = count _airClusters;
			_countHeliClusters = count _heliClusters;
			_countVehicleClusters = count _vehicleClusters;			
			
			_size = [_logic, "size"] call MAINCLASS;
			_type = [_logic, "type"] call MAINCLASS;
			_faction = [_logic, "faction"] call MAINCLASS;
			_ambientVehicleAmount = parseNumber([_logic, "ambientVehicleAmount"] call MAINCLASS);
			
			_factionConfig = (configFile >> "CfgFactionClasses" >> _faction);
			_factionSideNumber = getNumber(_factionConfig >> "side");
			_side = _factionSideNumber call ALIVE_fnc_sideNumberToText;
			_countProfiles = 0;
			
			//["Size: %1 Type: %2 SideNum: %3 Side: %4 Faction: %5",_size,_type,_factionSideNumber,_side,_faction] call ALIVE_fnc_dump;			
			//["Clusters hq:%1 a:%2 h:%3 v:%4", count _HQClusters, count _airClusters, count _heliClusters, count _vehicleClusters] call ALIVE_fnc_dump;
			
			_unitBlackist = ["O_UAV_AI","B_UAV_AI"];
			_vehicleBlacklist = ["O_UAV_02_F","O_UAV_02_CAS_F","O_UAV_01_F","O_UGV_01_F","O_UGV_01_rcws_F","B_UAV_01_F","B_UAV_02_F","B_UAV_02_CAS_F","B_UGV_01_F","B_UGV_01_rcws_F"];
			_groupBlacklist = ["HAF_AttackTeam_UAV","HAF_ReconTeam_UAV","HAF_AttackTeam_UGV","HAF_ReconTeam_UGV","HAF_SmallTeam_UAV",
			"BUS_AttackTeam_UAV","BUS_ReconTeam_UAV","BUS_AttackTeam_UGV","BUS_ReconTeam_UGV","BUS_SmallTeam_UAV",
			"OI_AttackTeam_UAV","OI_ReconTeam_UAV","OI_AttackTeam_UGV","OI_ReconTeam_UGV","OI_SmallTeam_UAV",
			"BUS_TankPlatoon_AA","BUS_MechInf_AA"];
			
			
			// Spawn helicopters on pads
			
			private ["_countCrewedHelis","_countUncrewedHelis"];
			_countCrewedHelis = 0;
			_countUncrewedHelis = 0;

						
			_heliClasses = [0,_faction,"Helicopter"] call ALiVE_fnc_findVehicleType;	
			_heliClasses = _heliClasses - _vehicleBlacklist;
			
			if(count _heliClasses > 0) then {
				{
					_nodes = [_x, "nodes"] call ALIVE_fnc_hashGet;
					//[_x, "debug", true] call ALIVE_fnc_cluster;
					{
						_position = position _x;
						_direction = direction _x;
						_vehicleClass = _heliClasses call BIS_fnc_selectRandom;
						if(random 1 > 0.8) then {
							[_vehicleClass,_side,_position,_direction,false,_faction] call ALIVE_fnc_createProfileVehicle;
							_countProfiles = _countProfiles + 1;
							_countUncrewedHelis =_countUncrewedHelis + 1;
						}else{
							[_vehicleClass,_side,"CAPTAIN",_position,_direction,false,_faction] call ALIVE_fnc_createProfilesCrewedVehicle;
							_countProfiles = _countProfiles + 2;
							_countCrewedHelis = _countCrewedHelis + 1;
						};
						
					} forEach _nodes;				
				} forEach _heliClusters;
			};
			
			
			// DEBUG -------------------------------------------------------------------------------------
			if(_debug) then {
				["ALIVE MP [%1] - Heli units placed: crewed:%2 uncrewed:%3",_faction,_countCrewedHelis,_countUncrewedHelis] call ALIVE_fnc_dump;
			};
			// DEBUG -------------------------------------------------------------------------------------
			
			
			// Spawn air units in hangars
			
			private ["_countAirUnits"];
			_countAirUnits = 0;
			
			if(_ambientVehicleAmount > 0) then {
			
				_airClasses = [0,_faction,"Plane"] call ALiVE_fnc_findVehicleType;			
				_airClasses = _airClasses - _vehicleBlacklist;
				_airClasses = _airClasses + _heliClasses;
				
				if(count _airClasses > 0) then {
				
					{
						_nodes = [_x, "nodes"] call ALIVE_fnc_hashGet;
						//[_x, "debug", true] call ALIVE_fnc_cluster;
						{
							_position = position _x;
							_direction = direction _x;
							_vehicleClass = _heliClasses call BIS_fnc_selectRandom;
							if(random 1 > 0.6) then {
								[_vehicleClass,_side,_position,_direction,false,_faction] call ALIVE_fnc_createProfileVehicle;
								_countProfiles = _countProfiles + 1;
								_countAirUnits = _countAirUnits + 1;
							};
						} forEach _nodes;				
					} forEach _airClusters;
				};
			};
			
			
			// DEBUG -------------------------------------------------------------------------------------
			if(_debug) then {
				["ALIVE MP [%1] - Air units placedin hangars: %2",_faction,_countAirUnits] call ALIVE_fnc_dump;
			};
			// DEBUG -------------------------------------------------------------------------------------
					
			
			// Spawn land units				
			
			private ["_countLandUnits"];
			_countLandUnits = 0;

			if(_ambientVehicleAmount > 0) then {
			
				_carClasses = [0,_faction,"Car"] call ALiVE_fnc_findVehicleType;
				_armorClasses = [0,_faction,"Tank"] call ALiVE_fnc_findVehicleType;
				_landClasses = _carClasses + _armorClasses;
				_landClasses = _landClasses - _vehicleBlacklist;
				
				if(count _landClasses > 0) then {
							
					{
						_parkingPositions = [_x, "parkingPositions"] call ALIVE_fnc_hashGet;
						_countParkingPositions = count _parkingPositions;
						
						_parkingChance = 0.1 * _ambientVehicleAmount;
						
						if(_countParkingPositions > 50) then {
							_parkingChance = 0.1 * _ambientVehicleAmount;
						};
						
						if(_countParkingPositions > 40 && _countParkingPositions < 50) then {
							_parkingChance = 0.2 * _ambientVehicleAmount;
						};
						
						if(_countParkingPositions > 30 && _countParkingPositions < 40) then {
							_parkingChance = 0.3 * _ambientVehicleAmount;
						};
						
						if(_countParkingPositions > 20 && _countParkingPositions < 30) then {
							_parkingChance = 0.4 * _ambientVehicleAmount;
						};
						
						if(_countParkingPositions > 10 && _countParkingPositions < 20) then {
							_parkingChance = 0.6 * _ambientVehicleAmount;
						};
						
						if(_countParkingPositions > 0 && _countParkingPositions < 10) then {
							_parkingChance = 0.7 * _ambientVehicleAmount;
						};
						
						//[_x, "debug", true] call ALIVE_fnc_cluster;
						{
							_position = _x select 0;
							_direction = _x select 1;
							_vehicleClass = _landClasses call BIS_fnc_selectRandom;
							if(random 1 < _parkingChance) then {
								[_vehicleClass,_side,_position,_direction,false,_faction] call ALIVE_fnc_createProfileVehicle;
								_countProfiles = _countProfiles + 1;
								_countLandUnits = _countLandUnits + 1;
							};
						} forEach _parkingPositions;				
					} forEach _clusters;
				};					
			};
			
			
			// DEBUG -------------------------------------------------------------------------------------
			if(_debug) then {
				["ALIVE MP [%1] - Ambient land units placed: %2",_faction,_countLandUnits] call ALIVE_fnc_dump;
			};
			// DEBUG -------------------------------------------------------------------------------------
			
			
			// Spawn the main force
			
			private ["_forceMax","_countArmored","_countMechanized","_countMotorized","_countInfantry",
			"_countAir","_groups","_group","_groupPerCluster","_totalCount","_center","_size","_position",
			"_groupCount","_clusterCount"];			
			
			// Force Strength
			_forceMax = 0;
			switch(_size) do {
				case "BN": {
					// Battalion (300-1200)
					_forceMax = 300 + random 900;
				};
				case "CY": {
					// Company (90-250)
					_forceMax = 90 + random 160;
				};
				case "PL": {
					// Platoon (30-50)
					_forceMax = 30 + random 20;					
				};
			};
			
			_countArmored = 0;
			_countMechanized = 0;
			_countMotorized = 0;
			_countInfantry = 0;
			_countAir = 0;
			
			// Force Composition			
			switch(_type) do {
				case "Armored": {					
					_countArmored = floor((_forceMax / 20) * 0.5);
					_countMechanized = floor((_forceMax / 12) * random(0.2));
					_countMotorized = floor((_forceMax / 12) * random(0.2));
					_countInfantry = floor((_forceMax / 10) * 0.5);
					_countAir = floor((_forceMax / 30) * random(0.1));
				};
				case "Mechanized": {
					_countMechanized = floor((_forceMax / 12) * 0.5);
					_countArmored = floor((_forceMax / 20) * random(0.2));
					_countMotorized = floor((_forceMax / 12) * random(0.2));
					_countInfantry = floor((_forceMax / 10) * 0.5);
					_countAir = floor((_forceMax / 30) * random(0.1));
				};
				case "Motorized": {
					_countMotorized = floor((_forceMax / 12) * 0.5);
					_countMechanized = floor((_forceMax / 12) * random(0.2));
					_countArmored = floor((_forceMax / 20) * random(0.2));
					_countInfantry = floor((_forceMax / 10) * 0.5);
					_countAir = floor((_forceMax / 30) * random(0.1));
				};
				case "Infantry": {
					_countInfantry = floor((_forceMax / 10) * 0.8);
					_countMotorized = floor((_forceMax / 12) * random(0.2));
					_countMechanized = floor((_forceMax / 12) * random(0.2));
					_countArmored = floor((_forceMax / 20) * random(0.2));
					_countAir = floor((_forceMax / 30) * random(0.1));
				};
				case "Air": {
					_countAir = floor((_forceMax / 30) * 0.5);
					_countInfantry = floor((_forceMax / 10) * 0.5);
					_countMotorized = floor((_forceMax / 12) * random(0.2));
					_countMechanized = floor((_forceMax / 12) * random(0.2));
					_countArmored = floor((_forceMax / 20) * random(0.2));
				};
			};
			
			
			// DEBUG -------------------------------------------------------------------------------------
			if(_debug) then {
				["ALIVE MP [%1] - Main force ceration ",_faction] call ALIVE_fnc_dump;
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
			
			_groups = _groups - _groupBlacklist;

			
			// Position and create groups
			_groupCount = count _groups;
			_clusterCount = count _clusters;
			_groupPerCluster = floor(_groupCount / _clusterCount);		
			_totalCount = 0;
			
			{
                private ["_grp","_center","_size"];
                		
				_center = [_x, "center"] call ALIVE_fnc_hashGet;
				_size = [_x, "size"] call ALIVE_fnc_hashGet;
                
                //Select guards (chose the group with most units, considering to create guard groupconfigs)
                switch (_faction) do {
                    case ("OPF_F") : {_grp = "OIA_InfSquad_Weapons"};
                    case ("IND_F") : {_grp = "HAF_InfSquad"};
                    case ("BLU_F") : {_grp = "BUS_InfSquad_Weapons"};
                    case ("BLU_G_F") : {_grp = "IRG_InfSquad_Weapons"};
                    default {_grp = ["Infantry",_faction] call ALIVE_fnc_configGetRandomGroup};
                };
                
                _guards = [_grp, _center, random(360), true, _faction] call ALIVE_fnc_createProfilesFromGroupConfig;
				
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
				["ALIVE MP - Total profiles created: %1",_countProfiles] call ALIVE_fnc_dump;
				["ALIVE MP - Placement completed"] call ALIVE_fnc_dump;
				[] call ALIVE_fnc_timer;
				["----------------------------------------------------------------------------------------"] call ALIVE_fnc_dump;
			};
			// DEBUG -------------------------------------------------------------------------------------
			
			
			// set module as started
			_logic setVariable ["startupComplete", true];
		};
	};
};

TRACE_1("MP - output",_result);
_result;
