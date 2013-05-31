_i = "";
_logic = _this select ((count _this)-1);

_unitG = _this select 0;_Spos = _unitG getvariable ("START" + (str _unitG));if (isNil ("_Spos")) then {_unitG setVariable [("START" + (str _unitG)),(position (vehicle (leader _unitG)))];_Spos = _unitG getVariable ("START" + (str _unitG))}; 
_Trg = _this select 1;
_isAttacked = (group _Trg) getvariable ("ArmorAttacked" + (str (group _Trg)));
if (isNil ("_isAttacked")) then {_isAttacked = 0};

_PosObj1 = position _Trg;
_unitvar = str (_unitG);
_busy = false;

//if (_isAttacked > 1) exitwith {};

[_unitG,_logic] call ALiVE_fnc_HAC_WPdel;

_unitG setVariable [("Deployed" + (str _unitG)),false];_unitG setVariable [("Capt" + (str _unitG)),false];

_unitG setVariable [("Busy" + _unitvar), true];
_HAC_HQ_AttackAv = (_logic getvariable ["HAC_HQ_AttackAv",[]]) -  [_unitG];
_logic setvariable ["HAC_HQ_AttackAv",_HAC_HQ_AttackAv];

_UL = leader _unitG;
_nothing = true;

_dX = (_PosObj1 select 0) - ((getposATL _logic) select 0);
_dY = (_PosObj1 select 1) - ((getposATL _logic) select 1);

_angle = _dX atan2 _dY;

_distance = _logic distance _PosObj1;
_distance2 = 500;

_dXc = _distance2 * (cos _angle);
_dYc = _distance2 * (sin _angle);

if (_isAttacked == 1) then {(group _Trg) setvariable [("ArmorAttacked" + (str (group _Trg))),2,true];_dYc = - _dYc};
if (_isAttacked < 1) then {(group _Trg) setvariable [("ArmorAttacked" + (str (group _Trg))),1,true];_dXc = - _dXc};
if (_isAttacked > 1) then {_distance = _distance - _distance2;_dXc = 0;_dYc = 0};

_dXb = _distance * (sin _angle);
_dYb = _distance * (cos _angle);

_posX = ((getposATL _logic) select 0) + _dXb + _dXc + (random 200) - 100;
_posY = ((getposATL _logic) select 1) + _dYb + _dYc + (random 200) - 100;

_isWater = surfaceIsWater [_posX,_posY];

while {((_isWater) and (([_posX,_posY] distance _PosObj1) >= 50))} do
	{
	_posX = _posX - _dXc/20;
	_posY = _posY - _dYc/20;
	_isWater = surfaceIsWater [_posX,_posY];
	};

_isWater = surfaceIsWater [_posX,_posY];

if (_isWater) exitwith 
	{
	_HAC_HQ_AttackAv = (_logic getvariable ["HAC_HQ_AttackAv",[]]) + [_unitG];
	_logic setvariable ["HAC_HQ_AttackAv",_HAC_HQ_AttackAv];
	_unitG setVariable [("Busy" + (str _unitG)),false];
	[_Trg,"ArmorAttacked",_logic] call ALiVE_fnc_HAC_VarReductor
	};

if ((isPlayer (leader _unitG)) and ((_logic getvariable "HAC_xHQ_GPauseActive"))) then {hintC "New orders from HQ!";setAccTime 1};

_UL = leader _unitG;
_logic setvariable ["HAC_HQ_VCDone",false];
if (isPlayer _UL) then {[_UL,_logic,_logic] spawn ALiVE_fnc_HAC_VoiceComm;sleep 3;waituntil {sleep 0.1;(_logic getvariable "HAC_HQ_VCDone")}} else {if ((random 100) < (_logic getvariable "HAC_xHQ_AIChatDensity")) then {[_UL,(_logic getvariable "HAC_xHQ_AIC_OrdConf"),"OrdConf",_logic] call ALiVE_fnc_HAC_AIChatter}};

if (((_logic getvariable "HAC_HQ_Debug")) or (isPlayer (leader _unitG))) then 
	{
	_i = [[_posX,_posY],_unitG,"markAttack",(_logic getvariable ["HAC_HQ_Color","ColorRed"]),"ICON","waypoint"," | Armor"," - ATTACK",[0.75,0.75],_logic] call ALiVE_fnc_HAC_Mark;
	};

