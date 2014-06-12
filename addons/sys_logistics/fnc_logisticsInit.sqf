#include <\x\alive\addons\sys_logistics\script_component.hpp>
SCRIPT(logisticsInit);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_logisticsInit
Description:
Creates the server side object to store settings

Parameters:
_this select 0: OBJECT - Reference to module logic

Returns:
Nil

See Also:
- <ALIVE_fnc_logistics>

Author:
Highhead

Peer Reviewed:
nil
---------------------------------------------------------------------------- */

private ["_logic","_moduleID"];

PARAMS_1(_logic);

// Confirm init function available
ASSERT_DEFINED("ALIVE_fnc_logistics","Main function missing");

_moduleID = [_logic, true] call ALIVE_fnc_dumpModuleInit;

[_logic, "init",[]] call ALIVE_fnc_logistics;

[_logic, false, _moduleID] call ALIVE_fnc_dumpModuleInit;

true