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
- <ALIVE_fnc_getNearestObjectInArray>
- <ALIVE_fnc_findClusters>

Author:
Wolffy.au
---------------------------------------------------------------------------- */

private ["_nodes","_err","_xc","_yc","_count","_result"];
_nodes = [_this, 0, [], [[]]] call BIS_fnc_param;
_err = format["cluster nodes array not valid - %1",_nodes];
ASSERT_DEFINED("_nodes",_err);
ASSERT_TRUE(typeName _nodes == "ARRAY",_err);

_result = [];
if(count _nodes > 0) then {
	_xc = 0;
	_yc = 0;
	{
		_xc = _xc + ((getPosATL _x) select 0);
		_yc = _yc + ((getPosATL _x) select 1);
	} forEach _nodes;

	_count = count _nodes;
	_result = [_xc / _count, _yc / _count];
};
_result;
