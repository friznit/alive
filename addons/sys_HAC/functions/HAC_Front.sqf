_ia = "";_ib = "";_ic = "";_id = "";_ie = "";_if = "";_ig = "";_ih = "";

_logic = _this select ((count _this)-1);
player sidechat format["%1",_logic];

if not (isNil ("HET_FA")) then 
	{
	_pos = position HET_FA;
	_att = triggerArea HET_FA;
	_XAxis = _att select 0;
	_YAxis = _att select 1;
	_dir = _att select 2;
	_isRec = _att select 3;

	_FrontA = createLocation ["Name", _pos, _XAxis, _YAxis];
	_FrontA setDirection _dir;
	_FrontA setRectangular _isRec;

	if (_logic getvariable "HAC_HQ_Debug") then 
		{
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

		[_ia] spawn
			{
			_ia = _this select 0;

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
	};

_logic setvariable ["FrontA",_FrontA];
_logic setvariable ["HAC_HQ_Fronts",true];