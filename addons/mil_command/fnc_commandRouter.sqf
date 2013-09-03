#include <\x\alive\addons\mil_command\script_component.hpp>
SCRIPT(commandRouter);

/* ----------------------------------------------------------------------------
Function: MAINCLASS
Description:
Command router for profile command system

Parameters:
Nil or Object - If Nil, return a new instance. If Object, reference an existing instance.
String - The selected function
Array - The selected parameters

Returns:
Any - The new instance or the result of the selected function and parameters

Attributes:
Boolean - debug - Debug enable, disable or refresh
Boolean - state - Store or restore state of analysis

Examples:
(begin example)
// create a sector
_logic = [nil, "create"] call ALIVE_fnc_commandRouter;

(end)

See Also:

Author:
ARJay

Peer reviewed:
nil
---------------------------------------------------------------------------- */

#define SUPERCLASS ALIVE_fnc_baseClassHash
#define MAINCLASS ALIVE_fnc_commandRouter

private ["_logic","_operation","_args","_result"];

TRACE_1("commandRouter - input",_this);

_logic = [_this, 0, objNull, [objNull,[]]] call BIS_fnc_param;
_operation = [_this, 1, "", [""]] call BIS_fnc_param;
_args = [_this, 2, objNull, [objNull,[],"",0,true,false]] call BIS_fnc_param;
_result = true;

#define MTEMPLATE "ALiVE_COMMAND_ROUTER_%1"

switch(_operation) do {
        case "init": {                
                /*
                MODEL - no visual just reference data
                - nodes
                - center
                - size
                */
                
                if (isServer) then {
                        // if server, initialise module game logic
						[_logic,"super"] call ALIVE_fnc_hashRem;
						[_logic,"class"] call ALIVE_fnc_hashRem;
                        TRACE_1("After module init",_logic);

						// set defaults
						[_logic,"commandState",[] call ALIVE_fnc_hashCreate] call ALIVE_fnc_hashSet;
                };
                
                /*
                VIEW - purely visual
                */
                
                /*
                CONTROLLER  - coordination
                */
        };
        case "destroy": {
                
                [_logic, "debug", false] call MAINCLASS;
                if (isServer) then {
                        // if server			
						[_logic,"super"] call ALIVE_fnc_hashRem;
						[_logic,"class"] call ALIVE_fnc_hashRem;
                        
                        [_logic, "destroy"] call SUPERCLASS;
                };
                
        };
        case "debug": {
                if(typeName _args != "BOOL") then {
						_args = [_logic,"debug", false] call ALIVE_fnc_hashGet;
                } else {
						[_logic,"debug",_args] call ALIVE_fnc_hashSet;
                };                
                _result = _args;
        };
		case "state": {
				private["_state"];
                
				if(typeName _args != "ARRAY") then {
						
						// Save state
				
                        _state = [] call ALIVE_fnc_hashCreate;
						
						{
							if(!(_x == "super") && !(_x == "class")) then {
								[_state,_x,[_logic,_x] call ALIVE_fnc_hashGet] call ALIVE_fnc_hashSet;
							};
						} forEach (_logic select 1);
                       
                        _result = _state;
						
                } else {
						ASSERT_TRUE(typeName _args == "ARRAY",str typeName _args);

                        // Restore state
                        {
							[_logic,_x,[_args,_x] call ALIVE_fnc_hashGet] call ALIVE_fnc_hashSet;
						} forEach (_args select 1);
                };
        };
		case "activate": {
				if(typeName _args == "ARRAY") then {
				
					private ["_profile","_commands","_profileID","_activeCommand","_commandName",
					"_commandType","_commandArgs","_handle"];
				
					_profile = _args select 0;
					_commands = _args select 1;
					
					_profileID = _profile select 2 select 4; //[_logic,"profileID"] call ALIVE_fnc_hashGet;
					
					_activeCommand = _commands select 0;
					_commandName = _activeCommand select 0;
					_commandType = _activeCommand select 1;
					_commandArgs = _activeCommand select 2;
					
					_commandState = _logic select 2 select 0;
					
					switch(_commandType) do {
						case "fsm": {
							_handle = [_profile, _commandArgs, true] execFSM format["\x\alive\addons\mil_command\%1.fsm",_commandName];
							[_commandState, _profileID, [_handle, _activeCommand]] call ALIVE_fnc_hashSet;
						};
						case "spawn": {
							_handle = [_profile, _commandArgs, true] spawn (call compile _commandName);
							[_commandState, _profileID, [_handle, _activeCommand]] call ALIVE_fnc_hashSet;
						};
					};
				
					// DEBUG -------------------------------------------------------------------------------------
					//if(_debug) then {
						["COMMAND Activate [%1]",_profileID] call ALIVE_fnc_dump;
					//};
					// DEBUG -------------------------------------------------------------------------------------
				};
        };
		case "deactivate": {
				if(typeName _args == "ARRAY") then {
				
					private ["_profile","_profileID","_commandState","_activeCommandState",
					"_handle","_activeCommand","_commandName","_commandType","_commandArgs"];
				
					_profile = _args;
					
					_profileID = _profile select 2 select 4; //[_logic,"profileID"] call ALIVE_fnc_hashGet;
					
					_commandState = _logic select 2 select 0;
					
					if(_profileID in (_commandState select 1)) then {
						_activeCommandState = [_commandState, _profileID] call ALIVE_fnc_hashGet;
						
						_handle = _activeCommandState select 0;
						_activeCommand = _activeCommandState select 1;
						_commandName = _activeCommand select 0;
						_commandType = _activeCommand select 1;
						_commandArgs = _activeCommand select 2;
						
						switch(_commandType) do {
							case "fsm": {
								if!(completedFSM _handle) then {
									_handle setFSMVariable ["_destroy",true];
								};
							};
							case "spawn": {
								if!(scriptDone _handle) then {
									terminate _handle;
								};
							};
						};
						
						[_commandState, _profileID] call ALIVE_fnc_hashRem;					
					
						// DEBUG -------------------------------------------------------------------------------------
						//if(_debug) then {
							["COMMAND Deactivate [%1]",_profileID] call ALIVE_fnc_dump;
						//};
						// DEBUG -------------------------------------------------------------------------------------
					};
				};
        };
        default {
                _result = [_logic, _operation, _args] call SUPERCLASS;
        };
};
TRACE_1("commandRouter - output",_result);
_result;