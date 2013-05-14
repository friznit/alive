_logic = _this select ((count _this)-1);
waituntil {sleep 10;(not (isNil {_logic getvariable "HAC_HQ_Support"}) and ((count (_logic getvariable "HAC_HQ_Support")) > 0) and (_logic getvariable "HAC_HQ_Cyclecount") > 2)};

if (isNil ("RHQ_Med")) then {_logic setvariable ["RHQ_Med", []]};
if (isNil ("HAC_HQ_SMed")) then {_logic setvariable ["HAC_HQ_SMed", true]};
if (isNil ("HAC_HQ_ExMedic")) then {_logic setvariable ["HAC_HQ_ExMedic", []]};
if (isNil ("HAC_HQ_MedPoints")) then {_logic setvariable ["HAC_HQ_MedPoints", []]};

_med = (_logic getvariable "RHQ_Med") + ["LandRover_Ambulance_ACR","M113Ambul_UN_EP1","M113Ambul_TK_EP1","UH60M_MEV_EP1","M1133_MEV_EP1","HMMWV_Ambulance_CZ_DES_EP1","HMMWV_Ambulance_DES_EP1","Mi17_medevac_Ins","BMP2_Ambul_INS","GAZ_Vodnik_MedEvac","Mi17_medevac_RU","Mi17_medevac_CDF","BMP2_Ambul_CDF","HMMWV_Ambulance","MH60S"] - (_logic getvariable "RHQs_Med");
_noenemy = true;

