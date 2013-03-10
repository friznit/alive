#include <\x\alive\addons\main\script_component.hpp>
SCRIPT(baseClass);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_BaseClass
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

_logic = [_this, 0, nil, [objNull]] call BIS_fnc_param;
_operation = [_this, 1, "", ["",nil]] call BIS_fnc_param;
_args = [_this, 2, nil] call BIS_fnc_param;

switch(_operation) do {
	default {
		private["_class"];
		if(typeName _logic != "OBJECT") then {
			_class = "undefined logic";
		} else {
			_class = _logic getVariable ["class", "unknown Class"];
		};
		["%1 does not support %2 operation", _class, _operation] call BIS_fnc_log;
	};
	case "init": {
		// Create a module object for settings and persistence
		ISNILS(sideLogic,createCenter sideLogic);
		_logic = (createGroup sideLogic) createUnit ["LOGIC", [0,0], [], 0, "NONE"];
		_logic setVariable ["class", ALIVE_fnc_baseClass];
		_logic;
	};
	case "destroy": {
		_logic setDamage 1;
		deleteVehicle _logic;
	};
};

