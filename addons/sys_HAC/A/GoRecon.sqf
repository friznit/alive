_i = "";

_timer = 0;
_unitG = _this select 0;_Spos = _unitG getvariable ("START" + (str _unitG));if (isNil ("_Spos")) then {_unitG setVariable [("START" + (str _unitG)),(position (vehicle (leader _unitG)))];_Spos = _unitG getVariable ("START" + (str _unitG))}; 
_stage = _this select 2;
_logic = _this select ((count _this)-1);

_PosObj1 = _this select 1;
_recvar = str (_unitG);

[_unitG,_logic] call ALiVE_fnc_HAC_WPdel;

_unitG setVariable [("Deployed" + (str _unitG)),false];_unitG setVariable [("Capt" + (str _unitG)),false];
_logic setvariable ["HAC_HQ_ReconAv",(_logic getvariable "HAC_HQ_ReconAv") - [_unitG]];

_UL = leader _unitG;
_PosLand = position _UL;
_nothing = true;
_End = [((position _logic) select 0) + (random 400) - 200,((position _logic) select 1) + (random 400) - 200];
_rd = 200;

_dX = (_PosObj1 select 0) - ((getposATL _logic) select 0);
_dY = (_PosObj1 select 1) - ((getposATL _logic) select 1);

_angle = _dX atan2 _dY;

_distance = _logic distance _PosObj1;

_distance2 = 600;

_dXc = _distance2 * (cos _angle);
_dYc = _distance2 * (sin _angle);

switch (_stage) do
	{
	case (6) : {_distance = _distance - _distance2/2;_dYc = - _dYc/2};
	case (5) : {_distance = _distance - _distance2/2;_dXc = - _dXc/2};
	case (4) : {_dYc = - _dYc};
	case (3) : {_dXc = - _dXc};
	case (2) : {_distance = _distance - _distance2;_dXc = 0;_dYc = 0};
	};

_dXb = _distance * (sin _angle);
_dYb = _distance * (cos _angle);

_posX = ((getposATL _logic) select 0) + _dXb + _dXc + (random 200) - 100;
_posY = ((getposATL _logic) select 1) + _dYb + _dYc + (random 200) - 100;

_MElevated = [_posX,_posY];
_MElev = (getposATL (nearestObject [_posX,_posY,10])) select 2;

if (_unitG in HAC_HQ_FOG) then 
	{
	for [{_a = 0},{_a <= 50},{_a = _a + 1}] do
		{
		_posX0 = _posX + (random 500) - 250;
		_posY0 = _posY + (random 500) - 250;
		_Elev = getTerrainHeightASL [_posX0,_posY0];
		if (_Elev > _MElev) then {_MElev = _Elev;_MElevated = [_posX0,_posY0]};
		}
	};

_posX = _MElevated select 0;
_posY = _MElevated select 1;

_isWater = surfaceIsWater [_posX,_posY];

while {((_isWater) and (([_posX,_posY] distance _PosObj1) >= 250))} do
	{
	_posX = _posX - _dXc/20;
	_posY = _posY - _dYc/20;
	_isWater = surfaceIsWater [_posX,_posY];
	};

_isWater = surfaceIsWater [_posX,_posY];

if (_isWater) exitwith {_logic setvariable ["HAC_HQ_ReconAv",(_logic getvariable "HAC_HQ_ReconAv") + [_unitG]];_unitG setVariable [("Busy" + (str _unitG)),false]};

if ((isPlayer (leader _unitG)) and ((_logic getvariable "HAC_xHQ_GPauseActive"))) then {hintC "New orders from HQ!";setAccTime 1};

_UL = leader _unitG;
_logic setvariable ["HAC_HQ_VCDone",false];
if (isPlayer _UL) then {[_UL,_logic,_logic] spawn ALiVE_fnc_HAC_VoiceComm;sleep 3;waituntil {sleep 0.1;(_logic getvariable "HAC_HQ_VCDone")}} else {if ((random 100) < (_logic getvariable "HAC_xHQ_AIChatDensity")) then {[_UL,(_logic getvariable "HAC_xHQ_AIC_OrdConf"),"OrdConf",_logic] call ALiVE_fnc_HAC_AIChatter}};

