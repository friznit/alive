HAC_BBArrRefresh = 
	{
	_HAC_BB_arrA_tmp = [
		_logic getvariable "HAC_HQ_Friends",
		_logic getvariable "HAC_HQ_NCrewInfG",
		_logic getvariable "HAC_HQ_CarsG",
		(_logic getvariable "HAC_HQ_HArmorG") + (_logic getvariable "HAC_HQ_LArmorG"),
		_logic getvariable "HAC_HQ_AirG",
		(_logic getvariable "HAC_HQ_NCAirG") + ((_logic getvariable "HAC_HQ_NCCargoG") - (_logic getvariable "HAC_HQ_NCAirG")) + ((_logic getvariable "HAC_HQ_SupportG") - ((_logic getvariable "HAC_HQ_NCAirG") + ((_logic getvariable "HAC_HQ_NCCargoG") - (_logic getvariable "HAC_HQ_NCAirG")))),
		_logic getvariable "HAC_HQ_CCurrent",
		_logic getvariable "HAC_HQ_CInitial",
		_logic getvariable "HAC_HQ_FValue",
		_logic getvariable "HAC_HQ_Morale",
		_logic getvariable "HAC_HQ_KnEnemiesG",
		_logic getvariable "HAC_HQ_EnInfG",
		_logic getvariable "HAC_HQ_EnCarsG",
		((_logic getvariable "HAC_HQ_EnHArmorG") + (_logic getvariable "HAC_HQ_EnLArmorG")),
		_logic getvariable "HAC_HQ_EnAirG",
		(_logic getvariable "HAC_HQ_EnNCAirG") + ((_logic getvariable "HAC_HQ_EnNCCargoG") - (_logic getvariable "HAC_HQ_EnNCAirG")) + ((_logic getvariable "HAC_HQ_EnSupportG") - ((_logic getvariable "HAC_HQ_EnNCAirG") + ((_logic getvariable "HAC_HQ_EnNCCargoG") - (_logic getvariable "HAC_HQ_EnNCAirG")))),
		_logic getvariable "HAC_HQ_EValue"
		];

	_logic setvariable ["HAC_BB_arrA",_HAC_BB_arrA_tmp];
	};

HAC_AngTowards = 
	{
	private ["_logic","_source0", "_target0", "_rnd0","_dX0","_dY0","_angleAzimuth0"];
	_source0 = _this select 0;
	_target0 = _this select 1;
	_rnd0 = _this select 2;

	_dX0 = (_target0 select 0) - (_source0 select 0);
	_dY0 = (_target0 select 1) - (_source0 select 1);

	_angleAzimuth0 = (_dX0 atan2 _dY0) + (random (_rnd0 * 2)) - _rnd0;

	_angleAzimuth0
	};

HAC_DistOrdB = 
	{
	private ["_logic","_array","_first","_point","_dst","_limit","_final","_VL"];

	_array = _this select 0;//BB strategic areas
	_point = _this select 1;
	_limit = _this select 2;

	_first = [];
	_final = [];

		{
		_dst = round ((_x select 0) distance _point);
		if (_dst <= _limit) then {_first set [_dst,_x]}
		}
	foreach _array;

		{
		if not (isNil "_x") then {_final set [(count _final),_x]}
		}
	foreach _first;

	_first = nil;

	_final
	};

HAC_WhereIs = 
	{
	private ["_logic","_point","_Rpoint","_angle","_diffA","_axis","_isLeft","_isFlanking","_isBehind"];	

	_point = _this select 0;
	_rPoint = _this select 1;
	_axis = _this select 2;

	_angle = [_rPoint,_point,0,_logic] call ALiVE_fnc_HAC_AngTowards;

	_isLeft = false;
	_isFlanking = false;
	_isBehind = false;

	if (_angle < 0) then {_angle = _angle + 360};
	if (_axis < 0) then {_axis = _axis + 360};

	_diffA = _angle - _axis;

	if (_diffA < 0) then {_diffA = _diffA + 360};

	if (_diffA > 180) then 
		{
		_isLeft = true
		};

	if ((_diffA > 60) and (_diffA < 300)) then 
		{
		_isFlanking = true
		};

	if ((_diffA > 120) and (_diffA < 240)) then 
		{
		_isBehind = true
		};

	[_isLeft,_isFlanking,_isBehind]
	};

HAC_Sectorize = 
	{
	private ["_logic","_ctr","_lng","_ang","_nbr","_EdgeL","_rd","_main","_step","_X1","_Y1","_posX","_posY","_centers","_first",
	"_sectors","_centers2","_Xa","_Ya","_dXa","_dYa","_dst","_ang2","_Xb","_Yb","_dXb","_dYb","_center","_crX","_crY","_crPoint","_sec"];

	_ctr = _this select 0;
	_lng = _this select 1;
	_ang = _this select 2;
	_nbr = _this select 3;

	_EdgeL = _lng/_nbr;
	
	_rd = _lng/2;

	_main = createLocation ["Name", _ctr, _rd, _rd];
	_main setRectangular true;

	_step = _EdgeL;

	_X1 = _ctr select 0;
	_Y1 = _ctr select 1;

	_posX = (_X1 - _rd) + _step/2;
	_posY = (_Y1 - _rd) + _step/2;

	_centers = [[_posX,_posY]];
	_first = false;

	while {(true)} do
		{
		while {(true)} do
			{
			if not (_first) then {_first = true;_posX = _posX + _step};
			if not ([_posX,_PosY] in _main) exitwith {_posX = ((_ctr select 0) - _rd) + _step/2;_first = true};
			_centers set [(count _centers),[_posX,_PosY]];
			_first = false
			};
		_posY = _posY + _step;
		if not ([_posX,_PosY] in _main) exitwith {}
		};

	if not (_ang in [0,90,180,270]) then
		{
		_main setDirection _ang;
		_centers2 = _centers;
		_centers = [];

			{
			_Xa = _x select 0;
			_Ya = _x select 1;
			_dXa = (_X1 - _Xa);
			_dYa = (_Y1 - _Ya);
			_dst = _ctr distance _x;

			_ang2 = _ang + (_dXa atan2 _dYa);

			_dXb = _dst * (sin _ang2);
			_dYb = _dst * (cos _ang2);

			_Xb = _X1 + _dXb;
			_Yb = _Y1 + _dYb;
			_center = [_Xb,_Yb];
			_centers set [(count _centers),_center]
			}
		foreach _centers2
		};
	
	_sectors = [];

		{
		_crX = _x select 0;
		_crY = _x select 1;
		_crPoint = [_crX,_crY,0];
		_sec = createLocation ["Name", _crPoint, _EdgeL/2, _EdgeL/2];
		_sec setDirection _ang;
		_sec setRectangular true;

		_sectors set [(count _sectors),_sec];
		}
	foreach _centers;

	[_sectors,_main]	
	};

HAC_Marker = 
	{
	private ["_logic","_name","_pos","_cl","_shape","_size","_dir","_alpha","_type","_brush","_text","_i"];	

	_name = _this select 0;
	_pos = _this select 1;
	_cl = _this select 2;
	_shape = _this select 3;

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
	};

HAC_LocLineTransform = 
	{
	private ["_logic","_loc","_p1","_p2","_space","_center","_angle","_r1","_r2"];

	_loc = _this select 0;
	_p1 = _this select 1;//ATL
	_p2 = _this select 2;//ATL
	_space = _this select 3;

	_center = [((_p1 select 0) + (_p2 select 0))/2,((_p1 select 1) + (_p2 select 1))/2,0];

	_angle = [_p1,_p2,0,_logic] call ALiVE_fnc_HAC_AngTowards;

	_r1 = _space;
	_r2 = (_center distance _p1) + _space;

	_loc setPosition _center;
	_loc setDirection _angle;
	_loc setSize [_r1,_r2];

	true
	};

