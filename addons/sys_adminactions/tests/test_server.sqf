// ----------------------------------------------------------------------------

#include <script_macros_core.hpp>
SCRIPT(test_cqb_server);

// ----------------------------------------------------------------------------

private ["_result","_err","_logic","_nearesthouse","_oldgroupcount","_oldunitcount","_oldhousecount","_unittypes","_result2","_state"];

LOG("Testing CQB Server");

// UNIT TESTS
ASSERT_DEFINED("MSO_fnc_CQB","");
ASSERT_DEFINED("MSO_fnc_getEnterableHouses","");

//========================================
// Start Defines

#define STAT1(msg) sleep 1; \
["TEST("+str player+": "+msg] call MSO_fnc_logger; \
titleText [msg,"PLAIN"]

#define STAT(msg) CONT = false; \
waitUntil{CONT}; \
["TEST("+str player+": "+msg] call MSO_fnc_logger; \
titleText [msg,"PLAIN"]

#define MISSIONOBJECTCOUNT _err = format["Mission objects: %1", count allMissionObjects ""]; \
STAT(_err);

#define DEBUGON STAT("Setup debug parameters"); \
_result = [_logic, "debug", true] call MSO_fnc_CQB; \
_err = "enabled debug"; \
ASSERT_TRUE(typeName _result == "BOOL", _err); \
ASSERT_TRUE(_result, _err);

#define DEBUGOFF STAT("Disable debug"); \
_result = [_logic, "debug", false] call MSO_fnc_CQB; \
_err = "disable debug"; \
ASSERT_TRUE(typeName _result == "BOOL", _err); \
ASSERT_TRUE(!_result, _err);

#define SPAWN0DISTANCE STAT("Set spawn distance to zero (disable activity)"); \
_result = [_logic, "spawnDistance", 0] call MSO_fnc_CQB; \
_err = "set spawn distance"; \
ASSERT_TRUE(typeName _result == "SCALAR", _err); \
STAT("Confirm spawn distance to zero (disable activity)"); \
waitUntil{([_logic, "spawnDistance"] call MSO_fnc_CQB) == 0};

#define SPAWN10DISTANCE STAT("Increase spawn distance for 1 building"); \
_result = [_logic, "spawnDistance", 10] call MSO_fnc_CQB; \
_err = "set spawn distance"; \
ASSERT_TRUE(typeName _result == "SCALAR", _err); \
STAT("Confirm spawn distance for 1 building"); \
waitUntil{([_logic, "spawnDistance"] call MSO_fnc_CQB) == 10};

#define CHECK0GROUPS STAT("Check for no groups"); \
_result = [_logic, "groups"] call MSO_fnc_CQB; \
_err = "check 0 groups"; \
ASSERT_TRUE(typeName _result == "ARRAY", _err); \
ASSERT_TRUE(count _result == 0, _err); \
ASSERT_TRUE(count AllGroups == _oldgroupcount, _err); \
ASSERT_TRUE(count allUnits == _oldunitcount, _err);

#define CHECK1GROUP STAT("Waiting for group"); \
waitUntil{sleep 3; (count ([_logic, "groups"] call MSO_fnc_CQB) > 0)}; \
STAT("Check for 1 new group"); \
_result = [_logic, "groups"] call MSO_fnc_CQB; \
_err = "check 1 group"; \
ASSERT_TRUE(typeName _result == "ARRAY", _err); \
ASSERT_TRUE(count _result == 1, _err); \
ASSERT_TRUE(count AllGroups == _oldgroupcount + 1, _err); \
ASSERT_TRUE(count allUnits > _oldunitcount, _err);

#define CHECKUNITTYPES STAT("Check unit types remained the same"); \
_result = _nearesthouse getVariable "unittypes"; \
_err = "check group unittypes"; \
ASSERT_TRUE(typeName _result == "ARRAY", _err); \
ASSERT_TRUE(count _result > 0, _err); \
_result2 = [_result, _unittypes] call BIS_fnc_areEqual; \
ASSERT_TRUE(_result2,_err);

//========================================

MISSIONOBJECTCOUNT

_logic = nil;

STAT("Create CQB instance");
if(isServer) then {
	_logic = call MSO_fnc_CQB;
	TEST_LOGIC = _logic;
	publicVariable "TEST_LOGIC";
};
STAT("Confirm new CQB instance");
waitUntil{!isNil "TEST_LOGIC"};
_logic = TEST_LOGIC;
_err = "instantiate object";
ASSERT_DEFINED("_logic",_err);
ASSERT_TRUE(typeName _logic == "OBJECT", _err);

_logic setVariable ["debugColor","ColorRed"];
_logic setVariable ["debugPrefix","Testing"];
DEBUGON

STAT("Find distant enterable houses");
// loc is for Utes Strelka
_result = [_logic, "houses", [[4345.0229,3232.7737], 50] call MSO_fnc_getEnterableHouses] call MSO_fnc_CQB;
_err = "set houses";
ASSERT_TRUE(typeName _result == "ARRAY", _err);
waitUntil{count ([_logic, "houses"] call MSO_fnc_CQB) > 0};

_oldhousecount = count ([_logic, "houses"] call MSO_fnc_CQB);
// loc is for Utes Strelka
_nearesthouse = ([[4395.0229,3171.7737], 10] call MSO_fnc_getEnterableHouses) select 0;

