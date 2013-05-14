	private ["_logic","_pos","_tgtPos","_radius","_dir","_posASL","_tgtPosASL","_pool","_posX","_posY","_posX2","_posY2","_pool2","_isBlock","_pool3","_elevImp","_terrImp","_terr","_elev","_final","_value",
	"_urban","_forest","_gp","_dst","_vh"];

	_pos = _this select 0;//ATL
	_tgtPos = _this select 1;//ATL
	_tgtPos = [_tgtPos select 0,_tgtPos select 1,1.5];
	_radius = _this select 2;
	_elevImp = 1;
    _logic = _this select ((count _this)-1);
    _thisTMP = _this - [_logic];
    
	if ((count _thisTMP) > 3) then {_elevImp = _thisTMP select 3};
	_terrImp = 1;
	if ((count _thisTMP) > 4) then {_terrImp = _thisTMP select 4};
	_gp = grpNull;
	if ((count _thisTMP) > 5) then {_gp = _thisTMP select 5};
	_vh = vehicle (leader _gp);
	
	_tgtPosASL = [_tgtPos select 0,_tgtPos select 1,getTerrainHeightASL [_tgtPos select 0,_tgtPos select 1] + 1.5];

	_pool = [];

	_posX = _pos select 0;
	_posY = _pos select 1;

	for "_i" from 1 to 100 do
		{
		_posX2 = _posX + (random (2 * _radius)) - _radius;
		_posY2 = _posY + (random (2 * _radius)) - _radius;

		if not (surfaceIsWater [_posX2,_posY2]) then {_pool set [(count _pool),[_posX2,_posY2,1]]}
		};

	_pool2 = [];

		{
		_isBlock = terrainIntersect [_x, _tgtPos];
		if not (_isBlock) then
			{
			_pool2 set [(count _pool2),_x]
			}
		}
	foreach _pool;

	if ((count _pool2) == 0) then {_pool2 = _pool};

	_pool3 = [];

		{
		_isBlock = lineIntersects [[_x select 0,_x select 1,getTerrainHeightASL [_x select 0,_x select 1] + 1], _tgtPosASL];
		if not (_isBlock) then
			{
			_pool3 set [(count _pool3),_x]
			}
		}
	foreach _pool2;

	if ((count _pool3) == 0) then {_pool3 = _pool2};

		{
		_value = [_x,1,1,_logic] call ALiVE_fnc_HAC_TerraCognita;
		_urban = _value select 0;
		_forest = _value select 1;

		_terr = (_urban + _forest) * 100;

		_posX = _x select 0;
		_posY = _x select 1;
		_elev = getTerrainHeightASL [_posX,_posY];
		_dst = 0;
		if not (isNull _gp) then
			{
			_dst = ([_posX,_posY] distance _vh)/1000
			};

		_x set [(count _x),((_terr * _terrImp) + (_elev * _elevImp))/(1 + _dst)]
		}
	foreach _pool3;

	_pool3 = [_pool3,_logic] call ALiVE_fnc_HAC_ValueOrd;

	_final = [];

		{
		_final set [(count _final),[_x select 0,_x select 1]]
		}
	foreach _pool3;

	_final