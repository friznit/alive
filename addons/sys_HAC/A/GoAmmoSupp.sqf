_i = "";

_unit = _this select 0;
_Trg = _this select 1;
_Hollow = _this select 2;
_soldiers = _this select 3;
_drop = _this select 4;
_logic = _this select ((count _this)-1);

_HAC_HQ_AmmoPoints = (_logic getvariable ["HAC_HQ_AmmoPoints",[]]) + [_Trg];
_logic setvariable ["HAC_HQ_AmmoPoints",_HAC_HQ_AmmoPoints];

_startpos = position _unit;

_unitG = group (assigneddriver _unit);

if (_unit in _soldiers) then {_unitG = group _unit};

_mtr = _unit;

_mtr disableAI "TARGET";_mtr disableAI "AUTOTARGET";

[_unitG,_logic] call ALiVE_fnc_HAC_WPdel;

(group (assigneddriver _unit)) setVariable [("Deployed" + (str (group (assigneddriver _unit)))),false];
_unitvar = str (_unitG);
_unitG setVariable [("Busy" + _unitvar), true];

_posX = ((position _Trg) select 0) + (random 100) - 50;
_posY = ((position _Trg) select 1) + (random 100) - 50;

_isWater = surfaceIsWater [_posX,_posY];

_cnt = 0;

while {((_isWater) and (_cnt <= 20))} do
	{
	_posX = _posX + (random 200) - 100;
	_posY = _posY + (random 200) - 100;
	_isWater = surfaceIsWater [_posX,_posY];
	_cnt = _cnt + 1;
	};

if ((isPlayer (leader _unitG)) and ((_logic getvariable "HAC_xHQ_GPauseActive"))) then {hintC "New orders from HQ!";setAccTime 1};

_UL = leader _unitG;
_logic setvariable ["HAC_HQ_VCDone",false];
if (isPlayer _UL) then {[_UL,_logic,_logic] spawn ALiVE_fnc_HAC_VoiceComm;sleep 3;waituntil {sleep 0.1;(_logic getvariable "HAC_HQ_VCDone")}} else {if ((random 100) < (_logic getvariable "HAC_xHQ_AIChatDensity")) then {[_UL,(_logic getvariable "HAC_xHQ_AIC_OrdConf"),"OrdConf",_logic] call ALiVE_fnc_HAC_AIChatter}};

_alive = false;
if (((_logic getvariable "HAC_HQ_Debug")) or (isPlayer (leader _unitG))) then 
	{
	_i = [[_posX,_posY],_unitG,"markAmmoSupp","ColorKhaki","ICON","mil_dot"," | Reammo"," - AMMO SUPPORT",[0.25,0.25],270,_logic] call ALiVE_fnc_HAC_Mark
	};

_task = [(leader _unitG),["Deliver ammunition.", "Support", ""],(position _Trg),_logic] call ALiVE_fnc_HAC_AddTask;

