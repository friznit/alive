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

	//This is the last module init to be run, indicates that init has passed on server
    ALiVE_REQUIRE_INITIALISED = true;
    Publicvariable "ALiVE_REQUIRE_INITIALISED";
};

["ALiVE [%1] %2 INIT COMPLETE",(getNumber(configfile >> "CfgVehicles" >>  typeOf _logic >> "functionPriority")),typeof _logic] call ALIVE_fnc_dump;
