#include <\x\alive\addons\sup_combatSupport\script_component.hpp>
SCRIPT(combatSupport);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_combatSupport
Description:
Creates the server side object to store settings

Parameters:
Nil or Object - If Nil, return a new instance. If Object, reference an existing instance.
String - The selected function
Array - The selected parameters

Returns:
Any - The new instance or the result of the selected function and parameters

Attributes:
Boolean - debug - Debug enabled
Boolean - enabled - Enabled or disable module

Parameters:
none

The popup menu will change to show status as functions are enabled and disabled.

Examples:
(begin example)
// Create instance by placing editor module and specifiying name myModule
(end)

See Also:
- <ALIVE_fnc_combatSupportInit>
- <ALIVE_fnc_combatSupportRWGExec>

Author:
NEO, adapted by Gunny for ALiVE
---------------------------------------------------------------------------- */

#define SUPERCLASS nil

private ["_logic","_operation","_args"];

PARAMS_1(_logic);
DEFAULT_PARAM(1,_operation,"");
DEFAULT_PARAM(2,_args,[]);

switch(_operation) do {
        case "init": {                
                /*
                MODEL - no visual just reference data
                - server side object only
				- enabled/disabled
                */
                
                // Ensure only one module is used
                if (isServer && !(isNil "ALIVE_combatSupport")) exitWith {
                        ERROR_WITH_TITLE(str _logic, localize "STR_ALIVE_CS_ERROR1");
                };
                
                //Load Functions on all localities and wait for the init to have passed
				call ALiVE_fnc_combatSupportFncInit;
                
                //Create basics on server
                if (isServer) then {
                        // if server, initialise module game logic
                        _logic setVariable ["super", SUPERCLASS];
                        _logic setVariable ["class", ALIVE_fnc_combatSupport];

                        //not publicVariable to clients yet to let it init before
                        NEO_radioLogic = _logic;


						_transportArrays = [];
						_casArrays = [];
						_sides = [WEST,EAST,RESISTANCE,CIVILIAN];
						     
				        for "_i" from 0 to ((count synchronizedObjects _logic)-1) do {
				            switch (typeOf ((synchronizedObjects _logic) select _i)) do {
				                    case ("ALiVE_sup_cas") : {
				                    private ["_position","_callsign","_type"];
	
                                    _position = getposATL ((synchronizedObjects _logic) select _i);
                                    _callsign = ((synchronizedObjects _logic) select _i) getvariable ["cas_callsign","EAGLE ONE"];
                                    _type = ((synchronizedObjects _logic) select _i) getvariable ["cas_type","B_Heli_Attack_01_F"];
                                    _direction =  getDir ((synchronizedObjects _logic) select _i);
                                    _id = [_position] call ALiVE_fnc_getNearestAirportID;

                                    _casArray = [_position,_direction, _type, _callsign, _id,{}];
                                    _casArrays set [count _casArrays,_casArray];
				                                    };
				                    case ("ALiVE_SUP_TRANSPORT") : {
				                       private ["_position","_callsign","_type"];
				                 
				                        _position = getposATL ((synchronizedObjects _logic) select _i);
				                        _callsign = ((synchronizedObjects _logic) select _i) getvariable ["transport_callsign","FRIZ ONE"];
				                        _type = ((synchronizedObjects _logic) select _i) getvariable ["transport_type","B_Heli_Transport_01_camo_F"];
				                        _direction =  getDir ((synchronizedObjects _logic) select _i);
				             
				                        _transportArray = [_position,_direction,_type, _callsign,["Pickup", "Land", "land (Eng off)", "Move", "Circle"],{}];
				                        _transportArrays set [count _transportArrays,_transportArray];
				                    };
				            };
				        };
					         
					    SUP_CASARRAYS  = _casArrays; PublicVariable "SUP_CASARRAYS";
					    SUP_TRANSPORTARRAYS  = _transportArrays; PublicVariable "SUP_TRANSPORTARRAYS";
						    
                        {
                        	NEO_radioLogic setVariable [format ["NEO_radioTrasportArray_%1", _x], [],true];
							NEO_radioLogic setVariable [format ["NEO_radioCasArray_%1", _x], [],true];
						} foreach _sides;

						private ["_t", "_c", "_a"];
							_t = [];
							_c = [];
							_a = [];

						  {
								private ["_pos", "_dir", "_type", "_callsign", "_tasks", "_code","_side"];
								_pos = _x select 0; _pos set [2, 0];
								_dir = _x select 1;
								_type = _x select 2;
								_callsign = toUpper (_x select 3);
								_tasks = _x select 4;
								_code = _x select 5;
                                
                                _faction = gettext(configfile >> "CfgVehicles" >> _type >> "faction");
								_side = getNumber(configfile >> "CfgVehicles" >> _type >> "side");
								
			                    switch (_side) do {
			                		case 0 : {_side = EAST};
			                		case 1 : {_side = WEST};
			                		case 2 : {_side = RESISTANCE};
			                		default {_side = EAST};
			            		};
								
								private ["_veh"];
								_veh = createVehicle [_type, _pos, [], 0, "CAN_COLLIDE"];
								_veh setDir _dir;
								_veh setPosATL _pos;
								_veh setVelocity [0,0,-1];
								
								private ["_grp"];
								_grp = createGroup _side;
								[_veh, _grp] call BIS_fnc_spawnCrew;
								_veh lockDriver true;
								{ _veh lockturret [[_x], true] } forEach [0,1,2];
								[[(units _grp select 0),_callsign], "fnc_setGroupID", false, false] spawn BIS_fnc_MP;
								//[nil, (units _grp select 0), "per", SETGROUPID, _callsign] spawn BIS_fnc_MP;
								_veh setVariable ["ALIVE_CombatSupport", true];
								_veh setVariable ["NEO_transportAvailableTasks", _tasks, true];
						/*
								[[ _veh, ["Talk with pilot", {call ALIVE_fnc_radioAction}, "talk", -1, false, true, "", 
								"
									_this in _target
									&&
									{
										lifeState _x == ""ALIVE""
										&&
										_x in (assignedCargo _target)
										&&
										rankID _x > rankID _this
									}
									count (crew _target) == 0
								"]],"fnc_addAction",true,true] spawn BIS_fnc_MP;  */
						
								_transportfsm = "\x\alive\addons\sup_combatSupport\scripts\NEO_radio\fsms\transport.fsm";
								[_veh, _grp, _callsign, _pos] execFSM _transportfsm;
								
								_t = NEO_radioLogic getVariable format ["NEO_radioTrasportArray_%1", _side];
								_t set [count _t, [_veh, _grp, _callsign]];
                                
                                NEO_radioLogic setVariable [format ["NEO_radioTrasportArray_%1", _side], _t,true];
							} forEach SUP_TRANSPORTARRAYS;
						
						{
								private ["_pos", "_dir", "_type", "_callsign", "_airport", "_code","_side"];
								_pos = _x select 0; _pos set [2, 0];
								_dir = _x select 1;
								_type = _x select 2;
								_callsign = toUpper (_x select 3);
								_airport = _x select 4;
								_code = _x select 5;
                                
                                _faction = gettext(configfile >> "CfgVehicles" >> _type >> "faction");
								_side = getNumber(configfile >> "CfgVehicles" >> _type >> "side");

			                    switch (_side) do {
			                		case 0 : {_side = EAST};
			                		case 1 : {_side = WEST};
			                		case 2 : {_side = RESISTANCE};
			                		default {_side = EAST};
			            		};
								
								private ["_veh"];
								_veh = createVehicle [_type, _pos, [], 0, "CAN_COLLIDE"];
								_veh setDir _dir;
								_veh setPosATL _pos;
								_veh setVelocity [0,0,-1];

								_veh setVariable ["ALIVE_CombatSupport", true];
								
								private ["_grp"];
								_grp = createGroup _side;
								[_veh, _grp] call BIS_fnc_spawnCrew;
								_veh lockDriver true;
								{ _veh lockturret [[_x], true] } forEach [0,1,2];
								[[(units _grp select 0),_callsign], "fnc_setGroupID", false, false] spawn BIS_fnc_MP;
								//[nil, (units _grp select 0), "per", SETGROUPID, _callsign] spawn BIS_fnc_MP;
								[_veh, _grp, units _grp] spawn _code;
								
								//FSM
								[_veh, _grp, _callsign, _pos, _airport] execFSM "\x\alive\addons\sup_combatSupport\scripts\NEO_radio\fsms\cas.fsm";
								
								_c = NEO_radioLogic getVariable format ["NEO_radioCasArray_%1", _side];
								_c set [count _c, [_veh, _grp, _callsign]];
                                
                                NEO_radioLogic setVariable [format ["NEO_radioCasArray_%1", _side], _c,true];
							} forEach SUP_CASARRAYS;
   
                            //Now PV the logic to all clients indicate its ready
                            _logic setVariable ["init", true,true];
                            publicVariable "NEO_radioLogic";
               	};
                
                // and wait for game logic to initialise
                // TODO merge into lazy evaluation
                waitUntil {!isNil "NEO_radioLogic"};
                waitUntil {NEO_radioLogic getVariable ["init", false]};

                /*
                VIEW - purely visual
                */
				NEO_radioLogic setVariable ["NEO_radioPlayerActionArray",
			   	 [ 
					[
				    	("<t color=""#700000"">" + ("Talk To Pilot") + "</t>"),
				        {["talk"] call ALIVE_fnc_radioAction},
				        "talk",
				        -1,
				        false,
				        true,
				        "",
						"
							({(_x select 0) == vehicle _this} count (NEO_radioLogic getVariable format ['NEO_radioTrasportArray_%1', side _this]) > 0)
							&&
							{alive (driver (vehicle _this))}
				        "
				    ]
			    ]
	      	  ];

	        	{player addAction _x} foreach (NEO_radioLogic getVariable "NEO_radioPlayerActionArray");
				player addEventHandler ["Respawn", { {(_this select 0) addAction _x } foreach (NEO_radioLogic getVariable "NEO_radioPlayerActionArray") }];
                
                //if there is a real screen it must be a player so hand out the menu item
				if (hasInterface) then {
					//Initialise Functions and add respawn eventhandler
					waituntil {(!(isnull player) && !(isnil "NEO_radioLogic"))};
				
					if (isNil "SELF_INTERACTION_KEY") then {SELF_INTERACTION_KEY = [221,[false,false,false]]};
					    
					// if A2 - ACE spectator enabled, seto to allow exit
					if(!isNil "ace_fnc_startSpectator") then {ace_sys_spectator_can_exit_spectator = true};
				    
					// check if player has item defined in module TODO!

				 		// initialise main menu
				    [
				            "player",
				            [SELF_INTERACTION_KEY],
				            -9500,
				            [
				                    "call ALIVE_fnc_CombatSupportMenuDef",
				                    "main"
				            ]
				    ] call ALIVE_fnc_flexiMenu_Add;
                };
            };
        case "destroy": {
                if (isServer) then {
                        // if server
                        _logic setVariable ["super", nil];
                        _logic setVariable ["class", nil];
                        _logic setVariable ["init", nil];
                        // and publicVariable to clients
                        NEO_radioLogic = _logic;
                        publicVariable "NEO_radioLogic";
                };
                
                if(!isDedicated && !isHC) then {

                };
        };
        default {
                private["_err"];
                _err = format["%1 does not support %2 operation", _logic, _operation];
                ERROR_WITH_TITLE(str _logic,_err);
        };
};
