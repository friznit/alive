// ----------------------------------------------------------------------------

#include <\x\alive\addons\fnc_strategic\script_component.hpp>
SCRIPT(test_clusters3);

// ----------------------------------------------------------------------------

private ["_err","_obj_array","_center","_clusters_mil","_clusters_civ","_m","_amo","_result"];


LOG("Testing Clusters 3");

ASSERT_DEFINED("ALIVE_fnc_getObjectsByType","");
ASSERT_DEFINED("ALIVE_fnc_findClusters","");
ASSERT_DEFINED("ALIVE_fnc_consolidateClusters","");

#define STAT(msg) sleep 3; \
diag_log ["TEST("+str player+": "+msg]; \
titleText [msg,"PLAIN"]

#define STAT1(msg) CONT = false; \
waitUntil{CONT}; \
diag_log ["TEST("+str player+": "+msg]; \
titleText [msg,"PLAIN"]

_amo = allMissionObjects "";

STAT("Get array of id's and positions from object index");
_obj_array = [
	"barrack",
	"bunker",
	"cargo_house_",
	"cargo_hq_",
	"cargo_patrol_",
	"hbarrier",
	"mil_wall",
	"mil_wired",
	"miloffices",
	"tenthangar",
	"razorwire"
] call ALIVE_fnc_getObjectsByType;
_err = "getObjectsByType";
ASSERT_DEFINED("_obj_array",_err);
ASSERT_TRUE(typeName _obj_array == "ARRAY", _err);
ASSERT_TRUE(count _obj_array > 0,_err);

STAT("findClusters function (Military)");
_clusters_mil = [_obj_array] call ALIVE_fnc_findClusters;
_err = "finding clusters";
ASSERT_TRUE(typeName _clusters_mil == "ARRAY", _err);
{
	[_x, "debug", true] call ALIVE_fnc_cluster;
} forEach _clusters_mil;

STAT("ConsolidateClusters function");
_result = [_clusters_mil] call ALIVE_fnc_consolidateClusters;
_clusters_mil = _result select 0;
_err = "consolidating clusters";
ASSERT_TRUE(typeName _clusters_mil == "ARRAY", _err);

STAT("ConsolidateClusters completed");

_obj_array = [
	"airport_tower",
	"communication_f",
	"dp_",
	"fuel",
	"helipad",
	"lighthouse_",
	"pier_f",
	"radar",
 	"runway_beton",
 	"runway_end",
 	"runway_main",
 	"runwayold",
	"shed_big_",
	"shed_small_",
	"spp_",
	"ttowerbig_",
	"valve"
] call ALIVE_fnc_getObjectsByType;

STAT("findClusters function (Civilian)");
_clusters_civ = [_obj_array] call ALIVE_fnc_findClusters;
_err = "finding clusters";
ASSERT_TRUE(typeName _clusters_civ == "ARRAY", _err);
{
	[_x, "debugColor", "ColorGreen"] call ALIVE_fnc_hashSet;
	[_x, "debug", true] call ALIVE_fnc_cluster;
} forEach _clusters_civ;

STAT("ConsolidateClusters function");
_result = [_clusters_civ] call ALIVE_fnc_consolidateClusters;
_clusters_civ = _result select 0;
_err = "consolidating clusters";
ASSERT_TRUE(typeName _clusters_civ == "ARRAY", _err);

STAT("ConsolidateClusters completed");

sleep 15;

STAT("ConsolidateClusters function");
_result = [_clusters_mil,_clusters_civ] call ALIVE_fnc_consolidateClusters;
_clusters_mil = _result select 0;
_clusters_civ = _result select 1;
_err = "consolidating clusters";
ASSERT_TRUE(typeName _clusters_mil == "ARRAY", _err);
ASSERT_TRUE(typeName _clusters_civ == "ARRAY", _err);

STAT("ConsolidateClusters completed");

sleep 15;

{
	[_x, "destroy"] call ALIVE_fnc_cluster;
} forEach _clusters_civ;
{
	[_x, "destroy"] call ALIVE_fnc_cluster;
} forEach _clusters_mil;

diag_log (allMissionObjects "") - _amo;

nil;
