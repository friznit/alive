	private ["_logic","_source","_distT","_angle","_dXb","_dYb","_px","_py","_pz"];

	_source = _this select 0;
	_angle = _this select 1;
	_distT = _this select 2;
    _logic = _this select ((count _this)-1);

	_dXb = _distT * (sin _angle);
	_dYb = _distT * (cos _angle);

	_px = (_source select 0) + _dXb;
	_py = (_source select 1) + _dYb;

	_pz = getTerrainHeightASL [_px,_py];

	[_px,_py,_pz]