	private ["_logic","_gp","_ct","_ncVeh"];

	_gp = _this select 0;
	_ncVeh = _this select 1;

	_ct = 0;
	
		{
		_ct = _ct + (count (magazines (vehicle _x)));
		if ((typeOf (vehicle _x)) in _ncVeh) then {_ct = _ct + (count (magazines _x))}
		}
	foreach (units _gp);

	_ct