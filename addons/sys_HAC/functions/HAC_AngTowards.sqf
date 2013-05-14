	private ["_logic","_source0", "_target0", "_rnd0","_dX0","_dY0","_angleAzimuth0"];
	_source0 = _this select 0;
	_target0 = _this select 1;
	_rnd0 = _this select 2;
    _logic = _this select ((count _this)-1);

	_dX0 = (_target0 select 0) - (_source0 select 0);
	_dY0 = (_target0 select 1) - (_source0 select 1);

	_angleAzimuth0 = (_dX0 atan2 _dY0) + (random (_rnd0 * 2)) - _rnd0;

	_angleAzimuth0