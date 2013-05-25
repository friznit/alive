	private ["_logic","_cargo","_ammoBox","_spawnPos","_parachute","_parachutePos","_height1","_height2","_height3","_speed","_dir","_vel","_pos","_off","_type","_benef"];

	_cargo = _this select 0;
	_ammoBox = _this select 1;
	_benef = _this select 2;
    _logic = _this select ((count _this)-1);
	_type = typeOf _ammoBox;

	_dir = getDir _cargo;

	_parachutePos = _cargo modelToWorld [(random 10) - 5,-10,-10];

	_parachute = createVehicle ["ParachuteMediumWest_EP1", [_parachutePos select 0,_parachutePos select 1,2000], [], 0.5, "NONE"];
	_parachute setPos _parachutePos;
	_parachute setDir _dir;

	_vel = velocity _cargo;

	_parachute setVelocity [(_vel select 0)/2,(_vel select 1)/2,(_vel select 2)/2];

	_ammoBox setDir _dir;

	_ammoBox attachTo [_parachute,[0,0,1]];

	sleep 2;

	waitUntil
		{
		_height1 = (getposATL _ammoBox) select 2;
		sleep 0.005;
		_height2 = (getposATL _ammoBox) select 2;
		_speed = abs ((velocity _ammoBox) select 2);
		if (_height2 > _height1) then {_parachute setVelocity [0,0,-20]};
		sleep 0.005;
		_height3 = (getposATL _ammoBox) select 2;

		((_height2 < 0.05) or (_height3 > _height2) or (_speed < 0.001) or (isNull _parachute))
		};

	detach _ammoBox;

	_pos = getposATL _ammoBox;

	deleteVehicle _ammoBox;

	_ammoBox = createVehicle [_type, _pos, [], 0, "NONE"];

	_off = _ammoBox modelToWorld [0,0,0] select 2;
	if (_off < 2) then 
		{
		_ammoBox setPos [_pos select 0,_pos select 1,0];
		} 
	else 
		{
		_off = getposATL _ammoBox select 2;
		_ammoBox setPosATL [_pos select 0,_pos select 1,(_pos select 2)-_off];
		};

	_benef setVariable ["isBoxed",_ammoBox];

	if not (isNull _parachute) then 
		{
		_parachute setVelocity [0,0,0]
		};

	sleep 5;

	if not (isNull _parachute) then 
		{
		deleteVehicle _parachute
		};