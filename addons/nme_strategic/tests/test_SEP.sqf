// ----------------------------------------------------------------------------

#include <\x\alive\addons\nme_strategic\script_component.hpp>
SCRIPT(test_SEP);

// ----------------------------------------------------------------------------

private ["_result","_err","_logic","_amo","_state","_result2"];

LOG("Testing SEP");

ASSERT_DEFINED("ALIVE_fnc_SEP","");

#define STAT(msg) sleep 0.5; \
diag_log ["TEST("+str player+": "+msg]; \
titleText [msg,"PLAIN"]

#define STAT1(msg) CONT = false; \
waitUntil{CONT}; \
diag_log ["TEST("+str player+": "+msg]; \
titleText [msg,"PLAIN"]

#define DEBUGON STAT("Setup debug parameters"); \
_result = [_logic, "debug", true] call ALIVE_fnc_SEP; \
_err = "enabled debug"; \
ASSERT_TRUE(typeName _result == "BOOL", _err); \
ASSERT_TRUE(_result, _err);

#define DEBUGOFF STAT("Disable debug"); \
_result = [_logic, "debug", false] call ALIVE_fnc_SEP; \
_err = "disable debug"; \
ASSERT_TRUE(typeName _result == "BOOL", _err); \
ASSERT_TRUE(!_result, _err);

//========================================

_amo = allMissionObjects "";

_logic = nil;

STAT("Create SEP instance");
if(isServer) then {
	_logic = [nil, "create"] call ALIVE_fnc_SEP;
	TEST_LOGIC = _logic;
	publicVariable "TEST_LOGIC";
};
STAT("Confirm new SEP instance");
waitUntil{!isNil "TEST_LOGIC"};
_logic = TEST_LOGIC;
ASSERT_DEFINED("_logic",_logic);
ASSERT_TRUE(typeName _logic == "OBJECT", typeName _logic);

DEBUGON

STAT("style - Test default");
_result = [_logic, "style"] call ALIVE_fnc_SEP;
ASSERT_TRUE(typeName _result == "STRING", typeName _result);
ASSERT_TRUE(_result == "SYM", _result);
STAT("style - Test bad value");
_result = [_logic, "style", "xxx"] call ALIVE_fnc_SEP;
ASSERT_TRUE(typeName _result == "STRING", typeName _result);
ASSERT_TRUE(_result == "SYM", _result);
STAT("style - Test good value");
_result = [_logic, "style", "ASYM"] call ALIVE_fnc_SEP;
ASSERT_TRUE(typeName _result == "STRING", typeName _result);
ASSERT_TRUE(_result == "ASYM", _result);

STAT("size - Test default");
_result = [_logic, "size"] call ALIVE_fnc_SEP;
ASSERT_TRUE(typeName _result == "STRING", typeName _result);
ASSERT_TRUE(_result == "COY", _result);
STAT("size - Test bad value");
_result = [_logic, "size", "xxx"] call ALIVE_fnc_SEP;
ASSERT_TRUE(typeName _result == "STRING", typeName _result);
ASSERT_TRUE(_result == "COY", _result);
STAT("size - Test good value");
_result = [_logic, "size", "BN"] call ALIVE_fnc_SEP;
ASSERT_TRUE(typeName _result == "STRING", typeName _result);
ASSERT_TRUE(_result == "BN", _result);

STAT("faction - Test default");
_result = [_logic, "faction"] call ALIVE_fnc_SEP;
ASSERT_TRUE(typeName _result == "STRING", typeName _result);
ASSERT_TRUE(_result == "OPF_F", _result);
STAT("faction - Test bad value");
_result = [_logic, "faction", "xxx"] call ALIVE_fnc_SEP;
ASSERT_TRUE(typeName _result == "STRING", typeName _result);
ASSERT_TRUE(_result == "OPF_F", _result);
STAT("faction - Test good value");
_result = [_logic, "faction", "IND_F"] call ALIVE_fnc_SEP;
ASSERT_TRUE(typeName _result == "STRING", typeName _result);
ASSERT_TRUE(_result == "IND_F", _result);

STAT("Save state");
_result = [_logic, "state"] call ALIVE_fnc_SEP;
ASSERT_TRUE(typeName _result == "ARRAY", typeName _result);
ASSERT_TRUE(count _result > 0, _result);
_state = _result;

STAT("Reset debug");
DEBUGOFF
sleep 1;
DEBUGON

STAT("Sleeping before destroy");
sleep 1;

STAT("Destroy old instance");
if(isServer) then {
	[_logic, "destroy"] call ALIVE_fnc_SEP;
	TEST_LOGIC = nil;
	publicVariable "TEST_LOGIC";
} else {
	waitUntil{isNull TEST_LOGIC};
};

STAT("Create Cluster instance");
if(isServer) then {
	_logic = [nil, "create"] call ALIVE_fnc_SEP;
	TEST_LOGIC2 = _logic;
	publicVariable "TEST_LOGIC2";
};
STAT("Confirm new Cluster instance 2");
waitUntil{!isNil "TEST_LOGIC2"};
_logic = TEST_LOGIC2;
_err = "instantiate object";
ASSERT_DEFINED("_logic",_err);
ASSERT_TRUE(typeName _logic == "OBJECT", _err);

DEBUGON

STAT("Restore state on new instance");
if(isServer) then {
	[_logic, "state", _state] call ALIVE_fnc_SEP;
};

STAT("Confirm restored state is still the same");
_result = [_logic, "state"] call ALIVE_fnc_SEP;
_err = "confirming restored state";
ASSERT_TRUE(typeName _result == "ARRAY", _err);
ASSERT_TRUE(count _result > 0, _err);
_result2 = [_state, ([_logic, "state"] call ALIVE_fnc_SEP)] call BIS_fnc_areEqual;
ASSERT_TRUE(_result2,_err);

STAT("Sleeping before destroy");
sleep 1;

if(isServer) then {
	STAT("Destroy old instance");
	[_logic, "destroy"] call ALIVE_fnc_SEP;
	TEST_LOGIC2 = nil;
	publicVariable "TEST_LOGIC2";
} else {
	STAT("Confirm destroy instance 2");
	waitUntil{isNull TEST_LOGIC2};
};

diag_log (allMissionObjects "") - _amo;

nil;
