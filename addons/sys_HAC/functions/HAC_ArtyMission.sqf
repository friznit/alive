	private ["_logic","_pos","_artyAv","_vh","_hasAmmo","_minRange","_maxRange","_rangeNeeded","_battery","_artyGp","_template","_ammoCount","_pX","_pY","_pZ","_arty","_ammo","_amount","_ammocheck",
	"_possible","_typeVh","_FO","_batLead","_agp","_batReady"];

	_pos = _this select 0;
	_arty = _this select 1;
	_ammo = _this select 2;
	_amount = _this select 3;
	_FO = _this select 4;
    _logic = _this select ((count _this)-1);

	_possible = false;
	_battery = ObjNull;
	_agp = objNull;

	_ammocheck = "SmokeAmmo";
	
	switch (_ammo) do
		{
		case ("ILLUM") : {_ammocheck = "IllumAmmo"};
		case ("HE") : {_ammocheck = "HEAmmo"};
		case ("WP") : {_ammocheck = "WPAmmo"};
		case ("SADARM") : {_ammocheck = "SADARMAmmo"};
		default {};
		};

	_artyAv = [];

		{
		if not (isNull _x) then
			{
			_vh = assignedvehicle (leader _x);
			_typeVh = typeOf _vh;


			_hasAmmo = _x getVariable [_ammocheck,0];

			if (_hasAmmo >= _amount) then
				{
				_minRange = 2375;
				_maxRange = 5800;

				switch (true) do
					{
					case (_vh isKindOf "StaticMortar") : {_minRange = 100;_maxRange = 3700};
					case (_typeVh in ["MLRS","MLRS_DES_EP1"]) : {_minRange = 4900;_maxRange = 15550};
					case (_typeVh in ["GRAD_CDF","GRAD_INS","GRAD_RU","GRAD_TK_EP1"]) : {_minRange = 3300;_maxRange = 10100};
					};

				_rangeNeeded = _pos distance _vh;

				if ((_rangeNeeded > _minRange) and (_rangeNeeded < _maxRange)) then
					{
					_battery = ObjNull;
					_agp = leader _x;

					if (alive _agp) then
						{
							{
							if (_agp in (synchronizedObjects _x)) exitWith {_battery = _x}
							}
						foreach ([10,10] nearEntities [["BIS_ARTY_Logic"],50]);

						if not (isNull _battery) then
							{
							_batReady = _battery getvariable [("CFF_Ready" + (str _battery)),true];
							if ((not (_battery getVariable "ARTY_ONMISSION")) and (_batReady)) then
								{
								_artyAv set [(count _artyAv),_x]
								}
							}
						}
					}
				}
			}
		}
	foreach _arty;

	if not ((count _artyAv) == 0) then
		{
		_artyGp = _artyAv select (floor (random (count _artyAv)));

		_agp = leader _artyGp;

			{
			if (_agp in (synchronizedObjects _x)) exitWith {_battery = _x}
			}
		foreach ([10,10] nearEntities [["BIS_ARTY_Logic"],50]);

		_possible = true;

		if (_ammo in ["ILLUM","SMOKE"]) then
			{
			[_battery,(200 + (random 200))] call BIS_ARTY_F_SetDispersion;

			_template = ["IMMEDIATE",_ammo,0,_amount];

			_pX = _pos select 0;
			_pY = _pos select 1;
			_pZ = _pos select 2;

			_pX = _pX + (random 100) - 50;
			_pY = _pY + (random 100) - 50;
			_pZ = _pZ + (random 20) - 10;

			_pos = [_pX,_pY,_pZ];

			[_battery,_pos,_template,_FO] spawn
				{
				private ["_logic","_battery","_pos","_template","_ammo","_amount","_angle","_FO","_i","_pos2","_pos3","_i2","_i3"];

				_battery = _this select 0;
				_pos = _this select 1;
				_template = _this select 2;
				_FO = getposASL (_this select 3);
				_ammo = _template select 1;
				_amount = _template select 3;

				if (_ammo == "ILLUM") then 
					{
					[_battery,_pos,_template] call BIS_ARTY_F_ExecuteTemplateMission;
					}
				else
					{
					_angle = [_FO,_pos,10,_logic] call ALiVE_fnc_HAC_AngTowards;
					_pos2 = [_pos,_angle + 110,200 + (random 100) - 50,_logic] call ALiVE_fnc_HAC_PosTowards2D;
					_pos3 = [_pos,_angle - 110,200 + (random 100) - 50,_logic] call ALiVE_fnc_HAC_PosTowards2D;
					//_i2 = [_pos2,(random 1000),"markArty",(_logic getvariable ["HAC_HQ_Color","ColorRed"]),"ICON","o_art",_ammo,"",[0.75,0.75],_logic] call ALiVE_fnc_HAC_Mark;
					//_i3 = [_pos3,(random 1000),"markArty",(_logic getvariable ["HAC_HQ_Color","ColorRed"]),"ICON","o_art",_ammo,"",[0.75,0.75],_logic] call ALiVE_fnc_HAC_Mark;

					_template = ["IMMEDIATE",_ammo,0,ceil (_amount/3)];

					[_battery,_pos,_template] call BIS_ARTY_F_ExecuteTemplateMission;
					waitUntil {sleep 0.1;_battery getVariable "ARTY_COMPLETE"};

					[_battery,_pos2,_template] call BIS_ARTY_F_ExecuteTemplateMission;
					waitUntil {sleep 0.1;_battery getVariable "ARTY_COMPLETE"};

					[_battery,_pos3,_template] call BIS_ARTY_F_ExecuteTemplateMission;
					waitUntil {sleep 0.1;_battery getVariable "ARTY_COMPLETE"};
					} 
				}
			}
		};

	[_possible,_battery,_agp]
    