STAT("Add nearest building to Player 1");
[_logic, "addHouse", _nearesthouse] call MSO_fnc_CQB;
_result = [_logic, "houses"] call MSO_fnc_CQB;
_err = "add house";
ASSERT_TRUE(typeName _result == "ARRAY", _err);
STAT("Confirm new distant enterable house");
waitUntil{count ([_logic, "houses"] call MSO_fnc_CQB) == _oldhousecount + 1};

_result = ([_logic, "houses"] call MSO_fnc_CQB) select 0;

STAT("Remove a building");
[_logic, "clearHouse", _result] call MSO_fnc_CQB;
_result = [_logic, "houses"] call MSO_fnc_CQB;
_err = "remove house";
ASSERT_TRUE(typeName _result == "ARRAY", _err);
STAT("Confirm remove a building");
waitUntil{count ([_logic, "houses"] call MSO_fnc_CQB) == _oldhousecount};

STAT("Set factions");
_result = [_logic, "factions", ["RU","INS"]] call MSO_fnc_CQB;
_err = "set factions";
ASSERT_TRUE(typeName _result == "ARRAY", _err);
STAT("Confirm set factions");
waitUntil{count ([_logic, "factions"] call MSO_fnc_CQB) > 0};

SPAWN0DISTANCE

_oldgroupcount = count allGroups;
_oldunitcount = count allUnits;

STAT("Activate CQB");
[_logic, "active", true] call MSO_fnc_CQB;

sleep 5;

CHECK0GROUPS

SPAWN10DISTANCE

CHECK1GROUP

STAT("Get and store unit types for nearest building");
_result = _nearesthouse getVariable "unittypes";
_err = "check group unittypes";
ASSERT_TRUE(typeName _result == "ARRAY", _err);
ASSERT_TRUE(count _result > 0, _err);
_unittypes = _result;

STAT("Save state");
_result = [_logic, "state"] call MSO_fnc_CQB;
_err = "check state";
ASSERT_TRUE(typeName _result == "ARRAY", _err);
ASSERT_TRUE(count _result > 0, _err);
_state = _result;

DEBUGOFF

_logic setVariable ["debugColor","ColorGreen"];
_logic setVariable ["debugPrefix","Testing2"];
DEBUGON

SPAWN0DISTANCE

waitUntil{sleep 3; (count ([_logic, "groups"] call MSO_fnc_CQB) == 0)};

sleep 5;

CHECK0GROUPS

CHECKUNITTYPES

SPAWN10DISTANCE

CHECK1GROUP

SPAWN0DISTANCE

waitUntil{sleep 3; (count ([_logic, "groups"] call MSO_fnc_CQB) == 0)};

CHECK0GROUPS

CHECKUNITTYPES

STAT("Sleeping before destroy");
sleep 15;

STAT("Destroy old instance");
if(isServer) then {
	[_logic, "destroy"] call MSO_fnc_CQB;
	TEST_LOGIC = nil;
	publicVariable "TEST_LOGIC";
} else {
	waitUntil{isNull TEST_LOGIC};
};

MISSIONOBJECTCOUNT

STAT("Create CQB instance");
if(isServer) then {
	_logic = call MSO_fnc_CQB;
	TEST_LOGIC2 = _logic;
	publicVariable "TEST_LOGIC2";
};
STAT("Confirm new CQB instance 2");
waitUntil{!isNil "TEST_LOGIC2"};
_logic = TEST_LOGIC2;
_err = "instantiate object";
ASSERT_DEFINED("_logic",_err);
ASSERT_TRUE(typeName _logic == "OBJECT", _err);

STAT("Activate new instance");
[_logic, "active", true] call MSO_fnc_CQB;

_logic setVariable ["debugColor","ColorBlue"];
_logic setVariable ["debugPrefix","Testing3"];
DEBUGON

STAT("Restore state on new instance");
if(isServer) then {
	[_logic, "state", _state] call MSO_fnc_CQB;
};

waitUntil{sleep 3; count ([_logic, "houses"] call MSO_fnc_CQB) > 0};

STAT("Confirm restored state is still the same");
_result = [_logic, "state"] call MSO_fnc_CQB;
_err = "confirming restored state";
ASSERT_TRUE(typeName _result == "ARRAY", _err);
ASSERT_TRUE(count _result > 0, _err);
_result2 = [_result, _state] call BIS_fnc_areEqual;
ASSERT_TRUE(_result2,_err);

CHECKUNITTYPES

SPAWN10DISTANCE

CHECK1GROUP

waitUntil{sleep 3; count units (([_logic, "groups"] call MSO_fnc_CQB) select 0) > 0};

STAT("Kill units");
_result = [_logic, "groups"] call MSO_fnc_CQB;
{
	_x setDamage 1;
} forEach units (_result select 0);

STAT("Waiting for house to clear");
waitUntil{sleep 3; (count ([_logic, "groups"] call MSO_fnc_CQB) == 0)};

STAT("Check house is cleared");
_result = [_logic, "houses"] call MSO_fnc_CQB;
_err = "check house cleared";
ASSERT_TRUE(typeName _result == "ARRAY", _err);
ASSERT_TRUE(!(_nearesthouse in _result), _err);

CHECK0GROUPS

STAT("Sleeping before destroy");
sleep 15;

if(isServer) then {
	STAT("Destroy old instance");
	[_logic, "destroy"] call MSO_fnc_CQB;
	TEST_LOGIC2 = nil;
	publicVariable "TEST_LOGIC2";
} else {
	STAT("Confirm destroy instance 2");
	waitUntil{isNull TEST_LOGIC2};
};

MISSIONOBJECTCOUNT

nil;
