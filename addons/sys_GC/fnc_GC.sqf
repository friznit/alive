//#define DEBUG_MODE_FULL
#include <\x\alive\addons\sys_GC\script_component.hpp>
SCRIPT(GC);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_GC
Description:
Garbage Collector

Function: MAINCLASS
Description:
Base class for GC objects to inherit from

Parameters:
Nil or Object - If Nil, return a new instance. If Object, reference an existing instance.
String - The selected function
Array - The selected parameters

Returns:
Any - The new instance or the result of the selected function and parameters

Attributes:
Boolean - debug - Debug enable, disable or refresh
init
start

Examples:
(begin example)
// create OPCOM objectives of SEP (ingame object for now) objectives and distance
[_logic, "start"] call ALIVE_fnc_GC;
(end)

See Also:

Author:
Highhead, original by BIS

Peer reviewed:
nil
---------------------------------------------------------------------------- */

#define SUPERCLASS ALIVE_fnc_baseClassHash
#define MAINCLASS ALIVE_fnc_GC

private ["_logic","_operation","_args","_result"];

TRACE_1("GC - input",_this);

_logic = [_this, 0, objNull, [objNull,[]]] call BIS_fnc_param;
_operation = [_this, 1, "", [""]] call BIS_fnc_param;
_args = [_this, 2, objNull,[objNull,grpNull,[],"",0,true,false]] call BIS_fnc_param;
_result = nil;

#define MTEMPLATE "ALiVE_GC_%1"

