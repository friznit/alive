_logic = _this select ((count _this)-1);
waituntil {sleep 10;(not (isNil {_logic getvariable "HAC_HQ_Support"}) and ((count (_logic getvariable "HAC_HQ_Support")) > 0) and ((_logic getvariable "HAC_HQ_Cyclecount") > 2))};

if (isNil {_logic getvariable "RHQ_Rep"}) then {_logic setvariable ["RHQ_Rep", []]};
if (isNil {_logic getvariable "HAC_HQ_SRep"}) then {_logic setvariable ["HAC_HQ_SRep", true]};
if (isNil {_logic getvariable "HAC_HQ_ExRepair"}) then {_logic setvariable ["HAC_HQ_ExRepair", []]};
if (isNil {_logic getvariable "HAC_HQ_RepPoints"}) then {_logic setvariable ["HAC_HQ_RepPoints", []]};

_rep = (_logic getvariable "RHQ_Rep") + ["T810Repair_Des_ACR","T810Repair_ACR","UralRepair_TK_EP1","MtvrRepair_DES_EP1","V3S_Repair_TK_GUE_EP1","UralRepair_INS","KamazRepair","UralRepair_CDF","MtvrRepair"] - (_logic getvariable "RHQs_Rep");
_noenemy = true;
sleep 5;
while {not (isNull (_logic getvariable "HAC_HQ"))} do
	{
	waituntil {sleep 5;(_logic getvariable "HAC_HQ_SRep")};
	sleep 25;
	
	_logic setvariable ["HAC_HQ_RepSupport", []];
	_logic setvariable ["HAC_HQ_RepSupportG", []];
		{
		if not (_x in (_logic getvariable "HAC_HQ_RepSupport")) then
			{
			if ((typeOf (assignedvehicle _x)) in _rep) then 
				{
				_logic setvariable ["HAC_HQ_RepSupport",(_logic getvariable "HAC_HQ_RepSupport") + [_x]];
				if not ((group _x) in ((_logic getvariable "HAC_HQ_RepSupportG") + (_logic getvariable "HAC_HQ_SpecForG") + (_logic getvariable "HAC_HQ_CargoOnly"))) then 
					{
					_logic setvariable ["HAC_HQ_RepSupportG",(_logic getvariable "HAC_HQ_RepSupportG") + [group _x]];
					}
				}
			}
		}
	foreach (_logic getvariable "HAC_HQ_Support");

	_damaged = [];
	_Sdamaged = [];
	_Ldamaged = [];

		{
			{
			_av = assignedvehicle _x;
			if not (isNull _av) then
				{
				if ((damage _av) > 0.1) then
					{
					if ((damage _av) < 0.9) then
						{
						if (((getposATL _x) select 2) < 5) then 
							{
							_damaged set [(count _damaged),_av];
							if (((damage _av) > 0.5) or not (canMove _av)) then
								{
								_Sdamaged set [(count _Sdamaged),_av]
								}
							}
						}
					}
				}
			}
		foreach (units _x)
		}
	foreach ((_logic getvariable "HAC_HQ_Friends") - (_logic getvariable "HAC_HQ_ExRepair"));

	_Ldamaged = _damaged - _Sdamaged;
	_logic setvariable ["HAC_HQ_damaged",_damaged];
	_rtrs = [];
	if (isNil {_logic getvariable "HAC_HQ_RSupportedG"}) then {_logic setvariable ["HAC_HQ_RSupportedG", []]};

		{
		_rt = assignedVehicle (leader _x);

		if not (isNull _rt) then
			{
			if (canMove _rt) then
				{
				if ((fuel _rt) > 0.2) then
					{
					_unitvar = str (_x);
					_busy = false;
					_busy = _x getvariable ("Busy" + _unitvar);
					if (isNil ("_busy")) then {_busy = false};

					if not (_busy) then
						{
						if not (_x in _rtrs) then 
							{
							_rtrs set [(count _rtrs),_x]
							}
						}
					}
				}
			}
		}
	foreach (_logic getvariable "HAC_HQ_RepSupportG");

	_rtrs2 = +_rtrs;
	_SDunits = +_Sdamaged;
	_a = 0;
	for [{_a = 500},{_a <= 20000},{_a = _a + 500}] do
		{
			{
			_rtr = assignedvehicle (leader _x);
			if (isNil ("_busy")) then {_busy = false};

			for [{_b = 0},{_b < (count _Sdamaged)},{_b = _b + 1}] do 
				{
				_SDunit = _Sdamaged select _b;

					{
					if ((_SDunit distance (assignedvehicle (leader _x))) < 300) exitwith {if not ((group _SDunit) in (_logic getvariable "HAC_HQ_RSupportedG")) then {_logic setvariable ["HAC_HQ_RSupportedG",(_logic getvariable "HAC_HQ_RSupportedG") + [group _SDunit]]}};
					}
				foreach (_logic getvariable "HAC_HQ_RepSupportG");

					{
					if ((_SDunit distance _x) < 300) exitwith {if not ((group _SDunit) in (_logic getvariable "HAC_HQ_RSupportedG")) then {_logic setvariable ["HAC_HQ_RSupportedG",(_logic getvariable "HAC_HQ_RSupportedG") + [group _SDunit]]}};
					}
				foreach (_logic getvariable "HAC_HQ_RepPoints");

				_noenemy = true;
				_halfway = [(((position _rtr) select 0) + ((position _SDunit) select 0))/2,(((position _rtr) select 1) + ((position _SDunit) select 1))/2];
				_distT = 500/(0.75 + ((_logic getvariable "HAC_HQ_Recklessness")/2));
				_eClose1 = [_SDunit,(_logic getvariable "HAC_HQ_KnEnemiesG"),_distT,_logic] call ALiVE_fnc_HAC_CloseEnemy;
				_eClose2 = [_halfway,(_logic getvariable "HAC_HQ_KnEnemiesG"),_distT,_logic] call ALiVE_fnc_HAC_CloseEnemy;				
				if ((_eClose1) or (_eClose2)) then {_noenemy = false};

				if not ((group _SDunit) in (_logic getvariable "HAC_HQ_RSupportedG")) then
					{
					_UL = leader (group (assignedDriver _SDunit));
					if not (isPlayer _UL) then {if ((random 100) < (_logic getvariable "HAC_xHQ_AIChatDensity")) then {[_UL,(_logic getvariable "HAC_xHQ_AIC_SuppReq"),"SuppReq",_logic] call ALiVE_fnc_HAC_AIChatter}};
					};
				
				if (not ((group _SDunit) in (_logic getvariable "HAC_HQ_RSupportedG")) and ((_SDunit distance _rtr) <= _a) and (_noenemy) and (_x in _rtrs)) then 
					{
					if ((random 100) < (_logic getvariable "HAC_xHQ_AIChatDensity")) then {[_logic,(_logic getvariable "HAC_xHQ_AIC_SuppAss"),"SuppAss",_logic] call ALiVE_fnc_HAC_AIChatter};
					_rtrs = _rtrs - [_x];
					_SDunits = _SDunits - [_SDunit];
					_logic setvariable ["HAC_HQ_RSupportedG",(_logic getvariable "HAC_HQ_RSupportedG") + [group _SDunit]];
					[_rtr,_SDunit,_damaged,_logic] spawn A_GoRepSupp; 
					}
				else
					{
					if (_a == 20000) then 
						{
						if not ((group _SDunit) in (_logic getvariable "HAC_HQ_RSupportedG")) then {if ((random 100) < (_logic getvariable "HAC_xHQ_AIChatDensity")) then {[_logic,(_logic getvariable "HAC_xHQ_AIC_SuppDen"),"SuppDen",_logic] call ALiVE_fnc_HAC_AIChatter}};
						_SDunits = _SDunits - [_SDunit]
						};
					};
				
				if (((count _rtrs) == 0) or ((count _SDunits) == 0)) exitwith {};
				};
			if (((count _rtrs) == 0) or ((count _SDunits) == 0)) exitwith {};
			sleep 0.1;
			}
		foreach _rtrs2;
		};

	_Dunits = +_damaged;

	for [{_a = 500},{_a < 10000},{_a = _a + 500}] do
		{
			{
			_rtr = assignedvehicle (leader _x);
			for [{_b = 0},{_b < (count _damaged)},{_b = _b + 1}] do 
				{
				_Dunit = _damaged select _b;

					{
					if ((_Dunit distance (assignedvehicle (leader _x))) < 400) exitwith {if not ((group _Dunit) in (_logic getvariable "HAC_HQ_RSupportedG")) then {_logic setvariable ["HAC_HQ_RSupportedG",(_logic getvariable "HAC_HQ_RSupportedG") + [group _Dunit]]}};
					}
				foreach (_logic getvariable "HAC_HQ_RepSupportG");

					{
					if ((_Dunit distance _x) < 400) exitwith {if not ((group _Dunit) in (_logic getvariable "HAC_HQ_RSupportedG")) then {_logic setvariable ["HAC_HQ_RSupportedG",(_logic getvariable "HAC_HQ_RSupportedG") + [group _Dunit]]}};
					}
				foreach (_logic getvariable "HAC_HQ_RepPoints");

				_noenemy = true;
				_halfway = [(((position _rtr) select 0) + ((position _Dunit) select 0))/2,(((position _rtr) select 1) + ((position _Dunit) select 1))/2];
				_distT = 600/(0.75 + ((_logic getvariable "HAC_HQ_Recklessness")/2));
				_eClose1 = [_Dunit,(_logic getvariable "HAC_HQ_KnEnemiesG"),_distT,_logic] call ALiVE_fnc_HAC_CloseEnemy;
				_eClose2 = [_halfway,(_logic getvariable "HAC_HQ_KnEnemiesG"),_distT,_logic] call ALiVE_fnc_HAC_CloseEnemy;				
				if ((_eClose1) or (_eClose2)) then {_noenemy = false};

				if not ((group _Dunit) in (_logic getvariable "HAC_HQ_RSupportedG")) then
					{
					_UL = leader (group (assignedDriver _Dunit));
					if not (isPlayer _UL) then {if ((random 100) < (_logic getvariable "HAC_xHQ_AIChatDensity")) then {[_UL,(_logic getvariable "HAC_xHQ_AIC_SuppReq"),"SuppReq",_logic] call ALiVE_fnc_HAC_AIChatter}};
					};
							
				if (not ((group _Dunit) in (_logic getvariable "HAC_HQ_RSupportedG")) and ((_Dunit distance _rtr) <= _a) and (_noenemy) and (_x in _rtrs)) then 
					{
					if ((random 100) < (_logic getvariable "HAC_xHQ_AIChatDensity")) then {[_logic,(_logic getvariable "HAC_xHQ_AIC_SuppAss"),"SuppAss",_logic] call ALiVE_fnc_HAC_AIChatter};
					_rtrs = _rtrs - [_x];
					_Dunits = _Dunits - [_Dunit];
					_logic setvariable ["HAC_HQ_RSupportedG",(_logic getvariable "HAC_HQ_RSupportedG") + [group _Dunit]];
					[_rtr,_Dunit,_damaged,_logic] spawn A_GoRepSupp; 
					}
				else
					{
					if (_a == 10000) then 
						{
						if not ((group _Dunit) in (_logic getvariable "HAC_HQ_RSupportedG")) then {if ((random 100) < (_logic getvariable "HAC_xHQ_AIChatDensity")) then {[_logic,(_logic getvariable "HAC_xHQ_AIC_SuppDen"),"SuppDen",_logic] call ALiVE_fnc_HAC_AIChatter}};
						_Dunits = _Dunits - [_Dunit]
						};
					};
				
				if (((count _rtrs) == 0) or ((count _Dunits) == 0)) exitwith {};
				};
			if (((count _rtrs) == 0) or ((count _Dunits) == 0)) exitwith {};
			sleep 0.1;
			}
		foreach _rtrs2;
		};


	};