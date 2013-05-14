_i = "";

_unit = _this select 0;
_Trg = _this select 1;
_wounded = _this select 2;
_logic = _this select ((count _this)-1);

_logic setvariable ["HAC_HQ_MedPoints",(_logic getvariable "HAC_HQ_MedPoints") + [_Trg]];

_startpos = position _unit;

_unitG = group _unit;

_amb = assignedvehicle (leader (_unitG));

_amb disableAI "TARGET";_amb disableAI "AUTOTARGET";

[_unitG,_logic] call ALiVE_fnc_HAC_WPdel;

(group (assigneddriver _unit)) setVariable [("Deployed" + (str (group (assigneddriver _unit)))),false,true];
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

_alive = false;

if ((isPlayer (leader _unitG)) and ((_logic getvariable "HAC_xHQ_GPauseActive"))) then {hintC "New orders from HQ!";setAccTime 1};

_UL = leader _unitG;
_logic setvariable ["HAC_HQ_VCDone",false];
if (isPlayer _UL) then {[_UL,_logic,_logic] spawn ALiVE_fnc_HAC_VoiceComm;sleep 3;waituntil {sleep 0.1;(_logic getvariable "HAC_HQ_VCDone")}} else {if ((random 100) < (_logic getvariable "HAC_xHQ_AIChatDensity")) then {[_UL,(_logic getvariable "HAC_xHQ_AIC_OrdConf"),"OrdConf",_logic] call ALiVE_fnc_HAC_AIChatter}};

if ((_logic getvariable "HAC_HQ_Debug") or (isPlayer (leader _unitG))) then 
	{
	_i = [[_posX,_posY],_unitG,"markMedSupp","ColorKhaki","ICON","Destroy"," Medic A"," - MEDICAL SUPPORT",[0.6,0.6],_logic] call ALiVE_fnc_HAC_Mark
	};

_task = [(leader _unitG),["Give medical aid nearby troops. Stay in this area.", "Support", ""],[_posX,_posY],_logic] call ALiVE_fnc_HAC_AddTask;

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
				[(leader _unitG),nil, "per", rSETSIMPLETASKDESTINATION, _task,[_posX,_posY]] call RE
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

	if not (_alive) exitwith {if ((_logic getvariable "HAC_HQ_Debug") or (isPlayer (leader _unitG))) then {deleteMarker ("markMedSupp" + str (_unitG))};_logic setvariable ["HAC_HQ_MedPoints",(_logic getvariable "HAC_HQ_MedPoints") - [_Trg]];_unitG setVariable [("Busy" + _unitvar), false];};
	if (_timer > 24) then {_counter = _counter + 1;[_unitG, (currentWaypoint _unitG)] setWaypointPosition [position (vehicle (leader _unitG)), 0]} else {_counter = _counter + 1}; 

	_UL = leader _unitG;if not (isPlayer _UL) then {if ((_timer <= 24) and (_counter == 1)) then {if ((random 100) < (_logic getvariable "HAC_xHQ_AIChatDensity")) then {[_UL,(_logic getvariable "HAC_xHQ_AIC_OrdFinal"),"OrdFinal",_logic] call ALiVE_fnc_HAC_AIChatter}}};

	if (((damage _Trg) < 0.1) or ((damage _Trg) >= 0.9) or (isNull (group (_this select 1)))) then {_wounded = _wounded - [_Trg]};
	};

if not (_alive) exitwith {if ((_logic getvariable "HAC_HQ_Debug") or (isPlayer (leader _unitG))) then {deleteMarker ("markMedSupp" + str (_unitG))};_logic setvariable ["HAC_HQ_MedPoints",(_logic getvariable "HAC_HQ_MedPoints") - [_Trg]];_unitG setVariable [("Busy" + _unitvar), false];};
[_unitG, (currentWaypoint _unitG)] setWaypointPosition [position (vehicle (leader _unitG)), 0];

_tp = "MOVE";
if (_logic getvariable "HAC_HQ_SupportWP") then {_tp = "SUPPORT"};

_wp = [_logic,_unitG,[_posX,_posY],_tp,"SAFE","BLUE","FULL",["true","{(vehicle _x) land 'LAND'} foreach (units (group this));deletewaypoint [(group this), 0]"]] call ALiVE_fnc_HAC_WPadd;

_cause = [_logic,_unitG,6,true,0,24,[],true,true,true,true] call ALiVE_fnc_HAC_Wait;
_timer = _cause select 0;
_alive = _cause select 1;

if not (_alive) exitwith {if ((_logic getvariable "HAC_HQ_Debug") or (isPlayer (leader _unitG))) then {deleteMarker ("markMedSupp" + str (_unitG))};_logic setvariable ["HAC_HQ_MedPoints",(_logic getvariable "HAC_HQ_MedPoints") - [_Trg]];_unitG setVariable [("Busy" + _unitvar), false];};
if (_timer > 24) then {[_unitG, (currentWaypoint _unitG)] setWaypointPosition [position (vehicle _UL), 0]}; 

_logic setvariable ["HAC_HQ_MedPoints",(_logic getvariable "HAC_HQ_MedPoints") - [_Trg]];
if ((isPlayer (leader _unitG)) and not (isMultiplayer)) then {(leader _unitG) removeSimpleTask _task};

_amb enableAI "TARGET";_amb enableAI "AUTOTARGET";
_unitG setVariable [("Busy" + _unitvar), false];

if (((damage _Trg) < 0.1) or ((damage _Trg) >= 0.9) or (isNull (group (_this select 1)))) then {_wounded = _wounded - [_Trg]};
if ((_logic getvariable "HAC_HQ_Debug") or (isPlayer (leader _unitG))) then {deleteMarker ("markMedSupp" + str (_unitG))};
_lastOne = true;

	{
	if (((group _x) == (group _Trg)) and not (_x == _Trg)) exitwith {_lastOne = false};
	}
foreach _wounded;
_logic setvariable ["HAC_HQ_SupportedG",(_logic getvariable "HAC_HQ_SupportedG") - [(group _Trg)]];
if (_lastOne) then {_logic setvariable ["HAC_HQ_SupportedG",(_logic getvariable "HAC_HQ_SupportedG") - [(group _Trg)]]};

_UL = leader _unitG;if not (isPlayer _UL) then {if ((random 100) < (_logic getvariable "HAC_xHQ_AIChatDensity")) then {[_UL,(_logic getvariable "HAC_xHQ_AIC_OrdEnd"),"OrdEnd",_logic] call ALiVE_fnc_HAC_AIChatter}};