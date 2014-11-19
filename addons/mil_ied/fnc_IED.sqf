#include <\x\alive\addons\mil_ied\script_component.hpp>
SCRIPT(ied);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_IED
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

INT - IED_Threat -
        values[]= {0,50,100,200,350};
        texts[]= {"None","Low","Med","High","Extreme"};
        default = 50;
INT - Bomber_Threat -
        values[]= {0,10,20,30,50};
        texts[]= {"None","Low","Med","High","Extreme"};
        default = 10;
INT - Locs_IED -
        values[]= {0,1,2};
        texts[]= {"Random","Enemy Occupied Only","Unoccupied"};
        default = 0;
INT - Ambient_VB-IEDs -
        values[]= {0,5,10,15,30};
        texts[]= {"None","Low","Med","High","Extreme"};
        default = 5;


Examples:
(begin example)
// Create instance by placing editor module and specifiying name myModule
(end)

See Also:
- <ALIVE_fnc_IEDInit>
- <ALIVE_fnc_IEDMenuDef>

Author:
Tupolov

Peer reviewed:
nil
---------------------------------------------------------------------------- */

#define SUPERCLASS ALIVE_fnc_baseClass
#define MAINCLASS ALIVE_fnc_ied
#define DEFAULT_BOMBER_THREAT 15
#define DEFAULT_IED_THREAT 60
#define DEFAULT_VB_IED_THREAT 8
#define DEFAULT_LOCS_IED 0

private ["_logic","_operation","_args"];

PARAMS_1(_logic);
DEFAULT_PARAM(1,_operation,"");
DEFAULT_PARAM(2,_args,[]);

