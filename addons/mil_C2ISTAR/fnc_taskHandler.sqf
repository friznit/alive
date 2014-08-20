#include <\x\alive\addons\mil_C2ISTAR\script_component.hpp>
SCRIPT(taskHandler);

/* ----------------------------------------------------------------------------
Function: MAINCLASS
Description:
Task repository and handling

Parameters:
Nil or Object - If Nil, return a new instance. If Object, reference an existing instance.
String - The selected function
Array - The selected parameters

Returns:
Any - The new instance or the result of the selected function and parameters

Attributes:


Examples:
(begin example)
// create a task handler
_logic = [nil, "create"] call ALIVE_fnc_taskHandler;

// init task handler
_result = [_logic, "init"] call ALIVE_fnc_taskHandler;

(end)

See Also:

Author:
ARJay

Peer reviewed:
nil
---------------------------------------------------------------------------- */

#define SUPERCLASS ALIVE_fnc_baseClassHash
#define MAINCLASS ALIVE_fnc_taskHandler

private ["_logic","_operation","_args","_result"];

TRACE_1("taskHandler - input",_this);

_logic = [_this, 0, objNull, [objNull,[]]] call BIS_fnc_param;
_operation = [_this, 1, "", [""]] call BIS_fnc_param;
_args = [_this, 2, objNull, [objNull,[],"",0,true,false]] call BIS_fnc_param;
//_result = true;

