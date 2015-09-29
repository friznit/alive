#include <\x\alive\addons\sup_command\script_component.hpp>
SCRIPT(commandHandler);

/* ----------------------------------------------------------------------------
Function: MAINCLASS
Description:
Server side command handling

Parameters:
Nil or Object - If Nil, return a new instance. If Object, reference an existing instance.
String - The selected function
Array - The selected parameters

Returns:
Any - The new instance or the result of the selected function and parameters

Attributes:


Examples:
(begin example)
// create a command handler
_logic = [nil, "create"] call ALIVE_fnc_commandHandler;

// init command handler
_result = [_logic, "init"] call ALIVE_fnc_commandHandler;

(end)

See Also:

Author:
SpyderBlack / ARJay

Peer reviewed:
nil
---------------------------------------------------------------------------- */

#define SUPERCLASS ALIVE_fnc_baseClassHash
#define MAINCLASS ALIVE_fnc_commandHandler

private ["_logic","_operation","_args","_result"];

TRACE_1("groupHandler - input",_this);

_logic = [_this, 0, objNull, [objNull,[]]] call BIS_fnc_param;
_operation = [_this, 1, "", [""]] call BIS_fnc_param;
_args = [_this, 2, objNull, [objNull,[],"",0,true,false]] call BIS_fnc_param;
//_result = true;

#define MTEMPLATE "ALiVE_COMMANDHANDLER_%1"

