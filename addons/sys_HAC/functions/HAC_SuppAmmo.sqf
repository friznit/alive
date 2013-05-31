_logic = _this select ((count _this)-1);
waitUntil {sleep 10;(!(isNil {_logic getvariable "HAC_HQ_Support"}) && !(isNil {_logic getvariable "HAC_HQ_AmmoDrop"}))};
waituntil {sleep 10;(((count ((_logic getvariable "HAC_HQ_Support") + (_logic getvariable "HAC_HQ_AmmoDrop"))) > 0) and ((_logic getvariable "HAC_HQ_Cyclecount") > 2))};

if (isNil {_logic getvariable "RHQ_Ammo"}) then {_logic setvariable ["RHQ_Ammo", []]};
if (isNil {_logic getvariable "HAC_HQ_SAmmo"}) then {_logic setvariable ["HAC_HQ_SAmmo", true]};
if (isNil {_logic getvariable "HAC_HQ_ExReammo"}) then {_logic setvariable ["HAC_HQ_ExReammo", []]};
if (isNil {_logic getvariable "HAC_HQ_AmmoPoints"}) then {_logic setvariable ["HAC_HQ_AmmoPoints",[]]};

_ammo = (_logic getvariable "RHQ_Ammo") + ["T810Reammo_Des_ACR","T810Reammo_ACR","UralReammo_TK_EP1","MtvrReammo_DES_EP1","V3S_Reammo_TK_GUE_EP1","UralReammo_INS","KamazReammo","UralReammo_CDF","MtvrReammo"] - (_logic getvariable "RHQs_Ammo");

_noenemy = true;

