	private ["_logic","_gp","_int","_int0","_ammoF","_speedF","_enemyF","_tolerance","_air","_cargo","_timer","_alive","_enemy","_UL","_DAV","_GDV","_AV","_inside","_outside","_own","_wplimit","_isBusy","_busy",
	"_isInside","_isOutside","_enG","_arr","_type","_cplR","_cWp","_wpCheck","_boxed","_firedF","_fCount","_forBoxing","_wp"];

	_logic = _this select 0;
	_gp = _this select 1;
	_int0 = _this select 2;

	_int = floor _int0;
	_ammoF = false;

	_speedF = _this select 3;
	_enemyF = _this select 4;
	_tolerance = _this select 5;

	_arr = _this select 6;
	_air = [];
	_enG = [];

	if ((count _arr) > 0) then 
		{
		_enG = _arr select 1;
		_air = _arr select 0
		};

	if not (_int == _int0) then
		{
		_ammoF = true
		};

	_cargo = _this select 7;
	_inside = true;
	if ((count _this) > 8) then {_inside = _this select 8};
	_outside = true;
	if ((count _this) > 9) then {_outside = _this select 9};
	_own = false;
	if ((count _this) > 10)  then {_own = _this select 10};
	_isBusy = false;
	if ((count _this) > 11) then {_isBusy = _this select 11};
	_wpCheck = true;
	if ((count _this) > 12) then {_wpCheck = _this select 12};
	_firedF = false;
	if ((count _this) > 13) then {_firedF = _this select 13};

	_wplimit = 1;
	if not ((_tolerance - (round _tolerance)) == 0) then {_wplimit = 2};

	_timer = 0;
	_alive = false;
	_enemy = false;
	_busy = false;
	_isInside = false;
	_isOutside = false;

	waituntil 
		{
		sleep _int;

		_UL = leader (_this select 0);
		_AV = vehicle _UL;
		_DAV = _UL;
		_GDV = _gp;

		if (_cargo) then
			{
			_AV = assignedVehicle _UL;
			_DAV = assigneddriver _AV;
			if not (_own) then {_GDV = group _DAV};

			waitUntil {sleep 0.5;not (isNull (assignedVehicle _UL))};

			_AV = assignedVehicle _UL;
			_DAV = assigneddriver _AV;
			if not (_own) then {_GDV = group _DAV};
			};


		_alive = true;
		if not (alive _AV) then {_alive = false};
		if (isNull _AV) then {_alive = false};

		if (_enemyF > 0) then
			{
			if not (_GDV in _air) then {_enemy = [_AV,_enG,_enemyF,_logic] call ALiVE_fnc_HAC_CloseEnemy}
			};

		if (not (isNull _GDV) and not (isNull _UL)) then {_alive = true} else {_alive = false};
		if (_speedF) then
			{
			if not (_logic getvariable "HAC_xHQ_SynchroAttack") then
				{
				if (abs (speed (vehicle (leader _GDV))) < 0.05) then {_timer = _timer + 1}
				}
			else
				{
				_type = typeOf _AV;
				_cplR = getNumber (configFile>>"cfgvehicles">>_type>>"precision");
				_cWp = waypointPosition [_gp, (currentWaypoint _gp)];
				if ((abs (speed (vehicle (leader _GDV))) < 0.05) and ((_cWp distance _AV) >= _cplR)) then {_timer = _timer + 1}
				}
			};

		if not (_inside) then
			{			
				{
				if not (_x in _AV) exitwith {_isInside = false};
				_isInside = true;
				}
			foreach (units _gp)
			};

		if not (_outside) then
			{
				{
				if (_x in _AV) exitwith {_isOutside = false};
				_isOutside = true;
				}
			foreach (units _gp)
			};

		if (_cargo) then
			{
			if (_own) then
				{
				_alive = false;
				if not (isNull _AV) then {_alive = true}
				}
			};

		if (_isBusy) then
			{
			_busy = _gp getvariable ("Busy" + (str _gp));
			if (isNil "_busy") then {_busy = false}
			};

		_forBoxing = _gp getVariable "forBoxing";

		if ((_ammoF) and not (isNil "_forBoxing")) then
			{
			[_gp, (currentWaypoint _gp)] setWaypointType "HOLD";
			[_gp, (currentWaypoint _gp)] setWaypointPosition [_forBoxing, 10];
			_forBoxing = nil;
			_gp setVariable ["ForBoxing",nil]
			};

		_boxed = _gp getVariable "isBoxed";

		if ((_ammoF) and not (isNil "_boxed")) then
			{
			_boxed = getPosATL _boxed;
			_boxed = [_boxed,20,_logic] call ALiVE_fnc_HAC_RandomAround;
			_wp = [_logic,_gp,[_boxed select 0,_boxed select 1],"MOVE","AWARE","GREEN","FULL",["true","deletewaypoint [(group this), 0]"]] call ALiVE_fnc_HAC_WPadd;
			_boxed = nil;
			_gp setVariable ["isBoxed",nil]
			};

		_fCount = (leader _gp) getVariable ["FireCount",0];

		if ((_firedF) and (_fCount >= 2)) then
			{
			_timer = _tolerance + _int;
			(leader _gp) setVariable ["FireCount",nil]
			};

		((((count (waypoints _GDV)) < _wplimit) and (_wpCheck)) or (_timer > _tolerance) or (_enemy) or not (_alive) or (_isInside) or (_isOutside) or (_busy))
		};

	if (_timer > _tolerance) then {if ((random 100) < (_logic getvariable "HAC_xHQ_AIChatDensity")) then {[(leader _gp),(_logic getvariable "HAC_xHQ_AIC_OrdDen"),"OrdDen",_logic] call ALiVE_fnc_HAC_AIChatter}};

	[_timer,_alive,_enemy,_busy];