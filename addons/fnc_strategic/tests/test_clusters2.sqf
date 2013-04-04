// ----------------------------------------------------------------------------

#include <\x\alive\addons\fnc_strategic\script_component.hpp>
SCRIPT(test_clusters2);

// ----------------------------------------------------------------------------

private ["_err","_obj_array","_center","_clusters"];

LOG("Testing Clusters 2");

// UNIT TESTS (initStrings.sqf - stringJoin)
ASSERT_DEFINED("ALIVE_fnc_getObjectsByType","");
ASSERT_DEFINED("ALIVE_fnc_getNearestObjectInCluster","");
ASSERT_DEFINED("ALIVE_fnc_findClusterCenter","");
ASSERT_DEFINED("ALIVE_fnc_chooseInitialCenters","");
ASSERT_DEFINED("ALIVE_fnc_assignPointsToClusters","");
ASSERT_DEFINED("ALIVE_fnc_findClusters","");
ASSERT_DEFINED("ALIVE_fnc_consolidateClusters","");

#define STAT(msg) sleep 3; \
diag_log ["TEST("+str player+": "+msg]; \
titleText [msg,"PLAIN"]

#define STAT1(msg) CONT = false; \
waitUntil{CONT}; \
diag_log ["TEST("+str player+": "+msg]; \
titleText [msg,"PLAIN"]

_err = format["Mission objects: %1", count allMissionObjects ""];
STAT(_err);

STAT("Get array of id's and positions from object index");
_obj_array = [
	"barrack",
	"_tower",
	"runway_end",
	"runway_poj",
	"runway_dirt",
	"runway_main",
	"runway_beton",
	"runwayold",
	"helipad",
	"hbarrier",
//	"cargo",
	"razorwire",
	"mil_wired",
	"miloffices",
	"radar",
	"hangar",
	"mil_wall",
	"bunker",
	"small_shed_f"
] call ALIVE_fnc_getObjectsByType;
_err = "getObjectsByType";
ASSERT_DEFINED("_obj_array",_err);
ASSERT_TRUE(typeName _obj_array == "ARRAY", _err);
ASSERT_TRUE(count _obj_array > 0,_err);
{
	LOG(_x);
        _m = createMarker [str _x, getPosATL _x];
	_m setMarkerShape "Icon";
	_m setMarkerSize [1, 1];
	_m setMarkerType "mil_dot";
	_m setMarkerColor "ColorGreen";
} forEach _obj_array;

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
{
	deleteMarker str _x;
} forEach _clusters;

_err = format["Mission objects: %1", count allMissionObjects ""];
STAT(_err);

nil;