HAC_LocMultiTransform = 
	{
	private ["_logic","_loc","_ps","_space","_center","_angle","_r1","_r2","_sx","_sy","_cnt","_dmax","_pf","_dst","_pfMain","_check","_indx","_pfbis","_dmaxbis","_cX","_cY","_allIn","_mpl","_pX","_pY"];

	_loc = _this select 0;
	_ps = _this select 1;//array of ATL
	_space = _this select 2;

	_sx = 0;
	_sy = 0;

		{
		_sx = _sx + (_x select 0);
		_sy = _sy + (_x select 1)
		}
	foreach _ps;

	_cnt = count _ps;

	if not (_cnt > 0) exitWith {};
		
	_center = [_sx/_cnt,_sy/_cnt,0];

	_pf = _ps select 0;

	_dmax = _center distance _pf;

	_indx = 0;

	for "_i" from 0 to ((count _ps) - 1) do
		{
		_check = _ps select _i;

		if (((typeName _check) == "ARRAY") and ((count _check) > 1)) then
			{
			_cX = _check select 0;
			_cY = _check select 1;

			_check = [_cX,_cY,0];

			_dst = _center distance _check;
			if (_dst > _dmax) then
				{
				_pf = _check;
				_indx = _i;
				_dmax = _dst
				}
			}
		};

	_pfMain = _pf;

	_ps set [_indx,"DeleteThis"];
	_ps = _ps - ["DeleteThis"];

	_pf = _ps select 0;

	_dmaxbis = _center distance _pf;

	for "_i" from 0 to ((count _ps) - 1) do
		{
		_check = _ps select _i;

		_cX = _check select 0;
		_cY = _check select 0;

		_check = [_cX,_cY,0];

		_dst = _center distance _check;
		if (_dst > _dmaxbis) then
			{
			_dmaxbis = _dst
			}
		};

	_angle = [_center,_pfMain,0,_logic] call ALiVE_fnc_HAC_AngTowards;

	_r1 = _dmaxbis;
	_r2 = _dmax;

	_loc setPosition _center;
	_loc setDirection _angle;
	_loc setSize [_r1,_r2];

	_allIn = false;

	_mpl = 10;

	while {(not (_allIn) and (_mpl > 0))} do
		{
		_allIn = true;

		_r1 = _dmaxbis/_mpl;
		_loc setSize [_r1,_r2];

			{
			_pX = _x select 0;
			_pY = _x select 1;

			if not ([_pX,_pY,0] in _loc) exitWith {_allIn = false};
			}
		foreach (_ps + [_pfMain]);

		_mpl = _mpl - 0.1;
		};

	_allIn = false;

	_mpl = 10;

	while {(not (_allIn) and (_mpl > 0))} do
		{
		_allIn = true;

		_r2 = _dmax/_mpl;
		_loc setSize [_r1,_r2];

			{
			_pX = _x select 0;
			_pY = _x select 1;

			if not ([_pX,_pY,0] in _loc) exitWith {_allIn = false};
			}
		foreach (_ps + [_pfMain]);

		_mpl = _mpl - 0.1;
		};

	_r1 = _r1 + _space;
	_r2 = _r2 + _space;

	_loc setSize [_r1,_r2];

	true
	};

HAC_TerraCognita = 
	{
	private ["_logic","_position","_posX","_posY","_radius","_precision","_sourcesCount","_urban","_forest","_hills","_flat","_sea","_valS","_value","_val0","_samples","_sGr","_hprev","_hcurr","_samplePos","_i","_rds"];	

	_position = _this select 0;
	_samples = _this select 1;
	_rds = 100;
	if ((count _this) > 2) then {_rds = _this select 2};

	if not ((typeName _position) == "ARRAY") then {_position = getPosATL _position};

	_posX = _position select 0;
	_posY = _position select 1;

	_radius = 5;
	_precision = 1;
	_sourcesCount = 1;

	_urban = 0;
	_forest = 0;
	_hills = 0;
	_flat = 0;
	_sea = 0;

	_sGr = 0;
	_hprev = getTerrainHeightASL [_posX,_posY];

	for "_i" from 1 to 10 do
		{
		_samplePos = [_posX + ((random (_rds * 2)) - _rds),_posY + ((random (_rds * 2)) - _rds)];
		_hcurr = getTerrainHeightASL _samplePos;
		_sGr = _sGr + abs (_hcurr - _hprev)
		};

	_sGr = _sGr/10;

		{
		_valS = 0;

		for "_i" from 1 to _samples do
			{
			_position = [_posX + (random (_rds/5)) - (_rds/10),_posY + (random (_rds/5)) - (_rds/10)];


			_value = selectBestPlaces [_position,_radius,_x,_precision,_sourcesCount];

			_val0 = _value select 0;
			_val0 = _val0 select 1;

			_valS = _valS + _val0;
			};

		_valS = _valS/_samples;

		switch (_x) do
			{
			case ("Houses") : {_urban = _urban + _valS};
			case ("Trees") : {_forest = _forest + (_valS/3)};
			case ("Forest") : {_forest = _forest + _valS};
			case ("Hills") : {_hills = _hills + _valS};
			case ("Meadow") : {_flat = _flat + _valS};
			case ("Sea") : {_sea = _sea + _valS};
			};
		}
	foreach ["Houses","Trees","Forest","Hills","Meadow","Sea"];

	[_urban,_forest,_hills,_flat,_sea,_sGr]
	};

HAC_ForceCount = 
	{
	private ["_logic","_friends","_inf","_car","_arm","_air","_nc","_current","_initial","_value","_morale","_enemies","_einf","_ecar","_earm","_eair","_enc","_frArr","_enArr",
	"_eInfG","_eCarG","_eArmG","_eAirG","_eNCG","_eAllP","_eInfP","_eCarP","_eArmP","_eAirP","_eNCP","_allP","_infP","_carP","_armP","_airP","_ncP","_enG","_evalue",
	"_frRep","_enRep","_gpHQ"];

	_friends = _this select 0;
	_inf = _this select 1;
	_car = _this select 2;
	_arm = _this select 3;
	_air = _this select 4;
	_nc = _this select 5;

	_current = _this select 6;
	_initial = _this select 7;
	_value = _this select 8;
	_morale = _this select 9;

	_enemies = _this select 10;
	_einf = _this select 11;
	_ecar = _this select 12;
	_earm = _this select 13;
	_eair = _this select 14;
	_enc = _this select 15;
	_evalue = _this select 16;

	_frArr = _this select 17;
	_enArr = _this select 18;

	_enG = _this select 19;
	_gpHQ = _this select 20;

	_eInfG = [];
	_eCarG = [];
	_eArmG = [];
	_eAirG = [];
	_eNCG = [];	

	_eInfP = 0;
	_eCarP = 0;
	_eArmP = 0;
	_eAirP = 0;
	_eNCP = 0;

	_infP = 0;
	_carP = 0;
	_armP = 0;
	_airP = 0;
	_ncP = 0;

	if ((count _enemies) > 0) then 
		{
			{
			if (not (_x in _enG) and (_x in _einf)) then {_eInfG set [(count _eInfG),_x]};
			if (not (_x in _enG) and (_x in _ecar)) then {_eCarG set [(count _eCarG),_x]};
			if (not (_x in _enG) and (_x in _earm)) then {_eArmG set [(count _eArmG),_x]};
			if (not (_x in _enG) and (_x in _eair)) then {_eAirG set [(count _eAirG),_x]};
			if (not (_x in _enG) and (_x in _enc)) then {_eNCG set [(count _eNCG),_x]};	
			}
		foreach _enemies;

		_eAllP = {not (_x in _enG)} count _enemies;

		if (_eAllP > 0) then
			{
			_eInfP = (count _eInf)/_eAllP;
			_eCarP = (count _eCar)/_eAllP;
			_eArmP = (count _eArm)/_eAllP;
			_eAirP = (count _eAir)/_eAllP;
			_eNCP = (count _eNC)/_eAllP
			}
		};
		
	_allP = count _friends;

	if (_allP > 0) then
		{	
		_infP = (count _inf)/_allP;
		_carP = (count _car)/_allP;
		_armP = (count _arm)/_allP;
		_airP = (count _air)/_allP;
		_ncP = (count _nc)/_allP
		};

	_frRep = [_allP,_current,_current - _initial,_value,_morale,[_infP,_carP,_armP,_airP,_ncP]];//liczba grup-liczba jednostek-straty-wartosc-morale-rozklad
	_enRep = [count _enemies,_evalue,[_eInfP,_eCarP,_eArmP,_eAirP,_eNCP]];//liczba grup-wartosc-rozklad

	_gpHQ setVariable ["ForceRep",[_frRep,_enRep]];

	_frArr set [(count _frArr),_frRep];
	_enArr set [(count _enArr),_enRep];

	[_frArr,_enArr]
	};

