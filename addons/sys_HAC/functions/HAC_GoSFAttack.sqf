_unitG = _this select 0;_Spos = _unitG getvariable ("START" + (str _unitG));if (isNil ("_Spos")) then {_unitG setVariable [("START" + (str _unitG)),(getposATL (vehicle (leader _unitG))),true]}; 
_Trg = _this select 1;
_trgPos = getposATL _Trg;
_trgG = _this select 2;
_logic = _this select ((count _this)-1);

if (_unitG in (_logic getvariable "HAC_HQ_Garrison")) exitwith {};
_ammo = [_unitG] call ALiVE_fnc_HAC_AmmoCount;

if (_ammo == 0) exitwith {};

_unitvar = str (_unitG);
_busy = false;
_busy = _unitG getvariable ("Busy" + _unitvar);
if (isNil ("_busy")) then {_busy = false};

if (_busy) exitwith {};

_default = [];
_Epos0 = [];
_Epos1 = [];

if (isNil {_logic getvariable "HAC_HQ_Obj"}) then {_default = position _logic} else {_default = position (_logic getvariable "HAC_HQ_Obj")};

if not ((count (_logic getvariable "HAC_HQ_KnEnemies")) == 0) then 
	{
		{
		_Epos0 = _Epos0 + [((getposATL _x) select 0)];
		_Epos1 = _Epos1 + [((getposATL _x) select 1)]
		}
	foreach (_logic getvariable "HAC_HQ_KnEnemies")
	};

_Epos0Max = _default select 0;
_Epos0Min = _default select 0;
_sel0Max = 0;
_sel0Min = 0;

for [{_a = 0},{_a < (count _Epos0)},{_a = _a + 1}] do 
	{
	_EposA = _Epos0 select _a;
	if (_a == 0) then {_Epos0Min = _EposA;_sel0Min = _a};
	if (_a == 0) then {_Epos0Max = _EposA;_sel0Max = _a};
	if (_Epos0Min >= _EposA) then {_Epos0Min = _EposA;_sel0Min = _a};
	if (_Epos0Max < _EposA) then {_Epos0Max = _EposA;_sel0Max = _a};
	};

_Epos1Max = _default select 1;
_Epos1Min = _default select 1;
_sel1Max = 1;
_sel1Min = 1;

for [{_b = 0},{_b < (count _Epos1)},{_b = _b + 1}] do 
	{
	_EposB = _Epos1 select _b;
	if (_b == 0) then {_Epos1Min = _EposB;_sel1Min = _b};
	if (_b == 0) then {_Epos1Max = _EposB;_sel1Max = _b};
	if (_Epos1Min >= _EposB) then {_Epos1Min = _EposB;_sel1Min = _b};
	if (_Epos1Max < _EposB) then {_Epos1Max = _EposB;_sel1Max = _b};
	};

_max0Enemy = _logic;
_min0Enemy = _logic;

_max1Enemy = _logic;
_min1Enemy = _logic;

if not (isNil {_logic getvariable "HAC_HQ_Obj"}) then 
	{
	_max0Enemy = (_logic getvariable "HAC_HQ_Obj");
	_min0Enemy = (_logic getvariable "HAC_HQ_Obj");

	_max1Enemy = (_logic getvariable "HAC_HQ_Obj");
	_min1Enemy = (_logic getvariable "HAC_HQ_Obj")
	};

if not ((count (_logic getvariable "HAC_HQ_KnEnemies")) == 0) then 
	{
	_max0Enemy = (_logic getvariable "HAC_HQ_KnEnemies") select _sel0Max;
	_min0Enemy = (_logic getvariable "HAC_HQ_KnEnemies") select _sel0Min;

	_max1Enemy = (_logic getvariable "HAC_HQ_KnEnemies") select _sel1Max;
	_min1Enemy = (_logic getvariable "HAC_HQ_KnEnemies") select _sel1Min
	};

_PosMid0 = (_Epos0Min + _Epos0Max)/2;
_PosMid1 = (_Epos1Min + _Epos1Max)/2;

_dX = (_PosMid0) - ((getposATL _logic) select 0);
_dY = (_Posmid1) - ((getposATL _logic) select 1);

_angle0 = _dX atan2 _dY;

if (_angle0 < 0) then {_angle0 = _angle0 + 360}; 

_BEnemyPosA = [];
_BEnemyPosB = [];
_BEnemyPos = [];

if ((_angle0 <= 45) or ((_angle0 > 135) and (_angle0 <= 225)) or (_angle0 > 315)) then {_BEnemyPosA = position _min0Enemy;_BEnemyPosB = position _max0Enemy} else {_BEnemyPosA = position _min1Enemy;_BEnemyPosB = position _max1Enemy};

_minF = false;
_maxF = false;

_BEnemyPos = _BEnemyPosA;
_MinSide = true;

_rnd = random 100;

if (_rnd < 50) then
	{
	_BEnemyPos = _BEnemyPosB;
	_MinSide = false
	};

_i1 = "";
_i2 = "";
_i3 = "";
_i4 = "";

_PosMidX = _PosMid0;
_PosMidY = _PosMid1;

_UL = leader _unitG;

