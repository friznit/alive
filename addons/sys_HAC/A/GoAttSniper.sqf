_i = "";

_unitG = _this select 0;
_logic = _this select ((count _this)-1);

_Spos = _unitG getvariable ("START" + (str _unitG));
if (isNil ("_Spos")) then {_unitG setVariable [("START" + (str _unitG)),(position (vehicle (leader _unitG)))];_Spos = _unitG getVariable ("START" + (str _unitG))}; 

_Trg = _this select 1;

_isAttacked = (group _Trg) getvariable ("SnpAttacked" + (str (group _Trg)));
if (isNil ("_isAttacked")) then {_isAttacked = 0};

_PosObj1 = position _Trg;
_unitvar = str (_unitG);

//if (_isAttacked > 2) exitwith {};

[_unitG,_logic] call ALiVE_fnc_HAC_WPdel;

_unitG setVariable [("Deployed" + (str _unitG)),false];_unitG setVariable [("Capt" + (str _unitG)),false];
if (_isAttacked < 1) then {(group _Trg) setvariable [("SnpAttacked" + (str (group _Trg))),1,true]};

_HAC_HQ_AttackAv = (_logic getvariable ["HAC_HQ_AttackAv",[]]) -  [_unitG];_logic setvariable ["HAC_HQ_AttackAv",_HAC_HQ_AttackAv];

_UL = leader _unitG;
_nothing = true;

_dX = (_PosObj1 select 0) - ((getPosATL _logic) select 0);
_dY = (_PosObj1 select 1) - ((getPosATL _logic) select 1);

_angle = _dX atan2 _dY;

_distance = _logic distance _PosObj1;
_distance2 = 500;

_Armor = (_logic getvariable "HAC_HQ_LArmorG") + (_logic getvariable "HAC_HQ_HArmorG");

if (_unitG in _Armor) then {_distance2 = 700};
if (_unitG in (_logic getvariable "HAC_HQ_AirG")) then {_distance2 = 800};

_isAttacked = (group _Trg) getvariable ("SnpAttacked" + (str (group _Trg)));

if (_isAttacked == 1) then {(group _Trg) setvariable [("SnpAttacked" + (str (group _Trg))),2]};
if (_isAttacked < 1) then {(group _Trg) setvariable [("SnpAttacked" + (str (group _Trg))),1]};

_distance = _distance - _distance2;
_dXb = _distance * (sin _angle);
_dYb = _distance * (cos _angle);

_posX = ((getPosATL _logic) select 0) + _dXb + (random 200) - 100;
_posY = ((getPosATL _logic) select 1) + _dYb + (random 200) - 100;

_isWater = surfaceIsWater [_posX,_posY];

_tposX = (getPosATL _Trg) select 0;
_tposY = (getPosATL _Trg) select 1;

while {((_isWater) and (([_posX,_posY] distance _PosObj1) >= 50))} do
	{
	_posX = (_posX + _tposX)/2;
	_posY = (_posY + _tposY)/2;
	_isWater = surfaceIsWater [_posX,_posY];
	};

_isWater = surfaceIsWater [_posX,_posY];

if (_isWater) exitwith 
	{
	_HAC_HQ_AttackAv = (_logic getvariable ["HAC_HQ_AttackAv",[]]) +  [_unitG];_logic setvariable ["HAC_HQ_AttackAv",_HAC_HQ_AttackAv];
	_unitG setVariable [("Busy" + (str _unitG)),false];
	[_Trg,"SnpAttacked",_logic] call ALiVE_fnc_HAC_VarReductor
	};

_positions = [[_posX,_posY,1],(getPosATL _Trg),200,1,1,_unitG,_logic] call ALiVE_fnc_HAC_FindOverwatchPos;

_cnt = count _positions;

