#include <\x\alive\addons\sys_GC\script_component.hpp>
SCRIPT(GCInit);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_GCInit
Description:
Creates the server side object to store settings

Parameters:
_this select 0: OBJECT - Reference to module
_this select 1: ARRAY - Synchronized units

Returns:
Nil

See Also:
- <ALIVE_fnc_GC>

Author:
Wolffy.au

Peer Reviewed:
nil
---------------------------------------------------------------------------- */

private ["_logic"];

PARAMS_1(_logic);
//DEFAULT_PARAM(1,_syncunits, []);

// Confirm init function available
ASSERT_DEFINED("ALIVE_fnc_GC","Main function missing");

["ALiVE [11] GC INIT"] call ALIVE_fnc_dump;

[_logic, "init"] call ALIVE_fnc_GC;

["ALiVE [11] GC INIT COMPLETE"] call ALIVE_fnc_dump;
