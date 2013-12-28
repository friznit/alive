//#define DEBUG_MODE_FULL
#include <\x\alive\addons\mil_intelligence\script_component.hpp>
SCRIPT(PSD);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_PSD
Description:
Sector Display

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
[_logic, "debug", true] call ALiVE_fnc_SD;

See Also:
- <ALIVE_fnc_PSDInit>

Author:
ARJay
---------------------------------------------------------------------------- */

#define SUPERCLASS ALIVE_fnc_baseClass
#define MAINCLASS ALIVE_fnc_PSD
#define MTEMPLATE "ALiVE_PSD_%1"

private ["_logic","_operation","_args","_result"];

TRACE_1("PSD - input",_this);

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
			_logic setVariable ["moduleType", "ALIVE_PSD"];
			_logic setVariable ["startupComplete", false];

			TRACE_1("After module init",_logic);

			//[_logic,"register"] call MAINCLASS;

            [_logic,"start"] call MAINCLASS;
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
		
			private ["_debug","_modules","_module","_activeAnalysisJobs","_activeAnalysis","_args"];
			
			_debug = [_logic, "debug"] call MAINCLASS;			
			
			
			// DEBUG -------------------------------------------------------------------------------------
			if(_debug) then {
				["----------------------------------------------------------------------------------------"] call ALIVE_fnc_dump;
				["ALIVE PSD - Startup"] call ALIVE_fnc_dump;
			};
			// DEBUG -------------------------------------------------------------------------------------

            if !(["ALiVE_sys_profile"] call ALiVE_fnc_isModuleAvailable) exitwith {
                ["Profile System module not placed! Exiting..."] call ALiVE_fnc_DumpR;
            };
            waituntil {!(isnil "ALIVE_liveAnalysis")};
						
			// if player analysis is running, turn on plot sectors
			_activeAnalysisJobs = [ALIVE_liveAnalysis, "getAnalysisJobs"] call ALIVE_fnc_liveAnalysis;
			
			if("activeSectors" in (_activeAnalysisJobs select 1)) then {
				_activeAnalysis = [_activeAnalysisJobs, "activeSectors"] call ALIVE_fnc_hashGet;
				_args = [_activeAnalysis, "args"] call ALIVE_fnc_hashGet;
				_args set [4, [true]];
			};
			
			
			// DEBUG -------------------------------------------------------------------------------------
			if(_debug) then {
				["ALIVE PSD - Startup completed"] call ALIVE_fnc_dump;
				["----------------------------------------------------------------------------------------"] call ALIVE_fnc_dump;
			};
			// DEBUG -------------------------------------------------------------------------------------
			
			
			_logic setVariable ["startupComplete", true];
        };
	};
};

TRACE_1("PSD - output",_result);
_result;
