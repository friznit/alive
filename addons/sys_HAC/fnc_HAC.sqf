#include <\x\alive\addons\sys_HAC\script_component.hpp>
SCRIPT(HAC);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_
Description:
XXXXXXXXXX

Parameters:
Nil or Object - If Nil, return a new instance. If Object, reference an existing instance.
String - The selected function
Array - The selected parameters

Returns:
Any - The new instance or the result of the selected function and parameters

Attributes:
Boolean - debug - Debug enabled
Boolean - enabled - Enabled or disable module

Parameters:
none

Description:
HAC Controller! Detailed description to follow

Examples:
[_logic, "active", true] call ALiVE_fnc_HAC;

See Also:
- <ALIVE_fnc_HAC_init>

Author:
Highhead
---------------------------------------------------------------------------- */
private ["_logic","_operation","_args"];

PARAMS_1(_logic);
DEFAULT_PARAM(1,_operation,"");
DEFAULT_PARAM(2,_args,nil);

switch(_operation) do {
        default {
                private["_err"];
                _err = format["%1 does not support %2 operation", _logic, _operation];
                ERROR_WITH_TITLE(str _logic,_err);
        };
        case "init": {
                /*
                MODEL - no visual just reference data
                - server side object only
				- enabled/disabled
                */
                
                // Ensure only one module is used
                if (isServer && !(isNil QMOD(HAC))) exitWith {
                        ERROR_WITH_TITLE(str _logic, localize "STR_ALIVE_HAC_ERROR1");
                };
                
                if (isServer) then {
                    // if server, initialise module game logic
                    MOD(HAC) = _logic;
                    MOD(HAC) setVariable ["super", SUPERCLASS];
                    MOD(HAC) setVariable ["class", ALIVE_fnc_HAC];

                    //create HAC logic & evaluate whether the Leader marker ("HAC_LStart") is on the map to set the startpos accordingly (default is map center)
                    _Mcenter = getArray (configFile >> "CfgWorlds" >> worldName >> "centerPosition");
					_Mcenter set [2,0];
                    _StartPos = _Mcenter;
                    
					if (["HAC_LStart"] call ALiVE_fnc_MarkerExists) then {
						_StartPos = getMarkerPos "HAC_LStart";
					};
                    
                    _group = createGroup EAST;
                	_logic = _group createUnit ["LOGIC", _StartPos, [], 0, "NONE"];
					[_logic] joinsilent _group;
					_logic setVariable ["class", ALiVE_fnc_HAC];
			
                    //Set default variables
                    _logic setvariable ["HAC_HQ_Debug", false];
					_logic setvariable ["HAC_HQ_DebugII",false];
					_logic setvariable ["HAC_HQ_IdleOrd", true];
					_logic setvariable ["HAC_BB_Debug", false];                            
					_logic setvariable ["HAC_HQ_CargoFind", 200];
					_logic setvariable ["HAC_HQ_Rush", true];
					_logic setvariable ["HAC_HQ_MAtt", true];
					_logic setvariable ["HAC_HQ_Personality", (MOD(HAC) getvariable ["HAC_HQ_Personality", "GENIUS"])];
					_logic setvariable ["HAC_HQ_SubAll", false];
					_logic setvariable ["HAC_HQ_SubSynchro", true];
					_logic setvariable ["HAC_HQ_ReSynchro", true];
					_logic setvariable ["HAC_BBa_HQs", [_logic]];
					_logic setvariable ["HAC_BB_Active", true];
					_logic setvariable ["HAC_BB_BBOnMap", false];
                    _logic setvariable ["HAC_HQ_Wait", 15];
                    
                    //Enable Debug
                    if (call compile (MOD(HAC) getvariable "HAC_HQ_Debug")) then {
	                    _logic setvariable ["HAC_BB_Debug", true];   
                        _logic setvariable ["HAC_HQ_Debug", true];
						_logic setvariable ["HAC_HQ_DebugII",true];
                    };
                    
                    //Add synchronized units from map
                    _logic synchronizeObjectsAdd (synchronizedObjects MOD(HAC));
                    
                    //Initialize Libraries
                    [_logic] call (compile preprocessfile "\x\alive\addons\sys_HAC\HAC_Library.sqf");
                    [_logic] call (compile preprocessfile "\x\alive\addons\sys_HAC\HAC_Vars.sqf");
                    
                    HAC_TACOM = _logic;
                    Publicvariable "HAC_TACOM";
                    
                    MOD(HAC) setVariable ["instances",[HAC_TACOM],true];
                    MOD(HAC) setVariable ["init", true, true];

                    // and publicVariable Main class to clients
                    publicVariable QMOD(HAC);
                    format["HAC Module init finished: Logic %1...", HAC_TACOM] call ALiVE_fnc_logger;
            } else {
                    // if client clean up client side game logics as they will transfer
                    // to servers on client disconnect
            };
                
		TRACE_2("After module init",MOD(HAC),MOD(HAC) getVariable "init");

                // and wait for game logic to initialise
                // TODO merge into lazy evaluation
                waitUntil {!isNil QMOD(HAC)};
                waitUntil {MOD(HAC) getVariable ["init", false]};
                
                /*
                CONTROLLER  - coordination
                - Start HAC Controller on Server
                */

				if (isServer) then {
	                waitUntil {MOD(HAC) getVariable ["init", false]};
					[HAC_TACOM, "active", true] call ALiVE_fnc_HAC;
                    format["HAC activated on logic %1...", HAC_TACOM] call ALiVE_fnc_logger;
				};
                
                /*
                VIEW - purely visual
                */
        };
        
        case "destroy": {
                if (isServer) then {
                        // if server
                        _logic setVariable ["super", nil];
                        _logic setVariable ["class", nil];
                        _logic setVariable ["init", nil];
                        // and publicVariable to clients
                        MOD(HAC) = _logic;
                        publicVariable QMOD(HAC);
                };
                
                if(!isDedicated && !isHC) then {
                        // TODO: remove 
                };
        };
        
	    case "personality": {
			if(isNil "_args") then {
				// if no new personality was provided return current setting
				_args = _logic getVariable ["HAC_HQ_Personality", "GENIUS"];
			} else {
				// if a new personality setting was provided set personality
				ASSERT_TRUE(typeName _args == "STRING",str typeName _args);
				_logic setVariable ["HAC_HQ_Personality", _args, true];
                [_logic] call A_Personality;
			};
			_args;
		};
        
        case "addGroups": {
			if(isNil "_args") then {
				// if no list was provided return current setting
				_args = synchronizedObjects _logic;
			} else {
				// if a list was provided add groups
				ASSERT_TRUE(typeName _args == "ARRAY",str typeName _args);
				
                {
                    _grpL = leader (group _x);
                    if !(_grpL in (synchronizedObjects _logic)) then {
                        _logic synchronizeObjectsAdd [_grpL];
                    };
                    
                } foreach _args;
                _args = synchronizedObjects _logic;
			};
			_args;
		};
        
        case "delGroups": {
			if(isNil "_args") then {
				// if no new list was provided return current setting
				_args = synchronizedObjects _logic;
			} else {
				// if a new list was provided remove groups
				ASSERT_TRUE(typeName _args == "ARRAY",str typeName _args);
			
                {
                    private ["_grp","_grpL"];
                    
                    if (typename _x == "GROUP") then {
                        _grp = _x;
                        _grpL = leader _x;
                    } else {
                        _grp = group _x;
                        _grpL = leader (group _x);
                    };

                    if (_grpL in (synchronizedObjects _logic)) then {
                        _logic synchronizeObjectsRemove [_grpL];
                    };
                } foreach _args;
			};
			_args;
		};
        
		case "active": {
			if(isNil "_args") exitWith {
				_logic getVariable ["active", false];
			};
	
			ASSERT_TRUE(typeName _args == "BOOL",str _args);		
			
			// xor check args is different to current debug setting
			if(
				((_args || (_logic getVariable ["active", false])) &&
				!(_args && (_logic getVariable ["active", false])))
			) then {
				ASSERT_TRUE(typeName _args == "BOOL",str _args);
				_logic setVariable ["active", _args];
				
				// if active
				if (_args) then {
		                _logic setvariable ["HAC_BBa_InitDone", false];
						_logic setvariable ["HAC_BBa_Init", false];
	                    _logic setvariable ["HAC_xHQ_AllLeaders", (_logic getvariable ["HAC_xHQ_AllLeaders",[]]) + [_logic]];

                        [_logic] call ALiVE_fnc_HAC_Front;
						[[(_logic getvariable "HAC_BBa_HQs"),"A"],_logic] spawn Boss;
		                [_logic] spawn A_HQSitRep;
				}; // end if active
			};
		};
};
