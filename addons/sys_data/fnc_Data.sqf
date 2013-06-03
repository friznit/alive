#include <\x\alive\addons\sys_Data\script_component.hpp>
SCRIPT(Data);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_Data
Description:
Provides a data interface for modules to read or write to/from.

Parameters:
Nil or Object - If Nil, return a new instance. If Object, reference an existing instance.
String - The selected function
Array - The selected parameters

Returns:
Any - The new instance or the result of the selected function and parameters

Attributes:
Boolean - debug - Debug enabled

Parameters:
none

Description:
Data Interface

Examples:
[_logic, "init"] call ALiVE_fnc_Data;

See Also:
- <ALIVE_fnc_Data_init>

Author:
Tupolov
---------------------------------------------------------------------------- */
private ["_logic","_operation","_args"];

#define SUPERCLASS ALIVE_fnc_baseClass
#define MAINCLASS ALIVE_fnc_Data

#define DATAOPERATIONS ["read","write","update","delete","load","save"]
#define DEFAULT_NAME QUOTE(alivedb)

private ["_logic","_operation","_args","_result"];

PARAMS_1(_logic);
DEFAULT_PARAM(1,_operation,"");
DEFAULT_PARAM(2,_args,nil);
TRACE_1("Data - input",_this);

_logic = [_this, 0, objNull, [objNull]] call BIS_fnc_param;
_operation = [_this, 1, "", [""]] call BIS_fnc_param;
_args = [_this, 2, objNull, [objNull,[],"",true,false]] call BIS_fnc_param;
_result = true;

switch(_operation) do {
	
        case "init": {                
                /*
                MODEL - no visual just reference data
                - server side object only
                - statistics enabled
                */
                
                if (isServer) then {

                        // if server, initialise module game logic
                        _logic setVariable ["super", SUPERCLASS];
                        _logic setVariable ["class", MAINCLASS];
                        _logic setVariable ["init", true, true];
						
						// Initialize debugging if set in the editor module
						if (_logic setVariable ["debug", false]) then {
							[_logic, "debug", true] call MAINCLASS;
						};
						
                } else {
                        // any client side logic
                };

				TRACE_2("After module init",_logic, _logic getVariable "init");

                // and wait for game logic to initialise
                // TODO merge into lazy evaluation
                waitUntil {!isNil _logic};
                waitUntil {_logic getVariable ["init", false]};        

                /*
                VIEW - purely visual
                - initialise menu
                - frequent check to modify menu and display status (ALIVE_fnc_adminActoinsmenuDef)
                */
                
                
                /*
                CONTROLLER  - coordination
                - frequent check if player is server admin (ALIVE_fnc_statisticsmenuDef)
                */
        };
		case "DatabaseName": {
			ASSERT_TRUE(typeName _args == "STRING", _args);
			if(typeName _args == "STRING") then { 
				_result = [_logic,_operation,_args,DEFAULT_NAME,[]] call ALIVE_fnc_OOsimpleOperation;
			} else {
				private["_err"];
                _err = format["%1 %2 operation requires a STRING as an argument not %3.", _logic, _operation, typeName _args];
                ERROR_WITH_TITLE(str _logic,_err);
			};
		};
		
		case (_operation in DATAOPERATIONS): {
			ASSERT_TRUE(typeName _args == "ARRAY", _args);
			if(typeName _args == "ARRAY") then {
				private ["_function"];
				_function = call compile (format ["ALIVE_fnc_%1Data_%2", _operation, _logic getVariable "source"]);
				_result = _args call _function;
			} else {
				private["_err"];
                _err = format["%1 %2 operation requires an ARRAY as an argument not %3.", _logic, _operation, typeName _args];
                ERROR_WITH_TITLE(str _logic,_err);
			};
		};
		
		case "debug": {
				ASSERT_TRUE(typeName _args == "BOOL",str _args);
                if(typeName _args != "BOOL") then {
                        _args = _logic getVariable ["debug", false];
                } else {
                        _logic setVariable ["debug", _args];
                };                

                if(_args) then {
                        // do some debugging
                };
                _result = _args;
        }; 
		
        case "destroy": {
                if (isServer) then {
					// if server
					_logic setVariable ["super", nil];
					_logic setVariable ["class", nil];
					_logic setVariable ["init", nil];
					_logic setVariable ["debug", false];
				};    
        };
		
        default {
                private["_err"];
                _err = format["%1 does not support %2 operation", _logic, _operation];
                ERROR_WITH_TITLE(str _logic,_err);
        };
};
TRACE_1("Data - output",_result);
_result;
