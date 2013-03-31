#include <\x\alive\addons\fnc_strategic\script_component.hpp>
SCRIPT(findClusterCenter);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_findClusterCenter

Description:
Return the centre position of an object cluster

Parameters:
Array - A list of objects to identify clusters

Returns:
Array - Average central position of the cluster

Examples:
(begin example)
// identify clusters of objects
_center = [_obj_array] call ALIVE_fnc_findClusterCenter;
(end)

See Also:
- <ALIVE_fnc_getNearestObjectInCluster>
- <ALIVE_fnc_findClusters>

Author:
Wolffy.au
---------------------------------------------------------------------------- */

private ["_nodes","_err","_nodes","_xc","_yc","_count"];
PARAMS_1(_nodes);
_err = "cluster nodes array not valid";
ASSERT_DEFINED("_nodes",_err);
ASSERT_TRUE(typeName _nodes == "ARRAY",_err);
ASSERT_TRUE(count _nodes > 0,_err);

_xc = 0;
_yc = 0;
{
	_xc = _xc + ((getPosATL _x) select 0);
	_yc = _yc + ((getPosATL _x) select 1);
} forEach _nodes;

_count = count _nodes;
[_xc / _count, _yc / _count];
