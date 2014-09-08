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

        _targetPosition = [_taskLocation,_taskLocationType,_taskEnemySide] call ALIVE_fnc_taskGetSideCluster;

        if(count _targetPosition == 0) then {

            // no enemy occupied cluster found
            // try to get a position containing enemy

            _targetPosition = [_taskLocation,_taskLocationType,_taskEnemySide] call ALIVE_fnc_taskGetSideSectorCompositionPosition;

            // spawn a populated composition

            [_targetPosition, "objectives", _taskEnemyFaction, 2] call ALIVE_fnc_spawnRandomPopulatedComposition;

        };

        _targetPosition = position (nearestBuilding _targetPosition);
        _targetPosition = _targetPosition findEmptyPosition [0,200];

        if!(isNil "_targetPosition") then {

            private["_dialogOptions","_dialogOption"];

            // select the random text

            _dialogOptions = [ALIVE_generatedTasks,"Assassination"] call ALIVE_fnc_hashGet;
            _dialogOptions = _dialogOptions select 1;
            _dialogOption = _dialogOptions call BIS_fnc_selectRandom;

            // format the dialog options

            private["_nearestTown","_dialog","_formatDescription","_formatChat","_formatMessage","_formatMessageText"];

            _nearestTown = [_targetPosition] call ALIVE_fnc_taskGetNearestLocationName;

            _dialog = [_dialogOption,"Destroy"] call ALIVE_fnc_hashGet;

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

                private["_taskEnemyFaction","_taskEnemySide","_taskObjects","_tables","_chairs","_electronics","_documents",
                "_tableClass","_electronicClass","_documentClass","_table","_electronic","_document","_HVTGroup","_HVTClass","_HVTUnit","_HVT",
                "_HVTGroup2","_HVTClass","_HVTUnit","_HVT2"];

                // spawn the HVT

                _taskEnemyFaction = [_params,"enemyFaction"] call ALIVE_fnc_hashGet;
                _taskEnemySide = _taskEnemyFaction call ALiVE_fnc_factionSide;

                _taskObjects = ALIVE_taskObjects;
                _tables = [_taskObjects,"tables"] call ALIVE_fnc_hashGet;
                _chairs = [_taskObjects,"chairs"] call ALIVE_fnc_hashGet;
                _electronics = [_taskObjects,"electronics"] call ALIVE_fnc_hashGet;
                _documents = [_taskObjects,"documents"] call ALIVE_fnc_hashGet;

                _tableClass = _tables call BIS_fnc_selectRandom;
                _electronicClass = _electronics call BIS_fnc_selectRandom;
                _documentClass = _documents call BIS_fnc_selectRandom;

                _table = _tableClass createVehicle _taskPosition;
                _table setdir 0;

                _electronic = [_table,_electronicClass] call ALIVE_fnc_taskSpawnOnTopOf;
                _document = [_table,_documentClass] call ALIVE_fnc_taskSpawnOnTopOf;

                _HVTGroup = creategroup _taskEnemySide;
                _HVTClass = [[_taskEnemyFaction],1,ALiVE_MIL_CQB_UNITBLACKLIST,true] call ALiVE_fnc_chooseRandomUnits;
                _HVTUnit = _HVTGroup createUnit [_HVTClass select 0, _taskPosition, [], 0 , "NONE"];
                _HVT = leader _HVTGroup;
                _HVT setformdir 0;
                _HVT setpos [getpos _table select 0,(getpos _table select 1)-2,0];

                _HVTGroup2 = creategroup _taskEnemySide;
                _HVTClass = [[_taskEnemyFaction],1,ALiVE_MIL_CQB_UNITBLACKLIST,true] call ALiVE_fnc_chooseRandomUnits;
                _HVTUnit = _HVTGroup2 createUnit [_HVTClass select 0, _taskPosition, [], 0 , "NONE"];
                _HVT2 = leader _HVTGroup2;
                _HVT2 setformdir 180;
                _HVT2 setpos [getpos _table select 0,(getpos _table select 1)+2,0];


                [_params,"HVTSpawned",true] call ALIVE_fnc_hashSet;
                [_params,"targets",[_HVT,_HVT2]] call ALIVE_fnc_hashSet;
                [_params,"groups",[_HVTGroup,_HVTGroup2]] call ALIVE_fnc_hashSet;

            };
        }else{

            private["_targets","_targetsDown","_targetPosition","_targetSide","_groups"];

            _targets = [_params,"targets"] call ALIVE_fnc_hashGet;

            _targetsDown = true;

            {
                if(alive _x) then {
                    _targetsDown = false;
                };
            } forEach _targets;

            if(_targetsDown) then {

                _groups = [_params,"groups"] call ALIVE_fnc_hashGet;

                {
                    deleteGroup _x;
                } forEach _groups;

                [_params,"nextTask",""] call ALIVE_fnc_hashSet;

                _task set [8,"Succeeded"];
                _task set [10, "N"];
                _result = _task;

                [_taskPlayers,_taskID] call ALIVE_fnc_taskDeleteMarkersForPlayers;

                ["chat_success",_currentTaskDialog,_taskSide,_taskPlayers] call ALIVE_fnc_taskCreateRadioBroadcastForPlayers;

            }else{

                _targetPosition = position (_targets select 0);
                _targetSide = side (_targets select 0);

                [_targetPosition,_targetSide,_taskPlayers,_taskID,"HVT"] call ALIVE_fnc_taskCreateMarkersForPlayers;

            }

        };

    };
};

_result