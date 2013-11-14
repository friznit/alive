#include <\x\alive\addons\sys_crewinfo\script_component.hpp>
SCRIPT(crewinfo);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_crewinfo
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
- <ALIVE_fnc_crewinfoInit>


Author:
[KH]Jman
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
                if (isServer && !(isNil QMOD(crewinfo))) exitWith {
                        ERROR_WITH_TITLE(str _logic, localize "STR_ALIVE_CREWINFO_ERROR1");
                };
                
                if (isServer) then {
                        MOD(crewinfo) = _logic;
                        publicVariable QMOD(crewinfo);

                        // if server, initialise module game logic
                        _logic setVariable ["super", SUPERCLASS];
                        _logic setVariable ["class", ALIVE_fnc_crewinfo];
                        _logic setVariable ["init", true, true];
                } else {
                        // if client clean up client side game logics as they will transfer
                        // to servers on client disconnect
                       // deleteVehicle _logic;
                };
                
                // and wait for game logic to initialise
                // TODO merge into lazy evaluation
                waitUntil {!isNil QMOD(crewinfo)};
                waitUntil {MOD(crewinfo) getVariable ["init", false]};        

                /*
                VIEW - purely visual
                - initialise 
                */
               
                
                if(!isDedicated && !isHC) then {
                	    CREWINFO_DEBUG = call compile (_logic getvariable ["crewinfo_debug_setting","false"]);
                      CREWINFO_UILOC = call compile (_logic getvariable ["crewinfo_ui_setting",1]);
                	 		Waituntil {!(isnil "CREWINFO_DEBUG")};
                	 		Waituntil {!(isnil "CREWINFO_UILOC")};
                	 		private ["_ui","_HudNames","_vehicleID","_picture","_vehicle","_vehname","_weapname","_weap","_wepdir","_Azimuth"];
                				
                				// DEBUG -------------------------------------------------------------------------------------
													if(CREWINFO_DEBUG) then {
														["ALIVE Crew Info - Starting..."] call ALIVE_fnc_dump;
															if (CREWINFO_UILOC == 1) then {
																["ALIVE Crew Info - Drawing UI right (%1)", CREWINFO_UILOC] call ALIVE_fnc_dump;
															} else {
																["ALIVE Crew Info - Drawing UI left (%1)", CREWINFO_UILOC] call ALIVE_fnc_dump;
															};
													};
												// DEBUG -------------------------------------------------------------------------------------

   										[] call ALIVE_fnc_crewinfoClient;
                };
                
        };
        case "destroy": {
                if (isServer) then {
                        // if server
                        _logic setVariable ["super", nil];
                        _logic setVariable ["class", nil];
                        _logic setVariable ["init", nil];
                        // and publicVariable to clients
                        MOD(crewinfo) = _logic;
                        publicVariable QMOD(crewinfo);
                };
        };
        default {
                private["_err"];
                _err = format["%1 does not support %2 operation", _logic, _operation];
                ERROR_WITH_TITLE(str _logic,_err);
        };
};

