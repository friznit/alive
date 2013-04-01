#include <\x\alive\addons\fnc_strategic\script_component.hpp>
SCRIPT(assignPointsToClusters);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_assignPointsToClusters

Description:
Adds the given points to the closest Cluster.

Parameters:
Array - A list of cluster objects
Array - A list of objects to associate with nearest cluster

Examples:
(begin example)
// reassign objects to nearest cluster
[_clusters, _obj_array] call ALIVE_fnc_assignPointsToClusters;
(end)

See Also:
- <ALIVE_fnc_getNearestObjectInCluster>
- <ALIVE_fnc_findClusters>

Author:
Wolffy.au
---------------------------------------------------------------------------- */

private ["_clusters","_points","_err","_chk"];
PARAMS_2(_clusters,_points);
_err = "initial centres array not valid";
ASSERT_DEFINED("_clusters",_err);
ASSERT_DEFINED("_points",_err);
ASSERT_TRUE(typeName _clusters == "ARRAY",_err);
ASSERT_TRUE(typeName _points == "ARRAY",_err);
ASSERT_TRUE(count _clusters <= count _points,_err);

{
	_x setVariable ["ClusterNodes", []];
} forEach _clusters;

{
	private ["_cluster"];
	_cluster = [_x, _clusters] call ALIVE_fnc_getNearestObjectInCluster;
	[_cluster,"ClusterNodes",[_x]] call BIS_fnc_variableSpaceAdd;
} forEach _points;

_chk = 0;
{
	_chk = _chk + count (_x getVariable "ClusterNodes");
} forEach _clusters;
_err = "points assignment not valid";
ASSERT_TRUE(typeName _clusters == "ARRAY",_err);
ASSERT_TRUE(typeName _points == "ARRAY",_err);
ASSERT_TRUE(_chk == count _points,_err);
true;
