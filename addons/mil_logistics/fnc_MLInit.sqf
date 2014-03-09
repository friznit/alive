#include <\x\alive\addons\mil_logistics\script_component.hpp>
SCRIPT(MLInit);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_MLInit
Description:
Creates the server side object to store settings

Parameters:
_this select 0: OBJECT - Reference to module
_this select 1: ARRAY - Synchronized units

Returns:
Nil

See Also:
- <ALIVE_fnc_ML>

Author:
ARJay

Peer Reviewed:
nil
---------------------------------------------------------------------------- */

private ["_logic"];

PARAMS_1(_logic);
//DEFAULT_PARAM(1,_syncunits, []);

// Confirm init function available
ASSERT_DEFINED("ALIVE_fnc_ML","Main function missing");

["ALiVE [9] ML INIT"] call ALIVE_fnc_dump;

[_logic, "init"] call ALIVE_fnc_ML;

["ALiVE [9] ML INIT COMPLETE"] call ALIVE_fnc_dump;