if (_cnt > 0) then
	{
	_rnd = random 100;

	switch (true) do
		{
		case ((_rnd < 25) or (_cnt == 1)) : 
			{
			_posX = (_positions select 0) select 0;
			_posY = (_positions select 0) select 1
			};

		case (((_rnd >= 25) and (_rnd < 45)) or (_cnt == 2)) : 
			{
			_posX = (_positions select 1) select 0;
			_posY = (_positions select 1) select 1
			};

		case (((_rnd >= 45) and (_rnd < 60)) or (_cnt == 3)) : 
			{
			_posX = (_positions select 2) select 0;
			_posY = (_positions select 2) select 1
			};

		case (((_rnd >= 60) and (_rnd < 70)) or (_cnt == 4)) : 
			{
			_posX = (_positions select 3) select 0;
			_posY = (_positions select 3) select 1
			};

		default 
			{
			_posR = _positions select (floor (random (count _positions)));
			_posX = _posR select 0;
			_posY = _posR select 1
			};
		}
	};

if ((isPlayer (leader _unitG)) and ((_logic getvariable "HAC_xHQ_GPauseActive"))) then {hintC "New orders from HQ!";setAccTime 1};

_UL = leader _unitG;
_logic setvariable ["HAC_HQ_VCDone",false];
if (isPlayer _UL) then {[_UL,_logic,_logic] spawn ALiVE_fnc_HAC_VoiceComm;sleep 3;waituntil {sleep 0.1;(_logic getvariable "HAC_HQ_VCDone")}} else {if ((random 100) < (_logic getvariable "HAC_xHQ_AIChatDensity")) then {[_UL,(_logic getvariable "HAC_xHQ_AIC_OrdConf"),"OrdConf",_logic] call ALiVE_fnc_HAC_AIChatter}};

if ((_logic getvariable "HAC_HQ_Debug") or (isPlayer (leader _unitG))) then 
	{
	_i = [[_posX,_posY],_unitG,"markAttack","ColorRed","ICON","mil_dot","Snp A"," - ATTACK",_logic] call ALiVE_fnc_HAC_Mark
	};

_AV = assignedVehicle _UL;
_DAV = assigneddriver _AV;
_GDV = group _DAV;
_EnNearTrg = false;
_NeNMode = false;
_halfway = false;

_wp0 = [];
_wp = [];
_nW = 1;

_LX1 = _posX;
_LY1 = _posY;

_eClose1 = [[_posX,_posY],(_logic getvariable "HAC_HQ_KnEnemiesG"),400,_logic] call ALiVE_fnc_HAC_CloseEnemyB;

_tooC1 = _eClose1 select 0;
_dstEM1 = _eClose1 select 1;
_NeN = _eClose1 select 2;

if not (isNull _NeN) then
	{
	_eClose2 = [_UL,(_logic getvariable "HAC_HQ_KnEnemiesG"),400,_logic] call ALiVE_fnc_HAC_CloseEnemyB;
	_tooC2 = _eClose2 select 0;
	_dstEM2 = _eClose2 select 1;
	_eClose3 = [_logic,(_logic getvariable "HAC_HQ_KnEnemiesG"),400,_logic] call ALiVE_fnc_HAC_CloseEnemyB;
	_tooC3 = _eClose3 select 0;

	if ((_tooC1) or (_tooC2) or (_tooC3) or (((_UL distance [_posX,_posY]) - _dstEM2) > _dstEM1)) then {_EnNearTrg = true}
	};

if (_EnNearTrg) then {_NeNMode = true};
if (not (isNull _GDV) and (_GDV in ((_logic getvariable "HAC_HQ_NCCargoG") + (_logic getvariable "HAC_HQ_AirG"))) and (_NeNMode)) then {_LX1 = (position _UL) select 0;_LY1 = (position _UL) select 1;_halfway = true};

if ((isNull _AV) and (([_posX,_posY] distance _UL) > 1500) and not (isPlayer (leader _unitG))) then
	{
	_LX = (position _UL) select 0;
	_LY = (position _UL) select 1;

	_spd = "LIMITED";
	_TO = [0,0,0];
	if (_NeNMode) then {_spd = "NORMAL";_TO = [40, 45, 50]};

	_wp0 = [_logic,_unitG,[(_posX + _LX)/2,(_posY + _LY)/2],"MOVE","SAFE","YELLOW",_spd,["true","deletewaypoint [(group this), 0];"],true,0.001,_TO] call ALiVE_fnc_HAC_WPadd;

	_nW = 2;
	};

