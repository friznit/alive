//#define DEBUG_MPDE_FULL
#include <\x\alive\addons\mil_placement\script_component.hpp>
SCRIPT(CMP);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_CMP
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
[_logic, "faction", "OPF_F"] call ALiVE_fnc_CMP;

See Also:
- <ALIVE_fnc_MPInit>

Author:
Wolffy
ARJay
---------------------------------------------------------------------------- */

#define SUPERCLASS ALIVE_fnc_baseClass
#define MAINCLASS ALIVE_fnc_CMP
#define MTEMPLATE "ALiVE_CMP_%1"
#define DEFAULT_FACTION QUOTE(OPF_F)
#define DEFAULT_SIZE "50"
#define DEFAULT_PRIORITY "50"
#define DEFAULT_NO_TEXT "0"

private ["_logic","_operation","_args","_result"];

TRACE_1("CMP - input",_this);

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
	case "faction": {
		_result = [_logic,_operation,_args,DEFAULT_FACTION,[] call BIS_fnc_getFactions] call ALIVE_fnc_OOsimpleOperation;
	};
	case "size": {
		_result = [_logic,_operation,_args,DEFAULT_SIZE] call ALIVE_fnc_OOsimpleOperation;
	};
	case "priority": {
		_result = [_logic,_operation,_args,DEFAULT_PRIORITY] call ALIVE_fnc_OOsimpleOperation;
	};
	// Main process
	case "init": {
        if (isServer) then {
			// if server, initialise module game logic
			_logic setVariable ["super", SUPERCLASS];
			_logic setVariable ["class", MAINCLASS];
			_logic setVariable ["moduleType", "ALIVE_CMP"];
			_logic setVariable ["startupComplete", false];
			TRACE_1("After module init",_logic);

            if !(["ALiVE_sys_profile"] call ALiVE_fnc_isModuleAvailable) exitwith {
                ["Profile System module not placed! Exiting..."] call ALiVE_fnc_DumpR;
                _logic setVariable ["startupComplete", true];
            };
            
            waituntil {!(isnil "ALiVE_ProfileHandler") && {[ALiVE_ProfileSystem,"startupComplete",false] call ALIVE_fnc_hashGet}};
            
            [_logic,"start"] call MAINCLASS;
            
        };
	};
	case "start": {
        if (isServer) then {
		
			private ["_debug"];
			
			_debug = [_logic, "debug"] call MAINCLASS;

			// DEBUG -------------------------------------------------------------------------------------
			if(_debug) then {
				["----------------------------------------------------------------------------------------"] call ALIVE_fnc_dump;
				["ALIVE CMP - Startup"] call ALIVE_fnc_dump;
				[true] call ALIVE_fnc_timer;
			};
			// DEBUG -------------------------------------------------------------------------------------
			
            // instantiate static vehicle position data
            if(isNil "ALIVE_groupConfig") then {
                [] call ALIVE_fnc_groupGenerateConfigData;
            };

            [_logic, "placement"] call MAINCLASS;
        };
	};
	// Placement
	case "placement": {
        if (isServer) then {
		
			private ["_debug","_customInfantryCount","_customMotorisedCount","_customMechanisedCount","_customArmourCount","_customSpecOpsCount",
			"_faction","_factionConfig","_factionSideNumber","_side","_countProfiles","_file","_size","_priority","_position","_moduleObject","_module","_objectiveName","_objective"];

			_debug = [_logic, "debug"] call MAINCLASS;
			
			// DEBUG -------------------------------------------------------------------------------------
			if(_debug) then {
				["----------------------------------------------------------------------------------------"] call ALIVE_fnc_dump;
				["ALIVE MP - Placement"] call ALIVE_fnc_dump;
				[true] call ALIVE_fnc_timer;
			};
			// DEBUG -------------------------------------------------------------------------------------

			_countInfantry = [_logic, "customInfantryCount"] call MAINCLASS;
            _countInfantry = parseNumber _countInfantry;

            _countMotorized = [_logic, "customMotorisedCount"] call MAINCLASS;
            _countMotorized = parseNumber _countMotorized;

            _countMechanized = [_logic, "customMechanisedCount"] call MAINCLASS;
            _countMechanized = parseNumber _countMechanized;

            _countArmored = [_logic, "customArmourCount"] call MAINCLASS;
            _countArmored = parseNumber _countArmored;

            _countSpecOps = [_logic, "customSpecOpsCount"] call MAINCLASS;
            _countSpecOps = parseNumber _countSpecOps;

			_faction = [_logic, "faction"] call MAINCLASS;
			_size = [_logic, "size"] call MAINCLASS;

			if(typeName _size == "STRING") then {
                _size = parseNumber _size;
            };

			_priority = [_logic, "priority"] call MAINCLASS;

			if(typeName _priority == "STRING") then {
                _priority = parseNumber _priority;
            };


			_factionConfig = (configFile >> "CfgFactionClasses" >> _faction);
			_factionSideNumber = getNumber(_factionConfig >> "side");
			_side = _factionSideNumber call ALIVE_fnc_sideNumberToText;
			_countProfiles = 0;
			_position = position _logic;
			
			
			// DEBUG -------------------------------------------------------------------------------------
			if(_debug) then {
			    ["ALIVE CMP [%1] - Size: %1 Priority: %2",_size,_priority] call ALIVE_fnc_dump;
				["ALIVE CMP [%1] - SideNum: %1 Side: %2 Faction: %3",_factionSideNumber,_side,_faction] call ALIVE_fnc_dump;
			};
			// DEBUG -------------------------------------------------------------------------------------			
			
			
			// Load static data
			
			if(isNil "ALiVE_STATIC_DATA_LOADED") then {
				_file = "\x\alive\addons\main\static\staticData.sqf";
				call compile preprocessFileLineNumbers _file;
			};

			// assign the objective to OPCOMS

            for "_i" from 0 to ((count synchronizedObjects _logic)-1) do {
                _moduleObject = (synchronizedObjects _logic) select _i;

                waituntil {_module = _moduleObject getVariable "handler"; !(isnil "_module")};
                _module = _moduleObject getVariable "handler";

                _objectiveName = format["CUSTOM_%1",floor((_position select 0) + (_position select 1))];
                _objective = [_objectiveName, _position, _size, "MIL", _priority];

                [_module,"addObjective",_objective] call ALiVE_fnc_OPCOM;
            };


			// Spawn the main force
			
			private ["_groups","_motorizedGroups","_infantryGroups","_group","_totalCount","_position",
			"_groupCount"];
			
			// DEBUG -------------------------------------------------------------------------------------
			if(_debug) then {
				["ALIVE CMP [%1] - Force creation ",_faction] call ALIVE_fnc_dump;
				["ALIVE CMP Count Armor: %1",_countArmored] call ALIVE_fnc_dump;
				["ALIVE CMP Count Mech: %1",_countMechanized] call ALIVE_fnc_dump;
				["ALIVE CMP Count Motor: %1",_countMotorized] call ALIVE_fnc_dump;
				["ALIVE CMP Count Infantry: %1",_countInfantry] call ALIVE_fnc_dump;
				["ALIVE CMP Count Spec Ops: %1",_countSpecOps] call ALIVE_fnc_dump;
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

			for "_i" from 0 to _countSpecOps -1 do {
                _group = ["SpecOps",_faction] call ALIVE_fnc_configGetRandomGroup;
                if!(_group == "FALSE") then {
                    _groups set [count _groups, _group];
                };
            };
			
			_groups = _groups - ALiVE_PLACEMENT_GROUPBLACKLIST;

			// DEBUG -------------------------------------------------------------------------------------
            if(_debug) then {
                ["ALIVE CMP [%1] - Groups ",_groups] call ALIVE_fnc_dump;
            };
            // DEBUG -------------------------------------------------------------------------------------

			
			// Position and create groups
			_groupCount = count _groups;
			_totalCount = 0;

			if(_groupCount > 0) then {
			
                for "_i" from 0 to _groupCount -1 do {

                    _group = _groups select _i;

                    _position = [position _logic, (random(200)), random(360)] call BIS_fnc_relPos;

                    if!(surfaceIsWater _position) then {

                        [_group, _position, random(360), false, _faction] call ALIVE_fnc_createProfilesFromGroupConfig;

                    };
                };
            }else{
                ["ALIVE CMP - Warning no usable groups found to use the faction used may be faulty."] call ALIVE_fnc_dumpR;
            };
            
			// DEBUG -------------------------------------------------------------------------------------
			if(_debug) then {
				["ALIVE CMP - Total profiles created: %1",_countProfiles] call ALIVE_fnc_dump;
				["ALIVE CMP - Placement completed"] call ALIVE_fnc_dump;
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