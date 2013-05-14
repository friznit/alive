	private ["_logic","_enemies","_targets","_target","_nothing","_potential","_potL","_taken","_candidate","_CL","_vehFactor","_artFactor","_crowdFactor","_veh","_nearImp","_ValMax","_trgValS",
	"_temptation","_vh","_HQfactor"];

	_enemies = _this select 0;
    _logic = _this select ((count _this)-1);

	_targets = [];
	_target = objNull;
	_temptation = 0;
	_nothing = 0;

		{
		_potential = _x;
		
		_potL = vehicle (leader _potential);
		_taken = (leader _potential) getVariable [("CFF_Taken" + str (leader _potential)),false];

		if not (isNull _potential) then
			{
			if (alive _potential) then
				{
				if not (_taken) then
					{
					if (((getposATL _potL) select 2) < 20) then
						{ 
						if ((abs(speed _potL)) < 50) then
							{ 
							if ((count (weapons (leader _potential))) > 0) then
								{ 
								if not ((leader _potential) isKindOf "civilian") then 
									{
									if not (captive _potL) then
										{
										if not (_potential in _targets) then
											{
											if ((damage _potL) < 0.9) then 
												{
												_targets set [(count _targets),_potential]
												}
											}
										}
									}
								}
							}
						}
					}
				}
			}
		}
	foreach _enemies;

		{
		_candidate = _x;
		_CL = leader _candidate;

		_temptation = 0;
		_vehFactor = 0;
		_artFactor = 1;
		_crowdFactor = 1;
		_HQFactor = 1;
		_veh = ObjNull;

		if not (isNull (assignedVehicle _CL)) then {_veh = assignedVehicle _CL};
		if not ((vehicle _CL) == _CL) then 
			{
			_veh = vehicle _CL;
			if (typeOf _veh in ((_logic getvariable "HAC_HQ_Howitzer") + (_logic getvariable "HAC_HQ_Mortar") + (_logic getvariable "HAC_HQ_Rocket"))) then {_artFactor = 10} else {_vehFactor = 500 + (rating _veh)};
			};

		_nearImp = (getPosATL _CL) nearEntities [["CAManBase","AllVehicles","Strategic","WarfareBBaseStructure","Fortress"],100];

			{
			if (((side _x) getFriend (side _CL) >= 0.6) and not (_x isKindOf "civilian")) then 
				{
				_vh = vehicle _x;
				_crowdFactor = _crowdFactor + 0.2;
				if not (_x == _vh) then 
					{
					_crowdFactor = _crowdFactor + 0.2;
					if (typeOf _vh in ((_logic getvariable "HAC_HQ_Howitzer") + (_logic getvariable "HAC_HQ_Mortar") + (_logic getvariable "HAC_HQ_Rocket"))) then 
						{
						_crowdFactor = _crowdFactor + 0.2
						}
					}
				};
			}
		foreach _nearImp;

		if (_CL in (_logic getvariable "HAC_HQ_AllLeaders")) then {_HQFactor = 20};

			{
			_temptation = _temptation + (250 + (rating _x));
			}
		foreach (units _candidate);

		_temptation = (((_temptation + _vehFactor)*10)/(5 + (speed _CL))) * _artFactor * _crowdFactor * _HQFactor;
		_candidate setVariable ["CFF_Temptation",_temptation]
		}
	foreach _targets;

	_ValMax = 0;
	_target = _targets select 0;

		{
		_trgValS = _x getVariable ["CFF_Temptation",0];
		if ((_ValMax < _trgValS) and (random 100 < 85)) then {_ValMax = _trgValS;_target = _x};
		}
	foreach _targets;

	if (isNull _target) then 
		{
		if not ((count _targets) == 0) then 
			{
			_target = _targets select (floor (random (count _targets)))
			} 
		else 
			{
			_nothing = 1
			}
		};

	_target
    