	private ["_logic","_HQ","_ahead","_frontPos","_o1","_o2","_o3","_o4","_allied","_HQpos","_front","_angle","_dst","_dstF","_dDst","_stancePos","_taken","_fG","_val","_forGarr","_ct","_ct2",
	"_garrison","_task","_hMany","_busy","_Wpos","_mark","_wp","_aheadL","_aliveHQ","_hostileG","_assg","_possPos","_enV","_posArr","_enV2","_nr","_sX","_sY","_dstA","_amnt","_actT",
	"_maxT","_poss","_m","_side","_rColor"];

	_HQ = _this select 0;
	_ahead = _this select 1;
	_o1 = _this select 2;
	_o2 = _this select 3;
	_o3 = _this select 4;
	_o4 = _this select 5;
	_allied = _this select 6;//leader units

	_HQpos = getPosATL (vehicle _HQ);
	_front = _this select 7;
	_taken = _this select 8;
	_hostileG = _this select 9;
	_side = _this select 10;
    _logic = _this select ((count _this)-1);

	_frontPos = _HQpos;
	if ((count _ahead) > 0) then 
		{
		_aheadL = _ahead select (floor (random (count _ahead)));
		_aliveHQ = true;
		if not (alive _aheadL) then {_aliveHQ = false};
		if (isNull _aheadL) then {_aliveHQ = false};

		if (_aliveHQ) then
			{
			_frontPos = getPosATL (vehicle _aheadL)
			}
		};

	_dst = _HQpos distance _frontPos;

	_dDst = 1000 + (random 1000);

	_dstF = _dst - _dDst;
	if (_dstF < 0) then {_dstF = _dst/2};

	_angle = [_HQpos,_frontPos,10,_logic] call ALiVE_fnc_HAC_AngTowards;

	if (_angle < 0) then {_angle = _angle + 360};

	_angle = _angle + 180;

	_stancePos = [_frontPos,_angle,_dstF,_logic] call ALiVE_fnc_HAC_PosTowards2D;
//diag_log format ["1 sp: %1",_stancePos];
	_stancePos = [(_stancePos select 0),(_stancePos select 1),0];
