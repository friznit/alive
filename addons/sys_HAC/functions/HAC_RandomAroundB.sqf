     //[[_posX,_posY],100,_logic] call ALiVE_fnc_HAC_RandomAround
	private ["_logic","_pos","_X","_Y","_radius","_radiusMax","_angle"];

	_pos = _this select 0;
	_radiusMax = _this select 1;
    _logic = _this select ((count _this)-1);

	_angle = random 360;
	_radius = random _radiusMax;

	_X = _radius * sin _angle;
	_Y = _radius * cos _angle;

	_pos = [(_pos select 0) + _X,(_pos select 1) + _Y,0];

	_pos