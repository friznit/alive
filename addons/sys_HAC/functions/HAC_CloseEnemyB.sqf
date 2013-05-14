	private ["_logic","_pos","_eG","_limit","_tooClose","_dstM","_dstAct","_closest"];

	_pos = _this select 0;
	_eG = _this select 1;
	_limit = _this select 2;
    _logic = _this select ((count _this)-1);

	_tooClose = false;

	_dstM = 100000;
	_closest = _eG select 0;

		{
		_dstAct = (vehicle (leader _x)) distance _pos;
		if (_dstAct < _dstM) then {_closest = _x;_dstM = _dstAct}
		}
	foreach _eG;

	if (_dstM < _limit) then {_tooClose = true};

	[_tooClose,_dstM,_closest]