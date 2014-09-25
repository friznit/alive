#include <\x\alive\addons\sys_viewdistance\script_component.hpp>
SCRIPT(vdist);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_vdist
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
- <ALIVE_fnc_vdistInit>
- <ALIVE_fnc_vdistMenuDef>

Author:
Gunny
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
                if (isServer && !(isNil QMOD(vdist))) exitWith {
                        ERROR_WITH_TITLE(str _logic, localize "STR_ALIVE_VDIST_ERROR1");
                };
                
                //Only one init per instance is allowed
            	if !(isnil {_logic getVariable "initGlobal"}) exitwith {["ALiVE SYS VIEWDISTANCE - Only one init process per instance allowed! Exiting..."] call ALiVE_fnc_Dump}; 
            
            	//Start init
            	_logic setVariable ["initGlobal", false];
                
                if (isServer) then {
                        MOD(vdist) = _logic;
                        publicVariable QMOD(vdist);

                        // if server, initialise module game logic
                        _logic setVariable ["super", SUPERCLASS];
                        _logic setVariable ["class", ALIVE_fnc_vdist];
                        _logic setVariable ["init", true, true];
                        // and publicVariable to clients
                       
                } else {
                        // if client clean up client side game logics as they will transfer
                        // to servers on client disconnect
                       // deleteVehicle _logic;
                };
                
                // and wait for game logic to initialise
                // TODO merge into lazy evaluation
                waitUntil {!isNil QMOD(vdist)};
                waitUntil {MOD(vdist) getVariable ["init", false]};        

                /*
                VIEW - purely visual
                - initialise menu
                - frequent check to modify menu and display status (ALIVE_fnc_vdistmenuDef)
                */
                
                if(!isDedicated && !isHC) then {
                    _mingettg = Alive_vdist getvariable["minTG", 2]; // get the minimum terrain grid set in themodule
                    _minsettg = parseNumber _mingettg; // convert the minimum variable to a number
                    if (_minsettg == 0) then {_minsettg = 1;}; //if the minimum terrain grid has not been set i.e blank, then set it to 1
                    _maxgettg = (ALIVE_vdist getVariable ["maxTG", 2]); // get the maximum terrain grid set in the module
                    _maxsettg = parseNumber _maxgettg; // convert the maximum variable to a number
                    if (_maxsettg == 0) then {_maxsettg = 5;};//if the maximum terrain grid has not been set i.e blank, then set it to  5

                    _tgvalue = _maxsettg - _minsettg;
                    _settg = 12.5;
                    if(_tgvalue == 0) then {
                                     switch (_maxsettg) do {
                                     case 1 : {_settg = 50};
                                     case 2 : {_settg = 25};
                                     case 3 : {_settg = 12.5};
                                     case 4 : {_settg = 6.25};
                                     case 5 : {_settg = 3.125};                                      
                      };
                    setTerrainGrid _settg;

 };
                    _maxgetvd = (ALIVE_vdist getVariable ["maxVD", 2]); // get the maximum view distance se in the module
                    _maxsetvd = parseNumber _maxgetvd; // convert the maximum variable to a number
                    if (_maxsetvd == 0) then {_maxsetvd = 15000;};//if the maximum view distance has not been set i.e blank, then set it to 15000
                    if(viewdistance >  _maxsetvd) then {
                        setViewDistance _maxsetvd;
                    };


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
                                        "call ALIVE_fnc_vdistMenuDef",
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
                        MOD(vdist) = _logic;
                        publicVariable QMOD(vdist);
                };
                
                if(!isDedicated && !isHC) then {
                        // remove main menu
                        [
                                "player",
                                [SELF_INTERACTION_KEY],
                                -9500,
                                [
                                        "call ALIVE_fnc_vdistMenuDef",
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


