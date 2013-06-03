_logic = _this select ((count _this)-1);
_unitG = _this select 0;
_GL = leader _unitG;

_CP = nearestObjects [_GL, ["Car","Tank","Motorcycle","Air","Ship"], (_logic getvariable "HAC_HQ_CargoFind")];
_NG = count (units _unitG);
_AV = ObjNull;
_ChosenOne = ObjNull;
_Free = true;
_emptyV = true;

	{
	if not (_x getVariable ["Hired",false]) then
		{
		_ESpace = (_x emptyPositions "Cargo") + (_x emptyPositions "Driver") + (_x emptyPositions "Gunner") + (_x emptyPositions "Commander");
		if ((_ESpace >= _NG) and ((count (assignedCargo _x)) == 0) and ((count (crew _x)) == 0) and ((fuel _x) >= 0.2) and (damage _x <= 0.8) and (canMove _x)) exitwith 
			{
			_ChosenOne = _x;
			_x setVariable ["Hired",true]
			}
		}
	}
foreach _CP;

_actV = ObjNull;
_ELast = 0;
_mpl = 1;

if (isNull _ChosenOne) then
	{
	_emptyV = false;

		{
		_ESpace = 0;
			{
			_unitvar = str (group _x);
			_busy = false;
			_busy = (group _x) getvariable ("Busy" + _unitvar);
			if (isNil ("_busy")) then {_busy = false};
			if (_actV == (assignedvehicle _x)) then 
				{
				_Elast = 0;
				}
			else
				{
				_Elast = _ESpace;
				};

			_ESpace = _ELast + ((assignedvehicle _x) emptyPositions "Cargo") + ((assignedvehicle _x) emptyPositions "Gunner") + ((assignedvehicle _x) emptyPositions "Commander");
			_actV = (assignedvehicle _x);
			if ((group _x) in (_logic getvariable "HAC_HQ_AirG")) then {_mpl = 3} else {_mpl = 1};
			_noenemy = true;
			_halfway = [(((position _actV) select 0) + ((position _GL) select 0))/2,(((position _actV) select 1) + ((position _GL) select 1))/2];
			_hired = (assignedvehicle _x) getVariable "Hired";
			if (isNil ("_hired")) then {_hired = false};
			if (((((_logic findNearestEnemy _GL) distance _GL) <= (500*_mpl)) or (((_logic findNearestEnemy _halfway) distance _halfway) <= (500*_mpl))) and ((random 100) > (20*(0.5 + (2*HAC_HQ_Recklessness))))) then {_noenemy = false};
			if ((_ESpace >= _NG) and 
				((count (assignedCargo (assignedvehicle _x))) == 0) and not 
					((_busy) or (_hired)) and not
                ((_x in (_logic getvariable "HAC_HQ_NCrewInfG")) and (count (units _x) > 1)) and
							(((vehicle (leader _x)) distance (vehicle _GL)) < (1500*_mpl)) and 
								((fuel (assignedvehicle _x)) >= 0.2) and 
									(damage (assignedvehicle _x) <= 0.8) and 
										(canMove (assignedvehicle _x)) and
											(_noenemy) and
												(not ((group _x) in (_logic getvariable "HAC_HQ_AirG")) or (((count ((_logic getvariable "HAC_HQ_AAthreat") + (_logic getvariable "HAC_HQ_Airthreat"))) == 0) or (random 100 > (85/(0.5 + (2*(_logic getvariable "HAC_HQ_Recklessness")))))))) exitwith 
				{
				(group _x) setVariable [("Busy" + _unitvar), true];(group _x) setVariable [("CargoM" + _unitvar), true];_ChosenOne = (assignedvehicle _x)
				}
			}
		foreach (units _x);
		if not (isNull _ChosenOne) exitwith {};
		}
	foreach ((_logic getvariable "HAC_HQ_CargoG") - ((_logic getvariable "HAC_HQ_NoCargo") + (_logic getvariable "HAC_HQ_SpecForG")));
	};

_unitvar = str _unitG;
if (isNull _ChosenOne) exitwith {_unitG setVariable [("CC" + _unitvar), true]};
_GD = (group (assigneddriver _ChosenOne));
_unitvar2 = str _GD;
_Vpos = _GD getvariable ("START" + _unitvar2); 

