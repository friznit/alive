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

private ["_logic","_activated"];

PARAMS_1(_logic);

// Confirm init function available
ASSERT_DEFINED("ALIVE_fnc_player","Main function missing");

["ALiVE [%1] %2 INIT",(getNumber(configfile >> "CfgVehicles" >>  typeOf _logic >> "functionPriority")),typeof _logic] call ALIVE_fnc_dump;

//_activated = [_this,2,true,[true]] call BIS_fnc_param;

//if (_activated) then {
	[_logic, "init",[]] call ALIVE_fnc_player;
//

["ALiVE [%1] %2 INIT COMPLETE",(getNumber(configfile >> "CfgVehicles" >>  typeOf _logic >> "functionPriority")),typeof _logic] call ALIVE_fnc_dump;

true