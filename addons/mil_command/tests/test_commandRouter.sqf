// ----------------------------------------------------------------------------

#include <\x\alive\addons\fnc_analysis\script_component.hpp>
SCRIPT(test_command);

//execVM "\x\alive\addons\mil_command\tests\test_commandRouter.sqf"

// ----------------------------------------------------------------------------

private ["_result","_err","_logic","_state","_result2","_m","_markers","_worldMarkers"];

LOG("Testing Command Router Object");

ASSERT_DEFINED("ALIVE_fnc_sector","");

#define STAT(msg) sleep 3; \
diag_log ["TEST("+str player+": "+msg]; \
titleText [msg,"PLAIN"]

#define STAT1(msg) CONT = false; \
waitUntil{CONT}; \
diag_log ["TEST("+str player+": "+msg]; \
titleText [msg,"PLAIN"]

#define DEBUGON STAT("Setup debug parameters"); \
_result = [_logic, "debug", true] call ALIVE_fnc_sector; \
_err = "enabled debug"; \
ASSERT_TRUE(typeName _result == "BOOL", _err); \
ASSERT_TRUE(_result, _err);

#define DEBUGOFF STAT("Disable debug"); \
_result = [_logic, "debug", false] call ALIVE_fnc_sector; \
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


player setCaptive true;

// debug info on cursor target
//[] call ALIVE_fnc_cursorTargetInfo;

// CREATE PROFILE HANDLER
STAT("Create Profile Handler");
ALIVE_profileHandler = [nil, "create"] call ALIVE_fnc_profileHandler;
[ALIVE_profileHandler, "init"] call ALIVE_fnc_profileHandler;

// create sector grid
ALIVE_sectorGrid = [nil, "create"] call ALIVE_fnc_sectorGrid;
[ALIVE_sectorGrid, "init"] call ALIVE_fnc_sectorGrid;
[ALIVE_sectorGrid, "createGrid"] call ALIVE_fnc_sectorGrid;

// create sector plotter
ALIVE_sectorPlotter = [nil, "create"] call ALIVE_fnc_plotSectors;
[ALIVE_sectorPlotter, "init"] call ALIVE_fnc_plotSectors;

// import static map analysis to the grid
[ALIVE_sectorGrid] call ALIVE_fnc_gridImportStaticMapAnalysis;

// create command router
ALIVE_commandRouter = [nil, "create"] call ALIVE_fnc_commandRouter;
[ALIVE_commandRouter, "init"] call ALIVE_fnc_commandRouter;
[ALIVE_commandRouter, "debug", true] call ALIVE_fnc_commandRouter;


STAT("Create Entity Profile 1");
_profileEntity1 = [nil, "create"] call ALIVE_fnc_profileEntity;
[_profileEntity1, "init"] call ALIVE_fnc_profileEntity;
[_profileEntity1, "profileID", "group_01"] call ALIVE_fnc_profileEntity;
[_profileEntity1, "unitClasses", ["B_Crew_F","B_Crew_F"]] call ALIVE_fnc_profileEntity;
[_profileEntity1, "position", getPos player] call ALIVE_fnc_profileEntity;
[_profileEntity1, "positions", [getPos player,getPos player,getPos player,getPos player]] call ALIVE_fnc_profileEntity;
[_profileEntity1, "damages", [0,0]] call ALIVE_fnc_profileEntity;
[_profileEntity1, "ranks", ["CAPTAIN","LIEUTENANT"]] call ALIVE_fnc_profileEntity;
[_profileEntity1, "side", "WEST"] call ALIVE_fnc_profileEntity;
[_profileEntity1, "faction", "BLU_F"] call ALIVE_fnc_profileEntity;

STAT("Register Profiles");
[ALIVE_profileHandler, "registerProfile", _profileEntity1] call ALIVE_fnc_profileHandler;


_profile = [ALIVE_profileHandler, "getProfile", "group_01"] call ALIVE_fnc_profileHandler;

STAT("Add Active Command");
//[_profile, "addActiveCommand", ["testCommand","fsm",["param1","param2"]]] call ALIVE_fnc_profileEntity;
//[_profile, "addActiveCommand", ["ALIVE_fnc_testCommand","spawn",["param1","param2"]]] call ALIVE_fnc_profileEntity;
[_profile, "addActiveCommand", ["ALIVE_fnc_testManagedCommand","managed",["param1","param2"]]] call ALIVE_fnc_profileEntity;

STAT("Spawn");
[_profile, "spawn"] call ALIVE_fnc_profileEntity;

sleep 30;

STAT("De-Spawn");
[_profile, "despawn"] call ALIVE_fnc_profileEntity;

sleep 5;

STAT("Spawn");
[_profile, "spawn"] call ALIVE_fnc_profileEntity;

sleep 5;

STAT("Set Active Command");
[_profile, "setActiveCommand", ["ALIVE_fnc_testCommand","spawn",["param1","param2"]]] call ALIVE_fnc_profileEntity;

sleep 5;

STAT("De-Spawn");
[_profile, "despawn"] call ALIVE_fnc_profileEntity;

sleep 5;

STAT("Spawn");
[_profile, "spawn"] call ALIVE_fnc_profileEntity;

nil;