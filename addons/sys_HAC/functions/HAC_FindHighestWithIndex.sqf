	private ["_logic","_array","_ix","_highest","_valMax","_valAct","_index","_clIndex"];

	_array = _this select 0;
	_ix = _this select 1;
    _logic = _this select ((count _this)-1);

	_highest = [];

	if ((count _array) > 0) then 
		{
		_highest = _array select 0;
		_index = 0;
		_clIndex = 0;
		_valMax = _highest select _ix;

			{
			_valAct = _x select _ix;

			if (_valAct > _valMax) then
				{
				_highest = _x;
				_valMax = _valAct;
				_clIndex = _index
				};

			_index = _index + 1
			}
		foreach _array
		};

	[_highest,_clIndex];