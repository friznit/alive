// ----------------------------------------------------------------------------

#include <\x\alive\addons\mil_opcom\script_component.hpp>
SCRIPT(test_loadOPCOMobjectives);

//execVM "\x\alive\addons\mil_opcom\tests\test_loadOPCOMobjectives.sqf"

// ----------------------------------------------------------------------------

private ["_result","_err","_logic","_state","_result2"];

LOG("Testing Load OPCOM objectives");

#define STAT(msg) sleep 3; \
diag_log ["TEST("+str player+": "+msg]; \
titleText [msg,"PLAIN"]

#define STAT1(msg) CONT = false; \
waitUntil{CONT}; \
diag_log ["TEST("+str player+": "+msg]; \
titleText [msg,"PLAIN"]

#define TIMERSTART \
_timeStart = diag_tickTime; \
diag_log "Timer Start";

#define TIMEREND \
_timeEnd = diag_tickTime - _timeStart; \
diag_log format["Timer End %1",_timeEnd];

//========================================

private ["_resultset"];

_resultset = [];
{
	_resultset set [count _resultset,[([_x,"loadData"] call ALIVE_fnc_OPCOM)]];
} foreach OPCOM_INSTANCES;

{["ALiVE OPCOM LOAD DATA RESULT: %1",str(_x)] call ALiVE_fnc_DumpMPH} foreach _resultset;