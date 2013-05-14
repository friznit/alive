	private ["_logic","_threat","_kind","_pool","_cars","_air","_Fpool","_side","_force","_range","_pattern","_SortedForce","_tPos","_limit","_avF","_trg","_ix","_infEnough","_armEnough","_airEnough","_sum","_handled",
	"_SnipersG","_NCrewInfG","_LArmorG","_HArmorG","_LArmorATG","_ATInfG","_AAInfG","_chosen","_ammo","_reck","_topo","_sCity","_sForest","_sHills","_sMeadow","_sGr","_sVal","_mpl","_attackAv","_garrison",
	"_garrR","_flankAv","_busy","_positive","_ATriskResign1","_ATriskResign2","_AAriskResign","_AAthreat","_ATthreat","_allAir","_armorATthreat","_ATRR1","_ATRR2","_thRep","_isClose","_enDst","_thFct","_chVP",
	"_clstE","_Airmpl","_NCVeh","_snpEnough","_cntInf","_cntArm","_cntAir","_cntSnp"];

	_logic = _this select 0;
	_threat = _this select 1;
	_kind = _this select 2;
	_side = _this select 3;
	_ATriskResign1 = _this select 4;
	_ATriskResign2 = _this select 5;
	_AAriskResign = _this select 6;
	_AAthreat = _this select 7;
	_ATthreat = _this select 8;
	_armorATthreat = _this select 9;
	_Fpool = _this select 10;

	_SnipersG = _Fpool select 0;
	_NCrewInfG = _Fpool select 1;
	_air = _Fpool select 2;
	_LArmorG = _Fpool select 3;
	_HArmorG = _Fpool select 4;
	_cars = _Fpool select 5;
	_LArmorATG = _Fpool select 6;
	_ATInfG = _Fpool select 7;
	_AAInfG = _Fpool select 8;
	_reck = _Fpool select 9;
	_attackAv = _Fpool select 10;
	_garrison = _Fpool select 11;
	_garrR = _Fpool select 12;
	_flankAv = _Fpool select 13;
	_allAir = _Fpool select 14;
	_NCVeh = _Fpool select 15;

	_pool = [];

	switch (_kind) do
		{
		case ("Recon") : 
			{
			_pool = [[_SnipersG,0.5,"SNP"],[_NCrewInfG,0.5,"INF"]]
			};

		case ("ATInf") : 
			{
			_pool = [[_SnipersG,0.5,"SNP"],[_air,2,"AIR"],[_NCrewInfG,0.5,"INF"]]
			};

		case ("Inf") : 
			{
			_pool = [[_LArmorG,1,"ARM"],[_HArmorG,1,"ARM"],[_SnipersG,0.5,"SNP"],[_cars,1,"INF"],[_air,2,"AIR"],[_NCrewInfG,0.5,"INF"]]
			};

		case ("Armor") : 
			{
			_pool = [[_air,2,"AIR"],[_HArmorG,1,"ARM"],[_LArmorATG,1,"ARM"],[_ATInfG,0.5,"INF"]]
			};

		case ("Cars") : 
			{
			_pool = [[_LArmorG,1,"ARM"],[_cars,1,"INF"],[_HArmorG,1,"ARM"],[_air,2,"AIR"],[_NCrewInfG,0.5,"INF"]]
			};

		case ("Art") : 
			{
			_pool = [[_air,2,"AIR"],[_LArmorG,1,"ARM"],[_cars,1,"INF"],[_HArmorG,1,"ARM"],[_NCrewInfG,0.5,"INF"]]
			};

		case ("Air") : 
			{
			_pool = [[_air,2,"AIR"],[_AAInfG,0.5,"INF"]]
			};

		case ("Static") : 
			{
			_pool = [[_air,2,"AIR"],[_LArmorG,1,"ARM"],[_SnipersG,0.5,"SNP"],[_cars,1,"INF"],[_HArmorG,1,"ARM"],[_NCrewInfG,0.5,"INF"]]
			};
		};

	_limit = 3;
	_infEnough = 3;
	_armEnough = 2;
	_airEnough = 1;
	_snpEnough = 2;

	_cntInf = {(_x in ((_NCrewInfG - _cars) + _cars))} count _attackAv;
	_cntArm = {(_x in ((_HArmorG + _LArmorG) - (_NCrewInfG + _air)))} count _attackAv;
	_cntAir = {(_x in (_air - (_NCrewInfG)))} count _attackAv;
	_cntSnp = {((_x in (_SnipersG)) and ((count (units _x)) <= 2))} count _attackAv;

		{
		if (_x >= 0) then
			{
			switch (_foreachIndex) do
				{
				case (0) : {_infEnough = ceil (_cntInf * _x)};
				case (1) : {_armEnough = ceil (_cntArm * _x)};
				case (2) : {_airEnough = ceil (_cntAir * _x)};
				case (3) : {_snpEnough = ceil (_cntSnp * _x)};
				}
			}
		}
	foreach (_logic getvariable "HAC_xHQ_MARatio");

	_sVal = 0;
	_mpl = 1 + _reck;

		{
		_handled = _x getVariable "HAC_Attacked";

		_sum = 0;

		if (isNil "_handled") then 
			{
			_sum = 6;
			_infEnough = 3;
			_armEnough = 2;
			_airEnough = 1;
			_snpEnough = 2;

				{
				if (_x >= 0) then
					{
					switch (_foreachIndex) do
						{
						case (0) : {_infEnough = ceil (_cntInf * _x)};
						case (1) : {_armEnough = ceil (_cntArm * _x)};
						case (2) : {_airEnough = ceil (_cntAir * _x)};
						case (3) : {_snpEnough = ceil (_cntSnp * _x)};
						}
					}
				}
			foreach (_logic getvariable "HAC_xHQ_MARatio");
			}
		else
			{
			{_sum = _sum + _x} foreach _handled;
			_infEnough = _handled select 0;
			_armEnough = _handled select 1;
			_airEnough = _handled select 2;
			_snpEnough = _handled select 3;
			};

		if not (alive (leader _x)) then {_sum = 0};
		if (isNull (leader _x)) then {_sum = 0};
		
		if (_sum > 0) then
			{
			_trg = vehicle (leader _x);
			_tPos = getPosATL _trg;	

			_topo = [_trg,5,_logic] call ALiVE_fnc_HAC_TerraCognita;

			_sCity = 100 * (_topo select 0);
			_sForest = 100 * (_topo select 1);
			_sHills = 100 * (_topo select 2);
			_sMeadow = 100 * (_topo select 3);
			_sGr = _topo select 5;

				{
				_pattern = _x select 2;

				switch (true) do
					{
					case (_pattern in ["ARM"]) : {_limit = _armEnough};
					case (_pattern in ["AIR"]) : {_limit = _airEnough};
					case (_pattern in ["SNP"]) : {_limit = _snpEnough};
					default {_limit = _infEnough};
					};

				if (_limit >= 1) then
					{
					_force = _x select 0;
					_range = _x select 1;

					_SortedForce = [_force,_tPos,10000*_range,_logic] call ALiVE_fnc_HAC_DistOrd;

					_avF = _SortedForce;

					_ix = 0;

					while {((_limit > 0) and ((count _avF) > 0) and (_ix < (count _SortedForce)))} do
						{
						_chosen = _SortedForce select _ix;
						_chVP = getPosATL (vehicle (leader _chosen));
						_ix = _ix + 1;

						_positive = true;

						_ammo = [_chosen,_NCVeh] call ALiVE_fnc_HAC_AmmoCount;

						switch (true) do
							{
							case (_pattern in ["SNP"]) : {_sVal = ((((2 * _sHills) + (2 * _sMeadow) + (_sGr/5)) * _mpl) - (((_sCity/2) + _sForest)/_mpl))};
							case (_pattern in ["ARM"]) : {_sVal = ((((5 * _sMeadow) + (_sHills)) * _mpl) - (((_sCity/2) + (3 * _sForest) + _sGr)/_mpl))};
							case (_pattern in ["AIR"]) : {_sVal = ((((4 * _sMeadow) + (_sHills)) * _mpl) - (((_sCity) + (2 * _sForest) + (_SGr/5))/_mpl))};
							default {_sVal = (0.5 + _sCity + (2 * _sForest) + (_sGr/10)) * (0.5 * _mpl) - ((0.05 + (2 * _sMeadow)) * (0.5/_mpl))};
							};

						if (_sVal < (5 + (10 * _reck))) then {_sVal = (5 + (10 * _reck))};

						_busy = _chosen getvariable ("Busy" + (str _chosen));
						if (isNil "_busy") then {_busy = false};

						if (_busy) then
							{
							_positive = false
							}
						else
							{
							if (_ammo == 0) then 
								{
								_positive = false
								} 
							else
								{
								if ((random 100) > _sVal) then
									{
									_positive = false
									}
								else
									{
									if ((_chosen in _garrison) and (((vehicle (leader _chosen)) distance _tPos) > _garrR)) then
										{
										_positive = false
										}
									else
										{
										if not (_chosen in _attackAv) then
											{
											_positive = false
											}
										else
											{
											if (_chosen in _flankAv) then
												{
												_positive = false
												}
											else
												{
												if (_pattern in ["AIR"]) then
													{
													_Airmpl = 0;
													if ([_logic] call ALiVE_fnc_HAC_IsNight) then {_Airmpl = 3};
													if ((((random 100) * (1 + _reck)) < ((_Airmpl + overcast) * 30)) and not ((random 100) > 95)) then
														{
														_positive = false
														}
													}
												else
													{
													if (_pattern in ["SNP","INF"]) then
														{
														if (_pattern in ["SNP"]) then
															{
															if ((count (units _chosen)) > 2) then
																{
																_positive = false
																}
															};

														if ((_chosen in _allAir) and ((count _AAthreat) > 0)) then
															{
															_thRep = [_chVP,_AAthreat,25000,_logic] call ALiVE_fnc_HAC_CloseEnemyB;
															_isClose = _thRep select 0;
															_clstE = getPosATL (vehicle (leader (_thRep select 2)));
															_enDst = [_chVP,_tPos,_clstE,_logic] call ALiVE_fnc_HAC_PointToSecDst;

															if ((_isClose) and (_enDst > 0) and (_enDst < 1500)) then
																{
																_thFct = (2500/(sqrt _enDst))/(0.5 + (2 * _reck));//diag_log format ["Grp: %1 endst: %2 thFct: %3",typeOf (vehicle (leader _chosen)),_enDst,_thFct];
																if (((random 100) < _thFct) and not (((random 100) > (90 - (_reck * 10))) and (_thFct >= (95 - (_reck * 10))))) then 
																	{
																	_positive = false
																	}
																}
															}
														else
															{
															if ((_chosen in (_LArmorG + _HArmorG)) and ((count _ATthreat) > 0)) then
																{
																_thRep = [_chVP,_ATthreat,25000,_logic] call ALiVE_fnc_HAC_CloseEnemyB;
																_isClose = _thRep select 0;
																_clstE = getPosATL (vehicle (leader (_thRep select 2)));
																_enDst = [_chVP,_tPos,_clstE,_logic] call ALiVE_fnc_HAC_PointToSecDst;

																if ((_isClose) and (_enDst > 0) and (_enDst < 1500)) then
																	{
																	_thFct = (2500/(sqrt _enDst))/(0.5 + (2 * _reck));//diag_log format ["Grp: %1 endst: %2 thFct: %3",typeOf (vehicle (leader _chosen)),_enDst,_thFct];
																	if (((random 100) < _thFct) and not (((random 100) > (95 - (_reck * 10))) and (_thFct >= (95 - (_reck * 10))))) then 
																		{
																		_positive = false
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
							};
						
						_ATRR1 = _ATriskResign1;
						_ATRR2 = _ATriskResign2;
						if (_chosen in _LArmorG) then 
							{
							_ATRR1 = _ATRR1 + 10;
							_ATRR2 = _ATRR2 + 10;
							};

						if (_positive) then
							{
							if (_pattern in ["ARM"]) then
								{
								if ((count _ATthreat) > 0) then
									{
									_thRep = [_chVP,_ATthreat,25000,_logic] call ALiVE_fnc_HAC_CloseEnemyB;
									_isClose = _thRep select 0;
									_clstE = getPosATL (vehicle (leader (_thRep select 2)));
									_enDst = [_chVP,_tPos,_clstE,_logic] call ALiVE_fnc_HAC_PointToSecDst;

									if ((_isClose) and (_enDst > 0) and (_enDst < 1500)) then
										{
										_thFct = ((_ATRR1 * 40)/(sqrt _enDst))/(0.5 + (2 * _reck));//diag_log format ["Grp: %1 endst: %2 thFct: %3",typeOf (vehicle (leader _chosen)),_enDst,_thFct];
										if (((random 100) < _thFct) and not (((random 100) > (95 - (_reck * 10))) and (_thFct >= (95 - (_reck * 10))))) then 
											{
											_positive = false
											}
										}
									}
								else
									{
									if ((count _armorATthreat) > 0) then
										{
										_thRep = [_chVP,_ATthreat,25000,_logic] call ALiVE_fnc_HAC_CloseEnemyB;
										_isClose = _thRep select 0;
										_clstE = getPosATL (vehicle (leader (_thRep select 2)));
										_enDst = [_chVP,_tPos,_clstE,_logic] call ALiVE_fnc_HAC_PointToSecDst;

										if ((_isClose) and (_enDst > 0) and (_enDst < 1500)) then
											{
											_thFct = ((_ATRR2 * 40)/(sqrt _enDst))/(0.5 + (2 * _reck));//diag_log format ["Grp: %1 endst: %2 thFct: %3",typeOf (vehicle (leader _chosen)),_enDst,_thFct];
											if (((random 100) < _thFct) and not (((random 100) > (95 - (_reck * 10))) and (_thFct >= (95 - (_reck * 10))))) then 
												{
												_positive = false
												}
											}
										}
									}
								};

							if (_pattern in ["AIR"]) then
								{
								if ((count _AAthreat) > 0) then
									{
									_thRep = [_chVP,_ATthreat,25000,_logic] call ALiVE_fnc_HAC_CloseEnemyB;
									_isClose = _thRep select 0;
									_clstE = getPosATL (vehicle (leader (_thRep select 2)));
									_enDst = [_chVP,_tPos,_clstE,_logic] call ALiVE_fnc_HAC_PointToSecDst;

									if ((_isClose) and (_enDst > 0) and (_enDst < 1500)) then
										{
										_thFct = ((_AAriskResign * 40)/(sqrt _enDst))/(0.5 + (2 * _reck));//diag_log format ["Grp: %1 endst: %2 thFct: %3",typeOf (vehicle (leader _chosen)),_enDst,_thFct];
										if (((random 100) < _thFct) and not (((random 100) > (95 - (_reck * 10))) and (_thFct >= (95 - (_reck * 10))))) then 
											{
											_positive = false
											}
										}
									}
								}
							};

						if (_positive) then
							{
							_chosen setVariable ["Busy" + (str _chosen),true];
							[_chosen,_trg,_logic] spawn ([_side,_pattern] call ALiVE_fnc_HAC_GoLaunch);
							_limit = _limit - 1
							};

						_avF = _avF - [_chosen]
						};

					switch (true) do
						{
						case (_pattern in ["ARM"]) : {_armEnough = _limit};
						case (_pattern in ["AIR"]) : {_airEnough = _limit};
						case (_pattern in ["SNP"]) : {_snpEnough = _limit};
						default {_infEnough = _limit};
						}
					}

				}
			foreach _pool;
			
			_x setVariable ["HAC_Attacked",[_infEnough,_armEnough,_airEnough,_snpEnough]]
			}
		}
	foreach _threat;