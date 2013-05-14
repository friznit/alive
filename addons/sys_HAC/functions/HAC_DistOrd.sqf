private ["_logic","_array","_first","_point","_dst","_limit","_final","_VL"];

	_array = _this select 0;
	_point = _this select 1;
	_limit = _this select 2;
    _logic = _this select ((count _this)-1);

	_first = [];
	_final = [];

		{
		_VL = vehicle (leader _x);
		_dst = round (_VL distance _point);
		if (_dst <= _limit) then {_first set [_dst,_x]}
		}
	foreach _array;

		{
		if not (isNil "_x") then {_final set [(count _final),_x]}
		}
	foreach _first;

	_first = nil;

	_final