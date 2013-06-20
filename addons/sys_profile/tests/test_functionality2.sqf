// ----------------------------------------------------------------------------

#include <\x\alive\addons\sys_profile\script_component.hpp>
SCRIPT(test_functionality);

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
_result = [_logic, "debug", true] call ALIVE_fnc_profileVehicle; \
_err = "enabled debug"; \
ASSERT_TRUE(typeName _result == "BOOL", _err); \
ASSERT_TRUE(_result, _err);

#define DEBUGOFF STAT("Disable debug"); \
_result = [_logic, "debug", false] call ALIVE_fnc_profileVehicle; \
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

// debug info on cursor target
[] call ALIVE_fnc_cursorTargetInfo;

// CREATE PROFILE HANDLER
STAT("Create Profile Handler");
ALIVE_profileHandler = [nil, "create"] call ALIVE_fnc_profileHandler;
[ALIVE_profileHandler, "init"] call ALIVE_fnc_profileHandler;


STAT("Create Entity Profile");
_profileEntity = [nil, "create"] call ALIVE_fnc_profileEntity;
[_profileEntity, "init"] call ALIVE_fnc_profileEntity;
[_profileEntity, "profileID", "group_01"] call ALIVE_fnc_profileEntity;
[_profileEntity, "unitClasses", ["B_Soldier_TL_F","B_Soldier_SL_F","B_Soldier_F","B_Soldier_F","B_Soldier_F","B_Soldier_F","B_Soldier_F","B_Soldier_F"]] call ALIVE_fnc_profileEntity;
[_profileEntity, "position", getPos player] call ALIVE_fnc_profileEntity;
[_profileEntity, "positions", [getPos player,getPos player,getPos player,getPos player,getPos player,getPos player,getPos player,getPos player]] call ALIVE_fnc_profileEntity;
[_profileEntity, "damages", [0,0,0,0,0,0,0,0]] call ALIVE_fnc_profileEntity;
[_profileEntity, "ranks", ["CAPTAIN","LIEUTENANT","PRIVATE","PRIVATE","PRIVATE","PRIVATE","PRIVATE","PRIVATE"]] call ALIVE_fnc_profileEntity;
[_profileEntity, "side", "WEST"] call ALIVE_fnc_profileEntity;


STAT("Create Entity Profile");
_profileEntity2 = [nil, "create"] call ALIVE_fnc_profileEntity;
[_profileEntity2, "init"] call ALIVE_fnc_profileEntity;
[_profileEntity2, "profileID", "group_02"] call ALIVE_fnc_profileEntity;
[_profileEntity2, "unitClasses", ["B_Soldier_TL_F","B_Soldier_SL_F","B_Soldier_F"]] call ALIVE_fnc_profileEntity;
[_profileEntity2, "position", getPos player] call ALIVE_fnc_profileEntity;
[_profileEntity2, "positions", [getPos player,getPos player,getPos player]] call ALIVE_fnc_profileEntity;
[_profileEntity2, "damages", [0,0,0]] call ALIVE_fnc_profileEntity;
[_profileEntity2, "ranks", ["CAPTAIN","LIEUTENANT","PRIVATE"]] call ALIVE_fnc_profileEntity;
[_profileEntity2, "side", "WEST"] call ALIVE_fnc_profileEntity;


STAT("Create Vehicle Profile");
_profileVehicle = [nil, "create"] call ALIVE_fnc_profileVehicle;
[_profileVehicle, "init"] call ALIVE_fnc_profileVehicle;
[_profileVehicle, "profileID", "vehicle_01"] call ALIVE_fnc_profileVehicle;
[_profileVehicle, "vehicleClass", "B_Hunter_HMG_F"] call ALIVE_fnc_profileVehicle;
[_profileVehicle, "position", [getPos player, 20, 180] call BIS_fnc_relPos] call ALIVE_fnc_profileVehicle;
[_profileVehicle, "direction", 180] call ALIVE_fnc_profileVehicle;
[_profileVehicle, "damage", 0] call ALIVE_fnc_profileVehicle;
[_profileVehicle, "fuel", 1] call ALIVE_fnc_profileVehicle;
[_profileVehicle, "side", "WEST"] call ALIVE_fnc_profileVehicle;