HAC_ForceAnalyze = 
	{
	private ["_logic","_HQarr","_frArr","_enArr","_frG","_enG","_HQs","_arr"];

	_HQarr = _this select 0;

	_frArr = [];
	_enArr = [];

	_frG = [];
	_enG = [];

	_HQs = [];

		{
		switch (true) do
			{
			case ((_x == _logic) and not (isNull (_logic getvariable "HAC_HQ"))) : 
				{
				_arr = ((_logic getvariable "HAC_BB_arrA") + [_frArr,_enArr,_enG,(_logic getvariable "HAC_HQ")]) call ALiVE_fnc_HAC_ForceCount;
				_frArr = _arr select 0;
				_enArr = _arr select 1;
				_HQs set [(count _HQs),(group _x)];
				_frG = _frG + (_logic getvariable "HAC_HQ_Friends") - (_logic getvariable "HAC_HQ_Exhausted");

					{
					if not (_x in _enG) then {_enG set [(count _enG),_x]};
					}
				foreach (_logic getvariable "HAC_HQ_KnEnemiesG")
				};
			default {false};
			}
		}
	foreach _HQarr;

	_frArr set [(count _frArr),_frG];
	_enArr set [(count _enArr),_enG];

	[_frArr,_enArr,_HQs]
	};

HAC_TopoAnalize = 
	{
	private ["_logic","_sectors","_sectors0","_infF","_vehF","_ct","_urbanF","_forestF","_hillsF","_flatF","_seaF","_roadsF","_grF","_actInf","_actVeh"];

	_sectors = _this select 0;

	_sectors0 = _sectors;


	_infF = 0;
	_vehF = 0;
	_ct = 0;

		{
		_urbanF = _x getVariable "Topo_Urban";
		_forestF = _x getVariable "Topo_Forest";
		_hillsF = _x getVariable "Topo_Hills";
		_flatF = _x getVariable "Topo_Flat";
		_seaF = _x getVariable "Topo_Sea";
		_roadsF = _x getVariable "Topo_Roads";
		_grF = _x getVariable "Topo_Grd";

		if not (_seaF >= 90) then 
			{
			//diag_log format ["L - U: %1 F: %2 H: %3, Fl: %4 S: %5 R: %6 G: %7 ",_urbanF,_forestF,_hillsF,_flatF,_seaF,_roadsF,_grF];

			_actInf = _urbanF + _forestF + _grF - _flatF - _hillsF;
			_actVeh = _flatF + _hillsF + _roadsF - _urbanF - _forestF - _grF;

			_x setVariable ["InfFr",_actInf];
			_x setVariable ["VehFr",_actVeh];

			_infF = _infF + _actInf;
			_vehF = _vehF + _actVeh;

			//_txt = format ["Inf: %1 - Veh: %2",_urbanF + _forestF + _grF - _flatF - _hillsF,_flatF + _hillsF + _roadsF - _urbanF - _forestF - _grF];

			//_x setText _txt;
			_ct = _ct + 1
			}
		else
			{
			_sectors = _sectors - [_x];
			}
		}
	foreach _sectors0;

	if (_ct > 0) then {_infF = _infF/_ct};
	if (_ct > 0) then {_vehF = _vehF/_ct};

	[_sectors,_infF,_vehF]
	};

HAC_Itinerary = 
	{
	private ["_logic","_sectors","_targets","_pos1","_pos2","_bound","_secIn","_tgtIn","_topoAn","_infF","_vehF","_side","_cSum","_varName","_HandledArray"];	

	_sectors = _this select 0;
	_targets = _this select 1;
	_pos1 = _this select 2;
	_pos2 = _this select 3;
	_side = _this select 4;

	_bound = createLocation ["Name", _pos1, 1, 1];
	_bound setRectangular true;

	[_bound,_pos1,_pos2,1200,_logic] call ALiVE_fnc_HAC_LocLineTransform;

	_secIn = [];
	_tgtIn = [];

		{
		if ((position _x) in _bound) then {_secIn set [(count _secIn),_x]}
		}
	foreach _sectors;

		{
		if ((_x select 0) in _bound) then 
			{
			_cSum = 0;

				{
				_cSum = _cSum + _x
				}
			foreach (_x select 0);

			_varName = "HandledAreas" + _side;

			_HandledArray = missionNameSpace getVariable _varName;

			if (isNil "_HandledArray") then 
				{
				missionNameSpace setVariable [_varName,[]];
				_HandledArray = missionNameSpace getVariable _varName
				};

			if not (_cSum in _HandledArray) then 
				{
				_tgtIn set [(count _tgtIn),_x];
				_HandledArray set [(count _HandledArray),_cSum];
				missionNameSpace setVariable [_varName,_HandledArray];
				}
			}
		}
	foreach _targets;

	deleteLocation _bound;

	_topoAn = [_secIn,_logic] call ALiVE_fnc_HAC_TopoAnalize;

	_secIn = _topoAn select 0;

	_topoAn = [_secIn,_logic] call ALiVE_fnc_HAC_TopoAnalize;

	_infF = _topoAn select 1;
	_vehF = _topoAn select 2;

	[_secIn,_tgtIn,_infF,_vehF]
	};

