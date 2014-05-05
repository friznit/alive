#include <\x\alive\addons\mil_cqb\script_component.hpp>
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

scopename "main";

PARAMS_1(_spawnhouses);
ASSERT_TRUE(typeName _spawnhouses == "ARRAY",str _spawnhouses);
DEFAULT_PARAM(1,_BuildingTypeStrategic,[]);
DEFAULT_PARAM(2,_density,1000);
DEFAULT_PARAM(3,_blackzone,[]);
DEFAULT_PARAM(4,_whitezone,[]);

_CQB_spawn = _logic getVariable ["CQB_spawn", 1];

_strathouses = [];
_nonstrathouses = [];

{ // forEach
    private ["_obj", "_positions"];
	_obj = _x;
    _positions = [_obj] call ALiVE_fnc_getBuildingPositions;
    
    if !(_positions isEqualTo []) then {
		private ["_pos", "_collect"];
		_pos = getPosATL _obj;
		_collect = true;
		
		if !(_whitezone isEqualTo []) then { // Ensure within white zone
			_collect = false;
			{ // forEach
				if ([_x, _pos] call BIS_fnc_inTrigger) exitWith {
					_collect = true;
				};
			} forEach _whitezone;
		} else { // Ensure not in black zone
			{ // forEach
				if ([_x, _pos] call BIS_fnc_inTrigger) exitWith {
					_collect = false;
				};
			} forEach _blackzone;
		};
		
		if (_collect) then {
			private ["_isStrategic", "_addHouse", "_houses"];
			_isStrategic = (typeOf _obj) in _BuildingTypeStrategic;
			_addHouse = true;
			_houses = if (_isStrategic) then {_strathouses} else {_nonstrathouses};
			
			{ // forEach
				if ((_pos distance (getposATL _x)) < _density) exitWith {
					_addHouse = false;
					
					if (_isStrategic) then {
						_addHouse = true;
						
						{ // forEach
							if ((_pos distance (getposATL _x)) < 60) exitWith {
								_addHouse = false;
							};
						} forEach _houses;
						
						if (_addHouse) then {
							_addHouse = ((random 1) < (_CQB_spawn / 30)) && {!(_obj in _houses)}
						};
						
					} else {
						if (((random 1) < (_CQB_spawn / 100)) && {!(_obj in _houses)}) then {
							_addHouse = true;
						};
					};
				};
			} forEach _houses;
			
			if (_addHouse) then {
				_houses set [count _houses, _obj];
			};
		};
    };
} forEach _spawnhouses;

[_strathouses,_nonstrathouses];
