#include <\x\alive\addons\amb_civ_placement\script_component.hpp>
SCRIPT(AMBCPInit);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_AMBCPInit
Description:
Creates the server side object to store settings

Parameters:
_this select 0: OBJECT - Reference to module
_this select 1: ARRAY - Synchronized units

Returns:
Nil

See Also:

Author:
ARJay
Peer Reviewed:
nil
---------------------------------------------------------------------------- */

private ["_logic"];

PARAMS_1(_logic);
//DEFAULT_PARAM(1,_syncunits, []);

// Confirm init function available
ASSERT_DEFINED("ALIVE_fnc_AMBCP","Main function missing");

["AMBCP INIT"] call ALIVE_fnc_dump;

[_logic, "init"] call ALIVE_fnc_AMBCP;

["AMBCP INIT COMPLETE"] call ALIVE_fnc_dump;