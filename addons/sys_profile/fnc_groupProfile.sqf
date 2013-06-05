#include <\x\alive\addons\sys_profile\script_component.hpp>
SCRIPT(groupProfile);

/* ----------------------------------------------------------------------------
Function: MAINCLASS
Description:
Group profile class

Parameters:
Nil or Object - If Nil, return a new instance. If Object, reference an existing instance.
String - The selected function
Array - The selected parameters
String - objectID - Set the profile object id
String - unitClass - Set the profile class name

Returns:
Any - The new instance or the result of the selected function and parameters

Attributes:
Boolean - debug - Debug enable, disable or refresh
Boolean - state - Store or restore state
String - objectID - Set the profile object id
Array - unitClasses - Set the profile class names
Array - unitStatus - Set the profile unit statuses
String - side - Set the profile side
String - leaderID - Set the profile group leader profile object id
String - vehicleIDs - Set the profile vehicle profile object id
Boolean - active - Flag for if the agents are spawned
Object - unit - Reference to the spawned units

Examples:
(begin example)
// create a profile
_logic = [nil, "create"] call ALIVE_fnc_groupProfile;

// init the profile
_result = [_logic, "init"] call ALIVE_fnc_groupProfile;

// set the profile object id
_result = [_logic, "objectID", "agent_01"] call ALIVE_fnc_groupProfile;

// set the unit class of the profile
_result = [_logic, "unitClasses", ["B_Soldier_F","B_Soldier_F"]] call ALIVE_fnc_groupProfile;

// set the unit status of the profile
_result = [_logic, "unitStatus", [true,true]] call ALIVE_fnc_groupProfile;

// set the profile side
_result = [_logic, "side", "WEST"] call ALIVE_fnc_groupProfile;

// set the profile group leader id
_result = [_logic, "leaderID", "agent_01"] call ALIVE_fnc_groupProfile;

// set the vehicle object ids
_result = [_logic, "vehicleIDs", ["vehicle_01","vehicle_02"]] call ALIVE_fnc_groupProfile;

// set the profile is active
_result = [_logic, "active", true] call ALIVE_fnc_agentProfile;

// set the profile units object reference
_result = [_logic, "units", [_unit,_unit]] call ALIVE_fnc_agentProfile;
(end)

See Also:

Author:
ARJay

Peer reviewed:
nil
---------------------------------------------------------------------------- */

#define SUPERCLASS ALIVE_fnc_profile
#define MAINCLASS ALIVE_fnc_groupProfile

private ["_logic","_operation","_args","_result"];

TRACE_1("groupProfile - input",_this);

_logic = [_this, 0, objNull, [[]]] call BIS_fnc_param;
_operation = [_this, 1, "", [""]] call BIS_fnc_param;
_args = [_this, 2, objNull, [objNull,[],"",0,true,false]] call BIS_fnc_param;
_result = true;

#define MTEMPLATE "ALiVE_GROUPPROFILE_%1"

switch(_operation) do {
        case "init": {                
                /*
                MODEL - no visual just reference data
                - nodes
                - center
                - size
                */
                
                if (isServer) then {
                        // if server, initialise module game logic
						//[_logic,"super",SUPERCLASS] call CBA_fnc_hashSet;
						//[_logic,"class",MAINCLASS] call CBA_fnc_hashSet;
                        //TRACE_1("After module init",_logic);
						
						// set defaults
						[_logic,"active",false] call CBA_fnc_hashSet;
						[_logic,"type","group"] call CBA_fnc_hashSet;
                };
                
                /*
                VIEW - purely visual
                */
                
                /*
                CONTROLLER  - coordination
                */
        };
		case "objectID": {
				if(typeName _args == "STRING") then {
						[_logic,"objectID",_args] call CBA_fnc_hashSet;
                };
				_result = [_logic,"objectID"] call CBA_fnc_hashGet;
        };
		case "unitClasses": {
				if(typeName _args == "ARRAY") then {
						[_logic,"unitClasses",_args] call CBA_fnc_hashSet;
                };
				_result = [_logic,"unitClasses"] call CBA_fnc_hashGet;
        };
		case "unitStatus": {
				if(typeName _args == "ARRAY") then {
						[_logic,"unitStatus",_args] call CBA_fnc_hashSet;
                };
				_result = [_logic,"unitStatus"] call CBA_fnc_hashGet;
        };
		case "side": {
				if(typeName _args == "STRING") then {
						[_logic,"side",_args] call CBA_fnc_hashSet;
                };
				_result = [_logic,"side"] call CBA_fnc_hashGet;
        };
		case "leaderID": {
				if(typeName _args == "STRING") then {
						[_logic,"leaderID",_args] call CBA_fnc_hashSet;
                };
				_result = [_logic,"leaderID"] call CBA_fnc_hashGet;
        };
		case "vehicleIDs": {
				if(typeName _args == "ARRAY") then {
						[_logic,"vehicleIDs",_args] call CBA_fnc_hashSet;
                };
				_result = [_logic,"vehicleIDs"] call CBA_fnc_hashGet;
        };
		case "units": {
				if(typeName _args == "ARRAY") then {
						[_logic,"units",_args] call CBA_fnc_hashSet;
                };
				_result = [_logic,"units"] call CBA_fnc_hashGet;
        };
		case "active": {
				if(typeName _args == "BOOL") then {
						[_logic,"active",_args] call CBA_fnc_hashSet;
                };
				_result = [_logic,"active"] call CBA_fnc_hashGet;
        };
        default {
                _result = [_logic, _operation, _args] call SUPERCLASS;
        };
};
TRACE_1("groupProfile - output",_result);
_result;