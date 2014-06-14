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

_logic = [_this, 0, objNull, [objNull,[]]] call BIS_fnc_param;
_operation = [_this, 1, "", [""]] call BIS_fnc_param;
_args = [_this, 2, objNull, [objNull,[],"",0,true,false]] call BIS_fnc_param;

TRACE_3("SYS_LOGISTICS",_logic, _operation, _args);

switch (_operation) do {
    
    	case "create": {
            _logic = (createGroup sideLogic) createUnit ["LOGIC", [0,0], [], 0, "NONE"];
            _result = _logic;
        };

        case "init": {
            
            // Ensure only one module is used
            if (isServer && !(isNil QMOD(SYS_LOGISTICS))) exitWith {
                    ERROR_WITH_TITLE(str _logic, localize "STR_ALIVE_LOGISTICS_ERROR1");
            };
            
            ["%1 - Initialisation started...",_logic] call ALiVE_fnc_Dump;

            /*
            MODEL - no visual just reference data
            - module object datastorage parameters
            - Establish data handler on server
            - Establish data model on server and client
            */
            
            TRACE_1("Creating class on all localities",true);
            
			// initialise module game logic on all localities
			_logic setVariable ["super", QUOTE(SUPERCLASS)];
			_logic setVariable ["class", QUOTE(MAINCLASS)];
            
            TRACE_1("Creating data store",true);

            // Create logistics data storage in memory on all localities
            GVAR(STORE) = [] call ALIVE_fnc_hashCreate;
            
            // Define logistics properties on all localities
            GVAR(CARRYABLE) = [["Man"],["Reammobox_F","Static","ThingX"]];
            GVAR(TOWABLE) = [["Truck_F"],["Car"]];
            GVAR(STOWABLE) = [["Car","Truck_F"],(GVAR(CARRYABLE) select 1)];
            GVAR(LIFTABLE) = [["Helicopter"],(GVAR(CARRYABLE) select 1) + (GVAR(TOWABLE) select 1)];
            
			// Define module basics on server
			if (isServer) then {
                MOD(SYS_LOGISTICS) = _logic;
                
                // Set Module (default) parameters as correct types
                MOD(SYS_LOGISTICS) setVariable ["debug", call compile (_logic getvariable ["debug","false"]), true];

                //Wait for data to init?
                //not yet, but do so once pers is on the way for this module

                // Push to clients
                publicVariable QMOD(SYS_LOGISTICS);
			};

            /*
            CONTROLLER  - coordination
            - check if an object is currently moved (= nearObjects attached to player)
            */
            
            TRACE_1("Spawning Server processes",isServer);
            
            if (isServer) then {
            };

			TRACE_1("Spawning clientside processes",hasInterface);

            if (hasInterface) then {
                _fnc_addActions = {
	                [MOD(SYS_LOGISTICS),"addAction",[player,"carryObject"]] call ALiVE_fnc_logistics;
	                [MOD(SYS_LOGISTICS),"addAction",[player,"dropObject"]] call ALiVE_fnc_logistics;
	                [MOD(SYS_LOGISTICS),"addAction",[player,"stowObjects"]] call ALiVE_fnc_logistics;
	                [MOD(SYS_LOGISTICS),"addAction",[player,"unloadObjects"]] call ALiVE_fnc_logistics;
                    [MOD(SYS_LOGISTICS),"addAction",[player,"towObject"]] call ALiVE_fnc_logistics;
                    [MOD(SYS_LOGISTICS),"addAction",[player,"untowObject"]] call ALiVE_fnc_logistics;
                    [MOD(SYS_LOGISTICS),"addAction",[player,"liftObject"]] call ALiVE_fnc_logistics;
                    [MOD(SYS_LOGISTICS),"addAction",[player,"releaseObject"]] call ALiVE_fnc_logistics;
                };
                
                player addEventhandler ["respawn", _fnc_addActions];
                call _fnc_addActions;
            };
            
            /*
            VIEW - purely visual
            - initialise menu
            - frequent check to modify menu and display status (ALIVE_fnc_logisticsmenuDef)
            */

			TRACE_1("Adding menu on clients",hasInterface);

			//The machine has an interface? Must be a MP client, SP client or a client that acts as host!
            if (hasInterface) then {
                //Wait until server init is finished
            	waitUntil {!isNil QMOD(SYS_LOGISTICS)};
            
                // Initialise interaction key if undefined
                if (isNil "SELF_INTERACTION_KEY") then {SELF_INTERACTION_KEY = [221,[false,false,false]];};

                TRACE_2("Menu pre-req",SELF_INTERACTION_KEY,ALIVE_fnc_logisticsMenuDef);

                // initialise main menu
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
            	MOD(SYS_LOGISTICS) setVariable ["init", true, true];
            };
            
            ["%1 - Initialisation Completed...",MOD(SYS_LOGISTICS)] call ALiVE_fnc_Dump;
            
            _result = MOD(SYS_LOGISTICS);
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

        case "updateObject": {
            if (isnil "_args") exitwith {};
            
            private ["_object","_id"];
            //_object = [_args, 0, objNull, [objNull,"",[]]] call BIS_fnc_param;

			_object = [_args, 0, objNull, [objNull,""]] call BIS_fnc_param;
            switch (typeName _object) do {
                case ("OBJECT") : {_id = _object getvariable [QGVAR(ID),format["%1_%2%3",typeof _object, floor(getposATL _object select 0),floor(getposATL _object select 1)]]};
                case ("STRING") : {_id = _object};

            };
            
            private ["_args","_id"];
            
			_args = [GVAR(STORE),_id] call ALiVE_fnc_HashGet;
            
            if (isnil "_args") then {
                _object setvariable [QGVAR(ID),_id,true];
                
                _args = [] call ALIVE_fnc_hashCreate;
                [GVAR(STORE),_id,_args] call ALiVE_fnc_HashSet;
            };
            
            [_args,"type",typeof _object] call ALiVE_fnc_HashSet;
            [_args,"position",getposATL _object] call ALiVE_fnc_HashSet;
            [_args,"vectorDirAndUp",[vectorDir _object,vectorUp _object]] call ALiVE_fnc_HashSet;
            [_args,"container",([GVAR(STORE),((_object getvariable QGVAR(CONTAINER)) getvariable QGVAR(ID)),[]] call ALiVE_fnc_HashGet)] call ALiVE_fnc_HashSet;
            [_args,"cargo",[_object] call ALiVE_fnc_getObjectCargo] call ALiVE_fnc_HashSet;
            
            _result = _args;
        };
        
        case "removeObject": {
            if (isnil "_args") exitwith {};
            
            private ["_object","_id"];
            
            _object = [_args, 0, objNull, [objNull,""]] call BIS_fnc_param;

            switch (typeName _object) do {
                case ("OBJECT") : {_id = _object getvariable [QGVAR(ID),format["%1_%2%3",typeof _object, floor(getposATL _object select 0),floor(getposATL _object select 1)]]};
                case ("STRING") : {_id = _object};
            };
            
            [GVAR(STORE),_id] call ALiVE_fnc_HashRem;
            _object setvariable [QGVAR(ID),nil,true];
            
            _result = GVAR(STORE) select 1;
        };
                        
        case "addAction": {
	        private ["_object","_operation","_id","_condition","_text","_input","_container","_die"];
	
			_object = [_args, 0, objNull, [objNull,[]]] call BIS_fnc_param;
			_operation = [_args, 1, "", [""]] call BIS_fnc_param;
			
			switch (typename _object) do {
			    case ("ARRAY") : {_object = _object select 0};
			    default {};
			};
            
            _id = (_object getvariable [format["ALiVE_SYS_LOGISTICS_%1",_operation],-1]); if (_id > -1) exitwith {_result = _id};
			
			switch (_operation) do {
				case ("carryObject") : {
                    _text = "Carry object";
                	_input = "cursortarget";
                    _container = "_this select 1";
                    _condition = "isnil {cursortarget getvariable 'ALiVE_SYS_LOGISTICS_CONTAINER'} && {cursortarget distance _target < 5} && {[cursortarget,_target] call ALiVE_fnc_canCarry}";
				};
			    case ("dropObject") : {
                    _text = "Drop object";
                    _input = "(attachedObjects (_this select 1)) select 0";
                    _container = "_this select 1";
                    _condition = "({!(isnil {_x getvariable 'ALiVE_SYS_LOGISTICS_CONTAINER'})} count (attachedObjects _target)) > 0";
                };
                case ("unloadObjects") : {
                    _text = "Load out cargo"; 
                    _input = "cursortarget"; 
                    _container = "((nearestObjects [_this select 1, ALiVE_SYS_LOGISTICS_STOWABLE select 0, 8]) select 0)"; 
                    _condition = "count (cursortarget getvariable ['ALiVE_SYS_LOGISTICS_CARGO',[]]) > 0";
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
            
	        private ["_object","_action","_id"];
	
			_object = [_args, 0, objNull, [objNull,[]]] call BIS_fnc_param;
			_action = [_args, 1, "", [""]] call BIS_fnc_param;

			_id = _object getvariable [format["ALiVE_SYS_LOGISTICS_%1",_action],-1];
            _object setvariable [format["ALiVE_SYS_LOGISTICS_%1",_operation],nil];
            _object removeAction _id;
            
			_result = _id;
        };
        
        case "carryObject": {
            if (isnil "_args") exitwith {};
            
            private ["_object","_container","_id"];

            _object = [_args, 0, objNull, [objNull]] call BIS_fnc_param;
			_container = [_args, 1, objNull, [objNull]] call BIS_fnc_param;
            
            if !([_object,_container] call ALiVE_fnc_canCarry) exitwith {};

            _object setvariable [QGVAR(CONTAINER),_container,true];
            _object attachTo [_container];
            
            [[_logic,"updateObject",_object],"ALIVE_fnc_logistics", false, false] call BIS_fnc_MP;
           
            _result =_container; 
        };
        
        case "dropObject": {
            if (isnil "_args") exitwith {};
            
            private ["_object","_container"];
            
            _object = [_args, 0, objNull, [objNull]] call BIS_fnc_param;
			_container = [_args, 1, objNull, [objNull]] call BIS_fnc_param;
            
            if ([_object,_container] call ALiVE_fnc_canCarry) exitwith {};

            _object setvariable [QGVAR(CONTAINER),nil,true];
            
            //Detach and reposition for a save placement
            detach _object;
            _object setposATL [getposATL _object select 0, getposATL _object select 1,0];
            _object setvelocity [0,0,-1];
            
            [[_logic,"updateObject",_object],"ALIVE_fnc_logistics", false, false] call BIS_fnc_MP;            
            
            _result = _object;
        };
        
		case "stowObject": {
            if (isnil "_args") exitwith {};
            
            //Do it globally so all clients are updated correctly all the time
            if !(isServer) exitwith {
                [[_logic, _operation, _args],"ALIVE_fnc_logistics", false, false] call BIS_fnc_MP;
            };
            
            private ["_object","_container"];
       
			_object = [_args, 0, objNull, [objNull]] call BIS_fnc_param;
			_container = [_args, 1, objNull, [objNull]] call BIS_fnc_param;
            
            if !([_object,_container] call ALiVE_fnc_canStow) exitwith {};
            
            [_logic,"dropObject",[_object,player]] call ALiVE_fnc_logistics;

            _object setvariable [QGVAR(CONTAINER),_container,true];
            _container setvariable [QGVAR(CARGO),(_container getvariable [QGVAR(CARGO),[]]) + [_object],true];

			if (isMultiplayer && isServer) then {_object hideObjectGlobal true; _object enableSimulationGlobal false} else {_object hideObject true; _object enableSimulation false};

			[_logic,"updateObject",_object] call ALIVE_fnc_logistics;
            [_logic,"updateObject",_container] call ALIVE_fnc_logistics;
            
            _result = _container;
        };
        
        case "stowObjects": {
            if (isnil "_args") exitwith {};
            
            private ["_object","_container","_nearObjects"];
                       
			_object = [_args, 0, objNull, [objNull]] call BIS_fnc_param;
			_container = [_args, 1, objNull, [objNull]] call BIS_fnc_param;
 
            {[_logic,"stowObject",[_x,_container]] call ALiVE_fnc_logistics} foreach (nearestObjects [_container, GVAR(STOWABLE) select 1, 15]);
            
            _result = _container;
        };
        
        case "unloadObject": {
            if (isnil "_args") exitwith {};
            
            //Do it globally so all clients are updated correctly all the time
            if !(isServer) exitwith {
                [[_logic, _operation, _args],"ALIVE_fnc_logistics", false, false] call BIS_fnc_MP;
            };

            private ["_object","_container"];
                       
			_object = [_args, 0, objNull, [objNull]] call BIS_fnc_param;
			_container = [_args, 1, objNull, [objNull]] call BIS_fnc_param;
            
			if ([_object,_container] call ALiVE_fnc_canStow) exitwith {};

            _object setvariable [QGVAR(CONTAINER),nil,true];
            _container setvariable [QGVAR(CARGO),(_container getvariable [QGVAR(CARGO),[]]) - [_object],true];
            
			_object setpos ([getpos _container, 0, 15, 2, 0, 20, 0, [],[[getpos _container,20] call CBA_fnc_Randpos]] call BIS_fnc_findSafePos);
			if (isMultiplayer && isServer) then {_object hideObjectGlobal false; _object enableSimulationGlobal true} else {_object hideObject false; _object enableSimulation true};

			[_logic,"updateObject",_object] call ALIVE_fnc_logistics;
            [_logic,"updateObject",_container] call ALIVE_fnc_logistics;
            
            _result = _container;
        };
        
        case "unloadObjects": {
            if (isnil "_args") exitwith {};
            
            private ["_object","_container","_cargo","_pos"];
                     
			_object = [_args, 0, objNull, [objNull]] call BIS_fnc_param;
			_container = [_args, 1, objNull, [objNull]] call BIS_fnc_param;
            
            {[_logic,"unloadObject",[_x,_container]] call ALiVE_fnc_logistics} foreach (_container getvariable [QGVAR(CARGO),[]]);
            
            _result = _container;
        };
        
        case "towObject": {
            if (isnil "_args") exitwith {};
            
            private ["_object","_container"];
            
			_object = [_args, 0, objNull, [objNull]] call BIS_fnc_param;
			_container = [_args, 1, objNull, [objNull]] call BIS_fnc_param;
            
            if !([_object,_container] call ALiVE_fnc_canTow) exitwith {};
            
            _object attachTo [_container, [
				0,
				(boundingBox _container select 0 select 1) + (boundingBox _container select 0 select 1) + 2,
				(boundingBox _container select 0 select 2) - (boundingBox _container select 0 select 2) + 0.4
			]];
            
            _object setvariable [QGVAR(CONTAINER),_container,true];
            _container setvariable [QGVAR(CARGO_TOW),(_container getvariable [QGVAR(CARGO_TOW),[]]) + [_object],true];

			[[_logic,"updateObject",_object],"ALIVE_fnc_logistics", false, false] call BIS_fnc_MP;

            _result = _container;
        };
        
        case "untowObject": {
            if (isnil "_args") exitwith {};
            
            private ["_object","_container"];
            
			_object = [_args, 0, objNull, [objNull]] call BIS_fnc_param;
			_container = [_args, 1, objNull, [objNull]] call BIS_fnc_param;
            
            if ([_object,_container] call ALiVE_fnc_canTow) exitwith {};

            _object setvariable [QGVAR(CONTAINER),nil,true];
            _container setvariable [QGVAR(CARGO_TOW),(_container getvariable [QGVAR(CARGO_TOW),[]]) - [_object],true];
                        
            detach _object;
            _object setposATL [getposATL _object select 0, getposATL _object select 1,0];
            
            [[_logic,"updateObject",_object],"ALIVE_fnc_logistics", false, false] call BIS_fnc_MP;
            
            _result = _container;
        };
        
        case "liftObject": {
            if (isnil "_args") exitwith {};
            
            private ["_object","_caller","_target"];
            
			_object = [_args, 0, objNull, [objNull]] call BIS_fnc_param;
			_container = [_args, 1, objNull, [objNull]] call BIS_fnc_param;
            
            if !([_object,_container] call ALiVE_fnc_canLift) exitwith {};
            
			_object attachTo [
            	_container,
            	[0,0,(boundingBox _container select 0 select 2) - (boundingBox _object select 0 select 2) - (getPos _container select 2) + 0.5]
			];
            
            _object setvariable [QGVAR(CONTAINER),_container,true];
            _container setvariable [QGVAR(CARGO_LIFT),(_container getvariable [QGVAR(CARGO_LIFT),[]]) + [_object],true];
            
            [[_logic,"updateObject",_object],"ALIVE_fnc_logistics", false, false] call BIS_fnc_MP;
            
            _result = _container;
        };
        
        case "releaseObject": {
            if (isnil "_args") exitwith {};
            
            private ["_object","_caller","_target"];
            
			_object = [_args, 0, objNull, [objNull]] call BIS_fnc_param;
			_container = [_args, 1, objNull, [objNull]] call BIS_fnc_param;
            
            if ([_object,_container] call ALiVE_fnc_canLift) exitwith {};
            
            _object setvariable [QGVAR(CONTAINER),nil,true];
            _container setvariable [QGVAR(CARGO_LIFT),(_container getvariable [QGVAR(CARGO_LIFT),[]]) - [_object],true];
                        
            detach _object;
            _object setposATL [getposATL _object select 0, getposATL _object select 1,0];
            
            [[_logic,"updateObject",_object],"ALIVE_fnc_logistics", false, false] call BIS_fnc_MP;
            
            _result = _container;
        };

        default {
            _result = [_logic, _operation, _args] call SUPERCLASS;
        };
};

TRACE_1("ALiVE SYS LOGISTICS - output",_result);

if !(isnil "_result") then {
    _result;
};
