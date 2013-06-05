// ----------------------------------------------------------------------------

#include <\x\alive\addons\sys_profile\script_component.hpp>
SCRIPT(test_groupProfile);

// ----------------------------------------------------------------------------

private ["_result","_err","_logic","_state","_result2"];

LOG("Testing Group Profile Object");

ASSERT_DEFINED("ALIVE_fnc_groupProfile","");

#define STAT(msg) sleep 3; \
diag_log ["TEST("+str player+": "+msg]; \
titleText [msg,"PLAIN"]

#define STAT1(msg) CONT = false; \
waitUntil{CONT}; \
diag_log ["TEST("+str player+": "+msg]; \
titleText [msg,"PLAIN"]

#define DEBUGON STAT("Setup debug parameters"); \
_result = [_logic, "debug", true] call ALIVE_fnc_groupProfile; \
_err = "enabled debug"; \
ASSERT_TRUE(typeName _result == "BOOL", _err); \
ASSERT_TRUE(_result, _err);

#define DEBUGOFF STAT("Disable debug"); \
_result = [_logic, "debug", false] call ALIVE_fnc_groupProfile; \
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
	_logic = [nil, "create"] call ALIVE_fnc_groupProfile;
	TEST_LOGIC = _logic;
	publicVariable "TEST_LOGIC";
};


STAT("Init Profile");
_result = [_logic, "init"] call ALIVE_fnc_groupProfile;
_err = "set init";
ASSERT_TRUE(typeName _result == "BOOL", _err);


STAT("Confirm new Profile instance");
waitUntil{!isNil "TEST_LOGIC"};
_logic = TEST_LOGIC;
_err = "instantiate object";
ASSERT_DEFINED("_logic",_err);
ASSERT_TRUE(typeName _logic == "ARRAY", _err);


STAT("Set object id");
_result = [_logic, "objectID", "group_01"] call ALIVE_fnc_groupProfile;
_err = "set object id";
ASSERT_TRUE(typeName _result == "STRING", _err);


STAT("Set unit classes");
_result = [_logic, "unitClasses", ["B_Soldier_F","B_Soldier_F"]] call ALIVE_fnc_groupProfile;
_err = "set unit classes";
ASSERT_TRUE(typeName _result == "ARRAY", _err);


STAT("Set unit statuses");
_result = [_logic, "unitStatus", [true,true]] call ALIVE_fnc_groupProfile;
_err = "set unit statuses";
ASSERT_TRUE(typeName _result == "ARRAY", _err);


STAT("Set side");
_result = [_logic, "side", "WEST"] call ALIVE_fnc_groupProfile;
_err = "set side";
ASSERT_TRUE(typeName _result == "STRING", _err);


STAT("Set leader id");
_result = [_logic, "leaderID", "agent_01"] call ALIVE_fnc_groupProfile;
_err = "set leader id";
ASSERT_TRUE(typeName _result == "STRING", _err);


STAT("Set vehicles ids");
_result = [_logic, "vehicleIDs", ["vehicle_01","vehicle_02"]] call ALIVE_fnc_groupProfile;
_err = "set vehicles ids";
ASSERT_TRUE(typeName _result == "ARRAY", _err);


STAT("Get state");
_state = [_logic, "state"] call ALIVE_fnc_groupProfile;
_err = "get state";
ASSERT_TRUE(typeName _state == "ARRAY", _err);


diag_log _state;

STAT("Sleeping before destroy");
sleep 10;


STAT("Destroy old Profile instance");
if(isServer) then {
	[_logic, "destroy"] call ALIVE_fnc_groupProfile;
	TEST_LOGIC = nil;
	publicVariable "TEST_LOGIC";
} else {
	waitUntil{isNull TEST_LOGIC};
};

nil;