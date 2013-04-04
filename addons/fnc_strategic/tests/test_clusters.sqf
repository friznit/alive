// ----------------------------------------------------------------------------

#include <\x\alive\addons\fnc_strategic\script_component.hpp>
SCRIPT(test_clusters);

// ----------------------------------------------------------------------------

private ["_result","_expected","_err","_obj_array","_point","_center","_clusters","_m"];

LOG("Testing Clusters");

ASSERT_DEFINED("ALIVE_fnc_getObjectsByType","");
ASSERT_DEFINED("ALIVE_fnc_getNearestObjectInCluster","");
ASSERT_DEFINED("ALIVE_fnc_findClusterCenter","");
ASSERT_DEFINED("ALIVE_fnc_chooseInitialCenters","");
ASSERT_DEFINED("ALIVE_fnc_assignPointsToClusters","");
ASSERT_DEFINED("ALIVE_fnc_findClusters","");

#define STAT(msg) sleep 3; \
diag_log ["TEST("+str player+": "+msg]; \
titleText [msg,"PLAIN"]

#define STAT1(msg) CONT = false; \
waitUntil{CONT}; \
diag_log ["TEST("+str player+": "+msg]; \
titleText [msg,"PLAIN"]

_err = format["Mission objects: %1", count allMissionObjects ""];
STAT(_err);

STAT("Create mock objects");
_obj_array = [];
createCenter sideLogic;
{
	_obj_array set [count _obj_array, (createGroup sideLogic) createUnit ["LOGIC", (player modelToWorld _x), [], 0, "NONE"]];
} forEach [
	[-1200,-900],
	[-900,-600],
	[-600,-900],
	[300,0],
	[300,1200],
	[600,900],
	[900,600],
	[900,300]
];
_err = "create mock objects";
ASSERT_DEFINED("_obj_array",_err);
ASSERT_TRUE(typeName _obj_array == "ARRAY", _err);
ASSERT_TRUE(count _obj_array == 8,_err);
{
        _m = createMarker [str _x, getPosATL _x];
        _m setMarkerShape "Icon";
        _m setMarkerSize [1, 1];
        _m setMarkerType "mil_dot";
} forEach _obj_array;

STAT("Test finding nearest object from cluster");
_point = _obj_array select 0;
_result = [_point, _obj_array] call ALIVE_fnc_getNearestObjectInCluster;
_expected = _obj_array select 1;
_err = "getNearestObjectInCluster #1";
ASSERT_TRUE(_result == _expected, _err);
(str _point) setMarkerColor "ColorBlue";
(str _result) setMarkerColor "ColorBlue";
[_result, _point] call ALIVE_fnc_createLink;

STAT("Finding nearest object #2 from cluster");
_point = _obj_array select 6;
_result = [_point, _obj_array] call ALIVE_fnc_getNearestObjectInCluster;
_expected = _obj_array select 7;
_err = "getNearestObjectInCluster #2";
ASSERT_TRUE(_result == _expected, _err);
(str _point) setMarkerColor "ColorBlue";
(str _result) setMarkerColor "ColorBlue";
[_result, _point] call ALIVE_fnc_createLink;

STAT("Test finding centre of cluster of objects");
_center = [_obj_array] call ALIVE_fnc_findClusterCenter;
_err = "cluster center";
ASSERT_DEFINED("_center",_err);
ASSERT_TRUE(typeName _center == "ARRAY", _err);
ASSERT_TRUE(count _center == 2,_err);
_m = createMarker [str _center, _center];
_m setMarkerShape "Icon";
_m setMarkerSize [1, 1];
_m setMarkerType "mil_dot";
_m setMarkerColor "ColorOrange";
_m setMarkerText "Cluster Center";

STAT("Find initial cluster seed centres");
_clusters = [_obj_array] call ALIVE_fnc_chooseInitialCenters;
_err = "cluster center";
ASSERT_DEFINED("_clusters",_err);
ASSERT_TRUE(typeName _clusters == "ARRAY", _err);
ASSERT_TRUE(count _clusters == ceil(sqrt(count _obj_array / 2)),_err);
{
        _m = createMarker [str _x, getPosATL _x];
	_m setMarkerShape "Icon";
	_m setMarkerSize [1, 1];
	_m setMarkerType "mil_dot";
	_m setMarkerColor "ColorYellow";
	_m setMarkerText format["Cluster Center #%1", _forEachIndex];
} forEach _clusters;

STAT("Reassign objects to nearest cluster #1");
[_clusters, _obj_array] call ALIVE_fnc_assignPointsToClusters;
_err = "cluster reassignment #1";
ASSERT_DEFINED("_clusters",_err);
ASSERT_TRUE(typeName _clusters == "ARRAY", _err);
ASSERT_TRUE(count _clusters == ceil(sqrt(count _obj_array / 2)),_err);
{
	_x setPos ([_x getVariable "ClusterNodes"] call ALIVE_fnc_findClusterCenter);
	str _x setMarkerPos getPosATL _x;
} forEach _clusters;

STAT("Reassign objects to nearest cluster #2");
[_clusters, _obj_array] call ALIVE_fnc_assignPointsToClusters;
_err = "cluster reassignment #2";
ASSERT_DEFINED("_clusters",_err);
ASSERT_TRUE(typeName _clusters == "ARRAY", _err);
ASSERT_TRUE(count _clusters == ceil(sqrt(count _obj_array / 2)),_err);
{
	_x setPos ([_x getVariable "ClusterNodes"] call ALIVE_fnc_findClusterCenter);
	str _x setMarkerPos getPosATL _x;
} forEach _clusters;

{
	deleteMarker str _x;
} forEach _clusters;

STAT("Run same exercise using the findClusters function");
_clusters = [_obj_array] call ALIVE_fnc_findClusters;
_err = "finding clusters";
ASSERT_TRUE(typeName _clusters == "ARRAY", _err);
ASSERT_TRUE(count _clusters == ceil(sqrt(count _obj_array / 2)),_err);
{
        _m = createMarker [str _x, getPosATL _x];
	_m setMarkerShape "Icon";
	_m setMarkerSize [1, 1];
	_m setMarkerType "mil_dot";
	_m setMarkerColor "ColorYellow";
	_m setMarkerText format["Cluster Center #%1", _forEachIndex];
} forEach _clusters;


STAT("Clean up markers");
deleteMarker str _center;
{
	deleteMarker str _x;
} forEach _obj_array;
[_obj_array select 1, _obj_array select 0] call ALIVE_fnc_deleteLink;
[_obj_array select 7, _obj_array select 6] call ALIVE_fnc_deleteLink;
{
	deleteMarker str _x;
} forEach _clusters;

_err = format["Mission objects: %1", count allMissionObjects ""];
STAT(_err);

nil;