if (_drop) then
	{
	_dst = _unit distance _Trg;
	if (_dst > 100) then
		{
		if (_unit isKindOf "Air") then
			{
			_ammoBox = _this select 5;
			_abPos = getPosATL _ammoBox;
			_ammoBox setPos [0,0,2000];
			_pos = _Trg;
			_ang = [(getPosATL _unit),(getPosATL _Trg),5,_logic] call ALiVE_fnc_HAC_AngTowards;
			_nextPos1 = [(getPosATL _unit),_ang,(_unit distance _Trg) + 200,_logic] call ALiVE_fnc_HAC_PosTowards2D;

			_tp = "MOVE";

			(group _Trg) setVariable ["ForBoxing",_pos];

			_wp = [_logic,_unitG,_pos,_tp,"STEALTH","BLUE","FULL",["true","deletewaypoint [(group this), 0]"]] call ALiVE_fnc_HAC_WPadd;

			_wp waypointAttachVehicle _Trg;

			_unit flyInHeight 150;
			//[_unit,100,_logic] spawn ALiVE_fnc_HAC_KeepAlt;

			_cause = [_logic,_unitG,6,true,0,24,[],true,true,true,true] call ALiVE_fnc_HAC_Wait;
			_timer = _cause select 0;
			_alive = _cause select 1;

			if not (_alive) exitwith {if (((_logic getvariable "HAC_HQ_Debug")) or (isPlayer (leader _unitG))) then {deleteVehicle _ammoBox;deleteMarker ("markAmmoSupp" + str (_unitG))};_HAC_HQ_AmmoPoints = (_logic getvariable ["HAC_HQ_AmmoPoints",[]]) - [_Trg]; _logic setvariable ["HAC_HQ_AmmoPoints",_HAC_HQ_AmmoPoints]; _unitG setVariable [("Busy" + _unitvar), false];};
			if (_timer > 24) then 
				{
				[_unitG, (currentWaypoint _unitG)] setWaypointPosition [position (vehicle (leader _unitG)), 0];
				_ammoBox setPos _abPos
				}
			else
				{
				_UL = leader _unitG;if not (isPlayer _UL) then {if (_timer <= 24) then {if ((random 100) < (_logic getvariable "HAC_xHQ_AIChatDensity")) then {[_UL,(_logic getvariable "HAC_xHQ_AIC_OrdConf"),"OrdConf",_logic] call ALiVE_fnc_HAC_AIChatter}}};
				[_unit,_ammoBox,(group _Trg),_logic] spawn ALiVE_fnc_HAC_AmmoDrop;
				_HAC_HQ_Boxed = (_logic getvariable ["HAC_HQ_Boxed",[]]) + [group _Trg];
				_logic setvariable ["HAC_HQ_Boxed",_HAC_HQ_Boxed];
				};

			_wp = [_logic,_unitG,_nextPos1,_tp,"STEALTH","BLUE","FULL",["true","deletewaypoint [(group this), 0]"]] call ALiVE_fnc_HAC_WPadd;

			_cause = [_logic,_unitG,6,true,0,24,[],true,true,true,true] call ALiVE_fnc_HAC_Wait;
			_timer = _cause select 0;
			_alive = _cause select 1;

			//_unit setVariable ["KeepAlt",false];

			if not (_alive) exitwith {if (((_logic getvariable "HAC_HQ_Debug")) or (isPlayer (leader _unitG))) then {deleteMarker ("markAmmoSupp" + str (_unitG))};_HAC_HQ_AmmoPoints = (_logic getvariable ["HAC_HQ_AmmoPoints",[]]) - [_Trg]; _logic setvariable ["HAC_HQ_AmmoPoints",_HAC_HQ_AmmoPoints];_unitG setVariable [("Busy" + _unitvar), false];};
			if (_timer > 24) then 
				{
				[_unitG, (currentWaypoint _unitG)] setWaypointPosition [position (vehicle (leader _unitG)), 0]
				}
			}
		}
	else
		{
		_sPos = _unit modelToWorld [(random 20) - 10,-10,0];
		_sPos = [_sPos select 0,_sPos select 1,0];

		_type = typeOf _ammoBox;
		deleteVehicle _ammoBox;

		_ammoBox = createVehicle [_type, _sPos, [], 0, "NONE"];

		_ammoBox setPos _sPos;
		_HAC_HQ_Boxed = (_logic getvariable ["HAC_HQ_Boxed",[]]) + [group _Trg];
		_logic setvariable ["HAC_HQ_Boxed",_HAC_HQ_Boxed];
		(group _Trg) setVariable ["isBoxed",_ammoBox]
		}
	}
else
	{
	_counter = 0;

	while {(_counter <= 3)} do
		{
		[_unitG,_logic] call ALiVE_fnc_HAC_WPdel;

		if not (_counter == 0) then 
			{
			_posX = ((position _unit) select 0) + (random 100) -  50;
			_posY = ((position _unit) select 1) + (random 100) -  50;

			_isWater = surfaceIsWater [_posX,_posY];

			_cnt = 0;

			while {((_isWater) and (_cnt <= 20))} do
				{
				_posX = _posX + (random 200) -  100;
				_posY = _posY + (random 200) -  100;
				_isWater = surfaceIsWater [_posX,_posY];
				_cnt = _cnt + 1;
				};

			if (isPlayer (leader _unitG)) then 
				{
				if not (isMultiplayer) then
					{
					_task setSimpleTaskDestination [_posX,_posY]
					}
				else
					{
					[(leader _unitG),nil, "per", rSETSIMPLETASKDESTINATION, _task,[_posX,_posY]] call RE;
					}
				}
			};

		_pos = [_posX,_posY];
		if (_counter == 0) then {_pos = _Trg};
		_tp = "MOVE";
		if ((_logic getvariable "HAC_HQ_SupportWP")) then {_tp = "SUPPORT"};

		_wp = [_logic,_unitG,_pos,_tp,"SAFE","BLUE","FULL",["true","(vehicle this) land 'GET IN';deletewaypoint [(group this), 0]"]] call ALiVE_fnc_HAC_WPadd;
		if (_counter == 0) then {_wp waypointAttachVehicle _Trg};

		_cause = [_logic,_unitG,6,true,0,24,[],true,true,true,true] call ALiVE_fnc_HAC_Wait;
		_timer = _cause select 0;
		_alive = _cause select 1;

		if not (_alive) exitwith {if (((_logic getvariable "HAC_HQ_Debug")) or (isPlayer (leader _unitG))) then {deleteMarker ("markAmmoSupp" + str (_unitG))};_HAC_HQ_AmmoPoints = (_logic getvariable ["HAC_HQ_AmmoPoints",[]]) - [_Trg];_logic setvariable ["HAC_HQ_AmmoPoints",_HAC_HQ_AmmoPoints];_unitG setVariable [("Busy" + _unitvar), false];};
		if (_timer > 24) then {_counter = _counter + 1;[_unitG, (currentWaypoint _unitG)] setWaypointPosition [position (vehicle (leader _unitG)), 0]} else {_counter = _counter + 1}; 

		_UL = leader _unitG;if not (isPlayer _UL) then {if ((_timer <= 24) and (_counter == 1)) then {if ((random 100) < (_logic getvariable "HAC_xHQ_AIChatDensity")) then {[_UL,(_logic getvariable "HAC_xHQ_AIC_OrdFinal"),"OrdFinal",_logic] call ALiVE_fnc_HAC_AIChatter}}};

		if ((damage _Trg) >= 0.9) then {_Hollow = _Hollow - [_Trg]};
		}
	};

