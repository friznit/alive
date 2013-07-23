//#define DEBUG_MODE_FULL
#include <\x\alive\addons\mil_opcom\script_component.hpp>
SCRIPT(OPCOM);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_OPCOM
Description:
Initial placement of enemy based on clustered targets within the AO.
In a persisted situation, the stance, etc would change during gameplay
and be persisted as well, restoring if the mission is restarted ie params
within editor module ignored.

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
[_logic, "faction", "OPF_F"] call ALiVE_fnc_OPCOM;

See Also:
- <ALIVE_fnc_OPCOMInit>

Author:
Wolffy
---------------------------------------------------------------------------- */
#include <\x\alive\addons\sys_profile\script_component.hpp>
SCRIPT(profile);

/* ----------------------------------------------------------------------------
Function: MAINCLASS
Description:
Base class for profile objects to inherit from

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
// create a profile
_logic = [nil, "create"] call ALIVE_fnc_profile;
(end)

See Also:

Author:
ARJay

Peer reviewed:
nil
---------------------------------------------------------------------------- */

#define SUPERCLASS ALIVE_fnc_baseClassHash
#define MAINCLASS ALIVE_fnc_profile

private ["_logic","_operation","_args","_result"];

TRACE_1("OPCOM - input",_this);

_logic = [_this, 0, objNull, [objNull,[]]] call BIS_fnc_param;
_operation = [_this, 1, "", [""]] call BIS_fnc_param;
_args = [_this, 2, objNull, [objNull,[],"",0,true,false]] call BIS_fnc_param;
_result = true;

