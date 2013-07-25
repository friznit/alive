//#define DEBUG_MODE_FULL
#include <\x\alive\addons\mil_opcom\script_component.hpp>
SCRIPT(OPCOM);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_OPCOM
Description:
Virtual AI Controller (WIP) 

Function: MAINCLASS
Description:
Base class for OPCOM objects to inherit from

Parameters:
Nil or Object - If Nil, return a new instance. If Object, reference an existing instance.
String - The selected function
Array - The selected parameters

Returns:
Any - The new instance or the result of the selected function and parameters

Attributes:
Boolean - debug - Debug enable, disable or refresh
init
createhashobject
createobjectivesbydistance
objectives
analyzeclusteroccupation
setorders
synchronizeorders
NearestAvailableSection
setstatebyclusteroccupation
selectordersbystate

Examples:
(begin example)
// create OPCOM objectives of SEP (ingame object for now) objectives and distance
_objectives = [_logic, "createobjectivesbydistance",SEP] call ALIVE_fnc_OPCOM;
(end)

See Also:

Author:
Highhead

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
			        
			        //Create OPCOM #Hash#Datahandler
					_handler = [nil, "createhashobject"] call ALIVE_fnc_OPCOM;
                   
					call compile format["OPCOM_%1 = _handler",count (missionNameSpace getvariable ["OPCOM_instances",[]])];
                    missionNameSpace setVariable ["OPCOM_instances",(missionNameSpace getvariable ["OPCOM_instances",[]]) + [_handler]];

					//Retrieve module-object variables
                    _debug = _logic getvariable ["debug",true];
                    _type = _logic getvariable ["controltype","invasion"];
                    _side = _logic getvariable ["side","EAST"];

					[_handler, "side",_side] call ALiVE_fnc_HashSet;
                    [_handler, "controltype",_type] call ALiVE_fnc_HashSet;
					
					/*
					CONTROLLER  - coordination
					*/
			        
			        "OPCOM - Waiting for virtual layer (profiles)..." call ALiVE_fnc_logger;
			        waituntil {sleep 5; !(isnil "ALiVE_ProfileHandler")};
			        
			        "OPCOM - Waiting for SEP objectives..." call ALiVE_fnc_logger;
			        waituntil {sleep 5; !(isnil {[SEP,"objectives"] call ALiVE_fnc_SEP})};
			
					"OPCOM and TACOM starting..." call ALiVE_fnc_logger;
                    [_handler] spawn {
						OPCOM = [_this select 0] execFSM "\x\alive\addons\mil_opcom\opcom.fsm";
						TACOM = [_this select 0] execFSM "\x\alive\addons\mil_opcom\tacom.fsm";
                    };
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

						_objectives_unsorted = [];
						_targets = [];
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
					if (([_x,"objectiveID"] call ALiVE_fnc_hashGet) == _id) exitwith {_objective = _x};
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
        
        case "setorders": {
            	ASSERT_TRUE(typeName _args == "ARRAY",str _args);
        
        		private ["_profile","_profileID","_objectiveID","_pos","_orders"];

				_pos = _args select 0;
				_profileID = _args select 1;
				_objectiveID = _args select 2;
				_orders = _args select 3;

				_profile = [ALIVE_profileHandler, "getProfile", _profileID] call ALIVE_fnc_profileHandler;

				[_profile, "clearWaypoints"] call ALIVE_fnc_profileEntity;
				_profileWaypoint = [_pos, 50] call ALIVE_fnc_createProfileWaypoint;

				_var = ["_TACOM_DATA",["completed",[_ProfileID,_objectiveID,_orders]]];
				_statements = format["TACOM setfsmvariable %1",_var];
				[_profileWaypoint,"statements",["true",_statements]] call ALIVE_fnc_hashSet;

				[_profile, "addWaypoint", _profileWaypoint] call ALIVE_fnc_profileEntity;
                
                _ordersFull = [_pos,_ProfileID,_objectiveID,time];
                [_logic,"pendingorders",([_logic,"pendingorders",[]] call ALiVE_fnc_HashGet) + [_ordersFull]] call ALiVE_fnc_HashSet;

                _result = _profileWaypoint;
		};
        
        case "synchronizeorders": {
            	ASSERT_TRUE(typeName _args == "STRING",str _args);
                
                private ["_ProfileIDInput","_profiles","_orders_pending","_synchronized","_item","_objectiveID"];
        
    			_ProfileIDInput = _args;
				_profiles = ([ALIVE_profileHandler, "getProfiles","entity"] call ALIVE_fnc_profileHandler) select 1;
				_orders_pending = ([_logic,"pendingorders",[]] call ALiVE_fnc_HashGet);
				_synchronized = false;

				for "_i" from 0 to ((count _orders_pending)-1) do {
					if (_i >= (count _orders_pending)) exitwith {};
			
					_item = _orders_pending select _i;
					_pos = _item select 0;
					_profileID = _item select 1;
					_objectiveID = _item select 2;
					_time = _item select 3;
					_dead = !(_ProfileID in _profiles);
					_timeout = (time - _time) > 600;
			
					if ((_dead) || {_timeout} || {_ProfileID == _ProfileIDInput}) then {
						_orders_pending set [_i,"x"]; _orders_pending = _orders_pending - ["x"];
                        [_logic,"pendingorders",_orders_pending] call ALiVE_fnc_HashSet;
                        if (({_objectiveID == (_x select 2)} count (_orders_pending)) == 0) then {_synchronized = true};
					};
				};
				_result = _synchronized;
        };
        
        case "NearestAvailableSection": {
            			ASSERT_TRUE(typeName _args == "ARRAY",str _args);
                        
                        private ["_profileIDs","_ProfileIDsBusy","_size","_available"];
        
        				_position = _args select 0;
						_typeOp = _args select 1;
                        _size = _args select 2;
                        
                        _side = [_logic,"side","EAST"] call ALiVE_fnc_HashGet;
                        _ProfileIDsReserve = [_logic,"ProfileIDsReserve",[]] call ALiVE_fnc_HashGet;
                        _objectivescount = [_logic,"simultanobjectives",3] call ALiVE_fnc_HashGet;
                        _profileIDs = [ALIVE_profileHandler, "getProfilesBySide",_side] call ALIVE_fnc_profileHandler;
                        _sections = [];
                        _section = [];
                        
                        if (_size < 0) then {_size = floor((count _profileIDs)/_objectivescount)};
                        
						_ProfileIDsBusy = [];
						{
							_ProfileID = _x select 1;
							_ProfileIDsBusy set [count _ProfileIDsBusy,_ProfileID];
						} foreach ([_logic,"pendingorders",[]] call ALiVE_fnc_HashGet);
						[_logic,"ProfileIDsBusy",_ProfileIDsBusy] call ALiVE_fnc_HashSet;

						switch (_typeOp) do {
							case ("attack") : {_available = _profileIDs - _ProfileIDsBusy - _ProfileIDsReserve};
							case ("reserve") : {_available = _profileIDs - _ProfileIDsBusy};
						};
						
						{
								private ["_profile","_profileID","_profileType","_position","_active"];
								
								_profile = [ALIVE_profileHandler, "getProfile", _x] call ALIVE_fnc_profileHandler;
								_profileID = [_profile,"profileID"] call ALIVE_fnc_hashGet;
								_side = [_profile, "side"] call ALIVE_fnc_hashGet;
								_active = [_profile, "active"] call ALIVE_fnc_hashGet;
								_pos = [_profile,"position"] call ALIVE_fnc_hashGet;
								_type = [_profile, "type"] call ALIVE_fnc_hashGet;

								if !(_type == "vehicle" ) then {
									_sections set [count _sections,[_ProfileID,_pos]];
								};
						} forEach _available;

						_sections = [_sections,[],{_position distance (_x select 1)},"ASCEND"] call BIS_fnc_sortBy;
						{_sections set [_foreachIndex,_x select 0]} foreach _sections;

						{
							if ((count _section) >= _size) exitwith {};
							_section set [count _section,_x];
						} foreach _sections;
						_result = _section;
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
