_i = "";

_logic = _this select ((count _this)-1);
_unitG = _this select 0;_Spos = _unitG getvariable ("START" + (str _unitG));if (isNil ("_Spos")) then {_unitG setVariable [("START" + (str _unitG)),(position (vehicle (leader _unitG)))];_Spos = _unitG getVariable ("START" + (str _unitG))}; 
_DefPos = _this select 1;if (_unitG in (_logic getvariable "HAC_HQ_Garrison")) exitwith {_logic setvariable ["HAC_HQ_RecDefSpot", (_logic getvariable "HAC_HQ_RecDefSpot") - [_unitG]];_logic setvariable ["HAC_HQ_GoodSpots", (_logic getvariable "HAC_HQ_GoodSpots") + [_DefPos]];_logic setvariable ["HAC_HQ_Roger", true]};
_angleV = _this select 2;


_ammo = [_unitG] call ALiVE_fnc_HAC_AmmoCount;

if (_ammo == 0) exitwith {_logic setvariable ["HAC_HQ_RecDefSpot", (_logic getvariable "HAC_HQ_RecDefSpot") - [_unitG]];_logic setvariable ["HAC_HQ_GoodSpots", (_logic getvariable "HAC_HQ_GoodSpots") + [_DefPos]];_logic setvariable ["HAC_HQ_Roger", true]};

_unitvar = str _unitG;
_busy = false;
_busy = _unitG getvariable ("Busy" + _unitvar);

if (isNil ("_busy")) then {_busy = false};

if ((_busy) and (_unitG in (_logic getvariable "HAC_HQ_RecDefSpot"))) exitwith {_logic setvariable ["HAC_HQ_Roger", true]};

[_unitG,_logic] call ALiVE_fnc_HAC_WPdel;

_attackAllowed = attackEnabled _unitG;
_unitG enableAttack false; 

_unitG setVariable [("Deployed" + (str _unitG)),false];_unitG setVariable [("Capt" + (str _unitG)),false];
_unitG setVariable [("Busy" + _unitvar), true];
_unitG setVariable ["Defending", true];

_posX = (_DefPos select 0) + (random 40) - 20;
_posY = (_DefPos select 1) + (random 40) - 20;
_DefPos = [_posX,_posY];

_isWater = surfaceIsWater _DefPos;

while {((_isWater) and (_logic distance _DefPos >= 10))} do
	{
	_PosX = ((_DefPos select 0) + ((position _logic) select 0))/2; 
	_PosY = ((_DefPos select 1) + ((position _logic) select 1))/2;
	_DefPos = [_posX,_posY]
	};

_isWater = surfaceIsWater _DefPos;
if (_isWater) exitwith {_logic setvariable ["HAC_HQ_RecDefSpot", (_logic getvariable "HAC_HQ_RecDefSpot") - [_unitG]];_logic setvariable ["HAC_HQ_Roger", true];_unitG setVariable [("Busy" + (str _unitG)),false]};

if ((isPlayer (leader _unitG)) and ((_logic getvariable "HAC_xHQ_GPauseActive"))) then {hintC "New orders from HQ!";setAccTime 1};

_UL = leader _unitG;

_logic setvariable ["HAC_HQ_Roger", true];

_nE = _UL findnearestenemy _UL;

if not (isNull _nE) then
	{
	if (((_logic getvariable "HAC_HQ_Smoke")) and ((_nE distance (vehicle _UL)) <= 500) and not (isPlayer _UL)) then
		{
		_posSL = getPosASL _UL;
		_posSL2 = getPosASL _nE;

		_angle = [_posSL,_posSL2,15,_logic] call ALiVE_fnc_HAC_AngTowards;

		_dstB = _posSL distance _posSL2;
		_pos = [_posSL,_angle,_dstB/4 + (random 100) - 50,_logic] call ALiVE_fnc_HAC_PosTowards2D;

		_CFF = false;

		if ((_logic getvariable "HAC_HQ_ArtyShells") > 0) then 
			{
			_CFF = ([_pos,HAC_HQ_ArtG,"SMOKE",9,_UL,_logic] call ALiVE_fnc_HAC_ArtyMission) select 0;
			if not (isPlayer _UL) then {if ((random 100) < (_logic getvariable "HAC_xHQ_AIChatDensity")) then {[_UL,(_logic getvariable "HAC_xHQ_AIC_SmokeReq"),"SmokeReq",_logic] call ALiVE_fnc_HAC_AIChatter}};
			};

		if (_CFF) then 
			{
			if ((_logic getvariable "HAC_HQ_ArtyShells") > 0) then {if ((random 100) < (_logic getvariable "HAC_xHQ_AIChatDensity")) then {[_logic,(_logic getvariable "HAC_xHQ_AIC_ArtAss"),"ArtAss",_logic] call ALiVE_fnc_HAC_AIChatter}};
			sleep 60
			}
		else
			{
			if ((_logic getvariable "HAC_HQ_ArtyShells") > 0) then {if ((random 100) < (_logic getvariable "HAC_xHQ_AIChatDensity")) then {[_logic,(_logic getvariable "HAC_xHQ_AIC_ArtDen"),"ArtDen",_logic] call ALiVE_fnc_HAC_AIChatter}};
			[_unitG,_logic] call ALiVE_fnc_HAC_Smoke;
			sleep 10;
			if ((vehicle _UL) == _UL) then {sleep 20}
			}
		}
	};

