	private ["_logic","_pos","_eG","_limit","_tooClose","_dst"];

	_pos = _this select 0;
	_eG = _this select 1;
	_limit = _this select 2;
    _logic = _this select ((count _this)-1);

	_tooClose = false;

	_dst = 100000;

		{
		_dst = (vehicle (leader _x)) distance _pos;
		if (_dst < _limit) exitwith {_tooClose = true}
		}
	foreach _eG;

	_tooClose