// ----------------------------------------------------------------------------

#include <script_macros_core.hpp>
SCRIPT(test_cqb_client);

// ----------------------------------------------------------------------------
/*
private ["_err","_obj_array","_center","_clusters"];

LOG("Testing Clusters 2");

// UNIT TESTS (initStrings.sqf - stringJoin)
ASSERT_DEFINED("MSO_fnc_getObjectsByType","");
ASSERT_DEFINED("MSO_fnc_getNearestObjectInCluster","");
ASSERT_DEFINED("MSO_fnc_findClusterCenter","");
ASSERT_DEFINED("MSO_fnc_chooseInitialCenters","");
ASSERT_DEFINED("MSO_fnc_assignPointsToClusters","");
ASSERT_DEFINED("MSO_fnc_findClusters","");

// get array of id's and positions from object index
_obj_array = [
	"vez.p3d",
	"barrack",
	"mil_controltower",
	"mil_house.p3d",
	"lhd_",
	"ss_hangar",
	"runway_end",
	"runway_poj",
	"runway_dirt",
	"runway_main",
	"runway_beton",
	"runwayold",
	"heli_h"
] call MSO_fnc_getObjectsByType;
_err = "getObjectsByType";
ASSERT_DEFINED("_obj_array",_err);
ASSERT_TRUE(typeName _obj_array == "ARRAY", _err);
ASSERT_TRUE(count _obj_array > 0,_err);
{
	[str _x, position _x, "Icon", [1, 1],"TYPE:", "Dot", "COLOR:", "ColorGreen"] call CBA_fnc_createMarker;
} forEach _obj_array;

// Test finding centre of cluster of objects
_center = [_obj_array] call MSO_fnc_findClusterCenter;
_err = "cluster center";
ASSERT_DEFINED("_center",_err);
ASSERT_TRUE(typeName _center == "ARRAY", _err);
ASSERT_TRUE(count _center == 2,_err);
[str _center, _center, "Icon", [1, 1],"TYPE:", "Dot", "COLOR:", "ColorOrange", "TEXT:","Cluster Center"] call CBA_fnc_createMarker;

// Run same exercise using the findClusters function
_clusters = [_obj_array] call MSO_fnc_findClusters;
_err = "finding clusters";
ASSERT_TRUE(typeName _clusters == "ARRAY", _err);
ASSERT_TRUE(count _clusters == ceil(sqrt(count _obj_array / 2)),_err);
{
	[str _x, position _x, "Icon", [1, 1],"TYPE:", "Dot", "COLOR:", "ColorYellow", "TEXT:", format["Cluster Center #%1", _forEachIndex]] call CBA_fnc_createMarker;
} forEach _clusters;
*/
nil;