_task = [(leader _unitG),["Search and destroy enemy.", "S&D", ""],[_posX,_posY],_logic] call ALiVE_fnc_HAC_AddTask;

_gp = _unitG;
if not (isNull _AV) then {_gp = _GDV;_posX = (_posX + _LX1)/2;_posY = (_posY + _LY1)/2};
_pos = [_posX,_posY];
_tp = "MOVE";
//if (not (isNull _AV) and (_unitG in _logic getvariable "HAC_HQ_NCrewInfG")) then {_tp = "UNLOAD"};
_beh = "STEALTH";
if (_halfway) then {_beh = "SAFE"};
if (not (isNull _AV) and (_GDV in (_logic getvariable "HAC_HQ_AirG"))) then {_beh = "CARELESS"};
_spd = "NORMAL";
if ((isNull _AV) and (([_posX,_posY] distance _UL) > 1000) and not (_NeNMode)) then {_spd = "LIMITED"};
_TO = [0,0,0];
if ((isNull _AV) and (([_posX,_posY] distance _UL) <= 1000) or ((_NeNMode) and (isNull _AV))) then {_TO = [40, 45, 50]};
_crr = false;
if ((_nW == 1) and (isNull _AV)) then {_crr = true};
if not (isNull _AV) then {_crr = true};
_sts = ["true","deletewaypoint [(group this), 0];"];
//if (((group (assigneddriver _AV)) in (_logic getvariable "HAC_HQ_AirG")) and (_unitG in _logic getvariable "HAC_HQ_NCrewInfG")) then {_sts = ["true","(vehicle this) land 'GET OUT';deletewaypoint [(group this), 0]"]};

_wp = [_logic,_gp,_pos,_tp,_beh,"YELLOW",_spd,_sts,_crr,0.001,_TO] call ALiVE_fnc_HAC_WPadd;

if ((_logic getvariable "HAC_xHQ_SynchroAttack") and not (_halfway)) then
	{
	[_wp,_Trg,_logic] call ALiVE_fnc_HAC_WPSync;
	 
	 
	};

_DAV = assigneddriver _AV;

_cause = [_logic,_unitG,6,true,0,300,[],false] call ALiVE_fnc_HAC_Wait;
_timer = _cause select 0;
_alive = _cause select 1;

if (_timer > 300) then {[_unitG, (currentWaypoint _unitG)] setWaypointPosition [position (vehicle _UL), 0];[_unitG,_logic] call ALiVE_fnc_HAC_ResetAI};
if not (_alive) exitwith 
	{
	if ((_logic getvariable "HAC_HQ_Debug") or (isPlayer (leader _unitG))) then {deleteMarker ("markAttack" + str (_unitG))};
	[_Trg,"SnpAttacked",_logic] call ALiVE_fnc_HAC_VarReductor
	};

_pass = assignedCargo _AV;
    if (_unitG in (_logic getvariable "HAC_HQ_NCrewInfG")) then {_pass orderGetIn false};
sleep 5;
_alive = true;
if (_halfway) then
	{
	_frm = formation _unitG;
	if not (isPlayer (leader _unitG)) then {_frm = "STAG COLUMN"};

	_wp = [_logic,_unitG,[_posX,_posY],"MOVE","STEALTH","YELLOW","NORMAL",["true","deletewaypoint [(group this), 0];"],true,0.001,[0,0,0],_frm] call ALiVE_fnc_HAC_WPadd;

	if (_logic getvariable "HAC_xHQ_SynchroAttack") then
		{
		[_wp,_Trg,_logic] call ALiVE_fnc_HAC_WPSync;
		 
		 
		};

	_cause = [_logic,_unitG,6,true,0,300,[],false] call ALiVE_fnc_HAC_Wait;
	_timer = _cause select 0;
	_alive = _cause select 1;

	if not (_alive) exitwith {if ((_logic getvariable "HAC_HQ_Debug") or (isPlayer (leader _unitG))) then {deleteMarker ("markAttack" + str (_unitG))}};
	if (_timer > 300) then {[_unitG, (currentWaypoint _unitG)] setWaypointPosition [position (vehicle _UL), 0];[_unitG,_logic] call ALiVE_fnc_HAC_ResetAI};
	};