sleep 7;
while {not (isNull (_logic getvariable "HAC_HQ"))} do
	{
	waituntil {sleep 5;(_logic getvariable "HAC_HQ_SAmmo")};
	sleep 25;
	
	_logic setvariable ["HAC_HQ_AmmoSupport", []];
	_logic setvariable ["HAC_HQ_AmmoSupportG", []];

		{
		if not (_x in (_logic getvariable "HAC_HQ_AmmoSupport")) then
			{
			if ((typeOf (assignedvehicle _x)) in _ammo) then 
				{
                    _logic setvariable ["HAC_HQ_AmmoSupport", (_logic getvariable "HAC_HQ_AmmoSupport") + [_x]];

				if not ((group _x) in ((_logic getvariable "HAC_HQ_AmmoSupportG") + (_logic getvariable "HAC_HQ_SpecForG") + (_logic getvariable "HAC_HQ_CargoOnly"))) then 
					{
                        _logic setvariable ["HAC_HQ_AmmoSupportG", (_logic getvariable "HAC_HQ_AmmoSupportG") + [group _x]];
					}
				}
			}
		}
	foreach (_logic getvariable "HAC_HQ_Support");

		{
		if not (_x in (_logic getvariable "HAC_HQ_AmmoSupportG")) then
			{
                _logic setvariable ["HAC_HQ_AmmoSupportG", (_logic getvariable "HAC_HQ_AmmoSupportG") + [group _x]];
			}
		}
	foreach (_logic getvariable "HAC_HQ_AmmoDrop");

	_Hollow = [];
	_soldiers = [];
	_ZeroA = [];

		{
		_ammoN = 0;

			{
			_ammoN = _ammoN + (count (magazines _x))
			}
		foreach (units _x);

			{
			_av = assignedvehicle _x;

			if not (isNull _av) then
				{
				if ((_av ammo ((weapons _av) select 0)) == 0) then
					{
					if not (_av in _ZeroA) then
						{
						if not ((typeOf _av) in ((_logic getvariable "HAC_HQ_NCVeh"))) then
							{
							if (((getposATL _x) select 2) < 5) then 
								{
								_ZeroA set [(count _ZeroA),_av]
								}
							}
						}
					}
				};

			if ((vehicle _x) == _x) then
				{
				if (((_x ammo ((weapons _x) select 0)) == 0) or ((count (magazines _x)) < 2) or ((_ammoN/(((count (units (group _x))) + 0.1)) < (6/((HAC_HQ_Recklessness*2) + 1))))) then
					{
					if not (_x in _Hollow) then 
						{
						_Hollow set [(count _Hollow),_x]; 
						if not (_x in _soldiers) then 
							{
							_soldiers set [(count _soldiers),_x]
							}
						}
					}
				}
			}
		foreach (units _x)
		}
	foreach ((_logic getvariable "HAC_HQ_Friends") - (_logic getvariable "HAC_HQ_ExReammo"));

	//_Hollow = _Hollow + _ZeroA;
	_logic setvariable ["HAC_HQ_Hollow", _Hollow + _ZeroA];
	_MTrucks = [];
	if (isNil {_logic getvariable "HAC_HQ_ASupportedG"}) then {_logic setvariable ["HAC_HQ_ASupportedG", []]};

		{
		_mtr = assignedVehicle (leader _x);

		if not (isNull _mtr) then
			{
			if (canMove _mtr) then
				{
				if ((fuel _mtr) > 0.2) then
					{
					_unitvar = str (_x);
					_busy = false;
					_busy = _x getvariable ("Busy" + _unitvar);
					if (isNil ("_busy")) then {_busy = false};

					if not (_busy) then
						{
						if not (_x in _MTrucks) then 
							{
							_MTrucks set [(count _MTrucks),_x]
							}
						}
					}
				}
			}
		}
	foreach (_logic getvariable "HAC_HQ_AmmoSupportG");

	_MTrucks2 = [];
	_MTrucks3 = [];

		{
		if (_x in (_logic getvariable "HAC_HQ_AmmoDrop")) then
			{
			_MTrucks3 set [(count _MTrucks3),_x]
			}
		else
			{
			_MTrucks2 set [(count _MTrucks2),_x]
			}
		}
	foreach _MTrucks;

	_MTrucks2a = +_MTrucks2;
	_MTrucks3a = +_MTrucks3;

	_Zunits = +_ZeroA;
	_a = 0;
	for [{_a = 500},{_a <= 20000},{_a = _a + 500}] do
		{
			{
			_MTruck = assignedvehicle (leader _x);
			if (isNil ("_busy")) then {_busy = false};

			for [{_b = 0},{_b < (count _ZeroA)},{_b = _b + 1}] do 
				{
				_Zunit = _ZeroA select _b;

					{
					if ((_Zunit distance (assignedvehicle (leader _x))) < 400) exitwith {if not ((group _Zunit) in (_logic getvariable "HAC_HQ_ASupportedG")) then {_logic setvariable ["HAC_HQ_ASupportedG", (_logic getvariable "HAC_HQ_ASupportedG") + [group _Zunit]]}};
					}
				foreach ((_logic getvariable "HAC_HQ_AmmoSupportG"));

					{
					if ((_Zunit distance _x) < 400) exitwith {if not ((group _Zunit) in (_logic getvariable "HAC_HQ_ASupportedG")) then {_logic setvariable ["HAC_HQ_ASupportedG", (_logic getvariable "HAC_HQ_ASupportedG") + [group _Zunit]]}};
					}
				foreach ((_logic getvariable "HAC_HQ_AmmoPoints"));

				_noenemy = true;

				_halfway = [(((position _MTruck) select 0) + ((position _Zunit) select 0))/2,(((position _MTruck) select 1) + ((position _Zunit) select 1))/2];
				_distT = 500/(0.75 + ((_logic getvariable "HAC_HQ_Recklessness")/2));
				_eClose1 = [_Zunit,(_logic getvariable "HAC_HQ_KnEnemiesG"),_distT,_logic] call ALiVE_fnc_HAC_CloseEnemy;
				_eClose2 = [_halfway,(_logic getvariable "HAC_HQ_KnEnemiesG"),_distT,_logic] call ALiVE_fnc_HAC_CloseEnemy;				
				if ((_eClose1) or (_eClose2)) then {_noenemy = false};
				if not ((group _Zunit) in (_logic getvariable "HAC_HQ_ASupportedG")) then
					{
					_UL = leader (group (assignedDriver _Zunit));
					if not (isPlayer _UL) then {if ((random 100) < (_logic getvariable "HAC_xHQ_AIChatDensity")) then {[_UL,(_logic getvariable "HAC_xHQ_AIC_SuppReq"),"SuppReq",_logic] call ALiVE_fnc_HAC_AIChatter}};
					};
				
				if (not ((group _Zunit) in (_logic getvariable "HAC_HQ_ASupportedG")) and ((_Zunit distance _MTruck) <= _a) and (_noenemy) and (_x in _MTrucks)) then 
					{
					if ((random 100) < (_logic getvariable "HAC_xHQ_AIChatDensity")) then {[_logic,(_logic getvariable "HAC_xHQ_AIC_SuppAss"),"SuppAss",_logic] call ALiVE_fnc_HAC_AIChatter};
					_MTrucks2 = _MTrucks2 - [_x];
					_Zunits = _Zunits - [_Zunit];
					_logic setvariable ["HAC_HQ_ASupportedG", (_logic getvariable "HAC_HQ_ASupportedG") + [group _Zunit]];
					[_MTruck,_Zunit,_Hollow,_soldiers,false,objNull,_logic] spawn ALiVE_fnc_HAC_GoAmmoSupp
					}
				else
					{
					if (_a == 20000) then 
						{
						if not ((group _Zunit) in (_logic getvariable "HAC_HQ_ASupportedG")) then {if ((random 100) < (_logic getvariable "HAC_xHQ_AIChatDensity")) then {[_logic,(_logic getvariable "HAC_xHQ_AIC_SuppDen"),"SuppDen",_logic] call ALiVE_fnc_HAC_AIChatter}};
						_Zunits = _Zunits - [_Zunit]
						};
					};
				
				if (((count _MTrucks2) == 0) or ((count _Zunits) == 0)) exitwith {};
				};
			if (((count _MTrucks2) == 0) or ((count _Zunits) == 0)) exitwith {};
			sleep 0.1;
			}
		foreach _MTrucks2a;
		};

	if ((count (_logic getvariable "HAC_HQ_AmmoBoxes")) > 0) then
		{
		_Hunits = +_Hollow;

		for [{_a = 500},{_a < 20000},{_a = _a + 500}] do
			{
				{
				_MTruck = assignedvehicle (leader _x);
				for [{_b = 0},{_b < (count _Hollow)},{_b = _b + 1}] do 
					{
					_Hunit = _Hollow select _b;

						{
						if ((_Hunit distance (assignedvehicle (leader _x))) < 250) exitwith {if not ((group _Hunit) in (_logic getvariable "HAC_HQ_ASupportedG")) then {_logic setvariable ["HAC_HQ_ASupportedG", (_logic getvariable "HAC_HQ_ASupportedG") + [group _Hunit]]}};
						}
					foreach (_logic getvariable "HAC_HQ_AmmoSupportG");

						{
						if ((_Hunit distance _x) < 250) exitwith {if not ((group _Zunit) in (_logic getvariable "HAC_HQ_ASupportedG")) then {_logic setvariable ["HAC_HQ_ASupportedG", (_logic getvariable "HAC_HQ_ASupportedG") + [group _Hunit]]}};
						}
					foreach ((_logic getvariable "HAC_HQ_AmmoPoints"));

					_noenemy = true;
					_halfway = [(((position _MTruck) select 0) + ((position _Hunit) select 0))/2,(((position _MTruck) select 1) + ((position _Hunit) select 1))/2];
					_distT = 300/(0.75 + ((_logic getvariable "HAC_HQ_Recklessness")/2));
					_eClose1 = [_Hunit,(_logic getvariable "HAC_HQ_KnEnemiesG"),_distT,_logic] call ALiVE_fnc_HAC_CloseEnemy;
					_eClose2 = [_halfway,(_logic getvariable "HAC_HQ_KnEnemiesG"),_distT,_logic] call ALiVE_fnc_HAC_CloseEnemy;				
					if ((_eClose1) or (_eClose2)) then {_noenemy = false};

					if not ((group _Nunit) in ((_logic getvariable "HAC_HQ_ASupportedG") + (_logic getvariable "HAC_HQ_Boxed"))) then
						{
						_UL = leader (group _Hunit);
						if not (isPlayer _UL) then {if ((random 100) < (_logic getvariable "HAC_xHQ_AIChatDensity")) then {[_UL,(_logic getvariable "HAC_xHQ_AIC_SuppReq"),"SuppReq",_logic] call ALiVE_fnc_HAC_AIChatter}};
						};
				
					if (not ((group _Hunit) in ((_logic getvariable "HAC_HQ_ASupportedG") + (_logic getvariable "HAC_HQ_Boxed"))) and ((_Hunit distance _MTruck) <= _a) and (_noenemy) and (_x in _MTrucks) and ((count (_logic getvariable "HAC_HQ_AmmoBoxes")) > 0)) then 
						{
						if ((random 100) < (_logic getvariable "HAC_xHQ_AIChatDensity")) then {[_logic,(_logic getvariable "HAC_xHQ_AIC_SuppAss"),"SuppAss",_logic] call ALiVE_fnc_HAC_AIChatter};
						_MTrucks3 = _MTrucks3 - [_x];
						_Hunits = _Hunits - [_Hunit];
						_logic setvariable ["HAC_HQ_ASupportedG", (_logic getvariable "HAC_HQ_ASupportedG") + [group _Hunit]];
						_ammoBox = (_logic getvariable "HAC_HQ_AmmoBoxes") select 0;
						_logic setvariable ["HAC_HQ_AmmoBoxes", (_logic getvariable "HAC_HQ_AmmoBoxes") - [_ammoBox]];
						[_MTruck,_Hunit,_Hollow,_soldiers,true,_ammoBox,_logic] spawn ALiVE_fnc_HAC_GoAmmoSupp; 
						}
					else
						{
						if (_a == 20000) then 
							{
							if not ((group _Hunit) in (_logic getvariable "HAC_HQ_ASupportedG")) then {if ((random 100) < (_logic getvariable "HAC_xHQ_AIChatDensity")) then {[_logic,(_logic getvariable "HAC_xHQ_AIC_SuppDen"),"SuppDen",_logic] call ALiVE_fnc_HAC_AIChatter}};
							_Hunits = _Hunits - [_Hunit]
							};
						};				
					if (((count _MTrucks3) == 0) or ((count _Hunits) == 0)) exitwith {};
					};
				if (((count _MTrucks3) == 0) or ((count _Hunits) == 0)) exitwith {};
				sleep 0.1
				}
			foreach _MTrucks3a
			}
		}
	};