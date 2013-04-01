#include <\x\alive\addons\sys_rwg\script_component.hpp>
SCRIPT(CQBsortStrategicHouses);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_CQBsortStrategicHouses

Description:
Sort buildings into strategic and non-strategic arrays

Parameters:
Array - List of all enterable houses

Returns:
Array - An array containing randomly selected strategic and non strategic
buidlings including the maximum number of building positions for 
the building.

Examples:
(begin example)
_spawnhouses = call ALIVE_fnc_getAllEnterableHouses;
_result = [_spawnhouses] call ALIVE_fnc_CQBsortStrategicHouses;
CQBpositionsStrat = _result select 0; // [strathouse1, strathouse2];
CQBpositionsReg = _result select 1; // [nonstrathouse1, nonstrathouse2];
(end)

See Also:
- <ALIVE_fnc_getEnterableHouses>
- <ALIVE_fnc_getAllEnterableHouses>

Author:
Highhead
Wolffy.au
---------------------------------------------------------------------------- */

private ["_spawnhouses","_BuildingTypeStrategic","_nonstrathouses","_strathouses","_cqb_spawn_intensity","_triglist","_blackzone"];

PARAMS_1(_spawnhouses);
ASSERT_TRUE(typeName _spawnhouses == "ARRAY",str _spawnhouses);
DEFAULT_PARAM(1,_BuildingTypeStrategic,[]);
DEFAULT_PARAM(2,_blackzone,"ALIVE_CQB_%1");
if (isnil "CQB_spawn") then {CQB_spawn = 2};

_triglist = [];

// check blacklisted areas
private ["_n"];
for [{_n = 0},{_n < 100},{_n = _n + 1}] do {
	if not (isNil format [_blackzone,_n]) then {
		_triglist = _triglist + [call compile format [_blackzone,_n]];
	};
};

_strathouses = [];
_nonstrathouses = [];

{
	private ["_pos"];
	_pos = getPosATL _x;
	// Check if spawn position is NOT within a blacklist trigger
	if ({[_x, _pos] call BIS_fnc_inTrigger} count _triglist == 0) then {
		if (typeOf _x in _BuildingTypeStrategic) then {
			if ((random 1) > 0.3) then {
				_strathouses set [count _strathouses, _x];
			};
		} else {
			if ((random 1) < (CQB_spawn / 10)) then {
				_nonstrathouses set [count _nonstrathouses, _x];
			};
		};
	};
} forEach _spawnhouses;

[_strathouses,_nonstrathouses];