switch(_operation) do {
        // Main process
		case "init": {
			if (isServer) then {
				// if server, initialise module game logic
				_logic setVariable ["super", SUPERCLASS];
				_logic setVariable ["class", MAINCLASS];
                
                //Registering disabled for now
				//_logic setVariable ["moduleType", "ALIVE_GC"];
				//_logic setVariable ["startupComplete", false];
				TRACE_1("After module init",_logic);

				//[_logic,"register"] call MAINCLASS;
                
                //Start GC
                [_logic,"start"] call MAINCLASS;
                
			};
		};
		case "register": {
			
			private["_registration","_moduleType"];
	
			_moduleType = _logic getVariable "moduleType";
			_registration = [_logic,_moduleType,["ALIVE_profileHandler","SYNCED"],["ALIVE_MI","ALIVE_OPCOM"]];
	
			if(isNil "ALIVE_registry") then {
				ALIVE_registry = [nil, "create"] call ALIVE_fnc_registry;
				[ALIVE_registry, "init"] call ALIVE_fnc_registry;			
			};

			[ALIVE_registry,"register",_registration] call ALIVE_fnc_registry;
		};
		// Main process
		case "start": {                
                /*
                MODEL - no visual just reference data
                - nodes
                - center
                - size
                */
                
                if (isServer) then {
                    //identify Garbage Collector
                    ALiVE_GC = _logic; 
                    //transmit to clients
                    Publicvariable "ALiVE_GC";
                    
					//Retrieve module-object variables
                    _debug = call compile (_logic getvariable ["debug","false"]);
                    _logic setvariable ["debug",_debug,true];
					_logic setVariable ["auto", true];
                    
                    /*
                	CONTROLLER  - coordination
                	*/
					// DEBUG -------------------------------------------------------------------------------------
						if(_debug) then {
							["----------------------------------------------------------------------------------------"] call ALIVE_fnc_dump;
							["ALIVE Garbage Collector starting..."] call ALIVE_fnc_dumpR;
						};
					// DEBUG -------------------------------------------------------------------------------------
					
                    _fsm = _logic execfsm "\x\alive\addons\sys_GC\garbagecollector.fsm";
                    _logic setVariable ["ALiVE_GC_FSM", _fsm];
                    
                    // set module as startup complete
					//_logic setVariable ["startupComplete",true,true];
				};

                /*
                VIEW - purely visual
                */
        };
        
        case "collect": { 
	        _individual = call compile (_logic getvariable ["ALiVE_GC_INDIVIDUALTYPES",[]]);
            _debug = _logic getvariable ["debug",false];
            _time = time;
            
            // DEBUG -------------------------------------------------------------------------------------
				if(_debug) then {
					["----------------------------------------------------------------------------------------"] call ALIVE_fnc_dump;
					["ALIVE Garbage Collector started collecting at %1...",_time] call ALIVE_fnc_dumpR;
				};
			// DEBUG -------------------------------------------------------------------------------------
            
			{
                [_logic,"trashIt",_x] call ALiVE_fnc_GC;
			    sleep 0.03;
			} forEach allDead;
			
			{
				if (count units _x == 0) then {
                    [_logic,"trashIt",_x] call ALiVE_fnc_GC;
				};
			    sleep 0.03;
			} foreach allGroups;
			
			if ((count _individual) > 0) then {
			    _amo = (allmissionObjects ""); _amo = +_amo;
				{
					if (((typeof _x) in _individual) && {((damage _x) == 1)}) then {
                        [_logic,"trashIt",_x] call ALiVE_fnc_GC;
					};
			        sleep 0.03;
				} foreach _amo;
			};
            
            // DEBUG -------------------------------------------------------------------------------------
				if(_debug) then {
					["ALIVE Garbage Collector collection finished at %1! Time taken %2...",_time,(time - _time)] call ALIVE_fnc_dumpR;
                    ["----------------------------------------------------------------------------------------"] call ALIVE_fnc_dump;
				};
			// DEBUG -------------------------------------------------------------------------------------
            
        };
        
        case "trashIt": { 
	        if (isNil "_args") exitWith {debugLog "Log: [trashIt] There should be 1 mandatory parameter!"; false};
	
			private ["_object", "_queue", "_timeToDie"];
			_object = _args;
            _debug = _logic getvariable ["debug",false];
			
			_queue = _logic getVariable ["queue",[]];
			
			switch (typeName _object) do
			{
				case (typeName objNull):
				{
					if (alive _object) then
					{
						_timeToDie = time + 30;
					}
					else
					{
						_timeToDie = time + 60;
					};
				};
			
				case (typeName grpNull):
				{
					_timeToDie = time + 60;
				};
			
				default
				{
					_timeToDie = time;
				};
			};
            
           
            // DEBUG -------------------------------------------------------------------------------------
				if(_debug) then {
					["ALIVE Garbage Collector trashed object %1 to bin! Time to deletion %2...",_object,_timeToDie] call ALIVE_fnc_dumpR;
				};
			// DEBUG -------------------------------------------------------------------------------------
			
			_queue = _queue + [[_object, _timeToDie]];
			_logic setVariable ["queue", _queue];
        };
        
        case "process": { 
			_queue = _logic getVariable ["queue",[]];
            _debug = _logic getvariable ["debug",false];
            _time = time;
            
            // DEBUG -------------------------------------------------------------------------------------
				if(_debug) then {
					["----------------------------------------------------------------------------------------"] call ALIVE_fnc_dump;
					["ALIVE Garbage Collector deletion started at %1 for %2 objects...",_time,(count _queue)] call ALIVE_fnc_dumpR;
				};
			// DEBUG -------------------------------------------------------------------------------------
			
			_i = 0;
			{
			
				private ["_entry", "_time"];
				_entry = _x;
				if(typeName _x == "ARRAY") then {
					_time = _entry select 1;
			
					//Check the object was in the queue for at least the assigned time (expiry date).
					if (_time <= time) then
					{
						private ["_object"];
						_object = _entry select 0;
			
						switch (typeName _object) do
						{
							case (typeName objNull):
							{
								//Player and his squadmates cannot be too close.
								//ToDo: use 'cameraOn' as well?
								if (({(_x distance _object) <= 1700} count ([] call BIS_fnc_listPlayers)) == 0) then
								{
									deleteVehicle _object;
								};
								_queue set [_i, -1];
							};
			
							case (typeName grpNull):
							{
								//Make sure the group is empty.
								if (({alive _x} count (units _object)) == 0) then
								{
									deleteGroup _object;
								};
								_queue set [_i, -1];
							};
			
							default {};
						};
					};
				};
				_i = _i + 1;
			} forEach _queue;
            
    		// DEBUG -------------------------------------------------------------------------------------
				if(_debug) then {
					["ALIVE Garbage Collector deletion processed at %1! Time taken %2...",_time,(time - _time)] call ALIVE_fnc_dumpR;
                    ["----------------------------------------------------------------------------------------"] call ALIVE_fnc_dump;
				};
			// DEBUG -------------------------------------------------------------------------------------
			
			_queue = _queue - [-1];
			_logic setVariable ["queue", _queue, true];
        };
        
        case "processInstantly": { 
			_queue = _logic getVariable ["queue",[]];
            _debug = _logic getvariable ["debug",false];
            _time = time;
            
            // DEBUG -------------------------------------------------------------------------------------
				if(_debug) then {
					["----------------------------------------------------------------------------------------"] call ALIVE_fnc_dump;
					["ALIVE Garbage Collector insta-deletion started at %1 for %2 objects...",_time,(count _queue)] call ALIVE_fnc_dumpR;
				};
			// DEBUG -------------------------------------------------------------------------------------
            
            {deleteVehicle (_x select 0); _queue set [_foreachIndex, -1]} foreach _queue;
			_queue = _queue - [-1];
            
            // DEBUG -------------------------------------------------------------------------------------
				if(_debug) then {
					["ALIVE Garbage Collector insta-deletion processed at %1! Time taken %2...",_time,(time - _time)] call ALIVE_fnc_dumpR;
                    ["----------------------------------------------------------------------------------------"] call ALIVE_fnc_dump;
				};
			// DEBUG -------------------------------------------------------------------------------------
            
			_logic setVariable ["queue", _queue, true];
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
TRACE_1("GC - output",_result);
if !(isnil "_result") then {_result} else {nil};