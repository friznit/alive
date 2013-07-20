	private ["_logic","_loc","_ps","_space","_center","_angle","_r1","_r2","_sx","_sy","_cnt","_dmax","_pf","_dst","_pfMain","_check","_indx","_pfbis","_dmaxbis","_cX","_cY","_allIn","_mpl","_pX","_pY"];
 diag_log format ["LocMultiTransform: %1",_this];
	_loc = _this select 0;
	_ps = _this select 1;//array of ATL
	_space = _this select 2;
    _logic = _this select 3;

	_sx = 0;
	_sy = 0;

	{
		_sx = _sx + (_x select 0);
		_sy = _sy + (_x select 1)
	} foreach _ps;

	_cnt = count _ps;

	if not (_cnt > 0) exitWith {};
		
	_center = [_sx/_cnt,_sy/_cnt,0];

	_pf = _ps select 0;

	_dmax = _center distance _pf;

	_indx = 0;

	for "_i" from 0 to ((count _ps) - 1) do
		{
		_check = _ps select _i;

		if (((typeName _check) == "ARRAY") and ((count _check) > 1)) then
			{
			_cX = _check select 0;
			_cY = _check select 1;

			_check = [_cX,_cY,0];

			_dst = _center distance _check;
			if (_dst > _dmax) then
				{
				_pf = _check;
				_indx = _i;
				_dmax = _dst
				}
			}
		};

	_pfMain = _pf;

	_ps set [_indx,"DeleteThis"];
	_ps = _ps - ["DeleteThis"];

	_pf = _ps select 0;

	_dmaxbis = _center distance _pf;

	for "_i" from 0 to ((count _ps) - 1) do
		{
		_check = _ps select _i;

		_cX = _check select 0;
		_cY = _check select 0;

		_check = [_cX,_cY,0];

		_dst = _center distance _check;
		if (_dst > _dmaxbis) then
			{
			_dmaxbis = _dst
			}
		};

	_angle = [_center,_pfMain,0,_logic] call ALiVE_fnc_HAC_AngTowards;

	_r1 = _dmaxbis;
	_r2 = _dmax;

	_loc setPosition _center;
	_loc setDirection _angle;
	_loc setSize [_r1,_r2];

	_allIn = false;

	_mpl = 10;

	while {(not (_allIn) and (_mpl > 0))} do {
		
		_allIn = true;

		_r1 = _dmaxbis/_mpl;
		_loc setSize [_r1,_r2];

		{
			_pX = _x select 0;
			_pY = _x select 1;
			
			if not ([_pX,_pY,0] in _loc) exitWith {_allIn = false};
		} foreach (_ps + [_pfMain]);

		_mpl = _mpl - 0.1;
	};

	_allIn = false;

	_mpl = 10;

	while {(not (_allIn) and (_mpl > 0))} do
		{
		_allIn = true;

		_r2 = _dmax/_mpl;
		_loc setSize [_r1,_r2];

			{
			_pX = _x select 0;
			_pY = _x select 1;

			if not ([_pX,_pY,0] in _loc) exitWith {_allIn = false};
			}
		foreach (_ps + [_pfMain]);

		_mpl = _mpl - 0.1;
		};

	_r1 = _r1 + _space;
	_r2 = _r2 + _space;

	_loc setSize [_r1,_r2];

	true