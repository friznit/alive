	private ["_logic","_pos","_lz"];

	_pos = _this select 0;
    _logic = _this select ((count _this)-1);
	_lz = objNull;

	_pos = [_pos,100] call ALiVE_fnc_findFlatArea;

	_lz = createVehicle ["Land_HelipadEmpty_F", _pos, [], 0, "NONE"];
	_i01 = [_pos,time,"markLZ",(_logic getvariable ["HAC_HQ_Color","ColorRed"]),"ICON","mil_dot","LZ","",_logic] call ALiVE_fnc_HAC_Mark;
	_lz;