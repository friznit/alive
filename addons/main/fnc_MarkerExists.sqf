#include <\x\alive\addons\main\script_component.hpp>
SCRIPT(MarkerExists);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_isHC
Description:
Checks if the marker given exists on map

Parameters:
Markername

Returns:
Bool - Returns true if player is a headless client

Examples:
(begin example)
_Exists = ["respawn_west"] call MarkerExists;
(end)

See Also:
- nil

Author:
Highhead

Peer reviewed:
nil
---------------------------------------------------------------------------- */
private ["_markername","_markerpos"];

_markername = _this select 0;
_markerpos = str(markerpos _markername);

switch (_markerpos) do {
	case ("[0,0,0]"): {false};
	default {true};
};