_safeX1 = 0;
_safeY1 = 0;

_safeX2 = 0;
_safeY2 = 0;

_GposX = (getposATL (leader _unitG)) select 0;
_GposY = (getposATL (leader _unitG)) select 1;

_BEposX = _BEnemyPos select 0;
_BEposY = _BEnemyPos select 1;

_dX = _BEposX - ((getposATL _logic) select 0);
_dY = _BEposY - ((getposATL _logic) select 1);

_angle = _dX atan2 _dY;

if (_angle < 0) then {_angle = _angle + 360};  
_h = 1;
if ((_angle0 > 45) and (_angle0 <= 225)) then {_h = - 1};

_BorHQD = _logic distance _BEnemyPos;

_distanceSafe = 1000;

_safeX1 = _h * _distanceSafe * (cos _angle);
_safeY1 = _h * _distanceSafe * (sin _angle);

_safeX2 = _distanceSafe * (sin _angle);
_safeY2 = _distanceSafe * (cos _angle);

if (_MinSide) then {_safeX1 = - _safeX1} else {_safeY1 = - _safeY1};

_FlankPosX = _BorHQD * (sin _angle);
_FlankPosY = _BorHQD * (cos _angle);

_posXWP1 = ((getposATL _logic) select 0) + _FlankPosX + _safeX1 + (random 200) - 100;
_posYWP1 = ((getposATL _logic) select 1) + _FlankPosY + _safeY1 + (random 200) - 100;

_isWater = surfaceIsWater [_posXWP1,_posYWP1];

while {((_isWater) and (([_posXWP1,_posYWP1] distance _BEnemyPos) >= 300))} do
	{
	_posXWP1 = _posXWP1 - _safeX1/20;
	_posYWP1 = _posYWP1 - _safeY1/20;
	_isWater = surfaceIsWater [_posXWP1,_posYWP1];
	};

_isWater = surfaceIsWater [_posXWP1,_posYWP1];

if (_isWater) exitwith {_unitG setVariable [("Busy" + (str _unitG)),false]};

_posXWP2 = _posXWP1 + _safeX2 + (random 200) - 100;
_posYWP2 = _posYWP1 + _safeY2 + (random 200) - 100;

_isWater = surfaceIsWater [_posXWP2,_posYWP2];

while {((_isWater) and (([_posXWP2,_posYWP2] distance _BEnemyPos) >= 300))} do
	{
	_posXWP2 = _posXWP2 - _safeX2/20;
	_posYWP2 = _posYWP2 - _safeY2/20;
	_isWater = surfaceIsWater [_posXWP2,_posYWP2];
	};

_isWater = surfaceIsWater [_posXWP2,_posYWP2];

if (_isWater) exitwith {_unitG setVariable [("Busy" + (str _unitG)),false]};

_posXWP3 = _posXWP2 - (_safeX1/2) + (random 200) - 100;
_posYWP3 = _posYWP2 - (_safeY1/2) + (random 200) - 100;

_isWater = surfaceIsWater [_posXWP3,_posYWP3];

while {((_isWater) and (([_posXWP3,_posYWP3] distance _BEnemyPos) >= 300))} do
	{
	_posXWP3 = (_posXWP3 + (_BEnemyPos select 0))/2;
	_posYWP3 = (_posYWP3 + (_BEnemyPos select 1))/2;
	_isWater = surfaceIsWater [_posXWP3,_posYWP3];
	};

_isWater = surfaceIsWater [_posXWP3,_posYWP3];

if (_isWater) exitwith {_unitG setVariable [("Busy" + (str _unitG)),false]};

_posXWP4 = (_trgPos select 0) + (random 100) - 50;
_posYWP4 = (_trgPos select 1) + (random 100) - 50;

_isWater = surfaceIsWater [_posXWP4,_posYWP4];

while {((_isWater) and (([_posXWP4,_posYWP4] distance _BEnemyPos) >= 50))} do
	{
	_posXWP3 = (_posXWP4 + (_BEnemyPos select 0))/2;
	_posYWP3 = (_posYWP4 + (_BEnemyPos select 1))/2;
	_isWater = surfaceIsWater [_posXWP4,_posYWP4];
	};

_isWater = surfaceIsWater [_posXWP4,_posYWP4];

if (_isWater) exitwith {_unitG setVariable [("Busy" + (str _unitG)),false]};

if ((_logic distance [_posXWP1,_posYWP1]) > (_logic distance [_posXWP2,_posYWP2])) then 
	{
	_posXWP2 = _posXWP1 - _safeX2;
	_posYWP2 = _posYWP1 - _safeY2;

	_isWater = surfaceIsWater [_posXWP2,_posYWP2];

	while {((_isWater) and (([_posXWP2,_posYWP2] distance _BEnemyPos) >= 300))} do
		{
		_posXWP2 = _posXWP2 + _safeX2/20;
		_posYWP2 = _posYWP2 + _safeY2/20;
		_isWater = surfaceIsWater [_posXWP2,_posYWP2];
		};

	_isWater = surfaceIsWater [_posXWP2,_posYWP2];
	};

if (_isWater) exitwith {_unitG setVariable [("Busy" + (str _unitG)),false]};

