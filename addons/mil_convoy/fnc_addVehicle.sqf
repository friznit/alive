	#include <\x\alive\addons\mil_convoy\script_component.hpp>

    private ["_logic","_type","_startposi","_startroads","_dire","_grop","_veh","_pos","_facs","_type"];
	
    _logic = _this select 0;
    _startposi = _this select 1;
	_dire = _this select 2;
	_grop = _this select 3;
    
    _facs = _logic getvariable ["conv_factions_setting","OPF_F"];
    
	//_startroads = _startposi nearRoads 200;
	//_pos = getposATL ((_startroads) call BIS_fnc_selectRandom);
    _pos = _startposi; //[_pos, 0, 100, 8, 0, 20, 0] call BIS_fnc_findSafePos;
	
    if (count _this > 4) then {
		_type = ([3, [_facs], _this select 4] call ALiVE_fnc_findVehicleType);
	} else {
		_type = ([3, [_facs], "LandVehicle"] call ALiVE_fnc_findVehicleType);
	};
    _type = _type call BIS_fnc_selectRandom;
    
    if (_logic getvariable ["conv_debug_setting",false]) then {
		["Spawning %1", _type] call ALiVE_fnc_DumpR;
	};
    
    _veh = [_pos, _dire, _type, _grop] call BIS_fnc_spawnVehicle;
    (_veh select 0) setdir _dire;
	_veh;
