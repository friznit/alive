#include <\x\alive\addons\main\script_component.hpp>
SCRIPT(baseClass);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_baseClass
Description:
Base class

Parameters:
Nil or Object - If Nil, return a new instance. If Object, reference an existing instance.
String - The selected function
Array - The selected parameters

Returns:
Any - The new instance or the result of the selected function and parameters

Attributes:
Nil - destroy - Destroy instance

Examples:
(begin example)
// Create instance
_logic = call ALIVE_fnc_BaseClass;

// Destroy instance
[_logic, "destroy"] call ALIVE_fnc_BaseClass;
(end)

See Also:
- nil

Author:
Wolffy.au

Peer reviewed:
nil
---------------------------------------------------------------------------- */
private ["_logic","_operation","_args","_result"];

if(
        isNil "_this" ||
        {typeName _this != "ARRAY"} ||
        {count _this == 0} ||
        {typeName (_this select 0) != "OBJECT"}
) then {
        _this = [objNull, "create"];
};

TRACE_1("baseClass",_this);

_logic = [_this, 0, objNull, [objNull]] call BIS_fnc_param;
_operation = [_this, 1, "", ["nil"]] call BIS_fnc_param;
_args = [_this, 2, [], [[]]] call BIS_fnc_param;
_result = objNull;

switch(_operation) do {
        default {
                private["_err"];
                _err = format["%1 does not support %2 operation", _logic, _operation];
                ERROR_WITH_TITLE(str _logic,_err);
        };
        case "create": {
                // Create a module object for settings and persistence
                if (isNil "sideLogic") then {createCenter sideLogic;};
                _logic = (createGroup sideLogic) createUnit ["LOGIC", [0,0], [], 0, "NONE"];
                _logic setVariable ["class", ALIVE_fnc_baseClass];
                _result = _logic;
        };
        case "destroy": {
                _logic setVariable ["class", nil];
                deleteVehicle _logic;
        };
};
TRACE_1("baseClass",_result);
_result;