if ((_logic getvariable "HAC_HQ_Debug") or (isPlayer (leader _unitG))) then 
	{
	_i = [[_posX,_posY],_unitG,"markRecon",(_logic getvariable ["HAC_HQ_Color","ColorRed"]),"ICON","mil_triangle"," | Rec Hold"," - NON-COMBAT RECON",[0.5,0.5],_logic] call ALiVE_fnc_HAC_Mark;
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
	
	_beh = "SAFE";
	if (_unitG in (_logic getvariable "HAC_HQ_RAirG")) then {_beh = "CARELESS"};
	_spd = "LIMITED";
	_TO = [0,0,0];
	if (_NeNMode) then {_spd = "NORMAL";_TO = [40, 45, 50]};

	_wp0 = [_logic,_unitG,[(_posX + _LX)/2,(_posY + _LY)/2],"MOVE",_beh,"GREEN",_spd,["true","deletewaypoint [(group this), 0];"],true,0,_TO] call ALiVE_fnc_HAC_WPadd;

	_nW = 2;
	};

_task = [(leader _unitG),["Make a reconnaissance designated area. Identify enemy positions. Avoid detection and engaging in combat.", "Search", ""],[_posX,_posY],_logic] call ALiVE_fnc_HAC_AddTask;

_gp = _unitG;
_pos = [_posX,_posY];
if not (isNull _AV) then {_gp = _GDV;_pos = [(_posX + _LX1)/2,(_posY + _LY1)/2]};
_tp = "MOVE";
//if (not (isNull _AV) and (_unitG in _logic getvariable "HAC_HQ_NCrewInfG")) then {_tp = "UNLOAD"};
_beh = "SAFE";
if (not (isNull _AV) and (_GDV in (_logic getvariable "HAC_HQ_AirG")) or (_unitG in (_logic getvariable "HAC_HQ_RAirG"))) then {_beh = "CARELESS"};
_spd = "NORMAL";
if ((isNull _AV) and (([_posX,_posY] distance _UL) > 1000) and not (_NeNMode)) then {_spd = "LIMITED"};
_TO = [0,0,0];
if ((isNull _AV) and (([_posX,_posY] distance _UL) <= 1000) or ((_NeNMode) and (isNull _AV))) then {_TO = [40, 45, 50]};
_crr = false;
if ((_nW == 1) and (isNull _AV)) then {_crr = true};
if not (isNull _AV) then {_crr = true};
_sts = ["true","deletewaypoint [(group this), 0];"];
    if (((group (assigneddriver _AV)) in (_logic getvariable "HAC_HQ_AirG")) and (_unitG in (_logic getvariable "HAC_HQ_NCrewInfG"))) then {_sts = ["true","(vehicle this) land 'GET OUT';deletewaypoint [(group this), 0]"]};

_wp = [_logic,_gp,_pos,_tp,_beh,"GREEN",_spd,_sts,_crr,0.001,_TO] call ALiVE_fnc_HAC_WPadd;

_DAV = assigneddriver _AV;

_cause = [_logic,_unitG,6,true,600,50,[(_logic getvariable "HAC_HQ_AirG"),(_logic getvariable "HAC_HQ_KnEnemiesG")],false] call ALiVE_fnc_HAC_Wait;
_timer = _cause select 0;
_alive = _cause select 1;
_enemy = _cause select 2;

if ((_timer > 50) or (_enemy)) then {[_unitG, (currentWaypoint _unitG)] setWaypointPosition [position (vehicle _UL), 0]};
if not (_alive) exitwith {if ((_logic getvariable "HAC_HQ_Debug") or (isPlayer (leader _unitG))) then {deleteMarker ("markAttack" + str (_unitG))}};

_UL = leader _unitG;if not (isPlayer _UL) then {if (not (_halfway) and (_timer <= 50) and not (_enemy)) then {if ((random 100) < (_logic getvariable "HAC_xHQ_AIChatDensity")) then {[_UL,(_logic getvariable "HAC_xHQ_AIC_OrdFinal"),"OrdFinal",_logic] call ALiVE_fnc_HAC_AIChatter}}};

