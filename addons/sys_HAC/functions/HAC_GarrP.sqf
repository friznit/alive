	private ["_logic","_gp","_points","_nHouse","_frm","_wp","_i","_posAll","_posAct","_sum","_sumAct","_added"];

	_gp = _this select 0;
	_points = _this select 1;
    _logic = _this select ((count _this)-1);

		{
		_nHouse = _x nearestObject "House";
		_posAll = [];
		_i = 0;
		_posAct = _nHouse buildingpos _i;
		
		while {not ((str _posAct) in ["[0,0,0]"])} do
			{
			_i = _i + 1;
			_sum = 0;
			
				{
				_sum = _sum + _x
				}
			foreach _posAct;
			
			_added = false;
			
				{
				_sumAct = 0;
				
					{
					_sum = _sum + _x
					}
				foreach _x;
				
				if (_sum == _sumAct) exitWith {_added = true}
				}
			foreach _posAll;
			
			if not (_added) then 
				{
				_posAll set [(count _posAll),_posAct]
				};
				
			_posAct = _nHouse buildingpos _i;
			};

		_frm = "DIAMOND";
		if (isPlayer (leader _gp)) then {_frm = formation _gp};

		_wp = [_logic,[_gp],_x,"MOVE","AWARE","YELLOW","LIMITED",["true",""],false,0.01,[10,15,20],_frm] call ALiVE_fnc_HAC_WPadd;

		//_i = [_x,(random 1000),"markPatrol",(_logic getvariable ["HAC_HQ_Color","ColorOrange"]),"ICON","o_inf"," | Patrol","",[0.3,0.3],_logic] call ALiVE_fnc_HAC_Mark;

		if ((count _posAll) > 0) then
			{
			_wp waypointAttachVehicle _nHouse;
			sleep 0.05;
			_wp setWaypointHousePosition (floor (random (count _posAll)))
			}
		}
	foreach _points;

	_wp = [_logic,[_gp],_points select 0,"CYCLE","AWARE","YELLOW","LIMITED",["true",""],false,0.01,[10,15,20],_frm] call ALiVE_fnc_HAC_WPadd;

	[_gp] spawn
		{
		private ["_logic","_gp","_UL","_nE","_dst"];

		_gp = _this select 0;

		_UL = leader _gp;

		_alive = true;

		waitUntil
			{
			sleep 20;
			_dst = 10000;
			_alive = true;
			if (isNull _gp) then {_alive = false};
			if (_alive) then 
				{
				_UL = leader _gp;
				if not (alive _UL) then {_alive = false};

				if (_alive) then
					{
					_nE = _UL findNearestEnemy (vehicle _UL);
					if not (isNull _nE) then {_dst = _nE distance (vehicle _UL)}
					}
				};
			
			(_dst < 500)
			};

		_gp setVariable ["Garrisoned" + (str _gp),false]
		};