#include <\x\alive\addons\mil_intelligence\script_component.hpp>
SCRIPT(SDInit);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_SDInit
Description:
Creates the server side object to store settings

Parameters:
_this select 0: OBJECT - Reference to module
_this select 1: ARRAY - Synchronized units

Returns:
Nil

See Also:
- <ALIVE_fnc_MI>

Author:
ARJay

Peer Reviewed:
nil
---------------------------------------------------------------------------- */

private ["_logic"];

PARAMS_1(_logic);
//DEFAULT_PARAM(1,_syncunits, []);

// Confirm init function available
ASSERT_DEFINED("ALIVE_fnc_SD","Main function missing");

["ALiVE [8] SD INIT"] call ALIVE_fnc_dump;

[_logic, "runEvery", _logic getVariable ["runEvery","1"]] call ALIVE_fnc_SD;

[_logic, "init"] call ALIVE_fnc_SD;

["ALiVE [8] SD INIT COMPLETE"] call ALIVE_fnc_dump;
