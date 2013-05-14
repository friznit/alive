	private ["_logic","_gp","_UL","_lastV","_Scount"];	

	_gp = _this select 0;
    _logic = _this select ((count _this)-1);

	_UL = leader _gp;

	_lastV = objNull;

	_Scount = 0;
		{
		if (((vehicle _x) == _x) and not (isPlayer _x)) then 
			{
			if (("SmokeShell" in (magazines _x)) or 
				("SmokeShellYellow" in (magazines _x)) or 
					("SmokeShellRed" in (magazines _x)) or 
						("SmokeShellBlue" in (magazines _x)) or
							("SmokeShellPurple" in (magazines _x)) or
								("SmokeShellOrange" in (magazines _x)) or
									("SmokeShellGreen" in (magazines _x))) then 
				{
				_x selectWeapon "SmokeShellMuzzle";_x fire "SmokeShellMuzzle";_Scount = _Scount + 1
				}
			else
				{
				if ("1Rnd_Smoke_M203" in (magazines _x)) then 
					{
					_x selectWeapon "M203Muzzle";_x fire ["M203Muzzle","M203Muzzle","1Rnd_Smoke_M203"];_Scount = _Scount + 1
					} 
				else
					{
					if ("1Rnd_SmokeRed_M203" in (magazines _x)) then
						{
						_x selectWeapon "M203Muzzle";_x fire ["M203Muzzle","M203Muzzle","1Rnd_SmokeRed_M203"];_Scount = _Scount + 1
						} 
					else
						{
						if ("1Rnd_SmokeGreen_M203" in (magazines _x)) then
							{
							_x selectWeapon "M203Muzzle";_x fire ["M203Muzzle","M203Muzzle","1Rnd_SmokeGreen_M203"];_Scount = _Scount + 1
							} 
						else
							{
							if ("1Rnd_SmokeYellow_M203" in (magazines _x)) then 
								{
								_x selectWeapon "M203Muzzle";_x fire ["M203Muzzle","M203Muzzle","1Rnd_SmokeYellow_M203"];_Scount = _Scount + 1
								}
							else
								{
								if ("1Rnd_SMOKE_GP25" in (magazines _x)) then
									{
									_x selectWeapon "GP25Muzzle";_x fire ["GP25Muzzle","GP25Muzzle","1Rnd_SMOKE_GP25"];_Scount = _Scount + 1
									}
								else
									{
									if ("1Rnd_SMOKERED_GP25" in (magazines _x)) then
										{
										_x selectWeapon "GP25Muzzle";_x fire ["GP25Muzzle","GP25Muzzle","1Rnd_SMOKERED_GP25"];_Scount = _Scount + 1
										}
									else
										{
										if ("1Rnd_SMOKEGREEN_GP25" in (magazines _x)) then
											{
											_x selectWeapon "GP25Muzzle";_x fire ["GP25Muzzle","GP25Muzzle","1Rnd_SMOKEGREEN_GP25"];_Scount = _Scount + 1
											}
										else
											{
											if ("1Rnd_SMOKEYELLOW_GP25" in (magazines _x)) then
												{
												_x selectWeapon "GP25Muzzle";_x fire ["GP25Muzzle","GP25Muzzle","1Rnd_SMOKEYELLOW_GP25"];_Scount = _Scount + 1
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

		if not (((vehicle _x) == _x) and not (_lastV == (vehicle _x))) then {_lastV = vehicle _x;_lastV selectWeapon "SmokeLauncher";_lastV fire "SmokeLauncher";_Scount = _Scount + 1};
		if (_Scount >= 3) exitwith {};
		}
	foreach (units _gp);