if not (_alive) exitwith {[_Trg,"SnpAttacked",_logic] call ALiVE_fnc_HAC_VarReductor};

if (isPlayer (leader _unitG)) then
	{
	if not (isMultiplayer) then
		{
		_task setSimpleTaskDescription ["Stay hidden, where you are and snipe any spotted enemy units.", "Snipe", ""];
		_task setSimpleTaskDestination (position _Trg)
		}
	else
		{
		[(leader _unitG),nil, "per", rSETSIMPLETASKDESTINATION, _task,(position _Trg)] call RE;
		[(leader _unitG),nil, "per", rSETSIMPLETASKDESCRIPTION, _task,["Stay hidden, where you are and snipe any spotted enemy units.", "Snipe", ""]] call RE
		}
	};

_frm = formation _unitG;
if not (isPlayer (leader _unitG)) then {_frm = "WEDGE"};
_unitG enableAttack false; 
_cur = true;
if (_logic getvariable "HAC_xHQ_SynchroAttack") then {_cur = false};

_UL = leader _unitG;if not (isPlayer _UL) then {if (_timer <= 300) then {if ((random 100) < HAC_xHQ_AIChatDensity) then {[_UL,HAC_xHQ_AIC_OrdFinal,"OrdFinal",_logic] call ALiVE_fnc_HAC_AIChatter}}};

_wp = [_logic,_unitG,getPosATL (vehicle (leader _unitG)),"SENTRY","STEALTH","RED","NORMAL",["true",""],_cur,0.001,[0,0,0],_frm] call ALiVE_fnc_HAC_WPadd;

_fEH = (leader _unitG) addEventHandler ["Fired",{_this spawn ALiVE_fnc_HAC_FireCount}];
(leader _unitG) setVariable ["HAC_FEH",_fEH];
[_unitG,_Trg] spawn {_unitG = _this select 0;_Trg = _this select 1; sleep (5 + (random 5));_unitG reveal [_Trg,3]};
_cause = [_logic,_unitG,5,true,0,240,[],false,true,true,false,false,false,true] call ALiVE_fnc_HAC_Wait;
_timer = _cause select 0;
_alive = _cause select 1;

_unitG enableAttack true; 
_fEH = (leader _unitG) getVariable "HAC_FEH";
(leader _unitG) setVariable ["FireCount",nil];

if not (isNil "_fEH") then
	{
	(leader _unitG) removeEventHandler ["Fired",_fEH];
	(leader _unitG) setVariable ["HAC_FEH",nil]
	};

if not (_alive) exitwith 
	{
	if ((_logic getvariable "HAC_HQ_Debug") or (isPlayer (leader _unitG))) then {deleteMarker ("markAttack" + str (_unitG))};
	[_Trg,"SnpAttacked",_logic] call ALiVE_fnc_HAC_VarReductor
	};

if (_timer > 240) then {[_unitG,_logic] call ALiVE_fnc_HAC_WPdel};

if ((_logic getvariable "HAC_HQ_Debug") or (isPlayer (leader _unitG))) then {_i setMarkerColor "ColorBlue"};

_sPosX = _Spos select 0;
_sPosY = _Spos select 1;

_wPosX = (_sPosX + _posX)/2;
_wPosY = (_sPosY + _posY)/2;

_frm = formation _unitG;
if not (isPlayer (leader _unitG)) then {_frm = "DIAMOND"};

_wp = [_logic,_unitG,[_wPosX,_wPosY],"MOVE","STEALTH","GREEN","NORMAL",["true","deletewaypoint [(group this), 0];"],true,0,[0,0,0],_frm] call ALiVE_fnc_HAC_WPadd;

