// ----------------------------------------------------------------------------

#include <\x\alive\addons\sys_event_log\script_component.hpp>
SCRIPT(test_event_log);

//execVM "\x\alive\addons\sys_event_log\tests\test_event_log.sqf"

// ----------------------------------------------------------------------------

private ["_result","_err","_logic","_state"];

LOG("Testing Event Log Object");

ASSERT_DEFINED("ALIVE_fnc_eventLog","");

#define STAT(msg) sleep 3; \
diag_log ["TEST("+str player+": "+msg]; \
titleText [msg,"PLAIN"]

#define STAT1(msg) CONT = false; \
waitUntil{CONT}; \
diag_log ["TEST("+str player+": "+msg]; \
titleText [msg,"PLAIN"]

#define DEBUGON STAT("Setup debug parameters"); \
_result = [ALIVE_eventLog, "debug", true] call ALIVE_fnc_eventLog; \
_err = "enabled debug"; \
ASSERT_TRUE(typeName _result == "BOOL", _err); \
ASSERT_TRUE(_result, _err);

#define DEBUGOFF STAT("Disable debug"); \
_result = [ALIVE_eventLog, "debug", false] call ALIVE_fnc_eventLog; \
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


// CREATE EVENT LOG
STAT("Create Event Log");
ALIVE_eventLog = [nil, "create"] call ALIVE_fnc_eventLog;
[ALIVE_eventLog, "debug", true] call ALIVE_fnc_eventLog;
[ALIVE_eventLog, "init"] call ALIVE_fnc_eventLog;



STAT("Add listener");
_listenerID = [ALIVE_eventLog, "addListener",[['ONE','TWO'], 'ALL']] call ALIVE_fnc_eventLog;

STAT("Get listeners");
_listeners = [ALIVE_eventLog, "getListeners"] call ALIVE_fnc_eventLog;
_listeners call ALIVE_fnc_inspectHash;

STAT("Get Filtered listeners");
_filteredListeners = [ALIVE_eventLog, "getListenersByFilter",'ALL'] call ALIVE_fnc_eventLog;
_filteredListeners call ALIVE_fnc_inspectHash;

STAT("Remove listener");
[ALIVE_eventLog, "removeListener",_listenerID] call ALIVE_fnc_eventLog;

_listeners = [ALIVE_eventLog, "getListeners"] call ALIVE_fnc_eventLog;
_listeners call ALIVE_fnc_inspectHash;

_filteredListeners = [ALIVE_eventLog, "getListenersByFilter",'ALL'] call ALIVE_fnc_eventLog;
_filteredListeners call ALIVE_fnc_inspectHash;


STAT("Add listener");
_listenerID = [ALIVE_eventLog, "addListener",[['THREE','FOUR'], 'TEST']] call ALIVE_fnc_eventLog;

STAT("Get listeners");
_listeners = [ALIVE_eventLog, "getListeners"] call ALIVE_fnc_eventLog;
_listeners call ALIVE_fnc_inspectHash;

STAT("Get Filtered listeners");
_filteredListeners = [ALIVE_eventLog, "getListenersByFilter",'ALL'] call ALIVE_fnc_eventLog;
_filteredListeners call ALIVE_fnc_inspectHash;

STAT("Clear listeners");
[ALIVE_eventLog, "clearListeners"] call ALIVE_fnc_eventLog;

_listeners = [ALIVE_eventLog, "getListeners"] call ALIVE_fnc_eventLog;
_listeners call ALIVE_fnc_inspectHash;

_filteredListeners = [ALIVE_eventLog, "getListenersByFilter",'ALL'] call ALIVE_fnc_eventLog;
_filteredListeners call ALIVE_fnc_inspectHash;



STAT("Add event");
_event = ['TEST', ['DOGS','CATS']] call ALIVE_fnc_event;
_eventID = [ALIVE_eventLog, "addEvent",_event] call ALIVE_fnc_eventLog;

STAT("Get events");
_events = [ALIVE_eventLog, "getEvents"] call ALIVE_fnc_eventLog;
_events call ALIVE_fnc_inspectHash;

STAT("Get events by type");
_eventTypes = [ALIVE_eventLog, "getEventsByType",'TEST'] call ALIVE_fnc_eventLog;
_eventTypes call ALIVE_fnc_inspectHash;

STAT("Remove event");
[ALIVE_eventLog, "removeEvent", _eventID] call ALIVE_fnc_eventLog;

_events = [ALIVE_eventLog, "getEvents"] call ALIVE_fnc_eventLog;
_events call ALIVE_fnc_inspectHash;

_eventTypes = [ALIVE_eventLog, "getEventsByType",'ALL'] call ALIVE_fnc_eventLog;
_eventTypes call ALIVE_fnc_inspectHash;



STAT("Add event");
_event = ['TEST', ['DOGS','CATS']] call ALIVE_fnc_event;
_eventID = [ALIVE_eventLog, "addEvent",_event] call ALIVE_fnc_eventLog;

STAT("Get events");
_events = [ALIVE_eventLog, "getEvents"] call ALIVE_fnc_eventLog;
_events call ALIVE_fnc_inspectHash;

STAT("Get events by type");
_eventTypes = [ALIVE_eventLog, "getEventsByType",'TEST'] call ALIVE_fnc_eventLog;
_eventTypes call ALIVE_fnc_inspectHash;

STAT("Clear events");
[ALIVE_eventLog, "clearEvents"] call ALIVE_fnc_eventLog;

_events = [ALIVE_eventLog, "getEvents"] call ALIVE_fnc_eventLog;
_events call ALIVE_fnc_inspectHash;

_eventTypes = [ALIVE_eventLog, "getEventsByType",'ALL'] call ALIVE_fnc_eventLog;
_eventTypes call ALIVE_fnc_inspectHash;



nil;