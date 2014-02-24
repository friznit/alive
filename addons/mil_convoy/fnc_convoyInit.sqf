#include <\x\alive\addons\mil_convoy\script_component.hpp>
SCRIPT(CONVOYInit);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_TransportInit
Description:
Creates the server side object to store settings

Parameters:
_this select 0: OBJECT - Reference to module
_this select 1: ARRAY - Synchronized units

Returns:
Nil

See Also:
- <ALIVE_fnc_CONVOY>

Author:
Gunny

Peer Reviewed:
nil
---------------------------------------------------------------------------- */

private ["_logic"];

PARAMS_1(_logic);
//DEFAULT_PARAM(1,_syncunits, []);

// Confirm init function available
ASSERT_DEFINED("ALIVE_fnc_CONVOY","Main function missing");

["MIL CONVOY INIT"] call ALIVE_fnc_dump;

[_logic, "init"] call ALIVE_fnc_convoy;