HAC_ExecutePath = 
	{
	private ["_logic","_HQ","_areas","_o1","_o2","_o3","_o4","_allied","_HQpos","_sortedA","_i","_nObj","_actO","_nObj","_KnEn","_KnEnAct","_VLpos","_enX","_enY","_ct","_VHQpos","_front","_afront",
	"_frPos","_frDir","_frDim","_chosenPos","_maxTempt","_actTempt","_sectors","_ownKnEn","_ownForce","_ctOwn","_alliedForce","_alliedGarrisons","_alliedExhausted","_inFlank","_Garrisons","_exhausted",
	"_prop","_enPos","_dst","_val","_profile","_j","_pCnt","_m","_checkPos","_actPos","_indx","_check","_reserve","_garrPool","_fG","_garrison","_chosen","_dstMin","_actG","_actDst","_side",
	"_AllV","_Civs","_AllV2","_Civs2","_AllV0","_AllV20","_NearAllies","_NearEnemies","_actOPos","_mChange","_marksT","_firstP","_actP","_angleM","_centerPoint","_mr1","_mr2","_lM","_wp",
	"_varName","_HandledArray","_cSum","_reck","_cons","_limit","_lColor"];	

	_HQ = _this select 0;//leader units
	_areas = _this select 1;
	_o1 = _this select 2;
	_o2 = _this select 3;
	_o3 = _this select 4;
	_o4 = _this select 5;
	_allied = (_this select 6) - [_HQ];//leader units

	_HQpos = _this select 7;
	_front = _this select 8;
	_sectors = _this select 9;
	_reserve = _this select 10;
	_side = _this select 11;

	_varName = "HandledAreas" + _side;

	_HandledArray = missionNameSpace getVariable _varName;

	_frPos = position _front;
	_frDir = direction _front;
	_frDim = size _front;

	_profile = (group _HQ) getVariable "ForceProfile";

	_sortedA = [_areas,_HQpos,25000,_logic] call ALiVE_fnc_HAC_DistOrdB;

	_pCnt = 0;

	_m = "";
	_marksT = [];		

	if (_logic getvariable "HAC_BB_Debug") then
		{
			{
			_pCnt = _pCnt + 1;
			_j = [(_x select 0),(random 1000),"markBBPath",(_logic getvariable ["HAC_HQ_Color","ColorBlack"]),"ICON","mil_box",(str _pCnt),"",[0.35,0.35],_logic] call ALiVE_fnc_HAC_Mark;
			_marksT set [(count _marksT),_j]
			}
		foreach _sortedA;

		for "_i" from 0 to ((count _sortedA) - 1) do
			{
			_firstP = _HQpos;
			if (_i > 0) then {_firstP = (_sortedA select (_i - 1)) select 0};

			_firstP = [_firstP select 0,_firstP select 1,0];

			_actP = (_sortedA select _i) select 0;
			_actP = [_actP select 0,_actP select 1,0];

			_angleM = [_firstP,_actP,0,_logic] call ALiVE_fnc_HAC_AngTowards;

			_centerPoint = [((_firstP select 0) + (_actP select 0))/2,((_firstP select 1) + (_actP select 1))/2,0];

			_mr1 = 1.5;
			_mr2 = _actP distance _centerPoint;

			_lM = [_centerPoint,(random 1000),"markBBline","ColorPink","RECTANGLE","Solid","","",[_mr1,_mr2],_angleM,_logic] call ALiVE_fnc_HAC_Mark;

			_marksT set [(count _marksT),_lM]
			}
		};

	(group _HQ) setVariable ["PathDone",false];

	for "_i" from 0 to ((count _sortedA) - 1) do
		{
		_actO = _sortedA select _i;

		_cSum = 0;

			{
			_cSum = _cSum + _x
			}
		foreach (_actO select 0);

		_actOPos = [(_actO select 0) select 0,(_actO select 0) select 1,0];
		_lColor = (_logic getvariable ["HAC_HQ_Color","ColorBlue"]);
		if (_Side == "B") then {_lColor = (_logic getvariable ["HAC_HQ_Color","ColorRed"])};

		if ((_logic getvariable "HAC_BB_Debug") or ((_logic getvariable "HAC_BBa_SimpleDebug") and (_Side == "A")) or ((_logic getvariable "HAC_BBb_SimpleDebug") and (_Side == "B"))) then
			{
			if (_i == 0) then {_m = [(_actO select 0),_HQ,"markBBCurrent",_lColor,"ICON","loc_Bunker"," | Current target for " + (str _HQ),"",[2,2],_logic] call ALiVE_fnc_HAC_Mark} else {_m setMarkerPos (_actO select 0)};
			};

			{
			_x setPosATL _actOPos
			}
		foreach [_o1,_o2,_o3,_o4];

		(group _HQ) setVariable ["ObjInit",true];

		switch (_HQ) do
			{
			case (_logic) : {_logic setvariable ["HAC_HQ_NObj", 1]};
			};
			default {false};

		waitUntil
			{
			sleep 120;

			_KnEn = [];

			_inFlank = (group _HQ) getVariable "inFlank";
			if (isNil "_inFlank") then {_inFlank = false};

			if not (_inFlank) then
				{
				_ownKnEn = _logic getvariable "HAC_HQ_KnEnemiesG";
				_ownForce = _logic getvariable "HAC_HQ_Friends";
				_Garrisons = _logic getvariable "HAC_HQ_Garrison";
				_exhausted = _logic getvariable "HAC_HQ_Exhausted";

				if (isNil "_exhausted") then {_exhausted = []};

				_ownForce = _ownForce - (_Garrisons + _exhausted);

				_ctOwn = 0;

					{
					if ((position (vehicle (leader _x))) in _front) then {_ctOwn = _ctOwn + 1}
					}
				foreach _ownKnEn;

				_prop = 100;

				if (_ctOwn > 0) then {_prop = (count _ownForce)/_ctOwn};

				if (_prop > (8 * (0.5 + (random 1)))) then
					{
						{
					
						_KnEnAct = _logic getvariable "HAC_HQ_KnEnemiesG";
						_afront = _logic getvariable "FrontA";

						_alliedForce = _logic getvariable "HAC_HQ_Friends";
						_alliedGarrisons = _logic getvariable "HAC_HQ_Garrison";
						_alliedExhausted = _logic getvariable "HAC_HQ_Exhausted";	

						if (isNil "_alliedExhausted") then {_alliedExhausted = []};
						_alliedForce =  _alliedForce - (_alliedGarrisons + _alliedExhausted);

						if ((count _KnEnAct) > 0) then
							{
							_ct = 0;
						
								{
								_enX = 0;
								_enY = 0;				

								_VLpos = getPosATL (vehicle (leader _x));
								if (_VLpos in _afront) then 
									{
									_ct = _ct + 1;
									_enX = _enX + (_VLpos select 0);
									_enY = _enY + (_VLpos select 1);
									}
								}
							foreach _KnEnAct;
							
							if (_ct > 0) then
								{
								_enX = _enX/_ct;
								_enY = _enY/_ct;
								};

							_KnEn set [(count _KnEn),[[_enX,_enY,0],_ct]];
							};

						}
					foreach _allied;

					if ((count _KnEn) > 0) then
						{
						_chosenPos = [];	
						_maxTempt = 0;			

							{
							_VHQpos = getPosATL (vehicle (leader _HQ));
							_enPos = _x select 0;
							_dst = _VHQpos distance _enPos;
							_val = _x select 1;
							_actTempt = 0;

							if ((_dst > 0) and ((count _ownForce) > (_val * (0.1 + (random 1)))) and (_val > ((count _alliedForce) * (0.5 + (random 0.5))))) then {_actTempt = (1000 * (sqrt _val))/_dst};

							if (_actTempt > _maxTempt) then
								{
								_maxTempt = _actTempt;
								_chosenPos = _enPos;
								}
							}
						foreach _KnEn;

						if ((count _chosenPos) > 1) then {_chosenPos = [(_chosenPos select 0),(_chosenPos select 1),0]};

						if (_maxTempt > (0.1 + (random 2))) then 
							{
							(group _HQ) setVariable ["inFlank",true];
							[_front,_VHQpos,_chosenPos,2000,_logic] call ALiVE_fnc_HAC_LocLineTransform;

								{
								_x setPosATL _chosenPos;
								}
							foreach [_o1,_o2,_o3,_o4];

							switch (_HQ) do
								{
								case (_logic) : {_logic setvariable ["HAC_HQ_NObj",1]};
								};

							waitUntil 
								{
								sleep 120;

								_nObj = _logic getvariable "HAC_HQ_NObj";
								_reck = _logic getvariable "HAC_HQ_Recklessness";
								_cons = _logic getvariable "HAC_HQ_Consistency";

								_limit = _logic getvariable "HAC_HQ_CaptLimit";

								if (isNil "_limit") then {_limit = 10};

								if (isNull (group _HQ)) then {_nObj = 100};
								if not (alive _HQ) then {_nObj = 100};

								_AllV = _chosenPos nearEntities [["AllVehicles"],300];
								_Civs = _chosenPos nearEntities [["Civilian"],300];
								_AllV2 = _chosenPos nearEntities [["AllVehicles"],500];
								_Civs2 = _chosenPos nearEntities [["Civilian"],500];

								_AllV = _AllV - _Civs;
								_AllV2 = _AllV2 - _Civs2;

								_AllV0 = _AllV;
								_AllV20 = _AllV2;

									{
									if not (_x isKindOf "Man") then
										{
										if ((count (crew _x)) == 0) then {_AllV = _AllV - [_x]}
										}
									}
								foreach _AllV0;

									{
									if not (_x isKindOf "Man") then
										{
										if ((count (crew _x)) == 0) then {_AllV2 = _AllV2 - [_x]}
										}
									}
								foreach _AllV20;

								_NearAllies = _HQ countfriendly _AllV;
								_NearEnemies = _HQ countenemy _AllV2;

								((_nObj > 1) or ((_NearAllies >= _limit) and (_NearEnemies <= ((_reck/(0.5 + _cons))*10))))
								};

							if not (isNull (group _HQ)) then 
								{
								_front setPosition _frPos;
								_front setDirection _frDir;
								_front setSize _frDim; 

									{
									_x setPosATL _actOPos;
									}
								foreach [_o1,_o2,_o3,_o4];

								switch (_HQ) do
									{
									case (_logic) : {_logic setvariable ["HAC_HQ_NObj", 1]};
									};

								(group _HQ) setVariable ["inFlank",false]
								};
							}
						}
					}
				};

			(_actO select 2)
			};

		if (isNull (group _HQ)) exitWith {};
		if not (alive _HQ) exitWith {};

		_garrPool = 0;

			{
			_fG = (_logic getvariable "HAC_HQ_NCrewInfG") - ((_logic getvariable "HAC_HQ_Exhausted") + (_logic getvariable "HAC_HQ_Garrison"));

			if ((count _fG) > 2) then {_garrPool = _garrPool + 1}
			}
		foreach _reserve;

		if (_garrPool == 0) then
			{
			_fG = (_logic getvariable "HAC_HQ_NCrewInfG") - ((_logic getvariable "HAC_HQ_Exhausted") + (_logic getvariable "HAC_HQ_Garrison"));
			_garrison = _logic getvariable "HAC_HQ_Garrison";

			if (((count _fG)/10) >= 1) then
				{
				_chosen = _fG select 0;

				_dstMin = (_actO select 0) distance (vehicle (leader _chosen));

					{
					_actG = _x;
					_actDst = (_actO select 0) distance (vehicle (leader _actG));
	
					if (_actDst < _dstMin) then 
						{
						_dstMin = _actDst;
						_chosen = _actG
						}
					}
				foreach _fG;

				_chosen setVariable ["Busy" + (str _chosen),true];

				_garrison set [(count _garrison),_chosen]
				}
			};

		switch (_HQ) do
			{
			case (_logic) : {_logic setvariable ["HAC_HQ_NObj", 5]};
			};

		switch (_HQ) do
			{
			case (_logic) : {_BBProg = (group _logic) getVariable ["BBProgress",0];(group _logic) setVariable ["BBProgress",_BBProg + 1]};
			};

		_HandledArray = _HandledArray - [_cSum];
		missionNameSpace setVariable [_varName,_HandledArray];

		if (_logic getvariable "HAC_BB_LRelocating") then
			{
			[(group _HQ),_logic] call ALiVE_fnc_HAC_WPdel;
			_wp = [_logic,(group _HQ),_actOPos,"HOLD","AWARE","GREEN","LIMITED",["true",""],true,50,[0,0,0],"FILE"] call ALiVE_fnc_HAC_WPadd
			}
		};

	if (_logic getvariable "HAC_BB_Debug") then
		{
			{
			deleteMarker _x
			}
		foreach (_marksT + [_m])
		};

	if not (isNull (group _HQ)) then {(group _HQ) setVariable ["PathDone",true]};
	};

