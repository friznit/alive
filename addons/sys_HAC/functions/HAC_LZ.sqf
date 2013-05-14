	private ["_logic","_pos","_lz","_rds","_isFlat","_posX","_posY"];

	_pos = _this select 0;
    _logic = _this select ((count _this)-1);

	_posX = -1;
	_posY = -1;
	_rds = 50;

	_lz = objNull;

	_isFlat = [];

	while {_rds <= 250} do
		{
		_isFlat = _pos isFlatEmpty [30,_rds,1.5,30,0,false,objNull];

		if ((count _isFlat) > 1) exitWith
			{
			_posX = _isFlat select 0;
			_posY = _isFlat select 1;
			};

		_rds = _rds + 50;
		};

	if (_posX > 0) then
		{
		_lz = createVehicle ["Land_HelipadEmpty_F", [_posX,_posY,0], [], 0, "NONE"];
		//_i01 = [[_posX,_posY],str (random 100),"markLZ","ColorRed","ICON","mil_dot","LZ","",_logic] call ALiVE_fnc_HAC_Mark
		};

	_lz;