// ----------------------------------------------------------------------------

#include <\x\alive\addons\sys_profile\script_component.hpp>
SCRIPT(test_functionality6);

//execVM "\x\alive\addons\sys_profile\tests\test_functionality6.sqf"

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


player setCaptive true;

// debug info on cursor target
//[] call ALIVE_fnc_cursorTargetInfo;

// CREATE PROFILE HANDLER
STAT("Create Profile Handler");
ALIVE_profileHandler = [nil, "create"] call ALIVE_fnc_profileHandler;
[ALIVE_profileHandler, "init"] call ALIVE_fnc_profileHandler;


STAT("Get random group names");
_group1 = [] call ALIVE_fnc_configGetRandomGroup;
_group2 = ["Air"] call ALIVE_fnc_configGetRandomGroup;
_group3 = ["Infantry","IND_F"] call ALIVE_fnc_configGetRandomGroup;
_group4 = ["Mechanized","BLU_F"] call ALIVE_fnc_configGetRandomGroup;


STAT("Create profiles for a config group");
_result = [_group1, getPosATL player] call ALIVE_fnc_createProfilesFromGroupConfig;

STAT("Spawn the unit via the profile");
_profileEntity = _result select 0;
[_profileEntity, "spawn"] call ALIVE_fnc_profileEntity;


sleep 10;
[_profileEntity, "despawn"] call ALIVE_fnc_profileEntity;


STAT("Create profiles for a config group");
_result = [_group2, getPosATL player] call ALIVE_fnc_createProfilesFromGroupConfig;

STAT("Spawn the unit via the profile");
_profileEntity = _result select 0;
[_profileEntity, "spawn"] call ALIVE_fnc_profileEntity;


sleep 10;
[_profileEntity, "despawn"] call ALIVE_fnc_profileEntity;


STAT("Create profiles for a config group");
_result = [_group3, getPosATL player] call ALIVE_fnc_createProfilesFromGroupConfig;

STAT("Spawn the unit via the profile");
_profileEntity = _result select 0;
[_profileEntity, "spawn"] call ALIVE_fnc_profileEntity;

sleep 10;
[_profileEntity, "despawn"] call ALIVE_fnc_profileEntity;


STAT("Create profiles for a config group");
_result = ["OIA_MotInf_Transport", getPosATL player] call ALIVE_fnc_createProfilesFromGroupConfig;

STAT("Spawn the unit via the profile");
_profileEntity = _result select 0;
[_profileEntity, "spawn"] call ALIVE_fnc_profileEntity;


sleep 10;
[_profileEntity, "despawn"] call ALIVE_fnc_profileEntity;


STAT("Create profiles for a config group");
_result = [_group4, getPosATL player] call ALIVE_fnc_createProfilesFromGroupConfig;

STAT("Spawn the unit via the profile");
_profileEntity = _result select 0;
[_profileEntity, "spawn"] call ALIVE_fnc_profileEntity;


sleep 10;
[_profileEntity, "despawn"] call ALIVE_fnc_profileEntity;


DEBUGON