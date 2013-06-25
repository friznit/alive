// ----------------------------------------------------------------------------

#include <\x\alive\addons\mil_strategic\script_component.hpp>
SCRIPT(test_findHQ);

// ----------------------------------------------------------------------------

#define STAT(msg) sleep 0.5; \
diag_log ["TEST("+str player+": "+msg]; \
titleText [msg,"PLAIN"]

#define STAT1(msg) CONT = false; \
waitUntil{CONT}; \
diag_log ["TEST("+str player+": "+msg]; \
titleText [msg,"PLAIN"]

#define DEBUGON STAT("Setup debug parameters"); \
_result = [_logic, "debug", true] call ALIVE_fnc_SEP; \
_err = "enabled debug"; \
ASSERT_TRUE(typeName _result == "BOOL", _err); \
ASSERT_TRUE(_result, _err);

#define DEBUGOFF STAT("Disable debug"); \
_result = [_logic, "debug", false] call ALIVE_fnc_SEP; \
_err = "disable debug"; \
ASSERT_TRUE(typeName _result == "BOOL", _err); \
ASSERT_TRUE(!_result, _err);

//========================================

private ["_amo","_pos","_types","_result","_err","_m","_markers"];

LOG("Testing Find HQ");

ASSERT_DEFINED("ALIVE_fnc_findHQ","");
ASSERT_DEFINED("ALIVE_fnc_getObjectsByType","");

_amo = allMissionObjects "";
_pos = position player;
_markers = [];

_types = [
        "barrack",
        "cargo_hq_",
        "miloffices"
];

STAT("Get object for position");
_result = [_types call ALIVE_fnc_getObjectsByType, _pos] call ALIVE_fnc_findHQ;
_err = "ALIVE_fnc_findHQ";
ASSERT_DEFINED("_result",_err);
ASSERT_TRUE(typeName _result == "OBJECT", typeName _result);

_m = createMarkerLocal [str _result, getPosATL _result];
_m setMarkerShapeLocal "Icon";
_m setMarkerSizeLocal [1, 1];
_m setMarkerTypeLocal "mil_dot";

player setPos ((position _result)findEmptyPosition[1 , 30 , typeOf player]);

sleep 10;

deleteMarkerLocal _m;

diag_log (allMissionObjects "") - _amo;

nil;
