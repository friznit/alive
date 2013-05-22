_logic = _this select ((count _this)-1);
if (isNil {_logic getvariable "HAC_HQ_Garrison"}) then {_logic setvariable ["HAC_HQ_Garrison",[]]};
waituntil {sleep 1; not (isNil {_logic getvariable "HAC_HQ_CargoAirEx"})};

_recArr = _this select 0;

_posTaken = [];

while {not (isNull (_logic getvariable "HAC_HQ"))} do
	{
	for [{_a = 0},{_a < (count (_logic getvariable "HAC_HQ_Garrison"))},{_a = _a + 1}] do
		{
		_unitG = (_logic getvariable "HAC_HQ_Garrison") select _a;
		_garrisoned = _unitG getVariable ("Garrisoned" + (str _unitG));
		if (isNil "_garrisoned") then {_garrisoned = false};
		
		if not (_garrisoned) then
			{
			[_unitG,_logic] call ALiVE_fnc_HAC_WPdel;

			_unitG setVariable ["Garrisoned" + (str _unitG),true];

			_pos = getPosATL (vehicle (leader _unitG));
			_units = [];

			_UL = leader _unitG;
			_AV = assignedVehicle _UL;

			_logic setvariable ["HAC_HQ_VCDone", false];
			if (isPlayer _UL) then {[_UL,_logic,_logic] spawn ALiVE_fnc_HAC_VoiceComm;sleep 3;waituntil {sleep 0.1;(_logic getvariable "HAC_HQ_VCDone")}} else {if ((random 100) < (_logic getvariable "HAC_xHQ_AIChatDensity")) then {[_UL,(_logic getvariable "HAC_xHQ_AIC_OrdConf"),"OrdConf",_logic] call ALiVE_fnc_HAC_AIChatter}};

			if (((_logic getvariable "HAC_HQ_Debug")) or (isPlayer (leader _unitG))) then 
				{
				_i = [_pos,_unitG,"markGarrison","ColorBrown","ICON","mil_dot"," | Garr"," - GARRISON",[0.25,0.25],_logic] call ALiVE_fnc_HAC_Mark;
				};

			if (((_logic getvariable "HAC_HQ_GarrVehAb")) and not (isPlayer (leader _unitG))) then
				{
				//{unassignVehicle _x} foreach (units _unitG);
				(units _unitG) orderGetIn false;
				(units _unitG) allowGetin false;
				sleep 5
				};

			if (not (isNull _AV) and not ((_logic getvariable "HAC_HQ_GarrVehAb"))) exitWith
				{
				_frm = "DIAMOND";
				if (isPlayer (leader _unitG)) then {_frm = formation _unitG};
				_wp = [_logic,_unitG,position (leader _unitG),"SENTRY","AWARE","YELLOW","NORMAL",["true","deletewaypoint [(group this), 0];"],false,0,[0,0,0],_frm] call ALiVE_fnc_HAC_WPadd
				};

			_units = (units _unitG) - [leader _unitG]; 

			if not (isPlayer _UL) then
				{
				_list = _pos nearObjects ["StaticWeapon", 200];
				_staticWeapons = [];

					{
					if ((_x emptyPositions "gunner") > 0) then 
						{
						_staticWeapons = _staticWeapons + [_x];	
						};
					} 
				forEach _list;

					{
					if ((count _units) > 0) then 
						{
						_unit = (_units select ((count _units) - 1));

						if (((random 1) > 0.1) and not ((typeOf _unit) in _recArr)) then 
							{
							_unit assignAsGunner _x;
							[_unit] orderGetIn true;
							
							_units resize ((count _units) - 1)
							}
						}
					} 
				forEach _staticWeapons;

				_Bldngs = _pos nearObjects ["House",200];
				_posAll = [];
				_posAll0 = [];

					{
					_Bldg = _x;
					if ((_Bldg distance _UL) > 200) then {_Bldg = ObjNull};

					if not (isNull _Bldg) then
						{
						_posAct = _Bldg buildingpos 0;
						_j = 0;	
						while {not ((str _posAct) in ["[0,0,0]"])} do
							{
							_tkn = false;

								{
								if (((_x select 0) + (_x select 1)) == ((_posAct select 0) + (_posAct select 1))) exitWith {_tkn = true}
								}
							foreach _posTaken;

							if not (_tkn) then
								{
								_tkn = false;

									{
									if (((_x select 0) + (_x select 1)) == ((_posAct select 0) + (_posAct select 1))) exitWith {_tkn = true}
									}
								foreach _posAll;

								if not (_tkn) then 
									{
									_posAll set [(count _posAll),_posAct]
									}
								};
								
							_j = _j + 1;
							_posAct = _Bldg buildingpos _j;
							}
						}
					}
				foreach _Bldngs;

				_posAll0 = +_posAll;

					{
					if not ((count _posAll) == 0) then
						{
						_posS = _posAll select floor (random (count _posAll));
						_ct = 0;

						while {((_posS in _posTaken) and (_ct < 20))} do
							{
							_posS = _posAll select floor (random (count _posAll));
							_ct = _ct + 1
							};

						if not ((_posS distance _pos) > 250) then
							{
							if ((random 100) > 20) then
								{
								_tkn = false;

									{
									if (((_x select 0) + (_x select 1)) == ((_posS select 0) + (_posS select 1))) exitWith {_tkn = true}
									}
								foreach _posTaken;

								if not (_tkn) then 
									{
									_posAll = _posAll - [_posS];
									_posTaken set [(count _posTaken),_posS];
									[_x,_posS,_posTaken,_logic] spawn ALiVE_fnc_HAC_GarrS;
									_units = _units - [_x]
									}
								}
							}
						}
					}
				foreach _units;

				_patrolPos = [];

					{
					_posA = _x;
					_tooClose = false;
					
						{
						_dst = _posA distance _x;
						if ((_dst > 0.1) and (_dst < 16)) exitWith
							{
							_tooClose = true
							}
						}
					foreach _patrolPos;
					
					if not (_tooClose) then 
						{
						_patrolPos set [(count _patrolPos),_posA];
						}
					}
				foreach _posAll0;
				
				if ((count _patrolPos) > 1) then 
					{
					[_unitG,_patrolPos,_logic] spawn ALiVE_fnc_HAC_GarrP
					}
				else
					{
					_frm = "DIAMOND";
					if (isPlayer (leader _unitG)) then {_frm = formation _unitG};
					_wp = [_logic,_unitG,position (leader _unitG),"SENTRY","AWARE","YELLOW","NORMAL",["true","deletewaypoint [(group this), 0];"],false,0,[0,0,0],_frm] call ALiVE_fnc_HAC_WPadd;
					}
				}
			}
		};
	sleep 60
	}