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

// Only on Server
if (isServer) then {
    //Sets global type of Versioning (Kick or Warn)
	MOD(VERSIONINGTYPE) = _logic getvariable [QMOD(VERSIONING),"warning"];
	Publicvariable QMOD(VERSIONINGTYPE);
    
    //Enables/Disables SP saving possibility, default value true due to out of mem crashes
    MOD(DISABLESAVE) = _logic getvariable [QMOD(DISABLESAVE),"true"];
    Publicvariable QMOD(DISABLESAVE);

    //Waiting for the mandatory modules below, mind that not all modules need to be initialised before mission start
	waitUntil {
		[
	        QMOD(AMB_CIV_PLACEMENT),
	        QMOD(MIL_PLACEMENT),
	        QMOD(CIV_PLACEMENT)
        ] call ALiVE_fnc_isModuleInitialised;
	};

    //This is the last module init to be run, therefore indicates that init of the defined modules above has passed on server
    MOD(REQUIRE_INITIALISED) = true;
    Publicvariable QMOD(REQUIRE_INITIALISED);
};

// Only on clients
if (hasInterface) then {
    waituntil {!isnil QMOD(DISABLESAVE)}; // Wait for global var to be set on Server
    if (call compile MOD(DISABLESAVE)) then {enableSaving [false, false]};
};

[_logic, false, _moduleID] call ALIVE_fnc_dumpModuleInit;

["ALiVE Global INIT COMPLETE"] call ALIVE_fnc_dump;
[false,"ALiVE Global Init Timer Complete","INIT"] call ALIVE_fnc_timer;
[" "] call ALIVE_fnc_dump;
