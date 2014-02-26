#include <\x\alive\addons\mil_convoy\script_component.hpp>

private ["_choices","_bias","_result","_j"];
_choices = _this select 0;
_bias = _this select 1;

_result = [];
_j = 0;
{
	for "_i" from 1 to _x do {
        _result set [count _result, _choices select _j];
	};
	_j = _j + 1;
} forEach _bias;

//hint str _result;

_result call BIS_fnc_selectRandom;