STAT("Create Vehicle Profile");
_profileVehicle2 = [nil, "create"] call ALIVE_fnc_profileVehicle;
[_profileVehicle2, "init"] call ALIVE_fnc_profileVehicle;
[_profileVehicle2, "profileID", "vehicle_02"] call ALIVE_fnc_profileVehicle;
[_profileVehicle2, "vehicleClass", "B_MH9_F"] call ALIVE_fnc_profileVehicle;
[_profileVehicle2, "position", [getPos player, 20, 360] call BIS_fnc_relPos] call ALIVE_fnc_profileVehicle;
[_profileVehicle2, "direction", 180] call ALIVE_fnc_profileVehicle;
[_profileVehicle2, "damage", 0] call ALIVE_fnc_profileVehicle;
[_profileVehicle2, "fuel", 1] call ALIVE_fnc_profileVehicle;
[_profileVehicle2, "side", "WEST"] call ALIVE_fnc_profileVehicle;


STAT("Register Profile");
[ALIVE_profileHandler, "registerProfile", _profileEntity] call ALIVE_fnc_profileHandler;
[ALIVE_profileHandler, "registerProfile", _profileEntity2] call ALIVE_fnc_profileHandler;
[ALIVE_profileHandler, "registerProfile", _profileVehicle] call ALIVE_fnc_profileHandler;
[ALIVE_profileHandler, "registerProfile", _profileVehicle2] call ALIVE_fnc_profileHandler;


STAT("Set debug on profile handler");
[ALIVE_profileHandler, "debug", true] call ALIVE_fnc_profileHandler;


STAT("Assign group 1 to vehicle 1");
[_profileEntity,_profileVehicle] call ALIVE_fnc_createProfileVehicleAssignment;

STAT("Assign group 2 to vehicle 2");
[_profileEntity2,_profileVehicle2] call ALIVE_fnc_createProfileVehicleAssignment;

STAT("Assign group 1 to vehicle 2");
[_profileEntity,_profileVehicle2] call ALIVE_fnc_createProfileVehicleAssignment;


/*
STAT("Get group 1 state");
_profileEntityState = [_profileEntity, "state"] call ALIVE_fnc_profileEntity;
_profileEntityState call ALIVE_fnc_inspectHash;

STAT("Get group 2 state");
_profileEntityState2 = [_profileEntity2, "state"] call ALIVE_fnc_profileEntity;
_profileEntityState2 call ALIVE_fnc_inspectHash;

STAT("Get vehicle 1 state");
_profileVehicleState = [_profileVehicle, "state"] call ALIVE_fnc_profileVehicle;
_profileVehicleState call ALIVE_fnc_inspectHash;

STAT("Get vehicle 2 state");
_profileVehicleState2 = [_profileVehicle2, "state"] call ALIVE_fnc_profileVehicle;
_profileVehicleState2 call ALIVE_fnc_inspectHash;
*/

STAT("Spawn the unit via the profile");
[_profileEntity, "spawn"] call ALIVE_fnc_profileEntity;


/*
STAT("Spawn the unit via the profile");
[_profileEntity, "spawn"] call ALIVE_fnc_profileEntity;


STAT("Spawn the vehicle via the profile");
[_profileVehicle, "spawn"] call ALIVE_fnc_profileVehicle;


_vehicle = [_profileVehicle,"vehicle"] call ALIVE_fnc_hashGet;
_leader = [_profileEntity,"leader"] call ALIVE_fnc_hashGet;
_group = group _leader;

_assignments = [_group,_vehicle] call ALIVE_fnc_vehicleAssignGroup;

diag_log _assignments;
*/

/*
STAT("Sleep for 10");
SLEEP 10;


STAT("De-Spawn the unit via the profile");
_unit = [_profileEntity, "despawn"] call ALIVE_fnc_profileEntity;


STAT("De-Spawn the vehicle via the profile");
_unit = [_profileVehicle, "despawn"] call ALIVE_fnc_profileVehicle;
*/