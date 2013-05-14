	private ["_logic","_name","_pos","_cl","_shape","_size","_dir","_alpha","_type","_brush","_text","_i"];	

	_name = _this select 0;
	_pos = _this select 1;
	_cl = _this select 2;
	_shape = _this select 3;
    _logic = _this select ((count _this)-1);

	_shape = toUpper (_shape);

	_size = _this select 4;
	_dir = _this select 5;
	_alpha = _this select 6;

	if not (_shape == "ICON") then {_brush = _this select 7} else {_type = _this select 7};
	_text = _this select 8;

	if not ((typename _pos) == "ARRAY") exitWith {};
	if ((_pos select 0) == 0) exitWith {};
	if ((count _pos) < 2) exitWith {};
	//diag_log format ["BB mark: %1 pos: %2 col: %3 size: %4 dir: %5 text: %6",_name,_pos,_cl,_size,_dir,_text];
	if (isNil "_pos") exitWith {};

	_i = _name;
	_i = createMarker [_i,_pos];
	_i setMarkerColor _cl;
	_i setMarkerShape _shape;
	_i setMarkerSize _size;
	_i setMarkerDir _dir;
	if not (_shape == "ICON") then {_i setMarkerBrush _brush} else {_i setMarkerType _type};
	_i setMarkerAlpha _alpha;
	_i setmarkerText _text;

	_i