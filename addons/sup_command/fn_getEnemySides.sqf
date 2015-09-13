params ["_unit"];

_side = str side player;
_sides = ["EAST","WEST","RESISTANCE"] - [_side];
_sidesEnemy = [];

{
	if (((call compile _side) getfriend (call compile _x)) < 0.6) then {_sidesEnemy pushBack _x}
} foreach _sides;

{if (_x == "RESISTANCE") then {_sidesEnemy set [_foreachIndex,"GUER"]}} foreach _sidesEnemy;

_sidesEnemy;