_lz = objNull;
_alive = true;

if not (_emptyV) then
	{
	if (isNil ("_Vpos")) then {_GD setVariable [("START" + _unitvar2),(position _ChosenOne)]};

	[_GD,_logic] call ALiVE_fnc_HAC_WPdel;

	_UL = leader _GD;
	_logic setvariable ["HAC_HQ_VCDone",false];
	if (isPlayer _UL) then {[_UL,_logic,_logic] spawn ALiVE_fnc_HAC_VoiceComm;sleep 3;waituntil {sleep 0.1;(_logic getvariable "HAC_HQ_VCDone")}} else {if ((random 100) < (_logic getvariable "HAC_xHQ_AIChatDensity")) then {[_UL,(_logic getvariable "HAC_xHQ_AIC_OrdConf"),"OrdConf",_logic] call ALiVE_fnc_HAC_AIChatter}};

	_ChosenOne disableAI "TARGET";_ChosenOne disableAI "AUTOTARGET";
	_Lpos = [((position _GL) select 0) + (random 100) - 50,((position _GL) select 1) + (random 100) - 50];

	_task = [(leader _GD),["Take a group waiting for transport at designated position.", "Load", ""],_Lpos,_logic] call ALiVE_fnc_HAC_AddTask;

	_task2 = [(leader _unitG),["Wait and get into vehicle.", "GET IN", ""],(position (leader _unitG)),_logic] call ALiVE_fnc_HAC_AddTask;

	_wp = [_logic,_GD,_Lpos,"MOVE","CARELESS","YELLOW","FULL",["true","deletewaypoint [(group this), 0]"]] call ALiVE_fnc_HAC_WPadd;

	if (_ChosenOne isKindOf "Air") then 
		{
		if ((_logic getvariable "HAC_HQ_LZ")) then 
			{
			_lz = [_Lpos,_logic] call ALiVE_fnc_HAC_LZ;
            _i01 = [_Lpos,group _ChosenOne,"markLZ",(_logic getvariable ["HAC_HQ_Color","ColorRed"]),"ICON","mil_dot","LZ","",_logic] call ALiVE_fnc_HAC_Mark;
			_ChosenOne setVariable ["TempLZ",_lz]
			}
		};

	_alive = true;
	_timer = -5;
	waituntil 
		{
		_DAV = assigneddriver _ChosenOne;
		_GD = group _DAV;
		if (isNull _GD) then {_alive = false};
		if not (alive  (leader _GD)) then {_alive = false};
		if ((speed _ChosenOne) < 0.5) then {_timer = _timer + 5};
		sleep 6;

		((((count (waypoints _GD)) < 1)) or (_timer > 120) or not (_alive));
		};

	if ((isPlayer (leader _GD)) and not (isMultiplayer)) then {(leader _GD) removeSimpleTask _task};
	if ((_timer > 120) and ((_ChosenOne distance (vehicle (leader _unitG))) > 200)) then {_alive = false};
	if not (_alive) exitwith {_unitG leaveVehicle _ChosenOne;_unitG setVariable [("CC" + _unitvar), true]};

	if ((_ChosenOne emptyPositions "Cargo") > 0) then 
		{
			{
			_x assignAsCargo _ChosenOne
			}
		foreach (units _unitG)
		};

	_ct = 0;
	waituntil 
		{
		sleep 1;
		_ct = _ct + 1;

		_assigned = true;

			{
			if (isNull (assignedVehicle _x)) exitWith {_assigned = false}
			}
		foreach (units _unitG);

		((_assigned) or (_ct > 300))
		};

	if (_ct > 240) then {_alive = false;_unitG leaveVehicle _ChosenOne;_unitG setVariable [("CC" + _unitvar), true]};
	};

if not (_alive) exitWith {};

_asCargo = units _unitG;

if ((_emptyV) or (isNull (assignedDriver _ChosenOne))) then {_GL assignAsDriver _ChosenOne;_asCargo = _asCargo - [_GL]};
if (((_ChosenOne emptyPositions "Gunner") > 0) and (count (units _unitG) > 1)) then {((units _unitG) select 1) assignAsGunner _ChosenOne;_asCargo = _asCargo - [(units _unitG) select 1]};

