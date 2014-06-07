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
            GVAR(logistics_data) = [] call ALIVE_fnc_hashCreate;

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
                [ALiVE_SYS_LOGISTICS,"addAction",[player,"attach"]] call ALiVE_fnc_logistics;
                [ALiVE_SYS_LOGISTICS,"addAction",[player,"detach"]] call ALiVE_fnc_logistics;
                [ALiVE_SYS_LOGISTICS,"addAction",[player,"loadIn"]] call ALiVE_fnc_logistics;
                [ALiVE_SYS_LOGISTICS,"addAction",[player,"loadOut"]] call ALiVE_fnc_logistics;
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
        
        case "addAction": {
	        private ["_object","_operation","_id","_condition","_text"];
	
			_object = [_args, 0, objNull, [objNull,[]]] call BIS_fnc_param;
			_operation = [_args, 1, "", [""]] call BIS_fnc_param;
			
			switch (typename _object) do {
			    case ("ARRAY") : {_object = _object select 0};
			    default {};
			};
			
			switch (_operation) do {
				case ("attach") : {_text = "Carry object"; _condition = "isnil {cursortarget getvariable 'ALiVE_SYS_LOGISTICS_ATTACHED'} && {cursortarget iskindof 'Static'} && {cursortarget distance _target < 5}"};
			    case ("detach") : {_text = "Release object"; _condition = "({!(isnil {_x getvariable 'ALiVE_SYS_LOGISTICS_ATTACHED'})} count (attachedObjects _target)) > 0"};
                case ("loadOut") : {_text = "Load out cargo"; _condition = "count (cursortarget getvariable ['ALiVE_SYS_LOGISTICS_CARGO',[]]) > 0"};
                case ("loadIn") : {_text  = "Load in cargo"; _condition = "cursortarget isKindOf 'Truck_F' && {cursortarget distance _target < 5}"};
			};
			
			_id = _object addAction [
				_text,
				{[MOD(SYS_LOGISTICS),_this select 3,[cursortarget,_this select 1]] call ALiVE_fnc_logistics},
				_operation,
				1,
				false,
				true,
				"",
				_condition
			];
			
			_result = _id;
        };

        case "attach": {
            if (isnil "_args") exitwith {};

            _object = [_args, 0, objNull, [objNull]] call BIS_fnc_param;
			_caller = [_args, 1, objNull, [objNull]] call BIS_fnc_param;
            
            private ["_object","_caller"];
            
            if (({!isnil {_x getvariable QGVAR(ATTACHED)}} count (attachedObjects _caller)) > 0) exitwith {};
            
            _object setvariable [QGVAR(ATTACHED),_caller,true];
            _object attachTo [_caller];
        };
        
        case "detach": {
            if (isnil "_args") exitwith {};
            
            private ["_object","_caller"];
            
            _object = [_args, 0, objNull, [objNull]] call BIS_fnc_param;
			_caller = [_args, 1, objNull, [objNull]] call BIS_fnc_param;
            
			{
                if (!isnil {_x getvariable QGVAR(ATTACHED)}) then {
                    _x setvariable [QGVAR(ATTACHED),nil,true];
                    detach _x;
                    
                    //Reposition for a save placement
                    _x setposATL [getposATL _x select 0, getposATL _x select 1,0];
                    _x setvelocity [0,0,-1];
				};
            } forEach (attachedObjects _caller);
        };
        
        case "loadIn": {
            if (isnil "_args") exitwith {};
            
            //Do it globally so all clients are updated correctly all the time
            if (!isServer) exitwith {
                [[_logic, _operation, _args],"ALIVE_fnc_logistics", false, false] call BIS_fnc_MP;
            };
            
			_object = [_args, 0, objNull, [objNull]] call BIS_fnc_param;
			_caller = [_args, 1, objNull, [objNull]] call BIS_fnc_param;
            
            [_logic,"detach",_args] call ALiVE_fnc_logistics;
            
            private ["_object","_caller","_nearObjects"];
            
            _nearObjects = _object getvariable [QGVAR(CARGO),[]];
            {
                if !(_x in _nearObjects) then {
                    _nearObjects set [count _nearObjects,_x];
                    
	                _x hideObject true;
	                _x hideObjectGlobal true;
                    
                    //_object setvariable [QGVAR(INCARGO),_object,true];
                };
            } foreach (nearestObjects [_object, ["Static"], 15]);
            
            _object setvariable [QGVAR(CARGO),_nearObjects,true];
            _result = _nearObjects;
        };
        
        case "loadOut": {
            if (isnil "_args") exitwith {};
            
            if (!isServer) exitwith {
                [[_logic, _operation, _args],"ALIVE_fnc_logistics", false, false] call BIS_fnc_MP;
            };
            
			_object = [_args, 0, objNull, [objNull]] call BIS_fnc_param;
			_caller = [_args, 1, objNull, [objNull]] call BIS_fnc_param;
            
            private ["_object","_caller","_cargo","_pos"];

            {
                _x setpos ([getpos _object, 0, 15, 2, 0, 20, 0, [],[[getpos _object,20] call CBA_fnc_Randpos]] call BIS_fnc_findSafePos);
                
                _x hideObject false;
                _x hideObjectGlobal false;
                
                //_x setvariable [QGVAR(INCARGO),nil,true];
            } foreach (_object getvariable [QGVAR(CARGO),[]]);
            
            _object setvariable [QGVAR(CARGO),nil,true];
        };
        
        //Obsolete and unused
        case "scan": {
            if ((isnil "_args") || {!hasInterface}) exitwith {};
            
            private ["_scan"];
            
            _scan = [_args, 0, false, [true,false]] call BIS_fnc_param;
            
            switch (_scan) do {
                
                case (true) : {
                    _handle = [_logic] spawn {
                        private ["_nearObjects"];
                        
                        waituntil {
                            sleep 2;
                            _nearObjects = [];
                            {
                                if !(_x in _nearObjects) then {_nearObjects set [count _nearObjects,_x]};
                            } foreach (nearestObjects [player, ["Static","Truck_F"], 5]);
							
                            if (count _nearObjects == 0) then {
                            	player setvariable [QGVAR(nearPlayerObjects),_nearObjects];
                                ["Collection %1",_nearObjects] call ALiVE_fnc_DumpR;
                            } else {
                                player setvariable [QGVAR(nearPlayerObjects),nil];
                            };
                        };
                    };
                    _logic setvariable [QGVAR(scan),_handle];
                };
                
                case (false) : {
                    _handle = _logic getvariable [QGVAR(scan),-1];
                    terminate _handle;
                };
                
                default {
                    _handle = _logic getvariable [QGVAR(scan),-1];
                    terminate _handle;
                };
            };
        };
        
        default {
            _result = [_logic, _operation, _args] call SUPERCLASS;
        };
};

TRACE_1("ALiVE SYS LOGISTICS - output",_result);

if !(isnil "_result") then {
    _result;
};
