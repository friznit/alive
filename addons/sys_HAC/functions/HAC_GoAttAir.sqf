_i = "";

_unitG = _this select 0;
_Trg = _this select 1;
_logic = _this select ((count _this)-1);

_PosObj1 = position _Trg;
_unitvar = str (_unitG);

_UL = leader _unitG;
_PosLand = position (vehicle _UL);

[_unitG,_logic] call ALiVE_fnc_HAC_WPdel;

_unitG setVariable [("Deployed" + (str _unitG)),false];_unitG setVariable [("Capt" + (str _unitG)),false];
//_unitG setVariable [("Busy" + (str _unitG)),true];

_HAC_HQ_AttackAv = (_logic getvariable ["HAC_HQ_AttackAv",[]]) -  [_unitG];
_logic setvariable ["HAC_HQ_AttackAv",_HAC_HQ_AttackAv];

_nothing = true;

_dX = (_PosObj1 select 0) - ((getposATL _logic) select 0);
_dY = (_PosObj1 select 1) - ((getposATL _logic) select 1);

_angle = _dX atan2 _dY;

_distance = _logic distance _PosObj1;
_distance2 = 0;

_dXc = _distance2 * (cos _angle);
_dYc = _distance2 * (sin _angle);

_dXb = _distance * (sin _angle);
_dYb = _distance * (cos _angle);

_posX = ((getposATL _logic) select 0) + _dXb;
_posY = ((getposATL _logic) select 1) + _dYb;

if ((isPlayer (leader _unitG)) and ((_logic getvariable "HAC_xHQ_GPauseActive"))) then {hintC "New orders from HQ!";setAccTime 1};

_UL = leader _unitG;
_logic setvariable ["HAC_HQ_VCDone",false];
if (isPlayer _UL) then {[_UL,_logic,_logic] spawn ALiVE_fnc_HAC_VoiceComm;sleep 3;waituntil {sleep 0.1;(_logic getvariable "HAC_HQ_VCDone")}} else {if ((random 100) < (_logic getvariable "HAC_xHQ_AIChatDensity")) then {[_UL,(_logic getvariable "HAC_xHQ_AIC_OrdConf"),"OrdConf",_logic] call ALiVE_fnc_HAC_AIChatter}};

if (((_logic getvariable "HAC_HQ_Debug")) or (isPlayer (leader _unitG))) then 
	{
	_i = [[_posX,_posY],_unitG,"markAttack",(_logic getvariable ["HAC_HQ_Color","ColorRed"]),"ICON","waypoint"," | Air"," - ATTACK",[0.75,0.75],_logic] call ALiVE_fnc_HAC_Mark
	};

_task = [(leader _unitG),["Search and destroy enemy.", "S&D", ""],[_posX,_posY],_logic] call ALiVE_fnc_HAC_AddTask;

_wp = [_logic,_unitG,[_posX,_posY],"SAD","COMBAT","RED","NORMAL",["true", "deletewaypoint [(group this), 0]"],true,0.001] call ALiVE_fnc_HAC_WPadd;

_lasT = ObjNull;

if (_unitG in (_logic getvariable "HAC_HQ_BAirG")) then 
	{
	_eSide = side _unitG;
	_wp waypointAttachVehicle _Trg;
	_wp setWaypointType "DESTROY";
	_tgt = "LaserTargetWStatic";
	if (_eSide == east) then {_tgt = "LaserTargetEStatic"};

	_tPos = getposATL _Trg;
	_tX = (_tPos select 0) + (random 60) - 30;
	_tY = (_tPos select 1) + (random 60) - 30;

	_lasT = createVehicle [_tgt, [_tX,_tY,0], [], 0, "CAN_COLLIDE"]; 

	[_Trg,_lasT,_unitG] spawn
		{
		_Trg = _this select 0;
		_lasT = _this select 1;
		_unitG = _this select 2;

		_VL = vehicle (leader _unitG);
		_ct = 0;

		while {(not (isNull _Trg) and not (isNull _lasT) and not (isNull _VL) and (_ct < 100))} do
			{
			if not (alive _Trg) exitWith {};
			if not (alive _VL) exitWith {};

			_tPos = getposATL _Trg;
			_tX = (_tPos select 0) + (random 60) - 30;
			_tY = (_tPos select 1) + (random 60) - 30;

			_lasT setPos [_tX,_tY,0];

			sleep 15;
			_ct = _ct + 1
			};

		if (not (isNull _unitG) and (({alive _x} count (units _unitG)) > 0)) then 
			{
			waitUntil
				{
				sleep 10;

				_isBusy = _unitG getVariable [("Busy" + (str _unitG)),false];

				(not (_isBusy) or (({alive _x} count (units _unitG)) < 1));
				}
			};

		deleteVehicle _lasT
		}
	};

