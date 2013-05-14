	private ["_logic","_array","_final","_random","_select"];

	_array = _this select 0;
    _logic = _this select ((count _this)-1);

	_final = [];

	while {((count _array) > 0)} do
		{
		_select = floor (random (count _array));
		_random = _array select _select;
		
		_final set [(count _final),_random];
		_array = _array - [_random];

		//_array set [_select,"Delete"];
		//_array = _array - ["Delete"]
		};

	_final