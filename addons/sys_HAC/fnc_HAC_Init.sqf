#include <\x\alive\addons\nme_CQB\script_component.hpp>
SCRIPT(CQBInit);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_HAC_Init
Description:
Creates the server side object to store settings

Parameters:
_this select 0: OBJECT - Reference to module
_this select 1: STRING - operation

Returns:
Nil

See Also:
- <ALIVE_fnc_CQB>

Author:
Wolffy.au
Highhead
Peer Reviewed:
nil
---------------------------------------------------------------------------- */

private ["_logic"];

PARAMS_1(_logic);
//DEFAULT_PARAM(1,_syncunits, []);

// Confirm init function available
ASSERT_DEFINED("ALIVE_fnc_HAC","Main function missing");

[_logic, "init"] call ALIVE_fnc_HAC;
//[_logic, "syncunits", _syncunits] call ALIVE_fnc_CQB;


