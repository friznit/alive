#include <\x\alive\addons\sys_playertags\script_component.hpp>
SCRIPT(playertags);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_playertags
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
Boolean - group - Display player group enabled
Boolean - rank - Display player rank enabled
Boolean - invehicle - Display player tags in vehicles enabled
Number  - distance - Sets player name tag distance
Number  - tolerance - Sets player name tag tolerance
Number  - scale - Sets player name tag scale
String  - namecolour - Sets name colour
String  - groupcolour - Sets group colour
String  - thisgroupleadernamecolour - Sets player's group leader colour
String  - thisgroupcolour - Sets player's group colour

The popup menu will change to show status as function is enabled and disabled.


Examples:
(begin example)
// Create instance by placing editor module and specifiying name myModule
(end)

See Also:
- <ALIVE_fnc_playertagsInit>
- <ALIVE_fnc_playertagsMenuDef>

Author:
[KH]Jman

Peer reviewed:
nil
---------------------------------------------------------------------------- */

#define SUPERCLASS nil

private ["_logic","_operation","_args"];

PARAMS_1(_logic);
DEFAULT_PARAM(1,_operation,"");
DEFAULT_PARAM(2,_args,[]);

enable_playertags = false;

switch(_operation) do {
        case "init": {                
                /*
                MODEL - no visual just reference data
                */
                
                // Ensure only one module is used
                if (isServer && !(isNil QMOD(playertags))) exitWith {
                        ERROR_WITH_TITLE(str _logic, localize "STR_ALIVE_PLAYERTAGS_ERROR1");
                };
                
                if (isServer) then {
                        // and publicVariable to clients
                        MOD(playertags) = _logic;
                        publicVariable QMOD(playertags);

                        // if server, initialise module game logic
                        _logic setVariable ["super", SUPERCLASS];
                        _logic setVariable ["class", ALIVE_fnc_playertags];
                        _logic setVariable ["init", true, true];
                         PLAYERTAGS_DEBUG = call compile (_logic getvariable ["playertags_debug_setting","false"]);
                         PLAYERTAGS_GROUP = call compile (_logic getvariable ["playertags_displaygroup_setting","false"]);
                         PLAYERTAGS_RANK = call compile (_logic getvariable ["playertags_displayrank_setting","false"]);
                         PLAYERTAGS_INVEHICLE = call compile (_logic getvariable ["playertags_invehicle_setting","false"]);
                         PLAYERTAGS_DISTANCE = _logic getvariable ["playertags_distance_setting",20];
                         PLAYERTAGS_TOLERANCE = _logic getvariable ["playertags_tolerance_setting",0.75];
                         PLAYERTAGS_SCALE = _logic getvariable ["playertags_scale_setting",0.65];
                         PLAYERTAGS_NAMECOLOUR = _logic getvariable ["playertags_namecolour_setting","#FFFFFF"];       
                         PLAYERTAGS_GROUPCOLOUR = _logic getvariable ["playertags_groupcolour_setting","#A8F000"]; 
                         PLAYERTAGS_THISGROUPLEADERNAMECOLOUR = _logic getvariable ["playertags_thisgroupleadernamecolour_setting","#FFB300"]; 
                         PLAYERTAGS_THISGROUPCOLOUR =_logic getvariable ["playertags_thisgroupcolour_setting","#009D91"]; 
                         // and publicVariable to clients
	                        publicVariable "PLAYERTAGS_DEBUG";
	                        publicVariable "PLAYERTAGS_GROUP";
	                        publicVariable "PLAYERTAGS_RANK";
	                        publicVariable "PLAYERTAGS_INVEHICLE";
	                        publicVariable "PLAYERTAGS_DISTANCE";
	                        publicVariable "PLAYERTAGS_TOLERANCE";
	                        publicVariable "PLAYERTAGS_SCALE";
	                        publicVariable "PLAYERTAGS_NAMECOLOUR";
	                        publicVariable "PLAYERTAGS_GROUPCOLOUR";
	                        publicVariable "PLAYERTAGS_THISGROUPLEADERNAMECOLOUR";
	                        publicVariable "PLAYERTAGS_THISGROUPCOLOUR";

                } else {
                        // any client side logic
                };



                // and wait for game logic to initialise
                // TODO merge into lazy evaluation
                waitUntil {!isNil QMOD(playertags)};
                waitUntil {MOD(playertags) getVariable ["init", false]};        
                /*
                VIEW - purely visual
                - initialise menu
                - frequent check to modify menu and display status (ALIVE_fnc_playertagsMenuDef)
                */
                


                if(!isDedicated && !isHC) then {
                		Waituntil {!(isnil "PLAYERTAGS_DEBUG")};
                		if(PLAYERTAGS_DEBUG) then {
                			["ALIVE Player Tags - Menu Starting..."] call ALIVE_fnc_dump;
                		};
                        // Initialise interaction key if undefined
                        if(isNil "SELF_INTERACTION_KEY") then {SELF_INTERACTION_KEY = [221,[false,false,false]];};

     
                        // initialise main menu
                        [
                                "player",
                                [SELF_INTERACTION_KEY],
                                -9500,
                                [
                                        "call ALIVE_fnc_playertagsMenuDef",
                                        "main"
                                ]
                        ] call ALIVE_fnc_flexiMenu_Add;
                };
                
                /*
                CONTROLLER  - coordination
                - frequent check if player is server admin (ALIVE_fnc_playertagsMenuDef)
                */
        };
        case "destroy": {
                if (isServer) then {
                        // if server
                        _logic setVariable ["super", nil];
                        _logic setVariable ["class", nil];
                        _logic setVariable ["init", nil];
                        // and publicVariable to clients
                        MOD(playertags) = _logic;
                        publicVariable QMOD(playertags);
                };
                
                if(!isDedicated && !isHC) then {
                        // remove main menu
                        [
                                "player",
                                [SELF_INTERACTION_KEY],
                                -9500,
                                [
                                        "call ALIVE_fnc_playertagsMenuDef",
                                        "main"
                                ]
                        ] call ALIVE_fnc_flexiMenu_Remove;
                };
        };
        default {
                private["_err"];
                _err = format["%1 does not support %2 operation", _logic, _operation];
                ERROR_WITH_TITLE(str _logic,_err);
        };
};