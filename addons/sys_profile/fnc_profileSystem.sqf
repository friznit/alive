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
						
						[_logic,"debug",false] call ALIVE_fnc_hashSet;
						[_logic,"spawnRadius",false] call ALIVE_fnc_hashSet;
                };
                
                /*
                VIEW - purely visual
                */
                
                /*
                CONTROLLER  - coordination
                */
        };
		case "start": {                
                
                if (isServer) then {
						
						_debug = [_logic,"debug",false] call ALIVE_fnc_hashGet;
						_spawnRadius = [_logic,"spawnRadius",false] call ALIVE_fnc_hashGet;
						
						// DEBUG -------------------------------------------------------------------------------------
						if(_debug) then {
							["----------------------------------------------------------------------------------------"] call ALIVE_fnc_dump;
							["ALIVE Profile system init"] call ALIVE_fnc_dump;
							[true] call ALIVE_fnc_timer;
						};
						// DEBUG -------------------------------------------------------------------------------------
						
						// create sector grid
						ALIVE_sectorGrid = [nil, "create"] call ALIVE_fnc_sectorGrid;
						[ALIVE_sectorGrid, "init"] call ALIVE_fnc_sectorGrid;
						[ALIVE_sectorGrid, "createGrid"] call ALIVE_fnc_sectorGrid;
						
						// create sector plotter
						ALIVE_sectorPlotter = [nil, "create"] call ALIVE_fnc_plotSectors;
						[ALIVE_sectorPlotter, "init"] call ALIVE_fnc_plotSectors;
						
						// import static map analysis to the grid
						[ALIVE_sectorGrid] call ALIVE_fnc_gridImportStaticMapAnalysis;
						
						// create the profile handler
						ALIVE_profileHandler = [nil, "create"] call ALIVE_fnc_profileHandler;
						[ALIVE_profileHandler, "init"] call ALIVE_fnc_profileHandler;
						
						// create profiles for all map units that dont have profiles
						[false] call ALIVE_fnc_createProfilesFromUnits;
						
						// turn on debug again to see the state of the profile handler, and set debug on all a profiles
						[ALIVE_profileHandler, "debug", _debug] call ALIVE_fnc_profileHandler;
						
						// create array block stepper
						ALIVE_arrayBlockHandler = [nil, "create"] call ALIVE_fnc_arrayBlockHandler;
						[ALIVE_arrayBlockHandler, "init"] call ALIVE_fnc_arrayBlockHandler;
						
						// run initial profile analysis
						[ALIVE_sectorGrid] call ALIVE_fnc_gridAnalysisProfileEntity;

						// DEBUG -------------------------------------------------------------------------------------
						if(_debug) then {
							["ALIVE Profile system init complete"] call ALIVE_fnc_dump;
							["ALIVE Sector grid created"] call ALIVE_fnc_dump;
							["ALIVE Profile handler created"] call ALIVE_fnc_dump;
							["ALIVE Map units converted to profiles"] call ALIVE_fnc_dump;
							["ALIVE Profile initial analysis complete"] call ALIVE_fnc_dump;
							["ALIVE Simulation controller created"] call ALIVE_fnc_dump;
							["ALIVE View controller created"] call ALIVE_fnc_dump;
							[] call ALIVE_fnc_timer;
							["----------------------------------------------------------------------------------------"] call ALIVE_fnc_dump;					
						};
						// DEBUG -------------------------------------------------------------------------------------
							
						// start the profile controller FSM
						/*
						_handle = [_logic,_spawnRadius] execFSM "\x\alive\addons\sys_profile\profileController.fsm";
						[_logic, "controller_FSM",_handle] call ALiVE_fnc_HashSet;
						*/
						
						_handle = [_logic] execFSM "\x\alive\addons\sys_profile\profileSimulator.fsm";
						//[_logic, "controller_FSM",_handle] call ALiVE_fnc_HashSet;
						
						_handle = [_logic,_spawnRadius] execFSM "\x\alive\addons\sys_profile\profileSpawner.fsm";
						//[_logic, "controller_FSM",_handle] call ALiVE_fnc_HashSet;
												
						
						// start profile simulation with debug enabled
						/*
						[_debug] spawn {
							_debug = _this select 0;
							[_debug] call ALIVE_fnc_simulateProfileMovement
						};
						*/
						
						/*
						// start profile spawner with activation radius of 1000m and debug enabled
						[] spawn {[1000,false] call ALIVE_fnc_profileSpawner};
						
						// run grid analysis
						[] spawn { 
							waituntil {
								sleep 240;
								
								private ["_sectors","_sectorData"];
								
								// DEBUG -------------------------------------------------------------------------------------
								["----------------------------------------------------------------------------------------"] call ALIVE_fnc_dump;
								["ALIVE Grid analysis for profile positions"] call ALIVE_fnc_dump;
								// DEBUG -------------------------------------------------------------------------------------
								
								// run profile analysis on all sectors
								[ALIVE_sectorGrid] call ALIVE_fnc_gridAnalysisProfileEntity;
								
								// DEBUG -------------------------------------------------------------------------------------
								// display visual representation of sector data
								
								_sectors = [ALIVE_sectorGrid, "sectors"] call ALIVE_fnc_sectorGrid;
								
								// clear the sector data plot
								[ALIVE_sectorPlotter, "clear"] call ALIVE_fnc_plotSectors;
								
								// plot the sector data
								[ALIVE_sectorPlotter, "plot", [_sectors, "entitiesBySide"]] call ALIVE_fnc_plotSectors;
								// DEBUG -------------------------------------------------------------------------------------
								
										
								sleep 5;		
								
								false 
							};
						};
						*/
                };
        };
        case "destroy": {                
                [_logic, "debug", false] call MAINCLASS;
                if (isServer) then {
					[_logic, "destroy"] call SUPERCLASS;
					
					_fsmHandler = [_logic, "controller_FSM"] call ALiVE_fnc_HashGet;					
					_fsmHandler setFSMVariable ["_destroy",true];
					
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
		case "spawnRadius": {
				if(typeName _args == "SCALAR") then {
						[_logic,"spawnRadius",_args] call ALIVE_fnc_hashSet;
						ALIVE_spawnRadius = _args;
                };
				_result = [_logic,"spawnRadius"] call ALIVE_fnc_hashGet;
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