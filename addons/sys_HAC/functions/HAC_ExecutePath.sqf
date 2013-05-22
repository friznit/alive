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
    _logic = _this select ((count _this)-1);

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