#define MTEMPLATE "ALiVE_TASKHANDLER_%1"

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

        _tasks = [_logic, "tasks"] call ALIVE_fnc_hashGet;

        _tasks call ALIVE_fnc_hashInspect;

        _result = _args;
    };
    case "init": {
        if (isServer) then {
            private["_tasksBySide","_tasksToDispatch"];

            // if server, initialise module game logic
            [_logic,"super"] call ALIVE_fnc_hashRem;
            [_logic,"class",MAINCLASS] call ALIVE_fnc_hashSet;
            TRACE_1("After module init",_logic);

            // set defaults
            [_logic,"debug",false] call ALIVE_fnc_hashSet;
            [_logic,"tasks",[] call ALIVE_fnc_hashCreate] call ALIVE_fnc_hashSet;
            [_logic,"tasksBySide",[] call ALIVE_fnc_hashCreate] call ALIVE_fnc_hashSet;
            [_logic,"tasksByPlayer",[] call ALIVE_fnc_hashCreate] call ALIVE_fnc_hashSet;
            [_logic,"tasksByGroup",[] call ALIVE_fnc_hashCreate] call ALIVE_fnc_hashSet;
            [_logic,"tasksToDispatch",[] call ALIVE_fnc_hashCreate] call ALIVE_fnc_hashSet;
            [_logic,"listenerID",""] call ALIVE_fnc_hashSet;

            _tasksBySide = [] call ALIVE_fnc_hashCreate;
            [_tasksBySide, "EAST", [] call ALIVE_fnc_hashCreate] call ALIVE_fnc_hashSet;
            [_tasksBySide, "WEST", [] call ALIVE_fnc_hashCreate] call ALIVE_fnc_hashSet;
            [_tasksBySide, "GUER", [] call ALIVE_fnc_hashCreate] call ALIVE_fnc_hashSet;
            [_tasksBySide, "CIV", [] call ALIVE_fnc_hashCreate] call ALIVE_fnc_hashSet;
            [_logic,"tasksBySide",_tasksBySide] call ALIVE_fnc_hashSet;

            _tasksToDispatch = [] call ALIVE_fnc_hashCreate;
            [_tasksToDispatch, "create", [] call ALIVE_fnc_hashCreate] call ALIVE_fnc_hashSet;
            [_tasksToDispatch, "update", [] call ALIVE_fnc_hashCreate] call ALIVE_fnc_hashSet;
            [_tasksToDispatch, "delete", [] call ALIVE_fnc_hashCreate] call ALIVE_fnc_hashSet;
            [_logic,"tasksToDispatch",_tasksToDispatch] call ALIVE_fnc_hashSet;

            [_logic,"listen"] call MAINCLASS;
        };
    };
    case "listen": {
        private["_listenerID"];

        _listenerID = [ALIVE_eventLog, "addListener",[_logic, ["TASKS_UPDATE","TASK_CREATE","TASK_UPDATE","TASK_DELETE","TASKS_SYNC"]]] call ALIVE_fnc_eventLog;
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
    case "TASKS_UPDATE": {
        private["_eventData"];

        _eventData = _args;

        ["TASKS UPDATE: %1",_eventData] call ALIVE_fnc_dump;

        [_logic, "updateTaskState", _eventData] call MAINCLASS;

    };
    case "TASK_CREATE": {
        private["_eventData"];

        _eventData = _args;

        ["TASK CREATE: %1",_eventData] call ALIVE_fnc_dump;

        [_logic, "registerTask", _eventData] call MAINCLASS;

        [_logic, "updateTaskState", _eventData] call MAINCLASS;

    };
    case "TASK_UPDATE": {
        private["_eventData"];

        _eventData = _args;

        ["TASK UPDATE: %1",_eventData] call ALIVE_fnc_dump;

        [_logic, "updateTask", _eventData] call MAINCLASS;

        [_logic, "updateTaskState", _eventData] call MAINCLASS;

    };
    case "TASK_DELETE": {
        private["_eventData","_taskID"];

        _eventData = _args;

        _taskID = _eventData select 0;

        ["TASK DELETE: %1",_eventData] call ALIVE_fnc_dump;

        [_logic, "unregisterTask", _taskID] call MAINCLASS;

        [_logic, "updateTaskState", _eventData] call MAINCLASS;

    };
    case "TASKS_SYNC": {
        private["_eventData","_taskID"];

        _eventData = _args;

        ["TASKS SYNC: %1",_eventData] call ALIVE_fnc_dump;

        [_logic, "syncTasks", _eventData] call MAINCLASS;

    };
    case "syncTasks": {
        private["_playerID","_groupID","_playerTasks","_groupTasks","_dispatchTasks","_player"];

        if(typeName _args == "ARRAY") then {

            _playerID = _eventData select 0;
            _groupID = _eventData select 0;

            _playerTasks = [_logic, "getTasksByPlayer", _playerID] call MAINCLASS;
            _groupTasks = [_logic, "getTasksByGroup", _groupID] call MAINCLASS;

            _dispatchTasks = [];

            if(count _playerTasks > 0) then {

                {
                    _dispatchTasks set [count _dispatchTasks,_x];
                } forEach _playerTasks;

            };

            if(count _groupTasks > 0) then {

                {
                    if!(_x in _dispatchTasks) then {
                        _dispatchTasks set [count _dispatchTasks,_x];
                    };
                } forEach _groupTasks;

            };

            if(count _dispatchTasks > 0) then {

                _player = [_playerID] call ALIVE_fnc_getPlayerByUID;

                // dispatch tasks to player
                {

                    private ["_task","_taskID","_requestPlayerID","_position","_title","_description","_state","_event","_current"];

                    _task = _x;
                    _taskID = _task select 0;
                    _requestPlayerID = _task select 1;
                    _position = _task select 3;
                    _title = _task select 5;
                    _description = _task select 6;
                    _state = _task select 8;
                    _current = _task select 10;

                    _event = ["TASK_CREATE",_taskID,_requestPlayerID,_position,_title,_description,_state,_current];

                    if !(isNull _player) then {
                        if(isDedicated) then {
                            [_event,"ALIVE_fnc_taskHandlerEventToClient",_player,false,false] spawn BIS_fnc_MP;
                        }else{
                            _event call ALIVE_fnc_taskHandlerEventToClient;
                        };
                    };

                } forEach _dispatchTasks;

            };

        };

    };
    case "registerTask": {
        private["_task","_taskID","_taskSide","_taskPlayers","_taskApplyType","_tasks","_tasksBySide","_sideTasks",
        "_tasksByPlayer","_tasksByGroup","_group","_groupTasks","_playerTasks","_player","_tasksToDispatch","_createTasks"];

        if(typeName _args == "ARRAY") then {

            /*
            _taskID = _task select 0;
            _requestPlayerID = _task select 1;
            _side = _task select 2;
            _position = _task select 3;
            _faction = _task select 4;
            _title = _task select 5;
            _description = _task select 6;
            _players = _task select 7;
            _state = _task select 8;
            _applyType = _task select 9;
            */

            _task = _args;
            _taskID = _task select 0;
            _taskSide = _task select 2;
            _taskPlayers = _task select 7 select 0;
            _taskApplyType = _task select 9;

            // store in main tasks hash
            _tasks = [_logic, "tasks"] call ALIVE_fnc_hashGet;
            [_tasks,_taskID,_task] call ALIVE_fnc_hashSet;

            // store in tasks by side hash
            _tasksBySide = [_logic, "tasksBySide"] call ALIVE_fnc_hashGet;
            _sideTasks = [_tasksBySide, _taskSide] call ALIVE_fnc_hashGet;
            [_sideTasks, _taskID, _taskID] call ALIVE_fnc_hashSet;

            // store in tasks by player hash
            _tasksByPlayer = [_logic, "tasksByPlayer"] call ALIVE_fnc_hashGet;

            // prepare tasks to dispatch
            _tasksToDispatch = [_logic,"tasksToDispatch"] call ALIVE_fnc_hashGet;
            _createTasks = [_tasksToDispatch,"create"] call ALIVE_fnc_hashGet;

            {

                _player = _x;

                if(_player in (_tasksByPlayer select 1)) then {

                    _playerTasks = [_tasksByPlayer, _player] call ALIVE_fnc_hashGet;

                }else{

                    [_tasksByPlayer, _player, [] call ALIVE_fnc_hashCreate] call ALIVE_fnc_hashSet;
                    _playerTasks = [_tasksByPlayer, _player] call ALIVE_fnc_hashGet;

                };

                // prepare task for dispatch to this player
                [_createTasks,_player,_task] call ALIVE_fnc_hashSet;

                // store the task by player
                [_playerTasks,_taskID,_taskID] call ALIVE_fnc_hashSet;
                [_tasksByPlayer, _player, _playerTasks] call ALIVE_fnc_hashSet;

            } forEach _taskPlayers;


            // store in tasks by group hash
            if(_taskApplyType == "Group") then {

                _tasksByGroup = [_logic, "tasksByGroup"] call ALIVE_fnc_hashGet;

                {

                    _player = [_x] call ALIVE_fnc_getPlayerByUID;

                    if !(isNull _player) then {
                        _group = group _player;

                        if(_group in (_tasksByGroup select 1)) then {

                            _groupTasks = [_tasksByGroup, _group] call ALIVE_fnc_hashGet;

                        }else{

                            [_tasksByGroup, _group, [] call ALIVE_fnc_hashCreate] call ALIVE_fnc_hashSet;
                            _groupTasks = [_tasksByGroup, _group] call ALIVE_fnc_hashGet;

                        };

                        [_groupTasks,_taskID,_taskID] call ALIVE_fnc_hashSet;
                        [_tasksByGroup, _group, _groupTasks] call ALIVE_fnc_hashSet;
                    };

                } forEach _taskPlayers;
            };

        };
    };
    case "updateTask": {
        private["_updatedTask","_updatedTaskPlayers","_taskApplyType","_taskSide","_taskID","_task","_previousTaskPlayers",
        "_previousTaskApplyType","_tasks","_tasksBySide","_sideTasks","_tasksByPlayer","_player","_group","_countRemoved",
        "_previousGroups","_updatedGroups","_tasksToDispatch","_updateTasks","_deleteTasks"];

        if(typeName _args == "ARRAY") then {

            _updatedTask = _args;
            _updatedTaskPlayers = _updatedTask select 7 select 0;
            _taskApplyType = _updatedTask select 9;
            _taskSide = _updatedTask select 2;

            _taskID = _updatedTask select 0;
            _task = [_logic, "getTask", _taskID] call MAINCLASS;
            _previousTaskPlayers = _task select 7 select 0;
            _previousTaskApplyType = _task select 9;

            // prepare tasks to dispatch
            _tasksToDispatch = [_logic,"tasksToDispatch"] call ALIVE_fnc_hashGet;
            _createTasks = [_tasksToDispatch,"create"] call ALIVE_fnc_hashGet;
            _updateTasks = [_tasksToDispatch,"update"] call ALIVE_fnc_hashGet;
            _deleteTasks = [_tasksToDispatch,"delete"] call ALIVE_fnc_hashGet;

            private ["_playerTasks"];

            _countRemoved = 0;

            // remove the task from removed players
            _tasksByPlayer = [_logic, "tasksByPlayer"] call ALIVE_fnc_hashGet;
            {

                _player = _x;

                if!(_player in _updatedTaskPlayers) then {

                    // remove task
                    _playerTasks = [_tasksByPlayer, _player] call ALIVE_fnc_hashGet;
                    [_playerTasks,_taskID] call ALIVE_fnc_hashRem;
                    [_tasksByPlayer, _player, _playerTasks] call ALIVE_fnc_hashSet;

                    // prepare task for dispatch to this player
                    [_deleteTasks,_player,_task] call ALIVE_fnc_hashSet;

                    _countRemoved = _countRemoved + 1;

                };

            } forEach _previousTaskPlayers;

            private ["_group"];

            // if some players have been removed need to also remove
            // the group if no other players from that group are selected
            if(_countRemoved > 0) then {

                if(_previousTaskApplyType == "Group") then {

                    if(_taskApplyType == "Group") then {

                        _previousGroups = [];

                        {

                            _player = [_x] call ALIVE_fnc_getPlayerByUID;

                            if !(isNull _player) then {
                                _group = group _player;

                                if!(_group in _previousGroups) then {
                                    _previousGroups set [count _previousGroups, _group];
                                };

                            };

                        } forEach _previousTaskPlayers;

                        _updatedGroups = [];

                        {

                            _player = [_x] call ALIVE_fnc_getPlayerByUID;

                            if !(isNull _player) then {
                                _group = group _player;

                                if!(_group in _updatedGroups) then {
                                    _updatedGroups set [count _updatedGroups, _group];
                                };

                            };

                        } forEach _updatedTaskPlayers;

                        _tasksByGroup = [_logic, "tasksByGroup"] call ALIVE_fnc_hashGet;

                        {

                            if!(_x in _updatedGroups) then {

                                if(_x in (_tasksByGroup select 1)) then {

                                    // remove task
                                    _groupTasks = [_tasksByGroup, _x] call ALIVE_fnc_hashGet;
                                    [_groupTasks,_taskID] call ALIVE_fnc_hashRem;
                                    [_tasksByGroup, _x, _groupTasks] call ALIVE_fnc_hashSet;

                                };

                            };

                        } forEach _previousGroups;

                    };

                };

            };

            private ["_playerTasks"];

            // update in tasks by player hash
            {
                _player = _x;

                if(_player in (_tasksByPlayer select 1)) then {

                    _playerTasks = [_tasksByPlayer, _player] call ALIVE_fnc_hashGet;

                    // prepare task for dispatch to this player
                    [_updateTasks,_player,_updatedTask] call ALIVE_fnc_hashSet;

                }else{

                    [_tasksByPlayer, _player, [] call ALIVE_fnc_hashCreate] call ALIVE_fnc_hashSet;
                    _playerTasks = [_tasksByPlayer, _player] call ALIVE_fnc_hashGet;

                    // prepare task for dispatch to this player
                    [_createTasks,_player,_updatedTask] call ALIVE_fnc_hashSet;

                };

                [_playerTasks,_taskID,_taskID] call ALIVE_fnc_hashSet;
                [_tasksByPlayer, _player, _playerTasks] call ALIVE_fnc_hashSet;

            } forEach _updatedTaskPlayers;

            private ["_playerTasks","_group"];

            // if the previous version of the task was for groups
            // and now has been set to individuals
            if(_previousTaskApplyType == "Group") then {

                if(_taskApplyType == "Individual") then {

                    _tasksByGroup = [_logic, "tasksByGroup"] call ALIVE_fnc_hashGet;

                    {

                        _player = [_x] call ALIVE_fnc_getPlayerByUID;

                        if !(isNull _player) then {
                            _group = group _player;

                            if(_group in (_tasksByGroup select 1)) then {

                                // remove task
                                _groupTasks = [_tasksByGroup, _group] call ALIVE_fnc_hashGet;
                                [_groupTasks,_taskID] call ALIVE_fnc_hashRem;
                                [_tasksByGroup, _group, _groupTasks] call ALIVE_fnc_hashSet;

                            };

                        };

                    } forEach _previousTaskPlayers;

                };
            };

            private ["_groupTasks","_group"];

            // if the previous version of the task was for individuals
            // and now has been set to groups
            if(_previousTaskApplyType == "Individual") then {

                if(_taskApplyType == "Group") then {

                    _tasksByGroup = [_logic, "tasksByGroup"] call ALIVE_fnc_hashGet;

                    {

                        _player = [_x] call ALIVE_fnc_getPlayerByUID;

                        if !(isNull _player) then {
                            _group = group _player;

                            if(_group in (_tasksByGroup select 1)) then {

                                _groupTasks = [_tasksByGroup, _group] call ALIVE_fnc_hashGet;

                            }else{

                                [_tasksByGroup, _group, [] call ALIVE_fnc_hashCreate] call ALIVE_fnc_hashSet;
                                _groupTasks = [_tasksByGroup, _group] call ALIVE_fnc_hashGet;

                            };

                            [_groupTasks,_taskID,_taskID] call ALIVE_fnc_hashSet;
                            [_tasksByGroup, _group, _groupTasks] call ALIVE_fnc_hashSet;

                        };

                    } forEach _updatedTaskPlayers;

                };
            };

            // update in main tasks hash
            _tasks = [_logic, "tasks"] call ALIVE_fnc_hashGet;
            [_tasks,_taskID,_updatedTask] call ALIVE_fnc_hashSet;

            // update in tasks by side hash
            _tasksBySide = [_logic, "tasksBySide"] call ALIVE_fnc_hashGet;
            _sideTasks = [_tasksBySide, _taskSide] call ALIVE_fnc_hashGet;
            [_sideTasks, _taskID, _taskID] call ALIVE_fnc_hashSet;

        };
    };
    case "unregisterTask": {
        private["_taskData","_taskID","_task","_taskSide","_tasks","_tasksBySide","_sideTasks","_tasksByGroup","_group","_groupTasks",
        "_tasksByPlayer","_player","_playerTasks","_tasksToDispatch","_deleteTasks","_taskPlayers"];

        if(typeName _args == "STRING") then {

            _taskID = _args;
            _task = [_logic, "getTask", _taskID] call MAINCLASS;

            _taskSide = _task select 2;
            _taskPlayers = _task select 7 select 0;

            // prepare tasks to dispatch
            _tasksToDispatch = [_logic,"tasksToDispatch"] call ALIVE_fnc_hashGet;
            _deleteTasks = [_tasksToDispatch,"delete"] call ALIVE_fnc_hashGet;

            {

                _player = _x;

                // prepare task for dispatch to this player
                [_deleteTasks,_player,_task] call ALIVE_fnc_hashSet;

            } forEach _taskPlayers;

            // remove from main tasks hash
            _tasks = [_logic, "tasks"] call ALIVE_fnc_hashGet;
            [_tasks,_taskID] call ALIVE_fnc_hashRem;
            [_logic, "tasks", _tasks] call ALIVE_fnc_hashSet;

            // remove from tasks by side hash
            _tasksBySide = [_logic, "tasksBySide"] call ALIVE_fnc_hashGet;
            _sideTasks = [_tasksBySide, _taskSide] call ALIVE_fnc_hashGet;
            [_sideTasks,_taskID] call ALIVE_fnc_hashRem;
            [_tasksBySide, _taskSide, _sideTasks] call ALIVE_fnc_hashSet;

            // remove from tasks by groups hash
            _tasksByGroup = [_logic, "tasksByGroup"] call ALIVE_fnc_hashGet;

            {
                _group = _x;
                _groupTasks = [_tasksByGroup,_group] call ALIVE_fnc_hashGet;
                [_groupTasks,_taskID] call ALIVE_fnc_hashRem;
                [_tasksByGroup, _group, _groupTasks] call ALIVE_fnc_hashSet;
            } forEach (_tasksByGroup select 1);

            // remove from tasks from player hash
            _tasksByPlayer = [_logic, "tasksByPlayer"] call ALIVE_fnc_hashGet;

            {
                _player = _x;
                _playerTasks = [_tasksByPlayer,_player] call ALIVE_fnc_hashGet;
                [_playerTasks,_taskID] call ALIVE_fnc_hashRem;
                [_tasksByPlayer, _player, _playerTasks] call ALIVE_fnc_hashSet;
            } forEach (_tasksByPlayer select 1);

        };
    };
    case "updateTaskState": {
        private["_task","_taskID","_playerID","_taskSide","_tasksBySide","_sideTasks","_event","_tasksToDispatch",
        "_createTasks","_updateTasks","_deleteTasks"];

        if(typeName _args == "ARRAY") then {

            _task = _args;
            _playerID = _task select 1;
            _taskSide = _task select 2;

            _tasksBySide = [_logic, "tasksBySide"] call ALIVE_fnc_hashGet;
            _sideTasks = [_logic, "getTasksBySide", _taskSide] call MAINCLASS;
            _tasksToDispatch = [_logic,"tasksToDispatch"] call ALIVE_fnc_hashGet;
            _createTasks = [_tasksToDispatch,"create"] call ALIVE_fnc_hashGet;
            _updateTasks = [_tasksToDispatch,"update"] call ALIVE_fnc_hashGet;
            _deleteTasks = [_tasksToDispatch,"delete"] call ALIVE_fnc_hashGet;

            //////////
            private ["_tasks","_tasksByGroup","_tasksByPlayer"];
            _tasks = [_logic, "tasks"] call ALIVE_fnc_hashGet;
            _tasksByGroup = [_logic, "tasksByGroup"] call ALIVE_fnc_hashGet;
            _tasksByPlayer = [_logic, "tasksByPlayer"] call ALIVE_fnc_hashGet;

            ["TASK STATE UPDATED!!"] call ALIVE_fnc_dump;
            ["TASK STATE:"] call ALIVE_fnc_dump;
            _tasks call ALIVE_fnc_inspectHash;
            ["TASK BY SIDE STATE:"] call ALIVE_fnc_dump;
            _tasksBySide call ALIVE_fnc_inspectHash;
            ["SIDE TASKS: %1",_sideTasks] call ALIVE_fnc_dump;
            ["TASK BY GROUP STATE:"] call ALIVE_fnc_dump;
            _tasksByGroup call ALIVE_fnc_inspectHash;
            ["TASK BY PLAYER STATE:"] call ALIVE_fnc_dump;
            _tasksByPlayer call ALIVE_fnc_inspectHash;
            ["TASKS TO DISPATCH:"] call ALIVE_fnc_dump;
            _tasksToDispatch call ALIVE_fnc_inspectHash;
            /////////


            // dispatch create events
            {

                private ["_player","_task","_taskID","_requestPlayerID","_position","_title","_description","_state","_event","_current"];

                _player = [_x] call ALIVE_fnc_getPlayerByUID;
                _task = [_createTasks,_x] call ALIVE_fnc_hashGet;

                _taskID = _task select 0;
                _requestPlayerID = _task select 1;
                _position = _task select 3;
                _title = _task select 5;
                _description = _task select 6;
                _state = _task select 8;
                _current = _task select 10;

                _event = ["TASK_CREATE",_taskID,_requestPlayerID,_position,_title,_description,_state,_current];

                if !(isNull _player) then {
                    if(isDedicated) then {
                        [_event,"ALIVE_fnc_taskHandlerEventToClient",_player,false,false] spawn BIS_fnc_MP;
                    }else{
                        _event call ALIVE_fnc_taskHandlerEventToClient;
                    };
                };

            } forEach (_createTasks select 1);

            // dispatch update events
            {

                private ["_player","_task","_taskID","_requestPlayerID","_position","_title","_description","_state","_event","_current"];

                _player = [_x] call ALIVE_fnc_getPlayerByUID;
                _task = [_updateTasks,_x] call ALIVE_fnc_hashGet;

                _taskID = _task select 0;
                _requestPlayerID = _task select 1;
                _position = _task select 3;
                _title = _task select 5;
                _description = _task select 6;
                _state = _task select 8;
                _current = _task select 10;

                _event = ["TASK_UPDATE",_taskID,_requestPlayerID,_position,_title,_description,_state,_current];

                if !(isNull _player) then {
                    if(isDedicated) then {
                        [_event,"ALIVE_fnc_taskHandlerEventToClient",_player,false,false] spawn BIS_fnc_MP;
                    }else{
                        _event call ALIVE_fnc_taskHandlerEventToClient;
                    };
                };

            } forEach (_updateTasks select 1);

            // dispatch delete events
            {

                private ["_player","_task","_taskID","_requestPlayerID","_position","_title","_description","_state","_event","_current"];

                _player = [_x] call ALIVE_fnc_getPlayerByUID;
                _task = [_deleteTasks,_x] call ALIVE_fnc_hashGet;

                _taskID = _task select 0;
                _requestPlayerID = _task select 1;
                _position = _task select 3;
                _title = _task select 5;
                _description = _task select 6;
                _state = _task select 8;
                _current = _task select 10;

                _event = ["TASK_DELETE",_taskID,_requestPlayerID,_position,_title,_description,_state,_current];

                if !(isNull _player) then {
                    if(isDedicated) then {
                        [_event,"ALIVE_fnc_taskHandlerEventToClient",_player,false,false] spawn BIS_fnc_MP;
                    }else{
                        _event call ALIVE_fnc_taskHandlerEventToClient;
                    };
                };

            } forEach (_deleteTasks select 1);

            [_tasksToDispatch,"create",[] call ALIVE_fnc_hashCreate] call ALIVE_fnc_hashSet;
            [_tasksToDispatch,"update",[] call ALIVE_fnc_hashCreate] call ALIVE_fnc_hashSet;
            [_tasksToDispatch,"delete",[] call ALIVE_fnc_hashCreate] call ALIVE_fnc_hashSet;

            _event = ['TASKS_UPDATED', [_playerID,_sideTasks], "TASK_HANDLER"] call ALIVE_fnc_event;
            [ALIVE_eventLog, "addEvent",_event] call ALIVE_fnc_eventLog;

        };
    };
    case "getTask": {
        private["_taskID","_tasks","_taskIndex"];

        if(typeName _args == "STRING") then {
            _taskID = _args;
            _tasks = [_logic, "tasks"] call ALIVE_fnc_hashGet;
            _taskIndex = _tasks select 1;
            if(_taskID in _taskIndex) then {
                _result = [_tasks, _taskID] call ALIVE_fnc_hashGet;
            }else{
                _result = nil;
            };
        };
    };
    case "getTasks": {
        _result = [_logic, "tasks"] call ALIVE_fnc_hashGet;
    };
    case "getTasksBySide": {
        private["_side","_tasksBySide","_sideTasks","_tasks"];

        if(typeName _args == "STRING") then {
            _side = _args;

            _tasksBySide = [_logic, "tasksBySide"] call ALIVE_fnc_hashGet;
            _sideTasks = [_tasksBySide, _side] call ALIVE_fnc_hashGet;

            _tasks = [];

            if!(isNil "_sideTasks") then {

                {
                    _tasks set [count _tasks, [_logic,"getTask",_x] call MAINCLASS];
                } forEach (_sideTasks select 1);

            };

            _result = _tasks;
        };
    };
    case "getTasksByPlayer": {
        private["_player","_tasksByPlayer","_playerTasks","_tasks","_task"];

        if(typeName _args == "STRING") then {
            _player = _args;

            _tasksByPlayer = [_logic, "tasksByPlayer"] call ALIVE_fnc_hashGet;
            _playerTasks = [_tasksByPlayer, _player] call ALIVE_fnc_hashGet;

            _tasks = [];

            if!(isNil "_playerTasks") then {

                {
                    _task = [_logic,"getTask",_x] call MAINCLASS;
                    _tasks set [count _tasks, _task];
                } forEach (_playerTasks select 1);

            };

            _result = _tasks;

        };
    };
    case "getTasksByGroup": {
        private["_group","_tasksByGroup","_groupTasks","_tasks","_task"];

        if(typeName _args == "STRING") then {
            _group = _args;

            _tasksByGroup = [_logic, "tasksByGroup"] call ALIVE_fnc_hashGet;
            _groupTasks = [_tasksByGroup, _group] call ALIVE_fnc_hashGet;

            _tasks = [];

            if!(isNil "_groupTasks") then {

                {
                    _task = [_logic,"getTask",_x] call MAINCLASS;
                    _tasks set [count _tasks, _task];
                } forEach (_groupTasks select 1);

            };

            _result = _tasks;
        };
    };
    default {
        _result = [_logic, _operation, _args] call SUPERCLASS;
    };
};
TRACE_1("taskHandler - output",_result);

if !(isnil "_result") then {_result} else {nil};