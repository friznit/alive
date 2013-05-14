	private ["_logic","_area","_BBSide","_isTaken","_HQ","_AllV","_Civs","_AllV2","_Civs2","_NearAllies","_NearEnemies","_trg","_AllV0","_AllV20","_mChange","_HQs","_enArea","_enPos","_BBProg"];

	_area = _this select 0;
	_BBSide = _this select 1;
	_HQ = _this select 2;
    _logic = _this select ((count _this)-1);

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
		};