	private ["_logic","_p1","_p2","_pc","_d","_d0","_d1","_d2","_x1","_y1","_x2","_y2","_xc","_yc","_a","_b"];

	_p1 = _this select 0;//ATL
	_p2 = _this select 1;//ATL
	_pc = _this select 2;//ATL
    _logic = _this select ((count _this)-1);

	_d0 = _p1 distance _p2;
	_d1 = _pc distance _p1;
	_d2 = _pc distance _p2;

	_d = _d1;

	switch (true) do
		{
		case (((_d0 * _d0) + (_d1 * _d1)) <= (_d2 * _d2)) : {_d = _d1};
		case (((_d0 * _d0) + (_d2 * _d2)) <= (_d1 * _d1)) : {_d = _d2};
		default
			{
			_x1 = _p1 select 0;
			_y1 = _p1 select 1;

			_x2 = _p2 select 0;
			_y2 = _p2 select 1;

			_xc = _pc select 0;
			_yc = _pc select 1;

			_a = (_y2 - _y1)/(_x2 - _x1);
			_b = _y1 - _x1 * _a;

			_d = abs (((_a/_b) * _xc) + ((-1/_b) * _yc) + 1)/(sqrt (((_a/_b) * (_a/_b)) + (1/(_b * _b))));
			}
		};

	_d