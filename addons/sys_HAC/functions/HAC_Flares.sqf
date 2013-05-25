	private ["_logic","_gp","_UL","_nE","_inDef","_Scount","_lat","_day","_hour","_sunangle","_arty","_flare","_shells","_pos","_CFF","_ldr"];

	_gp = _this select 0;
	_arty = _this select 2;
	_shells = _this select 3;
	_ldr = _this select 4;
    _logic = _this select ((count _this)-1);

	_UL = leader _gp;

	_inDef = true;

	while {_inDef} do
		{
		sleep (60 + (random 60));

		_flare = _this select 1;

		if (_flare) then
			{
			if ([_logic] call ALiVE_fnc_HAC_isNight) then
				{
				if not (false) then
					{
					_nE = _UL findnearestenemy _UL;
					if not (isNull _nE) then
						{
						if ((_nE distance (vehicle _UL)) <= 400) then
							{
							_pos = getposASL _nE;

							_CFF = false;

							if ((_shells > 0) and ((random 100) > 50)) then 
								{
								if not (isPlayer _UL) then {if ((random 100) < (_logic getvariable "HAC_xHQ_AIChatDensity")) then {[_UL,(_logic getvariable "HAC_xHQ_AIC_IllumReq"),"IllumReq",_logic] call ALiVE_fnc_HAC_AIChatter}};
								_CFF = ([_pos,_arty,"ILLUM",1,_UL,_logic] call ALiVE_fnc_HAC_ArtyMission) select 0;
								if (_CFF) then
									{
									if ((random 100) < (_logic getvariable "HAC_xHQ_AIChatDensity")) then {[_ldr,(_logic getvariable "HAC_xHQ_AIC_ArtAss"),"ArtAss",_logic] call ALiVE_fnc_HAC_AIChatter};
									}
								else
									{
									if ((random 100) < (_logic getvariable "HAC_xHQ_AIChatDensity")) then {[_ldr,(_logic getvariable "HAC_xHQ_AIC_ArtDen"),"ArtDen",_logic] call ALiVE_fnc_HAC_AIChatter};
									}
								};

							if (not (_CFF) and not (isPlayer _UL)) then
								{

								_Scount = 0;

									{
									if (((vehicle _x) == _x) and not (isPlayer _x)) then 
										{
										if ("FlareWhite_M203" in (magazines _x)) then 
											{
											_x selectWeapon "M203Muzzle";_x fire ["M203Muzzle","M203Muzzle","FlareWhite_M203"];_Scount = _Scount + 1
											} 
										else
											{
											if ("FlareGreen_M203" in (magazines _x)) then
												{
												_x selectWeapon "M203Muzzle";_x fire ["M203Muzzle","M203Muzzle","FlareGreen_M203"];_Scount = _Scount + 1
												} 
											else
												{
												if ("FlareRed_M203" in (magazines _x)) then
													{
													_x selectWeapon "M203Muzzle";_x fire ["M203Muzzle","M203Muzzle","FlareRed_M203"];_Scount = _Scount + 1
													} 
												else
													{
													if ("FlareYellow_M203" in (magazines _x)) then 
														{
														_x selectWeapon "M203Muzzle";_x fire ["M203Muzzle","M203Muzzle","FlareYellow_M203"];_Scount = _Scount + 1
														}
													else 
														{
														if ("FlareWhite_GP25" in (magazines _x)) then 
															{
															_x selectWeapon "GP25Muzzle";_x fire ["GP25Muzzle","GP25Muzzle","FlareWhite_GP25"];_Scount = _Scount + 1
															}
														else
															{
															if ("FlareGreen_GP25" in (magazines _x)) then
																{
																_x selectWeapon "GP25Muzzle";_x fire ["GP25Muzzle","GP25Muzzle","FlareGreen_GP25"];_Scount = _Scount + 1
																}
															else
																{
																if ("FlareRed_GP25" in (magazines _x)) then
																	{
																	_x selectWeapon "GP25Muzzle";_x fire ["GP25Muzzle","GP25Muzzle","FlareRed_GP25"];_Scount = _Scount + 1
																	}
																else
																	{
																	if ("FlareYellow_GP25" in (magazines _x)) then
																		{
																		_x selectWeapon "GP25Muzzle";_x fire ["GP25Muzzle","GP25Muzzle","FlareYellow_GP25"];_Scount = _Scount + 1
																		}
																	}
																}
															}
														}
													}
												}
											}
										};
					
									if (_Scount >= 1) exitwith {};
									}
								foreach (units _gp)
								}
							}
						}
					}
				}
			};

		_inDef = _gp getVariable "Defending";
		if (isNull _gp) then {_inDef = false};
		if not (alive _UL) then {_inDef = false};
		};
    