_cause = [_logic,_unitG,6,true,0,300,[],false] call ALiVE_fnc_HAC_Wait;
_timer = _cause select 0;
_alive = _cause select 1;

if not (_alive) exitwith {[_Trg,"SnpAttacked",_logic] call ALiVE_fnc_HAC_VarReductor;if ((_logic getvariable "HAC_HQ_Debug") or (isPlayer (leader _unitG))) then {deleteMarker ("markAttack" + str (_unitG))}};
if (_timer > 300) then {[_unitG, (currentWaypoint _unitG)] setWaypointPosition [position (vehicle _UL), 0]};

if (isPlayer (leader _unitG)) then
	{
	if not (isMultiplayer) then
		{
		_task setSimpleTaskDescription ["Withdraw.", "Move", ""];
		_task setSimpleTaskDestination _Spos
		}
	else
		{
		[(leader _unitG),nil, "per", rSETSIMPLETASKDESTINATION, _task,_Spos] call RE;
		[(leader _unitG),nil, "per", rSETSIMPLETASKDESCRIPTION, _task,["Withdraw.", "Move", ""]] call RE
		};
	};

_wp = [_logic,_unitG,_Spos,"MOVE","SAFE","YELLOW","NORMAL",["true","deletewaypoint [(group this), 0];"],true,5] call ALiVE_fnc_HAC_WPadd;

_cause = [_logic,_unitG,6,true,0,30,[],false] call ALiVE_fnc_HAC_Wait;
_timer = _cause select 0;
_alive = _cause select 1;

if (_unitG in (_logic getvariable "HAC_HQ_Garrison")) then
	{
	if (isPlayer (leader _unitG)) then
		{
		if not (isMultiplayer) then
			{
			_task setSimpleTaskDescription ["Return.", "Move", ""];
			_task setSimpleTaskDestination _Spos
			}
		else
			{
			[(leader _unitG),nil, "per", rSETSIMPLETASKDESTINATION, _task,_Spos] call RE;
			[(leader _unitG),nil, "per", rSETSIMPLETASKDESCRIPTION, _task,["Return.", "Move", ""]] call RE
			}
		};
	
	_wp = [_logic,_unitG,_Spos,"MOVE","SAFE","YELLOW","NORMAL",["true","deletewaypoint [(group this), 0];"],true,5] call ALiVE_fnc_HAC_WPadd;

	_cause = [_logic,_unitG,6,true,0,30,[],false] call ALiVE_fnc_HAC_Wait;
	_timer = _cause select 0;
	_alive = _cause select 1;

	if not (_alive) exitwith {if ((_logic getvariable "HAC_HQ_Debug") or (isPlayer (leader _unitG))) then {deleteMarker ("markAttack" + str (_unitG))}};
	if (_timer > 30) then {[_unitG, (currentWaypoint _unitG)] setWaypointPosition [position (vehicle _UL), 0]};
	_unitG setVariable ["Garrisoned" + (str _unitG),false];
	};

sleep 120;

if ((isPlayer (leader _unitG)) and not (isMultiplayer)) then {(leader _unitG) removeSimpleTask _task};

if ((_logic getvariable "HAC_HQ_Debug") or (isPlayer (leader _unitG))) then {deleteMarker ("markAttack" + str (_unitG))};

_pass orderGetIn true;//_countAv = count HAC_HQ_AttackAv;
_HAC_HQ_AttackAv = (_logic getvariable ["HAC_HQ_AttackAv",[]]) +  [_unitG];_logic setvariable ["HAC_HQ_AttackAv",_HAC_HQ_AttackAv];
_unitG setVariable [("Busy" + (str _unitG)),false];

[_Trg,"SnpAttacked",_logic] call ALiVE_fnc_HAC_VarReductor;

_UL = leader _unitG;
if not (isPlayer _UL) then {if ((random 100) < (_logic getvariable "HAC_xHQ_AIChatDensity")) then {[_UL,(_logic getvariable "HAC_xHQ_AIC_OrdEnd"),"OrdEnd",_logic] call ALiVE_fnc_HAC_AIChatter}};