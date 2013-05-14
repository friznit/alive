_ne = objNull;
_is = false;
_count = 0;
_logic = _this select ((count _this)-1);

if (_logic getvariable "HAC_HQ_DebugII") then
	{
	waitUntil 
		{
		sleep 1;
		not (isNil {_logic getvariable "HAC_HQ_KnEnemiesG"})	
		};

		{
		_dngr = _x getVariable "NearE";
		if (isNil "_dngr") then {_dngr = 0};
		_i = [(position (vehicle (leader _x))),_x,"markDanger","ColorGreen","ICON","mil_dot",(str _dngr),"",_logic] call ALiVE_fnc_HAC_Mark;
		}
	foreach (_logic getvariable "HAC_HQ_Friends");

	[_logic] spawn
		{
		_logic = _this select 0;
		while {not (isNull (_logic getvariable "HAC_HQ"))} do
			{
				{
				_alive = true;
				if (isNull _x) then {_alive = false};
				if not (alive (leader _x)) then {_alive = false};
				if (_alive) then
					{
					_mark = "MarkDanger" + (str _x);
					_dngr = _x getVariable "NearE";
					if (isNil "_dngr") then {_dngr = 0};

					_mark setMarkerPos (position (vehicle (leader _x)));
					_cl = "ColorGreen";
					if (_dngr > 0.1) then {_cl = "ColorOrange"};
					if (_dngr > 0.5) then {_cl = "ColorRed"};
					
					_mark setMarkerColor _cl;
					_mark setmarkerText (str _dngr)
					}
				else
					{
					deleteMarker ("MarkDanger" + (str _x))
					}
				}
			foreach (_logic getvariable "HAC_HQ_Friends");
			sleep 5;
			}
		}
	};

while {not (isNull (_logic getvariable "HAC_HQ"))} do
	{
	_LCU = (_logic getvariable "HAC_HQ_Friends") - ((_logic getvariable "HAC_HQ_NavalG") + (_logic getvariable "HAC_HQ_SupportG") + (_logic getvariable "HAC_HQ_ArtG") + ((_logic getvariable "HAC_HQ_NCCargoG") - ((_logic getvariable "HAC_HQ_NCrewInfG") - (_logic getvariable "HAC_HQ_SupportG"))));

		{
		_friend = _x;
		_fCount = count (units _friend);
		_UL = leader _friend;
		_cV = vehicle (leader _friend);
		_danger = 0;

			{
			_aV = vehicle (leader _x);
			_dstC = _aV distance _cV;

			if ((isNull _aV) or (isNull _cV)) then {_dstC = 1000};
			if ((_dstC < 500) and (_dstC > 0)) then {_fCount = _fCount + (({alive _x} count (units _x))/(_dstC/3))}
			}
		foreach (_LCU - [_x]);

			{
			if not (isNull _x) then
				{
				if (alive (leader _x)) then
					{
					_dst = (vehicle _UL) distance (vehicle (leader _x));
					_eCount = ({alive _x} count (units _x));
					if (_dst < 1000) then {_danger = _danger + ((_eCount * _eCount / _fCount)/(_dst/3))}
					}
				}
			}
		foreach (_logic getvariable "HAC_HQ_KnEnemiesG");

		if (_danger > 0.15) then
			{
			_UL = leader _x;if not (isPlayer _UL) then {if ((random 100) < (_logic getvariable "HAC_xHQ_AIChatDensity")) then {[_UL,(_logic getvariable "HAC_xHQ_AIC_InDanger"),"InDanger",_logic] call ALiVE_fnc_HAC_AIChatter}};
			};

		_x setvariable ["NearE",_danger];

		if (_logic getvariable "HAC_HQ_DynForm") then
			{
			if not (isNull _x) then
				{
				if (alive (leader _x)) then
					{
					if (_x in _LCU) then
						{
						if not (isPlayer (leader _x)) then 
							{
							_frm = _x getVariable "FormChanged";

							if (_danger > 0.005) then
								{
								if (isNil "_frm") then {_x setVariable ["FormChanged",[formation _x,behaviour (leader _x),speedMode _x]]};
								if ((behaviour (leader _x)) in ["CARELESS","SAFE"]) then
									{
									_x setBehaviour "AWARE"
									};

								if ((speedMode _x) in ["LIMITED"]) then
									{
									_x setSpeedMode "NORMAL"
									};

								if not ((formation _x) in ["WEDGE"]) then
									{
									_x setFormation "WEDGE"
									}
								}
							else
								{
								if not (isNil "_frm") then
									{
									if not ((_frm select 1) == (behaviour (leader _x))) then
										{
										_x setBehaviour (_frm select 1);
										};

									if not ((_frm select 2) == (speedMode _x)) then
										{
										_x setSpeedMode (_frm select 2);
										};

									if not ((_frm select 0) == (formation _x)) then
										{
										_x setFormation (_frm select 0)
										};

									_x setVariable ["FormChanged",nil]
									}
								}
							}
						}
					}
				}
			}
		}
	foreach ((_logic getvariable "HAC_HQ_Friends") - (_logic getvariable "HAC_HQ_AirG"));

	sleep 60;
	};

_logic setvariable ["HAC_HQ_ES", true];
