_logic = _this select ((count _this)-1);
waituntil {sleep 15; ((_logic getvariable "HAC_HQ_Cyclecount") > 2)};

if (isNil {_logic getvariable "HAC_HQ_AirDist"}) then {_logic setvariable ["HAC_HQ_AirDist", 4000]};

while {not (isNull (_logic getvariable "HAC_HQ"))} do 
	{
	sleep 61;
		{
		_veh = vehicle (leader _x);
		_pos = getposATL _veh;
		_start = _x getvariable ("START" + str (_x));
		if (isNil ("_start")) then {_x setVariable [("START" + str (_x)),_pos];sleep 0.05;_start = _x getvariable ("START" + str (_x))};
		_ammo = count (magazines _veh);
		if not (isPlayer (leader _x)) then 
			{
			if (not (_x in ((_logic getvariable "HAC_HQ_RAirG") + (_logic getvariable "HAC_HQ_NCAirG"))) and (_ammo == 0) and (((getposATL _veh) select 2) > 5)) then
				{
				_rest = _x getVariable ("Resting" + (str _x));
				if (isNil ("_rest")) then {_rest = false};
				if not (_rest) then {_x setVariable [("Busy" + (str _x)),false]};
				[_x,_logic] call ALiVE_fnc_HAC_WPdel;

				_wp = [_logic,_x,_start,"MOVE","CARELESS","GREEN","NORMAL",["true", "{(vehicle _x) land 'LAND'} foreach (units (group this)); deletewaypoint [(group this), 0]"]] call ALiVE_fnc_HAC_WPadd;

                    _logic setvariable ["HAC_HQ_Exhausted", (_logic getvariable "HAC_HQ_Exhausted") + [_x]];
				}
			else
				{
				if ((_logic getvariable "HAC_HQ_LZ")) then
					{
					if not (_x getVariable [("Resting" + (str _x)),false]) then
						{
						if not (_x getVariable [("Busy" + (str _x)),false]) then
							{
							_dst = (leader (_logic getvariable "HAC_HQ")) distance _start;
							if (_dst > (_logic getvariable "HAC_HQ_AirDist")) then
								{
								_newPos = [getposATL (leader (_logic getvariable "HAC_HQ")),300,_logic] call ALiVE_fnc_HAC_RandomAround;
								_lz = [_newPos,_logic] call ALiVE_fnc_HAC_LZ;
								if not (isNull _lz) then
									{
									_start = getposATL _lz;
									_x setVariable [("START" + str (_x)),_start];
									_x getVariable [("Busy" + (str _x)),true];
									_wp = [_logic,_x,_start,"MOVE","CARELESS","GREEN","NORMAL",["true", "{(vehicle _x) land 'LAND'} foreach (units (group this)); deletewaypoint [(group this), 0]"]] call ALiVE_fnc_HAC_WPadd;

									[(vehicle (leader _x)),_lz,_x] spawn
										{
										_heli = _this select 0;
										_lz = _this select 1;
										_gp = _this select 2;

										_cause = [_logic,_gp,6,true,0,24,[],false] call ALiVE_fnc_HAC_Wait;
										_timer = _cause select 0;
										_alive = _cause select 1;

										if (_alive) then
											{
											sleep 5;
											_ct = 0;

											waitUntil
												{
												sleep 1;
												_ct = _ct + 1;
												if (isNull _gp) then {_alive = false};
												if not (alive (leader _gp)) then {_alive = false};
												(not (landResult (vehicle (leader _gp)) in ["NotReady"]) or not (_alive) or (_ct > 60))
												};

											sleep 30;

											if (_alive) then {_gp getVariable [("Busy" + (str _gp)),false]}
											};

										deleteVehicle _lz
										}
									}
								}
							}
						}
					}
				}
			}
		else
			{
			if ((_logic getvariable "HAC_HQ_LZ")) then
				{
				_dst = (leader (_logic getvariable "HAC_HQ")) distance _start;
				if (_dst > (_logic getvariable "HAC_HQ_AirDist")) then
					{
					_lz = [getposATL (leader (_logic getvariable "HAC_HQ")),_logic] call ALiVE_fnc_HAC_LZ;
					if not (isNull _lz) then
						{
						_start = getposATL _lz;
						_x setVariable [("START" + str (_x)),_start]
						}
					}
				}
			};

		sleep 0.05;
		}
	foreach (_logic getvariable "HAC_HQ_AirG");
	}