#include <\x\alive\addons\mil_strategic\script_component.hpp>
SCRIPT(composeForce);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_composeForce
Description:
Identify the composition of enemy force

Parameters:
Object - The SEP Logic

Returns:
Array - A hashmap of enemy force make up

Examples:
(begin example)
_main_object = [
        ["miloffices"] call ALIVE_fnc_getObjectsByType,
        position player,
        2500
] call ALIVE_fnc_findHQ;
(end)

See Also:
- <ALIVE_fnc_SEP>

Author:
Wolffy.au
Peer Reviewed:
nil
---------------------------------------------------------------------------- */

private ["_logic","_result"];

// Get logic
PARAMS_1(_logic);

_result = [];

// Return hashmap
_result;

