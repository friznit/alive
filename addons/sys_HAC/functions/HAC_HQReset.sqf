private ["_logic","_Edistance","_trg"];
_logic = _this select 0;
waitUntil 
	{
	sleep 1;
	((_logic getvariable "HAC_HQ_Cyclecount") > 1)
	};

while {not (isNull (_logic getvariable "HAC_HQ"))} do
	{
	if (isNil {_logic getvariable "HAC_HQ_ResetNow"}) then {_logic setvariable ["HAC_HQ_ResetNow", false]};
	if (isNil {_logic getvariable "HAC_HQ_ResetOnDemand"}) then {_logic setvariable ["HAC_HQ_ResetOnDemand", false]};
	if (isNil {_logic getvariable "HAC_HQ_ResetTime"}) then {_logic setvariable ["HAC_HQ_ResetTime", 600]};
	if not (_logic getvariable "HAC_HQ_ResetOnDemand") then {sleep (_logic getvariable "HAC_HQ_ResetTime")} else {waituntil {sleep 1; _logic getvariable "HAC_HQ_ResetNow"};_logic setvariable ["HAC_HQ_ResetNow", false]};
	_Edistance = false;
	
		{
		if ((_x distance _logic) < 2000) exitwith {_Edistance = true};
		}
	foreach (_logic getvariable "HAC_HQ_KnEnemies");
	_logic setvariable ["HAC_HQ_ReconDone", false];
	_logic setvariable ["HAC_HQ_ReconStage", 1];
	if (_Edistance) then
		{
			{
			_LE = (leader _x);
			_LEvar = str _LE;
			_LE setVariable [("Checked" + _LEvar), false]
			}
		foreach ((_logic getvariable "HAC_HQ_Enemies") - (_logic getvariable "HAC_HQ_KnEnemiesG"))
		};

	_logic setvariable ["HAC_HQ_DefDone", false];

	if (not ((_logic getvariable "HAC_HQ_Order") == "DEFEND") or ((random 100) > 95)) then 
		{
			{
			_x setVariable ["Defending", false];
			_x setvariable ["SPRTD",0];
			_x setvariable ["Reinforcing",GrpNull];
			}
		foreach (_logic getvariable "HAC_HQ_Friends")
		};

	_trg = _logic;
	if ((_logic getvariable "HAC_HQ_NObj") == 1) then {_trg = (_logic getvariable "HAC_HQ_Obj")};
	if ((_logic getvariable "HAC_HQ_NObj") == 2) then {_trg = (_logic getvariable "HAC_HQ_Obj2")};
	if ((_logic getvariable "HAC_HQ_NObj") == 3) then {_trg = (_logic getvariable "HAC_HQ_Obj3")};
	if ((_logic getvariable "HAC_HQ_NObj") >= 4) then {_trg = (_logic getvariable "HAC_HQ_Obj4")};

	if (isNil {_logic getvariable "HAC_HQ_ObjRadius1"}) then {_logic setvariable ["HAC_HQ_ObjRadius1", 300]};
	if (isNil {_logic getvariable "HAC_HQ_ObjRadius2"}) then {_logic setvariable ["HAC_HQ_ObjRadius2", 500]};

	_mLoss = 10;
	if (_logic in ((_logic getvariable "HAC_BBa_HQs") + (_logic getvariable "HAC_BBb_HQs"))) then {_mLoss = 0};

	_lastObj = (_logic getvariable "HAC_HQ_NObj");

	_lost = ObjNull;
		{
		_AllV20 = _x nearEntities [["AllVehicles"], (_logic getvariable "HAC_HQ_ObjRadius1")];
		_Civs20 = _x nearEntities [["Civilian"], (_logic getvariable "HAC_HQ_ObjRadius1")];

		_AllV2 = [];

			{
			_AllV2 = _AllV2 + (crew _x)
			}
		foreach _AllV20;

		_Civs20 = _trg nearEntities [["Civilian"],(_logic getvariable "HAC_HQ_ObjRadius2")];

		_Civs2 = [];

			{
			_Civs2 = _Civs2 + (crew _x)
			}
		foreach _Civs20;

		_AllV2 = _AllV2 - _Civs2;

		_AllV20 = +_AllV2;

			{
			if not (_x isKindOf "Man") then
				{
				if ((count (crew _x)) == 0) then {_AllV2 = _AllV2 - [_x]}
				}
			}
		foreach _AllV20;

		_NearEnemies = _logic countenemy _AllV2;
		_AllV0 = _x nearEntities [["AllVehicles"], (_logic getvariable "HAC_HQ_ObjRadius2")];
		_Civs0 = _x nearEntities [["Civilian"], (_logic getvariable "HAC_HQ_ObjRadius2")];

		_AllV = [];

			{
			_AllV = _AllV + (crew _x)
			}
		foreach _AllV0;

		_Civs = [];

			{
			_Civs = _Civs + (crew _x)
			}
		foreach _Civs0;

		_AllV = _AllV - _Civs;
		_AllV0 = +_AllV;

			{
			if not (_x isKindOf "Man") then
				{
				if ((count (crew _x)) == 0) then {_AllV = _AllV - [_x]}
				}
			}
		foreach _AllV0;

		_NearAllies = _logic countfriendly _AllV;

		if (_x == _trg) then
			{
			_captLimit = (_logic getvariable "HAC_HQ_CaptLimit") * (1 + ((_logic getvariable "HAC_HQ_Circumspection")/(2 + (_logic getvariable "HAC_HQ_Recklessness"))));
			_enRoute = 0;

				{
				if not (isNull _x) then
					{
					if (_x getVariable [("Capt" + (str _x)),false]) then
						{
						_enRoute = _enRoute + (count (units _x))
						}
					}
				}
			foreach (_logic getvariable "HAC_HQ_Friends");

			_captDiff = _captLimit - _enRoute;

			if (_captDiff > 0) then
				{	
				private ["_isC","_amountC"];
				_isC = _trg getVariable ("Capturing" + (str _trg));

				_amountC = _isC select 1;
				_isC = _isC select 0;
				if (_isC > 3) then {_isC = 3};
				_trg setVariable [("Capturing" + (str _trg)),[_isC,_amountC - _captDiff]];
				}
			};

		if (_NearEnemies > _NearAllies) exitwith {_lost = _x};
		}
	foreach [(_logic getvariable "HAC_HQ_Obj1"),(_logic getvariable "HAC_HQ_Obj2"),(_logic getvariable "HAC_HQ_Obj3"),(_logic getvariable "HAC_HQ_Obj4")];
        if (isNull _lost)	then {_logic setvariable ["HAC_HQ_NObj", (_logic getvariable "HAC_HQ_NObj")]} else {
        if (_lost == (_logic getvariable "HAC_HQ_Obj1")) then {_logic setvariable ["HAC_HQ_NObj", 1];{_x setVariable [("Capturing" + (str _x)),[0,0]]}foreach [(_logic getvariable "HAC_HQ_Obj1"),(_logic getvariable "HAC_HQ_Obj2"),(_logic getvariable "HAC_HQ_Obj3"),(_logic getvariable "HAC_HQ_Obj4")]} else {
            if ((_lost == (_logic getvariable "HAC_HQ_Obj2")) and ((_logic getvariable "HAC_HQ_NObj") > 2)) then {_logic setvariable ["HAC_HQ_NObj", 2];{_x setVariable [("Capturing" + (str _x)),[0,0]]}foreach [(_logic getvariable "HAC_HQ_Obj2"),(_logic getvariable "HAC_HQ_Obj3"),(_logic getvariable "HAC_HQ_Obj4")]} else {
                if ((_lost == (_logic getvariable "HAC_HQ_Obj3")) and ((_logic getvariable "HAC_HQ_NObj") > 3)) then {_logic setvariable ["HAC_HQ_NObj", 3];{_x setVariable [("Capturing" + (str _x)),[0,0]]}foreach [(_logic getvariable "HAC_HQ_Obj3"),(_logic getvariable "HAC_HQ_Obj4")]} else {
                    if ((_lost == (_logic getvariable "HAC_HQ_Obj4")) and ((_logic getvariable "HAC_HQ_NObj") >= 4)) then {_logic setvariable ["HAC_HQ_NObj", 4];{_x setVariable [("Capturing" + (str _x)),[0,0]]}foreach ([(_logic getvariable "HAC_HQ_Obj4")])}}}}};

	if ((_logic getvariable "HAC_HQ_NObj") < 1) then {_logic setvariable ["HAC_HQ_NObj", 1]};
	if ((_logic getvariable "HAC_HQ_NObj") > 5) then {_logic setvariable ["HAC_HQ_NObj", 5]};
	
	_logic setvariable ["HAC_HQ_Progress", 0];
	if (_lastObj > (_logic getvariable "HAC_HQ_NObj")) then {_logic setvariable ["HAC_HQ_Progress", -1];_logic setvariable ["HAC_HQ_Morale",(_logic getvariable "HAC_HQ_Morale") - _mLoss]};	
	if (_lastObj < (_logic getvariable "HAC_HQ_NObj")) then {_logic setvariable ["HAC_HQ_Progress", 1]};

	_reserve = (_logic getvariable "HAC_HQ_Friends") - ((_logic getvariable "HAC_HQ_ArtG") + ((_logic getvariable "HAC_HQ_AirG") - (_logic getvariable "HAC_HQ_SupportG")) + (_logic getvariable "HAC_HQ_NavalG") + (_logic getvariable "HAC_HQ_StaticG") + (_logic getvariable "HAC_HQ_CargoOnly"));

		{
		_x setVariable [("Deployed" + (str _x)),false];
		}
	foreach _reserve;

		{
		if ((random 100) > 95) then {_x setVariable [("Garrisoned" + (str _x)),false]};
		}
	foreach (_logic getvariable "HAC_HQ_Garrison");

	if (isNil {_logic getvariable "HAC_HQ_Combining"}) then {_logic setvariable ["HAC_HQ_Combining", false]};
	if (_logic getvariable "HAC_HQ_Combining") then 
		{
		_exhausted = +(_logic getvariable "HAC_HQ_Exhausted");
			{
			if (not (isNull _x) and ((count (units _x)) >= 1)) then 
				{
				_unitvar = str _x;
				_nominal = _x getVariable ("Nominal" + (str _x));
				if (isNil ("_nominal")) then {_x setVariable [("Nominal" + _unitvar),(count (units _x)),true];_nominal = _x getVariable ("Nominal" + (str _x))};
				_current = count (units _x);
				if (((_nominal/(_current + 0.1)) > 2) and (isNull (assignedVehicle (leader _x)))) then 
					{
					_ex = ((_logic getvariable "HAC_HQ_Exhausted") - [_x]);
					for [{_a = 0},{(_a < (count _ex))},{_a = _a + 1}] do
						{
						_Aex = _ex select _a;
						_unitvarA = str _Aex;
						_nominalA = _Aex getVariable ("Nominal" + (str _Aex));
						if (isNil ("_nominal")) then {_Aex setVariable [("Nominal" + _unitvarA),(count (units _Aex)),true];_nominalA = _Aex getVariable ("Nominal" + (str _Aex))};
						_currentA = count (units _Aex);
						if (((_nominalA/(_currentA + 0.1)) > 2) and (isNull (assignedVehicle (leader _Aex))) and (((vehicle (leader _x)) distance (vehicle (leader _Aex))) < 200)) then 
							{
							(units _x) joinsilent _Aex;
							sleep 0.05;
							_Aex setVariable [("Nominal" + (str _Aex)),(count (units _Aex)),true];
							};
						};
					};
				}
			else
				{
				_exhausted = _exhausted - [_x]
				};
			}
		foreach (_logic getvariable "HAC_HQ_Exhausted");
		_logic setvariable ["HAC_HQ_Exhausted", _exhausted];
		};
	};