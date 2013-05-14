	private ["_logic","_array","_final","_highest","_ix"];

	_array = _this select 0;
    _logic = _this select ((count _this)-1);

	_final = [];

	while {((count _array) > 0)} do
		{
		_highest = [_array,3,_logic] call ALiVE_fnc_HAC_FindHighestWithIndex;
		_ix = _highest select 1;
		_highest = _highest select 0;
		
		_final set [(count _final),_highest];

		_array set [_ix,"Delete"];
		_array = _array - ["Delete"]
		};

	_final