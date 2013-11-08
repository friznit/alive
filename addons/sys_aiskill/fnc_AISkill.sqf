//#define DEBUG_MODE_FULL
#include <\x\alive\addons\sys_aiskill\script_component.hpp>
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
- <ALIVE_fnc_AISkillInit>

Author:
ARJay
---------------------------------------------------------------------------- */

#define SUPERCLASS ALIVE_fnc_baseClass
#define MAINCLASS ALIVE_fnc_AISkill
#define MTEMPLATE "ALiVE_AISKILL_%1"

private ["_logic","_operation","_args","_result"];

TRACE_1("AISKILL - input",_this);

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
			_logic setVariable ["moduleType", "ALIVE_AISKill"];
			_logic setVariable ["startupComplete", false];

			[_logic, "skillFactionsRecruit", _logic getVariable ["skillFactionsRecruit", []]] call MAINCLASS;
			[_logic, "skillFactionsRegular", _logic getVariable ["skillFactionsRegular", []]] call MAINCLASS;
			[_logic, "skillFactionsVeteran", _logic getVariable ["skillFactionsVeteran", []]] call MAINCLASS;
			[_logic, "skillFactionsNinja", _logic getVariable ["skillFactionsNinja", []]] call MAINCLASS;
			[_logic, "customSkillFactions", _logic getVariable ["customSkillFactions", []]] call MAINCLASS;

			TRACE_1("After module init",_logic);

			[_logic,"register"] call MAINCLASS;			
        };
	};
	case "register": {
		
			private["_registration","_moduleType"];
		
			_moduleType = _logic getVariable "moduleType";
			_registration = [_logic,_moduleType,[]];
	
			if(isNil "ALIVE_registry") then {
				ALIVE_registry = [nil, "create"] call ALIVE_fnc_registry;
				[ALIVE_registry, "init"] call ALIVE_fnc_registry;
			};

			[ALIVE_registry,"register",_registration] call ALIVE_fnc_registry;
	};
    case "skillFactionsRecruit": {
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
        _result = _logic getVariable [_operation, []];
    };
    case "skillFactionsRegular": {
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
        _result = _logic getVariable [_operation, []];
    };
    case "skillFactionsVeteran": {
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
        _result = _logic getVariable [_operation, []];
    };
    case "skillFactionsNinja": {
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
        _result = _logic getVariable [_operation, []];
    };
    case "customSkillFactions": {
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
        _result = _logic getVariable [_operation, []];
    };
    case "customSkillAbilityMin": {
        _result = [_logic,_operation,_args,0] call ALIVE_fnc_OOsimpleOperation;
    };
    case "customSkillAbilityMax": {
        _result = [_logic,_operation,_args,0] call ALIVE_fnc_OOsimpleOperation;
    };
    case "customSkillAimAccuracy": {
        _result = [_logic,_operation,_args,0] call ALIVE_fnc_OOsimpleOperation;
    };
    case "customSkillAimShake": {
        _result = [_logic,_operation,_args,0] call ALIVE_fnc_OOsimpleOperation;
    };
    case "customSkillAimSpeed": {
        _result = [_logic,_operation,_args,0] call ALIVE_fnc_OOsimpleOperation;
    };
    case "customSkillEndurance": {
        _result = [_logic,_operation,_args,0] call ALIVE_fnc_OOsimpleOperation;
    };
    case "customSkillSpotDistance": {
        _result = [_logic,_operation,_args,0] call ALIVE_fnc_OOsimpleOperation;
    };
    case "customSkillSpotTime": {
        _result = [_logic,_operation,_args,0] call ALIVE_fnc_OOsimpleOperation;
    };
    case "customSkillCourage": {
        _result = [_logic,_operation,_args,0] call ALIVE_fnc_OOsimpleOperation;
    };
    case "customSkillReload": {
        _result = [_logic,_operation,_args,0] call ALIVE_fnc_OOsimpleOperation;
    };
    case "customSkillCommanding": {
        _result = [_logic,_operation,_args,0] call ALIVE_fnc_OOsimpleOperation;
    };
    case "customSkillGeneral": {
        _result = [_logic,_operation,_args,0] call ALIVE_fnc_OOsimpleOperation;
    };
	// Main process
	case "start": {
        if (isServer) then {

            _debug = [_logic, "debug"] call MAINCLASS;

			[_logic, _debug] spawn {

			    _logic = _this select 0;
                _debug = _this select 1;

			    _skillFactionsRecruit = [_logic, "skillFactionsRecruit"] call MAINCLASS;
                _skillFactionsRegular = [_logic, "skillFactionsRegular"] call MAINCLASS;
                _skillFactionsVeteran = [_logic, "skillFactionsVeteran"] call MAINCLASS;
                _skillFactionsNinja = [_logic, "skillFactionsNinja"] call MAINCLASS;
                _customSkillFactions = [_logic, "customSkillFactions"] call MAINCLASS;
                _customSkillAbilityMin = [_logic, "customSkillAbilityMin"] call MAINCLASS;
                _customSkillAbilityMax = [_logic, "customSkillAbilityMax"] call MAINCLASS;
                _customSkillAimAccuracy = [_logic, "customSkillAimAccuracy"] call MAINCLASS;
                _customSkillAimShake = [_logic, "customSkillAimShake"] call MAINCLASS;
                _customSkillAimSpeed = [_logic, "customSkillAimSpeed"] call MAINCLASS;
                _customSkillEndurance = [_logic, "customSkillEndurance"] call MAINCLASS;
                _customSkillSpotDistance = [_logic, "customSkillSpotDistance"] call MAINCLASS;
                _customSkillSpotTime = [_logic, "customSkillSpotTime"] call MAINCLASS;
                _customSkillCourage = [_logic, "customSkillCourage"] call MAINCLASS;
                _customSkillReload = [_logic, "customSkillReload"] call MAINCLASS;
                _customSkillCommanding = [_logic, "customSkillCommanding"] call MAINCLASS;
                _customSkillGeneral = [_logic, "customSkillGeneral"] call MAINCLASS;


                // DEBUG -------------------------------------------------------------------------------------
                if(_debug) then {
                    ["AISKILL Recruit:[%1] Regular:[%2] Veteran:[%3] Ninja:[%4]",_skillFactionsRecruit,_skillFactionsRegular,_skillFactionsVeteran,_skillFactionsNinja] call ALIVE_fnc_dump;
                    ["AISKILL Custom Skill: Factions:[%1]",_customSkillFactions] call ALIVE_fnc_dump;
                    ["AISKILL Custom Skill: Min Ability:%1 Max Ability:%2",_customSkillAbilityMin,_customSkillAbilityMax] call ALIVE_fnc_dump;
                    ["AISKILL Custom Skill: Aim Accuracy:%1 Aim Shake:%2 Aim Speed:%3",_customSkillAimAccuracy,_customSkillAimShake,_customSkillAimSpeed] call ALIVE_fnc_dump;
                    ["AISKILL Custom Skill: Courage:%1 Endurance:%2 Spot Distance:%3 Spot Time:%4",_customSkillCourage,_customSkillEndurance,_customSkillSpotDistance,_customSkillSpotTime] call ALIVE_fnc_dump;
                    ["AISKILL Custom Skill: Reload:%1 Commanding:%2 General:%3",_customSkillReload,_customSkillCommanding,_customSkillGeneral] call ALIVE_fnc_dump;
                };
                // DEBUG -------------------------------------------------------------------------------------


                // min abil, max abil, aim acc, aim shake, aim speed, end, sdist, stime, cour, reload, comm, gen
                _recruitSkill = [0.2,0.21,0.01,1,0.05,0.05,0.2,0.2,0.05,0.05,1,0.2];
                _regularSkill = [0.2,0.25,0.05,0.9,0.1,0.1,0.5,0.4,0.1,0.1,1,0.5];
                _veteranSkill = [0.2,0.3,0.1,0.75,0.2,0.2,0.75,0.6,0.2,0.2,1,0.6];
                _expertSkill = [0.3,0.4,0.2,0.55,0.45,0.45,0.85,0.7,0.45,0.45,1,0.75];
                _customSkill = [_customSkillAbilityMin,_customSkillAbilityMax,_customSkillAimAccuracy,_customSkillAimShake,_customSkillAimSpeed,_customSkillEndurance,
                _customSkillSpotDistance,_customSkillSpotTime,_customSkillCourage,_customSkillReload,_customSkillCommanding,_customSkillGeneral];

                _factionSkills = [] call ALIVE_fnc_hashCreate;

                {
                    [_factionSkills, _x, _recruitSkill] call ALIVE_fnc_hashSet;
                } forEach _skillFactionsRecruit;

                {
                    [_factionSkills, _x, _regularSkill] call ALIVE_fnc_hashSet;
                } forEach _skillFactionsRegular;

                {
                    [_factionSkills, _x, _veteranSkill] call ALIVE_fnc_hashSet;
                } forEach _skillFactionsVeteran;

                {
                    [_factionSkills, _x, _expertSkill] call ALIVE_fnc_hashSet;
                } forEach _skillFactionsNinja;

                {
                    [_factionSkills, _x, _customSkill] call ALIVE_fnc_hashSet;
                } forEach _customSkillFactions;


                // DEBUG -------------------------------------------------------------------------------------
                if(_debug) then {
                    ["AISKILL Faction Skill Hash:"] call ALIVE_fnc_dump;
                    _factionSkills call ALIVE_fnc_inspectHash;
                };
                // DEBUG -------------------------------------------------------------------------------------


			    waituntil {


                    {
                        _faction = faction _x;

                        _aimingAccuracy = _x skill "aimingAccuracy";
                        _aimingShake = _x skill "aimingShake";
                        _aimingSpeed = _x skill "aimingSpeed";

                        if(_faction in (_factionSkills select 1)) then {
                            _factionSkill = [_factionSkills,_faction] call ALIVE_fnc_hashGet;

                            if((_aimingAccuracy != _factionSkill select 2) && (_aimingShake != _factionSkill select 3) && (_aimingSpeed != _factionSkill select 4)) then {


                                // DEBUG -------------------------------------------------------------------------------------
                                if(_debug) then {
                                    ["AISKILL Setting unit skill:"] call ALIVE_fnc_dump;
                                };
                                // DEBUG -------------------------------------------------------------------------------------


                                _minSkill = _factionSkill select 0;
                                _maxSkill = _factionSkill select 1;
                                _diff = _maxSkill - _minSkill;

                                _x setUnitAbility (_minSkill + (random _diff));

                                _x setSkill ["aimingAccuracy", _factionSkill select 2];
                                _x setSkill ["aimingShake", _factionSkill select 3];
                                _x setSkill ["aimingSpeed", _factionSkill select 4];
                                _x setSkill ["endurance", _factionSkill select 5];
                                _x setSkill ["spotDistance", _factionSkill select 6];
                                _x setSkill ["spotTime", _factionSkill select 7];
                                _x setSkill ["courage", _factionSkill select 8];
                                _x setSkill ["reloadSpeed", _factionSkill select 9];
                                _x setSkill ["commanding", _factionSkill select 10];
                                _x setSkill ["general", _factionSkill select 11];

                                sleep 0.03;
                            };
                        };

                    } forEach allUnits;


                    sleep (30);

                    false

                };
			};

			_logic setVariable ["startupComplete", true];
        };
	};
};

TRACE_1("AISKILL - output",_result);
_result;