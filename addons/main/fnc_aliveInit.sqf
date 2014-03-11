#include <\x\alive\addons\main\script_component.hpp>
SCRIPT(aliveInit);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_aliveInit
Description:
Creates the server side object to store settings

Parameters:
_this select 0: OBJECT - Reference to module
_this select 1: ARRAY - Synchronized units

Returns:
Nil

See Also:
- <ALIVE_fnc_alive>

Author:
Wolffy.au
Tupolov
Peer Reviewed:
nil
---------------------------------------------------------------------------- */

private ["_logic"];

PARAMS_1(_logic);
//DEFAULT_PARAM(1,_syncunits, []);

// Do Something
["ALiVE [%1] %2 INIT",(getNumber(configfile >> "CfgVehicles" >>  typeOf _logic >> "functionPriority")),typeof _logic] call ALIVE_fnc_dump;

if (isServer) then {
    //Sets global type of Versioning (Kick or Warn)
	ALiVE_VERSIONING_TYPE = _logic getvariable ["ALiVE_Versioning","warning"];
	Publicvariable "ALiVE_Versioning_Type";


    // mini registry
    // checks for startupComplete var of modules defined in _waitModules

	private ["_waitModules","_modules","_init","_startupComplete"];

	_waitModules = ["ALiVE_amb_civ_placement","ALiVE_mil_placement","ALiVE_civ_placement"];
	_modules = entities "Module_F";

	waitUntil {
	    _init = true;
        {
            //["MODULE: %1 %2 %3",_x,typeof _x] call ALIVE_fnc_dump;
            if(typeof _x in _waitModules) then {
                _startupComplete = _x getVariable ["startupComplete",false];
                //["MODULE STARTUP COMPLETE: %1 %2",typeof _x,_startupComplete] call ALIVE_fnc_dump;
                if!(_startupComplete) then {
                    _init = false;
                };
            };
        } foreach _modules;
        ["ALL MODULES STARTED: %1",_init] call ALIVE_fnc_dump;
	    _init
	};



	//This is the last module init to be run, indicates that init has passed on server
    ALiVE_REQUIRE_INITIALISED = true;
    Publicvariable "ALiVE_REQUIRE_INITIALISED";
};

["ALiVE [%1] %2 INIT COMPLETE",(getNumber(configfile >> "CfgVehicles" >>  typeOf _logic >> "functionPriority")),typeof _logic] call ALIVE_fnc_dump;
