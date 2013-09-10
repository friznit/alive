//#define DEBUG_MODE_FULL
#include <\x\alive\addons\mil_strategic\script_component.hpp>
SCRIPT(setTargets);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_setTargets
Description:
Set cluster values on array of clusters

Parameters:
Array - Array of clusters
String - Type of clusters to set
Scalar - Priority of clusters to set
String - Debug color of clusters to set

Returns:
Array - array of clusters with parameters set

Examples:
(begin example)
_main_object = ["MIL", 50, "ColorRed"] call ALIVE_fnc_setTargets;
(end)

See Also:

Author:
Wolffy
ARJay
Peer Reviewed:
nil
---------------------------------------------------------------------------- */


private ["_clusters","_type","_priority","_debugColour"];

_clusters = [_this, 0, [], [[]]] call BIS_fnc_param;
_type = [_this, 1, "", [""]] call BIS_fnc_param;
_priority = [_this, 2, 0, [0]] call BIS_fnc_param;
_debugColour = [_this, 3, "ColorRed", ["String"]] call BIS_fnc_param;

{
	[_x, "type", _type] call ALIVE_fnc_cluster;
	[_x, "priority", _priority] call ALIVE_fnc_cluster;
	[_x, "debugColor", _debugColour] call ALIVE_fnc_hashSet;
} forEach _clusters;

_clusters