#include <\x\alive\addons\sys_logistics\script_component.hpp>
SCRIPT(logistics);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_logistics
Description:
Creates the server side object to store settings

Parameters:
Nil or Object - If Nil, return a new instance. If Object, reference an existing instance.
String - The selected function
Array,String,Number,Boolean - The selected parameters

Returns:
Array, String, Number, Any - The expected return value

Examples:
(begin example)
// Create instance by placing editor module
[_logic,"init"] call ALiVE_fnc_logistics;
(end)

See Also:
- <ALIVE_fnc_logisticsInit>

Author:
Highhead

Peer reviewed:
nil
---------------------------------------------------------------------------- */

#define SUPERCLASS ALIVE_fnc_baseClass
#define MAINCLASS ALIVE_fnc_logistics

private ["_result", "_operation", "_args", "_logic"];

PARAMS_1(_logic);
DEFAULT_PARAM(1,_operation,"");
DEFAULT_PARAM(2,_args,nil);

//Listener for special purposes
if (!isnil QMOD(SYS_LOGISTICS) && {MOD(SYS_LOGISTICS) getvariable [QGVAR(LISTENER),false]}) then {
	_blackOps = ["id"];
    
	if !(_operation in _blackOps) then {
	    _check = "nothing"; if !(isnil "_args") then {_check = _args};
        
		["op: %1 | args: %2",_operation,_check] call ALiVE_fnc_DumpR;
	};
};

TRACE_3("SYS_LOGISTICS",_logic, _operation, _args);

