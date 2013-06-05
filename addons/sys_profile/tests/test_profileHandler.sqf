// ----------------------------------------------------------------------------

#include <\x\alive\addons\sys_profile\script_component.hpp>
SCRIPT(test_profileHandler);

// ----------------------------------------------------------------------------

private ["_result","_err","_logic","_state","_result2"];

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
_result = [_logic, "debug", true] call ALIVE_fnc_profile; \
_err = "enabled debug"; \
ASSERT_TRUE(typeName _result == "BOOL", _err); \
ASSERT_TRUE(_result, _err);

#define DEBUGOFF STAT("Disable debug"); \
_result = [_logic, "debug", false] call ALIVE_fnc_profile; \
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

STAT("Create Profile Handler instance");
if(isServer) then {
	_logic = [nil, "create"] call ALIVE_fnc_profileHandler;
	TEST_LOGIC = _logic;
	publicVariable "TEST_LOGIC";
};


STAT("Init Profile Handler");
_result = [_logic, "init"] call ALIVE_fnc_profileHandler;
_err = "set init";
ASSERT_TRUE(typeName _result == "BOOL", _err);


STAT("Confirm new Profile Handler instance");
waitUntil{!isNil "TEST_LOGIC"};
_logic = TEST_LOGIC;
_err = "instantiate object";
ASSERT_DEFINED("_logic",_err);
ASSERT_TRUE(typeName _logic == "ARRAY", _err);


_profile = [nil, "create"] call ALIVE_fnc_agentProfile;
_result = [_profile, "init"] call ALIVE_fnc_agentProfile;
_result = [_profile, "objectID", "agent_01"] call ALIVE_fnc_agentProfile;
_result = [_profile, "unitClass", "B_Soldier_F"] call ALIVE_fnc_agentProfile;
_result = [_profile, "position", getPos player] call ALIVE_fnc_agentProfile;
_result = [_profile, "side", "WEST"] call ALIVE_fnc_agentProfile;
_result = [_profile, "groupID", "group_01"] call ALIVE_fnc_agentProfile;
_result = [_profile, "vehicleID", "vehicle_01"] call ALIVE_fnc_agentProfile;
_result = [_profile, "active", true] call ALIVE_fnc_agentProfile;


STAT("Register Profile");
_result = [_logic, "registerProfile", _profile] call ALIVE_fnc_profileHandler;
_err = "register profile";
ASSERT_TRUE(typeName _result == "BOOL", _err);


STAT("Get Profile");
_result = [_logic, "getProfile", "agent_01"] call ALIVE_fnc_profileHandler;
_err = "get profile";
ASSERT_TRUE(typeName _result == "ARRAY", _err);


diag_log _result;


STAT("Get Profiles by type");
_result = [_logic, "getProfilesByType", "agent"] call ALIVE_fnc_profileHandler;
_err = "get Profiles by type";
ASSERT_TRUE(typeName _result == "ARRAY", _err);


diag_log _result;


STAT("Get Profiles by side");
_result = [_logic, "getProfilesBySide", "WEST"] call ALIVE_fnc_profileHandler;
_err = "get Profiles by side";
ASSERT_TRUE(typeName _result == "ARRAY", _err);


diag_log _result;


STAT("Get state");
_state = [_logic, "state"] call ALIVE_fnc_profileHandler;
_err = "get state";
ASSERT_TRUE(typeName _state == "ARRAY", _err);


diag_log _state;


STAT("UnRegister Profile");
_result = [_logic, "unregisterProfile", _profile] call ALIVE_fnc_profileHandler;
_err = "unregister profile";
ASSERT_TRUE(typeName _result == "BOOL", _err);


STAT("Get state");
_state = [_logic, "state"] call ALIVE_fnc_profileHandler;
_err = "get state";
ASSERT_TRUE(typeName _state == "ARRAY", _err);


diag_log _state;


STAT("Sleeping before destroy");
sleep 10;


STAT("Destroy old Profile Handler instance");
if(isServer) then {
	[_logic, "destroy"] call ALIVE_fnc_profileHandler;
	TEST_LOGIC = nil;
	publicVariable "TEST_LOGIC";
} else {
	waitUntil{isNull TEST_LOGIC};
};

nil;