switch(_operation) do {
    case "destroy": {
        [_logic, "debug", false] call MAINCLASS;
        if (isServer) then {
                [_logic, "destroy"] call SUPERCLASS;
        };
    };
    case "debug": {
        private["_tasks"];

        if(typeName _args != "BOOL") then {
                _args = [_logic,"debug"] call ALIVE_fnc_hashGet;
        } else {
                [_logic,"debug",_args] call ALIVE_fnc_hashSet;
        };
        ASSERT_TRUE(typeName _args == "BOOL",str _args);

        _result = _args;
    };
    case "init": {
        if (isServer) then {

            // if server, initialise module game logic
            [_logic,"super"] call ALIVE_fnc_hashRem;
            [_logic,"class",MAINCLASS] call ALIVE_fnc_hashSet;
            TRACE_1("After module init",_logic);

            // set defaults
            [_logic,"debug",false] call ALIVE_fnc_hashSet;

            waituntil {!(isnil "ALIVE_profileSystemInit")};

            [_logic,"listen"] call MAINCLASS;
        };
    };
    case "listen": {
        private["_listenerID"];

        _listenerID = [ALIVE_eventLog, "addListener",[_logic, [
            "INTEL_TYPE_SELECT",
            "INTEL_OPCOM_SELECT",
            "OPS_DATA_PREPARE",
            "OPS_OPCOM_SELECT",
            "OPS_GET_PROFILE",
            "OPS_GET_PROFILE_WAYPOINTS",
            "OPS_CLEAR_PROFILE_WAYPOINTS",
            "OPS_APPLY_PROFILE_WAYPOINTS",
            "OPS_JOIN_GROUP",
            "OPS_SPECTATE_GROUP"
            ]]] call ALIVE_fnc_eventLog;
        [_logic,"listenerID",_listenerID] call ALIVE_fnc_hashSet;
    };
    case "handleEvent": {
        private["_event","_type","_eventData"];

        if(typeName _args == "ARRAY") then {

            _event = _args;
            _type = [_event, "type"] call ALIVE_fnc_hashGet;
            _eventData = [_event, "data"] call ALIVE_fnc_hashGet;

            [_logic, _type, _eventData] call MAINCLASS;

        };
    };
    case "INTEL_TYPE_SELECT": {
        private["_debug","_eventData"];

        _debug = [_logic,"debug"] call ALIVE_fnc_hashGet;

        _eventData = _args;

        // DEBUG -------------------------------------------------------------------------------------
        if(_debug) then {
            ["----------------------------------------------------------------------------------------"] call ALIVE_fnc_dump;
            ["ALiVE Command Handler - Intel Type Selected event received"] call ALIVE_fnc_dump;
            _eventData call ALIVE_fnc_inspectArray;
        };
        // DEBUG -------------------------------------------------------------------------------------

        [_logic, "intelTypeSelected", _eventData] call MAINCLASS;

    };
    case "INTEL_OPCOM_SELECT": {
        private["_debug","_eventData"];

        _debug = [_logic,"debug"] call ALIVE_fnc_hashGet;

        _eventData = _args;

        // DEBUG -------------------------------------------------------------------------------------
        if(_debug) then {
            ["----------------------------------------------------------------------------------------"] call ALIVE_fnc_dump;
            ["ALiVE Command Handler - Intel OPCOM Selected event received"] call ALIVE_fnc_dump;
            _eventData call ALIVE_fnc_inspectArray;
        };
        // DEBUG -------------------------------------------------------------------------------------

        [_logic, "intelOPCOMSelected", _eventData] call MAINCLASS;

    };
    case "OPS_DATA_PREPARE": {
        private["_debug","_eventData"];

        _debug = [_logic,"debug"] call ALIVE_fnc_hashGet;

        _eventData = _args;

        // DEBUG -------------------------------------------------------------------------------------
        if(_debug) then {
            ["----------------------------------------------------------------------------------------"] call ALIVE_fnc_dump;
            ["ALiVE Command Handler - Operations Data Prepare event received"] call ALIVE_fnc_dump;
            _eventData call ALIVE_fnc_inspectArray;
        };
        // DEBUG -------------------------------------------------------------------------------------

        [_logic, "opsDataPrepare", _eventData] call MAINCLASS;

    };
    case "OPS_OPCOM_SELECT": {
        private["_debug","_eventData"];

        _debug = [_logic,"debug"] call ALIVE_fnc_hashGet;

        _eventData = _args;

        // DEBUG -------------------------------------------------------------------------------------
        if(_debug) then {
            ["----------------------------------------------------------------------------------------"] call ALIVE_fnc_dump;
            ["ALiVE Command Handler - Operations OPCOM Selected event received"] call ALIVE_fnc_dump;
            _eventData call ALIVE_fnc_inspectArray;
        };
        // DEBUG -------------------------------------------------------------------------------------

        [_logic, "opsOPCOMSelected", _eventData] call MAINCLASS;

    };
    case "OPS_GET_PROFILE": {
        private["_debug","_eventData"];

        _debug = [_logic,"debug"] call ALIVE_fnc_hashGet;

        _eventData = _args;

        // DEBUG -------------------------------------------------------------------------------------
        if(_debug) then {
            ["----------------------------------------------------------------------------------------"] call ALIVE_fnc_dump;
            ["ALiVE Command Handler - Operations Get Profile event received"] call ALIVE_fnc_dump;
            _eventData call ALIVE_fnc_inspectArray;
        };
        // DEBUG -------------------------------------------------------------------------------------

        [_logic, "opsGetProfile", _eventData] call MAINCLASS;

    };
    case "OPS_GET_PROFILE_WAYPOINTS": {
        private["_debug","_eventData"];

        _debug = [_logic,"debug"] call ALIVE_fnc_hashGet;

        _eventData = _args;

        // DEBUG -------------------------------------------------------------------------------------
        if(_debug) then {
            ["----------------------------------------------------------------------------------------"] call ALIVE_fnc_dump;
            ["ALiVE Command Handler - Operations Get Profile Waypoints event received"] call ALIVE_fnc_dump;
            _eventData call ALIVE_fnc_inspectArray;
        };
        // DEBUG -------------------------------------------------------------------------------------

        [_logic, "opsGetProfileWaypoints", _eventData] call MAINCLASS;

    };
    case "OPS_CLEAR_PROFILE_WAYPOINTS": {
        private["_debug","_eventData"];

        _debug = [_logic,"debug"] call ALIVE_fnc_hashGet;

        _eventData = _args;

        // DEBUG -------------------------------------------------------------------------------------
        if(_debug) then {
            ["----------------------------------------------------------------------------------------"] call ALIVE_fnc_dump;
            ["ALiVE Command Handler - Operations Clear Profile Waypoints event received"] call ALIVE_fnc_dump;
            _eventData call ALIVE_fnc_inspectArray;
        };
        // DEBUG -------------------------------------------------------------------------------------

        [_logic, "opsClearProfileWaypoints", _eventData] call MAINCLASS;

    };
    case "OPS_APPLY_PROFILE_WAYPOINTS": {
        private["_debug","_eventData"];

        _debug = [_logic,"debug"] call ALIVE_fnc_hashGet;

        _eventData = _args;

        // DEBUG -------------------------------------------------------------------------------------
        if(_debug) then {
            ["----------------------------------------------------------------------------------------"] call ALIVE_fnc_dump;
            ["ALiVE Command Handler - Operations Apply Profile Waypoints event received"] call ALIVE_fnc_dump;
            _eventData call ALIVE_fnc_inspectArray;
        };
        // DEBUG -------------------------------------------------------------------------------------

        [_logic, "opsApplyProfileWaypoints", _eventData] call MAINCLASS;

    };
    case "OPS_JOIN_GROUP": {
        private["_debug","_eventData"];

        _debug = [_logic,"debug"] call ALIVE_fnc_hashGet;

        _eventData = _args;

        // DEBUG -------------------------------------------------------------------------------------
        if(_debug) then {
            ["----------------------------------------------------------------------------------------"] call ALIVE_fnc_dump;
            ["ALiVE Command Handler - Operations Join Group event received"] call ALIVE_fnc_dump;
            _eventData call ALIVE_fnc_inspectArray;
        };
        // DEBUG -------------------------------------------------------------------------------------

        [_logic, "opsJoinGroup", _eventData] call MAINCLASS;

    };
    case "OPS_SPECTATE_GROUP": {
        private["_debug","_eventData"];

        _debug = [_logic,"debug"] call ALIVE_fnc_hashGet;

        _eventData = _args;

        // DEBUG -------------------------------------------------------------------------------------
        if(_debug) then {
            ["----------------------------------------------------------------------------------------"] call ALIVE_fnc_dump;
            ["ALiVE Command Handler - Operations Spectate Group event received"] call ALIVE_fnc_dump;
            _eventData call ALIVE_fnc_inspectArray;
        };
        // DEBUG -------------------------------------------------------------------------------------

        [_logic, "opsSpectateGroup", _eventData] call MAINCLASS;

    };
    case "opsDataPrepare": {
        private["_data","_playerID","_type","_limit","_side","_faction","_debug"];

        if(typeName _args == "ARRAY") then {

            _data = _args;
            _playerID = _data select 1;
            _limit = _data select 2;
            _side = _data select 3;
            _faction = _data select 4;

            _debug = [_logic,"debug"] call ALIVE_fnc_hashGet;

            private["_opcomData","_opcom","_opcomFactions","_opcomSide"];

            // get opcoms available by limit set on intel

            _opcomData = [];

            {
                _opcom = _x;
                _opcomFactions = [_opcom,"factions",""] call ALiVE_fnc_HashGet;
                _opcomSide = [_opcom,"side"] call ALIVE_fnc_hashGet;

                switch(_limit) do {
                    case "SIDE": {
                        if(_side == _opcomSide) then {
                            _opcomData pushBack (_opcomSide);
                        };
                    };
                    case "FACTION": {
                        if(_faction in _opcomFactions) then {
                            _opcomData pushBack (_opcomSide);
                        };
                    };
                    case "ALL": {
                        _opcomData pushBack (_opcomSide);
                    };
                };

            } foreach OPCOM_INSTANCES;

            // send the data back to the players SCOM tablet

            _event = ['SCOM_UPDATED', [_playerID,_opcomData], "COMMAND_HANDLER", "OPS_SIDES_AVAILABLE"] call ALIVE_fnc_event;
            [ALIVE_eventLog, "addEvent",_event] call ALIVE_fnc_eventLog;

        };
    };
    case "opsOPCOMSelected": {
        private["_data","_playerID","_side","_debug"];

        if(typeName _args == "ARRAY") then {

            _data = _args;
            _playerID = _data select 1;
            _side = _data select 2;

            _debug = [_logic,"debug"] call ALIVE_fnc_hashGet;

            private["_profileIDs","_groups","_opcom","_opcomSide","_data","_unitType"];

            // get groups state for the selected opcom

            _profileIDs = [ALIVE_profileHandler, "getProfilesBySide", _side] call ALIVE_fnc_profileHandler;

            _groups = [];

            {
                _opcom = _x;
                _opcomSide = [_opcom,"side"] call ALIVE_fnc_hashGet;

                if(_side == _opcomSide) then {

                    {
                        _data = [];
                        _unitType = [_opcom,_x,[]] call ALiVE_fnc_HashGet;
                        {
                            if (_x in _profileIDs) then {

                                _profile = [ALIVE_profileHandler, "getProfile", _x] call ALIVE_fnc_profileHandler;
                                if !(isnil "_profile") then {
                                    _position = _profile select 2 select 2;

                                    _data pushBack [_x,_position];
                                };
                            };
                        } forEach _unitType;
                        _groups pushBack _data;
                    } forEach ["infantry","motorized","mechanized","armored","air","sea","artillery","AAA"];

                };

            } foreach OPCOM_INSTANCES;

            // send the data back to the players SCOM tablet

            _event = ['SCOM_UPDATED', [_playerID,_side,_groups], "COMMAND_HANDLER", "OPS_GROUPS"] call ALIVE_fnc_event;
            [ALIVE_eventLog, "addEvent",_event] call ALIVE_fnc_eventLog;

        };
    };
    case "opsGetProfile": {
        private["_data","_playerID","_profileID","_debug"];

        if(typeName _args == "ARRAY") then {

            _data = _args;
            _playerID = _data select 1;
            _profileID = _data select 2;

            _debug = [_logic,"debug"] call ALIVE_fnc_hashGet;

            private["_profile","_profileData","_waypoints","_waypointPositions","_event"];

            // get profile

            _profile = [ALIVE_profileHandler, "getProfile", _profileID] call ALIVE_fnc_profileHandler;
            if !(isnil "_profile") then {

                // send the data back to the players SCOM tablet

                _profileData = [];
                _profileData pushBack (_profile select 2 select 1); // active
                _profileData pushBack (_profile select 2 select 3); // side
                _profileData pushBack (_profile select 2 select 2); // position
                _profileData pushBack (_profile select 2 select 13); // group

                _waypoints = _profile select 2 select 16;
                _waypointPositions = [];
                {
                    _waypointPositions pushBack ((_x select 2) select 0);
                } forEach _waypoints;

                _profileData pushBack _waypointPositions; // waypoints

                _event = ['SCOM_UPDATED', [_playerID,_profileData], "COMMAND_HANDLER", "OPS_PROFILE"] call ALIVE_fnc_event;
                [ALIVE_eventLog, "addEvent",_event] call ALIVE_fnc_eventLog;

            }else{

                _event = ['SCOM_UPDATED', [_playerID,[]], "COMMAND_HANDLER", "OPS_RESET"] call ALIVE_fnc_event;
                [ALIVE_eventLog, "addEvent",_event] call ALIVE_fnc_eventLog;

            };
        };
    };
    case "opsGetProfileWaypoints": {
        private["_data","_playerID","_profileID","_debug"];

        if(typeName _args == "ARRAY") then {

            _data = _args;
            _playerID = _data select 1;
            _profileID = _data select 2;

            _debug = [_logic,"debug"] call ALIVE_fnc_hashGet;

            private["_profile","_profileData","_waypoints","_waypointPositions","_event"];

            // get profile

            _profile = [ALIVE_profileHandler, "getProfile", _profileID] call ALIVE_fnc_profileHandler;
            if !(isnil "_profile") then {

                // send the data back to the players SCOM tablet

                _profileData = [];
                _profileData pushBack (_profile select 2 select 1); // active
                _profileData pushBack (_profile select 2 select 3); // side
                _profileData pushBack (_profile select 2 select 2); // position
                _profileData pushBack (_profile select 2 select 13); // group

                _waypoints = _profile select 2 select 16;
                _waypointsArray = [];
                {
                    _waypointsArray pushBack (_x select 2);
                } forEach _waypoints;

                _profileData pushBack _waypointsArray; // waypoints

                _event = ['SCOM_UPDATED', [_playerID,_profileData], "COMMAND_HANDLER", "OPS_PROFILE_WAYPOINTS"] call ALIVE_fnc_event;
                [ALIVE_eventLog, "addEvent",_event] call ALIVE_fnc_eventLog;

            }else{

                _event = ['SCOM_UPDATED', [_playerID,[]], "COMMAND_HANDLER", "OPS_RESET"] call ALIVE_fnc_event;
                [ALIVE_eventLog, "addEvent",_event] call ALIVE_fnc_eventLog;

            };
        };
    };
    case "opsClearProfileWaypoints": {
        private["_data","_playerID","_profileID"];

        if(typeName _args == "ARRAY") then {

            _data = _args;
            _playerID = _data select 1;
            _profileID = _data select 2;

            _debug = [_logic,"debug"] call ALIVE_fnc_hashGet;

            private["_profile","_profileData","_waypoints","_waypointPositions","_event"];

            // get profile

            _profile = [ALIVE_profileHandler, "getProfile", _profileID] call ALIVE_fnc_profileHandler;
            if !(isnil "_profile") then {

                // clear waypoints

                [_profile, 'clearWaypoints'] call ALIVE_fnc_profileEntity;

                // send the data back to the players SCOM tablet

                _profileData = [];
                _profileData pushBack (_profile select 2 select 1); // active
                _profileData pushBack (_profile select 2 select 3); // side
                _profileData pushBack (_profile select 2 select 2); // position
                _profileData pushBack (_profile select 2 select 13); // group
                _profileData pushBack []; // waypoints

                _event = ['SCOM_UPDATED', [_playerID,_profileData], "COMMAND_HANDLER", "OPS_PROFILE_WAYPOINTS_CLEARED"] call ALIVE_fnc_event;
                [ALIVE_eventLog, "addEvent",_event] call ALIVE_fnc_eventLog;

            }else{

                _event = ['SCOM_UPDATED', [_playerID,[]], "COMMAND_HANDLER", "OPS_RESET"] call ALIVE_fnc_event;
                [ALIVE_eventLog, "addEvent",_event] call ALIVE_fnc_eventLog;

            };
        };
    };
    case "opsApplyProfileWaypoints": {
        private["_data","_playerID","_profileID","_updatedWaypoints"];

        if(typeName _args == "ARRAY") then {

            _data = _args;
            _playerID = _data select 1;
            _profileID = _data select 2;
            _updatedWaypoints = _data select 3;

            _debug = [_logic,"debug"] call ALIVE_fnc_hashGet;

            private["_profile","_profileData","_waypoints","_waypointsArray","_waypointData","_event","_profilePos","_wp",
            "_waypointType","_waypointPosition"];

            // get profile

            _profile = [ALIVE_profileHandler, "getProfile", _profileID] call ALIVE_fnc_profileHandler;
            if !(isnil "_profile") then {

                // set busy

                [_profile,"busy",true] call ALIVE_fnc_profileEntity;

                // clear waypoints

                [_profile, "clearWaypoints"] call ALIVE_fnc_profileEntity;

                {
                    _waypointData = _x;

                    _waypointType = _waypointData select 2;

                    if(_waypointType == "LAND OFF" || _waypointType == "LAND HOVER") then {

                        _waypointPosition = _waypointData select 0;

                        _wp = [_waypointPosition,15] call ALIVE_fnc_createProfileWaypoint;

                        [_profile,"addWaypoint",_wp] call ALIVE_fnc_profileEntity;

                        _helipad = "Land_HelipadEmpty_F" createVehicle _waypointPosition;

                        [_profile,_helipad,_waypointType] spawn {
                            private["_profile","_helipad","_type","_timeTaken","_group","_waypointType","_waypointPosition"];
                            _this params ["_profile","_helipad","_waypointType"];
                            _timeTaken = time;
                            waitUntil {sleep 5;([_profile,"active"] call ALiVE_fnc_hashGet or {time - _timeTaken > 600})};
                            if ([_profile,"active"] call ALiVE_fnc_hashGet) then {
                                _group = _profile select 2 select 13;
                                waitUntil {sleep 2;unitReady (leader _group)};
                                [_profile, 'clearWaypoints'] call ALIVE_fnc_profileEntity;	//-- Needed because waypoint doesn't seem to complete when you use land command
                                if (_waypointType == "LAND OFF") then {(vehicle (leader _group)) land "LAND"} else {(vehicle (leader _group)) land "GET OUT"};
                                sleep 60;
                                deleteVehicle _helipad;
                            } else {deleteVehicle _helipad};

                        };

                    }else{

                        _wp = [_waypointData select 0] call ALIVE_fnc_createProfileWaypoint;

                        _wp set [2,_waypointData];

                        [_profile,"addWaypoint",_wp] call ALIVE_fnc_profileEntity;

                    };

                } foreach _updatedWaypoints;

                _profileData = [];
                _profileData pushBack (_profile select 2 select 1); // active
                _profileData pushBack (_profile select 2 select 3); // side
                _profileData pushBack (_profile select 2 select 2); // position
                _profileData pushBack (_profile select 2 select 13); // group

                _waypoints = _profile select 2 select 16;
                _waypointsArray = [];
                {
                    _waypointsArray pushBack (_x select 2);
                } forEach _waypoints;

                _profileData pushBack _waypointsArray; // waypoints

                _event = ['SCOM_UPDATED', [_playerID,_profileData], "COMMAND_HANDLER", "OPS_PROFILE_WAYPOINTS_UPDATED"] call ALIVE_fnc_event;
                [ALIVE_eventLog, "addEvent",_event] call ALIVE_fnc_eventLog;

            }else{

                _event = ['SCOM_UPDATED', [_playerID,[]], "COMMAND_HANDLER", "OPS_RESET"] call ALIVE_fnc_event;
                [ALIVE_eventLog, "addEvent",_event] call ALIVE_fnc_eventLog;

            };
        };
    };
    case "opsJoinGroup": {
        private["_data","_playerID","_profileID","_debug"];

        if(typeName _args == "ARRAY") then {

            _data = _args;
            _playerID = _data select 1;
            _profileID = _data select 2;

            _debug = [_logic,"debug"] call ALIVE_fnc_hashGet;

            private["_profile","_faction","_position","_vehiclesInCommandOf","_event","_player","_group"];

            // get profile

            _profile = [ALIVE_profileHandler, "getProfile", _profileID] call ALIVE_fnc_profileHandler;
            if !(isnil "_profile") then {

                _faction = _profile select 2 select 29;
                _position = _profile select 2 select 2;
                _vehiclesInCommandOf = _profile select 2 select 8;

                if(count _vehiclesInCommandOf == 0) then {

                    _position = [_position, 50, random 360] call BIS_fnc_relPos;

                    if(surfaceIsWater _position) then {
                        _position = [_position] call ALIVE_fnc_getClosestLand;
                    };

                    _player = [_playerID] call ALIVE_fnc_getPlayerByUID;

                    _player hideObjectGlobal true;

                    _player setPos _position;

                    waitUntil{_profile select 2 select 1};

                    sleep 2;

                    _group = _profile select 2 select 13;
                    _unit = (units _group) call BIS_fnc_selectRandom;

                    _event = ['SCOM_UPDATED', [_playerID,[_unit]], "COMMAND_HANDLER", "OPS_GROUP_JOIN_READY"] call ALIVE_fnc_event;
                    [ALIVE_eventLog, "addEvent",_event] call ALIVE_fnc_eventLog;


                }else{

                    _event = ['SCOM_UPDATED', [_playerID,[]], "COMMAND_HANDLER", "OPS_RESET"] call ALIVE_fnc_event;
                    [ALIVE_eventLog, "addEvent",_event] call ALIVE_fnc_eventLog;

                };

            }else{

                _event = ['SCOM_UPDATED', [_playerID,[]], "COMMAND_HANDLER", "OPS_RESET"] call ALIVE_fnc_event;
                [ALIVE_eventLog, "addEvent",_event] call ALIVE_fnc_eventLog;

            };
        };
    };
    case "opsSpectateGroup": {
        private["_data","_playerID","_profileID","_debug"];

        if(typeName _args == "ARRAY") then {

            _data = _args;
            _playerID = _data select 1;
            _profileID = _data select 2;

            _debug = [_logic,"debug"] call ALIVE_fnc_hashGet;

            private["_profile","_faction","_position","_vehiclesInCommandOf","_event","_player","_group"];

            // get profile

            _profile = [ALIVE_profileHandler, "getProfile", _profileID] call ALIVE_fnc_profileHandler;
            if !(isnil "_profile") then {

                _faction = _profile select 2 select 29;
                _position = _profile select 2 select 2;
                _vehiclesInCommandOf = _profile select 2 select 8;

                _position = [_position, 50, random 360] call BIS_fnc_relPos;

                if(surfaceIsWater _position) then {
                    _position = [_position] call ALIVE_fnc_getClosestLand;
                };

                _player = [_playerID] call ALIVE_fnc_getPlayerByUID;

                _player hideObjectGlobal true;

                _player setPos _position;

                waitUntil{_profile select 2 select 1};

                sleep 2;

                _group = _profile select 2 select 13;
                _unit = (units _group) call BIS_fnc_selectRandom;

                _event = ['SCOM_UPDATED', [_playerID,[_unit]], "COMMAND_HANDLER", "OPS_GROUP_SPECTATE_READY"] call ALIVE_fnc_event;
                [ALIVE_eventLog, "addEvent",_event] call ALIVE_fnc_eventLog;


            }else{

                _event = ['SCOM_UPDATED', [_playerID,[]], "COMMAND_HANDLER", "OPS_RESET"] call ALIVE_fnc_event;
                [ALIVE_eventLog, "addEvent",_event] call ALIVE_fnc_eventLog;

            };
        };
    };

    case "intelTypeSelected": {
        private["_data","_playerID","_type","_limit","_side","_faction","_debug"];

        if(typeName _args == "ARRAY") then {

            _data = _args;
            _playerID = _data select 1;
            _type = _data select 2;
            _limit = _data select 3;
            _side = _data select 4;
            _faction = _data select 5;

            _debug = [_logic,"debug"] call ALIVE_fnc_hashGet;

            switch(_type) do {
                case "Objectives": {

                    private["_objectiveData","_opcom","_opcomFactions","_opcomSide"];

                    // get opcoms available by limit set on intel

                    _opcomData = [];

                    {
                        _opcom = _x;
                        _opcomFactions = [_opcom,"factions",""] call ALiVE_fnc_HashGet;
                        _opcomSide = [_opcom,"side"] call ALIVE_fnc_hashGet;

                        switch(_limit) do {
                            case "SIDE": {
                                if(_side == _opcomSide) then {
                                    _opcomData pushBack (_opcomSide);
                                };
                            };
                            case "FACTION": {
                                if(_faction in _opcomFactions) then {
                                    _opcomData pushBack (_opcomSide);
                                };
                            };
                            case "ALL": {
                                _opcomData pushBack (_opcomSide);
                            };
                        };

                    } foreach OPCOM_INSTANCES;

                    // send the data back to the players SCOM tablet

                    _event = ['SCOM_UPDATED', [_playerID,_opcomData], "COMMAND_HANDLER", "OPCOM_SIDES_AVAILABLE"] call ALIVE_fnc_event;
                    [ALIVE_eventLog, "addEvent",_event] call ALIVE_fnc_eventLog;
                };

                case "Marking": {

                    private["_profilesInactive","_entities","_entitiesWest","_entitiesEast","_entitiesGuer","_profiles","_type","_profilePosition","_profileSide","_profileFaction"];

                    // get inactive profiles available by limit set on intel

                    _profilesInactive = [ALIVE_profileHandler, "profilesInActiveBySide"] call ALIVE_fnc_hashGet;

                    switch(_limit) do {
                        case "SIDE": {
                            _entities = [_profilesInactive, _side] call ALIVE_fnc_hashGet;
                            _entities = _entities select 2;
                        };
                        case "FACTION": {
                            _entities = [_profilesInactive, _side] call ALIVE_fnc_hashGet;
                            _entities = _entities select 2;
                        };
                        case "ALL": {
                            _entitiesWest = [_profilesInactive, "WEST"] call ALIVE_fnc_hashGet;
                            _entitiesWest = _entitiesWest select 2;
                            _entitiesEast = [_profilesInactive, "EAST"] call ALIVE_fnc_hashGet;
                            _entitiesEast = _entitiesEast select 2;
                            _entitiesGuer = [_profilesInactive, "GUER"] call ALIVE_fnc_hashGet;
                            _entitiesGuer = _entitiesGuer select 2;

                            _entities = _entitiesWest;
                            _entities = _entities + _entitiesEast;
                            _entities = _entities + _entitiesGuer;
                        };
                    };

                    _profiles = [];
                    {
                        _type = _x select 2 select 5;

                        if(_type == "entity") then {

                            _profilePosition = _x select 2 select 2;
                            _profileSide = _x select 2 select 3;
                            _profileFaction = _x select 2 select 29;

                            if(_limit == "FACTION" && {_faction == _profileFaction}) then {
                                _profiles pushback [_profilePosition,_profileSide];
                            }else{
                                _profiles pushback [_profilePosition,_profileSide];
                            };
                        };

                    } forEach _entities;

                    // send the data back to the players SCOM tablet

                    _event = ['SCOM_UPDATED', [_playerID,_profiles], "COMMAND_HANDLER", "UNIT_MARKING"] call ALIVE_fnc_event;
                    [ALIVE_eventLog, "addEvent",_event] call ALIVE_fnc_eventLog;

                };
            };

        };
    };
    case "intelOPCOMSelected": {
        private["_data","_playerID","_side","_debug"];

        if(typeName _args == "ARRAY") then {

            _data = _args;
            _playerID = _data select 1;
            _side = _data select 2;

            _debug = [_logic,"debug"] call ALIVE_fnc_hashGet;

            private["_objectiveData","_opcom","_opcomSide","_center","_size","_tacom_state","_opcom_state","_section","_profileID","_profile","_position","_sections"];

            // get objective state by selected opcom

            _objectiveData = [];

            {
                _opcom = _x;
                _opcomSide = [_opcom,"side"] call ALIVE_fnc_hashGet;

                if(_side == _opcomSide) then {

                    {
                        _center = [_x,"center",[]] call ALIVE_fnc_hashGet;
                        _size = [_x,"size",150] call ALIVE_fnc_hashGet;
                        _tacom_state = [_x,"tacom_state","unassigned"] call ALIVE_fnc_hashGet;
                        _opcom_state = [_x,"opcom_state","unassigned"] call ALIVE_fnc_hashGet;
                        _section = [_x,"section"] call ALIVE_fnc_hashGet;

                        if!(isNil "_section") then {

                            _sections = [];

                            {
                                _profileID = _x;
                                _profile = [ALIVE_profileHandler, "getProfile", _profileID] call ALIVE_fnc_profileHandler;
                                if !(isnil "_profile") then {
                                    _position = _profile select 2 select 2;

                                    if!(surfaceIsWater _position) then {
                                        _dir = [_position, _center] call BIS_fnc_dirTo;
                                        _sections pushBack [_position,_dir];
                                    };

                                };
                            } forEach _section;
                        };

                        _objectiveData pushBack [_size,_center,_tacom_state,_opcom_state,_sections];

                    } forEach ([_opcom,"objectives",[]] call ALiVE_fnc_HashGet);

                };

            } foreach OPCOM_INSTANCES;

            // send the data back to the players SCOM tablet

            _event = ['SCOM_UPDATED', [_playerID,_objectiveData], "COMMAND_HANDLER", "OPCOM_OBJECTIVES"] call ALIVE_fnc_event;
            [ALIVE_eventLog, "addEvent",_event] call ALIVE_fnc_eventLog;

        };
    };
    default {
        _result = [_logic, _operation, _args] call SUPERCLASS;
    };
};
TRACE_1("commandHandler - output",_result);

if !(isnil "_result") then {_result} else {nil};