_task = [(leader _unitG),["Search and destroy enemy.", "S&D", ""],[_posX,_posY],_logic] call ALiVE_fnc_HAC_AddTask;

_wp = [_logic,_unitG,[_posX,_posY],"MOVE","AWARE","RED","NORMAL"] call ALiVE_fnc_HAC_WPadd;

if (_logic getvariable "HAC_xHQ_SynchroAttack") then
	{
	[_wp,_Trg,_logic] call ALiVE_fnc_HAC_WPSync;
	};

_cause = [_logic,_unitG,6,true,0,24,[],false] call ALiVE_fnc_HAC_Wait;
_timer = _cause select 0;
_alive = _cause select 1;

if not (_alive) exitwith 
	{
	if ((_logic getvariable "HAC_HQ_Debug") or (isPlayer (leader _unitG))) then {deleteMarker ("markAttack" + str (_unitG))};
	[_Trg,"ArmorAttacked",_logic] call ALiVE_fnc_HAC_VarReductor
	};

if (_timer > 24) then {deleteWaypoint _wp};

if (isPlayer (leader _unitG)) then
	{
	if not (isMultiplayer) then
		{
		_task setSimpleTaskDestination (position _Trg)
		}
	else
		{
		[(leader _unitG),nil, "per", rSETSIMPLETASKDESTINATION, _task,(position _Trg)] call RE
		}
	};

_cur = true;

if (_logic getvariable "HAC_xHQ_SynchroAttack") then {_cur = false};
_frm = formation _unitG;
if not (isPlayer (leader _unitG)) then {_frm = "WEDGE"};

_UL = leader _unitG;if not (isPlayer _UL) then {if (_timer <= 24) then {if ((random 100) < (_logic getvariable "HAC_xHQ_AIChatDensity")) then {[_UL,(_logic getvariable "HAC_xHQ_AIC_OrdFinal"),"OrdFinal",_logic] call ALiVE_fnc_HAC_AIChatter}}};

_tPos = getposATL _Trg;
_tPosX = _tPos select 0;
_tPosY = _tPos select 1;

_tPosX = (_tPosX + _posX)/2;
_tPosY = (_tPosY + _posY)/2;

_wp = [_logic,_unitG,[_tPosX,_tPosY],"SAD","AWARE","RED","NORMAL",["true","deletewaypoint [(group this), 0];"],_cur,0,[0,0,0],_frm] call ALiVE_fnc_HAC_WPadd;

_cause = [_logic,_unitG,6,true,0,24,[],false] call ALiVE_fnc_HAC_Wait;
_timer = _cause select 0;
_alive = _cause select 1;

if not (_alive) exitwith 
	{
	if ((_logic getvariable "HAC_HQ_Debug") or (isPlayer (leader _unitG))) then {deleteMarker ("markAttack" + str (_unitG))};
	[_Trg,"ArmorAttacked",_logic] call ALiVE_fnc_HAC_VarReductor
	};

if (_timer > 24) then {deleteWaypoint _wp};

if ((_logic getvariable "HAC_HQ_Debug") or (isPlayer (leader _unitG))) then {_i setMarkerColor (_logic getvariable ["HAC_HQ_Color","ColorBlue"])};

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

sleep 60;

if ((isPlayer (leader _unitG)) and not (isMultiplayer)) then {(leader _unitG) removeSimpleTask _task};

if ((_logic getvariable "HAC_HQ_Debug") or (isPlayer (leader _unitG))) then {deleteMarker _i};

_countAv = count (_logic getvariable "HAC_HQ_AttackAv");
_HAC_HQ_AttackAv = (_logic getvariable ["HAC_HQ_AttackAv",[]]) + [_unitG];
_logic setvariable ["HAC_HQ_AttackAv",_HAC_HQ_AttackAv];
_unitG setVariable [("Busy" + (str _unitG)),false];

[_Trg,"ArmorAttacked",_logic] call ALiVE_fnc_HAC_VarReductor;

_UL = leader _unitG;
if not (isPlayer _UL) then {if ((random 100) < (_logic getvariable "HAC_xHQ_AIChatDensity")) then {[_UL,(_logic getvariable "HAC_xHQ_AIC_OrdEnd"),"OrdEnd",_logic] call ALiVE_fnc_HAC_AIChatter}};