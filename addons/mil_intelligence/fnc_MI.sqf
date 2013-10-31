//#define DEBUG_MPDE_FULL
#include <\x\alive\addons\mil_intelligence\script_component.hpp>
SCRIPT(MI);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_MI
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
[_logic, "debug", true] call ALiVE_fnc_MI;

See Also:
- <ALIVE_fnc_MIInit>

Author:
ARJay
---------------------------------------------------------------------------- */

#define SUPERCLASS ALIVE_fnc_baseClass
#define MAINCLASS ALIVE_fnc_MI
#define MTEMPLATE "ALiVE_MI_%1"
#define DEFAULT_INTEL_CHANCE "0.1"
#define DEFAULT_FRIENDLY_INTEL "NONE"

private ["_logic","_operation","_args","_result"];

TRACE_1("MI - input",_this);

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
	// Return the Intel Chance
	case "intelChance": {
		_result = [_logic,_operation,_args,DEFAULT_INTEL_CHANCE] call ALIVE_fnc_OOsimpleOperation;
	};
	// Return the Friendly Intel
    case "friendlyIntel": {
        _result = [_logic,_operation,_args,DEFAULT_FRIENDLY_INTEL] call ALIVE_fnc_OOsimpleOperation;
    };
	// Main process
	case "init": {
        if (isServer) then {
			// if server, initialise module game logic
			_logic setVariable ["super", SUPERCLASS];
			_logic setVariable ["class", MAINCLASS];
			_logic setVariable ["moduleType", "ALIVE_MI"];
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
				["ALIVE MI - Startup"] call ALIVE_fnc_dump;
			};
			// DEBUG -------------------------------------------------------------------------------------
				
				
			_modules = [];
					
			for "_i" from 0 to ((count synchronizedObjects _logic)-1) do {
				_module = (synchronizedObjects _logic) select _i;
				_module = _module getVariable "handler";
				_modules set [count _modules, _module];
			};
						
			// if grid profile analysis is running with plot sectors, turn off plot sectors
			_activeAnalysisJobs = [ALIVE_liveAnalysis, "getAnalysisJobs"] call ALIVE_fnc_liveAnalysis;
			
			if("gridProfileEntity" in (_activeAnalysisJobs select 1)) then {
				_gridProfileAnalysis = [_activeAnalysisJobs, "gridProfileEntity"] call ALIVE_fnc_hashGet;
				_args = [_gridProfileAnalysis, "args"] call ALIVE_fnc_hashGet;
				_args set [4, [false]];
				// clear the sector data plot
				[ALIVE_sectorPlotter, "clear"] call ALIVE_fnc_plotSectors;
			};
			
			
			// DEBUG -------------------------------------------------------------------------------------
			if(_debug) then {
				["ALIVE MI - Startup completed"] call ALIVE_fnc_dump;
				["----------------------------------------------------------------------------------------"] call ALIVE_fnc_dump;
			};
			// DEBUG -------------------------------------------------------------------------------------
			
			
			_logic setVariable ["startupComplete", true];
			
			if(count _modules > 0) then {
				[_logic, "monitor", _modules] call MAINCLASS;			
			}else{
				["ALIVE MI - Warning no OPCOM modules synced to Military Intelligence module, nothing to do.."] call ALIVE_fnc_dumpR;
			};					
        };
	};
	// Main process
	case "monitor": {
        if (isServer) then {
		
			private ["_debug","_intelligenceChance","_friendlyIntel","_intelligenceObtained","_modules","_module","_modulesObjectives","_moduleSide","_moduleEnemies","_moduleFriendly","_objectives"];
			
			_modules = _args;
			
			_debug = [_logic, "debug"] call MAINCLASS;
			_intelligenceChance = parseNumber([_logic, "intelChance"] call MAINCLASS);
			_friendlyIntel = parseNumber([_logic, "friendlyIntel"] call MAINCLASS);
			
			_intelligenceObtained = _logic getVariable "intelligenceObtained";
			_modulesObjectives = [];
			
			// get objectives and modules settings from syncronised OPCOM instances
			{
				_module = _x;
				_moduleSide = [_module,"side"] call ALiVE_fnc_HashGet;
				_moduleEnemies = [_module,"sidesenemy"] call ALiVE_fnc_HashGet;
				_moduleFriendly = [_module,"sidesfriendly"] call ALiVE_fnc_HashGet;
				
				_objectives = [];

				waituntil {
					sleep 10;
					_objectives = nil;
					_objectives = [_module,"objectives"] call ALIVE_fnc_hashGet;
					(!(isnil "_objectives") && {count _objectives > 0})
				};
				
				_modulesObjectives set [count _modulesObjectives, [_moduleSide,_moduleEnemies,_moduleFriendly,_objectives]];
				
			} forEach _modules;

			// spawn monitoring loop
			
			[_logic, _debug, _modulesObjectives, _intelligenceObtained, _intelligenceChance] spawn {
			
				private ["_debug","_modulesObjectives","_intelligenceObtained","_intelligenceChance","_moduleSide",
						"_moduleEnemies","_moduleFriendly","_objectives","_intelComplete","_itemComplete","_id","_state","_danger","_tacom_state","_occupied",
						"_reserve","_recon","_capture","_intelligenceAvailable","_intelligenceAdded","_objective","_center","_sector"];
				
				_logic = _this select 0;
				_debug = _this select 1;
				_modulesObjectives = _this select 2;
				_intelligenceObtained = _this select 3;
				_intelligenceChance = _this select 4;
								
				waituntil {
					sleep (25 + random 20);
					
					{
						_moduleSide = _x select 0;
						_moduleEnemies = _x select 1;
						_moduleFriendly = _x select 2;
						_objectives = _x select 3;
						
						// reset intel once all objectives completed
						if(count (_intelligenceObtained select 2) == count _objectives) then {
							_intelComplete = true;
							{					
								_itemComplete = _x select 5;
								if!(_itemComplete) then {
									_intelComplete = false;
								};
							} forEach (_intelligenceObtained select 2);
							
							if(_intelComplete) then {
							
								
								// DEBUG -------------------------------------------------------------------------------------
								if(_debug) then {
									["----------------------------------------------------------------------------------------"] call ALIVE_fnc_dump;
									["ALIVE MI - intel run completed, reset"] call ALIVE_fnc_dump;
								};
								// DEBUG -------------------------------------------------------------------------------------
								

								_intelligenceObtained = [] call ALIVE_fnc_hashCreate;
							};
						};
						
						/*
						["Side: %1", _moduleSide] call ALIVE_fnc_dump;
						["Enemies: %1", _moduleEnemies] call ALIVE_fnc_dump;
						["Friends: %1", _moduleFriendly] call ALIVE_fnc_dump;
						*/
						
						_reserve = [];
						_recon = [];
						_capture = [];
						
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
									_reserve set [count _reserve, [_moduleSide, _moduleEnemies, _moduleFriendly, _x]];
								};
								case "recon":{
									_recon set [count _recon, [_moduleSide, _moduleEnemies, _moduleFriendly, _x]];
								};
								case "capture":{
									_capture set [count _capture, [_moduleSide, _moduleEnemies, _moduleFriendly, _x]];
								};
							};
							
						} forEach _objectives;
						
						
						// DEBUG -------------------------------------------------------------------------------------
						if(_debug) then {
							["----------------------------------------------------------------------------------------"] call ALIVE_fnc_dump;
							["ALIVE MI - reserved: %1 recon: %2 capture: %3 for side %4", count _reserve, count _recon, count _capture, _moduleSide] call ALIVE_fnc_dump;
						};
						// DEBUG -------------------------------------------------------------------------------------
						
						
						_intelligenceAvailable = true;
						_intelligenceAdded = [];
						
						// if chance of gathering intelligence passes
						// loop through sorted objectives until a not
						// delivered intelligence item is found
						if(_intelligenceChance > random 1) then {
						
							_maxItems = 2 + floor(random 5);
						
						
							// DEBUG -------------------------------------------------------------------------------------
							if(_debug) then {
								["ALIVE MI - Intelligence chance dice roll succeeded -  max intel items: %1",_maxItems] call ALIVE_fnc_dump;
							};
							// DEBUG -------------------------------------------------------------------------------------
							
							
							private ["_sectorData","_entitiesBySide","_entitiesSide"];
						
							if(count _capture > 0 && (count _intelligenceAdded < _maxItems)) then {
								{
									_objective = _x select 3;
									_id = [_objective,"objectiveID"] call ALIVE_fnc_hashGet;
									_section = [_objective,"section"] call ALIVE_fnc_hashGet;
									_center = [_objective,"center"] call ALIVE_fnc_hashGet;
									_sector = [ALIVE_sectorGrid, "positionToSector", _center] call ALIVE_fnc_sectorGrid;
									_sectorData = [_sector, "data"] call ALIVE_fnc_hashGet;		

									if("entitiesBySide" in (_sectorData select 1)) then {								
										
										_entitiesBySide = [_sectorData, "entitiesBySide"] call ALIVE_fnc_hashGet;
										_entitiesSide = [_entitiesBySide, _moduleSide] call ALIVE_fnc_hashGet;
										
										if(count _entitiesSide > 0) then {
											if(!(_id in (_intelligenceObtained select 1)) && (count _intelligenceAdded < _maxItems)) then {
											
											
												// DEBUG -------------------------------------------------------------------------------------
												if(_debug) then {
													["ALIVE MI - Objective capture intel item generated"] call ALIVE_fnc_dump;
												};
												// DEBUG -------------------------------------------------------------------------------------
											
											
												_x set [count _x, _sector];
												_x set [count _x, false];
												_intelligenceAdded set [count _intelligenceAdded, _id];
												[_intelligenceObtained, _id , _x] call ALIVE_fnc_hashSet;
											};
										};
									};
								} forEach _capture;							
							};
							
							if(count _recon > 0 && (count _intelligenceAdded < _maxItems)) then {
								{
									_objective = _x select 3;
									_id = [_objective,"objectiveID"] call ALIVE_fnc_hashGet;
									_section = [_objective,"section"] call ALIVE_fnc_hashGet;
									_center = [_objective,"center"] call ALIVE_fnc_hashGet;
									_sector = [ALIVE_sectorGrid, "positionToSector", _center] call ALIVE_fnc_sectorGrid;
									_sectorData = [_sector, "data"] call ALIVE_fnc_hashGet;

									if("entitiesBySide" in (_sectorData select 1)) then {								
										
										_entitiesBySide = [_sectorData, "entitiesBySide"] call ALIVE_fnc_hashGet;
										_entitiesSide = [_entitiesBySide, _moduleSide] call ALIVE_fnc_hashGet;
										
										if(count _entitiesSide > 0) then {
											if(!(_id in (_intelligenceObtained select 1)) && (count _intelligenceAdded < _maxItems)) then {
											
												
												// DEBUG -------------------------------------------------------------------------------------
												if(_debug) then {
													["ALIVE MI - Objective recon intel item generated"] call ALIVE_fnc_dump;
												};
												// DEBUG -------------------------------------------------------------------------------------
											
											
												_x set [count _x, _sector];
												_x set [count _x, false];
												_intelligenceAdded set [count _intelligenceAdded, _id];
												[_intelligenceObtained, _id , _x] call ALIVE_fnc_hashSet;
											};
										};
									};
								} forEach _recon;							
							};
							
							if(count _reserve > 0 && (count _intelligenceAdded < _maxItems)) then {
								{
									_objective = _x select 3;
									_id = [_objective,"objectiveID"] call ALIVE_fnc_hashGet;
									_section = [_objective,"section"] call ALIVE_fnc_hashGet;
									_center = [_objective,"center"] call ALIVE_fnc_hashGet;
									_sector = [ALIVE_sectorGrid, "positionToSector", _center] call ALIVE_fnc_sectorGrid;
									_sectorData = [_sector, "data"] call ALIVE_fnc_hashGet;

									if("entitiesBySide" in (_sectorData select 1)) then {								
										
										_entitiesBySide = [_sectorData, "entitiesBySide"] call ALIVE_fnc_hashGet;
										_entitiesSide = [_entitiesBySide, _moduleSide] call ALIVE_fnc_hashGet;
										
										if(count _entitiesSide > 0) then {
											if(!(_id in (_intelligenceObtained select 1)) && (count _intelligenceAdded < _maxItems)) then {
											
												
												// DEBUG -------------------------------------------------------------------------------------
												if(_debug) then {
													["ALIVE MI - Objective reserve intel item generated"] call ALIVE_fnc_dump;
												};
												// DEBUG -------------------------------------------------------------------------------------
																								
											
												_x set [count _x, _sector];
												_x set [count _x, false];
												_intelligenceAdded set [count _intelligenceAdded, _id];
												[_intelligenceObtained, _id , _x] call ALIVE_fnc_hashSet;
											};
										};
									};
								} forEach _reserve;							
							};
							
							if(count _intelligenceAdded > 0) then {
								[_logic, "notifyIntelligenceItem", _intelligenceAdded] call MAINCLASS;
							};
						};
						
					} forEach _modulesObjectives;
					
					false 
				};
			};
		};		
	};
	case "notifyIntelligenceItem": {
		private ["_intelItems","_debug","_intelItemID","_intelligenceObtained","_intelItem","_sides","_objective",
		"_side","_command","_sector","_center","_type","_state","_grid","_details","_typeName","_sideText"];
						
		_intelItems = _args;
		
		_debug = [_logic, "debug"] call MAINCLASS;
		_intelligenceObtained = _logic getVariable "intelligenceObtained";
		
		{
			_intelItemID = _x;
			
			_intelItem = [_intelligenceObtained, _intelItemID] call ALIVE_fnc_hashGet;
			
			_side = _intelItem select 0;
			_sides = _intelItem select 1;
			_objective = _intelItem select 3;
			_sector = _intelItem select 4;
			
			_center = [_objective,"center"] call ALIVE_fnc_hashGet;
			_type = [_objective,"type"] call ALIVE_fnc_hashGet;
			_state = [_objective,"tacom_state"] call ALIVE_fnc_hashGet;
			_grid = mapGridPosition _center;
			
			// setup analysis and plotting job
			// analysis job will run every 45 seconds for 5 times
			
			[ALIVE_liveAnalysis, "registerAnalysisJob", [25, 5, "intelligenceItem", _intelItemID, [_intelItem]]] call ALIVE_fnc_liveAnalysis;
			
			// compile radio message text
			
			_details = "";
			
			switch(_type) do {
				case "MIL": {
					_typeName = "military objective";
				};
				case "CIV": {
					_typeName = "civilian objective";
				};
			};
			
			_sideText = [_side] call ALIVE_fnc_sideTextToLong;
			_details = format["New intel received, %1 forces ",_sideText];
			
			switch(_state) do {
				case "reserve": {
					_details = _details + format["sighted occupying %1", _typeName];
				};
				case "recon": {
					_details = _details + format["sighted near %1", _typeName];
				};
				case "capture": {
					_details = _details + format["are attacking %1", _typeName];
				};
			};
			
			_details = _details + format[" - coords: %1",_grid];

			
			// DEBUG -------------------------------------------------------------------------------------
			if(_debug) then {
				["Alive MI - Intel message: %1",_details] call ALIVE_fnc_dump;
			};
			// DEBUG -------------------------------------------------------------------------------------			
			
			
			{
				_side = [_x] call ALIVE_fnc_sideTextToObject;								
				_command = [_side,"HQ"];
				_command SideChat _details;
			} forEach _sides;
			
		} forEach _intelItems;		
	};
};

TRACE_1("MI - output",_result);
_result;
