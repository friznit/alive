	private ["_logic","_wp","_pos","_nHouses","_nHouse","_posAll","_posAct","_chosen","_enterable","_stat","_oldStat"];

	_wp = _this select 0;
    _logic = _this select ((count _this)-1);
	_pos = waypointPosition _wp;
	
	_posAll = [];
	_chosen = -1;

	_nHouses = _pos nearObjects ["House",100];

	if ((count _nHouses) > 0) then
		{
		_nHouse = _nHouses select (floor (random (count _nHouses)));
		_nHouses = _nHouses - [_nHouse];

		_enterable = true;
		if ((str (_nHouse buildingpos 0)) == "[0,0,0]") then {_enterable = false};

		if not (_enterable) then
			{
			while {((count _nHouses) > 0)} do
				{
				_nHouse = _nHouses select (floor (random (count _nHouses)));
				_nHouses = _nHouses - [_nHouse];

				_enterable = true;
				if ((str (_nHouse buildingpos 0)) == "[0,0,0]") then {_enterable = false};
				if (_enterable) exitWith {}
				}
			};

		if (_enterable) then
			{
			_posAct = [1,1,1];

			_i = 0;
			while {not ((str _posAct) == "[0,0,0]")} do
				{
				_posAct = _nHouse buildingpos _i;
				_i = _i + 1;
				if not ((str _posAct) == "[0,0,0]") then 
					{
					if not (_posAct in _posAll) then 
						{
						_posAll set [(count _posAll),_posAct]
						}
					}
				}
			};

		if ((count _posAll) > 0) then
			{
			_chosen = _posAll select (floor (random (count _posAll)));
			_wp setWaypointPosition [_chosen,0];
			_stat = "this doMove " + (str _chosen);

			_oldStat = (waypointStatements _wp) select 1;
			_stat = _stat + ";" + _oldStat;

			_wp setWaypointStatements ["true",_stat];
			}
		};

	[_nHouse,_chosen];