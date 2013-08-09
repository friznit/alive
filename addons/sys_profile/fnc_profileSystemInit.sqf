#include <\x\alive\addons\mil_strategic\script_component.hpp>
SCRIPT(profileSystemInit);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_profileSystemInit
Description:
Creates the server side object to store settings

Parameters:
_this select 0: OBJECT - Reference to module

Returns:
Nil

See Also:

Author:
ARjay
Peer Reviewed:
nil
---------------------------------------------------------------------------- */

private ["_logic","_debug","_profileSystem"];

PARAMS_1(_logic);

// Confirm init function available
ASSERT_DEFINED("ALIVE_fnc_profileSystem","Main function missing");

_debug = _logic getVariable ["debug",false];

if(_debug == "true") then {
	_debug = true;
}else{
	_debug = false;
};

_profileSystem = [nil, "create"] call ALIVE_fnc_profileSystem;
[_profileSystem, "init"] call ALIVE_fnc_profileSystem;
[_profileSystem, "debug", _debug] call ALIVE_fnc_profileSystem;
[_profileSystem, "start"] call ALIVE_fnc_profileSystem;
