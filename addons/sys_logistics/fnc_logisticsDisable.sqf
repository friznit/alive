#include <\x\alive\addons\sys_logistics\script_component.hpp>
SCRIPT(logisticsDisable);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_logisticsDisable
Description:

Creates the disable logistics module

Parameters:
_this select 0: OBJECT - Reference to module logic

Returns:
Nil

See Also:
- <ALIVE_fnc_logistics>

Author:
Highhead

Peer Reviewed:
nil
---------------------------------------------------------------------------- */
if !(isServer) exitwith {};

private ["_logic"];

PARAMS_1(_logic);

_debug = _logic getvariable ["DEBUG","false"];
_disableCarry = _logic getvariable ["DISABLECARRY","false"];
_disablePersistence = _logic getvariable ["DISABLEPERSISTENCE","false"];
_disableTow = _logic getvariable ["DISABLETOW","false"];
_disableLift = _logic getvariable ["DISABLELIFT","false"];
_disableLoad = _logic getvariable ["DISABLELOAD","false"];
_disable3D = _logic getvariable ["DISABLE3D","false"];

waituntil {!isnil QMOD(SYS_LOGISTICS)};

MOD(SYS_LOGISTICS) setvariable ["DEBUG", call compile _debug, true];
MOD(SYS_LOGISTICS) setvariable ["DISABLECARRY",call compile _disableCarry, true];
MOD(SYS_LOGISTICS) setvariable ["DISABLEPERSISTENCE",call compile _disablePersistence, true];
MOD(SYS_LOGISTICS) setvariable ["DISABLETOW",call compile _disableTow, true];
MOD(SYS_LOGISTICS) setvariable ["DISABLELIFT",call compile _disableLift, true];
MOD(SYS_LOGISTICS) setvariable ["DISABLELOAD",call compile _disableLoad, true];
MOD(SYS_LOGISTICS) setvariable ["DISABLE3D",call compile _disable3D, true];

_logic