if (((leader _unitG) distance [_posXWP2,_posYWP2]) < ((leader _unitG) distance [_posXWP1,_posYWP1])) then {_posXWP1 = _GposX;_posYWP1 = _GposY};

_task = taskNull;
if ((_ammo > 0) and not (_busy)) then
	{
	_unitG setVariable [("Deployed" + (str _unitG)),false];_unitG setVariable [("Capt" + (str _unitG)),false];
	_unitG setVariable [("Busy" + (str _unitG)),true];
	_veh = str (typeOf (Vehicle (leader (_unitG))));

	_logic setvariable ["HAC_HQ_SFTargets",(_logic getvariable "HAC_HQ_SFTargets") + [_trgG]];

	[_unitG,_logic] call ALiVE_fnc_HAC_WPdel;

	if ((isPlayer (leader _unitG)) and ((_logic getvariable "HAC_xHQ_GPauseActive"))) then {hintC "New orders from HQ!";setAccTime 1};

	_UL = leader _unitG;
	_logic setvariable ["HAC_HQ_VCDone",false];
	if (isPlayer _UL) then {[_UL,_logic,_logic] spawn ALiVE_fnc_HAC_VoiceComm;sleep 3;waituntil {sleep 0.1;(_logic getvariable "HAC_HQ_VCDone")}} else {if ((random 100) < (_logic getvariable "HAC_xHQ_AIChatDensity")) then {[_UL,(_logic getvariable "HAC_xHQ_AIC_OrdConf"),"OrdConf",_logic] call ALiVE_fnc_HAC_AIChatter}};

	
	if ((_logic getvariable "HAC_HQ_Debug") or (isPlayer (leader _unitG))) then 
		{
		_i1 = [[_posXWP1,_posYWP1],_unitG,"markSFFlank1",(_logic getvariable ["HAC_HQ_Color","ColorOrange"]),"ICON","mil_triangle"," | SF Flk 1"," - SF FLANK 1",[0.75,0.75],_logic] call ALiVE_fnc_HAC_Mark;
		_i2 = [[_posXWP2,_posYWP2],_unitG,"markSFFlank2",(_logic getvariable ["HAC_HQ_Color","ColorOrange"]),"ICON","mil_triangle"," | SF Flk 2"," - SF FLANK 2",[0.75,0.75],_logic] call ALiVE_fnc_HAC_Mark;
		_i3 = [[_posXWP3,_posYWP3],_unitG,"markSFFlank3",(_logic getvariable ["HAC_HQ_Color","ColorOrange"]),"ICON","mil_triangle"," | SF Flk 3"," - SF FLANK 3",[0.75,0.75],_logic] call ALiVE_fnc_HAC_Mark;
		_i4 = [[_posXWP4,_posYWP4],_unitG,"markSFFlank4",(_logic getvariable ["HAC_HQ_Color","ColorOrange"]),"ICON","mil_triangle"," | SF Flk 4"," - SF ATTACK",[0.75,0.75],_logic] call ALiVE_fnc_HAC_Mark
		};

	_CargoCheck = _unitG getvariable ("CC" + _unitvar);
	if (isNil ("_CargoCheck")) then {_unitG setVariable [("CC" + _unitvar), false]};
	_AV = assignedVehicle _UL;
	if (((_logic getvariable "HAC_HQ_CargoFind") > 0) and (isNull _AV) and (([_posXWP4,_posYWP4] distance (vehicle _UL)) > 1000)) then {[_unitG,_logic] spawn ALiVE_fnc_HAC_SCargo } else {_unitG setVariable [("CC" + _unitvar), true]};
	if ((_logic getvariable "HAC_HQ_CargoFind") > 0) then 
		{
		waituntil {sleep 0.05;(_unitG getvariable ("CC" + _unitvar))};
		_unitG setVariable [("CC" + _unitvar), false];
		};

	_AV = assignedVehicle _UL;
	_DAV = assigneddriver _AV;
	_GDV = group _DAV;
	_alive = false;
	_timer = 0;

	if (not (isNull _AV) and ((_logic getvariable "HAC_HQ_CargoFind") > 0)) then
		{
		_task = [(leader _unitG),["Wait and get into vehicle.", "GET IN", ""],(getposATL (leader _unitG)),_logic] call ALiVE_fnc_HAC_AddTask;

		_wp = [_logic,_unitG,_AV,"GETIN"] call ALiVE_fnc_HAC_WPadd;
		_wp waypointAttachVehicle _AV;
		_cause = [_logic,_unitG,1,false,0,900,[],true,false,true,false,false,false] call ALiVE_fnc_HAC_Wait;
		if ((_logic getvariable "HAC_HQ_LZ")) then {deleteVehicle (_AV getVariable ["TempLZ",objNull])};
		_timer = _cause select 0
		};

	if ((isPlayer (leader _unitG)) and not (isMultiplayer)) then {(leader _unitG) removeSimpleTask _task};
	if ((isNull (leader (_this select 0))) or (_timer > 900)) exitwith {if ((_logic getvariable "HAC_HQ_Debug") or (isPlayer (leader _unitG))) then {{deleteMarker _x} foreach [_i1,_i2,_i3,_i4]};if not (isNull _GDV) then {[_GDV, (currentWaypoint _GDV)] setWaypointPosition [getposATL (vehicle (leader _GDV)), 1];_GDV setVariable [("Busy" + _unitvar), false];}};

	_AV = assignedVehicle _UL;
	_DAV = assigneddriver _AV;
	_GDV = group _DAV;
	_wp1 = [];
	_wp2 = [];
	_wp3 = [];

	_task = [(leader _unitG),["Reach designated position. Try to avoid engaging in combat.", "Move", ""],[_posXWP1,_posYWP1],_logic] call ALiVE_fnc_HAC_AddTask;

	_Ctask = taskNull;
	if ((isPlayer (leader _GDV)) and not ((leader _GDV) == (leader _unitG))) then
		{
		_Ctask = [(leader _GDV),["Reach designated position. Try to avoid engaging in combat.", "Move", ""],[_posXWP1,_posYWP1],_logic] call ALiVE_fnc_HAC_AddTask
		};

	[_unitG,_logic] call ALiVE_fnc_HAC_WPdel;

	_grp = _unitG;
	if not (isNull _AV) then {_grp = _GDV};
	_beh = "AWARE";
	if (not (isNull _AV) and (_GDV in (_logic getvariable "HAC_HQ_AirG"))) then {_beh = "CARELESS"};
	_TO = [0,0,0];
	if ((isNull _AV) and (([_posXWP1,_posYWP1] distance _UL) > 1000)) then {_TO = [40, 45, 50]};
	_frm = formation _grp;
	if not (isPlayer (leader _grp)) then {_frm = "DIAMOND"};

	_wp1 = [_logic,_grp,[_posXWP1,_posYWP1],"MOVE",_beh,"GREEN","NORMAL",["true","deletewaypoint [(group this), 0];"],true,0,_TO,_frm] call ALiVE_fnc_HAC_WPadd;

	_DAV = assigneddriver _AV;
	_OtherGroup = false;
	_GDV = group _DAV;
	_enemy = false;

	if not (((group _DAV) == (group _UL)) or (isNull (group _DAV))) then 
		{
		_OtherGroup = true;

		_cause = [_logic,_GDV,6,true,300,30,[(_logic getvariable "HAC_HQ_AirG"),(_logic getvariable "HAC_HQ_KnEnemiesG")],true] call ALiVE_fnc_HAC_Wait;
		_timer = _cause select 0;
		_alive = _cause select 1;
		_enemy = _cause select 2
		}
	else 
		{
		_cause = [_logic,_unitG,6,true,300,30,[(_logic getvariable "HAC_HQ_AirG"),(_logic getvariable "HAC_HQ_KnEnemiesG")],false] call ALiVE_fnc_HAC_Wait;
		_timer = _cause select 0;
		_alive = _cause select 1;
		_enemy = _cause select 2
		};

	if (((_timer > 30) or (_enemy)) and (_OtherGroup)) then {if not (isNull _GDV) then {[_GDV, (currentWaypoint _GDV)] setWaypointPosition [getposATL (vehicle _UL), 1]}};
	if (((_timer > 30) or (_enemy)) and not (_OtherGroup)) then {[_unitG, (currentWaypoint _unitG)] setWaypointPosition [getposATL (vehicle _UL), 1]};
	if (not (_alive) and not (_OtherGroup)) exitwith {if ((_logic getvariable "HAC_HQ_Debug") or (isPlayer (leader _unitG))) then {{deleteMarker _x} foreach [_i1,_i2,_i3,_i4]}};
	if (isNull (leader (_this select 0))) exitwith {if ((_logic getvariable "HAC_HQ_Debug") or (isPlayer (leader _unitG))) then {{deleteMarker _x} foreach [_i1,_i2,_i3,_i4]};if not (isNull _GDV) then {[_GDV, (currentWaypoint _GDV)] setWaypointPosition [getposATL (vehicle (leader _GDV)), 1];_GDV setVariable [("Busy" + _unitvar), false];}};

	if (isPlayer (leader _unitG)) then
		{
		if not (isMultiplayer) then
			{
			_task setSimpleTaskDescription ["Reach designated position. Try to avoid engaging in combat.", "Move", ""];
			_task setSimpleTaskDestination [_posXWP2,_posYWP2]
			}
		else
			{
			[(leader _unitG),nil, "per", rSETSIMPLETASKDESTINATION, _task,[_posXWP2,_posYWP2]] call RE;
			[(leader _unitG),nil, "per", rSETSIMPLETASKDESCRIPTION, _task,["Reach designated position. Try to avoid engaging in combat.", "Move", ""]] call RE
			}
		};

	if ((isPlayer (leader _GDV)) and not ((leader _GDV) == (leader _unitG))) then
		{
		if not (isMultiplayer) then
			{
			_Ctask setSimpleTaskDescription ["Reach designated position. Try to avoid engaging in combat.", "Move", ""];
			_Ctask setSimpleTaskDestination [_posXWP2,_posYWP2]
			}
		else
			{
			[(leader _GDV),nil, "per", rSETSIMPLETASKDESTINATION, _Ctask,[_posXWP2,_posYWP2]] call RE;
			[(leader _GDV),nil, "per", rSETSIMPLETASKDESCRIPTION, _Ctask,["Reach designated position. Try to avoid engaging in combat.", "Move", ""]] call RE
			}
		};

	[_unitG,_logic] call ALiVE_fnc_HAC_WPdel;

	if ((_logic getvariable "HAC_HQ_Debug") or (isPlayer (leader _unitG))) then {_i1 setMarkerColor (_logic getvariable ["HAC_HQ_Color","ColorBlue"])};

	_grp = _unitG;
	if not (isNull _AV) then {_grp = _GDV};
	_beh = "AWARE";
	if (not (isNull _AV) and (_GDV in (_logic getvariable "HAC_HQ_AirG"))) then {_beh = "CARELESS"};
	_TO = [0,0,0];
	if ((isNull _AV) and (([_posXWP2,_posYWP2] distance _UL) > 1000)) then {_TO = [40, 45, 50]};
	_frm = formation _grp;
	if not (isPlayer (leader _grp)) then {_frm = "DIAMOND"};

	_wp2 = [_logic,_grp,[_posXWP2,_posYWP2],"MOVE",_beh,"GREEN","NORMAL",["true","deletewaypoint [(group this), 0];"],true,0,_TO,_frm] call ALiVE_fnc_HAC_WPadd;

	_DAV = assigneddriver _AV;
	_OtherGroup = false;
	_GDV = group _DAV;
	_enemy = false;

	if not (((group _DAV) == (group _UL)) or (isNull (group _DAV))) then 
		{
		_OtherGroup = true;

		_cause = [_logic,_GDV,6,true,300,30,[(_logic getvariable "HAC_HQ_AirG"),(_logic getvariable "HAC_HQ_KnEnemiesG")],true] call ALiVE_fnc_HAC_Wait;
		_timer = _cause select 0;
		_alive = _cause select 1;
		_enemy = _cause select 2
		}
	else 
		{
		_cause = [_logic,_unitG,6,true,300,30,[(_logic getvariable "HAC_HQ_AirG"),(_logic getvariable "HAC_HQ_KnEnemiesG")],false] call ALiVE_fnc_HAC_Wait;
		_timer = _cause select 0;
		_alive = _cause select 1;
		_enemy = _cause select 2
		};

	_DAV = assigneddriver _AV;
	if (((_timer > 30) or (_enemy)) and (_OtherGroup)) then {if not (isNull _GDV) then {[_GDV, (currentWaypoint _GDV)] setWaypointPosition [getposATL (vehicle _UL), 1]}};
	if (((_timer > 30) or (_enemy)) and not (_OtherGroup)) then {[_unitG, (currentWaypoint _unitG)] setWaypointPosition [getposATL (vehicle _UL), 1]};
	if (not (_alive) and not (_OtherGroup)) exitwith {if ((_logic getvariable "HAC_HQ_Debug") or (isPlayer (leader _unitG))) then {{deleteMarker _x} foreach [_i1,_i2,_i3,_i4]}};
	if (isNull (leader (_this select 0))) exitwith {if ((_logic getvariable "HAC_HQ_Debug") or (isPlayer (leader _unitG))) then {{deleteMarker _x} foreach [_i1,_i2,_i3,_i4]};if not (isNull _GDV) then {[_GDV, (currentWaypoint _GDV)] setWaypointPosition [getposATL (vehicle (leader _GDV)), 1];_GDV setVariable [("Busy" + _unitvar), false];}};

	if (isPlayer (leader _unitG)) then
		{
		if not (isMultiplayer) then
			{
			_task setSimpleTaskDescription ["Reach designated position. Try to avoid engaging in combat.", "Move", ""];
			_task setSimpleTaskDestination [_posXWP3,_posYWP3]
			}
		else
			{
			[(leader _unitG),nil, "per", rSETSIMPLETASKDESTINATION, _task,[_posXWP3,_posYWP3]] call RE;
			[(leader _unitG),nil, "per", rSETSIMPLETASKDESCRIPTION, _task,["Reach designated position. Try to avoid engaging in combat.", "Move", ""]] call RE
			}
		};

	if ((isPlayer (leader _GDV)) and not ((leader _GDV) == (leader _unitG))) then
		{
		if not (isMultiplayer) then
			{
			_Ctask setSimpleTaskDescription ["Disembark group at designated position.", "Move", ""];
			_Ctask setSimpleTaskDestination [_posXWP3,_posYWP3]
			}
		else
			{
			[(leader _GDV),nil, "per", rSETSIMPLETASKDESTINATION, _Ctask,[_posXWP3,_posYWP3]] call RE;
			[(leader _GDV),nil, "per", rSETSIMPLETASKDESCRIPTION, _Ctask,["Disembark group at designated position.", "Move", ""]] call RE
			}
		};

	[_unitG,_logic] call ALiVE_fnc_HAC_WPdel;

	if ((_logic getvariable "HAC_HQ_Debug") or (isPlayer (leader _unitG))) then {_i2 setMarkerColor (_logic getvariable ["HAC_HQ_Color","ColorBlue"])};

	_tp = "MOVE";
	//if (not (isNull _AV) and (_unitG in _logic getvariable "HAC_HQ_NCrewInfG") and not ((_GDV == _unitG) or (_GDV in (_logic getvariable "HAC_HQ_AirG")))) then {_tp = "UNLOAD"};
	_grp = _unitG;
	if not (isNull _AV) then {_grp = _GDV};
	_beh = "AWARE";
	_lz = objNull;
	if (not (isNull _AV) and (_GDV in (_logic getvariable "HAC_HQ_AirG"))) then 
		{
		_beh = "CARELESS";
		if ((_logic getvariable "HAC_HQ_LZ")) then
			{
			_lz = [[_posXWP3,_posYWP3],_logic] call ALiVE_fnc_HAC_LZ;
			if not (isNull _lz) then
				{
				_lzPos = getposATL _lz;
				_posXWP3 = _lzPos select 0;
				_posYWP3 = _lzPos select 1
				}
			};
            _i01 = [[_posXWP3,_posYWP3],_unitG,"markLZ",(_logic getvariable ["HAC_HQ_Color","ColorRed"]),"ICON","mil_dot","LZ","",_logic] call ALiVE_fnc_HAC_Mark;
		};

	_sts = ["true","deletewaypoint [(group this), 0];"];
	//if (((group (assigneddriver _AV)) in (_logic getvariable "HAC_HQ_AirG")) and (_unitG in _logic getvariable "HAC_HQ_NCrewInfG")) then {_sts = ["true","(vehicle this) land 'GET OUT';deletewaypoint [(group this), 0]"]};
	_TO = [0,0,0];
	if ((isNull _AV) and (([_posXWP3,_posYWP3] distance _UL) > 1000)) then {_TO = [40, 45, 50]};
	_frm = formation _grp;
	if not (isPlayer (leader _grp)) then {_frm = "DIAMOND"};

	_wp3 = [_logic,_grp,[_posXWP3,_posYWP3],_tp,_beh,"GREEN","NORMAL",_sts,true,0,_TO,_frm] call ALiVE_fnc_HAC_WPadd;

	_DAV = assigneddriver _AV;
	_OtherGroup = false;
	_GDV = group _DAV;
	_enemy = false;

	if not (((group _DAV) == (group _UL)) or (isNull (group _DAV))) then 
		{
		_OtherGroup = true;

		_cause = [_logic,_GDV,6,true,300,30,[(_logic getvariable "HAC_HQ_AirG"),(_logic getvariable "HAC_HQ_KnEnemiesG")],true] call ALiVE_fnc_HAC_Wait;
		_timer = _cause select 0;
		_alive = _cause select 1;
		_enemy = _cause select 2
		}
	else 
		{
		_cause = [_logic,_unitG,6,true,300,30,[(_logic getvariable "HAC_HQ_AirG"),(_logic getvariable "HAC_HQ_KnEnemiesG")],false] call ALiVE_fnc_HAC_Wait;
		_timer = _cause select 0;
		_alive = _cause select 1;
		_enemy = _cause select 2
		};

	if (((_timer > 30) or (_enemy)) and (_OtherGroup)) then {if not (isNull _GDV) then {[_GDV, (currentWaypoint _GDV)] setWaypointPosition [getposATL (vehicle (leader _GDV)), 1]}};
	if (((_timer > 30) or (_enemy)) and not (_OtherGroup)) then {[_unitG, (currentWaypoint _unitG)] setWaypointPosition [getposATL (vehicle _UL), 1]};
	if (not (_alive) and not (_OtherGroup)) exitwith {if ((_logic getvariable "HAC_HQ_Debug") or (isPlayer (leader _unitG))) then {{deleteMarker _x} foreach [_i1,_i2,_i3,_i4]}};
	if (isNull (leader (_this select 0))) exitwith {if ((_logic getvariable "HAC_HQ_Debug") or (isPlayer (leader _unitG))) then {{deleteMarker _x} foreach [_i1,_i2,_i3,_i4]};if not (isNull _GDV) then {[_GDV, (currentWaypoint _GDV)] setWaypointPosition [getposATL (vehicle (leader _GDV)), 1];_GDV setVariable [("Busy" + _unitvar), false];}};

	_AV = assignedVehicle _UL;
	_pass = assignedCargo _AV;
	_allowed = true;
	if not ((_GDV == _unitG) or (isNull _GDV)) then 
		{
		//{unassignVehicle _x} foreach (units _unitG);
		_pass orderGetIn false;
		_allowed = false;
		(units _unitG) allowGetIn false
		}
	else
		{
            if (_unitG in (_logic getvariable "HAC_HQ_NCrewInfG")) then {_pass orderGetIn false};
		};

	_DAV = assigneddriver _AV;
	_GDV = group _DAV;

        if (not (isNull _AV) and ((_logic getvariable "HAC_HQ_CargoFind") > 0) and (_unitG in (_logic getvariable "HAC_HQ_NCrewInfG"))) then
		{	
		_cause = [_logic,_unitG,1,false,0,240,[],true,true,false,false,false,false] call ALiVE_fnc_HAC_Wait;
		_timer = _cause select 0
		};

	if not (_allowed) then {(units _unitG) allowGetIn true};

	if ((_logic getvariable "HAC_HQ_LZ")) then {deleteVehicle _lz};

	if not ((_GDV == _unitG) or (isNull _GDV)) then 
		{
		{unassignVehicle _x} foreach (units _unitG);
		};

	if ((isPlayer (leader _GDV)) and not (isMultiplayer)) then {(leader _GDV) removeSimpleTask _Ctask};
	if ((isNull (leader (_this select 0))) or (_timer > 240)) exitwith {if ((_logic getvariable "HAC_HQ_Debug") or (isPlayer (leader _unitG))) then {{deleteMarker _x} foreach [_i1,_i2,_i3,_i4]};if not (isNull _GDV) then {[_GDV, (currentWaypoint _GDV)] setWaypointPosition [getposATL (vehicle (leader _GDV)), 1];_GDV setVariable [("Busy" + _unitvar), false];_pass orderGetIn true}};

	_unitvar = str _GDV;
	_timer = 0;
	if (not (isNull _GDV) and (_GDV in (_logic getvariable "HAC_HQ_AirG")) and not (isPlayer (leader _GDV))) then
		{
		_wp = [_logic,_GDV,[((position _AV) select 0) + (random 200) - 100,((position _AV) select 1) + (random 200) - 100,1000],"MOVE","CARELESS","GREEN","NORMAL"] call ALiVE_fnc_HAC_WPadd;

		_cause = [_logic,_GDV,3,true,0,8,[],false] call ALiVE_fnc_HAC_Wait;
		_timer = _cause select 0;

		if (_timer > 8) then {[_GDV, (currentWaypoint _GDV)] setWaypointPosition [getposATL (vehicle (leader _GDV)), 1]};
		};

	_GDV setVariable [("CargoM" + _unitvar), false];

	if (isPlayer (leader _unitG)) then
		{
		if not (isMultiplayer) then
			{
			_task setSimpleTaskDescription ["Eliminate enemy at designated position.", "Eliminate", ""];
			_task setSimpleTaskDestination [_posXWP4,_posYWP4]
			}
		else
			{
			[(leader _unitG),nil, "per", rSETSIMPLETASKDESTINATION, _task,[_posXWP4,_posYWP4]] call RE;
			[(leader _unitG),nil, "per", rSETSIMPLETASKDESCRIPTION, _task,["Eliminate enemy at designated position.", "Eliminate", ""]] call RE
			}
		};

	[_unitG,_logic] call ALiVE_fnc_HAC_WPdel;

	if ((_logic getvariable "HAC_HQ_Debug") or (isPlayer (leader _unitG))) then {_i3 setMarkerColor (_logic getvariable ["HAC_HQ_Color","ColorBlue"])};

	if not (isPlayer (leader _unitG)) then 
		{
		_frm = "WEDGE";

		_posXWP35 = (_posXWP3 + _posXWP4)/2;
		_posYWP35 = (_posYWP3 + _posYWP4)/2;

		_wp35 = [_logic,_unitG,[_posXWP35,_posYWP35],"MOVE","STEALTH","GREEN","NORMAL",["true","deletewaypoint [(group this), 0];"],true,50,[50,55,60],_frm] call ALiVE_fnc_HAC_WPadd;

		_cause = [_logic,_unitG,6,true,0,300,[],false] call ALiVE_fnc_HAC_Wait;
		_timer = _cause select 0;
		_alive = _cause select 1;

		if not (_alive) exitwith 
			{
			if ((_logic getvariable "HAC_HQ_Debug") or (isPlayer (leader _unitG))) then 
				{
					{
					deleteMarker _x
					}
				foreach [_i1,_i2,_i3,_i4]
				}
			};

		if (_timer > 300) then {[_unitG, (currentWaypoint _unitG)] setWaypointPosition [position (vehicle _UL), 0];[_unitG,_logic] call ALiVE_fnc_HAC_ResetAI};
		};

	_beh = "COMBAT";
	_spd = "NORMAL";

	_frm = formation _unitG;
	if not (isPlayer (leader _unitG)) then {_frm = "WEDGE"};

	_UL = leader _unitG;if not (isPlayer _UL) then {if (_timer <= 300) then {if ((random 100) < (_logic getvariable "HAC_xHQ_AIChatDensity")) then {[_UL,(_logic getvariable "HAC_xHQ_AIC_OrdFinal"),"OrdFinal",_logic] call ALiVE_fnc_HAC_AIChatter}}};

	_wp4 = [_logic,_unitG,[_posXWP4,_posYWP4],"MOVE",_beh,"RED",_spd,["true","deletewaypoint [(group this), 0];"],true,200,[0,0,0],_frm] call ALiVE_fnc_HAC_WPadd;
	_wp4 waypointAttachVehicle _Trg;
	_wp4 setWaypointType "DESTROY";

	_cause = [_logic,_unitG,6,true,0,300,[],false] call ALiVE_fnc_HAC_Wait;
	_timer = _cause select 0;
	_alive = _cause select 1;

	if not (_alive) exitwith 
		{
		if ((_logic getvariable "HAC_HQ_Debug") or (isPlayer (leader _unitG))) then 
			{
				{
				deleteMarker _x
				}
			foreach [_i1,_i2,_i3,_i4]
			}
		};

	if (_timer > 300) then {[_unitG, (currentWaypoint _unitG)] setWaypointPosition [position (vehicle _UL), 0];[_unitG,_logic] call ALiVE_fnc_HAC_ResetAI};

	if ((_logic getvariable "HAC_HQ_Debug") or (isPlayer (leader _unitG))) then 
		{
			{
			deleteMarker _x
			}
		foreach [_i4]
		};

	if (isPlayer (leader _unitG)) then
		{
		if not (isMultiplayer) then
			{
			_task setSimpleTaskDescription ["Return.", "Move", ""];
			_task setSimpleTaskDestination [_posXWP3,_posYWP3]
			}
		else
			{
			[(leader _unitG),nil, "per", rSETSIMPLETASKDESTINATION, _task,[_posXWP3,_posYWP3]] call RE;
			[(leader _unitG),nil, "per", rSETSIMPLETASKDESCRIPTION, _task,["Return.", "Move", ""]] call RE
			}
		};

	_beh = "AWARE";
	_spd = "NORMAL";

	_frm = formation _unitG;
	if not (isPlayer (leader _unitG)) then {_frm = "DIAMOND"};

	_wp5 = [_logic,_unitG,[_posXWP3,_posYWP3],"MOVE",_beh,"GREEN",_spd,["true","deletewaypoint [(group this), 0];"],true,20,[0,0,0],_frm] call ALiVE_fnc_HAC_WPadd;

	_cause = [_logic,_unitG,6,true,0,30,[],false] call ALiVE_fnc_HAC_Wait;
	_timer = _cause select 0;
	_alive = _cause select 1;

	if not (_alive) exitwith 
		{
		if ((_logic getvariable "HAC_HQ_Debug") or (isPlayer (leader _unitG))) then 
			{
				{
				deleteMarker _x
				}
			foreach [_i1,_i2,_i3]
			}
		};

	if ((_logic getvariable "HAC_HQ_Debug") or (isPlayer (leader _unitG))) then 
		{
			{
			deleteMarker _x
			}
		foreach [_i3]
		};

	if (isPlayer (leader _unitG)) then
		{
		if not (isMultiplayer) then
			{
			_task setSimpleTaskDestination [_posXWP2,_posYWP2]
			}
		else
			{
			[(leader _unitG),nil, "per", rSETSIMPLETASKDESTINATION, _task,[_posXWP2,_posYWP2]] call RE
			}
		};

	_wp6 = [_logic,_unitG,[_posXWP2,_posYWP2],"MOVE",_beh,"GREEN",_spd,["true","deletewaypoint [(group this), 0];"],true,20,[0,0,0],_frm] call ALiVE_fnc_HAC_WPadd;

	_cause = [_logic,_unitG,6,true,0,30,[],false] call ALiVE_fnc_HAC_Wait;
	_timer = _cause select 0;
	_alive = _cause select 1;

	if not (_alive) exitwith 
		{
		if ((_logic getvariable "HAC_HQ_Debug") or (isPlayer (leader _unitG))) then 
			{
				{
				deleteMarker _x
				}
			foreach [_i1,_i2]
			}
		};

	if ((_logic getvariable "HAC_HQ_Debug") or (isPlayer (leader _unitG))) then 
		{
			{
			deleteMarker _x
			}
		foreach [_i2]
		};

	if (isPlayer (leader _unitG)) then
		{
		if not (isMultiplayer) then
			{
			_task setSimpleTaskDestination [_posXWP1,_posYWP1]
			}
		else
			{
			[(leader _unitG),nil, "per", rSETSIMPLETASKDESTINATION, _task,[_posXWP1,_posYWP1]] call RE
			}
		};

	_wp7 = [_logic,_unitG,[_posXWP1,_posYWP1],"MOVE",_beh,"GREEN",_spd,["true","deletewaypoint [(group this), 0];"],true,20,[0,0,0],_frm] call ALiVE_fnc_HAC_WPadd;

	_cause = [_logic,_unitG,6,true,0,30,[],false] call ALiVE_fnc_HAC_Wait;
	_timer = _cause select 0;
	_alive = _cause select 1;

	if not (_alive) exitwith 
		{
		if ((_logic getvariable "HAC_HQ_Debug") or (isPlayer (leader _unitG))) then 
			{
				{
				deleteMarker _x
				}
			foreach [_i1]
			}
		};

	if ((_logic getvariable "HAC_HQ_Debug") or (isPlayer (leader _unitG))) then 
		{
			{
			deleteMarker _x
			}
		foreach [_i1]
		};

	if ((isPlayer (leader _unitG)) and not (isMultiplayer)) then {(leader _unitG) removeSimpleTask _task};
	_unitG setVariable [("Busy" + _unitvar), false];

	_UL = leader _unitG;if not (isPlayer _UL) then {if ((random 100) < (_logic getvariable "HAC_xHQ_AIChatDensity")) then {[_UL,(_logic getvariable "HAC_xHQ_AIC_OrdEnd"),"OrdEnd",_logic] call ALiVE_fnc_HAC_AIChatter}};
	};	
