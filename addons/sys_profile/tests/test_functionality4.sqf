// ----------------------------------------------------------------------------

#include <\x\alive\addons\sys_profile\script_component.hpp>
SCRIPT(test_functionality2);

//execVM "\x\alive\addons\sys_profile\tests\test_functionality4.sqf"

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


//[] call ALIVE_fnc_vehicleGenerateEmptyPositionData;

player setCaptive true;

// debug info on cursor target
//[] call ALIVE_fnc_cursorTargetInfo;

// CREATE PROFILE HANDLER
STAT("Create Profile Handler");
ALIVE_profileHandler = [nil, "create"] call ALIVE_fnc_profileHandler;
[ALIVE_profileHandler, "init"] call ALIVE_fnc_profileHandler;


STAT("Create Entity Profile");
_profileEntity = [nil, "create"] call ALIVE_fnc_profileEntity;
[_profileEntity, "init"] call ALIVE_fnc_profileEntity;
[_profileEntity, "profileID", "group_01"] call ALIVE_fnc_profileEntity;
[_profileEntity, "unitClasses", ["B_Soldier_F","B_Soldier_F","B_Soldier_F","B_Soldier_F"]] call ALIVE_fnc_profileEntity;
[_profileEntity, "position", getPos player] call ALIVE_fnc_profileEntity;
[_profileEntity, "positions", [getPos player,getPos player,getPos player,getPos player]] call ALIVE_fnc_profileEntity;
[_profileEntity, "damages", [0,0,0,0]] call ALIVE_fnc_profileEntity;
[_profileEntity, "ranks", ["CAPTAIN","LIEUTENANT","PRIVATE","PRIVATE"]] call ALIVE_fnc_profileEntity;
[_profileEntity, "side", "WEST"] call ALIVE_fnc_profileEntity;

/*
STAT("Create Vehicle Profile");
_profileVehicle = [nil, "create"] call ALIVE_fnc_profileVehicle;
[_profileVehicle, "init"] call ALIVE_fnc_profileVehicle;
[_profileVehicle, "profileID", "vehicle_01"] call ALIVE_fnc_profileVehicle;
[_profileVehicle, "vehicleClass", "B_Heli_Transport_01_F"] call ALIVE_fnc_profileVehicle;
[_profileVehicle, "position", [getPos player, 20, 180] call BIS_fnc_relPos] call ALIVE_fnc_profileVehicle;
[_profileVehicle, "direction", 180] call ALIVE_fnc_profileVehicle;
[_profileVehicle, "damage", 0] call ALIVE_fnc_profileVehicle;
[_profileVehicle, "fuel", 1] call ALIVE_fnc_profileVehicle;
[_profileVehicle, "side", "WEST"] call ALIVE_fnc_profileVehicle;
*/

STAT("Register Profile");
[ALIVE_profileHandler, "registerProfile", _profileEntity] call ALIVE_fnc_profileHandler;
//[ALIVE_profileHandler, "registerProfile", _profileVehicle] call ALIVE_fnc_profileHandler;


DEBUGON

/*
STAT("Assign group 1 to vehicle 1");
[_profileEntity,_profileVehicle] call ALIVE_fnc_createProfileVehicleAssignment;
*/

//DEBUGON


STAT("Spawn the unit via the profile");
[_profileEntity, "spawn"] call ALIVE_fnc_profileEntity;