// ----------------------------------------------------------------------------

#include <\x\alive\addons\sys_profile\script_component.hpp>
SCRIPT(test_profileHandler);

// ----------------------------------------------------------------------------

private ["_result","_err","_logic","_state","_result2","_profileHandler","_unitProfile","_groupProfile","_position","_profileWaypoint"];

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

// CREATE PROFILE HANDLER
STAT("Create Profile Handler");
_profileHandler = [nil, "create"] call ALIVE_fnc_profileHandler;
[_profileHandler, "init"] call ALIVE_fnc_profileHandler;


STAT("Create Unit Profile");
_unitProfile = [nil, "create"] call ALIVE_fnc_agentProfile;
[_unitProfile, "init"] call ALIVE_fnc_agentProfile;
[_unitProfile, "objectID", "agent_01"] call ALIVE_fnc_agentProfile;
[_unitProfile, "unitClass", "B_Soldier_F"] call ALIVE_fnc_agentProfile;
[_unitProfile, "position", getPos player] call ALIVE_fnc_agentProfile;
[_unitProfile, "side", "WEST"] call ALIVE_fnc_agentProfile;
[_unitProfile, "groupID", "group_01"] call ALIVE_fnc_agentProfile;


STAT("Create Group Profile");
_groupProfile = [nil, "create"] call ALIVE_fnc_groupProfile;
[_groupProfile, "init"] call ALIVE_fnc_groupProfile;
[_groupProfile, "objectID", "group_01"] call ALIVE_fnc_groupProfile;
[_groupProfile, "unitClasses", ["B_Soldier_F","B_Soldier_F"]] call ALIVE_fnc_groupProfile;
[_groupProfile, "unitStatus", [true,true]] call ALIVE_fnc_groupProfile;
[_groupProfile, "side", "WEST"] call ALIVE_fnc_groupProfile;
[_groupProfile, "leaderID", "agent_01"] call ALIVE_fnc_groupProfile;


STAT("Register Profile");
[_profileHandler, "registerProfile", _unitProfile] call ALIVE_fnc_profileHandler;
[_profileHandler, "registerProfile", _groupProfile] call ALIVE_fnc_profileHandler;


STAT("Delete local profile references");
_unitProfile = nil;
_groupProfile = nil;


STAT("Get the unit profile from the profile handler");
_unitProfile = [_profileHandler, "getProfile", "agent_01"] call ALIVE_fnc_profileHandler;


STAT("Set debug on profile handler");
[_profileHandler, "debug", true] call ALIVE_fnc_profileHandler;


STAT("Spawn the unit via the profile");
_unit = [_unitProfile, "spawn", _profileHandler] call ALIVE_fnc_agentProfile;


STAT("Sleep for 10");
SLEEP 10;


STAT("De-Spawn the unit via the profile");
[_unitProfile, "despawn", _profileHandler] call ALIVE_fnc_agentProfile;


STAT("Add waypoint");
_position = [getPos player, 200, random 360] call BIS_fnc_relPos;
_profileWaypoint = [_position, 50] call ALIVE_fnc_createProfileWaypoint;
[_unitProfile, "addWaypoint", _profileWaypoint] call ALIVE_fnc_agentProfile;


_m = createMarkerLocal ["destinationMarker1", _position];
_m setMarkerShapeLocal "ICON";
_m setMarkerSizeLocal [1, 1];
_m setMarkerTypeLocal "hd_dot";
_m setMarkerColorLocal "ColorRed";
_m setMarkerTextLocal "destination";


STAT("Add waypoint");
_position = [_position, 200, random 360] call BIS_fnc_relPos;
_profileWaypoint = [_position, 50] call ALIVE_fnc_createProfileWaypoint;
[_unitProfile, "addWaypoint", _profileWaypoint] call ALIVE_fnc_agentProfile;


_m = createMarkerLocal ["destinationMarker2", _position];
_m setMarkerShapeLocal "ICON";
_m setMarkerSizeLocal [1, 1];
_m setMarkerTypeLocal "hd_dot";
_m setMarkerColorLocal "ColorRed";
_m setMarkerTextLocal "destination";


STAT("Start simulated profile movement");
[_profileHandler] spawn {
	_profileHandler = _this select 0;
	[_profileHandler] call ALIVE_fnc_simulateProfileMovement;	
};


STAT("Sleep for 10");
SLEEP 20;


STAT("Spawn the unit via the profile");
_unit = [_unitProfile, "spawn", _profileHandler] call ALIVE_fnc_agentProfile;


STAT("Sleep for 10");
SLEEP 20;


STAT("De-Spawn the unit via the profile");
[_unitProfile, "despawn", _profileHandler] call ALIVE_fnc_agentProfile;

/*
STAT("Sleep for 10");
SLEEP 10;


STAT("Spawn the unit via the profile");
_unit = [_unitProfile, "spawn", _profileHandler] call ALIVE_fnc_agentProfile;


STAT("Sleep for 10");
SLEEP 10;


STAT("De-Spawn the unit via the profile");
[_unitProfile, "despawn", _profileHandler] call ALIVE_fnc_agentProfile;


STAT("Sleep for 10");
SLEEP 10;


STAT("Spawn the unit via the profile");
_unit = [_unitProfile, "spawn", _profileHandler] call ALIVE_fnc_agentProfile;


STAT("Sleep for 10");
SLEEP 10;


STAT("De-Spawn the unit via the profile");
[_unitProfile, "despawn", _profileHandler] call ALIVE_fnc_agentProfile;
*/