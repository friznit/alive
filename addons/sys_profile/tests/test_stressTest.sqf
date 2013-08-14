// ----------------------------------------------------------------------------

#include <\x\alive\addons\sys_profile\script_component.hpp>
SCRIPT(test_getNearProfiles);

//execVM "\x\alive\addons\sys_profile\tests\test_stressTest.sqf"

// ----------------------------------------------------------------------------

private ["_result","_err","_logic","_state","_result2","_unitProfile","_groupProfile","_profileVehicle","_markers"];

LOG("Testing Get Near Profiles Function");

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


player setCaptive true;


// Player position to sector and sector data -----------------------------------------------

_sectors = [ALIVE_sectorGrid, "sectorsInRadius", [getPos player, 500]] call ALIVE_fnc_sectorGrid;


TIMERSTART
STAT("Merging Sector Data");
_mergedData = _sectors call ALIVE_fnc_sectorDataMerge;
TIMEREND


TIMERSTART
STAT("Get Flat Empty Positions");
_flatEmptyPositions = [_mergedData, "flatEmpty"] call ALIVE_fnc_hashGet;
TIMEREND


TIMERSTART
STAT("Generating random groups for flat empty positions");
private ["_testFactions","_testTypes","_type","_faction","_group","_positions","_position","_testProfle","_sortedProfilePositions","_nearestProfilePosition","_m"];

_testFactions  = ["BLU_F"];
_testTypes = ["Infantry","Motorized","Mechanized","Air"];

{
	_position = _x;
	_type = _testTypes call BIS_fnc_selectRandom; 
	_faction = _testFactions call BIS_fnc_selectRandom;
	_group = [_type,_faction] call ALIVE_fnc_configGetRandomGroup;
	if!(_group == "FALSE") then {
		[_group, _position] call ALIVE_fnc_createProfilesFromGroupConfig;
	};
} forEach _flatEmptyPositions;

TIMEREND

[] spawn {[true] call ALIVE_fnc_simulateProfileMovement};
//[] spawn {[1000,true] call ALIVE_fnc_profileSpawner};

