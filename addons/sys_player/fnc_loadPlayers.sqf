#include <\x\alive\addons\sys_player\script_component.hpp>
SCRIPT(LoadPlayers);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_LoadPlayers
Description:
Load all player data for the current mission.  It loads the list of players first, then it proceeds to load the document relating to this mission for each player.

Parameters:
Object - If Nil, return a new instance. If Object, reference an existing instance.
Array - The selected parameters

Returns:
Hash - Array of player data

Examples:
(begin example)
//
(end)

See Also:
- <ALIVE_fnc_playerInit>
- <ALIVE_fnc_playerMenuDef>

Author:
Tupolov

Peer reviewed:
nil
---------------------------------------------------------------------------- */

private ["_logic","_args","_result"];

_logic = [_this, 0, objNull, [objNull,[]]] call BIS_fnc_param;
_args = [_this, 1, objNull, [objNull,[],"",0,true,false]] call BIS_fnc_param;

_result = true;
//