//diag_log format ["2 sp: %1",_stancePos];
	if (surfaceIsWater [(_stancePos select 0),(_stancePos select 1)]) then {_stancePos = _HQpos};

	if ((count _hostileG) == 0) then
		{
			{
			_x setPosATL _stancePos
			}
		foreach [_o1,_o2,_o3,_o4]
		};

	(group _HQ) setVariable ["ObjInit",true];

	[(group _HQ),_logic] call ALiVE_fnc_HAC_WPdel;
	_wp = [_logic,(group _HQ),_StancePos,"HOLD","AWARE","GREEN","LIMITED",["true",""],true,50,[0,0,0],"FILE"] call ALiVE_fnc_HAC_WPadd;

	_fG = (_logic getvariable "HAC_HQ_NCrewInfG") - ((_logic getvariable "HAC_HQ_Exhausted") + (_logic getvariable "HAC_HQ_Garrison"));
	_garrison = _logic getvariable "HAC_HQ_Garrison";

	switch (_HQ) do
		{
		case (_logic) : {_logic setvariable ["HAC_HQ_NObj", 1]};
		};

	_fG = _fG - [(group _HQ)];

		{
		if ((count _x) < 5) then {_x set [4,false]};
		if not (_x select 4) then
			{
			_Wpos = _x select 0;
			_val = _x select 1;
			if (_val > 5) then {_val = 5};
			_hMany = floor ((_val/10) * (count _fG));

			//if (_hMany > (ceil (_val/2))) then {_hMany = ceil (_val/2)};
			if (_hMany > 2) then {_hMany = 2};
			//if ((_hMany == 0) and ((random 100) > (90 - (count _fG)))) then {_hMany = 1};

			_ct = 0;

			while {((_ct < _hMany) and ((count _fG) > 0))} do
				{
				_ct = _ct + 1;
				_forGarr = _fG select (floor (random (count _fG)));
				_busy = _forGarr getVariable ("Busy" + (str _forGarr));
				if (isNil "_busy") then {_busy = false};

				_ct2 = 0;

				while {(_busy) and (_ct2 <= (count _fG))} do
					{
					_ct2 = _ct2 + 1;
					_forGarr = _fG select (floor (random (count _fG)));
					_busy = _forGarr getVariable ("Busy" + (str _forGarr));
					if (isNil "_busy") then {_busy = false};
					};

				if not (_busy) then
					{
					_x set [4,true];
					_fG = _fG - [_forGarr];

					[_forGarr,_garrison,_Wpos,_HQ] spawn
						{
						private ["_logic","_unitG","_cause","_timer","_alive","_task","_form","_Wpos","_garrison","_HQ","_wp"];

						_unitG = _this select 0;
						_garrison = _this select 1;
						_Wpos = _this select 2;
						_HQ = _this select 3;

						_form = "DIAMOND";
						if (isPlayer (leader _unitG)) then {_form = formation _unitG};
						_unitG setVariable ["Busy" + (str _unitG),true];

						_logic setvariable ["HAC_HQ_VCDone", false];
						if (isPlayer (leader _unitG)) then {[(leader _unitG),_HQ,_logic] spawn ALiVE_fnc_HAC_VoiceComm;sleep 3;waituntil {sleep 0.1;(_logic getvariable "HAC_HQ_VCDone")}} else {if ((random 100) < (_logic getvariable "HAC_xHQ_AIChatDensity")) then {[_UL,_logic getvariable "HAC_xHQ_AIC_OrdConf","OrdConf",_logic] spawn ALiVE_fnc_HAC_AIChatter}};

						_task = [(leader _unitG),["Reach the designated position.", "Move", ""],_Wpos,_logic] call ALiVE_fnc_HAC_AddTask;

						[_unitG,_logic] call ALiVE_fnc_HAC_WPdel;

						_wp = [_logic,_unitG,_Wpos,"MOVE","AWARE","YELLOW","NORMAL",["true","deletewaypoint [(group this), 0]"],true,250,[0,0,0],_form] call ALiVE_fnc_HAC_WPadd;

						_cause = [_logic,_unitG,6,true,0,30,[],false] call ALiVE_fnc_HAC_Wait;
						_timer = _cause select 0;
						_alive = _cause select 1;

						if not (_alive) exitwith {};
						if (_timer > 30) then {[_unitG, (currentWaypoint _unitG)] setWaypointPosition [position (vehicle (leader _unitG)), 1]};

						if ((isPlayer (leader _unitG)) and not (isMultiplayer)) then {(leader _unitG) removeSimpleTask _task};

						if not (_timer > 30) then {_garrison set [(count _garrison),_unitG]};
						}
					}
				}
			}
		}
	foreach _taken;

	if ((count _hostileG) > 0) then
		{
		_assg = [];
		_possPos = [];

			{
			if not (_x in _assg) then
				{
				_enV = vehicle (leader _x);
				_posArr = [];

					{
					_enV2 = vehicle (leader _x);

					if ((_enV distance _enV2) < 600) then 
						{
						_posArr set [(count _posArr),getPosATL _enV2];
						_assg set [(count _assg),_x];			
						}
					}
				foreach _hostileG;

				_nr = count _posArr;

				if (_nr > 0) then
					{
					_sX = 0;
					_sY = 0;

						{
						_sX = _sX + (_x select 0);
						_sY = _sY + (_x select 1);
						}
					foreach _posArr;
					
					_poss = [[_sX/_nr,_sY/_nr,0],_nr];
					if not (surfaceIsWater [_sX/_nr,_sY/_nr]) then {_possPos set [(count _possPos),_poss]}
					}
				}
			}
		foreach _hostileG;

		_stancePos = (_possPos select 0) select 0;
		_maxT = 0;
//diag_log format ["3 sp: %1",_stancePos];
			{
			_dstA = (_x select 0) distance _HQpos;
			_amnt = _x select 1;
			_actT = (_amnt/((_dstA/1000) * (_dstA/1000))) * (0.5 + (random 0.5) + (random 0.5));

			if (_actT > _maxT) then
				{
				_maxT = _actT;
				_stancePos = _x select 0;
				}

			}
		foreach _possPos
		};

		{
		_x setPosATL _stancePos
		}
	foreach [_o1,_o2,_o3,_o4];

	if (_logic getvariable "HAC_BB_Debug") then
		{
		_m = (group _HQ) getVariable "ResMark";
		if (isNil "_m") then 
			{
			_rColor = "ColorBlue";
			if (_side == "B") then {_rColor = "ColorRed"};
			_m = [_StancePos,_HQ,"markBBCurrent",_rColor,"ICON","o_unknown"," | Reserve area for " + (str _HQ),"",[0.5,0.5],_logic] call ALiVE_fnc_HAC_Mark;
			(group _HQ) setVariable ["ResMark",_m]
			}
		else
			{
			_m setMarkerPos _StancePos
			};
		};
    