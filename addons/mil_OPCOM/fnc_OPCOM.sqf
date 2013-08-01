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
                    [_handler, "debug",(call compile _debug)] call ALiVE_fnc_HashSet;
					
					/*
					CONTROLLER  - coordination
					*/
			        
			        "OPCOM - Waiting for virtual layer (profiles)..." call ALiVE_fnc_logger;
			        waituntil {sleep 5; !(isnil "ALiVE_ProfileHandler")};
			        
			        "OPCOM - Waiting for SEP objectives..." call ALiVE_fnc_logger;
			        waituntil {sleep 5; !(isnil {[SEP,"objectives"] call ALiVE_fnc_SEP})};
                    			
					"OPCOM and TACOM starting..." call ALiVE_fnc_logger;
                    [_handler] call {
                        _handler = _this select 0;
						_OPCOM = [_handler,_side] execFSM "\x\alive\addons\mil_opcom\opcom.fsm";
						_TACOM = [_handler,_side] execFSM "\x\alive\addons\mil_opcom\tacom.fsm";
						[_handler, "OPCOM_FSM",_OPCOM] call ALiVE_fnc_HashSet;
                        [_handler, "TACOM_FSM",_TACOM] call ALiVE_fnc_HashSet;
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
        
        case "addObjective": {
                if(isnil "_args") then {
					_args = [_logic,"objectives"] call ALIVE_fnc_hashGet;
                } else {
                    ASSERT_TRUE(typeName _args == "ARRAY",str _args);
                    _pos = _args select 0;
                    _size = _args select 1;
                    _opcom_state = "unassigned"; if (count _args > 2) then {_opcom_state = _args select 2};
                    
                    _objectives = [_logic, "objectives",[]] call ALIVE_fnc_HashGet;
                    _debug = [_logic, "debug",false] call ALIVE_fnc_HashGet;
                    
                    _type = "unknown";
                    _priority = 25;
                    
    				_target = [nil, "createhashobject"] call ALIVE_fnc_OPCOM;
		
					_id = format["OPCOM_objective_%1",count _objectives];
                    [_target, "objectiveID",_id] call ALIVE_fnc_HashSet;
					[_target, "center",_pos] call ALIVE_fnc_HashSet;
					[_target, "size",_size] call ALIVE_fnc_HashSet;
					[_target, "type",_type] call ALIVE_fnc_HashSet;
					[_target, "priority",_priority] call ALIVE_fnc_HashSet;
					[_target, "opcom_state",_opcom_state] call ALIVE_fnc_HashSet;
                    [_target, "opcom_orders","none"] call ALIVE_fnc_HashSet;
		
					if (_debug) then {
		            	_m = createMarkerLocal [_id, _pos];
						_m setMarkerShapeLocal "RECTANGLE";
						_m setMarkerSizeLocal [_size, _size];
						_m setMarkerBrushLocal "FDiagonal";
						_m setMarkerColorLocal "ColorYellow";
						
						_m = createMarkerLocal [format["%1_label",_id], _pos];
						_m setMarkerShapeLocal "ICON";
						_m setMarkerSizeLocal [0.5, 0.5];
						_m setMarkerTypeLocal "mil_dot";
						_m setMarkerColorLocal "ColorYellow";
						_m setMarkerTextLocal _id;
					};
		
					_objectives set [count _objectives, _target];
                    _objectives = [_objectives,[],{SEP distance ((_x select 2) select 1)},"ASCEND"] call BIS_fnc_sortBy;
                    [_logic, "objectives",_objectives] call ALIVE_fnc_HashSet;
                    _args = _target;
                };
                _result = _args;
        };
        
        case "addTask": {
            
            _operation = _args select 0;
            _pos = _args select 1;
            _section = _args select 2;
            _TACOM_FSM = [_logic,"TACOM_FSM"] call ALiVE_fnc_HashGet;
            
            _objective = [_logic,"addObjective",[_pos,100,"internal"]] call ALiVE_fnc_OPCOM;
            [_objective,"section",_section] call AliVE_fnc_HashSet;
            
            _TACOM_FSM setFSMVariable ["_busy",false];
            _TACOM_FSM setFSMVariable ["_TACOM_DATA",["true",nil]];
            
            switch (_operation) do {
                case ("recon") : {
                    _recon = [_objective,_section];
                    _TACOM_FSM setFSMVariable ["_recon",_recon];
                };
                case ("capture") : {
                    _capture = [_objective,_section];
                    _TACOM_FSM setFSMVariable ["_capture",_capture];
                };
                case ("defend") : {
                    _defend = [_objective,_section];
                	_TACOM_FSM setFSMVariable ["_defend",_defend];
                };
                case ("reserve") : {
                    _reserve = [_objective,_section];
                    _TACOM_FSM setFSMVariable ["_reserve",_reserve];
                };
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
										_m setMarkerBrushLocal "FDiagonal";
										_m setMarkerColorLocal "ColorYellow";
										
										_m = createMarkerLocal [format["%1_label",_id], _pos];
										_m setMarkerShapeLocal "ICON";
										_m setMarkerSizeLocal [0.5, 0.5];
										_m setMarkerTypeLocal "mil_dot";
										_m setMarkerColorLocal "ColorYellow";
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

				_sides = _args;
				//_distance = _args select 1;
                _result_tmp = [];
                {
                    _nearForces = [];
                    _side = _x;
	                {
	                    _item = _x;
						_pos = [_item,"center"] call ALiVE_fnc_HashGet;
						_id = [_item,"objectiveID"] call ALiVE_fnc_HashGet;
	                    _type = "surroundingsectors";
                        _entArr = [];
                        _entities = [];
			            
			            _sectors = [[ALIVE_sectorGrid, "positionToSector", _pos] call ALIVE_fnc_sectorGrid];
						//_sectors = ([ALIVE_sectorGrid, "surroundingSectors", _pos] call ALIVE_fnc_sectorGrid);

						{
							_sector = _x;
							_sectorData = [_sector, "data"] call ALIVE_fnc_sector;
							_sectorID = [_sector, "id"] call ALIVE_fnc_sector;
					
							if("entitiesBySide" in (_sectorData select 1)) then {
								_sectorEntityData = [_sectorData, "entitiesBySide"] call ALIVE_fnc_hashGet;
								_ent = [_sectorEntityData,_side] call ALiVE_fnc_HashGet;
			                    //_check = (({(count _x > 0)} count (_sectorEntityData select 2)) - count _ent) > 0;
			                    _entArr set [count _entArr,_ent];
							};
						} forEach _sectors;

			            {
			                if (typeName ((_x select 0) select 0) == "STRING") then {
			                	_entities set [count _entities,(_x select 0) select 0];
			            	};
			            } foreach _entArr;
	                    
	                    if (count _entities > 0) then {_nearForces set [count _nearForces,[_id,_entities]]};
	                } foreach ([_logic,"objectives",[]] call AliVE_fnc_HashGet);
                    
                    _result_tmp set [count _result_tmp,_nearForces];
                } foreach _sides;
            
	            _targetsTaken1 =  _result_tmp select 0;
	            _targetsTaken2 =  _result_tmp select 1;
	            
	        	_targetsAttacked1 = [];
                _remover1 = [];
				{
					_targetID = _x select 0;
					_entities = _x select 1;
					
					if ({(_x select 0) == _targetID} count _targetsTaken2 > 0) then {
						_targetsAttacked1 set [count _targetsAttacked1,_x];
						_remover1 set [count _remover1,_foreachIndex];
					};
				} foreach _targetsTaken1;
	
				_targetsAttacked2 = [];
                _remover2 = [];
				{
					_targetID = _x select 0;
					_entities = _x select 1;
					
					if ({(_x select 0) == _targetID} count _targetsTaken1 > 0) then {
						_targetsAttacked2 set [count _targetsAttacked2,_x];
						_remover2 set [count _remover2,_foreachIndex];
					};
				} foreach _targetsTaken2;
                

                {
                   _targetsTaken1 set [_x,"x"];
                   _targetsTaken1 = _targetsTaken1 - ["x"];
                } foreach _remover1;
                
                {
                   _targetsTaken2 set [_x,"x"];
                   _targetsTaken2 = _targetsTaken2 - ["x"];
                } foreach _remover2;

                
	            _result = [_targetsTaken1, _targetsAttacked1, _targetsTaken2, _targetsAttacked2];
                diag_log format ["East: Taken %1 | Attacked %2 // West: Taken %3 | Attacked %4",_targetsTaken1, _targetsAttacked1, _targetsTaken2, _targetsAttacked2];
		};

        case "entitiesnearsector": {
            	ASSERT_TRUE(typeName _args == "STRING",str _args);
        
	            _side = _args;
                _pos = [_logic,"center"] call ALiVE_fnc_HashGet;
                _ent = [];
                _entArr = [];

			    _sectors = [[ALIVE_sectorGrid, "positionToSector", _pos] call ALIVE_fnc_sectorGrid];
                _sectors = _sectors + ([ALIVE_sectorGrid, "surroundingSectors", _pos] call ALIVE_fnc_sectorGrid);

						{
							_sector = _x;
							_sectorData = [_sector, "data"] call ALIVE_fnc_sector;
							_sectorID = [_sector, "id"] call ALIVE_fnc_sector;
					
							if("entitiesBySide" in (_sectorData select 1)) then {
								_sectorEntityData = [_sectorData, "entitiesBySide"] call ALIVE_fnc_hashGet;
								_ent = [_sectorEntityData,_side] call ALiVE_fnc_HashGet;
			                    if (count _ent > 0) then {_entArr set [count _entArr,_ent]};
							};
						} forEach _sectors;
	            _result = _entArr;
        };

        case "setorders": {
            	ASSERT_TRUE(typeName _args == "ARRAY",str _args);
        
        		private ["_profile","_profileID","_objectiveID","_pos","_orders","_pending_orders","_objectives","_id"];

				_pos = _args select 0;
				_profileID = _args select 1;
				_objectiveID = _args select 2;
				_orders = _args select 3;
                _TACOM_FSM = [_logic,"TACOM_FSM"] call ALiVE_fnc_HashGet;
                _objectives = [_logic,"objectives"] call ALiVE_fnc_HashGet;
                
                _pending_orders = [_logic,"pendingorders",[]] call ALiVE_fnc_HashGet;
                _pending_orders_tmp = _pending_orders;
                
                {
                    _id = [_x,"objectiveID"] call ALiVE_fnc_HashGet;
                    _section = [_x,"section",[]] call ALiVE_fnc_HashGet;
                    
                    if ((_profileID in _section) && {!(_objectiveID == _id)}) then {
                        _section = _section - [_profileID];
                        if (count _section < 1) then {[_x,"opcom_state","unassigned"] call ALiVE_fnc_HashSet; [_x,"opcom_orders","unassigned"] call ALiVE_fnc_HashSet};
                        [_x,"section",_section] call ALiVE_fnc_HashSet;
                    };
                } foreach _objectives;
                
                if (({(_x select 1) == _profileID} count _pending_orders_tmp) > 0) then {
                    {
                        if ((_x select 1) == _profileID) then {_pending_orders_tmp set [_foreachIndex,"x"]};
                    } foreach _pending_orders_tmp;
                    _pending_orders = _pending_orders_tmp - ["x"];
                };

				_profile = [ALIVE_profileHandler, "getProfile", _profileID] call ALIVE_fnc_profileHandler;

				[_profile, "clearWaypoints"] call ALIVE_fnc_profileEntity;
				_profileWaypoint = [_pos, 50] call ALIVE_fnc_createProfileWaypoint;

				_var = ["_TACOM_DATA",["completed",[_ProfileID,_objectiveID,_orders]]];
				_statements = format["%1 setfsmvariable %2",_TACOM_FSM,_var];
				[_profileWaypoint,"statements",["true",_statements]] call ALIVE_fnc_hashSet;

				[_profile, "addWaypoint", _profileWaypoint] call ALIVE_fnc_profileEntity;
                
                _ordersFull = [_pos,_ProfileID,_objectiveID,time];
                [_logic,"pendingorders",_pending_orders + [_ordersFull]] call ALiVE_fnc_HashSet;

                _result = _profileWaypoint;
		};
        
        case "synchronizeorders": {
            	ASSERT_TRUE(typeName _args == "STRING",str _args);
                
                private ["_ProfileIDInput","_profiles","_orders_pending","_synchronized","_item","_objectiveID","_profileID"];
        
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
					_timeout = (time - _time) > 1800;
			
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
                            case ("defend") : {
                                _available = _ProfileIDsReserve;
                                
                                //In emergency take nearest troops
                            	if (count _available < _size) then {
                                    _sectors = [[ALIVE_sectorGrid, "positionToSector", _position] call ALIVE_fnc_sectorGrid];
                					//_sectors = _sectors + ([ALIVE_sectorGrid, "surroundingSectors", _position] call ALIVE_fnc_sectorGrid);
									{
                                    
                            			_sectorData = [_x, "data"] call ALIVE_fnc_hashGet;
                                		_sortedProfiles = [_sectorData, "entitiesBySide", [_position,_side]] call ALIVE_fnc_sectorDataSort;
                                    	{_available set [count _available,_x select 0]} foreach _sortedProfiles;
                                     } foreach _sectors;
                                };
                            };
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
                	case ("unassigned") : {_idleStates = ["internal","unassigned"]};
                    case ("attack") : {_idleStates = ["internal","attack","attacking"]};
                    case ("defend") : {_idleStates = ["internal","defend","defending"]};
                    case ("reserve") : {_idleStates = ["internal","reserve","reserving","idle"]};
                    default {_idleStates = ["internal","reserve","reserving","idle"]};
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
            	private ["_target","_state","_DATA_TMP"];
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
                        if !(isnil "_target") then {
							[_target,"opcom_orders","attack"] call AliVE_fnc_HashSet;
							_DATA_TMP = ["execute",_target];
                        };
					};
					case ("unassigned") : {
						{
							_state = [_x,"opcom_state"] call AliVE_fnc_HashGet;
							if (_state == "unassigned") exitwith {_target = _x};
						} foreach ([_logic,"objectives",[]] call AliVE_fnc_HashGet);
		
						//Trigger order execution
                        if !(isnil "_target") then {
							[_target,"opcom_orders","attack"] call AliVE_fnc_HashSet;
							_DATA_TMP = ["execute",_target];
                        };
					};
                    case ("defend") : {
						{
							_state = [_x,"opcom_state"] call AliVE_fnc_HashGet;
							if (_state == "defend") exitwith {_target = _x};
						} foreach ([_logic,"objectives",[]] call AliVE_fnc_HashGet);
		
						//Trigger order execution
                        if !(isnil "_target") then {
							[_target,"opcom_orders","defend"] call AliVE_fnc_HashSet;
							_DATA_TMP = ["execute",_target];
                        };
					};
					case ("reserve") : {
						{
							_state = [_x,"opcom_state"] call AliVE_fnc_HashGet;
							if (_state == "reserve") exitwith {_target = _x};
						} foreach ([_logic,"objectives",[]] call AliVE_fnc_HashGet);;
		
						//Trigger order execution
                        if !(isnil "_target") then {
							[_target,"opcom_orders","reserve"] call AliVE_fnc_HashSet;
							_DATA_TMP = ["execute",_target];
                        };
					};
        		};
                if !(isnil "_DATA_TMP") then {_result = _DATA_TMP} else {player sidechat "no target was selected"};
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
