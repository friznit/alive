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
	// Main process
	case "init": {
        if (isServer) then {
			// if server, initialise module game logic
			_logic setVariable ["super", SUPERCLASS];
			_logic setVariable ["class", MAINCLASS];
			_logic setVariable ["moduleType", "ALIVE_MI"];
			_logic setVariable ["startupComplete", false];
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
		
			private ["_debug","_modules","_module"];
			
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
			
			
			// DEBUG -------------------------------------------------------------------------------------
			if(_debug) then {
				["----------------------------------------------------------------------------------------"] call ALIVE_fnc_dump;
				["ALIVE MI - Startup completed"] call ALIVE_fnc_dump;
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
		
			private ["_debug","_modules","_module","_modulesObjectives","_moduleSide","_moduleEnemies","_moduleFriendly","_objectives"];
			
			_modules = _args;
			
			_debug = [_logic, "debug"] call MAINCLASS;
			_modulesObjectives = [];
			
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

			
			[_debug, _modulesObjectives] spawn {
				private ["_debug","_modulesObjectives","_intelligenceDelivered","_moduleSide","_moduleEnemies","_moduleFriendly",
				"_objectives","_id","_state","_danger","_tacom_state","_occupied"];
				
				_debug = _this select 0;
				_modulesObjectives = _this select 1;
				
				_intelligenceDelivered = [];
								
				waituntil {
					sleep (45 + random 20);
					
					{
						_moduleSide = _x select 0;
						_moduleEnemies = _x select 1;
						_moduleFriendly = _x select 2;
						_objectives = _x select 3;
						
						["Side: %1", _moduleSide] call ALIVE_fnc_dump;
						["Enemies: %1", _moduleEnemies] call ALIVE_fnc_dump;
						["Friends: %1", _moduleFriendly] call ALIVE_fnc_dump;
						
						_reserve = [];
						_recon = [];
						_capture = [];
												
						{
							//_x call ALIVE_fnc_inspectHash;
							/*
							_id = [_x,"objectiveID"] call ALIVE_fnc_hashGet;
							_state = [_x,"opcom_state"] call ALIVE_fnc_hashGet;
							_orders = [_x,"opcom_orders"] call ALIVE_fnc_hashGet;
							_danger = [_x,"danger"] call ALIVE_fnc_hashGet;
							*/
							
							_tacom_state = '';
							if("tacom_state" in (_x select 1)) then {
								_tacom_state = [_x,"tacom_state"] call ALIVE_fnc_hashGet;
							};
							
							switch(_tacom_state) do {
								case "reserve":{
									_reserved set [count _reserved, _x];
								};
								case "recon":{
									_recon set [count _recon, _x];
								};
								case "capture":{
									_capture set [count _capture, _x];
								};
							};
							
							["OBJ [%1] state: %2 orders: %3 danger: %4 tacom state: %5",_id,_state,_orders,_danger,_tacom_state] call ALIVE_fnc_dump;
							
						} forEach _objectives;
						
						_intelligenceSent = false;
						
						if(count _capture > 0) then {
							{
								_id = [_x,"objectiveID"] call ALIVE_fnc_hashGet;
								if!(_id in _intelligenceDelivered) then {
									["INTEL SENT"] call ALIVE_fnc_dump;
									_x call ALIVE_fnc_inspectHash;
									_intelligenceSent = true;
									_intelligenceDelivered set [count _intelligenceDelivered, _id];
								};
							} forEach _capture;							
						};
						
						if(count _recon > 0 && !(_intelligenceSent)) then {
							{
								_id = [_x,"objectiveID"] call ALIVE_fnc_hashGet;
								if!(_id in _intelligenceDelivered) then {
									["INTEL SENT"] call ALIVE_fnc_dump;
									_x call ALIVE_fnc_inspectHash;
									_intelligenceSent = true;
									_intelligenceDelivered set [count _intelligenceDelivered, _id];
								};
							} forEach _recon;							
						};
						
						if(count _reserved > 0 && !(_intelligenceSent)) then {
							{
								_id = [_x,"objectiveID"] call ALIVE_fnc_hashGet;
								if!(_id in _intelligenceDelivered) then {
									["INTEL SENT"] call ALIVE_fnc_dump;
									_x call ALIVE_fnc_inspectHash;
									_intelligenceSent = true;
									_intelligenceDelivered set [count _intelligenceDelivered, _id];
								};
							} forEach _reserved;							
						};						
						
					} forEach _modulesObjectives;
					
					["----------------------------------------------------------------------------------------"] call ALIVE_fnc_dump;
					
					false 
				};
			};
		};		
	};
};

TRACE_1("MI - output",_result);
_result;
