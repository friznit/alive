// ----------------------------------------------------------------------------

#include <\x\alive\addons\nme_strategic\script_component.hpp>
SCRIPT(test_SEP);

// ----------------------------------------------------------------------------


private ["_result","_err","_logic","_amo"];

LOG("Testing SEP");

ASSERT_DEFINED("ALIVE_fnc_SEP","");

#define STAT(msg) sleep 3; \
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
_err = "instantiate object";
ASSERT_DEFINED("_logic",_err);
ASSERT_TRUE(typeName _logic == "OBJECT", _err);

DEBUGON

STAT("style - Test default");
_result = [_logic, "style"] call ALIVE_fnc_SEP;
_err = "style - default";
ASSERT_TRUE(typeName _result == "STRING", _err);
ASSERT_TRUE(_result == "SYM", _err);

STAT("size - Test default");
_result = [_logic, "size"] call ALIVE_fnc_SEP;
_err = "size - default";
ASSERT_TRUE(typeName _result == "STRING", _err);
ASSERT_TRUE(_result == "COY", _err);
/*
STAT("factions - Test default");
_result = [_logic, "factions"] call ALIVE_fnc_SEP;
_err = "factions - default";
ASSERT_TRUE(typeName _result == "STRING", _err);
ASSERT_TRUE(_result == "Red", _err);
*/
/*
// Manipulate nodes - remove last object
_newnode = _obj_array select 11;
_new_array = _obj_array - [_newnode];

STAT("Assign nodes");
_result = [_logic, "nodes", _new_array] call ALIVE_fnc_cluster;
_err = "set nodes";
ASSERT_TRUE(typeName _result == "ARRAY", _err);
waitUntil{count ([_logic, "nodes"] call ALIVE_fnc_cluster) == 11};

_oldnodecount = count ([_logic, "nodes"] call ALIVE_fnc_cluster);

STAT("Add new node");
[_logic, "addNode", _newnode] call ALIVE_fnc_cluster;
_result = [_logic, "nodes"] call ALIVE_fnc_cluster;
_err = "add node";
ASSERT_TRUE(typeName _result == "ARRAY", _err);
STAT("Confirm new node");
waitUntil{count ([_logic, "nodes"] call ALIVE_fnc_cluster) == _oldnodecount + 1};

_newnode = ([_logic, "nodes"] call ALIVE_fnc_cluster) select 0;

STAT("Remove a nodes");
[_logic, "delNode", _newnode] call ALIVE_fnc_cluster;
_result = [_logic, "nodes"] call ALIVE_fnc_cluster;
_err = "remove node";
ASSERT_TRUE(typeName _result == "ARRAY", _err);
STAT("Confirm remove a node");
waitUntil{count ([_logic, "nodes"] call ALIVE_fnc_cluster) == _oldnodecount};
_test = _result;

STAT("Save state");
_result = [_logic, "state"] call ALIVE_fnc_cluster;
_err = "check state";
ASSERT_TRUE(typeName _result == "ARRAY", _err);
ASSERT_TRUE(count _result > 0, _err);
_state = _result;

STAT("Reset debug");
DEBUGOFF
sleep 5;
DEBUGON

STAT("Sleeping before destroy");
sleep 10;

STAT("Destroy old instance");
if(isServer) then {
	[_logic, "destroy"] call ALIVE_fnc_cluster;
	TEST_LOGIC = nil;
	publicVariable "TEST_LOGIC";
} else {
	waitUntil{isNull TEST_LOGIC};
};

STAT("Create Cluster instance");
if(isServer) then {
	_logic = [nil, "create"] call ALIVE_fnc_cluster;
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
	[_logic, "state", _state] call ALIVE_fnc_cluster;
};

STAT("Confirm restored state is still the same");
_result = [_logic, "state"] call ALIVE_fnc_cluster;
_err = "confirming restored state";
ASSERT_TRUE(typeName _result == "ARRAY", _err);
ASSERT_TRUE(count _result > 0, _err);
_result2 = [_test, ([_logic, "nodes"] call ALIVE_fnc_cluster)] call BIS_fnc_areEqual;
ASSERT_TRUE(_result2,_err);

STAT("Sleeping before destroy");
sleep 10;

if(isServer) then {
	STAT("Destroy old instance");
	[_logic, "destroy"] call ALIVE_fnc_cluster;
	TEST_LOGIC2 = nil;
	publicVariable "TEST_LOGIC2";
} else {
	STAT("Confirm destroy instance 2");
	waitUntil{isNull TEST_LOGIC2};
};

sleep 5;

STAT("Clean up markers");
{
	deleteMarker str _x;
	deleteVehicle _x;
} forEach _obj_array;
*/
diag_log (allMissionObjects "") - _amo;

nil;
