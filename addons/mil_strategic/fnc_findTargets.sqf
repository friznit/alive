//#define DEBUG_MODE_FULL
#include <\x\alive\addons\mil_strategic\script_component.hpp>
SCRIPT(findTargets);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_findTargets
Description:
Identify targets within the TAOR

Parameters:
Array - A list of objects to identify locations
Array - Position identifying Centre of Mass
Scalar - Max Radius from CoM (optional)

Returns:
Object - A random object from the list within the radius of the position

Examples:
(begin example)
_main_object = [
        ["miloffices"] call ALIVE_fnc_getObjectsByType,
        position player,
        2500
] call ALIVE_fnc_findTargets;
(end)

See Also:
- <ALIVE_fnc_getObjectsByType>

Author:
Wolffy.au
Peer Reviewed:
nil
---------------------------------------------------------------------------- */


private ["_logic","_types","_obj_array","_clusters"];


_logic = [_this, 0, objNull, [objNull]] call BIS_fnc_param;
_types = [_this, 1, [], [[]]] call BIS_fnc_param;

TRACE_1("findTargets - input",_types);

_obj_array = _types call ALIVE_fnc_getObjectsByType;
_obj_array = [[_logic, "taor"] call ALIVE_fnc_MO, _obj_array, true] call ALIVE_fnc_validateLocations;
_obj_array = [[_logic, "blacklist"] call ALIVE_fnc_MO, _obj_array, false] call ALIVE_fnc_validateLocations;
_clusters = [_obj_array] call ALIVE_fnc_findClusters;

TRACE_1("findTargets - output",_clusters);
_clusters;