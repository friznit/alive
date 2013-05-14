	private ["_logic","_veh","_alt","_keep"];
	
	_veh = _this select 0;
	_alt = _this select 1;
    _logic = _this select ((count _this)-1);

	_keep = true;

	while {_keep} do
		{
		sleep 0.1;
		if (isNull _veh) exitWith {};
		if not (alive _veh) exitWith {};
		_keep = _veh getVariable ["KeepAlt",true];
		_veh flyInHeight _alt
		};

	_veh setVariable ["KeepAlt",nil]