_pass = assignedCargo _AV;
    if (_unitG in (_logic getvariable "HAC_HQ_NCrewInfG")) then {_pass orderGetIn false};
sleep 5;
_alive = true;
if (_halfway) then
	{
	_beh = "AWARE";
	if (_unitG in (_logic getvariable "HAC_HQ_RAirG")) then {_beh = "CARELESS"};
	_frm = formation _unitG;
	if not (isPlayer (leader _unitG)) then {_frm = "STAG COLUMN"};

	_wp = [_logic,_unitG,[_posX,_posY],"MOVE",_beh,"GREEN","NORMAL",["true","deletewaypoint [(group this), 0];"],true,0.001,[0,0,0],_frm] call ALiVE_fnc_HAC_WPadd;

	_cause = [_logic,_unitG,6,true,0,30,[],false] call ALiVE_fnc_HAC_Wait;
	_timer = _cause select 0;
	_alive = _cause select 1;

	if not (_alive) exitwith {if ((_logic getvariable "HAC_HQ_Debug") or (isPlayer (leader _unitG))) then {deleteMarker ("markAttack" + str (_unitG))}};
	if (_timer > 30) then {[_unitG, (currentWaypoint _unitG)] setWaypointPosition [position (vehicle _UL), 0]};
	};

if not (_alive) exitwith {};

_beh = "AWARE";
if (_unitG in (_logic getvariable "HAC_HQ_RAirG")) then {_beh = "CARELESS"};
_frm = formation _unitG;
if not (isPlayer (leader _unitG)) then {_frm = "WEDGE"};

_UL = leader _unitG;if not (isPlayer _UL) then {if ((_halfway) and (_timer <= 30)) then {if ((random 100) < (_logic getvariable "HAC_xHQ_AIChatDensity")) then {[_UL,(_logic getvariable "HAC_xHQ_AIC_OrdFinal"),"OrdFinal",_logic] call ALiVE_fnc_HAC_AIChatter}}};

_wp = [_logic,_unitG,[_posX,_posY],"SAD",_beh,"GREEN","NORMAL",["true","deletewaypoint [(group this), 0];"],true,0.001,[0,0,0],_frm] call ALiVE_fnc_HAC_WPadd;

_cause = [_logic,_unitG,6,true,250,30,[(_logic getvariable "HAC_HQ_AirG"),(_logic getvariable "HAC_HQ_KnEnemiesG")],false] call ALiVE_fnc_HAC_Wait;
_alive = _cause select 1;

if not (_alive) exitwith {if ((_logic getvariable "HAC_HQ_Debug") or (isPlayer (leader _unitG))) then {deleteMarker ("markRecon" + str (_unitG))}};
if ((count (waypoints _unitG)) >= 1) then {deleteWaypoint [_unitG, 1]};

    if (_stage >= 4) then {_logic setvariable ["HAC_HQ_ReconDone", true]};

if (_unitG in (_logic getvariable "HAC_HQ_FOG")) then
	{
	_beh = "STEALTH";
	if (_unitG in (_logic getvariable "HAC_HQ_RAirG")) then {_beh = "CARELESS"};
	_frm = formation _unitG;
	if not (isPlayer (leader _unitG)) then {_frm = "WEDGE"};

	_wp = [_logic,_unitG,[_posX,_posY],"MOVE",_beh,"GREEN","LIMITED",["true","deletewaypoint [(group this), 0];"],true,0.001,[0,0,0],_frm] call ALiVE_fnc_HAC_WPadd;

	_cause = [_logic,_unitG,6,true,150,120,[(_logic getvariable "HAC_HQ_AirG"),(_logic getvariable "HAC_HQ_KnEnemiesG")],false] call ALiVE_fnc_HAC_Wait;
	_timer = _cause select 0;
	_alive = _cause select 1;
	_enemy = _cause select 2
	};