switch (_operation) do {
    
    	case "create": {
            if (isServer) then {
                
	            // Ensure only one module is used
	            if !(isNil QMOD(SYS_LOGISTICS)) then {
                	_logic = MOD(SYS_LOGISTICS);
                    ERROR_WITH_TITLE(str _logic, localize "STR_ALIVE_LOGISTICS_ERROR1");
	            } else {
	        		_logic = (createGroup sideLogic) createUnit ["ALiVE_SYS_LOGISTICS", [0,0], [], 0, "NONE"];
                    MOD(SYS_LOGISTICS) = _logic;
                };
                                
                //Push to clients
	            PublicVariable QMOD(SYS_LOGISTICS);
            };
            
            TRACE_1("Waiting for object to be ready",true);
            
            waituntil {!isnil QMOD(SYS_LOGISTICS)};
            
            TRACE_1("Creating class on all localities",true);
            
			// initialise module game logic on all localities
			MOD(SYS_LOGISTICS) setVariable ["super", QUOTE(SUPERCLASS)];
			MOD(SYS_LOGISTICS) setVariable ["class", QUOTE(MAINCLASS)];
            
            _result = MOD(SYS_LOGISTICS);
        };

        case "init": {
            
            ["%1 - Initialisation started...",_logic] call ALiVE_fnc_Dump;

            /*
            MODEL - no visual just reference data
            - module object datastorage parameters
            - Establish data handler on server
            - Establish data model on server and client
            */
            
            TRACE_1("Creating data store",true);

	        // Create logistics data storage in memory on all localities
	        GVAR(STORE) = [] call ALIVE_fnc_hashCreate;
            
            // Define logistics properties on all localities
            GVAR(CARRYABLE) = [["Man"],["Reammobox_F","Static","StaticWeapon","ThingX"],["House"]];
            GVAR(TOWABLE) = [["Truck_F"],["Car","Ship"],[]];
            GVAR(STOWABLE) = [["Car","Truck_F","Helicopter","Ship"],(GVAR(CARRYABLE) select 1),[]];
            GVAR(LIFTABLE) = [["Helicopter"],(GVAR(CARRYABLE) select 1) + (GVAR(TOWABLE) select 1),[]];
            
            //Define actions on all localities (just in case)
			GVAR(ACTIONS) = {
                private ["_logic"];
                
                _logic = MOD(SYS_LOGISTICS);

                if !(_logic getvariable ["DISABLECARRY",false]) then {[_logic,"addAction",[player,"carryObject"]] call ALiVE_fnc_logistics};
                if !(_logic getvariable ["DISABLECARRY",false]) then {[_logic,"addAction",[player,"dropObject"]] call ALiVE_fnc_logistics};
                if !(_logic getvariable ["DISABLELOAD",false]) then {[_logic,"addAction",[player,"stowObjects"]] call ALiVE_fnc_logistics};
                if !(_logic getvariable ["DISABLELOAD",false]) then {[_logic,"addAction",[player,"unloadObjects"]] call ALiVE_fnc_logistics};
                if !(_logic getvariable ["DISABLETOW",false]) then {[_logic,"addAction",[player,"towObject"]] call ALiVE_fnc_logistics};
                if !(_logic getvariable ["DISABLETOW",false]) then {[_logic,"addAction",[player,"untowObject"]] call ALiVE_fnc_logistics};
                if !(_logic getvariable ["DISABLELIFT",false]) then {[_logic,"addAction",[player,"liftObject"]] call ALiVE_fnc_logistics};
                if !(_logic getvariable ["DISABLELIFT",false]) then {[_logic,"addAction",[player,"releaseObject"]] call ALiVE_fnc_logistics};
                
                player setvariable [QGVAR(ACTIONS),true];
                true;
			};
                  
			// Define module basics on server
			if (isServer) then {

                // Wait for disable log module  to set module parameters
                if (["AliVE_SYS_LOGISTICSDISABLE"] call ALiVE_fnc_isModuleavailable) then {
                    waituntil {!isnil {MOD(SYS_LOGISTICS) getvariable "DEBUG"}};
                };

                // Reset states with provided data;
                if !(_logic getvariable ["DISABLEPERSISTENCE",false]) then {
                    if (isDedicated && {[QMOD(SYS_DATA)] call ALiVE_fnc_isModuleAvailable}) then {
                        waituntil {!isnil QMOD(SYS_DATA) && {MOD(SYS_DATA) getvariable ["startupComplete",false]}};
                    };
                    
	                _state = call ALiVE_fnc_logisticsLoadData;
	
	                if !(typeName _state == "BOOL") then {
	                    GVAR(STORE) = _state;
	                };
                };
                
                GVAR(STORE) call ALIVE_fnc_inspectHash;
            
            	[_logic,"state",GVAR(STORE)] call ALiVE_fnc_logistics;
                
                //Hack for hideObjectGlobal not working prior to mission runtime, thanks BIS
                [] spawn {
                    waituntil {time > 0};
                    
                    {if !(simulationEnabled _x) then {_x hideObjectGlobal true}} foreach ([MOD(SYS_LOGISTICS),"allObjects"] call ALiVE_fnc_logistics);
                };
                
                _logic setVariable ["init", true, true];
			};

            /*
            CONTROLLER  - coordination
            - check if an object is currently moved (= nearObjects attached to player)
            */

            // Wait until server init is finished
            waituntil {_logic getvariable ["init",false]};
            
            TRACE_1("Spawning Server processes",isServer);
            
            if (isServer) then {
                // Set eventhandlers for logistics objects
                //[_logic,"setEH",[_logic,"allObjects"] call ALiVE_fnc_logistics] call ALiVE_fnc_logistics;
            };

			TRACE_1("Spawning clientside processes",hasInterface);

            if (hasInterface) then {
                // Set eventhandlers for player
                [_logic,"setEH",[player]] call ALiVE_fnc_logistics;
            };
            
            /*
            VIEW - purely visual
            - initialise menu
            - frequent check to modify menu and display status (ALIVE_fnc_logisticsmenuDef)
            */

			TRACE_1("Adding menu on clients",hasInterface);

			// The machine has an interface? Must be a MP client, SP client or a client that acts as host!
            if (hasInterface) then {

                // Initialise interaction key if undefined
                if (isNil "SELF_INTERACTION_KEY") then {SELF_INTERACTION_KEY = [221,[false,false,false]];};

                TRACE_2("Menu pre-req",SELF_INTERACTION_KEY,ALIVE_fnc_logisticsMenuDef);

                // Initialise main menu
                [
                        "player",
                        [SELF_INTERACTION_KEY],
                        -9500,
                        [
                                "call ALIVE_fnc_logisticsMenuDef",
                                "main"
                        ]
                ] call ALiVE_fnc_flexiMenu_Add;
            };

            TRACE_1("After module init",_logic);
            
            // Indicate Init is finished on server
            if (isServer) then {
                _logic setVariable ["startupComplete", true, true];
            };
            
            ["%1 - Initialisation Completed...",MOD(SYS_LOGISTICS)] call ALiVE_fnc_Dump;
            
            _result = MOD(SYS_LOGISTICS);
        };

        case "updateObject": {
            if (isnil "_args") exitwith {};
            
            if !(isServer) exitwith {
                [[_logic, _operation, _args],"ALIVE_fnc_logistics", false, false] call BIS_fnc_MP;
            };
            
            private ["_objects"];

            switch (typeName _args) do {
                case ("ARRAY") : {_objects = _args};
                case ("OBJECT") : {_objects = [_args]};
                default {_objects = []};
            };
            
            {
            	private ["_args","_id","_cont"];
                
                //Ensure object is existing and not profiled
                if (!(isnil "_x") && {!(isNull _x)} && {isnil {_x getVariable "profileID"}}) then {
	                _id = [_logic,"id",_x] call ALiVE_fnc_logistics;
					_args = [GVAR(STORE),_id] call ALiVE_fnc_HashGet;
		            
                    //Create objecthash and add to store if not existing yet
		            if (isnil "_args") then {
		                _args = [] call ALIVE_fnc_hashCreate;
		                [GVAR(STORE),_id,_args] call ALiVE_fnc_HashSet;
		            };
	                
                    //Set static data
	                [_args,QGVAR(ID),_id] call ALiVE_fnc_HashSet;
		            [_args,QGVAR(TYPE),typeof _x] call ALiVE_fnc_HashSet;
		            [_args,QGVAR(POSITION),getposATL _x] call ALiVE_fnc_HashSet;
		            [_args,QGVAR(VECDIRANDUP),[vectorDir _x,vectorUp _x]] call ALiVE_fnc_HashSet;
                    [_args,QGVAR(CARGO),[_x] call ALiVE_fnc_getObjectCargo] call ALiVE_fnc_HashSet;
                    [_args,QGVAR(FUEL),[_x] call ALiVE_fnc_getObjectFuel] call ALiVE_fnc_HashSet;
                    [_args,QGVAR(DAMAGE),[_x] call ALiVE_fnc_getObjectDamage] call ALiVE_fnc_HashSet;
					
                    //Set dynamic data (to fight errors on loading back existing data from DB)
                    if (!isnil {_x getvariable QGVAR(CONTAINER)} && {!isnull (_x getvariable QGVAR(CONTAINER))}) then {
                        [_args,QGVAR(CONTAINER),(_x getvariable QGVAR(CONTAINER)) getvariable QGVAR(ID)] call ALiVE_fnc_HashSet;
                    } else {
                        [_args,QGVAR(CONTAINER)] call ALiVE_fnc_HashRem;
                    };
                    
		            //_args call ALiVE_fnc_InspectHash;
                };
            } foreach _objects;
            
            _result = _args;
        };
        
        case "removeObject": {
			if (isnil "_args") exitwith {};
            
            private ["_object","_id"];
            
            _object = [_args, 0, objNull, [objNull,""]] call BIS_fnc_param;

            switch (typeName _object) do {
                case ("OBJECT") : {_id = _object getvariable QGVAR(ID)};
                case ("STRING") : {[GVAR(STORE),_object] call ALiVE_fnc_HashRem};
            };
            
            if (isnil "_id") exitwith {_result = _object};

			[GVAR(STORE),_id] call ALiVE_fnc_HashRem;
            _object setvariable [QGVAR(ID),nil,true];
            
            //GVAR(STORE) call ALiVE_fnc_InspectHash;
            
            _result = GVAR(STORE) select 1;
        };
       
        case "id" : {
            if (isnil "_args") exitwith {};
            
            private ["_object","_id"];

            _object = [_args, 0, objNull, [objNull,""]] call BIS_fnc_param;
			_id = _object getvariable QGVAR(ID);
            
            if (isnil "_id") then {
				_id = format["%1_%2%3",typeof _object, floor(getposATL _object select 0),floor(getposATL _object select 1)];
				_object setvariable [QGVAR(ID),_id,true];
            };

            _result = _id;
        };
        
        case "carryObject": {
            if (isnil "_args") exitwith {};
            
            private ["_object","_container","_objectID","_containerID"];

            _object = [_args, 0, objNull, [objNull]] call BIS_fnc_param;
			_container = [_args, 1, objNull, [objNull]] call BIS_fnc_param;
            
            _objectID = [_logic,"id",_object] call ALiVE_fnc_logistics;
            _containerID = [_logic,"id",_container] call ALiVE_fnc_logistics;
            
            if !([_object,_container] call ALiVE_fnc_canCarry) exitwith {};
			
            _object attachTo [_container];
            
            [[_logic,"updateObject",[_container,_object]],"ALIVE_fnc_logistics", false, false] call BIS_fnc_MP;
           
            _result =_container; 
        };
        
        case "dropObject": {
            if (isnil "_args") exitwith {};
            
            private ["_object","_container","_objectID","_containerID"];
            
            _object = [_args, 0, objNull, [objNull]] call BIS_fnc_param;
			_container = [_args, 1, objNull, [objNull]] call BIS_fnc_param;
            
            _objectID = [_logic,"id",_object] call ALiVE_fnc_logistics;
            _containerID = [_logic,"id",_container] call ALiVE_fnc_logistics;
            
            if ([_object,_container] call ALiVE_fnc_canCarry) exitwith {};
            
            // Detach and reposition for a save placement
            detach _object;
            _object setposATL [getposATL _object select 0, getposATL _object select 1,0];
            
            [[_logic,"updateObject",[_container,_object]],"ALIVE_fnc_logistics", false, false] call BIS_fnc_MP;         
            
            _result = _object;
        };
        
		case "stowObject": {
            if (isnil "_args") exitwith {};
            
            //Do it globally so all clients are updated correctly all the time
            if !(isServer) exitwith {
                [[_logic, _operation, _args],"ALIVE_fnc_logistics", false, false] call BIS_fnc_MP;
            };
            
            private ["_object","_container","_objectID","_containerID"];
            
            _object = [_args, 0, objNull, [objNull]] call BIS_fnc_param;
			_container = [_args, 1, objNull, [objNull]] call BIS_fnc_param;
            
            _objectID = [_logic,"id",_object] call ALiVE_fnc_logistics;
            _containerID = [_logic,"id",_container] call ALiVE_fnc_logistics;
            
            if !([_object,_container] call ALiVE_fnc_canStow) exitwith {};
            
            [_logic,"dropObject",[_object,player]] call ALiVE_fnc_logistics;

            _object setvariable [QGVAR(CONTAINER),_container,true];
            _container setvariable [QGVAR(CARGO),(_container getvariable [QGVAR(CARGO),[]]) + [_object],true];

			if (isMultiplayer && isServer) then {_object hideObjectGlobal true; _object enableSimulationGlobal false} else {_object hideObject true; _object enableSimulation false};
            
			[_logic,"updateObject",[_container,_object]] call ALIVE_fnc_logistics;
            
            _result = _container;
        };
        
        case "stowObjects": {
            if (isnil "_args") exitwith {};
            
            private ["_object","_container","_objectID","_containerID"];
            
            _object = [_args, 0, objNull, [objNull]] call BIS_fnc_param;
			_container = [_args, 1, objNull, [objNull]] call BIS_fnc_param;
            
            _objectID = [_logic,"id",_object] call ALiVE_fnc_logistics;
            _containerID = [_logic,"id",_container] call ALiVE_fnc_logistics;
 
            {[_logic,"stowObject",[_x,_container]] call ALiVE_fnc_logistics} foreach (nearestObjects [_container, GVAR(STOWABLE) select 1, 15]);
            
            _result = _container;
        };
        
        case "unloadObject": {
            if (isnil "_args") exitwith {};
            
            //Do it globally so all clients are updated correctly all the time
            if !(isServer) exitwith {
                [[_logic, _operation, _args],"ALIVE_fnc_logistics", false, false] call BIS_fnc_MP;
            };

            private ["_object","_container","_objectID","_containerID"];
            
            _object = [_args, 0, objNull, [objNull]] call BIS_fnc_param;
			_container = [_args, 1, objNull, [objNull]] call BIS_fnc_param;
            
            _objectID = [_logic,"id",_object] call ALiVE_fnc_logistics;
            _containerID = [_logic,"id",_container] call ALiVE_fnc_logistics;
            
			if ([_object,_container] call ALiVE_fnc_canStow) exitwith {};

            _object setvariable [QGVAR(CONTAINER),nil,true];
            _container setvariable [QGVAR(CARGO),(_container getvariable [QGVAR(CARGO),[]]) - [_object],true];
            
			if (isMultiplayer && isServer) then {_object hideObjectGlobal false; _object enableSimulationGlobal true} else {_object hideObject false; _object enableSimulation true};
            _object setpos ([getpos _container, 0, 15, 2, 0, 20, 0, [],[[getpos _container,20] call CBA_fnc_Randpos]] call BIS_fnc_findSafePos);

			[_logic,"updateObject",[_container,_object]] call ALIVE_fnc_logistics;
            
            _result = _container;
        };
        
        case "unloadObjects": {
            if (isnil "_args") exitwith {};
            
            private ["_object","_container","_objectID","_containerID"];
            
            _object = [_args, 0, objNull, [objNull]] call BIS_fnc_param;
			_container = [_args, 1, objNull, [objNull]] call BIS_fnc_param;
            
            _objectID = [_logic,"id",_object] call ALiVE_fnc_logistics;
            _containerID = [_logic,"id",_container] call ALiVE_fnc_logistics;
            
            {[_logic,"unloadObject",[_x,_container]] call ALiVE_fnc_logistics} foreach (_container getvariable [QGVAR(CARGO),[]]);
            
            _result = _container;
        };
        
        case "towObject": {
            if (isnil "_args") exitwith {};
            
            private ["_object","_container","_objectID","_containerID"];
            
            _object = [_args, 0, objNull, [objNull]] call BIS_fnc_param;
			_container = [_args, 1, objNull, [objNull]] call BIS_fnc_param;
            
            _objectID = [_logic,"id",_object] call ALiVE_fnc_logistics;
            _containerID = [_logic,"id",_container] call ALiVE_fnc_logistics;
            
            if !([_object,_container] call ALiVE_fnc_canTow) exitwith {};
            
            _object attachTo [_container, [
				0,
				(boundingBox _container select 0 select 1) + (boundingBox _container select 0 select 1) + 2,
				(boundingBox _container select 0 select 2) - (boundingBox _container select 0 select 2) + 0.4
			]];
            
            _object setvariable [QGVAR(CONTAINER),_container,true];
            _container setvariable [QGVAR(CARGO_TOW),(_container getvariable [QGVAR(CARGO_TOW),[]]) + [_object],true];

			[[_logic,"updateObject",[_container,_object]],"ALIVE_fnc_logistics", false, false] call BIS_fnc_MP;

            _result = _container;
        };
        
        case "untowObject": {
            if (isnil "_args") exitwith {};
            
            private ["_object","_container","_objectID","_containerID"];
            
            _object = [_args, 0, objNull, [objNull]] call BIS_fnc_param;
			_container = [_args, 1, objNull, [objNull]] call BIS_fnc_param;
            
            _objectID = [_logic,"id",_object] call ALiVE_fnc_logistics;
            _containerID = [_logic,"id",_container] call ALiVE_fnc_logistics;
            
            if ([_object,_container] call ALiVE_fnc_canTow) exitwith {};

            _object setvariable [QGVAR(CONTAINER),nil,true];
            _container setvariable [QGVAR(CARGO_TOW),(_container getvariable [QGVAR(CARGO_TOW),[]]) - [_object],true];
                        
            detach _object;
            _object setposATL [getposATL _object select 0, getposATL _object select 1,0];
            
            [[_logic,"updateObject",[_container,_object]],"ALIVE_fnc_logistics", false, false] call BIS_fnc_MP;
            
            _result = _container;
        };
        
        case "liftObject": {
            if (isnil "_args") exitwith {};
            
            private ["_object","_container","_objectID","_containerID"];
            
            _object = [_args, 0, objNull, [objNull]] call BIS_fnc_param;
			_container = [_args, 1, objNull, [objNull]] call BIS_fnc_param;
            
            _objectID = [_logic,"id",_object] call ALiVE_fnc_logistics;
            _containerID = [_logic,"id",_container] call ALiVE_fnc_logistics;
            
            if !([_object,_container] call ALiVE_fnc_canLift) exitwith {};
            
			_object attachTo [
            	_container,
            	[0,0,(boundingBox _container select 0 select 2) - (boundingBox _object select 0 select 2) - (getPos _container select 2) + 0.5]
			];
            
            _object setvariable [QGVAR(CONTAINER),_container,true];
            _container setvariable [QGVAR(CARGO_LIFT),(_container getvariable [QGVAR(CARGO_LIFT),[]]) + [_object],true];
            
            [[_logic,"updateObject",[_container,_object]],"ALIVE_fnc_logistics", false, false] call BIS_fnc_MP;
            
            _result = _container;
        };
        
        case "releaseObject": {
            if (isnil "_args") exitwith {};
            
            private ["_object","_container","_objectID","_containerID"];
            
            _object = [_args, 0, objNull, [objNull]] call BIS_fnc_param;
			_container = [_args, 1, objNull, [objNull]] call BIS_fnc_param;
            
            _objectID = [_logic,"id",_object] call ALiVE_fnc_logistics;
            _containerID = [_logic,"id",_container] call ALiVE_fnc_logistics;
            
            if ([_object,_container] call ALiVE_fnc_canLift) exitwith {};
            
            _object setvariable [QGVAR(CONTAINER),nil,true];
            _container setvariable [QGVAR(CARGO_LIFT),(_container getvariable [QGVAR(CARGO_LIFT),[]]) - [_object],true];
                        
            detach _object;
            _object setposATL [getposATL _object select 0, getposATL _object select 1,0];
            
            [[_logic,"updateObject",[_container,_object]],"ALIVE_fnc_logistics", false, false] call BIS_fnc_MP;
            
            _result = _container;
        };
        
        case "addAction": {
	        private ["_object","_operation","_id","_condition","_text","_input","_container","_die"];
	
			_object = [_args, 0, objNull, [objNull,[]]] call BIS_fnc_param;
			_operation = [_args, 1, "", [""]] call BIS_fnc_param;
			
			switch (typename _object) do {
			    case ("ARRAY") : {_object = _object select 0};
			    default {};
			};

			switch (_operation) do {
				case ("carryObject") : {
                    _text = "Carry object";
                	_input = "cursortarget";
                    _container = "_this select 1";
                    _condition = "isnil {cursortarget getvariable 'ALiVE_SYS_LOGISTICS_CONTAINER'} && {cursortarget distance _target < 5} && {[cursortarget,_target] call ALiVE_fnc_canCarry}";
				};
			    case ("dropObject") : {
                    _text = "Drop object";
                    _input = "call {private ['_objs','_result']; _objs = attachedObjects (_this select 1); {if (!isnull _x) exitwith {_result = _x}} foreach _objs; _result}";
                    _container = "_this select 1";
                    _condition = "({!isnull _x} count (attachedObjects _target)) > 0";
                };
                case ("unloadObjects") : {
                    _text = "Load out cargo"; 
                    _input = "cursortarget"; 
                    _container = "((nearestObjects [_this select 1, ALiVE_SYS_LOGISTICS_STOWABLE select 0, 8]) select 0)"; 
                    _condition = "cursortarget distance _target < 5 && {count (cursortarget getvariable ['ALiVE_SYS_LOGISTICS_CARGO',[]]) > 0}";
                };
                case ("stowObjects") : {
                    _text  = "Stow in cargo"; 
                    _input = "objNull"; 
                    _container = "cursortarget"; 
                    _condition = "cursortarget distance _target < 5 && {[((nearestObjects [cursortarget, ALiVE_SYS_LOGISTICS_STOWABLE select 1, 8]) select 0),cursortarget] call ALiVE_fnc_canStow}";
                };
                case ("towObject") : {
                    _text  = "Tow object";
                    _input = "cursortarget";
                    _container = "((nearestObjects [_this select 1, ALiVE_SYS_LOGISTICS_TOWABLE select 0, 8]) select 0)";
                    _condition = "cursortarget distance player < 5 && {[cursortarget,(nearestObjects [cursortarget, ALiVE_SYS_LOGISTICS_TOWABLE select 0, 8]) select 0] call ALiVE_fnc_canTow}";
                };
                case ("untowObject") : {
                    _text  = "Untow object";
                    _input = "cursortarget";
                    _container = "attachedTo cursortarget";
                    _condition = "cursortarget distance _target < 5 && {{_x == cursortarget} count ((attachedTo cursortarget) getvariable ['ALiVE_SYS_LOGISTICS_CARGO_TOW',[]]) > 0}";
                };
                case ("liftObject") : {
                    _text  = "Lift object";
                    _input = "((nearestObjects [vehicle (_this select 1), ALiVE_SYS_LOGISTICS_LIFTABLE select 1, 15]) select 0)";
                    _container = "vehicle (_this select 1)";
                    _condition = "(getposATL (vehicle _target) select 2) > 5 && {(getposATL (vehicle _target) select 2) < 15} && {[(nearestObjects [vehicle (_target), ALiVE_SYS_LOGISTICS_LIFTABLE select 1, 15]) select 0, vehicle _target] call ALiVE_fnc_canLift}";
                };
                case ("releaseObject") : {
                    _text  = "Release object";
                    _input = "attachedObjects (vehicle (_this select 1)) select 0";
                    _container = "vehicle (_this select 1)";
                    _condition = "(getposATL (vehicle _target) select 2) > 5 && {(getposATL (vehicle _target) select 2) < 15} && {count ((vehicle _target) getvariable ['ALiVE_SYS_LOGISTICS_CARGO_LIFT',[]]) > 0}";
            	};
                default {_die = true};
			};
            
            if !(isnil "_die") exitwith {_result = -1};
			
			_id = _object addAction [
				_text,
				{[MOD(SYS_LOGISTICS),(_this select 3 select 0),[call compile (_this select 3 select 1), call compile (_this select 3 select 2)]] call ALiVE_fnc_logistics},
				[_operation,_input,_container],
				1,
				false,
				true,
				"",
				_condition
			];
            
            _object setvariable [format["ALiVE_SYS_LOGISTICS_%1",_operation],_id];
			
			_result = _id;
        };

        case "removeAction": {
            if (isnil "_args") exitwith {};
            
	        private ["_object","_operation","_id"];
	
			_object = [_args, 0, objNull, [objNull,[]]] call BIS_fnc_param;
			_operation = [_args, 1, "", [""]] call BIS_fnc_param;

			_id = _object getvariable [format["ALiVE_SYS_LOGISTICS_%1",_operation],-1];
            _object setvariable [format["ALiVE_SYS_LOGISTICS_%1",_operation],nil];
            _object removeAction _id;
            
			_result = _id;
        };
        
        case "addActions": {
            if !(hasInterface) exitwith {};
            
			_result = call GVAR(ACTIONS);
        };
        
        case "removeActions": {
			if !(hasInterface) exitwith {};

            [_logic,"removeAction",[player,"carryObject"]] call ALiVE_fnc_logistics;
            [_logic,"removeAction",[player,"dropObject"]] call ALiVE_fnc_logistics;
            [_logic,"removeAction",[player,"stowObjects"]] call ALiVE_fnc_logistics;
            [_logic,"removeAction",[player,"unloadObjects"]] call ALiVE_fnc_logistics;
            [_logic,"removeAction",[player,"towObject"]] call ALiVE_fnc_logistics;
            [_logic,"removeAction",[player,"untowObject"]] call ALiVE_fnc_logistics;
            [_logic,"removeAction",[player,"liftObject"]] call ALiVE_fnc_logistics;
            [_logic,"removeAction",[player,"releaseObject"]] call ALiVE_fnc_logistics;

			player setvariable [QGVAR(ACTIONS),nil];

			_result = false;
        };
        
        case "setEH" : {
            if (isnil "_args") exitwith {};
            
            private ["_objects"];

			switch (typeName _args) do {
                case ("OBJECT") : {_objects = [_args]};
                case ("ARRAY") : {_objects = _args};
                default {_objects = _args};
            };
       
            {
                private ["_object"];
                
                _object = _x;
                
	            //Clientside only section below
				if (hasInterface) then {
					//apply these EHs on players
					_object setvariable [QGVAR(EH_INVENTORYCLOSED), _object getvariable [QGVAR(EH_INVENTORYCLOSED), _object addEventHandler ["InventoryClosed", {[ALiVE_SYS_LOGISTICS,"updateObject",[_this select 1, _this select 0]] call ALIVE_fnc_logistics; if (!isnil QMOD(SYS_LOGISTICS) && {MOD(SYS_LOGISTICS) getvariable [QGVAR(LISTENER),false]}) then {["ALiVE SYS LOGISTICS EH InventoryClosed firing"] call ALiVE_fnc_DumpR}}]]];
				};
            
	            //Serverside only section below
	            if (isServer) then {
		            //apply these EHs on all objects
		            _object setvariable [QGVAR(EH_KILLED), _object getvariable [QGVAR(EH_KILLED), _object addEventHandler ["Killed", {[ALiVE_SYS_LOGISTICS,"removeObject",_this select 0] call ALIVE_fnc_logistics; if (!isnil QMOD(SYS_LOGISTICS) && {MOD(SYS_LOGISTICS) getvariable [QGVAR(LISTENER),false]}) then {["ALiVE SYS LOGISTICS EH Killed firing"] call ALiVE_fnc_DumpR}}]]];

		            //apply these EHs on vehicles
		            if ({_object isKindOf _x} count ["LandVehicle","Air","Ship"] > 0) then {
		            	_object setvariable [QGVAR(EH_GETOUT), _object getvariable [QGVAR(EH_GETOUT), _object addEventHandler ["GetOut", {if !((_this select 1) == "cargo") then {[ALiVE_SYS_LOGISTICS,"updateObject",[_this select 0]] call ALIVE_fnc_logistics; if (!isnil QMOD(SYS_LOGISTICS) && {MOD(SYS_LOGISTICS) getvariable [QGVAR(LISTENER),false]}) then {["ALiVE SYS LOGISTICS EH Getout firing"] call ALiVE_fnc_DumpR}}}]]];
		            };
	            };
            } foreach _objects;
            
            _result = _objects;
        };
                
        case "allObjects" : {
			if (isnil "_args" || {isnull _args}) then {_args = []};
            
            private ["_position","_radius","_list","_objects"];

            _position = [_args, 0, getArray(configFile >> "CfgWorlds" >> worldName >> "centerPosition")] call BIS_fnc_param;
            _radius = [_args, 1, 30000] call BIS_fnc_param;
            _list = [_args, 2, ["Reammobox_F","Static","ThingX","LandVehicle","Air"]] call BIS_fnc_param;
            
            _objects = [];
            {
            	private ["_object"];
                
	            _object = _x;
	            if ((_x distance _position <= _radius) && {({_object iskindOf _x} count _list) > 0}) then {
	                _objects set [count _objects,_object];
	            };
            } foreach (allMissionObjects "");
            
            _result = _objects;
        };
                        
        case "destroy": {
            [[_logic, "destroyGlobal",_args],"ALIVE_fnc_logistics",true, false] call BIS_fnc_MP;
        };

        case "destroyGlobal": {

                [_logic, "debug", false] call MAINCLASS;

                if (isServer) then {
                		// if server
                        MOD(SYS_LOGISTICS) = _logic;

                        MOD(SYS_LOGISTICS) setVariable ["super", nil];
                        MOD(SYS_LOGISTICS) setVariable ["class", nil];
                        MOD(SYS_LOGISTICS) setVariable ["init", nil];
                                
                        // and publicVariable to clients
                        
                        publicVariable QMOD(SYS_LOGISTICS);
                        [_logic, "destroy"] call SUPERCLASS;
                };

                if (hasInterface) then {
                    	{[MOD(SYS_LOGISTICS),"removeAction",[player,_x]] call ALiVE_fnc_logistics} foreach ["carryObject","dropObject","stowObjects","unloadObjects","towObject","untowObject","liftObject","releaseObject"];
                    
                        // remove main menu
                        [
                                "player",
                                [SELF_INTERACTION_KEY],
                                -9500,
                                [
                                        "call ALIVE_fnc_logisticsMenuDef",
                                        "main"
                                ]
                        ] call ALiVE_fnc_flexiMenu_Remove;
                };
        };
        
        case "state" : {
            if ((isnil "_args") || {!isServer}) exitwith {_result = GVAR(STORE)};
            
            private ["_startObjects"];

            //Get all logistics objects
            TRACE_1("ALiVE SYS LOGISTICS Finding SYS_LOGISTICS objects!",_logic);
            
            _startObjects = [_logic,"allObjects"] call ALiVE_fnc_logistics;
            
            //Set ID on all startobjects
            TRACE_1("ALiVE SYS LOGISTICS Setting IDs and EHs on existing objects!",_logic);

            {[_logic,"id",_x] call ALiVE_fnc_logistics; [_logic,"setEH",[_x]] call ALiVE_fnc_logistics} foreach _startObjects;
            
            //Check if provided data is valid
            if (count (_args select 1) == 0) exitwith {};
            
            private ["_collection"];
            
            //Reset store with provided data
            GVAR(STORE) set [1,_args select 1];
            GVAR(STORE) set [2,_args select 2];
            
            //defaults
            _createdObjects = [];
            _existing = [];
            _blacklist = ["Man"];

            //if objectID is existing in store then reapply object state (_pos,_vecDirUp,_damage,_fuel)
            {
                private ["_id","_args"];

                _id = [MOD(SYS_LOGISTICS),"id",_x] call ALiVE_fnc_logistics;
                _args = [GVAR(STORE),_id] call ALiVE_fnc_HashGet;

                if !(isnil "_args") then {
                    private ["_pos","_vDirUp","_container","_cargo"];

					TRACE_1("ALiVE SYS LOGISTICS Resetting state of existing object!",_x);

                    //apply values
		            _x setposATL ([_args,QGVAR(POSITION)] call ALiVE_fnc_HashGet);
                    _x setVectorDirAndUp ([_args,QGVAR(VECDIRANDUP)] call ALiVE_fnc_HashGet);

                    //remove in next step
					_existing set [count _existing,_id];
                };
            } foreach _startObjects;

            //create non existing vehicles
            {
                private ["_args","_object"];

                _args = [GVAR(STORE),_x] call ALiVE_fnc_HashGet;
                _type = ([_args,QGVAR(TYPE)] call ALiVE_fnc_hashGet);
                
                if (({_type iskindOf _x} count _blacklist) == 0) then {
                    
                    TRACE_1("ALiVE SYS LOGISTICS Creating non existing object from store!",_x);
                    
					_object = _type createVehicle ([_args,QGVAR(POSITION)] call ALiVE_fnc_hashGet);
	                _object setvariable [QGVAR(ID),_x,true];
	            	_object setposATL ([_args,QGVAR(POSITION)] call ALiVE_fnc_HashGet);
	                _object setVectorDirAndUp ([_args,QGVAR(VECDIRANDUP)] call ALiVE_fnc_HashGet);
	                
	                _createdObjects set [count _createdObjects,_object];
                } else {
                    TRACE_1("ALiVE SYS LOGISTICS Removing non-existing unit from store!",_x);
                    
                    [_logic,"removeObject",_x] call ALiVE_fnc_logistics;
                };
             } foreach ((GVAR(STORE) select 1) - _existing);
             
             //reset cargo
             {
                _args = [GVAR(STORE),_x getvariable QGVAR(ID)] call ALiVE_fnc_HashGet;

                if !(isnil "_args") then {
                    
                    TRACE_1("ALiVE SYS LOGISTICS Resetting cargo for object!",_x);
                	[_x,_args] call ALiVE_fnc_setObjectState;
                };
             } foreach (_startObjects + _createdObjects);

            _result = GVAR(STORE);
        };
        
        case "convertData": {
    		if (isnil "_args") exitwith {};
    
			private ["_data","_convertedData","_selection_1","_selection_2"];
            
			_data = _args;
            
            if !(typeName _data == "ARRAY" && {count _data > 2} && {count (_data select 2) > 0}) exitwith {_result = _data};
            
            _dataSet = [
				[QGVAR(ID),"ASL_ID"],
				[QGVAR(TYPE),"ASL_TY"],
				[QGVAR(POSITION),"ASL_PO"],
				[QGVAR(VECDIRANDUP),"ASL_VD"],
				[QGVAR(CARGO),"ASL_CA"],
				[QGVAR(FUEL),"ASL_FU"],
				[QGVAR(DAMAGE),"ASL_DA"],
				[QGVAR(CONTAINER),"ASL_CO"],
				["_rev","_rev"]
            ];
            
            _convertedData = [] call ALIVE_fnc_hashCreate;
            
            if (isnil {[(_data select 2 select 1),"ASL_ID"] call ALiVE_fnc_HashGet}) then {
				_selection_1 = {_x select 1};
				_selection_2 = {_x select 0};
            } else {
				_selection_1 = {_x select 0};
				_selection_2 = {_x select 1};
            };
            
            {
                private ["_convertedObject","_args"];
                
                _convertedObject = [] call ALIVE_fnc_hashCreate;
                _args = [_data,_x] call ALiVE_fnc_HashGet;
                
                {[_convertedObject,call _selection_1,[_args,call _selection_2] call ALiVE_fnc_HashGet] call ALiVE_fnc_HashSet} foreach _dataSet;
                
                [_convertedData,_x,_convertedObject] call ALiVE_fnc_HashSet;
            } foreach (_data select 1);
            
            _convertedData call ALiVE_fnc_InspectHash;
            
            _result = _convertedData;
        };
                
        default {
            _result = [_logic, _operation, _args] call SUPERCLASS;
        };
};

TRACE_1("ALiVE SYS LOGISTICS - output",_result);

if !(isnil "_result") then {
    _result;
};
