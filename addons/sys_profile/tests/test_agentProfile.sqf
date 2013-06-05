// ----------------------------------------------------------------------------

#include <\x\alive\addons\sys_profile\script_component.hpp>
SCRIPT(test_agentProfile);

// ----------------------------------------------------------------------------

private ["_result","_err","_logic","_state","_profileWaypoint"];

LOG("Testing Agent Profile Object");

ASSERT_DEFINED("ALIVE_fnc_agentProfile","");

#define STAT(msg) sleep 3; \
diag_log ["TEST("+str player+": "+msg]; \
titleText [msg,"PLAIN"]

#define STAT1(msg) CONT = false; \
waitUntil{CONT}; \
diag_log ["TEST("+str player+": "+msg]; \
titleText [msg,"PLAIN"]

#define DEBUGON STAT("Setup debug parameters"); \
_result = [_logic, "debug", true] call ALIVE_fnc_agentProfile; \
_err = "enabled debug"; \
ASSERT_TRUE(typeName _result == "BOOL", _err); \
ASSERT_TRUE(_result, _err);

#define DEBUGOFF STAT("Disable debug"); \
_result = [_logic, "debug", false] call ALIVE_fnc_agentProfile; \
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

_logic = nil;

STAT("Create Profile instance");
if(isServer) then {
	_logic = [nil, "create"] call ALIVE_fnc_agentProfile;
	TEST_LOGIC = _logic;
	publicVariable "TEST_LOGIC";
};


STAT("Init Profile");
_result = [_logic, "init"] call ALIVE_fnc_agentProfile;
_err = "set init";
ASSERT_TRUE(typeName _result == "BOOL", _err);


STAT("Confirm new Profile instance");
waitUntil{!isNil "TEST_LOGIC"};
_logic = TEST_LOGIC;
_err = "instantiate object";
ASSERT_DEFINED("_logic",_err);
ASSERT_TRUE(typeName _logic == "ARRAY", _err);


STAT("Set object id");
_result = [_logic, "objectID", "agent_01"] call ALIVE_fnc_agentProfile;
_err = "set object id";
ASSERT_TRUE(typeName _result == "STRING", _err);


STAT("Set unit class");
_result = [_logic, "unitClass", "B_Soldier_F"] call ALIVE_fnc_agentProfile;
_err = "set unit class";
ASSERT_TRUE(typeName _result == "STRING", _err);


STAT("Set position");
_result = [_logic, "position", getPos player] call ALIVE_fnc_agentProfile;
_err = "set position";
ASSERT_TRUE(typeName _result == "ARRAY", _err);


STAT("Set side");
_result = [_logic, "side", "WEST"] call ALIVE_fnc_agentProfile;
_err = "set side";
ASSERT_TRUE(typeName _result == "STRING", _err);


STAT("Set group ID");
_result = [_logic, "groupID", "group_01"] call ALIVE_fnc_agentProfile;
_err = "set groupID";
ASSERT_TRUE(typeName _result == "STRING", _err);


STAT("Set vehicle ID");
_result = [_logic, "vehicleID", "vehicle_01"] call ALIVE_fnc_agentProfile;
_err = "set vehicleID";
ASSERT_TRUE(typeName _result == "STRING", _err);


STAT("Set active");
_result = [_logic, "active", true] call ALIVE_fnc_agentProfile;
_err = "set active";
ASSERT_TRUE(typeName _result == "BOOL", _err);


_profileWaypoint = [getPos player, 100] call ALIVE_fnc_createProfileWaypoint;
diag_log _profileWaypoint;


STAT("Add waypoint");
_result = [_logic, "addWaypoint", _profileWaypoint] call ALIVE_fnc_agentProfile;
_err = "add waypoint";
ASSERT_TRUE(typeName _result == "ARRAY", _err);


_profileWaypoint = [getPos player, 100] call ALIVE_fnc_createProfileWaypoint;
diag_log _profileWaypoint;


STAT("Add waypoint");
_result = [_logic, "addWaypoint", _profileWaypoint] call ALIVE_fnc_agentProfile;
_err = "add waypoint";
ASSERT_TRUE(typeName _result == "ARRAY", _err);


STAT("Clear waypoints");
_result = [_logic, "clearWaypoints"] call ALIVE_fnc_agentProfile;
_err = "clear waypoints";
ASSERT_TRUE(typeName _result == "BOOL", _err);


STAT("Get state");
_state = [_logic, "state"] call ALIVE_fnc_agentProfile;
_err = "get state";
ASSERT_TRUE(typeName _state == "ARRAY", _err);


DEBUGON
diag_log _state;


STAT("Sleeping before destroy");
sleep 10;


STAT("Destroy old Profile instance");
if(isServer) then {
	[_logic, "destroy"] call ALIVE_fnc_agentProfile;
	TEST_LOGIC = nil;
	publicVariable "TEST_LOGIC";
} else {
	waitUntil{isNull TEST_LOGIC};
};

nil;