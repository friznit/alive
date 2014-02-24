	private ["_type","_startposi","_startroads","_dire","_grop","_veh","_pos","_facs","_type"];
	
    _startposi = _this select 0;
	_dire = _this select 1;
	_grop = _this select 2;
    
	_startroads = _startposi nearRoads 200;
	_facs = factionsConvoy;
	_pos = position ((_startroads) call BIS_fnc_selectRandom);
    
    _pos = [_pos, 0, 50, 5, 0, 20, 0] call BIS_fnc_findSafePos;
	
    if (count _this > 3) then {
		_type = ([0, [_facs], _this select 3] call ALiVE_fnc_findVehicleType);
	} else {
		_type = ([0, [_facs], "LandVehicle"] call ALiVE_fnc_findVehicleType);
	};

    if (CONVOY_GLOBALDEBUG) then {
		["Spawning %1", _type] call ALiVE_fnc_DumpR;
	};
    
    _type = _type call BIS_fnc_selectRandom;
    
    _veh = [_pos, _dire, _type, _grop] call BIS_fnc_spawnVehicle;
	_veh;
