_unitG = _this select 0;_Spos = _unitG getvariable ("START" + (str _unitG));if (isNil ("_Spos")) then {_unitG setVariable [("START" + (str _unitG)),(position (vehicle (leader _unitG)))];_Spos = _unitG getVariable ("START" + (str _unitG))}; 
_pos = position (leader _unitG);
_UL = leader _unitG;
_VLU = vehicle _UL;
_logic = _this select ((count _this)-1);

_AV = assignedVehicle _UL;

if not (isNull _AV) then
	{
	_GDV = group (assignedDriver _AV);
	if not (_GDV == _unitG) then
		{
		if not (_GDV in (_logic getvariable "HAC_HQ_Exhausted")) then
			{
			(units _unitG) orderGetIn false;
			{unassignVehicle _x} foreach (units _unitG);
			}
		}
	else
		{
			{
			if not ((group _x) == _unitG) then 
				{
				if not ((group _x) in (_logic getvariable "HAC_HQ_Exhausted")) then
					{
					[_x] ordergetIn false;
					unassignVehicle _x
					}
				} 
			}
		foreach (crew _AV);

		_ac = assignedCargo _AV;
		if ((count _ac) > 0) then
			{
				{
				if not ((group _x) == _unitG) then 
					{
					if not ((group _x) in (_logic getvariable "HAC_HQ_Exhausted")) then
						{
						[_x] ordergetIn false;
						unassignVehicle _x
						}
					}
				}
			foreach _ac
			}
		}
	};

if (_unitG in (_logic getvariable "HAC_HQ_Garrison")) exitwith {_logic setvariable ["HAC_HQ_Exhausted",(_logic getvariable "HAC_HQ_Exhausted") - [_unitG]]};

[_unitG,_logic] call ALiVE_fnc_HAC_WPdel;

_attackAllowed = attackEnabled _unitG;
//_unitG enableAttack false; 

_unitG setVariable [("Resting" + (str _unitG)),true];
_unitG setVariable [("Busy" + (str _unitG)), true];
_unitG setVariable [("Deployed" + (str _unitG)),false];
_unitG setVariable [("Capt" + (str _unitG)),false];

_nE = _UL findnearestenemy _UL;