switch(_operation) do {
        default {
                _result = [_logic, _operation, _args] call SUPERCLASS;
        };
        case "init": {
                /*
                MODEL - no visual just reference data
                - server side object only
                - ied threat
                - vb-ied threat
                - bomber threat
                - ied locations
                */

                // Ensure only one module is used
                if (isServer && !(isNil QMOD(mil_ied))) exitWith {
                        ERROR_WITH_TITLE(str _logic, localize "STR_ALIVE_ied_ERROR1");
                };

                if (isServer) then {
                        // and publicVariable to clients
                        private ["_debug","_mapInfo","_center","_radius"];
                        MOD(mil_ied) = _logic;

                        // if server, initialise module game logic
                        MOD(mil_ied) setVariable ["super", SUPERCLASS];
                        MOD(mil_ied) setVariable ["class", MAINCLASS];
                        MOD(mil_ied) setVariable ["init", true, true];

        		publicVariable QMOD(mil_ied);

        		_debug = MOD(mil_ied) getVariable ["debug", false];

                        _mapInfo = [] call ALIVE_fnc_getMapInfo;
                        _center = _mapInfo select 0;
                        _radius = _mapInfo select 2;

                        _locations = nearestLocations [_center, ["NameCityCapital","NameCity","NameVillage","Strategic"],_radius];

        		// Set up Bombers and IEDs at each location (except any player starting location)
        		{
        			private ["_fate","_pos","_trg","_twn"];

        			//Get the location object
        			_pos = position _x;
        			_twn = (nearestLocations [_pos, ["NameCityCapital","NameCity","NameVillage","Strategic"],200]) select 0;
                                _size = (size _twn) select 0;

        			if (_size < 250) then {_size = 250;};
        			if (_debug) then {
        				diag_log format ["town is %1 at %2. %3m in size and type %4", text _twn, position _twn, _size, type _twn];
        			};

        			// Place triggers if not within distance of players
        			if ({(getpos _x distance _pos) < _size} count ([] call BIS_fnc_listPlayers) == 0) then {

        				//Roll the dice
        				_fate = 1;

        				if (_fate < _logic getvariable ["Bomber_Threat", DEFAULT_BOMBER_THREAT]) then {
        					// Place Suicide Bomber trigger

        					_trg = createTrigger["EmptyDetector",getpos _twn];

        					_trg setTriggerArea[(_size+250),(_size+250),0,false];

        					_trg setTriggerActivation["WEST","PRESENT",true];
        					_trg setTriggerStatements["this && ({(vehicle _x in thisList) && ((getposATL _x) select 2 < 25)} count ([] call BIS_fnc_listPlayers) > 0)", format ["null = [getpos thisTrigger, thisList, %1] call ALIVE_fnc_createBomber",_size], ""];

        					 if (_debug) then {
        						_t = format["suic_t%1", random 1000];

        						diag_log format ["ALIVE-%1 Suicide Bomber Trigger: created at %2 (%3)", time, text _twn, mapgridposition  (getpos _twn)];
        						[_t, getpos _twn, "Ellipse", [_size+250,_size+250], "TEXT:", text _twn, "COLOR:", "ColorOrange", "BRUSH:", "Border", "GLOBAL","PERSIST"] call CBA_fnc_createMarker;

        					};
        				};

        				if (_fate < _logic getvariable ["IED_Threat", DEFAULT_IED_THREAT]) then {
        					// Place IED trigger
        					_trg = createTrigger["EmptyDetector",getpos _twn];

        					_trg setTriggerArea[(_size+250), (_size+250),0,false];

        					if (_logic getvariable ["Locs_IED", DEFAULT_LOCS_IED] == 1) then {
        						_trg setTriggerActivation["ANY","PRESENT",false]; // true = repeated

        						_trg setTriggerStatements["this && ({(vehicle _x in thisList) && ((getposATL _x) select 2 < 25)} count ([] call BIS_fnc_listPlayers) > 0)", format ["null = [getpos thisTrigger,%1] call ALIVE_fnc_createIED",_size], ""];
        					} else {
        						_trg setTriggerActivation["WEST","PRESENT",false]; // true = repeated
        						_trg setTriggerStatements["this && ({(vehicle _x in thisList) && ((getposATL _x) select 2 < 25)} count ([] call BIS_fnc_listPlayers) > 0)", format ["null = [getpos thisTrigger,%1] call ALIVE_fnc_createIED",_size], ""];
        					};

        					if (_debug) then {
        						_t = format["ied_t%1", random 1000];

        						diag_log format ["ALIVE-%1 IED Trigger: created at %2 (%3)", time, text _twn, mapgridposition  (getpos _twn)];
        						[_t, getpos _twn, "Ellipse", [_size+245,_size+245], "TEXT:", text _twn, "COLOR:", "ColorYellow", "BRUSH:", "Border", "GLOBAL","PERSIST"] call CBA_fnc_createMarker;

        					};
        				};
        			};
        		} foreach _locations;

                } else {
                        // any client side logic
                };

		TRACE_2("After module init",MOD(mil_ied),MOD(mil_ied) getVariable "init");

                // and wait for game logic to initialise
                // TODO merge into lazy evaluation
                waitUntil {!isNil QMOD(mil_ied)};
                waitUntil {MOD(mil_ied) getVariable ["init", false]};

                /*
                VIEW - purely visual
                - initialise menu
                - frequent check to modify menu and display status (ALIVE_fnc_IEDmenuDef)
                */

		TRACE_2("Adding menu",isDedicated,isHC);

                if(!isDedicated && !isHC) then {
                        // Initialise interaction key if undefined
                        if(isNil "SELF_INTERACTION_KEY") then {SELF_INTERACTION_KEY = [221,[false,false,false]];};

                        // if ACE spectator enabled, seto to allow exit
                        if(!isNil "ace_fnc_startSpectator") then {ace_sys_spectator_can_exit_spectator = true;};

                        // Initialise default map click command if undefined
                        ISNILS(DEFAULT_MAPCLICK,"");

			TRACE_3("Menu pre-req",SELF_INTERACTION_KEY,ace_fnc_startSpectator,DEFAULT_MAPCLICK);

                        // initialise main menu
                        [
                                "player",
                                [SELF_INTERACTION_KEY],
                                -9500,
                                [
                                        "call ALIVE_fnc_iedMenuDef",
                                        "main"
                                ]
                        ] call ALIVE_fnc_flexiMenu_Add;
                };

                /*
                CONTROLLER  - coordination
                - frequent check if player is server admin (ALIVE_fnc_IEDmenuDef)
                */
        };
        case "destroy": {
                if (isServer) then {
                        // if server
                        _logic setVariable ["super", nil];
                        _logic setVariable ["class", nil];
                        _logic setVariable ["init", nil];
                        // and publicVariable to clients
                        MOD(mil_ied) = _logic;
                        publicVariable QMOD(mil_ied);
                };

                if(!isDedicated && !isHC) then {
                        // remove main menu
                        [
                                "player",
                                [SELF_INTERACTION_KEY],
                                -9500,
                                [
                                        "call ALIVE_fnc_iedMenuDef",
                                        "main"
                                ]
                        ] call CBA_fnc_flexiMenu_Remove;
                };
        };
};
