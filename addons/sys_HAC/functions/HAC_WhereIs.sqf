	private ["_logic","_point","_Rpoint","_angle","_diffA","_axis","_isLeft","_isFlanking","_isBehind"];	

	_point = _this select 0;
	_rPoint = _this select 1;
	_axis = _this select 2;
    _logic = _this select ((count _this)-1);

	_angle = [_rPoint,_point,0,_logic] call ALiVE_fnc_HAC_AngTowards;

	_isLeft = false;
	_isFlanking = false;
	_isBehind = false;

	if (_angle < 0) then {_angle = _angle + 360};
	if (_axis < 0) then {_axis = _axis + 360};

	_diffA = _angle - _axis;

	if (_diffA < 0) then {_diffA = _diffA + 360};

	if (_diffA > 180) then 
		{
		_isLeft = true
		};

	if ((_diffA > 60) and (_diffA < 300)) then 
		{
		_isFlanking = true
		};

	if ((_diffA > 120) and (_diffA < 240)) then 
		{
		_isBehind = true
		};

	[_isLeft,_isFlanking,_isBehind]