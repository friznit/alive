#include <\x\alive\addons\sys_player\script_component.hpp>
SCRIPT(playerInit);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_playerInit
Description:
Creates the server side object to store settings

Parameters:
_this select 0: OBJECT - Reference to module

Returns:
Nil

See Also:
- <ALIVE_fnc_player>

Author:
Tupolov

Peer Reviewed:
nil
---------------------------------------------------------------------------- */

private ["_logic"];

PARAMS_1(_logic);

// Confirm init function available
ASSERT_DEFINED("ALIVE_fnc_player","Main function missing");

[_logic, "init",[]] call ALIVE_fnc_player;

