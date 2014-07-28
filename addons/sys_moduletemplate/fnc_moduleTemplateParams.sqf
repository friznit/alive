#include <\x\alive\addons\sys_moduletemplate\script_component.hpp>
SCRIPT(moduletemplateParams);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_moduletemplateParams
Description:

Creates the parameter configuration module

Parameters:
_this select 0: OBJECT - Reference to module logic

Returns:
Nil

See Also:
- <ALIVE_fnc_moduletemplate>

Author:
Highhead

Peer Reviewed:
nil
---------------------------------------------------------------------------- */
if !(isServer) exitwith {};

private ["_logic"];

PARAMS_1(_logic);

_debug = _logic getvariable ["DEBUG","false"];

waituntil {!isnil QMOD(SYS_MODULETEMPLATE)};

MOD(SYS_MODULETEMPLATE) setvariable ["DEBUG", call compile _debug, true];

_logic