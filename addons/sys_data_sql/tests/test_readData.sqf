// ----------------------------------------------------------------------------

#include <\x\alive\addons\sys_data_sql\script_component.hpp>
SCRIPT(test_readData);

// ----------------------------------------------------------------------------

private ["_result","_err","_logic","_timeStart","_timeEnd","_bounds","_grid","_plotter","_sector","_allSectors","_landSectors"];

LOG("Testing SQL Read Data");

ASSERT_DEFINED("ALIVE_fnc_data","");

#define STAT(msg) sleep 3; \
diag_log ["TEST("+str player+": "+msg]; \
titleText [msg,"PLAIN"]

#define STAT1(msg) CONT = false; \
waitUntil{CONT}; \
diag_log ["TEST("+str player+": "+msg]; \
titleText [msg,"PLAIN"]

#define DEBUGON STAT("Setup debug parameters"); \
_result = [_logic, "debug", true] call ALIVE_fnc_sectorGrid; \
_err = "enabled debug"; \
ASSERT_TRUE(typeName _result == "BOOL", _err); \
ASSERT_TRUE(_result, _err);

#define DEBUGOFF STAT("Disable debug"); \
_result = [_logic, "debug", false] call ALIVE_fnc_sectorGrid; \
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


STAT("Run Terrain Analysis");
TIMERSTART
_result = [_allSectors] call ALIVE_fnc_sectorAnalysisTerrain;
TIMEREND


STAT("Run Elevation Analysis");
TIMERSTART
_result = [_allSectors] call ALIVE_fnc_sectorAnalysisElevation;
TIMEREND


STAT("Run Unit Analysis");
TIMERSTART
_result = [_allSectors] call ALIVE_fnc_sectorAnalysisUnits;
TIMEREND


STAT("Output sector data");
{
	_sector = _x;
	_sectorData = [_sector, "data"] call ALIVE_fnc_sector;
	_id = [_sector, "id"] call ALIVE_fnc_sector;
	diag_log format["S: %1 - %2",_id, _sectorData];
} forEach _allSectors;


STAT("Sleeping before destroy");
sleep 10;


STAT("Destroy grid instance");
[_grid, "destroy"] call ALIVE_fnc_sectorGrid;

nil;