_cause = [_logic,_unitG,6,true,0,24,[],false] call ALiVE_fnc_HAC_Wait;
_timer = _cause select 0;
_alive = _cause select 1;

if not (_alive) exitwith 
	{
	if ((_logic getvariable "HAC_HQ_Debug") or (isPlayer (leader _unitG))) then {deleteMarker ("markAttack" + str (_unitG))};
	if not (isNull _lasT) then {deleteVehicle _lasT};
	[_Trg,"AirAttacked",_logic] call ALiVE_fnc_HAC_VarReductor
	};

if (_timer > 24) then {deleteWaypoint _wp};

if (isPlayer (leader _unitG)) then
	{
	if not (isMultiplayer) then
		{
		_task setSimpleTaskDestination _Posland;
		_task setSimpleTaskDescription ["Return to the landing site.", "Move", ""]
		}
	else
		{
		[(leader _unitG),nil, "per", rSETSIMPLETASKDESTINATION, _task,_Posland] call RE;
		[(leader _unitG),nil, "per", rSETSIMPLETASKDESCRIPTION, _task,["Return to the landing site.", "Move", ""]] call RE
		}
	};

if (_logic getvariable "HAC_HQ_Debug" or (isPlayer (leader _unitG))) then {_i setMarkerColor (_logic getvariable ["HAC_HQ_Color","ColorBlue"])};
if (_unitG in (_logic getvariable "HAC_HQ_BAirG")) then {deleteVehicle _lasT};

_wp = [_logic,_unitG,_Posland,"MOVE","AWARE","GREEN","NORMAL",["true", "{(vehicle _x) land 'LAND'} foreach (units (group this)); deletewaypoint [(group this), 0]"],true,0.001] call ALiVE_fnc_HAC_WPadd;

_cause = [_logic,_unitG,6,true,0,24,[],false] call ALiVE_fnc_HAC_Wait;
_timer = _cause select 0;
_alive = _cause select 1;

if not (_alive) exitwith 
	{
	if ((_logic getvariable "HAC_HQ_Debug") or (isPlayer (leader _unitG))) then {deleteMarker ("markAttack" + str (_unitG))};
	[_Trg,"AirAttacked",_logic] call ALiVE_fnc_HAC_VarReductor
	};
if (_timer > 24) then {deleteWaypoint _wp};

sleep 30;

if ((isPlayer (leader _unitG)) and not (isMultiplayer)) then {(leader _unitG) removeSimpleTask _task};

if ((_logic getvariable "HAC_HQ_Debug") or (isPlayer (leader _unitG))) then {deleteMarker ("markAttack" + str (_unitG))};

_countAv = count (_logic getvariable "HAC_HQ_AttackAv");
_HAC_HQ_AttackAv = (_logic getvariable ["HAC_HQ_AttackAv",[]]) + [_unitG];
_logic setvariable ["HAC_HQ_AttackAv",_HAC_HQ_AttackAv];
_unitG setVariable [("Busy" + (str _unitG)),false];

[_Trg,"AirAttacked",_logic] call ALiVE_fnc_HAC_VarReductor;

_UL = leader _unitG;
if not (isPlayer _UL) then {if ((random 100) < (_logic getvariable "HAC_xHQ_AIChatDensity")) then {[_UL,(_logic getvariable "HAC_xHQ_AIC_OrdEnd"),"OrdEnd",_logic] call ALiVE_fnc_HAC_AIChatter}};