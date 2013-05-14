_i = "";

_unitG = _this select 0;
_Spot = _this select 1;
_StartPos = position (vehicle (leader _unitG));
_logic = _this select ((count _this)-1);

_ammo = [_unitG] call ALiVE_fnc_HAC_AmmoCount;

if (_ammo == 0) exitwith {_logic setvariable ["HAC_HQ_Roger", true]};

_unitvar = str _unitG;
_busy = false;
_busy = _unitG getvariable ("Busy" + _unitvar);

if (isNil ("_busy")) then {_busy = false};

if ((_busy) and (_unitG in (_logic getvariable "HAC_HQ_AirInDef"))) exitwith {_logic setvariable ["HAC_HQ_Roger", true]};

[_unitG,_logic] call ALiVE_fnc_HAC_WPdel;

_unitG setVariable [("Deployed" + (str _unitG)),false];_unitG setVariable [("Capt" + (str _unitG)),false];
_unitG setVariable [("Busy" + _unitvar), true];
_unitG setVariable ["Defending", true];

_logic setvariable ["HAC_HQ_AirInDef",(_logic getvariable "HAC_HQ_AirInDef") + [_unitG]];
_logic setvariable ["HAC_HQ_Roger", true];

if ((isPlayer (leader _unitG)) && (_logic getvariable "HAC_xHQ_GPauseActive")) then {hintC "New orders from HQ!";setAccTime 1};

_UL = leader _unitG;
_logic setvariable ["HAC_HQ_VCDone",false];
if (isPlayer _UL) then {[_UL,_logic,_logic] spawn ALiVE_fnc_HAC_VoiceComm;sleep 3;waituntil {sleep 0.1;(_logic getvariable "HAC_HQ_VCDone")}} else {if ((random 100) < (_logic getvariable "HAC_xHQ_AIChatDensity")) then {[_UL,(_logic getvariable "HAC_xHQ_AIC_OrdConf"),"OrdConf",_logic] call ALiVE_fnc_HAC_AIChatter}};

_endThis = false;
_alive = true;

while {not (_endThis)} do
	{
	_DefPos = [((position _Spot) select 0) + (random 1000) - 500,((position _Spot) select 1) + (random 1000) - 500];
	if ((_logic getvariable "HAC_HQ_Debug") or (isPlayer (leader _unitG))) then 
		{
		_i = [_DefPos,_unitG,"markDef","ColorBrown","ICON","mil_dot","Air A"," - DEFEND AREA",_logic] call ALiVE_fnc_HAC_Mark
		};

	_task = [(leader _unitG),["Provide air cover.", "S&D", ""],_DefPos,_logic] call ALiVE_fnc_HAC_AddTask;

	_wp = [_logic,_unitG,_DefPos,"SAD","AWARE","YELLOW","NORMAL"] call ALiVE_fnc_HAC_WPadd;

	if (_unitG in (_logic getvariable "HAC_HQ_BAirG")) then 
		{
		_chosen = GrpNull;
		_dstM = 5000;

		_chosen = ([_Spot,(_logic getvariable "HAC_HQ_KnEnemiesG"),0,_logic] call ALiVE_fnc_HAC_CloseEnemyB) select 2;

		if not (isNull _chosen) then
			{
			_Trg = vehicle (leader _chosen);
			_eSide = side _unitG;
			_wp waypointAttachVehicle _Trg;_wp setWaypointType "DESTROY";
			_tgt = "LaserTargetWStatic";
			if (_eSide == east) then {_tgt = "LaserTargetEStatic"};

			_tPos = getPosATL _Trg;
			_tX = (_tPos select 0) + (random 60) - 30;
			_tY = (_tPos select 1) + (random 60) - 30;
			_tZ = (_tPos select 2) + (random 10) - 5;
			_lasT = createVehicle [_tgt, [_tX,_tY,_tZ], [], 0, "NONE"]; 

			[_Trg,_lasT,_tX,_tY,_tZ] spawn
				{
				_Trg = _this select 0;
				_lasT = _this select 1;

				_tX = _this select 2;
				_tY = _this select 3;
				_tZ = _this select 4;

				_ct = 0;

				while {(not (isNull _Trg) and (_ct < 20))} do
					{
					_tX = _tX + (random 60) - 30;
					_tY = _tY + (random 60) - 30;
					_tZ = _tZ + (random 10) - 5;

					_lasT setPos [_tX,_tY,_tZ];
					sleep 15;
					_ct = _ct + 1
					};

				deleteVehicle _lasT
				}
			}
		};

	_cause = [_logic,_unitG,6,true,0,24,[],false] call ALiVE_fnc_HAC_Wait;

	if ((isPlayer (leader _unitG)) and not (isMultiplayer)) then {(leader _unitG) removeSimpleTask _task};

	if not (_unitG getVariable "Defending") then {_endThis = true};
	if ((isNull _unitG) or (isNull HAC_HQ)) then {_endThis = true;_alive = false};
	if not (alive (leader _unitG)) then {_endThis = true;_alive = false};
	};

if not (_alive) exitWith 
	{
	if ((_logic getvariable "HAC_HQ_Debug") or (isPlayer (leader _unitG))) then 
		{
		deleteMarker ("markDef" + _unitVar);
		deleteMarker ("markWatch" + _unitVar);
		};

	_logic setvariable ["HAC_HQ_AirInDef",(_logic getvariable "HAC_HQ_AirInDef") - [_unitG]];
	};

_task = [(leader _unitG),["Return to the landing site.", "Move", ""],_StartPos,_logic] call ALiVE_fnc_HAC_AddTask;

_wp = [_logic,_unitG,_StartPos,"MOVE","AWARE","GREEN","NORMAL",["true", "{(vehicle _x) land 'LAND'} foreach (units (group this)); deletewaypoint [(group this), 0]"]] call ALiVE_fnc_HAC_WPadd;

_cause = [_logic,_unitG,6,true,0,24,[],false] call ALiVE_fnc_HAC_Wait;
_alive = _cause select 1;

if not (_alive) exitwith {if ((_logic getvariable "HAC_HQ_Debug") or (isPlayer (leader _unitG))) then {deleteMarker ("markDef" + (str _unitG))};_logic setvariable ["HAC_HQ_AirInDef",(_logic getvariable "HAC_HQ_AirInDef") - [_unitG]]};

if ((isPlayer (leader _unitG)) and not (isMultiplayer)) then {(leader _unitG) removeSimpleTask _task};

sleep 30;

if ((_logic getvariable "HAC_HQ_Debug") or (isPlayer (leader _unitG))) then {deleteMarker ("markDef" + (str _unitG))};

_logic setvariable ["HAC_HQ_AirInDef",(_logic getvariable "HAC_HQ_AirInDef") - [_unitG]];
_unitG setVariable [("Busy" + _unitvar), false];

_UL = leader _unitG;if not (isPlayer _UL) then {if ((random 100) < (_logic getvariable "HAC_xHQ_AIChatDensity")) then {[_UL,(_logic getvariable "HAC_xHQ_AIC_OrdEnd"),"OrdEnd",_logic] call ALiVE_fnc_HAC_AIChatter}};