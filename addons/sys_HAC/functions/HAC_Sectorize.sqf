	private ["_logic","_ctr","_lng","_ang","_nbr","_EdgeL","_rd","_main","_step","_X1","_Y1","_posX","_posY","_centers","_first",
	"_sectors","_centers2","_Xa","_Ya","_dXa","_dYa","_dst","_ang2","_Xb","_Yb","_dXb","_dYb","_center","_crX","_crY","_crPoint","_sec"];

	_ctr = _this select 0;
	_lng = _this select 1;
	_ang = _this select 2;
	_nbr = _this select 3;
    _logic = _this select ((count _this)-1);

	_EdgeL = _lng/_nbr;
	
	_rd = _lng/2;

	_main = createLocation ["Name", _ctr, _rd, _rd];
	_main setRectangular true;

	_step = _EdgeL;

	_X1 = _ctr select 0;
	_Y1 = _ctr select 1;

	_posX = (_X1 - _rd) + _step/2;
	_posY = (_Y1 - _rd) + _step/2;

	_centers = [[_posX,_posY]];
	_first = false;

	while {(true)} do
		{
		while {(true)} do
			{
			if not (_first) then {_first = true;_posX = _posX + _step};
			if not ([_posX,_PosY] in _main) exitwith {_posX = ((_ctr select 0) - _rd) + _step/2;_first = true};
			_centers set [(count _centers),[_posX,_PosY]];
			_first = false
			};
		_posY = _posY + _step;
		if not ([_posX,_PosY] in _main) exitwith {}
		};

	if not (_ang in [0,90,180,270]) then
		{
		_main setDirection _ang;
		_centers2 = _centers;
		_centers = [];

			{
			_Xa = _x select 0;
			_Ya = _x select 1;
			_dXa = (_X1 - _Xa);
			_dYa = (_Y1 - _Ya);
			_dst = _ctr distance _x;

			_ang2 = _ang + (_dXa atan2 _dYa);

			_dXb = _dst * (sin _ang2);
			_dYb = _dst * (cos _ang2);

			_Xb = _X1 + _dXb;
			_Yb = _Y1 + _dYb;
			_center = [_Xb,_Yb];
			_centers set [(count _centers),_center]
			}
		foreach _centers2
		};
	
	_sectors = [];

		{
		_crX = _x select 0;
		_crY = _x select 1;
		_crPoint = [_crX,_crY,0];
		_sec = createLocation ["Name", _crPoint, _EdgeL/2, _EdgeL/2];
		_sec setDirection _ang;
		_sec setRectangular true;

		_sectors set [(count _sectors),_sec];
		}
	foreach _centers;

	[_sectors,_main]