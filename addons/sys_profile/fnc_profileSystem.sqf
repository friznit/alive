#include <\x\alive\addons\sys_profile\script_component.hpp>
SCRIPT(profileSystem);

/* ----------------------------------------------------------------------------
Function: MAINCLASS
Description:
Main class for profile system initialisation

Parameters:
Nil or Object - If Nil, return a new instance. If Object, reference an existing instance.
String - The selected function
Array - The selected parameters

Returns:
Any - The new instance or the result of the selected function and parameters

Attributes:
Boolean - debug - Debug enable, disable or refresh

Examples:
(begin example)
// create the 
_logic = [nil, "init"] call ALIVE_fnc_profileSystem;
(end)

See Also:

Author:
ARJay

Peer reviewed:
nil
---------------------------------------------------------------------------- */

#define SUPERCLASS ALIVE_fnc_baseClassHash
#define MAINCLASS ALIVE_fnc_profileSystem

private ["_logic","_operation","_args","_result"];

TRACE_1("profileSystem - input",_this);

_logic = [_this, 0, objNull, [objNull,[]]] call BIS_fnc_param;
_operation = [_this, 1, "", [""]] call BIS_fnc_param;
_args = [_this, 2, objNull, [objNull,[],"",0,true,false]] call BIS_fnc_param;
_result = true;

#define MTEMPLATE "ALiVE_PROFILESYSTEM_%1"

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
						// nil these out they add a lot of code to the hash..
						[_logic,"super"] call ALIVE_fnc_hashRem;
						[_logic,"class"] call ALIVE_fnc_hashRem;
                        //TRACE_1("After module init",_logic);
						["PROFILE SYSTEM"] call ALIVE_fnc_dump;						
						
						// create sector grid
						ALIVE_sectorGrid = [nil, "create"] call ALIVE_fnc_sectorGrid;
						[ALIVE_sectorGrid, "init"] call ALIVE_fnc_sectorGrid;
						[ALIVE_sectorGrid, "createGrid"] call ALIVE_fnc_sectorGrid;
						
						// import static map analysis to the grid
						[ALIVE_sectorGrid] call ALIVE_fnc_gridImportStaticMapAnalysis;
						
						// create the profile handler
						ALIVE_profileHandler = [nil, "create"] call ALIVE_fnc_profileHandler;
						[ALIVE_profileHandler, "init"] call ALIVE_fnc_profileHandler;
						
						// create profiles for all map units that dont have profiles
						[false] call ALIVE_fnc_createProfilesFromUnits;
						
						// turn on debug again to see the state of the profile handler, and set debug on all a profiles
						[ALIVE_profileHandler, "debug", true] call ALIVE_fnc_profileHandler;
						
						// run profile analysis
						[ALIVE_sectorGrid] call ALIVE_fnc_gridAnalysisProfileEntity;
						
						// start profile spawner with activation radius of 1000m and debug enabled
						[] spawn {[1000,false] call ALIVE_fnc_profileSpawner};
						
						// start simulation controller
						ALIVE_simulationController = [nil, "create"] call ALIVE_fnc_simulationController;
						[ALIVE_simulationController, "init"] call ALIVE_fnc_simulationController;
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
					[_logic, "destroy"] call SUPERCLASS;
                };                
        };
        case "debug": {
                if(typeName _args != "BOOL") then {
						_args = [_logic,"debug"] call ALIVE_fnc_hashGet;
                } else {
						[_logic,"debug",_args] call ALIVE_fnc_hashSet;
                };                
                ASSERT_TRUE(typeName _args == "BOOL",str _args);
                
                _result = _args;
        };
		case "state": {
				private["_state"];
                
				if(typeName _args != "ARRAY") then {
						
						// Save state
				
                        _state = [] call ALIVE_fnc_hashCreate;
						
						// BaseClassHash CHANGE 
						// loop the class hash and set vars on the state hash
						{
							if(!(_x == "super") && !(_x == "class")) then {
								[_state,_x,[_logic,_x] call ALIVE_fnc_hashGet] call ALIVE_fnc_hashSet;
							};
						} forEach (_logic select 1);
                       
                        _result = _state;
						
                } else {
						ASSERT_TRUE(typeName _args == "ARRAY",str typeName _args);

                        // Restore state
						
						// BaseClassHash CHANGE 
						// loop the passed hash and set vars on the class hash
                        {
							[_logic,_x,[_args,_x] call ALIVE_fnc_hashGet] call ALIVE_fnc_hashSet;
						} forEach (_args select 1);
                };
        };
        default {
                _result = [_logic, _operation, _args] call SUPERCLASS;
        };
};
TRACE_1("profileSystem - output",_result);
_result;