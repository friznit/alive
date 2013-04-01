#include <\x\alive\addons\fnc_strategic\script_component.hpp>
SCRIPT(findClusters);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_findClusters

Description:
Returns a list of logics representing clusters of objects

K-means++ code inspired from: http://commons.apache.org/math/api-2.1/index.html?org/apache/commons/math/stat/clustering/KMeansPlusPlusClusterer.html

Parameters:
Array - A list of objects to identify clusters

Returns:
Array - List of cluster logics from the objects specified

Examples:
(begin example)
// identify clusters of objects
_clusters = [_obj_array] call ALIVE_fnc_findClusters;
(end)

See Also:
- <ALIVE_fnc_chooseInitialCenters>
- <ALIVE_fnc_assignPointsToClusters>
- <ALIVE_fnc_findClusterCenter>

Author:
Wolffy.au
---------------------------------------------------------------------------- */

private ["_obj_array","_err","_clusters","_k"];
PARAMS_1(_obj_array);
_err = "objects provided not valid";
ASSERT_DEFINED("_obj_array", _err);
ASSERT_OP(typeName _obj_array, == ,"ARRAY", _err);
ASSERT_OP(count _obj_array,>,0,_err);

_k = ceil(sqrt(count _obj_array / 2));

// create the initial cluster centers
_clusters = [_obj_array] call ALIVE_fnc_chooseInitialCenters;
for "_i" from 0 to _k do {
        [_clusters, _obj_array] call ALIVE_fnc_assignPointsToClusters;
        {
                private["_nodes"];
                _nodes = _x getVariable "ClusterNodes";
                if(count _nodes > 0) then {
                        _x setPos ([_nodes] call ALIVE_fnc_findClusterCenter);
                };
                
        } forEach _clusters;

        _clusters = ([_clusters] call ALIVE_fnc_consolidateClusters) select 0;
};

_clusters;