if (_emptyV) then
	{
		{
		_x assignAsCargo _ChosenOne
		}
	foreach _asCargo
	};

_GD = (group (assigneddriver _ChosenOne));

_unitG setVariable [("CC" + _unitvar), true];

_unitvar = str _GD;

_busy = false;

if not (_GD == _unitG) then 
	{
	_timer = -5;
	waituntil 
		{
		sleep 5;
		_GD = (group (assigneddriver _ChosenOne));
		_busy = _GD getvariable ("CargoM" + _unitvar);
		if ((abs (speed _ChosenOne)) < 0.5) then {_timer = _timer + 5};
		(not (_busy) or (_timer > 120));
		};

	if (_timer > 120) then 
		{
		[_GD, (currentWaypoint _GD)] setWaypointPosition [position _ChosenOne, 0];
		if (_ChosenOne isKindOf "Air") then 
			{
			if ((_logic getvariable "HAC_HQ_LZ")) then 
				{
				_lz = [position _ChosenOne,_logic] call ALiVE_fnc_HAC_LZ;
                _i01 = [position _lz,group _ChosenOne,"markLZ",(_logic getvariable ["HAC_HQ_Color","ColorRed"]),"ICON","mil_dot","LZ","",_logic] call ALiVE_fnc_HAC_Mark;
				}
			};

		_ChosenOne land 'GET OUT';
		if not ((_GD == _unitG) or (isNull ((group (assigneddriver _ChosenOne))))) then 
			{
			{unassignVehicle _x} foreach (units _unitG);
			_unitvar = str _GD;
			_GD setVariable [("CargoM" + _unitvar), false]
			}
		else
			{
			(units _unitG) orderGetIn false;
			};

		_cause = [_logic,_unitG,1,false,0,240,[],false,true,false] call ALiVE_fnc_HAC_Wait;
		if ((_logic getvariable "HAC_HQ_LZ")) then {deleteVehicle _lz};
		_timer = _cause select 0
		};

	_Landpos = [];
	_Vpos = _GD getvariable ("START" + _unitvar);

	if not (isNil ("_Vpos")) then {_LandPos = _GD getvariable ("START" + _unitvar)} else {_LandPos = [(position _logic select 0) + (random 200) - 100,(position _logic select 1) + (random 200) - 100]};
	sleep 5;
	if not (_GD in (_logic getvariable "HAC_HQ_AirG")) then {sleep 15};

	_task = [(leader _GD),["Return to starting position.", "Move", ""],_LandPos,_logic] call ALiVE_fnc_HAC_AddTask;

	_GD = (group (assigneddriver _ChosenOne));

	_beh = "SAFE";
	if (_unitG in (_logic getvariable "HAC_HQ_RAirG")) then {_beh = "CARELESS"};
	_wp = [_logic,_GD,_LandPos,"MOVE",_beh,"YELLOW","FULL",["true","{(vehicle _x) land 'LAND'} foreach (units (group this));deletewaypoint [(group this), 0]"]] call ALiVE_fnc_HAC_WPadd;

	_timer = -5;
	waituntil 
		{
		_GD = (group (assigneddriver _ChosenOne));
		if (abs (speed _ChosenOne) < 0.5) then {_timer = _timer + 5};
		sleep 5;
		(((count (waypoints _GD)) < 1) or (_timer > 120))
		};

	if (_timer > 120) then {deleteWaypoint [_GD, 1]};
	if ((isPlayer (leader _GD)) and not (isMultiplayer)) then {(leader _GD) removeSimpleTask _task};
	_GD setVariable [("Busy" + _unitvar), false];
	_ChosenOne enableAI "TARGET";_ChosenOne enableAI "AUTOTARGET";
	_UL = leader _unitG;if not (isPlayer _UL) then {if ((random 100) < (_logic getvariable "HAC_xHQ_AIChatDensity")) then {[_UL,(_logic getvariable "HAC_xHQ_AIC_OrdEnd"),"OrdEnd",_logic] call ALiVE_fnc_HAC_AIChatter}};
	};