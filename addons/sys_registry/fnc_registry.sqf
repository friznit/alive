#include <\x\alive\addons\sys_registry\script_component.hpp>
SCRIPT(registry);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_registry
Description:
Registry for modules

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
// create the command router
_logic = [nil, "create"] call ALIVE_fnc_registry;

(end)

See Also:

Author:
ARJay

Peer reviewed:
nil
---------------------------------------------------------------------------- */

#define SUPERCLASS ALIVE_fnc_baseClassHash
#define MAINCLASS ALIVE_fnc_registry

private ["_logic","_operation","_args","_result","_excludedModules","_syncedModule","_syncedModuleType","_started","_module","_modules","_profilesByType"];

TRACE_1("registry - input",_this);

_logic = [_this, 0, objNull, [objNull,[]]] call BIS_fnc_param;
_operation = [_this, 1, "", [""]] call BIS_fnc_param;
_args = [_this, 2, objNull, [objNull,[],"",0,true,false]] call BIS_fnc_param;
_result = true;

#define MTEMPLATE "ALiVE_REGISTRY_%1"

switch(_operation) do {
    case "init": {                
        /*
        MODEL - no visual just reference data
        */
        
        if (isServer) then {
            // if server, initialise module game logic
            [_logic,"super"] call ALIVE_fnc_hashRem;
            [_logic,"class"] call ALIVE_fnc_hashRem;
            TRACE_1("After module init",_logic);
            
            // set defaults
            [_logic,"debug",false] call ALIVE_fnc_hashSet; // select 2 select 0
            [_logic,"moduleCount",0] call ALIVE_fnc_hashSet;
            [_logic,"modules",[] call ALIVE_fnc_hashCreate] call ALIVE_fnc_hashSet;
            [_logic,"modulesByType",[] call ALIVE_fnc_hashCreate] call ALIVE_fnc_hashSet;
            [_logic,"startupQueue",[]] call ALIVE_fnc_hashSet;
            [_logic,"startupRunning",false] call ALIVE_fnc_hashSet;
            [_logic,"modulesStarted",[]] call ALIVE_fnc_hashSet;
            
            if([_logic, "debug"] call MAINCLASS) then {
                ["----------------------------------------------------------------------------------------"] call ALIVE_fnc_dump;
                ["ALIVE Registry init"] call ALIVE_fnc_dump;
            };
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
    case "register": {
        private["_module","_modules","_moduleType","_moduleID","_requiredModules","_modulesByType","_startupQueue","_modulesType","_startupRunning"];
        
        if(typeName _args == "ARRAY") then {
            
            _module = _args select 0;
            _moduleType = _args select 1;
            _requiredModules = [_args, 2, [], [[]]] call BIS_fnc_param;
            _excludedModules = [_args, 3, [], [[]]] call BIS_fnc_param;
            
            _modules = [_logic, "modules"] call ALIVE_fnc_hashGet;
            _modulesByType = [_logic, "modulesByType"] call ALIVE_fnc_hashGet;
            _startupQueue = [_logic, "startupQueue"] call ALIVE_fnc_hashGet;
            
            _moduleID = [_logic, "getNextInsertID"] call MAINCLASS;
            
            // store reference by type
            _modulesType = [_modulesByType, _moduleType, []] call ALIVE_fnc_hashGet;
            _modulesType set [count _modulesType, _moduleID];
            [_modulesByType, _moduleType, _modulesType] call ALIVE_fnc_hashSet;
            
            // place the module in the queue
            _startupQueue set [count _startupQueue, [_moduleID,_moduleType,_requiredModules,_excludedModules]];				
            [_modules, _moduleID, _module] call ALIVE_fnc_hashSet;
            
            /*
            ["----------------------------------------------------------------------------------------"] call ALIVE_fnc_dump;
            ["ALIVE Registry - Register [%1] type: %2 reqs: %3",_moduleID,_moduleType,_requiredModules] call ALIVE_fnc_dump;
            ["ALIVE Registry - Startup queue %1",_startupQueue] call ALIVE_fnc_dump;
            _modulesByType call ALIVE_fnc_inspectHash;
            */
            
            _startupRunning = [_logic, "startupRunning"] call ALIVE_fnc_hashGet;
            
            if!(_startupRunning) then {
                [_logic, "startupRunning", true] call ALIVE_fnc_hashSet;
                [_logic,"startup",0] call MAINCLASS;
            };
        };
    };
    case "startup": {
        private["_startupQueue","_modulesStarted","_queuedModule","_moduleID","_moduleType","_requiredModules","_excludedModules","_requirementsPassed","_startedModules","_class","_loopCount"];
        
        _startupQueue = [_logic, "startupQueue"] call ALIVE_fnc_hashGet;
        _modulesStarted = [_logic, "modulesStarted"] call ALIVE_fnc_hashGet;
        _modules = [_logic, "modules"] call ALIVE_fnc_hashGet;

        _loopCount = _args;

        ["-------------------------------- ALIVE REGISTRY LOOP COUNT: %1",_loopCount] call ALIVE_fnc_dump;
        
        {
            _queuedModule = _x;
            _moduleID = _queuedModule select 0;
            _moduleType = _queuedModule select 1;
            _requiredModules = _queuedModule select 2;
            _excludedModules = _queuedModule select 3;
            
            // DEBUG -------------------------------------------------------------------------------------
            ["ALIVE Registry - %2 Startup [%1]",_moduleID,_moduleType] call ALIVE_fnc_dump;
            // DEBUG -------------------------------------------------------------------------------------
            
            _requirementsPassed = true;
            
            if(count _requiredModules > 0) then {
                
                // DEBUG -------------------------------------------------------------------------------------
                ["ALIVE Registry - %2 [%1] has required modules defined: %3",_moduleID,_moduleType,_requiredModules] call ALIVE_fnc_dump;
                // DEBUG -------------------------------------------------------------------------------------
                
                if("SYNCED" in _requiredModules) then {
                    
                    _module = [_modules, _moduleID] call ALIVE_fnc_hashGet;
                    
                    for "_i" from 0 to ((count synchronizedObjects _module)-1) do {
                        _syncedModule = (synchronizedObjects _module) select _i;
                        _syncedModuleType = _syncedModule getVariable ["moduleType","NONE"];
                        _started = _syncedModule getVariable ["startupComplete",false];
                        
                        if!(_syncedModuleType in _excludedModules) then {
                            
                            // DEBUG -------------------------------------------------------------------------------------
                            ["ALIVE Registry - %2 [%1] required synced %3 module has started:%4",_moduleID,_moduleType,_syncedModuleType,_started] call ALIVE_fnc_dump;
                            // DEBUG -------------------------------------------------------------------------------------
                            
                            if!(_started) then {
                                _requirementsPassed = false;
                            };
                            
                        };						
                    };					
                };
                
                _startedModules = [];
                {
                    _startedModules set [count _startedModules, (_x select 1)];
                } forEach _modulesStarted;						
                
                {
                    if!(_x == "SYNCED") then {
                        if!(_x in _startedModules) then {
                            _requirementsPassed = false;
                        };
                    };
                } forEach _requiredModules;
            };
            
            if(_requirementsPassed) then {
                
                _module = [_modules, _moduleID] call ALIVE_fnc_hashGet;
                
                if(typeName _module == "OBJECT") then {
                    _class = _module getVariable "class";
                }else{
                    _class = [_module,"class"] call ALIVE_fnc_hashGet;
                };
                
                // DEBUG -------------------------------------------------------------------------------------
                ["ALIVE Registry - %2 [%1] starting..",_moduleID,_moduleType] call ALIVE_fnc_dump;
                // DEBUG -------------------------------------------------------------------------------------
                
                //["Class: %1",_class] call ALIVE_fnc_dump;					
                [_module,"start"] call _class;
                
                // set module as started
                _modulesStarted set [count _modulesStarted, _queuedModule];
                
                // remove module from queue
                _startupQueue set [_forEachIndex, 1];
            }else{
                
                // DEBUG -------------------------------------------------------------------------------------
                ["ALIVE Registry - %2 [%1] is not ready to be started, waiting on: %3",_moduleID,_moduleType,_requiredModules] call ALIVE_fnc_dump;
                // DEBUG -------------------------------------------------------------------------------------
                
            };
            
        } forEach _startupQueue;
        
        _startupQueue = _startupQueue - [1];
        
        [_logic, "startupQueue", _startupQueue] call ALIVE_fnc_hashSet;
        [_logic, "modulesStarted", _modulesStarted] call ALIVE_fnc_hashSet;
        
        sleep 0.5;
        
        
        // loop
        if((count _startupQueue) > 0) then {

            _loopCount = _loopCount + 1;

            if(_loopCount > 10) then {
                ["------------------------------ WARNING -----------------------------"] call ALIVE_fnc_dumpR;
                ["ALIVE Registry - Warning module startup appears to be broken, aborting. Check your module syncronisation and requirements"] call ALIVE_fnc_dumpR;

                {
                    _queuedModule = _x;
                    _moduleID = _queuedModule select 0;
                    _moduleType = _queuedModule select 1;

                    ["ALIVE Registry - Module remaining to be started: %1 %2",_moduleType,_moduleID] call ALIVE_fnc_dumpR;

                } forEach _startupQueue;
            }else{
                // DEBUG -------------------------------------------------------------------------------------
                ["ALIVE Registry - Startup queue not empty, looping.."] call ALIVE_fnc_dump;
                // DEBUG -------------------------------------------------------------------------------------

                [_logic, "startup", _loopCount] call MAINCLASS;
            };
        }else{
            
            // DEBUG -------------------------------------------------------------------------------------
            ["ALIVE Registry - Startup queue completed.."] call ALIVE_fnc_dump;
            // DEBUG -------------------------------------------------------------------------------------
            
            if!(isNil "ALIVE_profileHandler") then {
                ["ALIVE total unit count: %1", [ALIVE_profileHandler, "getUnitCount"] call ALIVE_fnc_profileHandler] call ALIVE_fnc_dump;
                ["ALIVE total vehicle count: %1", [ALIVE_profileHandler, "getVehicleCount"] call ALIVE_fnc_profileHandler] call ALIVE_fnc_dump;
            };
            
            // shut down the startup queue
            [_logic, "startupRunning", false] call ALIVE_fnc_hashSet;
        };				
    };
    case "getModule": {
        private["_moduleID","_modules","_moduleIndex"];
        
        if(typeName _args == "STRING") then {
            _moduleID = _args;
            _modules = [_logic, "modules"] call ALIVE_fnc_hashGet;
            _moduleIndex = _modules select 1;
            if(_moduleID in _moduleIndex) then {
                _result = [_modules, _moduleID] call ALIVE_fnc_hashGet;
            }else{
                _result = nil;
            };		
        };
    };
    case "getModules": {
        _result = [_logic, "modules"] call ALIVE_fnc_hashGet;
    };
    case "getModulesByType": {
        private["_type","_modulesByType"];
        
        if(typeName _args == "STRING") then {
            _type = _args;
            
            _modulesByType = [_logic, "modulesByType"] call ALIVE_fnc_hashGet;
            
            _result = [_profilesByType, _type] call ALIVE_fnc_hashGet;
        };
    };
    case "getNextInsertID": {
        private["_moduleCount"];
        _moduleCount = [_logic, "moduleCount"] call ALIVE_fnc_hashGet;
        _result = format["module_%1",_moduleCount];
        _moduleCount = _moduleCount + 1;
        [_logic, "moduleCount", _moduleCount] call ALIVE_fnc_hashSet;
    };
    default {
        _result = [_logic, _operation, _args] call SUPERCLASS;
    };
};
TRACE_1("registry - output",_result);
_result;
