#include <\x\alive\addons\mil_C2ISTAR\script_component.hpp>
SCRIPT(taskAssassination);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_taskAssassination

Description:
Assault Task

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
	    "_taskApplyType","_taskEnemySide","_enemyClusters","_targetPosition"];

        _taskID = _task select 0;
        _requestPlayerID = _task select 1;
        _taskSide = _task select 2;
        _taskFaction = _task select 3;
        _taskLocationType = _task select 5;
        _taskLocation = _task select 6;
        _taskPlayers = _task select 7;
        _taskEnemyFaction = _task select 8;
        _taskCurrent = _taskData select 9;
        _taskApplyType = _taskData select 10;

        _taskEnemySide = _taskEnemyFaction call ALiVE_fnc_factionSide;
        _taskEnemySide = [_taskEnemySide] call ALIVE_fnc_sideObjectToNumber;
        _taskEnemySide = [_taskEnemySide] call ALIVE_fnc_sideNumberToText;

        // establish the location for the task
        // get enemy occupied cluster position

        _targetPosition = [_taskLocation,_taskLocationType,_taskEnemySide] call ALIVE_fnc_taskGetEnemyCluster;

        if(count _targetPosition == 0) then {

            // no enemy occupied cluster found
            // try to get a position containing enemy

            _targetPosition = [_taskLocation,_taskLocationType,_taskEnemySide] call ALIVE_fnc_taskGetEnemySectorCompositionPosition;

            // spawn a populated composition

            [_targetPosition, "objectives", _taskEnemyFaction, 2] call ALIVE_fnc_spawnRandomPopulatedComposition;

        };

        if!(isNil "_targetPosition") then {

            private["_dialogOptions","_dialogOption"];

            // select the random text

            _dialogOptions = [ALIVE_generatedTasks,"Assassination"] call ALIVE_fnc_hashGet;
            _dialogOptions = _dialogOptions select 1;
            _dialogOption = _dialogOptions call BIS_fnc_selectRandom;

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
            _taskSource = format["%1-Assassination-Parent",_taskID];
            _newTask = [_taskID,_requestPlayerID,_taskSide,_targetPosition,_taskFaction,_taskTitle,_taskDescription,_taskPlayers,_state,_taskApplyType,"N","None",_taskSource,false];

            _tasks set [count _tasks,_newTask];
            _taskIDs set [count _taskIDs,_taskID];

            // create the destroy task

            _dialog = [_dialogOption,"Destroy"] call ALIVE_fnc_hashGet;
            _taskTitle = [_dialog,"title"] call ALIVE_fnc_hashGet;
            _taskDescription = [_dialog,"description"] call ALIVE_fnc_hashGet;
            _newTaskID = format["%1_c1",_taskID];
            _taskSource = format["%1-Assassination-Destroy",_taskID];
            _newTask = [_newTaskID,_requestPlayerID,_taskSide,_targetPosition,_taskFaction,_taskTitle,_taskDescription,_taskPlayers,_state,_taskApplyType,_taskCurrent,_taskID,_taskSource,true];

            _tasks set [count _tasks,_newTask];
            _taskIDs set [count _taskIDs,_newTaskID];

            // store task data in the params for this task set

            _taskParams = [] call ALIVE_fnc_hashCreate;
            [_taskParams,"nextTask",_taskIDs select 1] call ALIVE_fnc_hashSet;
            [_taskParams,"taskIDs",_taskIDs] call ALIVE_fnc_hashSet;
            [_taskParams,"dialog",_dialogOption] call ALIVE_fnc_hashSet;
            [_taskParams,"enemyFaction",_taskEnemyFaction] call ALIVE_fnc_hashSet;
            [_taskParams,"lastState",""] call ALIVE_fnc_hashSet;
            [_taskParams,"HVTSpawned",false] call ALIVE_fnc_hashSet;

            // return the created tasks and params

            _result = [_tasks,_taskParams];

        };

	};
	case "Parent":{

	};
	case "Destroy":{

	    private["_taskID","_requestPlayerID","_taskSide","_taskPosition","_taskFaction","_taskTitle","_taskDescription","_taskPlayers",
	    "_destinationReached","_taskIDs","_HVTSpawned","_lastState","_taskDialog","_currentTaskDialog"];

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
        _currentTaskDialog = [_taskDialog,_taskState] call ALIVE_fnc_hashGet;
        _HVTSpawned = [_params,"HVTSpawned"] call ALIVE_fnc_hashGet;

        if(_lastState != "Destroy") then {

            ["chat_start",_currentTaskDialog,_taskSide,_taskPlayers] call ALIVE_fnc_taskCreateRadioBroadcastForPlayers;

            [_params,"lastState","Destroy"] call ALIVE_fnc_hashSet;
        };

        if!(_HVTSpawned) then {

            _destinationReached = [_taskPosition,_taskPlayers,1000] call ALIVE_fnc_taskHavePlayersReachedDestination;

            if(_destinationReached) then {

                private["_taskEnemyFaction","_taskEnemySide","_group","_unit"];

                // spawn the HVT

                _taskEnemyFaction = [_params,"enemyFaction"] call ALIVE_fnc_hashGet;
                _taskEnemySide = _taskEnemyFaction call ALiVE_fnc_factionSide;

                _group = createGroup _taskEnemySide;

                _unit = [[_taskEnemyFaction],1,ALiVE_MIL_CQB_UNITBLACKLIST,true] call ALiVE_fnc_chooseRandomUnits;

                _unit = _group createUnit [_unit select 0, _taskPosition, [], 0 , "NONE"];

                [_params,"HVTSpawned",true] call ALIVE_fnc_hashSet;
                [_params,"target",_unit] call ALIVE_fnc_hashSet;

            };
        }else{

            private["_target","_targetPosition","_targetSide"];

            _target = [_params,"target"] call ALIVE_fnc_hashGet;

            if!(alive _target) then {

                [_params,"nextTask",""] call ALIVE_fnc_hashSet;

                _task set [8,"Succeeded"];
                _task set [10, "N"];
                _result = _task;

                [_taskPlayers,_taskID] call ALIVE_fnc_taskDeleteMarkersForPlayers;

                ["chat_success",_currentTaskDialog,_taskSide,_taskPlayers] call ALIVE_fnc_taskCreateRadioBroadcastForPlayers;

            }else{

                _targetPosition = position _target;
                _targetSide = side _target;

                [_targetPosition,_targetSide,_taskPlayers,_taskID,"HVT"] call ALIVE_fnc_taskCreateMarkersForPlayers;

            }

        };

    };
};

_result