if not (_alive) exitwith {if ((_logic getvariable "HAC_HQ_Debug") or (isPlayer (leader _unitG))) then {deleteMarker ("markRecon" + str (_unitG))}};
if ((_logic getvariable "HAC_HQ_Debug") or (isPlayer (leader _unitG))) then {_i setMarkerColor (_logic getvariable ["HAC_HQ_Color","ColorBlue"])};

[_unitG,_logic] call ALiVE_fnc_HAC_WPdel;

_timer2 = 0;

while {(_nothing)} do
	{
	_unitG = group (leader (_this select 0));
	if (((not (isNull (_UL findNearestEnemy _UL)) or (_timer2 > 4)) and not (isNull _unitG) and not (_unitG in (_logic getvariable "HAC_HQ_FOG"))) or ((_timer2 > 40) and not (isNull _unitG))) then 
		{
            if (_unitG in (_logic getvariable "HAC_HQ_NCrewInfG")) then {_pass orderGetIn true};
		sleep 15;
		_rd = 0;
		if (_unitG in (_logic getvariable "HAC_HQ_AirG")) then {_End = _PosLand;_rd = 0} else {_End = [((position _logic) select 0) + (random 400) - 200,((position _logic) select 1) + (random 400) - 200];_isWater = surfaceIsWater _End;if (_isWater) then {_End = [((position _logic) select 0) + (random 40) - 20,((position _logic) select 1) + (random 40) - 20]}};

		if (isPlayer (leader _unitG)) then
			{
			if not (isMultiplayer) then
				{
				_task setSimpleTaskDescription ["Return.", "Move", ""];
				_task setSimpleTaskDestination _End
				}
			else
				{
				[(leader _unitG),nil, "per", rSETSIMPLETASKDESTINATION, _task,_End] call RE;
				[(leader _unitG),nil, "per", rSETSIMPLETASKDESCRIPTION, _task,["Return.", "Move", ""]] call RE
				}
			};

		_beh = "SAFE";
		if (_unitG in (_logic getvariable "HAC_HQ_RAirG")) then {_beh = "CARELESS"};
		_sts = ["true", "deletewaypoint [(group this), 0];"];
		if (_unitG in (_logic getvariable "HAC_HQ_AirG")) then {_sts = ["true", "{(vehicle _x) land 'LAND'} foreach (units (group this));deletewaypoint [(group this), 0];"]};

		_wp = [_logic,_unitG,_End,"MOVE",_beh,"GREEN","NORMAL",_sts] call ALiVE_fnc_HAC_WPadd;

		_unitG setCurrentWaypoint _wp;
		if ((_logic getvariable "HAC_HQ_Debug") or (isPlayer (leader _unitG))) then {deleteMarker ("markRecon" + str (_unitG))};
		_nothing = false;

		_cause = [_logic,_unitG,6,true,0,24,[],false] call ALiVE_fnc_HAC_Wait;
		_alive = _cause select 1;

		if (_alive) then
			{
			if (_unitG in ((_logic getvariable "HAC_HQ_unitG") + (_logic getvariable "HAC_HQ_FOG") + (_logic getvariable "HAC_HQ_snipersG") + (_logic getvariable "HAC_HQ_InfG"))) then {_logic setvariable ["HAC_HQ_ReconAv",(_logic getvariable "HAC_HQ_ReconAv") + [_unitG]]};
			_unitG setVariable [("Busy" + (str _unitG)), false];
			[_unitG,_logic] call ALiVE_fnc_HAC_WPdel;
			if ((isPlayer (leader _unitG)) and not (isMultiplayer)) then {(leader _unitG) removeSimpleTask _task};
			}
		};

	sleep 15;
	if (isNull _unitG) then {_alive = false};
	if not (_alive) exitwith {if ((_logic getvariable "HAC_HQ_Debug") or (isPlayer (leader _unitG))) then {deleteMarker ("markRecon" + str (_unitG))}};
	_timer2 = _timer2 + 1;
	};

_UL = leader _unitG;if not (isPlayer _UL) then {if ((random 100) < (_logic getvariable "HAC_xHQ_AIChatDensity")) then {[_UL,(_logic getvariable "HAC_xHQ_AIC_OrdEnd"),"OrdEnd",_logic] call ALiVE_fnc_HAC_AIChatter}};