_UL = leader _unitG;
_logic setvariable ["HAC_HQ_VCDone",false];
if (isPlayer _UL) then {[_UL,_logic,_logic] spawn ALiVE_fnc_HAC_VoiceComm;sleep 3;waituntil {sleep 0.1;(_logic getvariable "HAC_HQ_VCDone")}} else {if ((random 100) < (_logic getvariable "HAC_xHQ_AIChatDensity")) then {[_UL,(_logic getvariable "HAC_xHQ_AIC_OrdConf"),"OrdConf",_logic] call ALiVE_fnc_HAC_AIChatter}};

if ((_logic getvariable "HAC_HQ_Debug") or (isPlayer (leader _unitG))) then 
	{
	_i = [_DefPos,_unitG,"markDef","ColorBrown","ICON","mil_dot","Rec A"," - WATCH FOREGROUND",_logic] call ALiVE_fnc_HAC_Mark
	};

_task = [(leader _unitG),["Take a defensive, elevated position as fast, as possible. Then observe foreground and search for enemy targets.", "Sentry", ""],_DefPos,_logic] call ALiVE_fnc_HAC_AddTask;

_frm = formation _unitG;
if not (isPlayer (leader _unitG)) then {_frm = "FILE"};

_wp = [_logic,_unitG,_DefPos,_tp,"AWARE","GREEN","FULL",["true","deletewaypoint [(group this), 0];"],true,0.001,[0,0,0],_frm] call ALiVE_fnc_HAC_WPadd;

_cause = [_logic,_unitG,6,true,0,24,[],false] call ALiVE_fnc_HAC_Wait;
_alive = _cause select 1;

if not (_alive) exitwith {if ((_logic getvariable "HAC_HQ_Debug") or (isPlayer (leader _unitG))) then {deleteMarker ("markDef" + str (_unitG))};_logic setvariable ["HAC_HQ_RecDefSpot", (_logic getvariable "HAC_HQ_RecDefSpot") - [_unitG]]};

_frm = formation _unitG;
if not (isPlayer (leader _unitG)) then {_frm = "WEDGE"};

_wp = [_logic,_unitG,_DefPos,"SENTRY","STEALTH","YELLOW","FULL",["true","deletewaypoint [(group this), 0];"],true,0.001,[0,0,0],_frm] call ALiVE_fnc_HAC_WPadd;

_TED = position _logic;

_dX = 2000 * (sin _angleV);
_dY = 2000 * (cos _angleV);

_posX = ((getPos _logic) select 0) + _dX + (random 2000) - 1000;
_posY = ((getPos _logic) select 1) + _dY + (random 2000) - 1000;

_TED = [_posX,_posY];

if ((_logic getvariable "HAC_HQ_Debug") or (isPlayer (leader _unitG))) then 
	{
	_i = [_TED,_unitG,"markWatch","ColorGreen","ICON","mil_dot","A","A",[0.2,0.2],_logic] call ALiVE_fnc_HAC_Mark
	};

_dir = [(getPosATL (vehicle (leader _unitG))),_TED,10,_logic] call ALiVE_fnc_HAC_AngTowards;
if (_dir < 0) then {_dir = _dir + 360};

_unitG setFormDir _dir;
(units _unitG) doWatch _TED;

_UL = leader _unitG;if not (isPlayer _UL) then {if ((random 100) < HAC_xHQ_AIChatDensity) then {[_UL,HAC_xHQ_AIC_OrdFinal,"OrdFinal",_logic] call ALiVE_fnc_HAC_AIChatter}};

[_unitG,(_logic getvariable "HAC_HQ_Flare"),(_logic getvariable "HAC_HQ_ArtG"),(_logic getvariable "HAC_HQ_ArtyShells"),_logic,_logic] spawn ALiVE_fnc_HAC_Flares;

_alive = true;

waituntil 
	{
	sleep 10;
	_endThis = false;
	if not (_unitG getVariable "Defending") then {_endThis = true};
	if (isNull _unitG) then {_endThis = true;_alive = false};
	if not (alive (leader _unitG)) then {_endThis = true;_alive = false};
	(_endThis)
	};

if not (_alive) exitWith 
	{
	if ((_logic getvariable "HAC_HQ_Debug") or (isPlayer (leader _unitG))) then {deleteMarker ("markDef" + _unitVar);deleteMarker ("markWatch" + _unitVar)};
	_logic setvariable ["HAC_HQ_RecDefSpot", (_logic getvariable "HAC_HQ_RecDefSpot") - [_unitG]]
	};

if ((isPlayer (leader _unitG)) and not (isMultiplayer)) then {(leader _unitG) removeSimpleTask _task};

if ((_logic getvariable "HAC_HQ_Debug") or (isPlayer (leader _unitG))) then {deleteMarker ("markDef" + (str _unitG));deleteMarker ("markWatch" + (str _unitG))};

(units _unitG) doWatch ObjNull;

if (_attackAllowed) then {_unitG enableAttack true};

_logic setvariable ["HAC_HQ_RecDefSpot", (_logic getvariable "HAC_HQ_RecDefSpot") - [_unitG]];

_unitG setVariable [("Busy" + _unitvar), false];

_UL = leader _unitG;if not (isPlayer _UL) then {if ((random 100) < (_logic getvariable "HAC_xHQ_AIChatDensity")) then {[_UL,(_logic getvariable "HAC_xHQ_AIC_OrdEnd"),"OrdEnd",_logic] call ALiVE_fnc_HAC_AIChatter}};