// ----------------------------------------------------------------------------
#include <\x\alive\addons\sys_logistics\script_component.hpp>
SCRIPT(test_logistics);
// ----------------------------------------------------------------------------

private ["_result","_err","_logic","_amo"];

LOG("Testing logistics");

// UNIT TESTS
ASSERT_DEFINED("ALIVE_fnc_logistics","ALIVE_fnc_logistics is not defined!");

#define STAT(msg) sleep 1; \
diag_log ["TEST("+str player+": "+msg]; \
titleText [msg,"PLAIN"]

#define STAT1(msg) CONT = false; \
waitUntil{CONT}; \
diag_log ["TEST("+str player+": "+msg]; \
titleText [msg,"PLAIN"]

STAT("Test Logistics 1 starting...");

_amo = allMissionObjects "";

STAT("Create instance");
_err = "Creating instance failed";
if(isServer) then {
	TEST_LOGIC = [nil, "create"] call ALIVE_fnc_logistics;
    ASSERT_DEFINED("TEST_LOGIC",_err);
    
    publicVariable "TEST_LOGIC";
};

STAT("Confirm new instance on all localities");
_err = "Instantiating object failed";
waitUntil {!(isNil "TEST_LOGIC")};

_logic = TEST_LOGIC;
ASSERT_DEFINED("_logic",_err);
ASSERT_TRUE(typeName _logic == "OBJECT", _err);

STAT("Initialise instance with default values");
_err = "Initialising instance failed";

[_logic,"init"] call ALiVE_fnc_logistics;
ASSERT_DEFINED(QMOD(SYS_LOGISTICS),_err);

if (hasInterface) then {
    
    STAT("Preparing actions test and removing old actions");
    
    _actions = ["carryObject","dropObject","stowObjects","unloadObjects","towObject","untowObject","liftObject","releaseObject"];
    {[MOD(SYS_LOGISTICS),"removeAction",[player,_x]] call ALiVE_fnc_logistics} foreach _actions;
    
	{
        _message = format["Checking %1 action on player",_x];
		_err = format["Initialising %1 failed",_x];
        
        STAT(_message);
        
        _id = [MOD(SYS_LOGISTICS),'addAction',[player,_x]] call ALiVE_fnc_logistics;
        
		ASSERT_TRUE(_id > 0,_err);
        
         _actions set [_foreachIndex,_id];
         
        sleep 1;
	} foreach _actions;
	
	STAT("Removing temp actions from player");
	{player removeAction _x} foreach _actions;
    
    GVAR(CLIENT_ACTION_TESTFINISHED) = true;
    publicVariable QGVAR(CLIENT_ACTION_TESTFINISHED);
};
STAT("Waiting on action test to finish");
waituntil {!isnil QGVAR(CLIENT_ACTION_TESTFINISHED)};

STAT("Sleeping before destroy");
sleep 10;

STAT("Destroy created instance");
_err = "Destruction of old instance failed...";
if(isServer) then {
	[_logic, "destroy"] call ALIVE_fnc_logistics;
	missionNamespace setVariable ["TEST_LOGIC",nil];
} else {
	waitUntil {isNull TEST_LOGIC};
};

ASSERT_TRUE(isnil "TEST_LOGIC", _err);

diag_log (allMissionObjects "") - _amo;

STAT("Test Logistics 1 finished...");