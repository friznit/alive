#include <\x\alive\addons\main\script_component.hpp>
SCRIPT(baseClassHash);

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
Nil - create - Create instance
Nil - destroy - Destroy instance

Examples:
(begin example)
// Create instance
_logic = [nil, "create"] call ALIVE_fnc_BaseClass;

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
        {typeName (_this select 0) != "ARRAY"} // changed to array
) then {
        _this = [[], "create"]; // changed to array
};

TRACE_1("baseClassHash - input",_this);

_logic = [_this, 0, objNull, [[]]] call BIS_fnc_param; // changed to array as the allowed not sure if this is right..
_operation = [_this, 1, "", [""]] call BIS_fnc_param;
_args = [_this, 2, objNull, [objNull,[],"",0,true,false]] call BIS_fnc_param;
_result = true;

switch(_operation) do {
        default {
                private["_err"];
                _err = format["%1 does not support ""%2"" operation", _logic, _operation];
                //ERROR_WITH_TITLE(str _logic,_err);
                diag_log _err;
        };
        case "create": {
                // Create a module object for settings and persistence
                _logic = [] call CBA_fnc_hashCreate;
				[_logic, "class", ALIVE_fnc_baseClassHash] call CBA_fnc_hashSet;
                _result = _logic;
        };
        case "destroy": {
				[_logic, "class"] call CBA_fnc_hashRem;
				
				// wolffy - could do a loop to destroy all subclass vars?
				/*
				{
					[_logic, _x] call CBA_fnc_hashRem;
				} forEach (_logic select 1);
				*/
				
				_logic = nil;
        };
};
TRACE_1("baseClassHash - output",_result);
_result;
