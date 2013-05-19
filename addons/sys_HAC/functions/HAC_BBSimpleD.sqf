	private ["_logic","_HQs","_BBSide","_clusters","_enPos","_ens","_centers","_center","_amounts","_amount","_midX","_midY","_frs","_frCenters","_frCenter","_lPos","_lng","_angle","_arrow","_colorArr","_mainCenter",
	"_amounts","_amount","_battles","_battle","_angleBatt","_tooClose","_mPos","_mSize","_dstAct","_colorBatt","_sizeBatt","_oldSize","_HQPosMark"];

	_HQs = _this select 0;
	_BBSide = _this select 1;
    _logic = _this select ((count _this)-1);

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

			_colorArr = "ColorBlue";
			if (_BBSide == "B") then {_colorArr = "ColorRed"};

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
					_HQPosMark = [(getPosATL (vehicle _x)),(group _x),"HQMark",_colorArr,"ICON","mil_box"," | Position of " + (str _x),"",[0.5,0.5],_logic] call ALiVE_fnc_HAC_Mark;
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

				_colorBatt = "ColorBlue";
				if (_BBSide == "B") then {_colorBatt = "ColorRed"};
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
		};