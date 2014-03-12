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

private ["_logic","_moduleID"];

PARAMS_1(_logic);
//DEFAULT_PARAM(1,_syncunits, []);

// Do Something

_moduleID = [_logic, true] call ALIVE_fnc_dumpModuleInit;

//_moduleID = [_logic, true] call ALIVE_fnc_dumpModuleInit;

if (isServer) then {
    //Sets global type of Versioning (Kick or Warn)
	ALiVE_VERSIONING_TYPE = _logic getvariable ["ALiVE_Versioning","warning"];
	Publicvariable "ALiVE_Versioning_Type";

    //Waiting for the mandatory modules below, mind that not all modules need to be initialised before mission start
	waitUntil {
		[
	        "ALiVE_amb_civ_placement",
	        "ALiVE_mil_placement",
	        "ALiVE_civ_placement"
        ] call ALiVE_fnc_isModuleInitialised;
	};

    //This is the last module init to be run, therefore indicates that init of the defined modules above has passed on server
    ALiVE_REQUIRE_INITIALISED = true;
    Publicvariable "ALiVE_REQUIRE_INITIALISED";

};


[_logic, false, _moduleID] call ALIVE_fnc_dumpModuleInit;

["ALiVE Global INIT COMPLETE"] call ALIVE_fnc_dump;
[false,"ALiVE Global Init Timer Complete","INIT"] call ALIVE_fnc_timer;
[" "] call ALIVE_fnc_dump;

//[_logic, false, _moduleID] call ALIVE_fnc_dumpModuleInit;
