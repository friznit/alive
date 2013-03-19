#include <\x\alive\addons\sys_rwg\script_component.hpp>
SCRIPT(RWGInit);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_RWGInit
Description:
Creates the server side object to store settings

Parameters:
_this select 0: OBJECT - Reference to module


Returns:
Nil

See Also:
- <ALIVE_fnc_RWG>

Author:
Highhead
Peer Reviewed:
nil
---------------------------------------------------------------------------- */

private ["_logic"];

PARAMS_1(_logic);
//DEFAULT_PARAM(1,_syncunits, []);

// Confirm init function available
ASSERT_DEFINED("ALIVE_fnc_RWG","Main function missing");

[_logic, "init"] call ALIVE_fnc_RWG;


