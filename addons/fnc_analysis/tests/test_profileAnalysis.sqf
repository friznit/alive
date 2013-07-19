// ----------------------------------------------------------------------------

#include <\x\alive\addons\fnc_analysis\script_component.hpp>
SCRIPT(test_profileAnalysis);

//execVM "\x\alive\addons\fnc_analysis\tests\test_profileAnalysis.sqf"

// ----------------------------------------------------------------------------

private ["_result","_err","_logic","_timeStart","_timeEnd","_bounds","_grid","_plotter","_sector","_allSectors","_landSectors"];

LOG("Testing Unit Analysis Object");

ASSERT_DEFINED("ALIVE_fnc_sectorGrid","");
ASSERT_DEFINED("ALIVE_fnc_sectorAnalysisProfile","");

#define STAT(msg) sleep 3; \
diag_log ["TEST("+str player+": "+msg]; \
titleText [msg,"PLAIN"]

#define STAT1(msg) CONT = false; \
waitUntil{CONT}; \
diag_log ["TEST("+str player+": "+msg]; \
titleText [msg,"PLAIN"]

#define PH_DEBUGON STAT("Setup debug parameters"); \
_result = [ALIVE_profileHandler, "debug", true] call ALIVE_fnc_profileHandler; \
_err = "enabled debug"; \
ASSERT_TRUE(typeName _result == "BOOL", _err); \
ASSERT_TRUE(_result, _err);

#define PH_DEBUGOFF STAT("Disable debug"); \
_result = [ALIVE_profileHandler, "debug", true] call ALIVE_fnc_profileHandler; \
_err = "disable debug"; \
ASSERT_TRUE(typeName _result == "BOOL", _err); \
ASSERT_TRUE(!_result, _err);

#define G_DEBUGON STAT("Setup debug parameters"); \
_result = [_grid, "debug", true] call ALIVE_fnc_sectorGrid; \
_err = "enabled debug"; \
ASSERT_TRUE(typeName _result == "BOOL", _err); \
ASSERT_TRUE(_result, _err);

#define G_DEBUGOFF STAT("Disable debug"); \
_result = [_grid, "debug", false] call ALIVE_fnc_sectorGrid; \
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


STAT("Create Profile Handler");
ALIVE_profileHandler = [nil, "create"] call ALIVE_fnc_profileHandler;
[ALIVE_profileHandler, "init"] call ALIVE_fnc_profileHandler;


STAT("Create profiles from editor placed units");
[true] call ALIVE_fnc_createProfilesFromUnits;


PH_DEBUGON


STAT("Create SectorGrid instance");
TIMERSTART
_grid = [nil, "create"] call ALIVE_fnc_sectorGrid;
[_grid, "init"] call ALIVE_fnc_sectorGrid;
TIMEREND


STAT("Create Grid");
TIMERSTART
_result = [_grid, "createGrid"] call ALIVE_fnc_sectorGrid;
TIMEREND


_allSectors = [_grid, "sectors"] call ALIVE_fnc_sectorGrid;
diag_log format["Sectors created: %1",count _allSectors];


STAT("Create Sector Plotter");
TIMERSTART
_plotter = [nil, "create"] call ALIVE_fnc_plotSectors;
TIMEREND


STAT("Run Profile analysis");
TIMERSTART
_result = [_grid] call ALIVE_fnc_sectorAnalysisProfiles;
TIMEREND


STAT("Plot profiles on sectors");
TIMERSTART
[_plotter, "plot", [_allSectors, "profilesBySide"]] call ALIVE_fnc_plotSectors;
TIMEREND


STAT("Sleeping before destroy");
sleep 10;

nil;