while {not (isNull (_logic getvariable "HAC_HQ"))} do
	{
	waituntil {sleep 5;(_logic getvariable "HAC_HQ_SMed")};
	sleep 25;
	
	_logic setvariable ["HAC_HQ_MedSupport", []];
	_logic setvariable ["HAC_HQ_MedSupportG", []];
	_logic setvariable ["HAC_HQ_MedSupportAirG", []];

		{
		if not (_x in (_logic getvariable "HAC_HQ_MedSupport")) then			{
			if ((typeOf (assignedvehicle _x)) in _med) then 
				{
				_logic setvariable ["HAC_HQ_MedSupport", (_logic getvariable "HAC_HQ_MedSupport") + [_x]];
				if not ((group _x) in (_logic getvariable "HAC_HQ_MedSupportG")) then 
					{
					_logic setvariable ["HAC_HQ_MedSupportG", (_logic getvariable "HAC_HQ_MedSupportG") + [_x]];
					};

				if not ((group _x) in ((_logic getvariable "HAC_HQ_MedSupportAirG") + (_logic getvariable "HAC_HQ_SpecForG") + (_logic getvariable "HAC_HQ_CargoOnly"))) then
					{
					if (_x in (_logic getvariable "HAC_HQ_AirG")) then 
						{
						_logic setvariable ["HAC_HQ_AirG", (_logic getvariable "HAC_HQ_AirG") + [group _x]];
						}
				}
			}
		}
    } foreach (_logic getvariable "HAC_HQ_Support");

	_airMedAv = [];
	_landMedAv = [];

		{
		_busy = _x getVariable ("Busy" + (str _x));
		if (isNil "_busy") then {_busy = false};
		if not (_busy) then {_airMedAv set [(count _airMedAv),_x]}
		}
	foreach (_logic getvariable "HAC_HQ_MedSupportAirG");

		{
		_busy = _x getVariable ("Busy" + (str _x));
		if (isNil "_busy") then {_busy = false};
		if not (_busy) then {_landMedAv set [(count _landMedAv),_x]}
		}
	foreach ((_logic getvariable "HAC_HQ_MedSupportG") - (_logic getvariable "HAC_HQ_MedSupportAirG"));

	_wounded = [];
	_Swounded = [];
	_Lwounded = [];

		{
			{
			if ((vehicle _x) == _x) then
				{
				if ((damage _x) > 0.5) then
					{
					if ((damage _x) < 0.9) then 
						{
						_wounded set [(count _wounded),_x]
						};

					if (alive _x) then
						{
						if (((damage _x) > 0.75) or not (canStand _x)) then
							{
							_Swounded set [(count _Swounded),_x]
							}
						}
					}
				}
			}
		foreach (units _x)
		}
	foreach ((_logic getvariable "HAC_HQ_Friends") - (_logic getvariable "HAC_HQ_ExMedic"));

	_Lwounded = _wounded - _Swounded;
	_logic setvariable ["HAC_HQ_Wounded", _wounded];
	_ambulances = [];
	if (isNil ("HAC_HQ_SupportedG")) then {_logic setvariable ["HAC_HQ_SupportedG", []]};

		{
		_amb = assignedVehicle (leader _x);

		if not (isNull _amb) then
			{
			if (canMove _amb) then
				{
				if ((fuel _amb) > 0.2) then
					{
					_unitvar = str (_x);
					_busy = false;
					_busy = _x getvariable ("Busy" + _unitvar);
					if (isNil ("_busy")) then {_busy = false};

					if not (_busy) then
						{
						if not (_x in _ambulances) then 
							{
							_ambulances set [(count _ambulances),_x]
							}
						}
					}
				}
			}
		}
	foreach (_logic getvariable "HAC_HQ_MedSupportG");

	_ambulances2 = +_ambulances;
	_SWunits = +_Swounded;
	_a = 0;
	for [{_a = 500},{_a <= 20000},{_a = _a + 500}] do
		{
			{
			_ambulance = assignedvehicle (leader _x);
			if (isNil ("_busy")) then {_busy = false};

			for [{_b = 0},{_b < (count _Swounded)},{_b = _b + 1}] do 
				{
				_SWunit = _Swounded select _b;

					{
					if ((_SWunit distance (assignedvehicle (leader _x))) < 125) exitwith {if not ((group _SWunit) in (_logic getvariable "HAC_HQ_SupportedG")) then {_logic setvariable ["HAC_HQ_SupportedG",(_logic getvariable "HAC_HQ_SupportedG") + [group _SWunit]]}};
					}
				foreach (_logic getvariable "HAC_HQ_MedSupportG");

					{
					if ((_SWunit distance _x) < 125) exitwith {if not ((group _SWunit) in (_logic getvariable "HAC_HQ_SupportedG")) then {_logic setvariable ["HAC_HQ_SupportedG",(_logic getvariable "HAC_HQ_SupportedG") + [group _SWunit]]}};
					}
				foreach (_logic getvariable "HAC_HQ_MedPoints");

				_noenemy = true;
				_halfway = [(((position _ambulance) select 0) + ((position _SWunit) select 0))/2,(((position _ambulance) select 1) + ((position _SWunit) select 1))/2];
				_distT = 500/(0.75 + ((_logic getvariable "HAC_HQ_Recklessness")/2));
				_eClose1 = [_SWunit,(_logic getvariable "HAC_HQ_KnEnemiesG"),_distT,_logic] call ALiVE_fnc_HAC_CloseEnemy;
				_eClose2 = [_halfway,(_logic getvariable "HAC_HQ_KnEnemiesG"),_distT,_logic] call ALiVE_fnc_HAC_CloseEnemy;				
				if ((_eClose1) or (_eClose2)) then {_noenemy = false};

				if not ((group _SWunit) in (_logic getvariable "HAC_HQ_SupportedG")) then
					{
					_UL = leader (group _SWunit);
					if not (isPlayer _UL) then {if ((random 100) < (_logic getvariable "HAC_xHQ_AIChatDensity")) then {[_UL,(_logic getvariable "HAC_xHQ_AIC_MedReq"),"MedReq",_logic] call ALiVE_fnc_HAC_AIChatter}};
					};				

				if (not ((group _SWunit) in (_logic getvariable "HAC_HQ_SupportedG")) and ((_SWunit distance _ambulance) <= _a) and (_noenemy) and (_x in _ambulances)) then 
					{
					if ((_a > 1500) and ((count _airMedAv) > 0) and not (_x in _airMedAv)) exitwith {};
					if ((_a <= 1500) and ((count _landMedAv) > 0) and not (_x in _landMedAv)) exitwith {};
					if ((random 100) < (_logic getvariable "HAC_xHQ_AIChatDensity")) then {[_logic,(_logic getvariable "HAC_xHQ_AIC_SuppAss"),"SuppAss",_logic] call ALiVE_fnc_HAC_AIChatter};
					if (_x in _airMedAv) then {_airMedAv = _airMedAv - [_x]} else {_landMedAv = _landMedAv - [_x]};
					_ambulances = _ambulances - [_x];
					_SWunits = _SWunits - [_SWunit];
					_logic setvariable ["HAC_HQ_SupportedG",(_logic getvariable "HAC_HQ_SupportedG") + [group _SWunit]];
					[_ambulance,_SWunit,_wounded,_logic] spawn A_GoMedSupp; 
					}
				else
					{
					if (_a == 20000) then 
						{
						if not ((group _SWunit) in (_logic getvariable "HAC_HQ_SupportedG")) then {if ((random 100) < (_logic getvariable "HAC_xHQ_AIChatDensity")) then {[_logic,(_logic getvariable "HAC_xHQ_AIC_SuppDen"),"SuppDen",_logic] call ALiVE_fnc_HAC_AIChatter}};
						_SWunits = _SWunits - [_SWunit]
						};
					};
				
				if (((count _ambulances) == 0) or ((count _SWunits) == 0)) exitwith {};
				};
			if (((count _ambulances) == 0) or ((count _SWunits) == 0)) exitwith {};
			sleep 0.1;
			}
		foreach _ambulances2;
		};

	_Wunits = +_wounded;

	for [{_a = 500},{_a < 10000},{_a = _a + 500}] do
		{
			{
			_ambulance = assignedvehicle (leader _x);
			for [{_b = 0},{_b < (count _wounded)},{_b = _b + 1}] do 
				{
				_Wunit = _wounded select _b;

					{
					if ((_Wunit distance (assignedvehicle (leader _x))) < 250) exitwith {if not ((group _Wunit) in (_logic getvariable "HAC_HQ_SupportedG")) then {_logic setvariable ["HAC_HQ_SupportedG",(_logic getvariable "HAC_HQ_SupportedG") + [group _Wunit]]}};
					}
				foreach (_logic getvariable "HAC_HQ_MedSupportG");

					{
					if ((_Wunit distance _x) < 250) exitwith {if not ((group _Wunit) in (_logic getvariable "HAC_HQ_SupportedG")) then {_logic setvariable ["HAC_HQ_SupportedG",(_logic getvariable "HAC_HQ_SupportedG") + [group _Wunit]]}};
					}
				foreach (_logic getvariable "HAC_HQ_MedPoints");

				_noenemy = true;
				_halfway = [(((position _ambulance) select 0) + ((position _Wunit) select 0))/2,(((position _ambulance) select 1) + ((position _Wunit) select 1))/2];
				_distT = 600/(0.75 + ((_logic getvariable "HAC_HQ_Recklessness")/2));
				_eClose1 = [_Wunit,(_logic getvariable "HAC_HQ_KnEnemiesG"),_distT,_logic] call ALiVE_fnc_HAC_CloseEnemy;
				_eClose2 = [_halfway,(_logic getvariable "HAC_HQ_KnEnemiesG"),_distT,_logic] call ALiVE_fnc_HAC_CloseEnemy;				
				if ((_eClose1) or (_eClose2)) then {_noenemy = false};

				if not ((group _Wunit) in (_logic getvariable "HAC_HQ_SupportedG")) then
					{
					_UL = leader (group _Wunit);
					if not (isPlayer _UL) then {if ((random 100) < (_logic getvariable "HAC_xHQ_AIChatDensity")) then {[_UL,(_logic getvariable "HAC_xHQ_AIC_MedReq"),"MedReq",_logic] call ALiVE_fnc_HAC_AIChatter}};	
					};
				
				if (not ((group _Wunit) in (_logic getvariable "HAC_HQ_SupportedG")) and ((_Wunit distance _ambulance) <= _a) and (_noenemy) and (_x in _ambulances)) then 
					{
					if ((_a > 2500) and ((count _airMedAv) > 0) and not (_x in _airMedAv)) exitwith {};
					if ((_a <= 2500) and ((count _landMedAv) > 0) and not (_x in _landMedAv)) exitwith {};
					if ((random 100) < (_logic getvariable "HAC_xHQ_AIChatDensity")) then {[_logic,(_logic getvariable "HAC_xHQ_AIC_SuppAss"),"SuppAss",_logic] call ALiVE_fnc_HAC_AIChatter};
					if (_x in _airMedAv) then {_airMedAv = _airMedAv - [_x]} else {_landMedAv = _landMedAv - [_x]};
					_ambulances = _ambulances - [_x];
					_Wunits = _Wunits - [_Wunit];
					_logic setvariable ["HAC_HQ_SupportedG",(_logic getvariable "HAC_HQ_SupportedG") + [group _Wunit]];
					[_ambulance,_Wunit,_wounded,_logic] spawn A_GoMedSupp; 
					}
				else
					{
					if (_a == 10000) then 
						{
						if not ((group _Wunit) in (_logic getvariable "HAC_HQ_SupportedG")) then {if ((random 100) < (_logic getvariable "HAC_xHQ_AIChatDensity")) then {[_logic,(_logic getvariable "HAC_xHQ_AIC_SuppDen"),"SuppDen",_logic] call ALiVE_fnc_HAC_AIChatter}};
						_Wunits = _Wunits - [_Wunit]
						};
					};
				
				if (((count _ambulances) == 0) or ((count _Wunits) == 0)) exitwith {};
				};
			if (((count _ambulances) == 0) or ((count _Wunits) == 0)) exitwith {};
			sleep 0.1;
			}
		foreach _ambulances2;
		};


	};