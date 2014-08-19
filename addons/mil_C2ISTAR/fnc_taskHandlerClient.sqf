#include <\x\alive\addons\mil_C2ISTAR\script_component.hpp>
SCRIPT(taskHandlerClient);

/* ----------------------------------------------------------------------------
Function: MAINCLASS
Description:
Clientside task repository and handling

Parameters:
Nil or Object - If Nil, return a new instance. If Object, reference an existing instance.
String - The selected function
Array - The selected parameters

Returns:
Any - The new instance or the result of the selected function and parameters

Attributes:


Examples:
(begin example)

(end)

See Also:

Author:
ARJay

Peer reviewed:
nil
---------------------------------------------------------------------------- */

#define SUPERCLASS ALIVE_fnc_baseClassHash
#define MAINCLASS ALIVE_fnc_taskHandlerClient

private ["_logic","_operation","_args","_result"];

TRACE_1("taskHandlerClient - input",_this);

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

        };
    };
    case "handleEvent": {
        private["_event","_type"];

        if(typeName _args == "ARRAY") then {

            _event = _args;
            _type = _event select 0;

            [_logic, _type, _event] call MAINCLASS;

            ["CLIENT TASK HANDLER HANDLE EVENT: %1",_event] call ALIVE_fnc_dump;

        };
    };
    case "TASK_CREATE": {
        private["_eventData"];

        _eventData = _args;

        ["TASK CREATE: %1",_eventData] call ALIVE_fnc_dump;

        [_logic, "registerTask", _eventData] call MAINCLASS;

    };
    case "TASK_UPDATE": {
        private["_eventData"];

        _eventData = _args;

        ["TASK UPDATE: %1",_eventData] call ALIVE_fnc_dump;

        [_logic, "updateTask", _eventData] call MAINCLASS;

    };
    case "TASK_DELETE": {
        private["_eventData","_taskID"];

        _eventData = _args;

        _taskID = _eventData select 1;

        ["TASK DELETE: %1",_eventData] call ALIVE_fnc_dump;

        [_logic, "unregisterTask", _taskID] call MAINCLASS;

    };
    case "registerTask": {
        private["_task","_taskID","_requestingPlayer","_position","_title","_description","_state","_current","_taskObject","_tasks"];

        if(typeName _args == "ARRAY") then {

            _task = _args;

            _taskID = _task select 1;
            _requestingPlayer = _task select 2;
            _position = _task select 3;
            _title = _task select 4;
            _description = _task select 5;
            _state = _task select 6;
            _current = _task select 7;

            _taskObject = player createSimpleTask [_title];
            _taskObject setSimpleTaskDescription [_description,_title,_title];
            _taskObject setSimpleTaskDestination _position;
            _taskObject setTaskState _state;

            if(_current == "Y") then {
                player setCurrentTask _taskObject;
            };

            switch(_state) do {
                case "Created": {
                    ["NewTask",["",_title]] call BIS_fnc_showNotification;
                };
                case "Assigned": {
                    ["TaskAssigned",["",_title]] call BIS_fnc_showNotification;
                };
                case "Succeeded": {
                    ["TaskSucceeded",["",_title]] call BIS_fnc_showNotification;
                };
                case "Failed": {
                    ["TaskFailed",["",_title]] call BIS_fnc_showNotification;
                };
                case "Canceled": {
                    ["TaskCanceled",["",_title]] call BIS_fnc_showNotification;
                };
            };

            _task set [8,_taskObject];

            // store in main tasks hash
            _tasks = [_logic, "tasks"] call ALIVE_fnc_hashGet;
            [_tasks,_taskID,_task] call ALIVE_fnc_hashSet;

        };
    };
    case "updateTask": {
        private["_updatedTask","_taskID","_requestingPlayer","_position","_title","_description","_state","_current","_taskObject","_tasks"];

        if(typeName _args == "ARRAY") then {

            _updatedTask = _args;

            _taskID = _updatedTask select 1;
            _requestingPlayer = _updatedTask select 2;
            _position = _updatedTask select 3;
            _title = _updatedTask select 4;
            _description = _updatedTask select 5;
            _state = _updatedTask select 6;
            _current = _updatedTask select 7;

            _task = [_logic, "getTask", _taskID] call MAINCLASS;

            _taskObject = _task select 8;
            _taskObject setSimpleTaskDescription [_description,_title,_title];
            _taskObject setSimpleTaskDestination _position;
            _taskObject setTaskState _state;

            if(_current == "Y") then {
                player setCurrentTask _taskObject;
            };

            switch(_state) do {
                case "Created": {
                    ["NewTask",["",_title]] call BIS_fnc_showNotification;
                };
                case "Assigned": {
                    ["TaskAssigned",["",_title]] call BIS_fnc_showNotification;
                };
                case "Succeeded": {
                    ["TaskSucceeded",["",_title]] call BIS_fnc_showNotification;
                };
                case "Failed": {
                    ["TaskFailed",["",_title]] call BIS_fnc_showNotification;
                };
                case "Canceled": {
                    ["TaskCanceled",["",_title]] call BIS_fnc_showNotification;
                };
            };

            _updatedTask set [8,_taskObject];

            // update in main tasks hash
            _tasks = [_logic, "tasks"] call ALIVE_fnc_hashGet;
            [_tasks,_taskID,_updatedTask] call ALIVE_fnc_hashSet;

        };
    };
    case "unregisterTask": {
        private["_task","_taskID","_tasks","_taskObject"];

        if(typeName _args == "STRING") then {

            _taskID = _args;

            _task = [_logic, "getTask", _taskID] call MAINCLASS;

            _taskObject = _task select 8;

            player removeSimpleTask _taskObject;

            // remove from main tasks hash
            _tasks = [_logic, "tasks"] call ALIVE_fnc_hashGet;
            [_tasks,_taskID] call ALIVE_fnc_hashRem;
            [_logic, "tasks", _tasks] call ALIVE_fnc_hashSet;

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
    default {
        _result = [_logic, _operation, _args] call SUPERCLASS;
    };
};
TRACE_1("taskHandlerClient - output",_result);

if !(isnil "_result") then {_result} else {nil};