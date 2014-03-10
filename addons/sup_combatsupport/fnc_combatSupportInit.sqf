#include <\x\alive\addons\sup_combatSupport\script_component.hpp>
SCRIPT(CombatSupportInit);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_combatSupportInit
Description:
Creates the server side object to store settings

Parameters:
_this select 0: OBJECT - Reference to module


Returns:
Nil

See Also:
- <ALIVE_fnc_combatSupport>

Author:
Gunny
Peer Reviewed:
nil
---------------------------------------------------------------------------- */

private ["_logic"];

PARAMS_1(_logic);
//DEFAULT_PARAM(1,_syncunits, []);

// Confirm init function available
ASSERT_DEFINED("ALIVE_fnc_CombatSupport","Main function missing");

["ALiVE [%1] %2 INIT",(getNumber(configfile >> "CfgVehicles" >>  typeOf _logic >> "functionPriority")),typeof _logic] call ALIVE_fnc_dump;

[_logic, "init"] call ALIVE_fnc_CombatSupport;

["ALiVE [%1] %2 INIT COMPLETE",(getNumber(configfile >> "CfgVehicles" >>  typeOf _logic >> "functionPriority")),typeof _logic] call ALIVE_fnc_dump;



