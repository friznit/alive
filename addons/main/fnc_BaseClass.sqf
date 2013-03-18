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
private ["_logic","_operation","_args"];

// Constructor - create a new instance
if(isNil "_this") exitWith {
	// Create a module object for settings and persistence
	[sideLogic] call CBA_fnc_createCenter;
        _logic = (createGroup sideLogic) createUnit ["LOGIC", [0,0], [], 0, "NONE"];
        _logic setVariable ["class", ALIVE_fnc_baseClass];
        _logic;
};

PARAMS_1(_logic);
DEFAULT_PARAM(1,_operation,"");
DEFAULT_PARAM(2,_args,[]);

switch(_operation) do {
        default {
                private["_err"];
                _err = format["%1 does not support %2 operation", _logic, _operation];
                ERROR_WITH_TITLE(str _logic,_err);
        };
        case "destroy": {
                _logic setDamage 1;
                deleteVehicle _logic;
        };
};
