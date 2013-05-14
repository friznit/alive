	//based on Muzzleflash' function
	private ["_logic","_pos","_xPos","_yPos","_a","_dir","_angle","_mag","_nX","_nY","_temp"];

	_pos = _this select 0;
	_a = _this select 1;
    _logic = _this select ((count _this)-1);

	_xPos = _pos select 0;
	_yPos = _pos select 1;

	_dir = random 360;

	_mag = sqrt ((random _a) * _a);
	_nX = _mag * (sin _dir);
	_nY = _mag * (cos _dir);

	_pos = [_xPos + _nX, _yPos + _nY,0];  

	_pos;