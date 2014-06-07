#include <\x\alive\addons\sys_logistics\script_component.hpp>

/*
private ["_logic","_operation","_id","_condition"];

_logic = [_this, 0, objNull, [objNull,[]]] call BIS_fnc_param;
_operation = [_this, 1, "", [""]] call BIS_fnc_param;

switch (typename _logic) do {
    case ("ARRAY") : {_logic = _logic select 0};
    default {};
};

switch (_operation) do {
	case ("attach") : {_condition = "isnil {_target getvariable 'ALiVE_SYS_LOGISTICS_ATTACHED'}"};
    case ("detach") : {_condition = "!(isnil {_target getvariable 'ALiVE_SYS_LOGISTICS_ATTACHED'})"}; 
};

_id = _logic addAction [
	_operation,
	{[MOD(SYS_LOGISTICS),_this select 3,[_this select 0,_this select 1]] call ALiVE_fnc_logistics},
	_operation,
	1,
	false,
	true,
	"",
	_condition
];

_id;
*/