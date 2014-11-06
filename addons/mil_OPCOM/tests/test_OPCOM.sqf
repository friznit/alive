// ----------------------------------------------------------------------------
#include <\x\alive\addons\mil_opcom\script_component.hpp>
SCRIPT(test_OPCOM);
// ----------------------------------------------------------------------------

if !(isnil QGVAR(TEST_OPCOM)) exitwith {};

GVAR(TEST_OPCOM) = true; 

#define MAINCLASS ALiVE_fnc_OPCOM

// ----------------------------------------------------------------------------

private ["_result","_err","_logic","_state","_result2"];

LOG("Testing OPCOM");

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

LOG("Testing Create Object");

TIMERSTART

//Profile System
private ["_logic"];
_logic = (createGroup sideLogic) createUnit ["ALiVE_sys_profile", [0,0], [], 0, "NONE"];
_logic setVariable ["debug","true"];
_logic setVariable ["spawnRadius","1500"];
waituntil {!isnil "ALIVE_profileSystemInit" && {ALIVE_profileSystemInit}};

//Military Placement
private ["_logic"];
_logic = (createGroup sideLogic) createUnit ["ALiVE_mil_placement", [2000,2000], [], 0, "NONE"];
_logic setVariable ["faction","BLU_F"];
_logic setVariable ["debug","true"];
_MP = _logic;
//[_logic] spawn ALiVE_fnc_MPInit;
waituntil {_logic getVariable ["startupComplete", false]};

STAT("Creating class");
private ["_logic"];
_logic = [nil,"create"] call MAINCLASS;
_logic setvariable ["faction1","BLU_F"];
_logic setvariable ["debug","true"];
_logic synchronizeObjectsAdd [_MP];
_err = "Creation of class failed";
ASSERT_TRUE(typeName _logic == "OBJECT", _err);

sleep 10;

STAT("Destroying class");
_result = [_logic, "destroy"] call MAINCLASS;
_err = "Destruction of class failed";
ASSERT_TRUE(isnil QUOTE(ADDON), _err);

TIMEREND

GVAR(TEST_OPCOM) = nil;