if not (isNull _nE) then
	{
	if (((_logic getvariable "HAC_HQ_Smoke")) and ((_nE distance (vehicle _UL)) <= 500) and not (isPlayer _UL)) then
		{
		_posSL = getposASL _UL;
		_posSL2 = getposASL _nE;

		_angle = [_posSL,_posSL2,15,_logic] call ALiVE_fnc_HAC_AngTowards;

		_dstB = _posSL distance _posSL2;
		_pos = [_posSL,_angle,_dstB/4 + (random 100) - 50,_logic] call ALiVE_fnc_HAC_PosTowards2D;

		_CFF = false;

		if ((_logic getvariable "HAC_HQ_ArtyShells") > 0) then 
			{
			_CFF = ([_pos,(_logic getvariable "HAC_HQ_ArtG"),"SMOKE",9,_UL,_logic] call ALiVE_fnc_HAC_ArtyMission) select 0;
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

_Xpos = ((position _logic) select 0) + (random 500) - 250;
_Ypos = ((position _logic) select 1) + (random 500) - 250;

_posX = _Xpos;
_posY = _Ypos;

_isDecoy = false;
_enemyMatters = true;

if not (isNil "HAC_HQ_RestDecoy") then
	{
	_isDecoy = true;

	_tRadius = (triggerArea (_logic getvariable "HAC_HQ_RestDecoy")) select 0;

	if ((random 100) >= (_logic getvariable "HAC_HQ_RDChance")) exitWith {_isDecoy = false};

	_tPos = position (_logic getvariable "HAC_HQ_RestDecoy");
	_enemyMatters = (triggerArea (_logic getvariable "HAC_HQ_RestDecoy")) select 3;

	_posX = (_tPos select 0) + (random (2 * _tRadius)) - (_tRadius);
	_posY = (_tPos select 1) + (random (2 * _tRadius)) - (_tRadius);
	};

if not (_isDecoy) then 
	{
	_safedist = 1000/(0.75 + ((_logic getvariable "HAC_HQ_Recklessness")/2));
	_behind = false;
	_behind2 = false;
	if ((_logic getvariable "HAC_HQ_Cyclecount") > (4 + ((_logic distance (_logic getvariable "HAC_HQ_Obj"))/1000))) then {_behind2 = true};
	_counterU = 0;

		{
		_VL = vehicle (leader _x);
		if (((_VL distance (_logic getvariable "HAC_HQ_Obj")) < ([_Xpos,_Ypos] distance (_logic getvariable "HAC_HQ_Obj"))) or (((_VL distance (_logic getvariable "HAC_HQ_Obj")) < ([_Xpos,_Ypos] distance _VL)) and ((_VL distance (_logic getvariable "HAC_HQ_Obj")) < ((_logic getvariable "HAC_HQ_Obj") distance _VLU)))) then {_counterU = _counterU + 1};
		if ((_counterU >= (round (2/(0.5 + ((_logic getvariable "HAC_HQ_Recklessness")/2))))) or (_counterU >= ((count (_logic getvariable "HAC_HQ_Friends"))/(4*(0.5 + ((_logic getvariable "HAC_HQ_Recklessness")/2)))))) exitwith {_behind = true}
		}
	foreach (_logic getvariable "HAC_HQ_Friends");

	_Xpos2 = _Xpos;
	_Ypos2 = _Ypos;

	while {((((_logic getvariable "HAC_HQ_Obj") distance [_Xpos,_Ypos]) > _safedist) and (_behind2) and (_behind))} do
		{
		_Xpos3 = _Xpos2;
		_Ypos3 = _Ypos2;
		_behind2 = false;
		_counterU = 0;
		_Xpos2 = (_Xpos2 + ((position (_logic getvariable "HAC_HQ_Obj")) select 0))/2;
		_Ypos2 = (_Ypos2 + ((position (_logic getvariable "HAC_HQ_Obj")) select 1))/2;
		if not (((_logic getvariable "HAC_HQ_Obj") distance [_Xpos2,_Ypos2]) > _safedist) exitWith {_Xpos = _Xpos3;_Ypos = _Ypos3};

			{
			_VL = vehicle (leader _x);
			if (((_VL distance (_logic getvariable "HAC_HQ_Obj")) < ([_Xpos2,_Ypos2] distance (_logic getvariable "HAC_HQ_Obj"))) or (((_VL distance (_logic getvariable "HAC_HQ_Obj")) < ([_Xpos2,_Ypos2] distance _VL)) and ((_VL distance (_logic getvariable "HAC_HQ_Obj")) < ((_logic getvariable "HAC_HQ_Obj") distance _VLU)))) then {_counterU = _counterU + 1};
			if ((_counterU >= (round (2/(0.5 + ((_logic getvariable "HAC_HQ_Recklessness")/2))))) or (_counterU >= ((count (_logic getvariable "HAC_HQ_Friends"))/(4*(0.5 + ((_logic getvariable "HAC_HQ_Recklessness")/2)))))) exitwith {_behind2 = true}
			}
		foreach (_logic getvariable "HAC_HQ_Friends");
		if not (_behind2) exitwith {_Xpos = _Xpos3;_Ypos = _Ypos3};
		if (_behind2) then {_Xpos = _Xpos2;_Ypos = _Ypos2};
		};

	_posX = _Xpos;
	_posY = _Ypos;
	};

_isWater = true;
_counter = 0;

waituntil
	{
	_counter = _counter + 1;
	_isWater = surfaceIsWater [_posX,_posY];
	if (_iswater) then 
		{
		_posX = _posX + (random 500) - 250;
		_posY = _posY + (random 500) - 250;
		};

	(not (_isWater) and ((isNull (_logic FindNearestEnemy [_posX,_posY])) or (((_logic FindNearestEnemy [_posX,_posY]) distance [_posX,_posY]) >= 500) or not (_enemyMatters)) or (_counter > 30))
	};

if ((_counter > 30) or (not (isNull (_logic FindNearestEnemy [_posX,_posY])) and (((_logic FindNearestEnemy [_posX,_posY]) distance [_posX,_posY]) < 500) and (_enemyMatters))) then {_posX = ((position _logic) select 0) + (random 500) - 250;_posY = ((position _logic) select 1) + (random 500) - 250};

_isWater = surfaceIsWater [_posX,_posY];
if ((_isWater) or (not (isNull (_logic FindNearestEnemy [_posX,_posY])) and (((_logic FindNearestEnemy [_posX,_posY]) distance [_posX,_posY]) < 500) and (_enemyMatters))) exitwith {_unitG setVariable [("Resting" + (str _unitG)),false,true];_unitG setVariable [("Busy" + (str _unitG)), false, true];_logic setvariable ["HAC_HQ_Exhausted",(_logic getvariable "HAC_HQ_Exhausted") - [_unitG]]};

sleep 10;
if (_VLU == _UL) then {sleep 20};

if ((isPlayer (leader _unitG)) and ((_logic getvariable "HAC_xHQ_GPauseActive"))) then {hintC "New orders from HQ!";setAccTime 1};

_UL = leader _unitG;
_logic setvariable ["HAC_HQ_VCDone",false];
if (isPlayer _UL) then {[_UL,_logic,_logic] spawn ALiVE_fnc_HAC_VoiceComm;sleep 3;waituntil {sleep 0.1;(_logic getvariable "HAC_HQ_VCDone")}} else {if ((random 100) < (_logic getvariable "HAC_xHQ_AIChatDensity")) then {[_UL,(_logic getvariable "HAC_xHQ_AIC_OrdConf"),"OrdConf",_logic] call ALiVE_fnc_HAC_AIChatter}};

if ((_logic getvariable "HAC_HQ_Debug") or (isPlayer (leader _unitG))) then
	{
	_i = [[_posX,_posY],_unitG,"markRest",(_logic getvariable ["HAC_HQ_Color","ColorGreen"]),"ICON","mil_dot"," | ReGrp"," - REST & REGROUP",[0.5,0.5],_logic] call ALiVE_fnc_HAC_Mark
	};

_task = [(leader _unitG),["Take a rest, take care of wounded, replenish ammo and wait for orders.", "Move", ""],[_posX,_posY],_logic] call ALiVE_fnc_HAC_AddTask;

_lackAmmo = _unitG getVariable ["LackAmmo",false];
_counts = 6;
if (_lackAmmo) then 
	{
	_counts = 6.1
	};

_wp = [_logic,_unitG,[_posX,_posY],"MOVE","AWARE","GREEN","FULL",["true","deletewaypoint [(group this), 0]"]] call ALiVE_fnc_HAC_WPadd;

_cause = [_logic,_unitG,_counts,true,0,60,[],false] call ALiVE_fnc_HAC_Wait;
_timer = _cause select 0;
_alive = _cause select 1;

if not (_alive) exitwith {if ((_logic getvariable "HAC_HQ_Debug") or (isPlayer (leader _unitG))) then {deleteMarker ("markRest" + str (_unitG))};(_logic setvariable ["HAC_HQ_Exhausted",(_logic getvariable "HAC_HQ_Exhausted") - [_unitG]])};
if (_timer > 60) then {[_unitG, (currentWaypoint _unitG)] setWaypointPosition [position (vehicle _UL), 0]};

_UL = leader _unitG;if not (isPlayer _UL) then {if (_timer <= 60) then {if ((random 100) < (_logic getvariable "HAC_xHQ_AIChatDensity")) then {[_UL,(_logic getvariable "HAC_xHQ_AIC_OrdFinal"),"OrdFinal",_logic] call ALiVE_fnc_HAC_AIChatter}}};

waituntil 
	{
	sleep 60;
	_vehready = true;
	_solready = true;
	_effective = true;
	_ammo = true;
	_Gdamage = 0;
		{
		_Gdamage = _Gdamage + (damage _x);
		if ((count (magazines _x)) == 0) exitWith {_ammo = false};
		if (((damage _x) > 0.5) or not (canStand _x)) exitWith {_effective = false};
		}
	foreach (units _unitG);

	_nominal = _unitG getVariable ("Nominal" + (str _unitG));
	_current = count (units _unitG);
	_Gdamage = _Gdamage + (_nominal - _current);
	if (((_Gdamage/(_current + 0.1)) > (0.4*(((_logic getvariable "HAC_HQ_Recklessness")/1.2) + 1))) or not (_effective) or not (_ammo)) then {_solready = false};

		{
		_veh = assignedvehicle _x;
		if (not (isNull _veh) and (not (canMove _veh) or ((fuel _veh) <= 0.1) or ((damage _veh) > 0.5) or (((group _x) in (((_logic getvariable "HAC_HQ_AirG") - (_logic getvariable "HAC_HQ_NCAirG")) + ((_logic getvariable "HAC_HQ_HArmorG") + (_logic getvariable "HAC_HQ_LArmorG") + ((_logic getvariable "HAC_HQ_CarsG") - ((_logic getvariable "HAC_HQ_NCCargoG") + (_logic getvariable "HAC_HQ_SupportG")))))) and ((count (magazines _veh)) == 0)) and not ((group _x) in (_logic getvariable "HAC_HQ_RAirG")))) exitwith {_vehready = false};
		}
	foreach (units _unitG);
	(((_vehready) and (_solready)) || (({alive _x} count (units _unitG)) < 1));
	};

if ((isPlayer (leader _unitG)) and not (isMultiplayer)) then {(leader _unitG) removeSimpleTask _task};

if ((_logic getvariable "HAC_HQ_Debug") or (isPlayer (leader _unitG))) then {deleteMarker ("markRest" + str (_unitG))};
_logic setvariable ["HAC_HQ_Exhausted",(_logic getvariable "HAC_HQ_Exhausted") - [_unitG]];

if (_attackAllowed) then {_unitG enableAttack true};

_unitG setVariable [("Resting" + (str _unitG)),false];
_unitG setVariable [("Busy" + (str _unitG)), false];
_unitG setVariable ["LackAmmo",false];

_UL = leader _unitG;if not (isPlayer _UL) then {if ((random 100) < (_logic getvariable "HAC_xHQ_AIChatDensity")) then {[_UL,(_logic getvariable "HAC_xHQ_AIC_OrdEnd"),"OrdEnd",_logic] call ALiVE_fnc_HAC_AIChatter}};