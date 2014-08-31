#include <\x\alive\addons\mil_C2ISTAR\script_component.hpp>
SCRIPT(taskGenerator);

/* ----------------------------------------------------------------------------
Function: MAINCLASS
Description:
Dynamic task generation

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
_logic = [nil, "create"] call ALIVE_fnc_taskGenerator;

// init task handler
_result = [_logic, "init"] call ALIVE_fnc_taskGenerator;

(end)

See Also:

Author:
ARJay

Peer reviewed:
nil
---------------------------------------------------------------------------- */

#define SUPERCLASS ALIVE_fnc_baseClassHash
#define MAINCLASS ALIVE_fnc_taskGenerator

private ["_logic","_operation","_args","_result"];

TRACE_1("taskGenerator - input",_this);

_logic = [_this, 0, objNull, [objNull,[]]] call BIS_fnc_param;
_operation = [_this, 1, "", [""]] call BIS_fnc_param;
_args = [_this, 2, objNull, [objNull,[],"",0,true,false]] call BIS_fnc_param;
//_result = true;

#define MTEMPLATE "ALiVE_TASKGENERATOR_%1"

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

            // if server, initialise module game logic
            [_logic,"super"] call ALIVE_fnc_hashRem;
            [_logic,"class",MAINCLASS] call ALIVE_fnc_hashSet;
            TRACE_1("After module init",_logic);

            // set defaults
            [_logic,"debug",false] call ALIVE_fnc_hashSet;
            [_logic,"tasks",[] call ALIVE_fnc_hashCreate] call ALIVE_fnc_hashSet;
            [_logic,"listenerID",""] call ALIVE_fnc_hashSet;

            [_logic,"listen"] call MAINCLASS;
        };
    };
    case "listen": {
        private["_listenerID"];

        _listenerID = [ALIVE_eventLog, "addListener",[_logic, ["TASK_GENERATE"]]] call ALIVE_fnc_eventLog;
        [_logic,"listenerID",_listenerID] call ALIVE_fnc_hashSet;
    };
    case "handleEvent": {
        private["_event","_type","_eventData"];

        if(typeName _args == "ARRAY") then {

            _event = _args;
            _type = [_event, "type"] call ALIVE_fnc_hashGet;
            _eventData = [_event, "data"] call ALIVE_fnc_hashGet;

            ["TASK GENERATE EVENT!!!"] call ALIVE_fnc_dump;
            _event call ALIVE_fnc_inspectHash;

            //[_logic, _type, _eventData] call MAINCLASS;

        };
    };
    default {
        _result = [_logic, _operation, _args] call SUPERCLASS;
    };
};
TRACE_1("taskGenerator - output",_result);

if !(isnil "_result") then {_result} else {nil};