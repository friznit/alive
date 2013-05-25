_logic = _this select ((count _this)-1);
waituntil {sleep 10;(not (isNil {_logic getvariable "HAC_HQ_Support"}) and ((count (_logic getvariable "HAC_HQ_Support")) > 0) and ((_logic getvariable "HAC_HQ_Cyclecount") > 2))};

if (isNil {_logic getvariable "RHQ_Fuel"}) then {_logic setvariable ["RHQ_Fuel", []]};
if (isNil {_logic getvariable "HAC_HQ_SFuel"}) then {_logic setvariable ["HAC_HQ_SFuel", true]};
if (isNil {_logic getvariable "HAC_HQ_ExRefuel"}) then {_logic setvariable ["HAC_HQ_ExRefuel", []]};
if (isNil {_logic getvariable "HAC_HQ_FuelPoints"}) then {_logic setvariable ["HAC_HQ_FuelPoints",[]]};

_fuel = (_logic getvariable "RHQ_Fuel") + ["T810Refuel_Des_ACR","T810Refuel_ACR","UralRefuel_TK_EP1","MtvrRefuel_DES_EP1","V3S_Refuel_TK_GUE_EP1","UralRefuel_INS","KamazRefuel","UralRefuel_CDF","MtvrRefuel"] - (_logic getvariable "RHQs_Fuel");
_noenemy = true;
sleep 3;
while {not (isNull (_logic getvariable "HAC_HQ"))} do
	{
	waituntil {sleep 5;(_logic getvariable "HAC_HQ_SFuel")};
	sleep 25;
	
	_logic setvariable ["HAC_HQ_FuelSupport", []];
	_logic setvariable ["HAC_HQ_FuelSupportG", []];

		{
		if not (_x in (_logic getvariable "HAC_HQ_FuelSupport")) then
			{
			if ((typeOf (assignedvehicle _x)) in _fuel) then 
				{
                _logic setvariable ["HAC_HQ_FuelSupport",(_logic getvariable "HAC_HQ_FuelSupport") + [_x]];
				if not ((group _x) in ((_logic getvariable "HAC_HQ_FuelSupportG") + (_logic getvariable "HAC_HQ_SpecForG") + (_logic getvariable "HAC_HQ_CargoOnly"))) then 
					{
                    _logic setvariable ["HAC_HQ_FuelSupportG",(_logic getvariable "HAC_HQ_FuelSupportG") + [group _x]];
					}
				}
			}
		}
	foreach (_logic getvariable "HAC_HQ_Support");

	_dried = [];
	_ZeroF = [];

		{
			{
			_av = assignedvehicle _x;
			if not (isNull _av) then
				{
				if ((fuel _av) <= 0.1) then
					{
					if not (_av in _dried) then
						{
						if (((getposATL _x) select 2) < 5) then 
							{
							_dried set [(count _dried),(assignedvehicle _x)]
							}
						}
					}
				};

			if not (isNull _av) then
				{
				if ((fuel _av) == 0) then
					{
					if not (_av in _ZeroF) then
						{
						if (((getposATL _x) select 2) < 5) then 
							{
							_ZeroF set [(count _ZeroF),(assignedvehicle _x)]
							}
						}
					}
				}
			}
		foreach (units _x)
		}
	foreach ((_logic getvariable "HAC_HQ_Friends") - (_logic getvariable "HAC_HQ_ExRefuel"));

	_logic setvariable ["HAC_HQ_Dried", _dried];
	_cisterns = [];
	if (isNil {_logic getvariable "HAC_HQ_FSupportedG"}) then {_logic setvariable ["HAC_HQ_FSupportedG", []]};

		{
		_cis = assignedVehicle (leader _x);

		if not (isNull _cis) then
			{
			if (canMove _cis) then
				{
				if ((fuel _cis) > 0.2) then
					{
					_unitvar = str (_x);
					_busy = false;
					_busy = _x getvariable ("Busy" + _unitvar);
					if (isNil ("_busy")) then {_busy = false};

					if not (_busy) then
						{
						if not (_x in _cisterns) then 
							{
							_cisterns set [(count _cisterns),_x]
							}
						}
					}
				}
			}
		}
	foreach (_logic getvariable "HAC_HQ_FuelSupportG");

	_cisterns2 = +_cisterns;
	_Zunits = +_ZeroF;
	_a = 0;
	for [{_a = 500},{_a <= 20000},{_a = _a + 500}] do
		{
			{
			_cistern = assignedvehicle (leader _x);
			if (isNil ("_busy")) then {_busy = false};

			for [{_b = 0},{_b < (count _ZeroF)},{_b = _b + 1}] do 
				{
				_Zunit = _ZeroF select _b;

					{
					if ((_Zunit distance (assignedvehicle (leader _x))) < 300) exitwith {if not ((group _Zunit) in (_logic getvariable "HAC_HQ_FSupportedG")) then {_logic setvariable ["HAC_HQ_FSupportedG",(_logic getvariable "HAC_HQ_FSupportedG") + [group _Zunit]]}};
					}
				foreach (_logic getvariable "HAC_HQ_FuelSupportG");

					{
					if ((_Zunit distance _x) < 300) exitwith {if not ((group _Zunit) in (_logic getvariable "HAC_HQ_FSupportedG")) then {_logic setvariable ["HAC_HQ_FSupportedG",(_logic getvariable "HAC_HQ_FSupportedG") + [group _Zunit]]}};
					}
				foreach (_logic getvariable "HAC_HQ_FuelPoints");

				_noenemy = true;
				_halfway = [(((position _cistern) select 0) + ((position _Zunit) select 0))/2,(((position _cistern) select 1) + ((position _Zunit) select 1))/2];
				_distT = 500/(0.75 + ((_logic getvariable "HAC_HQ_Recklessness")/2));
				_eClose1 = [_Zunit,(_logic getvariable "HAC_HQ_KnEnemiesG"),_distT,_logic] call ALiVE_fnc_HAC_CloseEnemy;
				_eClose2 = [_halfway,(_logic getvariable "HAC_HQ_KnEnemiesG"),_distT,_logic] call ALiVE_fnc_HAC_CloseEnemy;				
				if ((_eClose1) or (_eClose2)) then {_noenemy = false};
				
				if not ((group _Dunit) in (_logic getvariable "HAC_HQ_FSupportedG")) then
					{
					_UL = leader (group (assignedDriver _Zunit));
					if not (isPlayer _UL) then {if ((random 100) < (_logic getvariable "HAC_xHQ_AIChatDensity")) then {[_UL,(_logic getvariable "HAC_xHQ_AIC_SuppReq"),"SuppReq",_logic] call ALiVE_fnc_HAC_AIChatter}};
					};

				if (not ((group _Zunit) in (_logic getvariable "HAC_HQ_FSupportedG")) and ((_Zunit distance _cistern) <= _a) and (_noenemy) and (_x in _cisterns)) then 
					{
					if ((random 100) < (_logic getvariable "HAC_xHQ_AIChatDensity")) then {[_logic,(_logic getvariable "HAC_xHQ_AIC_SuppAss"),"SuppAss",_logic] call ALiVE_fnc_HAC_AIChatter};
					_cisterns = _cisterns - [_x];
					_Zunits = _Zunits - [_Zunit];
					_logic setvariable ["HAC_HQ_FSupportedG",(_logic getvariable "HAC_HQ_FSupportedG") + [group _Zunit]];
					[_cistern,_Zunit,_dried,_logic] spawn A_GoFuelSupp; 
					}
				else
					{
					if (_a == 20000) then 
						{
						if not ((group _Zunit) in (_logic getvariable "HAC_HQ_FSupportedG")) then {if ((random 100) < (_logic getvariable "HAC_xHQ_AIChatDensity")) then {[_logic,(_logic getvariable "HAC_xHQ_AIC_SuppDen"),"SuppDen",_logic] call ALiVE_fnc_HAC_AIChatter}};
						_Zunits = _Zunits - [_Zunit]
						};
					};
				
				if (((count _cisterns) == 0) or ((count _Zunits) == 0)) exitwith {};
				};
			if (((count _cisterns) == 0) or ((count _Zunits) == 0)) exitwith {};
			sleep 0.1;
			}
		foreach _cisterns2;
		};

	_Dunits = +_dried;

	for [{_a = 500},{_a < 10000},{_a = _a + 500}] do
		{
			{
			_cistern = assignedvehicle (leader _x);
			for [{_b = 0},{_b < (count _dried)},{_b = _b + 1}] do 
				{
				_Dunit = _dried select _b;

					{
					if ((_Dunit distance (assignedvehicle (leader _x))) < 400) exitwith {if not ((group _Dunit) in (_logic getvariable "HAC_HQ_FSupportedG")) then {_logic setvariable ["HAC_HQ_FSupportedG",(_logic getvariable "HAC_HQ_FSupportedG") + [group _Dunit]]}};
					}
				foreach (_logic getvariable "HAC_HQ_FuelSupportG");

					{
					if ((_Dunit distance _x) < 400) exitwith {if not ((group _Dunit) in (_logic getvariable "HAC_HQ_FSupportedG")) then {_logic setvariable ["HAC_HQ_FSupportedG",(_logic getvariable "HAC_HQ_FSupportedG") + [group _Dunit]]}};
					}
				foreach (_logic getvariable "HAC_HQ_FuelPoints");

				_noenemy = true;
				_halfway = [(((position _cistern) select 0) + ((position _Dunit) select 0))/2,(((position _cistern) select 1) + ((position _Dunit) select 1))/2];
				_distT = 600/(0.75 + ((_logic getvariable "HAC_HQ_Recklessness")/2));
				_eClose1 = [_Dunit,(_logic getvariable "HAC_HQ_KnEnemiesG"),_distT,_logic] call ALiVE_fnc_HAC_CloseEnemy;
				_eClose2 = [_halfway,(_logic getvariable "HAC_HQ_KnEnemiesG"),_distT,_logic] call ALiVE_fnc_HAC_CloseEnemy;				
				if ((_eClose1) or (_eClose2)) then {_noenemy = false};

				if not ((group _Dunit) in (_logic getvariable "HAC_HQ_FSupportedG")) then
					{
					_UL = leader (group (assignedDriver _Dunit));
					if not (isPlayer _UL) then {if ((random 100) < (_logic getvariable "HAC_xHQ_AIChatDensity")) then {[_UL,(_logic getvariable "HAC_xHQ_AIC_SuppReq"),"SuppReq",_logic] call ALiVE_fnc_HAC_AIChatter}};
					};
				
				if (not ((group _Dunit) in (_logic getvariable "HAC_HQ_FSupportedG")) and ((_Dunit distance _cistern) <= _a) and (_noenemy) and (_x in _cisterns)) then 
					{
					if ((random 100) < (_logic getvariable "HAC_xHQ_AIChatDensity")) then {[_logic,(_logic getvariable "HAC_xHQ_AIC_SuppAss"),"SuppAss",_logic] call ALiVE_fnc_HAC_AIChatter};
					_cisterns = _cisterns - [_x];
					_Dunits = _Dunits - [_Dunit];
					_logic setvariable ["HAC_HQ_FSupportedG",(_logic getvariable "HAC_HQ_FSupportedG") + [group _Dunit]];
					[_cistern,_Dunit,_dried,_logic] spawn A_GoFuelSupp; 
					}
				else
					{
					if (_a == 10000) then 
						{
						if not ((group _Dunit) in (_logic getvariable "HAC_HQ_FSupportedG")) then {if ((random 100) < (_logic getvariable "HAC_xHQ_AIChatDensity")) then {[_logic,(_logic getvariable "HAC_xHQ_AIC_SuppDen"),"SuppDen",_logic] call ALiVE_fnc_HAC_AIChatter}};
						_Dunits = _Dunits - [_Dunit]
						};
					};
				
				if (((count _cisterns) == 0) or ((count _Dunits) == 0)) exitwith {};
				};
			if (((count _cisterns) == 0) or ((count _Dunits) == 0)) exitwith {};
			sleep 0.1;
			}
		foreach _cisterns2;
		};


	};