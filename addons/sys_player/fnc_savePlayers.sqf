#include <\x\alive\addons\sys_player\script_component.hpp>
SCRIPT(SavePlayers);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_SavePlayers
Description:
Save all player data for the current mission. Uses the key defined in the module to create or append a mission record listing all the players that have state in game. It then saves all player states to the database.

Parameters:
Object - If Nil, return a new instance. If Object, reference an existing instance.
Array - The selected parameters

Returns:
String - Success or error message

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

// Get the key for the mission
// See if the document exists / check for a clash?
// Append any new players to the list, all players that have played not just current - so check the store for that
// For each player in the store, save their data to a document in the player table, unique key is the mission key + player uid


_result = true;