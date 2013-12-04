// ----------------------------------------------------------------------------

#include <\x\alive\addons\sys_debug\script_component.hpp>
SCRIPT(test_debug);

// ----------------------------------------------------------------------------

private ["_result","_err","_logic","_state","_profileWaypoint"];

LOG("Testing Agent Profile Object");

ASSERT_DEFINED("ALIVE_fnc_agentProfile","");

#define STAT(msg) sleep 3; \
diag_log ["TEST("+str player+": "+msg]; \
titleText [msg,"PLAIN"]

#define STAT1(msg) CONT = false; \
waitUntil{CONT}; \
diag_log ["TEST("+str player+": "+msg]; \
titleText [msg,"PLAIN"]

#define DEBUGON STAT("Setup debug parameters"); \
_result = [_logic, "debug", true] call ALIVE_fnc_agentProfile; \
_err = "enabled debug"; \
ASSERT_TRUE(typeName _result == "BOOL", _err); \
ASSERT_TRUE(_result, _err);

#define DEBUGOFF STAT("Disable debug"); \
_result = [_logic, "debug", false] call ALIVE_fnc_agentProfile; \
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

STAT("Dump");
[getPos player] call ALIVE_fnc_dump;
["Position: %1",getPos player] call ALIVE_fnc_dump;

STAT("Timer");
[true] call ALIVE_fnc_timer;
sleep 1;
[] call ALIVE_fnc_timer;

STAT("Inspect classes to RPT");
[] call ALIVE_fnc_inspectClasses;

STAT("Inspect player");
[player] call ALIVE_fnc_inspectObject;

STAT("Enable cursor target inspection. Hold cursor over target for 3 seconds to inspect to the RPT");
[] call ALIVE_fnc_cursorTargetInfo;

nil;