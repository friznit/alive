#include <\x\alive\addons\mil_insurgency\script_component.hpp>
SCRIPT(insurgencyParams);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_insurgencyParams
Description:

Creates the parameter configuration module

Parameters:
_this select 0: OBJECT - Reference to module logic

Returns:
Nil

See Also:
- <ALIVE_fnc_insurgency>

Author:
Highhead

Peer Reviewed:
nil
---------------------------------------------------------------------------- */
if !(isServer) exitwith {};

private ["_logic"];

PARAMS_1(_logic);

_debug = _logic getvariable ["DEBUG","false"];

waituntil {!isnil QMOD(mil_insurgency)};

MOD(mil_insurgency) setvariable ["DEBUG", call compile _debug, true];

_logic