#include <\x\alive\addons\sys_TEMPLATE\script_component.hpp>
SCRIPT(TEMPLATE);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_TEMPLATE
Description:
XXXXXXXXXX

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
- <ALIVE_fnc_TEMPLATEInit>
- <ALIVE_fnc_TEMPLATEMenuDef>

Author:
Tupolov
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
                if (isServer && !(isNil "ALIVE_TEMPLATE")) exitWith {
                        ERROR_WITH_TITLE(str _logic, localize "STR_ALIVE_TEMPLATE_ERROR1");
                };
                
                if (isServer) then {
                        // if server, initialise module game logic
                        _logic setVariable ["super", SUPERCLASS];
                        _logic setVariable ["class", ALIVE_fnc_TEMPLATE];
                        _logic setVariable ["init", true];
                        // and publicVariable to clients
                        ALIVE_TEMPLATE = _logic;
                        publicVariable "ALIVE_TEMPLATE";
                } else {
                        // if client clean up client side game logics as they will transfer
                        // to servers on client disconnect
                        deleteVehicle _logic;
                };
                
                // and wait for game logic to initialise
                // TODO merge into lazy evaluation
                waitUntil {!isNil "ALIVE_TEMPLATE"};
                waitUntil {ALIVE_TEMPLATE getVariable ["init", false]};        

                /*
                VIEW - purely visual
                - initialise menu
                - frequent check to modify menu and display status (ALIVE_fnc_TEMPLATEsmenuDef)
                */
                
                if(!isDedicated && !isHC) then {
                        // Initialise interaction key if undefined
                        if(isNil "SELF_INTERACTION_KEY") then {SELF_INTERACTION_KEY = [221,[false,false,false]];};
                        // if ACE spectator enabled, seto to allow exit
                        if(!isNil "ace_fnc_startSpectator") then {ace_sys_spectator_can_exit_spectator = true;};
                        // initialise main menu
                        [
                                "player",
                                [SELF_INTERACTION_KEY],
                                -9500,
                                [
                                        "call ALIVE_fnc_TEMPLATEMenuDef",
                                        "main"
                                ]
                        ] call CBA_fnc_flexiMenu_Add;
                };
                
        };
        case "destroy": {
                if (isServer) then {
                        // if server
                        _logic setVariable ["super", nil];
                        _logic setVariable ["class", nil];
                        _logic setVariable ["init", nil];
                        // and publicVariable to clients
                        ALIVE_TEMPLATE = _logic;
                        publicVariable "ALIVE_TEMPLATE";
                };
                
                if(!isDedicated && !isHC) then {
                        // remove main menu
                        [
                                "player",
                                [SELF_INTERACTION_KEY],
                                -9500,
                                [
                                        "call ALIVE_fnc_TEMPLATEMenuDef",
                                        "main"
                                ]
                        ] call CBA_fnc_flexiMenu_Remove;
                };
        };
        default {
                private["_err"];
                _err = format["%1 does not support %2 operation", _logic, _operation];
                ERROR_WITH_TITLE(str _logic,_err);
        };
};
