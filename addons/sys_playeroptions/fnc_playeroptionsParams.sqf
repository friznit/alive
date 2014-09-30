#include <\x\alive\addons\sys_playeroptions\script_component.hpp>
SCRIPT(playeroptionsParams);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_playeroptionsParams
Description:

Creates the parameter configuration module

Parameters:
_this select 0: OBJECT - Reference to module logic

Returns:
Nil

See Also:
- <ALIVE_fnc_playeroptions>

Author:
Highhead

Peer Reviewed:
nil
---------------------------------------------------------------------------- */
if !(isServer) exitwith {};

private ["_logic"];

PARAMS_1(_logic);

_debug = _logic getvariable ["DEBUG","false"];

waituntil {!isnil QMOD(SYS_playeroptions)};

MOD(SYS_playeroptions) setvariable ["DEBUG", call compile _debug, true];

_logic