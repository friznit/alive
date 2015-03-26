#include <\x\alive\addons\amb_civ_population\script_component.hpp>
SCRIPT(addCivilianActions);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_addCivilianActions

Description:
Adds civilian actions

Parameters:

Returns:
Bool - true

Examples:
(begin example)
//
_result = _unit call ALIVE_fnc_addCivilianActions;
(end)

See Also:

Author:
Highhead
---------------------------------------------------------------------------- */

private ["_object","_operation","_id","_condition","_text"];

_object = _this select 0;

if !(side _object == CIVILIAN && {isnil QGVAR(ROLES_DISABLED)}) exitwith {};

_role = "townelder";
_text = format["Talk to %1",_role];
_params = [];
_code = {_object = _this select 0; _caller = _this select 1; _params = _this select 3; [_object,_caller] call ALiVE_fnc_SelectRoleAction};
_condition = format["_target getvariable [%1,false]",str(_role)];

_id = _object addAction [
	_text,
	_code,
	_params,
	1,
	false,
	true,
	"",
	_condition
];

_role = "major";
_text = format["Talk to %1",_role];
_params = [];
_code = {_object = _this select 0; _caller = _this select 1; _params = _this select 3; [_object,_caller] call ALiVE_fnc_SelectRoleAction};
_condition = format["_target getvariable [%1,false]",str(_role)];

_id = _object addAction [
	_text,
	_code,
	_params,
	1,
	false,
	true,
	"",
	_condition
];

_role = "priest";
_text = format["Talk to %1",_role];
_params = [];
_code = {_object = _this select 0; _caller = _this select 1; _params = _this select 3; [_object,_caller] call ALiVE_fnc_SelectRoleAction};
_condition = format["_target getvariable [%1,false]",str(_role)];

_id = _object addAction [
	_text,
	_code,
	_params,
	1,
	false,
	true,
	"",
	_condition
];

_role = "muezzin";
_text = format["Talk to %1",_role];
_params = [];
_code = {_object = _this select 0; _caller = _this select 1; _params = _this select 3; [_object,_caller] call ALiVE_fnc_SelectRoleAction};
_condition = format["_target getvariable [%1,false]",str(_role)];

_id = _object addAction [
	_text,
	_code,
	_params,
	1,
	false,
	true,
	"",
	_condition
];

_role = "politician";
_text = format["Talk to %1",_role];
_params = [];
_code = {_object = _this select 0; _caller = _this select 1; _params = _this select 3; [_object,_caller] call ALiVE_fnc_SelectRoleAction};
_condition = format["_target getvariable [%1,false]",str(_role)];

_id = _object addAction [
	_text,
	_code,
	_params,
	1,
	false,
	true,
	"",
	_condition
];

_text = "Arrest";
_params = [];
_code = {_object = _this select 0; _caller = _this select 1; _params = _this select 3; [_object] joinsilent (group _caller); _object setvariable ['detained',true,true]};
_condition = "!(_target getvariable ['detained',false])";

_id = _object addAction [
	_text,
	_code,
	_params,
	1,
	false,
	true,
	"",
	_condition
];

_text = "Release";
_params = [];
_code = {_object = _this select 0; _caller = _this select 1; _params = _this select 3; [_object] joinsilent grpNull; _object setvariable ['detained',false,true]};
_condition = "_target getvariable ['detained',false]";

_id = _object addAction [
	_text,
	_code,
	_params,
	1,
	false,
	true,
	"",
	_condition
];

_text = "Search";
_params = [];
_code = {_object = _this select 0; _caller = _this select 1; _params = _this select 3; _caller action ["Gear", _object]};
_condition = "true";

_id = _object addAction [
	_text,
	_code,
	_params,
	1,
	false,
	true,
	"",
	_condition
];

true;