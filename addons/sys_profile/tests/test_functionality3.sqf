// ----------------------------------------------------------------------------

#include <\x\alive\addons\sys_profile\script_component.hpp>
SCRIPT(test_functionality3);

//execVM "\x\alive\addons\sys_profile\tests\test_functionality3.sqf"

// ----------------------------------------------------------------------------

private ["_result","_err","_logic","_state","_result2","_unitProfile","_groupProfile","_profileVehicle"];

LOG("Testing Profile Handler Object");

ASSERT_DEFINED("ALIVE_fnc_profileHandler","");

#define STAT(msg) sleep 3; \
diag_log ["TEST("+str player+": "+msg]; \
titleText [msg,"PLAIN"]

#define STAT1(msg) CONT = false; \
waitUntil{CONT}; \
diag_log ["TEST("+str player+": "+msg]; \
titleText [msg,"PLAIN"]

#define DEBUGON STAT("Setup debug parameters"); \
_result = [ALIVE_profileHandler, "debug", true] call ALIVE_fnc_profileHandler; \
_err = "enabled debug"; \
ASSERT_TRUE(typeName _result == "BOOL", _err); \
ASSERT_TRUE(_result, _err);

#define DEBUGOFF STAT("Disable debug"); \
_result = [ALIVE_profileHandler, "debug", false] call ALIVE_fnc_profileHandler; \
_err = "disable debug"; \
ASSERT_TRUE(typeName _result == "BOOL", _err); \
ASSERT_TRUE(!_result, _err);

#define TIMERSTART \
_timeStart = diag_tickTime; \
diag_log "Timer Start";

#define TIMEREND \
_timeEnd = diag_tickTime - _timeStart; \
diag_log format["Timer End %1",_timeEnd];

//========================================


[] call ALIVE_fnc_cursorTargetInfo;

/*
// CREATE PROFILE HANDLER
STAT("Create Profile Handler");
ALIVE_profileHandler = [nil, "create"] call ALIVE_fnc_profileHandler;
[ALIVE_profileHandler, "init"] call ALIVE_fnc_profileHandler;


STAT("Create profiles from editor placed units");
[] call ALIVE_fnc_createProfilesFromUnits;


STAT("Get profile handler state");
_state = [ALIVE_profileHandler, "state"] call ALIVE_fnc_profileHandler;
_state call ALIVE_fnc_inspectHash;

DEBUGON;


STAT("Run waypoint simulator");
[] spawn {[] call ALIVE_fnc_simulateProfileMovement};


STAT("Run profile spawner");
[] spawn {[100] call ALIVE_fnc_profileSpawner};
*/