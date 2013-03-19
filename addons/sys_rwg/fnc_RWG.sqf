#include <\x\alive\addons\sys_rwg\script_component.hpp>
SCRIPT(rwg);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_RWG
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
- <ALIVE_fnc_RWGInit>
- <ALIVE_fnc_RWGExec>

Author:
Highhead
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
                if (isServer && !(isNil "ALIVE_RWG")) exitWith {
                        ERROR_WITH_TITLE(str _logic, localize "STR_ALIVE_RWG_ERROR1");
                };
                
                if (isServer) then {
                        // if server, initialise module game logic
                        _logic setVariable ["super", SUPERCLASS];
                        _logic setVariable ["class", ALIVE_fnc_RWG];
                        _logic setVariable ["init", true];
                        // and publicVariable to clients
                        ALIVE_RWG = _logic;
                        publicVariable "ALIVE_RWG";
                } else {
                        // if client clean up client side game logics as they will transfer
                        // to servers on client disconnect
                        deleteVehicle _logic;
                };
                
                // and wait for game logic to initialise
                // TODO merge into lazy evaluation
                waitUntil {!isNil "ALIVE_RWG"};
                waitUntil {ALIVE_RWG getVariable ["init", false]};        

                /*
                VIEW - purely visual
                */
                
				if(!isDedicated && !isHC) then {
					//Initialise Functions and add respawn eventhandler
					waituntil {not isnull player};
					call ALIVE_fnc_RWGExec;
                };
                
        };
        case "destroy": {
                if (isServer) then {
                        // if server
                        _logic setVariable ["super", nil];
                        _logic setVariable ["class", nil];
                        _logic setVariable ["init", nil];
                        // and publicVariable to clients
                        ALIVE_RWG = _logic;
                        publicVariable "ALIVE_RWG";
                };
                
                if(!isDedicated && !isHC) then {
                        // remove respawn eventhandler
			player removeEventHandler ["respawn",RWG_HANDLE];
			player removeAction RWG_HANDLE_actSave;
			player removeAction RWG_HANDLE_actload;
                };
        };
        default {
                private["_err"];
                _err = format["%1 does not support %2 operation", _logic, _operation];
                ERROR_WITH_TITLE(str _logic,_err);
        };
};