#define MTEMPLATE "ALiVE_OPCOM_%1"

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
					_logic setVariable ["super", SUPERCLASS];
					_logic setVariable ["class", MAINCLASS];
					TRACE_1("After module init",_logic);
			        
                    //Retrieve module-object variables
                    _debug = _logic getvariable ["debug",true];
                    _type = _logic getvariable ["controltype","invasion"];
                    _side = _logic getvariable ["side","EAST"];
                    
			        //Create OPCOM #Hash#Datahandler
					_handler = [nil, "createhashobject"] call ALIVE_fnc_OPCOM;
					call compile format["OPCOM_%1 = _handler",count (missionNameSpace getvariable ["OPCOM_instances",[]])];
                    missionNameSpace setVariable ["OPCOM_instances",(missionNameSpace getvariable ["OPCOM_instances",[]]) + [_handler]];
					
					/*
					CONTROLLER  - coordination
					*/
			        
			        "OPCOM - Waiting for virtual layer (profiles)..." call ALiVE_fnc_logger;
			        waituntil {sleep 5; !(isnil "ALiVE_ProfileHandler")};
			        
			        "OPCOM - Waiting for SEP objectives..." call ALiVE_fnc_logger;
			        waituntil {sleep 5; !(isnil {[SEP,"objectives"] call ALiVE_fnc_SEP})};
			
					"OPCOM and TACOM starting..." call ALiVE_fnc_logger;
					OPCOM = [_handler] execFSM "\x\alive\addons\mil_opcom\opcom.fsm";
					TACOM = [_handler] execFSM "\x\alive\addons\mil_opcom\tacom.fsm";
                };
                
                /*
                VIEW - purely visual
                */
                
                /*
                CONTROLLER  - coordination
                */
        };
        case "createhashobject": {                
                if (isServer) then {
                        _result = [nil, "create"] call ALIVE_fnc_OPCOM;
						[_result,"super"] call ALIVE_fnc_hashRem;
						[_result,"class"] call ALIVE_fnc_hashRem;
                        //TRACE_1("After module init",_logic);
                };
        };
                                
		case "createobjectivesbydistance": {
                if(isnil "_args") then {
						_args = [_logic,"objectives"] call ALIVE_fnc_hashGet;
                } else {
                    	//Collect objectives from SEP and order by distance from SEP module (for now)
                        _logic = _args;
						_objectives = [_logic,"objectives"] call ALiVE_fnc_SEP;
						{
									_target = _x;
									_pos = [_target,"center"] call ALiVE_fnc_hashGet;
									_size = [_target,"size"] call ALiVE_fnc_hashGet;
									_type = [_target,"type"] call ALiVE_fnc_hashGet;
									_priority = [_target,"priority"] call ALiVE_fnc_hashGet;
									_objectives_unsorted set [count _objectives_unsorted, [_pos,_size,_type,_priority]];
						} foreach _objectives;
						_objectives = [_objectives_unsorted,[],{_logic distance (_x select 0)},"ASCEND"] call BIS_fnc_sortBy;
						
						//Create objectives for OPCOM and set it on the OPCOM Handler 
						//GetObjectivesByPriority
						{
									_target = [nil, "createhashobject"] call ALIVE_fnc_OPCOM;
						
									_id = format["OPCOM_objective_%1",_foreachIndex]; [_target, "objectiveID",_id] call ALIVE_fnc_HashSet;
									_pos = _x select 0; [_target, "center",_pos] call ALIVE_fnc_HashSet;
									_size = _x select 1; [_target, "size",_size] call ALIVE_fnc_HashSet;
									_type = _x select 2; [_target, "type",_type] call ALIVE_fnc_HashSet;
									_priority = _x select 3; [_target, "priority",_priority] call ALIVE_fnc_HashSet;
									_opcom_state = "unassigned"; [_target, "opcom_state",_opcom_state] call ALIVE_fnc_HashSet;
						
									if  (_debug) then {
						            	_m = createMarkerLocal [_id, _pos];
										_m setMarkerShapeLocal "RECTANGLE";
										_m setMarkerSizeLocal [_size, _size];
										_m setMarkerTypeLocal "hd_dot";
										_m setMarkerColorLocal "ColorWhite";
										_m setMarkerTextLocal format["Objective Priority %1",_foreachIndex];
									};
						
									_objectives set [_forEachIndex, _target];
						 } foreach _objectives;
                         _args = _objectives;
                };                
                ASSERT_TRUE(typeName _args == "ARRAY",str _args);
                
                _result = _args;
        };                                        

		case "objectives": {
                if(isnil "_args") then {
						_args = [_logic,"objectives",[]] call ALIVE_fnc_hashGet;
                } else {
						[_logic,"objectives",_args] call ALIVE_fnc_hashSet;
                };                
                ASSERT_TRUE(typeName _args == "ARRAY",str _args);
                
                _result = _args;
        };
        
        case "getobjectivebyid": {
            	ASSERT_TRUE(typeName _args == "STRING",str _args);
                
			    private ["_objective","_id"];
				_id = _args;
				{
					if (([_x,"objectiveID"] call ALiVE_fnc_hashGet) == _id) exitwith {_objective = _x; diag_log format["how many count %2 | %1",_objective,_foreachindex]};
				} foreach ([_logic, "objectives"] call ALIVE_fnc_HashGet);

				_result = _objective;
		};
        case "analyzeclusteroccupation": {
            	ASSERT_TRUE(typeName _args == "ARRAY",str _args);

				_side = _args select 0;
				_distance = _args select 1;
				_nearForces = [];
			
				_forces = [ALIVE_Profilehandler, "getProfilesBySide", _side] call ALIVE_fnc_profileHandler;
				{
					_item = _x;
					_pos = [_item,"center"] call ALiVE_fnc_HashGet;
					_id = [_item,"objectiveID"] call ALiVE_fnc_HashGet;
					_nearEntities = [];
			
						{
							_ProID = _x;
							_profile = [ALIVE_profileHandler, "getProfile", _ProID] call ALIVE_fnc_profileHandler;
							_posP = [_profile, "position"] call ALIVE_fnc_profileEntity;
			            			if (_posP distance _pos < _distance) then {_nearEntities set [count _nearEntities,_ProID]};
						} foreach _forces;
						if (count _nearEntities > 0) then {_nearForces set [count _nearForces,[_id,_nearEntities]]};
				} foreach ([_logic,"objectives",[]] call AliVE_fnc_HashGet);
				_result = _nearForces;
		};
        
        case "setstatebyclusteroccupation": {
            	ASSERT_TRUE(typeName _args == "ARRAY",str _args);
                
				private ["_objectives","_operation","_idleStates","_state","_target"];
				_objectives = _args select 0;
				_operation = _args select 1;

				switch (_operation) do {
                	case ("unassigned") : {_idleStates = ["unassigned"]};
                    case ("attack") : {_idleStates = ["attack","attacking"]};
                    case ("reserve") : {_idleStates = ["reserve","reserving","idle"]};
                    default {_idleStates = ["reserve","reserving","idle"]};
                };

				{
					_id = _x; if (typeName _x == "ARRAY") then {_id = _x select 0};
					_target = [_logic,"getobjectivebyid",_id] call ALiVE_fnc_OPCOM;
					
                    _pos = [_target,"center"] call AliVE_fnc_HashGet;
					_state = [_target,"opcom_state"] call AliVE_fnc_HashGet;
	                if !(_state in _idleStates) then {[_target,"opcom_state",_operation] call AliVE_fnc_HashSet};
                } foreach _objectives;
                
                if !(isnil "_target") then {_result = [_target,_operation]} else {nil};
		};
        
        case "selectordersbystate": {
            	ASSERT_TRUE(typeName _args == "STRING",str _args);
                
                _state = _args;
                _DATA_TMP = nil;

            	switch (_state) do {
					case ("attack") : {
						{
							_state = [_x,"opcom_state"] call AliVE_fnc_HashGet;
							if (_state == "attack") exitwith {_target = _x};
						} foreach ([_logic,"objectives",[]] call AliVE_fnc_HashGet);
		
						//Trigger order execution
						[_target,"opcom_orders","attack"] call AliVE_fnc_HashSet;
						_DATA_TMP = ["execute",_target];
					};
					case ("unassigned") : {
						{
							_state = [_x,"opcom_state"] call AliVE_fnc_HashGet;
							if (_state == "unassigned") exitwith {_target = _x};
						} foreach ([_logic,"objectives",[]] call AliVE_fnc_HashGet);
		
						//Trigger order execution
						[_target,"opcom_orders","attack"] call AliVE_fnc_HashSet;
						_DATA_TMP = ["execute",_target];
					};
					case ("reserve") : {
						{
							_state = [_x,"opcom_state"] call AliVE_fnc_HashGet;
							if (_state == "reserve") exitwith {_target = _x};
						} foreach ([_logic,"objectives",[]] call AliVE_fnc_HashGet);;
		
						//Trigger order execution
						[_target,"opcom_orders","reserve"] call AliVE_fnc_HashSet;
						_DATA_TMP = ["execute",_target];
					};
        		};
                if !(isnil "_DATA_TMP") then {_result = _DATA_TMP};
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
TRACE_1("OPCOM - output",_result);
_result;
