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
/*
	"cargo",
	"_tower",
	"runway_end",
	"runway_poj",
	"runway_dirt",
	"runway_main",
	"runway_beton",
	"runwayold",
	"helipad",
	"radar",
	"hangar",
	"shed_small_f"
*/
/*
	"dp_transformer_F",
	"HighVoltageTower",
	"PowerCable",
	"PowerPole",
	"PowerWire",
	"PowLines_Transformer_F",
	"spp_transformer_F"
*/
_obj_array = [
	"hbarrier",
	"razorwire",
	"mil_wired",
	"mil_wall",
	"barrack",
	"miloffices",
	"bunker"
] call ALIVE_fnc_getObjectsByType;
_err = "getObjectsByType";
ASSERT_DEFINED("_obj_array",_err);
ASSERT_TRUE(typeName _obj_array == "ARRAY", _err);
ASSERT_TRUE(count _obj_array > 0,_err);
/*
{
	LOG(_x);
        _m = createMarker [str _x, getPosATL _x];
	_m setMarkerShape "Icon";
	_m setMarkerSize [1, 1];
	_m setMarkerType "mil_dot";
	_m setMarkerColor "ColorGreen";
} forEach _obj_array;
*/

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
	"dp_transformer_F",
	"spp_transformer_F",
//	"cargo",
//	"shed_small_f"
	"_tower",
	"runway_end",
	"runway_poj",
	"runway_dirt",
	"runway_main",
	"runway_beton",
	"runwayold",
	"helipad",
	"radar",
	"hangar"
] call ALIVE_fnc_getObjectsByType;

STAT("findClusters function (Civilian)");
_clusters_civ = [_obj_array] call ALIVE_fnc_findClusters;
_err = "finding clusters";
ASSERT_TRUE(typeName _clusters_civ == "ARRAY", _err);
{
	_x setVariable ["debugColor", "ColorGreen"];
	[_x, "debug", true] call ALIVE_fnc_cluster;
} forEach _clusters_civ;

sleep 15;

STAT("ConsolidateClusters function");
_result = [_clusters_mil,_clusters_civ] call ALIVE_fnc_consolidateClusters;
_clusters_mil = _result select 0;
_clusters_civ = _result select 1;
_err = "consolidating clusters";
ASSERT_TRUE(typeName _clusters_mil == "ARRAY", _err);
ASSERT_TRUE(typeName _clusters_civ == "ARRAY", _err);

STAT("ConsolidateClusters completed");
/*
sleep 15;

{
	[_x, "destroy"] call ALIVE_fnc_cluster;
} forEach _clusters_civ;
{
	[_x, "destroy"] call ALIVE_fnc_cluster;
} forEach _clusters_mil;
*/
diag_log (allMissionObjects "") - _amo;

nil;
