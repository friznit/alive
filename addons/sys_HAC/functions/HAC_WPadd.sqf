	private 
		[
		"_gp","_pos","_tp","_beh","_CM","_spd","_sts","_crr","_rds","_TO","_frm","_wp","_vh",
		"_topArr","_fFactor","_posX","_posY","_isWater","_wpn","_addedpath","_assVeh","_wps",
		"_isAir","_sPoint","_dst","_dstFirst","_mPoints","_num","_actDst","_angle","_mPoint",
		"_topPoints","_sPosX","_sPosY","_sUrban","_sForest","_sHills","_sFlat","_sSea",
		"_sGr","_count","_friendly","_opt","_j","_samplePos","_sRoads,","_lastDistance",
		"_dstCheck","_pfAll","_sRoads","_mpl","_frds","_this"
		];

	_pfAll = true;
	_logic = _this select 0;
	_gp = _this select 1;

	if ((typeName _gp) == "ARRAY") then {_pfAll = false;_gp = _gp select 0};

	_pos = _this select 2;

	_tp = "MOVE";
	if ((count _this) > 3) then {_tp = _this select 3};

	_beh = "AWARE";
	if ((count _this) > 4) then {_beh = _this select 4};

	_CM = "YELLOW";
	if ((count _this) > 5) then {_CM = _this select 5};

	_spd = "NORMAL";
	if ((count _this) > 6) then {_spd = _this select 6};

	if (_logic getvariable "HAC_HQ_Rush") then 
		{
		if (_spd == "LIMITED") then
			{
			_spd = "NORMAL"
			};

		if (_beh == "SAFE") then
			{
			_beh = "AWARE"
			}
		};
	
	_sts = ["true","deletewaypoint [(group this), 0]"];
	if ((count _this) > 7) then {_sts = _this select 7};

	_crr = true;
	if ((count _this) > 8) then {_crr = _this select 8};

	_rds = 0;
	if ((count _this) > 9) then {_rds = _this select 9};

	_TO = [0,0,0];
	if ((count _this) > 10) then {_TO = _this select 10};

	_frm = formation _gp;
	if ((count _this) > 11) then {_frm = _this select 11};

	if ((typeName _pos) == "OBJECT") then {_pos = position _pos};
    
    //diag_log format ["%1 | %2 | %3 | %4 | %5 | %6 | %7 | %8 | %9 | %10 | %11",_gp,_pos,_tp, _beh,_CM,_spd,_sts,_crr,_rds,_TO,_frm];

	if (isNull _gp) exitWith {diag_log format ["wp error group: %1 type: %3 pos: %2",_gp,_pos,typeOf (vehicle (leader _gp))]};
	if not ((typename _pos == "ARRAY")) exitWith {diag_log format ["wp error group: %1 typ: %3 pos: %2",_gp,_pos,typeOf (vehicle (leader _gp))]};
	if ((count _pos) < 2) exitWith {diag_log format ["wp error group: %1 type: %3 pos: %2",_gp,_pos,typeOf (vehicle (leader _gp))]};
	if ((_pos select 0) == 0) exitWith {diag_log format ["wp error group: %1 type: %3 pos: %2",_gp,_pos,typeOf (vehicle (leader _gp))]};

	if (isNil "_pos") exitWith {diag_log format ["wp error group: %1 type: %3 pos: %2",_gp,_pos,typeOf (vehicle (leader _gp))]};

	_addedpath = false;

	if (isPlayer (leader _gp)) then {_pfAll = false};

	if not (_rds == 0.01) then {[_gp,_logic] call ALiVE_fnc_HAC_WPdel};

	_frds = floor _rds;
	if (_frds == _rds) then
		{
		_pos = [_pos,50,_logic] call ALiVE_fnc_HAC_FlatLandNoRoad
		}
	else
		{
		_rds = 0
		};

	if (((_logic getvariable "HAC_HQ_PathFinding") > 0) and (_pfAll)) then
		{
		_assVeh = assignedVehicle (leader _gp);
		if (isNull _assVeh) then
			{
				{
				_vh = assignedVehicle _x;
				if not (isNull _vh) exitWith {_assVeh = _vh};
				_vh = vehicle _x;
				if not (_vh == _x) exitWith {_assVeh = _vh}
				}
			foreach (units _gp)
			};

		if not (isNull _assVeh) exitWith {};//!

		_isAir = false;
		if not (isNull _assVeh) then
			{
			if (_assVeh isKindOf "Air") then {_isAir = true}
			};

		if not (_isAir) then
			{
			_sPoint = getPosATL (vehicle (leader _gp));

			_wps = waypoints _gp;

			if not ((count _wps) == 0) then
				{
				_sPoint = waypointPosition (_wps select ((count _wps) - 1))
				};

			_dst = _sPoint distance _pos;

			_lastDistance = _dst;

			if (_dst > (_logic getvariable "HAC_HQ_PathFinding")) then
				{
				_dstFirst = _dst;
				_mPoints = [];

				while {(_dst > (_logic getvariable "HAC_HQ_PathFinding"))} do
					{
					_dst = floor (_dst/2)
					};

				_dst = _dst * 2;

				_num = floor (_dstFirst/_dst);

				if (_num >= 2) then
					{
					_actDst = 0;
					_angle = [_sPoint,_pos,0,_logic] call ALiVE_fnc_HAC_AngTowards;

					for "_i" from 1 to _num do
						{
						_actDst = _actDst + _dst;
						_mPoint = [_sPoint,_angle,_actDst,_logic] call ALiVE_fnc_HAC_PosTowards2D;
						_mPoints set [(count _mPoints),_mPoint];
						};

					_topPoints = [];

						{
						_sPosX = _x select 0;
						_sPosY = _x select 1;

						_count = 10;

						_friendly = -1000000;
						_opt = _x;
						_samplePos = _x;
						_mpl = 1.5;

						for "_i" from 1 to _count do
							{
							_samplePos = [_sPosX + ((random ((_logic getvariable "HAC_HQ_PathFinding") * _mpl)) - (((_logic getvariable "HAC_HQ_PathFinding") * _mpl)/2)),_sPosY + ((random ((_logic getvariable "HAC_HQ_PathFinding") * _mpl)) - (((_logic getvariable "HAC_HQ_PathFinding") * _mpl)/2))];

							_topArr = [_samplePos,1,_logic] call ALiVE_fnc_HAC_TerraCognita;

							_sUrban = _topArr select 0;
							_sForest = _topArr select 1;
							_sHills = _topArr select 2;
							_sFlat = _topArr select 3;
							_sSea = _topArr select 4;
							_sGr = _topArr select 5;

							_sUrban = round (_sUrban*100);
							_sForest = round (_sForest*100);
							_sHills = round (_sHills*100);
							_sFlat = round (_sFlat*100);
							_sSea = round (_sSea*100);
							_sGr = round _sGr;

							_sRoads = count (_samplePos nearRoads 100);

							_fFactor = _sUrban + _sForest + _sGr - _sFlat - _sHills;

							if (not (isNull _assVeh) and (_assVeh isKindOf "LandVehicle")) then
								{
								_fFactor = _sFlat + _sHills + _sRoads - _sUrban - _sForest - _sGr
								};

							if (_fFactor > _friendly) then
								{
								_opt = _samplePos;
								_friendly = _fFactor
								}
							};
						
						_posX = _opt select 0;
						_posY = _opt select 1;

						_isWater = surfaceIsWater [_posX,_posY];

						
						_dstCheck = [_posX,_posY] distance _pos;

						if ((not (_isWater)) and (true)) then
							{
							_topPoints set [(count _topPoints),[_posX,_posY,0]];
							_lastDistance = _dstCheck;
							}
						}
					foreach _mPoints;

					if ((count _topPoints) > 0) then
						{
						_wpn = 0;
							{
							//if (HAC_BB_Debug) then {_j = [_x,_gp,(str (random 1000)),"ColorPink","ICON","mil_dot",(str _wpn),"",[0.25,0.25],_logic] call ALiVE_fnc_HAC_Mark};
							_wpn = _wpn + 1;
							_wp = _gp addWaypoint [_x, 0];
							_wp setWaypointType "MOVE";
							_wp setWaypointBehaviour _beh;
							_wp setWaypointCombatMode _CM;
							_wp setWaypointSpeed _spd;
							_wp setWaypointStatements ["true","deletewaypoint [(group this), 0]"];
							_wp setWaypointTimeout [0,0,0];
							_wp setWaypointFormation _frm;
							if ((_crr) and (_wpn == 1)) then {_gp setCurrentWaypoint _wp};
							}
						foreach _topPoints
						};
					_addedpath = true;
					}
				}
			}
		};

	_wp = _gp addWaypoint [_pos, _rds];
	_wp setWaypointType _tp;
	_wp setWaypointBehaviour _beh;
	_wp setWaypointCombatMode _CM;
	_wp setWaypointSpeed _spd;
	_wp setWaypointStatements _sts;
	_wp setWaypointTimeout _TO;
	_wp setWaypointFormation _frm;
	if not (_addedpath) then {if (_crr) then {_gp setCurrentWaypoint _wp}};

	_wp