if not (_alive) exitwith {if (((_logic getvariable "HAC_HQ_Debug")) or (isPlayer (leader _unitG))) then {deleteMarker ("markAmmoSupp" + str (_unitG))};_HAC_HQ_AmmoPoints = (_logic getvariable ["HAC_HQ_AmmoPoints",[]]) - [_Trg];_logic setvariable ["HAC_HQ_AmmoPoints",_HAC_HQ_AmmoPoints];_unitG setVariable [("Busy" + _unitvar), false];};
[_unitG, (currentWaypoint _unitG)] setWaypointPosition [position (vehicle (leader _unitG)), 0];

_tp = "MOVE";
if (((_logic getvariable "HAC_HQ_SupportWP")) and not (_drop)) then {_tp = "SUPPORT"};
_pos = [_posX,_posY];

if (_drop) then 
	{
	_HAC_HQ_AmmoPoints = (_logic getvariable ["HAC_HQ_AmmoPoints",[]]) - [_Trg];_logic setvariable ["HAC_HQ_AmmoPoints",_HAC_HQ_AmmoPoints];
	_pos = _startpos;
	if (isPlayer (leader _unitG)) then
		{
		if not (isMultiplayer) then
			{
			_task setSimpleTaskDescription ["Return.", "Move", ""];
			_task setSimpleTaskDestination _pos
			}
		else
			{
			[(leader _unitG),nil, "per", rSETSIMPLETASKDESTINATION, _task,_pos] call RE;
			[(leader _unitG),nil, "per", rSETSIMPLETASKDESCRIPTION, _task,["Return.", "Move", ""]] call RE
			}
		}
	};

_beh = "SAFE";
if (_drop) then {_beh = "STEALTH"};

_wp = [_logic,_unitG,_pos,_tp,_beh,"BLUE","FULL",["true","{(vehicle _x) land 'LAND'} foreach (units (group this));deletewaypoint [(group this), 0]"]] call ALiVE_fnc_HAC_WPadd;

_cause = [_logic,_unitG,6,true,0,24,[],true,true,true,true] call ALiVE_fnc_HAC_Wait;
_timer = _cause select 0;
_alive = _cause select 1;

if not (_alive) exitwith {if (((_logic getvariable "HAC_HQ_Debug")) or (isPlayer (leader _unitG))) then {deleteMarker ("markAmmoSupp" + str (_unitG))};_HAC_HQ_AmmoPoints = (_logic getvariable ["HAC_HQ_AmmoPoints",[]]) - [_Trg];_logic setvariable ["HAC_HQ_AmmoPoints",_HAC_HQ_AmmoPoints];_unitG setVariable [("Busy" + _unitvar), false];};
if (_timer > 24) then {[_unitG, (currentWaypoint _unitG)] setWaypointPosition [position (vehicle (leader _unitG)), 0]}; 

_HAC_HQ_AmmoPoints = (_logic getvariable ["HAC_HQ_AmmoPoints",[]]) - [_Trg];
_logic setvariable ["HAC_HQ_AmmoPoints",_HAC_HQ_AmmoPoints];

if ((isPlayer (leader _unitG)) and not (isMultiplayer)) then {(leader _unitG) removeSimpleTask _task};

_mtr enableAI "TARGET";_mtr enableAI "AUTOTARGET";
_unitG setVariable [("Busy" + _unitvar), false];

if ((damage _Trg) >= 0.9) then {_Hollow = _Hollow - [_Trg]};
if (((_logic getvariable "HAC_HQ_Debug")) or (isPlayer (leader _unitG))) then {deleteMarker ("markAmmoSupp" + str (_unitG))};
_lastOne = true;

	{
	if (((group (assigneddriver _x)) == (group (assigneddriver _Trg))) and not (_x == _Trg)) exitwith {_lastOne = false};
	if (((group _x) == (group _Trg)) and not (_x == _Trg)) exitwith {_lastOne = false};
	}
foreach _Hollow;

if (_lastOne) then {_HAC_HQ_ASupportedG = (_logic getvariable ["HAC_HQ_ASupportedG",[]]) - [group _Trg];_logic setvariable ["HAC_HQ_ASupportedG",_HAC_HQ_ASupportedG]};

_UL = leader _unitG;if not (isPlayer _UL) then {if ((random 100) < (_logic getvariable "HAC_xHQ_AIChatDensity")) then {[_UL,(_logic getvariable "HAC_xHQ_AIC_OrdEnd"),"OrdEnd",_logic] call ALiVE_fnc_HAC_AIChatter}};