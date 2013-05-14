	private ["_logic","_pos","_onMap","_pX","_pY","_mapMinX","_mapMinY"];

	_pos = _this select 0;
    _logic = _this select ((count _this)-1);
	_onMap = true;

	_pX = _pos select 0;
	_pY = _pos select 1;

	_mapMinX = 0;
	_mapMinY = 0;

	if not (isNil "HAC_BB_MC") then
		{
		_mapMinX = _logic getvariable "HAC_BB_MapXMin";
		_mapMinY = _logic getvariable "HAC_BB_MapYMin"
		};

	if (_pX < _mapMinX) then 
		{
		_onMap = false
		}
	else
		{
		if (_pY < _mapMinY) then
			{
			_onMap = false
			}
		else
			{
			if (_pX > _logic getvariable "HAC_BB_MapXMax") then
				{
				_onMap = false
				}
			else
				{
				if (_pY > _logic getvariable" HAC_BB_MapYMax") then
					{
					_onMap = false
					}
				}
			}
		};

	_onMap