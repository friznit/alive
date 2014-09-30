#include <\x\alive\addons\sys_quickstart\script_component.hpp>
SCRIPT(quickstartParams);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_quickstartParams
Description:

Creates the parameter configuration module

Parameters:
_this select 0: OBJECT - Reference to module logic

Returns:
Nil

See Also:
- <ALIVE_fnc_quickstart>

Author:
Highhead

Peer Reviewed:
nil
---------------------------------------------------------------------------- */
if !(isServer) exitwith {};

private ["_logic"];

PARAMS_1(_logic);

_debug = _logic getvariable ["DEBUG","false"];

waituntil {!isnil QMOD(SYS_quickstart)};

MOD(SYS_quickstart) setvariable ["DEBUG", call compile _debug, true];

_logic