HAC_ReserveExecuting = 
	{
	private ["_logic","_HQ","_ahead","_frontPos","_o1","_o2","_o3","_o4","_allied","_HQpos","_front","_angle","_dst","_dstF","_dDst","_stancePos","_taken","_fG","_val","_forGarr","_ct","_ct2",
	"_garrison","_task","_hMany","_busy","_Wpos","_mark","_wp","_aheadL","_aliveHQ","_hostileG","_assg","_possPos","_enV","_posArr","_enV2","_nr","_sX","_sY","_dstA","_amnt","_actT",
	"_maxT","_poss","_m","_side","_rColor"];

	_HQ = _this select 0;
	_ahead = _this select 1;
	_o1 = _this select 2;
	_o2 = _this select 3;
	_o3 = _this select 4;
	_o4 = _this select 5;
	_allied = _this select 6;//leader units

	_HQpos = getPosATL (vehicle _HQ);
	_front = _this select 7;
	_taken = _this select 8;
	_hostileG = _this select 9;
	_side = _this select 10;

	_frontPos = _HQpos;
	if ((count _ahead) > 0) then 
		{
		_aheadL = _ahead select (floor (random (count _ahead)));
		_aliveHQ = true;
		if not (alive _aheadL) then {_aliveHQ = false};
		if (isNull _aheadL) then {_aliveHQ = false};

		if (_aliveHQ) then
			{
			_frontPos = getPosATL (vehicle _aheadL)
			}
		};

	_dst = _HQpos distance _frontPos;

	_dDst = 1000 + (random 1000);

	_dstF = _dst - _dDst;
	if (_dstF < 0) then {_dstF = _dst/2};

	_angle = [_HQpos,_frontPos,10,_logic] call ALiVE_fnc_HAC_AngTowards;

	if (_angle < 0) then {_angle = _angle + 360};

	_angle = _angle + 180;

	_stancePos = [_frontPos,_angle,_dstF,_logic] call ALiVE_fnc_HAC_PosTowards2D;
//diag_log format ["1 sp: %1",_stancePos];
	_stancePos = [(_stancePos select 0),(_stancePos select 1),0];
//diag_log format ["2 sp: %1",_stancePos];
	if (surfaceIsWater [(_stancePos select 0),(_stancePos select 1)]) then {_stancePos = _HQpos};

	if ((count _hostileG) == 0) then
		{
			{
			_x setPosATL _stancePos
			}
		foreach [_o1,_o2,_o3,_o4]
		};

	(group _HQ) setVariable ["ObjInit",true];

	[(group _HQ),_logic] call ALiVE_fnc_HAC_WPdel;
	_wp = [_logic,(group _HQ),_StancePos,"HOLD","AWARE","GREEN","LIMITED",["true",""],true,50,[0,0,0],"FILE"] call ALiVE_fnc_HAC_WPadd;

	_fG = (_logic getvariable "HAC_HQ_NCrewInfG") - ((_logic getvariable "HAC_HQ_Exhausted") + (_logic getvariable "HAC_HQ_Garrison"));
	_garrison = _logic getvariable "HAC_HQ_Garrison";

	switch (_HQ) do
		{
		case (_logic) : {_logic setvariable ["HAC_HQ_NObj", 1]};
		};

	_fG = _fG - [(gspawn ALiVE_fnc_HAC_;

		{
		if ((count _x) < 5) then {_x set [4,false]};
		if not (_x select 4) then
			{
			_Wpos = _x select 0;
			_val = _x select 1;
			if (_val > 5) then {_val = 5};
			_hMany = floor ((_val/10) * (count _fG));

			//if (_hMany > (ceil (_val/2))) then {_hMany = ceil (_val/2)};
			if (_hMany > 2) then {_hMany = 2};
			//if ((_hMany == 0) and ((random 100) > (90 - (count _fG)))) then {_hMany = 1};

			_ct = 0;

			while {((_ct < _hMany) and ((count _fG) > 0))} do
				{
				_ct = _ct + 1;
				_forGarr = _fG select (floor (random (count _fG)));
				_busy = _forGarr getVariable ("Busy" + (str _forGarr));
				if (isNil "_busy") then {_busy = false};

				_ct2 = 0;

				while {(_busy) and (_ct2 <= (count _fG))} do
					{
					_ct2 = _ct2 + 1;
					_forGarr = _fG select (floor (random (count _fG)));
					_busy = _forGarr getVariable ("Busy" + (str _forGarr));
					if (isNil "_busy") then {_busy = false};
					};

				if not (_busy) then
					{
					_x set [4,true];
					_fG = _fG - [_forGarr];

					[_forGarr,_garrison,_Wpos,_HQ] spawn
						{
						private ["_logic","_unitG","_cause","_timer","_alive","_task","_form","_Wpos","_garrison","_HQ","_wp"];

						_unitG = _this select 0;
						_garrison = _this select 1;
						_Wpos = _this select 2;
						_HQ = _this select 3;

						_form = "DIAMOND";
						if (isPlayer (leader _unitG)) then {_form = formation _unitG};
						_unitG setVariable ["Busy" + (str _unitG),true];

						_logic setvariable ["HAC_HQ_VCDone", false];
						if (isPlayer (leader _unitG)) then {[(leader _unitG),_HQ] spawn VoiceComm;sleep 3;waituntil {sleep 0.1;(_logic getvariable "HAC_HQ_VCDone")}} else {if ((random 100) < (_logic getvariable "HAC_xHQ_AIChatDensity")) then {[_UL,_logic getvariable "HAC_xHQ_AIC_OrdConf","OrdConf",_logic] spawn ALiVE_fnc_HAC_AIChatter}};

						_task = [(leader _unitG),["Reach the designated position.", "Move", ""],_Wpos,_logic] call ALiVE_fnc_HAC_AddTask;

						[_unitG,_logic] call ALiVE_fnc_HAC_WPdel;

						_wp = [_logic,_unitG,_Wpos,"MOVE","AWARE","YELLOW","NORMAL",["true","deletewaypoint [(group this), 0]"],true,250,[0,0,0],_form] call ALiVE_fnc_HAC_WPadd;

						_cause = [_logic,_unitG,6,true,0,30,[],false] call ALiVE_fnc_HAC_Wait;
						_timer = _cause select 0;
						_alive = _cause select 1;

						if not (_alive) exitwith {};
						if (_timer > 30) then {[_unitG, (currentWaypoint _unitG)] setWaypointPosition [position (vehicle (leader _unitG)), 1]};

						if ((isPlayer (leader _unitG)) and not (isMultiplayer)) then {(leader _unitG) removeSimpleTask _task};

						if not (_timer > 30) then {_garrison set [(count _garrison),_unitG]};
						}
					}
				}
			}
		}
	foreach _taken;

	if ((count _hostileG) > 0) then
		{
		_assg = [];
		_possPos = [];

			{
			if not (_x in _assg) then
				{
				_enV = vehicle (leader _x);
				_posArr = [];

					{
					_enV2 = vehicle (leader _x);

					if ((_enV distance _enV2) < 600) then 
						{
						_posArr set [(count _posArr),getPosATL _enV2];
						_assg set [(count _assg),_x];			
						}
					}
				foreach _hostileG;

				_nr = count _posArr;

				if (_nr > 0) then
					{
					_sX = 0;
					_sY = 0;

						{
						_sX = _sX + (_x select 0);
						_sY = _sY + (_x select 1);
						}
					foreach _posArr;
					
					_poss = [[_sX/_nr,_sY/_nr,0],_nr];
					if not (surfaceIsWater [_sX/_nr,_sY/_nr]) then {_possPos set [(count _possPos),_poss]}
					}
				}
			}
		foreach _hostileG;

		_stancePos = (_possPos select 0) select 0;
		_maxT = 0;
//diag_log format ["3 sp: %1",_stancePos];
			{
			_dstA = (_x select 0) distance _HQpos;
			_amnt = _x select 1;
			_actT = (_amnt/((_dstA/1000) * (_dstA/1000))) * (0.5 + (random 0.5) + (random 0.5));

			if (_actT > _maxT) then
				{
				_maxT = _actT;
				_stancePos = _x select 0;
				}

			}
		foreach _possPos
		};

		{
		_x setPosATL _stancePos
		}
	foreach [_o1,_o2,_o3,_o4];

	if (_logic getvariable "HAC_BB_Debug") then
		{
		_m = (group _HQ) getVariable "ResMark";
		if (isNil "_m") then 
			{
			_rColor = (_logic getvariable ["HAC_HQ_Color","ColorBlue"]);
			if (_side == "B") then {_rColor = (_logic getvariable ["HAC_HQ_Color","ColorRed"])};
			_m = [_StancePos,_HQ,"markBBCurrent",_rColor,"ICON","mil_triangle","Reserve area for " + (str _HQ),"",[0.5,0.5],_logic] call ALiVE_fnc_HAC_Mark;
			(group _HQ) setVariable ["ResMark",_m]
			}
		else
			{
			_m setMarkerPos _StancePos
			};
		};
	};

HAC_ObjectivesMon = 
	{
	private ["_logic","_area","_BBSide","_isTaken","_HQ","_AllV","_Civs","_AllV2","_Civs2","_NearAllies","_NearEnemies","_trg","_AllV0","_AllV20","_mChange","_HQs","_enArea","_enPos","_BBProg"];

	_area = _this select 0;
	_BBSide = _this select 1;
	_HQ = _this select 2;

	while {(_logic getvariable "HAC_BB_Active")} do
		{
		sleep 60;

			{
			_isTaken = _x select 2;
			_trg = _x select 0;

			_trg = [_trg select 0,_trg select 1,0];

			if (_isTaken) then
				{
				_AllV = _trg nearEntities [["AllVehicles"],500];
				_Civs = _trg nearEntities [["Civilian"],500];
				_AllV2 = _trg nearEntities [["AllVehicles"],300];
				_Civs2 = _trg nearEntities [["Civilian"],300];

				_AllV = _AllV - _Civs;
				_AllV2 = _AllV2 - _Civs2;

				_AllV0 = _AllV;
				_AllV20 = _AllV2;

					{
					if not (_x isKindOf "Man") then
						{
						if ((count (crew _x)) == 0) then {_AllV = _AllV - [_x]}
						}
					}
				foreach _AllV0;

					{
					if not (_x isKindOf "Man") then
						{
						if ((count (crew _x)) == 0) then {_AllV2 = _AllV2 - [_x]}
						}
					}
				foreach _AllV20;

				_NearAllies = _HQ countfriendly _AllV;
				_NearEnemies = _HQ countenemy _AllV2;

				if (_NearAllies < _NearEnemies) then 
					{
					_x set [2,false];
					_HQs = _logic getvariable "HAC_BBa_HQs";
					if (_BBSide == "A") then {_logic setvariable ["HAC_BBa_Urgent", true]} else {_logic setvariable ["HAC_BBb_Urgent", true];_HQs = _logic getvariable "HAC_BBb_HQs"};

					_mChange = 10/(count _HQs);

						{
						switch (_x) do
							{
							case (_logic) : {_logic setvariable ["HAC_HQ_Morale", ((_logic getvariable "HAC_HQ_Morale") - _mChange)]};
							};
						}
					foreach _HQs
					}
				}
			else
				{
				_AllV = _trg nearEntities [["AllVehicles"],300];
				_Civs = _trg nearEntities [["Civilian"],300];
				_AllV2 = _trg nearEntities [["AllVehicles"],500];
				_Civs2 = _trg nearEntities [["Civilian"],500];

				_AllV = _AllV - _Civs;
				_AllV2 = _AllV2 - _Civs2;

				_AllV0 = _AllV;
				_AllV20 = _AllV2;

					{
					if not (_x isKindOf "Man") then
						{
						if ((count (crew _x)) == 0) then {_AllV = _AllV - [_x]}
						}
					}
				foreach _AllV0;

					{
					if not (_x isKindOf "Man") then
						{
						if ((count (crew _x)) == 0) then {_AllV2 = _AllV2 - [_x]}
						}
					}
				foreach _AllV20;

				_NearAllies = _HQ countfriendly _AllV;
				_NearEnemies = _HQ countenemy _AllV2;

				if ((_NearAllies >= 10) and (_NearEnemies <= 5)) then 
					{
					_x set [2,true];

					_enArea = missionNameSpace getVariable ["B_SAreas",[]];
					if (_BBSide == "B") then {_enArea = missionNameSpace getVariable ["A_SAreas",[]]};

						{
						_enPos = _x select 0;
						_enPos = [_enPos select 0,_enPos select 1,0];
						if ((_enPos distance _trg) < 50) exitWith
							{
							_x set [2,false]
							}
						}
					foreach _enArea;

					_HQs = _logic getvariable "HAC_BBa_HQs";
					if (_BBSide == "A") then {_logic setvariable ["HAC_BBb_Urgent", true]} else {_logic setvariable ["HAC_BBa_Urgent", true];_HQs = _logic getvariable "HAC_BBb_HQs"};

					_mChange = 20/(count _HQs);

						{
						switch (_x) do
							{
							case (_logic) : {_logic setvariable ["HAC_HQ_Morale",(_logic getvariable "HAC_HQ_Morale") + _mChange]};//_BBProg = (group _logic) getVariable ["BBProgress",0];(group _logic) setVariable ["BBProgress",_BBProg + 1]};
							};
						}
					foreach _HQs
					}
				}
			}
		foreach _area
		}
	};

HAC_ObjMark = 
	{
	private ["_logic","_obj","_mark","_taken","_color","_txt","_AllV","_pos","_side","_alpha"];

	_obj = _this select 0;
	_mark = _this select 1;
	_side = _this select 2;
	
	while {((_logic getvariable "HAC_BB_Active") and (_logic getvariable "HAC_BB_Debug"))} do
		{
		sleep 20;
		_pos = _obj select 0;
		_pos = [_pos select 0,_pos select 1,0];

		_taken = _obj select 2;
		_color = (_logic getvariable ["HAC_HQ_Color","ColorYellow"]);
		_alpha = 0.1;

		if ((_taken) and (_side == "A")) then {_color = (_logic getvariable ["HAC_HQ_Color","ColorBlue"]);_alpha = 0.5};
		if ((_taken) and (_side == "B")) then {_color = (_logic getvariable ["HAC_HQ_Color","ColorRed"]);_alpha = 0.5};
//_AllV = _pos nearEntities [["AllVehicles"],300];
//diag_log format ["obj: %1 col: %2",_obj,_color];
		//_txt = format [" status: %1",count _AllV];

		_mark setMarkerColor _color;

		_mark setMarkerAlpha _alpha;
		//_mark setMarkerText _txt;
		}
	};

HAC_ClusterA = 
	{
	private ["_logic","_points","_clusters","_checked","_newCluster","_point","_range","_sum"];

	_points = _this select 0;
	_range = _this select 1;

	_clusters = [];
	_checked = [];
	_newCluster = [];

	//_points2 = +_points;

		{
		_sum = (_x select 0) + (_x select 1);
		if not (_sum in _checked) then
			{
			_checked set [(count _checked),_sum];
			_point = _x;
			_newCluster = [_point];

				{
				_sum = (_x select 0) + (_x select 1);
				if not (_sum in _checked) then
					{
					if ((_point distance _x) <= _range) then 
						{
						_checked set [(count _checked),_sum];
						_newCluster set [(count _newCluster),_x];
						}
					}
				}
			foreach _points;

			_clusters set [(count _clusters),_newCluster]
			}
		}
	foreach _points;

	_clusters
	};

HAC_ClusterB = 
	{
	private ["_logic","_points","_clusters","_point","_sumC","_sumS","_sumMin","_pointMin","_dstMin","_sum","_dstAct","_added","_cluster","_inside"];

	_points = _this select 0;

	_clusters = [];

		{
		_point = _x;
		_sumC = (_point select 0) + (_point select 1);

		_added = false;
		_inside = false;

			{
				{
				_sum = (_x select 0) + (_x select 1);
				if (_sum == _sumC) exitWith {_inside = true}
				}
			foreach _x;

			if (_inside) exitWith {}
			}
		foreach _clusters;

		if not (_inside) then
			{
			_sumMin = _sumC;
			_pointMin = _point;
			_dstMin = 100000;

				{
				_sum = (_x select 0) + (_x select 1);

				if not (_sumC == _sum) then
					{
					_dstAct = _point distance _x;
					if (_dstAct < _dstMin) then
						{
						_dstMin = _dstAct;
						_pointMin = _x;
						_sumMin = _sum;
						}
					}
				}
			foreach _points;

				{
				_cluster = _x;

					{
					_sumS = (_x select 0) + (_x select 1);
					if (_sumS == _sumMin) exitWith 
						{
						_added = true;
						_cluster set [(count _cluster),_point]
						};
					}
				foreach _cluster;

				if (_added) exitWith {}
				}
			foreach _clusters;

			if not (_added) then 
				{
				_clusters set [(count _clusters),[_point,_pointMin]];
				};
			}
		}
	foreach _points;

	_clusters
	};

HAC_Cluster = 
	{
	private ["_logic","_points","_clusters","_centers","_cluster","_midX","_midY","_center","_clustersC","_newClusters","_newCluster","_clusterNearby","_centerC"];

	_points = _this select 0;

	_clusters = [_points,_logic] call ALiVE_fnc_HAC_ClusterB;

	_centers = [];


		{
		_cluster = _x;	

		_midX = 0;
		_midY = 0;

			{
			_midX = _midX + (_x select 0);
			_midY = _midY + (_x select 1);
			}
		foreach _cluster;

		_center = [_midX/(count _cluster),_midY/(count _cluster),0];
		_centers set [(count _centers),_center];
		}
	foreach _clusters;

	_clusters set [(count _clusters),_centers];

	_clustersC = [_centers,500,_logic] call ALiVE_fnc_HAC_ClusterA;

	_newClusters = [];

		{
		_newCluster = [];
		_clusterNearby = [];

			{
			_centerC = _x;

				{
				if (((_centers select _foreachIndex) select 0) == (_centerC select 0)) then {_clusterNearby set [(count _clusterNearby),(_clusters select _foreachIndex)]}
				}
			foreach _clusters
			}
		foreach _x;

			{
				{
				_newCluster set [(count _newCluster),_x]
				}
			foreach _x
			}
		foreach _clusterNearby;

		_newClusters set [(count _newClusters),_newCluster]
		}
	foreach _clustersC;

	_clusters = _newClusters;

	_clusters
	};

HAC_isOnMap = 
	{
	private ["_logic","_pos","_onMap","_pX","_pY","_mapMinX","_mapMinY"];

	_pos = _this select 0;
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
	};

HAC_BBSimpleD = 
	{
	private ["_logic","_HQs","_BBSide","_clusters","_enPos","_ens","_centers","_center","_amounts","_amount","_midX","_midY","_frs","_frCenters","_frCenter","_lPos","_lng","_angle","_arrow","_colorArr","_mainCenter",
	"_amounts","_amount","_battles","_battle","_angleBatt","_tooClose","_mPos","_mSize","_dstAct","_colorBatt","_sizeBatt","_oldSize","_HQPosMark"];

	_HQs = _this select 0;
	_BBSide = _this select 1;

	sleep 60;

	while {(({not (isNull (group _x))} count _HQs) > 0)} do
		{

		if (({not (isNull (group _x))} count _HQs) == 0) exitWith {};

		_enPos = [];
		_frCenters = [];

			{
			if (alive _x) then
				{
				_ens = _logic getvariable "HAC_HQ_KnEnPos";
				_frs = _logic getvariable "HAC_HQ_Friends";

				_enPos = _enPos + _ens;
				};

			_lPos = (group _x) getVariable "LastCenter";
			_frCenter = _lPos;

			_midX = 0;
			_midY = 0;

				{
				_midX = _midX + ((getPosATL (vehicle (leader _x))) select 0);
				_midY = _midY + ((getPosATL (vehicle (leader _x))) select 1);
				}
			foreach _frs;

			if ((count _frs) > 0) then
				{
				if ([[_midX/(count _frs),_midY/(count _frs)],_logic] call ALiVE_fnc_HAC_isOnMap) then 
					{
					_frCenter = [_midX/(count _frs),_midY/(count _frs),0]
					}
				else 
					{
					if (isNil "_lPos") then
						{
						_frCenter = getPosATL (vehicle _x);
						}
					}
				};

			(group _x) setVariable ["LastCenter",_frCenter];

			_frCenters set [(count _frCenters),_frCenter];

			_colorArr = (_logic getvariable ["HAC_HQ_Color","ColorBlue"]);
			if (_BBSide == "B") then {_colorArr = (_logic getvariable ["HAC_HQ_Color","ColorRed"])};

			if not (isNil "_lPos") then
				{
				_lng = _lPos distance _frCenter;

				if (_lng > 100) then
					{
					_angle = [_lPos,_frCenter,5,_logic] call ALiVE_fnc_HAC_AngTowards;

					_arrow = (group _x) getVariable ["ArrowMark",""];

					if (_arrow == "") then 
						{
						_arrow = [_frCenter,(group _x),"markArrow",_colorArr,"ICON","mil_arrow","","",[({alive (leader _x)} count _frs)/10,_lng/500],_angle,_logic] call ALiVE_fnc_HAC_Mark;
						(group _x) setVariable ["ArrowMark",_arrow];
						}
					else
						{
						_arrow setMarkerPos _frCenter;
						_arrow setMarkerDir _angle;
						_arrow setMarkerSize [({alive (leader _x)} count _frs)/10,_lng/500]
						}
					}
				};

			if not (isNull (group _x)) then
				{
				_HQPosMark = (group _x) getVariable ["HQPosMark",""];
				if (_HQPosMark == "") then
					{
					_HQPosMark = [(getPosATL (vehicle _x)),(group _x),"HQMark",_colorArr,"ICON","mil_box","Position of " + (str _x),"",[0.5,0.5],_logic] call ALiVE_fnc_HAC_Mark;
					(group _x) setVariable ["HQPosMark",_HQPosMark]
					}
				else
					{
					_HQPosMark setMarkerPos (getPosATL (vehicle _x));
					}
				}
			else
				{
				deleteMarker ("HQMark" + (str (group _x)))
				}
			}
		foreach _HQs;

		_midX = 0;
		_midY = 0;

			{
			_midX = _midX + (_x select 0);
			_midY = _midY + (_x select 1);
			}
		foreach _frCenters;

		_mainCenter = [_midX/(count _HQs),_midY/(count _HQs),0];

		_clusters = [];

		if ((count _enPos) > 0) then {_clusters = [_enPos,_logic] call ALiVE_fnc_HAC_Cluster};

		_centers = [];
		_amounts = [];

			{
			_amount = count _x;

			if (_amount > 2) then
				{
				_midX = 0;
				_midY = 0;

					{
					_midX = _midX + (_x select 0);
					_midY = _midY + (_x select 1);
					}
				foreach _x;

				_centers set [(count _centers),[_midX/(count _x),_midY/(count _x),0]];
				_amounts set [(count _amounts),_amount];
				}
			}
		foreach _clusters;

		_battles = missionNamespace getVariable ["Battlemarks",[]];
		_battle = "";


			{
			_center = _x;
			if ([_center,_logic] call ALiVE_fnc_HAC_isOnMap) then
				{
				_tooClose = false;

					{
					_mPos = getMarkerPos _x;
					_mSize = getMarkerSize _x;
					_mSize = ((_mSize select 0) + (_mSize select 1)) * 100;
					_dstAct = _center distance _mPos;

					if (_mSize > _dstAct) exitWith {_tooClose = true;_battle = _x}
					}
				foreach _battles;

				_colorBatt = (_logic getvariable ["HAC_HQ_Color","ColorBlue"]);
				if (_BBSide == "B") then {_colorBatt = (_logic getvariable ["HAC_HQ_Color","ColorRed"])};
				_sizeBatt = (_amounts select _foreachIndex)/6;
				if (_sizeBatt > 5) then {_sizeBatt = 5};

				_angleBatt = [_mainCenter,_x,0,_logic] call ALiVE_fnc_HAC_AngTowards;

				if not (_tooClose) then
					{
					_battle = [_x,(random 10000),"markBattle",_colorBatt,"ICON","mil_ambush","","",[_sizeBatt,_sizeBatt],_angleBatt - 90,_logic] call ALiVE_fnc_HAC_Mark;
					_battles set [(count _battles),_battle];
					missionNamespace setVariable ["Battlemarks",_battles];
					}
				else
					{
					_oldSize = getMarkerSize _battle;
					_oldSize = _oldSize select 0;
				
					if (_sizeBatt > _oldSize) then
						{
						_battle setMarkerColor _colorBatt;
						_battle setMarkerSize [_sizeBatt,_sizeBatt];
						_battle setMarkerDir (_angleBatt - 90)
						}
					}
				}
			}
		foreach _centers;

		sleep 300
		}
	};