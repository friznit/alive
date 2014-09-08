#include <\x\alive\addons\mil_C2ISTAR\script_component.hpp>
SCRIPT(taskTransportInsertion);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_taskTransportInsertion

Description:
Transport insertion

Parameters:

Returns:

Examples:
(begin example)
(end)

See Also:

Author:
ARJay
---------------------------------------------------------------------------- */

private ["_taskState","_taskID","_task","_params","_debug","_result","_nextState"];

_taskState = _this select 0;
_taskID = _this select 1;
_task = _this select 2;
_params = _this select 3;
_debug = _this select 4;
_result = [];

switch (_taskState) do {
	case "init":{

	    private["_taskID","_requestPlayerID","_taskSide","_taskFaction","_taskLocationType","_taskLocation","_taskEnemyFaction","_taskCurrent",
	    "_taskApplyType","_taskEnemySide","_enemyClusters","_pickupPosition","_insertionPosition"];

        _taskID = _task select 0;
        _requestPlayerID = _task select 1;
        _taskSide = _task select 2;
        _taskFaction = _task select 3;
        _taskLocationType = _task select 5;
        _taskLocation = _task select 6;
        _taskPlayers = _task select 7;
        _taskEnemyFaction = _task select 8;
        _taskCurrent = _task select 9;
        _taskApplyType = _task select 10;

        _taskEnemySide = _taskEnemyFaction call ALiVE_fnc_factionSide;
        _taskEnemySide = [_taskEnemySide] call ALIVE_fnc_sideObjectToNumber;
        _taskEnemySide = [_taskEnemySide] call ALIVE_fnc_sideNumberToText;

        _task call ALIVE_fnc_inspectArray;

        // establish the location for the pickup task
        // get friendly military cluster

        _pickupPosition = [_taskLocation,_taskLocationType,_taskSide,"MIL"] call ALIVE_fnc_taskGetSideCluster;

        if(count _pickupPosition == 0) then {

            // no enemy occupied cluster found
            // try to get a position containing enemy

            _pickupPosition = [_taskLocation,_taskLocationType,_taskSide] call ALIVE_fnc_taskGetSideSectorCompositionPosition;

            // spawn a populated composition

            [_targetPosition, "objectives", _taskFaction, 2] call ALIVE_fnc_spawnRandomPopulatedComposition;

        };

        // establish the location for the insertion task
        // get enemy military cluster

        _insertionPosition = [_taskLocation,_taskLocationType,_taskEnemySide,"MIL"] call ALIVE_fnc_taskGetSideCluster;

        if(count _insertionPosition == 0) then {

            // no enemy occupied cluster found
            // try to get a position containing enemy

            _insertionPosition = [_taskLocation,_taskLocationType,_taskEnemySide] call ALIVE_fnc_taskGetSideSectorCompositionPosition;

            // spawn a populated composition

            [_targetPosition, "objectives", _taskEnemyFaction, 2] call ALIVE_fnc_spawnRandomPopulatedComposition;

        };

        if(!(isNil "_pickupPosition") && !(isNil "_insertionPosition")) then {

            private["_stagingPosition","_dialogOptions","_dialogOption","_group","_profile"];

            // establish the staging position for the task

            _insertionPosition = [_insertionPosition,"overwatch"] call ALIVE_fnc_taskGetSectorPosition;

            // create the group profile for transporting

            _group = ["Infantry",_taskFaction] call ALIVE_fnc_configGetRandomGroup;

            //_profile = [_group, _pickupPosition, random(360), true, _taskFaction, true] call ALIVE_fnc_createProfilesFromGroupConfig;
            _profile = ["BUS_InfSquad", _pickupPosition, random(360), true, _taskFaction, true] call ALIVE_fnc_createProfilesFromGroupConfig;

            _profileID = _profile select 0 select 2 select 4;

            // select the random text

            _dialogOptions = [ALIVE_generatedTasks,"TransportInsertion"] call ALIVE_fnc_hashGet;
            _dialogOptions = _dialogOptions select 1;
            _dialogOption = _dialogOptions call BIS_fnc_selectRandom;

            // format the dialog options

            private["_nearestTown","_dialog","_formatDescription","_formatChat","_formatMessage","_formatMessageText"];

            _nearestTown = [_pickupPosition] call ALIVE_fnc_taskGetNearestLocationName;

            _dialog = [_dialogOption,"Pickup"] call ALIVE_fnc_hashGet;

            _formatDescription = [_dialog,"description"] call ALIVE_fnc_hashGet;
            _formatDescription = format[_formatDescription,_nearestTown];
            [_dialog,"description",_formatDescription] call ALIVE_fnc_hashSet;

            _formatChat = [_dialog,"chat_start"] call ALIVE_fnc_hashGet;
            _formatMessage = _formatChat select 0;
            _formatMessageText = _formatMessage select 1;
            _formatMessageText = format[_formatMessageText,_nearestTown];
            _formatMessage set [1,_formatMessageText];
            _formatChat set [0,_formatMessage];
            [_dialog,"chat_start",_formatChat] call ALIVE_fnc_hashGet;

            _nearestTown = [_insertionPosition] call ALIVE_fnc_taskGetNearestLocationName;

            _dialog = [_dialogOption,"Insertion"] call ALIVE_fnc_hashGet;

            _formatDescription = [_dialog,"description"] call ALIVE_fnc_hashGet;
            _formatDescription = format[_formatDescription,_nearestTown];
            [_dialog,"description",_formatDescription] call ALIVE_fnc_hashSet;

            _formatChat = [_dialog,"chat_start"] call ALIVE_fnc_hashGet;
            _formatMessage = _formatChat select 0;
            _formatMessageText = _formatMessage select 1;
            _formatMessageText = format[_formatMessageText,_nearestTown];
            _formatMessage set [1,_formatMessageText];
            _formatChat set [0,_formatMessage];
            [_dialog,"chat_start",_formatChat] call ALIVE_fnc_hashGet;

            // create the tasks

            private["_state","_tasks","_taskIDs","_dialog","_taskTitle","_taskDescription","_newTask","_newTaskID","_taskParams"];

            if(_taskCurrent == 'Y')then {
                _state = "Assigned";
            }else{
                _state = "Created";
            };

            _tasks = [];
            _taskIDs = [];

            // create the parent task

            _dialog = [_dialogOption,"Parent"] call ALIVE_fnc_hashGet;
            _taskTitle = [_dialog,"title"] call ALIVE_fnc_hashGet;
            _taskDescription = [_dialog,"description"] call ALIVE_fnc_hashGet;
            _taskSource = format["%1-TransportInsertion-Parent",_taskID];
            _newTask = [_taskID,_requestPlayerID,_taskSide,_insertionPosition,_taskFaction,_taskTitle,_taskDescription,_taskPlayers,_state,_taskApplyType,"N","None",_taskSource,false];

            _tasks set [count _tasks,_newTask];
            _taskIDs set [count _taskIDs,_taskID];

            // create the pickup task

            _dialog = [_dialogOption,"Pickup"] call ALIVE_fnc_hashGet;
            _taskTitle = [_dialog,"title"] call ALIVE_fnc_hashGet;
            _taskDescription = [_dialog,"description"] call ALIVE_fnc_hashGet;
            _newTaskID = format["%1_c1",_taskID];
            _taskSource = format["%1-TransportInsertion-Pickup",_taskID];
            _newTask = [_newTaskID,_requestPlayerID,_taskSide,_pickupPosition,_taskFaction,_taskTitle,_taskDescription,_taskPlayers,_state,_taskApplyType,_taskCurrent,_taskID,_taskSource,false];

            _tasks set [count _tasks,_newTask];
            _taskIDs set [count _taskIDs,_newTaskID];

            // create the insertion task

            _dialog = [_dialogOption,"Insertion"] call ALIVE_fnc_hashGet;
            _taskTitle = [_dialog,"title"] call ALIVE_fnc_hashGet;
            _taskDescription = [_dialog,"description"] call ALIVE_fnc_hashGet;
            _newTaskID = format["%1_c2",_taskID];
            _taskSource = format["%1-TransportInsertion-Insertion",_taskID];
            _newTask = [_newTaskID,_requestPlayerID,_taskSide,_insertionPosition,_taskFaction,_taskTitle,_taskDescription,_taskPlayers,"Created",_taskApplyType,"N",_taskID,_taskSource,true];

            _tasks set [count _tasks,_newTask];
            _taskIDs set [count _taskIDs,_newTaskID];

            // store task data in the params for this task set

            _taskParams = [] call ALIVE_fnc_hashCreate;
            [_taskParams,"nextTask",_taskIDs select 1] call ALIVE_fnc_hashSet;
            [_taskParams,"taskIDs",_taskIDs] call ALIVE_fnc_hashSet;
            [_taskParams,"dialog",_dialogOption] call ALIVE_fnc_hashSet;
            [_taskParams,"enemyFaction",_taskEnemyFaction] call ALIVE_fnc_hashSet;
            [_taskParams,"profileID",_profileID] call ALIVE_fnc_hashSet;
            [_taskParams,"pickupReached",false] call ALIVE_fnc_hashSet;
            [_taskParams,"insertionReached",false] call ALIVE_fnc_hashSet;
            [_taskParams,"lastState",""] call ALIVE_fnc_hashSet;

            // return the created tasks and params

            _result = [_tasks,_taskParams];

        };

	};
	case "Parent":{

    };
	case "Pickup":{

	    private["_taskID","_requestPlayerID","_taskSide","_taskPosition","_taskFaction","_taskTitle","_taskDescription","_taskPlayers",
	    "_taskIDs","_lastState","_taskDialog","_profileID","_currentTaskDialog","_pickupReached"];

	    _taskID = _task select 0;
        _requestPlayerID = _task select 1;
        _taskSide = _task select 2;
        _taskPosition = _task select 3;
        _taskFaction = _task select 4;
        _taskTitle = _task select 5;
        _taskDescription = _task select 6;
        _taskPlayers = _task select 7 select 0;

        _lastState = [_params,"lastState"] call ALIVE_fnc_hashGet;
        _taskDialog = [_params,"dialog"] call ALIVE_fnc_hashGet;
        _profileID = [_params,"profileID"] call ALIVE_fnc_hashGet;
        _pickupReached = [_params,"pickupReached"] call ALIVE_fnc_hashGet;
        _currentTaskDialog = [_taskDialog,_taskState] call ALIVE_fnc_hashGet;

        if(_lastState != "Pickup") then {

            ["chat_start",_currentTaskDialog,_taskSide,_taskPlayers] call ALIVE_fnc_taskCreateRadioBroadcastForPlayers;

            [_params,"lastState","Pickup"] call ALIVE_fnc_hashSet;
        };

        if!(_pickupReached) then {

            private["_infantryProfile","_destinationReached","_infantryGroup","_nearVehicles","_vehicles","_vehicle","_assignments","_maxRoomVehicle","_room"];

            _infantryProfile = [ALIVE_profileHandler, "getProfile", _profileID] call ALIVE_fnc_profileHandler;
            if!(isNil "_infantryProfile") then {

                _destinationReached = [_taskPosition,_taskPlayers,200] call ALIVE_fnc_taskHavePlayersReachedDestination;

                if(_destinationReached) then {

                    _infantryGroup = _infantryProfile select 2 select 13;

                    _nearVehicles = [_taskPosition,_taskPlayers,200] call ALIVE_fnc_taskGetNearPlayerVehicles;

                    _vehicles = [_nearVehicles,_infantryGroup] call ALIVE_fnc_taskDoVehiclesHaveRoomForGroup;

                    if(count _vehicles > 0) then {
                        _vehicle = _vehicles select 0;

                        _assignments = [_infantryGroup, _vehicle, true] call ALIVE_fnc_vehicleAssignGroup;

                        [_params,"pickupReached",true] call ALIVE_fnc_hashSet;
                        [_params,"vehicle",_vehicle] call ALIVE_fnc_hashSet;
                        [_params,"assignments",_assignments] call ALIVE_fnc_hashSet;
                    }else{

                        _vehicle = [_nearVehicles] call ALIVE_fnc_taskGetVehicleWithMaxRoom;

                        _maxRoomVehicle = _vehicle select 0;

                        if!(isNull _maxRoomVehicle) then {

                            _room = _vehicle select 1;

                            [_infantryProfile,"resize",_room] call ALIVE_fnc_profileEntity;

                            _infantryGroup = _infantryProfile select 2 select 13;

                            _assignments = [_infantryGroup, _maxRoomVehicle, true] call ALIVE_fnc_vehicleAssignGroup;

                            [_params,"pickupReached",true] call ALIVE_fnc_hashSet;
                            [_params,"vehicle",_maxRoomVehicle] call ALIVE_fnc_hashSet;
                            [_params,"assignments",_assignments] call ALIVE_fnc_hashSet;

                        }else{

                            [_infantryProfile,"busy",false] call ALIVE_fnc_profileEntity;

                            [_params,"nextTask",""] call ALIVE_fnc_hashSet;

                            _task set [8,"Failed"];
                            _task set [10, "N"];
                            _result = _task;

                            ["chat_failed",_currentTaskDialog,_taskSide,_taskPlayers] call ALIVE_fnc_taskCreateRadioBroadcastForPlayers;

                        };

                    }

                };

            }else{

                [_params,"nextTask",""] call ALIVE_fnc_hashSet;

                _task set [8,"Cancelled"];
                _task set [10, "N"];
                _result = _task;

                ["chat_cancelled",_currentTaskDialog,_taskSide,_taskPlayers] call ALIVE_fnc_taskCreateRadioBroadcastForPlayers;

            };

        }else{

            private["_infantryProfile","_units","_loaded","_vehicle"];

            _infantryProfile = [ALIVE_profileHandler, "getProfile", _profileID] call ALIVE_fnc_profileHandler;
            if!(isNil "_infantryProfile") then {

                _units = _infantryProfile select 2 select 21;

                _loaded = [_units] call ALIVE_fnc_taskHaveUnitsLoadedInVehicle;

                if(_loaded) then {

                    _taskIDs = [_params,"taskIDs"] call ALIVE_fnc_hashGet;
                    [_params,"nextTask",_taskIDs select 2] call ALIVE_fnc_hashSet;

                    _task set [8,"Succeeded"];
                    _task set [10, "N"];
                    _result = _task;

                };

            }else{

                [_params,"nextTask",""] call ALIVE_fnc_hashSet;

                _task set [8,"Cancelled"];
                _task set [10, "N"];
                _result = _task;

                ["chat_cancelled",_currentTaskDialog,_taskSide,_taskPlayers] call ALIVE_fnc_taskCreateRadioBroadcastForPlayers;

            };

        };

    };
    case "Insertion":{

        private["_taskID","_requestPlayerID","_taskSide","_taskPosition","_taskFaction","_taskTitle","_taskDescription","_taskPlayers",
        "_areaClear","_lastState","_taskDialog","_insertionReached","_currentTaskDialog"];

        _taskID = _task select 0;
        _requestPlayerID = _task select 1;
        _taskSide = _task select 2;
        _taskPosition = _task select 3;
        _taskFaction = _task select 4;
        _taskTitle = _task select 5;
        _taskDescription = _task select 6;
        _taskPlayers = _task select 7 select 0;

        _lastState = [_params,"lastState"] call ALIVE_fnc_hashGet;
        _taskDialog = [_params,"dialog"] call ALIVE_fnc_hashGet;
        _insertionReached = [_params,"insertionReached"] call ALIVE_fnc_hashGet;
        _currentTaskDialog = [_taskDialog,_taskState] call ALIVE_fnc_hashGet;

        if(_lastState != "Insertion") then {

            ["chat_start",_currentTaskDialog,_taskSide,_taskPlayers] call ALIVE_fnc_taskCreateRadioBroadcastForPlayers;

            [_params,"lastState","Insertion"] call ALIVE_fnc_hashSet;
        };

        if!(_insertionReached) then {

            private["_profileID","_infantryProfile","_destinationReached","_infantryGroup","_assignments","_vehicle"];

            _vehicle = [_params,"vehicle"] call ALIVE_fnc_hashGet;

            if!(alive _vehicle) then {

                [_params,"nextTask",""] call ALIVE_fnc_hashSet;

                _task set [8,"Failed"];
                _task set [10, "N"];
                _result = _task;

                ["chat_failed",_currentTaskDialog,_taskSide,_taskPlayers] call ALIVE_fnc_taskCreateRadioBroadcastForPlayers;

            }else{

                _destinationReached = [_taskPosition,_taskPlayers,300] call ALIVE_fnc_taskHavePlayersReachedDestination;

                if(_destinationReached) then {

                    _profileID = [_params,"profileID"] call ALIVE_fnc_hashGet;

                    _infantryProfile = [ALIVE_profileHandler, "getProfile", _profileID] call ALIVE_fnc_profileHandler;
                    if!(isNil "_infantryProfile") then {

                        _infantryGroup = _infantryProfile select 2 select 13;

                        _assignments = [_params,"assignments"] call ALIVE_fnc_hashGet;
                        [_assignments, _vehicle] call ALIVE_fnc_vehicleDismount;

                        [_params,"insertionReached",true] call ALIVE_fnc_hashSet;

                    }else{

                        [_params,"nextTask",""] call ALIVE_fnc_hashSet;

                        _task set [8,"Failed"];
                        _task set [10, "N"];
                        _result = _task;

                        ["chat_failed",_currentTaskDialog,_taskSide,_taskPlayers] call ALIVE_fnc_taskCreateRadioBroadcastForPlayers;

                    };

                };

            };

        }else{

            private["_profileID","_infantryProfile","_units","_unloaded"];

            _profileID = [_params,"profileID"] call ALIVE_fnc_hashGet;

            _infantryProfile = [ALIVE_profileHandler, "getProfile", _profileID] call ALIVE_fnc_profileHandler;
            if!(isNil "_infantryProfile") then {

                _units = _infantryProfile select 2 select 21;

                _unloaded = [_units] call ALIVE_fnc_taskHaveUnitsUnloadedFromVehicle;

                if(_unloaded) then {

                    [_infantryProfile,"busy",false] call ALIVE_fnc_profileEntity;

                    [_params,"nextTask",""] call ALIVE_fnc_hashSet;

                    _task set [8,"Succeeded"];
                    _task set [10, "N"];
                    _result = _task;

                    ["chat_success",_currentTaskDialog,_taskSide,_taskPlayers] call ALIVE_fnc_taskCreateRadioBroadcastForPlayers;

                };

            }else{

                [_params,"nextTask",""] call ALIVE_fnc_hashSet;

                _task set [8,"Failed"];
                _task set [10, "N"];
                _result = _task;

                ["chat_failed",_currentTaskDialog,_taskSide,_taskPlayers] call ALIVE_fnc_taskCreateRadioBroadcastForPlayers;

            };

        };

    };
};

_result