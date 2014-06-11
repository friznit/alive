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
	STAT("Checking attach action on player");
	_err = "Initialising carryObject failed";
    
	_id_carryObject = [ALiVE_SYS_LOGISTICS,"addAction",[player,"carryObject"]] call ALiVE_fnc_logistics; 
	ASSERT_TRUE(_idA > 0,_err);
	
	STAT("Checking dropObject action on player");
	_err = "Initialising dropObject failed";
	
	_id_dropObject = [ALiVE_SYS_LOGISTICS,"addAction",[player,"dropObject"]] call ALiVE_fnc_logistics;
	ASSERT_TRUE(_idD > 0,_err);
	
	STAT("Checking stowObjects action on player");
	_err = "Initialising stowObjects failed";
	
	_id_stowObjects = [ALiVE_SYS_LOGISTICS,"addAction",[player,"stowObjects"]] call ALiVE_fnc_logistics;
	ASSERT_TRUE(_idLI > 0,_err);
	
	STAT("Checking unloadObjects action on player");
	_err = "Initialising unloadObjects failed";
	
	_id_unloadObjects = [ALiVE_SYS_LOGISTICS,"addAction",[player,"unloadObjects"]] call ALiVE_fnc_logistics;
	ASSERT_TRUE(_idLO > 0,_err);
    
    STAT("Checking towObject action on player");
	_err = "Initialising towObject failed";
    
	_id_towObject = [ALiVE_SYS_LOGISTICS,"addAction",[player,"towObject"]] call ALiVE_fnc_logistics; 
	ASSERT_TRUE(_idA > 0,_err);
	
	STAT("Checking untowObject action on player");
	_err = "Initialising untowObject failed";
	
	_id_untowObject = [ALiVE_SYS_LOGISTICS,"addAction",[player,"untowObject"]] call ALiVE_fnc_logistics;
	ASSERT_TRUE(_idD > 0,_err);
	
	STAT("Checking liftObject action on player");
	_err = "Initialising liftObject failed";
	
	_id_liftObject = [ALiVE_SYS_LOGISTICS,"addAction",[player,"liftObject"]] call ALiVE_fnc_logistics;
	ASSERT_TRUE(_idLI > 0,_err);
	
	STAT("Checking releaseObject action on player");
	_err = "Initialising releaseObject failed";
	
	_id_releaseObject = [ALiVE_SYS_LOGISTICS,"addAction",[player,"releaseObject"]] call ALiVE_fnc_logistics;
	ASSERT_TRUE(_idLO > 0,_err);
	
	STAT("Removing temp actions of player");
	{player removeAction _x} foreach [_id_towObject,_id_untowObject,_id_liftObject,_id_releaseObject,_id_unloadObjects,_id_stowObjects,_id_dropObject,_id_carryObject];
    
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