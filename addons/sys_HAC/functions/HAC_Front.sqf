private ["_logic","_FrontA"];

_logic = _this select 0;

	private ["_pos","_att","_XAxis","_YAxis","_dir","_isRec"];
	_pos = position _logic;
	//_att = triggerArea HET_FA;
	_XAxis = 200;
	_YAxis = 50;
	_dir = 0;
	_isRec = true;

	_FrontA = createLocation ["Name", _pos, _XAxis, _YAxis];
	_FrontA setDirection _dir;
	_FrontA setRectangular _isRec;

	if (_logic getvariable "HAC_HQ_Debug") then {
		private ["_shape","_ia"];
		_shape = "ELLIPSE";
		if (_isRec) then {_shape = "RECTANGLE"};
		_FrontA setText "FrontA";
		_ia = "markFront" + str (_FrontA);
		_ia = createMarker [_ia,_pos];
		_ia setMarkerColor (_logic getvariable ["HAC_HQ_Color","ColorRed"]);
		_ia setMarkerShape _shape;
		_ia setMarkerSize [_XAxis, _YAxis];
		_ia setMarkerDir _dir;
		_ia setMarkerBrush "Border";
		_ia setMarkerColor "ColorKhaki";

		[_ia, _logic, _FrontA] spawn
			{
			private ["_ia","_logic","_FrontA"];
			_ia = _this select 0;
			_logic = _this select 1;
			_FrontA = _this select 2;
			waitUntil
				{
				sleep 5;
				not (isNull (_logic getvariable "HAC_HQ"))
				};
			
			while {not (isNull (_logic getvariable "HAC_HQ"))} do
				{
				sleep 5;

				_ia setMarkerPos (position _FrontA);
				_ia setMarkerDir (direction _FrontA);
				_ia setMarkerSize (size _FrontA)
				};
			}
	};
_logic setvariable ["FrontA",_FrontA];
_logic setvariable ["HAC_HQ_Fronts",true];
