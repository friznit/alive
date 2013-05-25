	private ["_logic","_battery","_target","_batlead","_Ammo","_friends","_Debug","_batname","_first","_phaseF","_targlead","_againF","_dispF","_accF","_Amount","_Rate","_FMType","_againcheck","_Aunit",
	"_HAC_AccF","_TTI","_amount1","_amount2","_template","_targetposATL","_X0","_Y0","_X1","_Y1","_X2","_Y2","_Xav","_Yav","_transspeed","_transdir","_Xhd","_Yhd","_impactpos","_safebase","_distance",
	"_safe","_safecheck","_gauss1","_gauss09","_gauss04","_gauss2","_distance2","_DdistF","_DdamageF","_DweatherF","_DskillF","_anotherD","_Dreduct","_spawndisp","_dispersion","_disp","_HAC_AccF",
	"_gauss1b","_gauss2b","_AdistF","_AweatherF","_AdamageF","_AskillF","_Areduct","_spotterF","_anotherA","_acc","_finalimpact","_posX","_posY","_i","_dX","_dY","_angle","_dXb","_dYb","_posX2",
	"_posY2","_AmmoN","_exDst","_exPX","_exPY","_onRoad","_exPos","_nR","_stRS","_dMin","_dAct","_dSum","_checkedRS","_RSArr","_angle","_rPos","_actRS","_ammocheck","_artyGp","_ammoCount","_dstAct",
	"_maxRange","_minRange","_isTaken","_batlead","_alive","_waitFor","_UL"];	

	_battery = _this select 0;
	_target = _this select 1;
	_batlead = _this select 2;
	_Ammo = _this select 3;
	_friends = _this select 4;
	_Debug = _this select 5;
    _logic = _this select ((count _this)-1);

	_batname = str _battery;

	_first = _battery getVariable [("FIRST" + _batname),1];

	_artyGp = group _batlead;

	_ammocheck = "SmokeAmmo";
	
	switch (_Ammo) do
		{
		case ("ILLUM") : {_ammocheck = "IllumAmmo"};
		case ("HE") : {_ammocheck = "HEAmmo"};
		case ("WP") : {_ammocheck = "WPAmmo"};
		case ("SADARM") : {_ammocheck = "SADARMAmmo"};
		};

	_isTaken = (leader _target) getvariable ["CFF_Taken" + str (leader _target),false];
	if (_isTaken) exitWith {_battery setvariable [("CFF_Ready" + _batname),true]};
	(leader _target) setvariable ["CFF_Taken" + str (leader _target),true];

	_phaseF = [1,2];

	_targlead = vehicle (leader _target);

	_minRange = 2375;
	_maxRange = 5800;

	switch (true) do
		{
		case ((vehicle _batlead) isKindOf "StaticMortar") : {_minRange = 100;_maxRange = 3700};
		case ((typeOf (vehicle _batlead)) in ["MLRS","MLRS_DES_EP1"]) : {_minRange = 4900;_maxRange = 15550};
		case ((typeOf (vehicle _batlead)) in ["GRAD_CDF","GRAD_INS","GRAD_RU","GRAD_TK_EP1"]) : {_minRange = 3300;_maxRange = 10100};
		};

	_waitFor = true;

		{
		if (isNil ("_target")) exitwith {_waitFor = false};
		if (isNull _target) exitwith {_waitFor = false};
		if not (alive _targlead) exitwith {_waitFor = false};

		if (isNull _batlead) exitwith {_waitFor = false};
		if not (alive _batlead) exitwith {_waitFor = false};

		if ((abs (speed _targlead)) > 50) exitWith {_waitFor = false};
		if (((getposATL _targlead) select 2) > 20)  exitWith {_waitFor = false};
		
		_againF = 0.5;
		_dispF = 0.4;
		_accF = 2;
		_Amount = 6;
		_Rate = 0;
		_FMType = "IMMEDIATE";

		_againcheck = _battery getVariable [("CFF_Trg" + _batname),objNull];
		if not ((str _againcheck) == (str _target)) then {_againF = 1};

		_Aunit = vehicle _batlead;
		_HAC_AccF = 1;
		_TTI = 60;

		Switch (typeOf _Aunit) do
			{
			case	"M119" : {_HAC_Accf = 2;_TTI = 20};
			case	"M119_US_EP1" : {_HAC_Accf = 2;_TTI = 20};
			case	"D30_RU" : {_HAC_Accf = 2;_TTI = 20};
			case	"D30_INS" : {_HAC_Accf = 2;_TTI = 20};
			case	"D30_CDF" : {_HAC_Accf = 2;_TTI = 20};
			case	"D30_TK_EP1" : {_HAC_Accf = 2;_TTI = 20};
			case	"D30_TK_GUE_EP1" : {_HAC_Accf = 2;_TTI = 20};
			case	"D30_TK_INS_EP1" : {_HAC_Accf = 2;_TTI = 20};
			case	"MLRS" : {_HAC_Accf = 3;_TTI = 35};
			case	"MLRS_DES_EP1" : {_HAC_Accf = 3;_TTI = 35};
			case	"GRAD_Base" : {_HAC_Accf = 4;_TTI = 35};
			case	"GRAD_RU" : {_HAC_Accf = 4;_TTI = 35};
			case	"GRAD_INS" : {_HAC_Accf = 4;_TTI = 35};
			case	"GRAD_CDF" : {_HAC_Accf = 4;_TTI = 35};
			case	"GRAD_TK_EP1" : {_HAC_Accf = 4;_TTI = 35};
			default {_HAC_Accf = 1;_TTI = 25};
			};

		if (isNil {_logic getvariable "HAC_ART_FMType"}) then {_FMType = "IMMEDIATE"} else {_FMType = (_logic getvariable "HAC_ART_FMType")};
		//if (isNil ("HAC_ART_Ammo")) then {_Ammo = "HE"} else {_Ammo = HAC_ART_Ammo};
		if (isNil {_logic getvariable "HAC_ART_Rate"}) then {_Rate = 0} else {_Rate = (_logic getvariable "HAC_ART_Rate")};
		if (isNil {_logic getvariable "HAC_ART_Amount"}) then {_Amount = 6} else {_Amount = (_logic getvariable "HAC_ART_Amount")};
		if (isNil {_logic getvariable "HAC_ART_Disp"}) then {_dispF = 0.4} else {_dispF = (_logic getvariable "HAC_ART_Disp")};
		if (isNil {_logic getvariable "HAC_ART_Acc"}) then {_accF = 2} else {_accF = (_logic getvariable "HAC_ART_Acc")};

		if (_Ammo == "SADARM") then {_amount = ceil (_amount/3)};

		_amount1 = ceil (_amount/6);
		_amount2 = _amount - _amount1;

		if ((count _phaseF) == 2) then
			{
			if (_x == 1) then
				{
				_amount = _amount1
				}
			else
				{
				_amount = _amount2
				}
			};

		if (_amount == 0) exitwith {_waitFor = false};
		_template = [_FMType,_Ammo,_Rate,_Amount];
		_targetposATL = getposASL _targlead;

		_X0 = (_targetposATL select 0);
		_Y0 = (_targetposATL select 1);
		sleep 10;

		if (isNull _targlead) exitWith {_waitFor = false};
		if not (alive _targlead) exitWith {_waitFor = false};

		_targetposATL = getposASL _targlead;
		_X1 = (_targetposATL select 0);
		_Y1 = (_targetposATL select 1);
		sleep 10;

		if (isNull _targlead) exitWith {_waitFor = false};
		if not (alive _targlead) exitWith {_waitFor = false};

		if (isNull _batlead) exitwith {_waitFor = false};
		if not (alive _batlead) exitwith {_waitFor = false};

		_targetposATL = getposASL _targlead;
		_X2 = (_targetposATL select 0);
		_Y2 = (_targetposATL select 1);

		_onRoad = isOnRoad _targlead;

		_Xav = (_X1+_X2)/2;
		_Yav = (_Y1+_Y2)/2;

		_transspeed = ([_X0,_Y0] distance [_Xav,_Yav])/15;
		_transdir = (_Xav - _X0) atan2 (_Yav - _Y0);

		_Xhd = _transspeed * sin _transdir * 2.7 * _TTI;
		_Yhd = _transspeed * cos _transdir * 2.7 * _TTI;
		_impactpos = _targetposATL;
		_safebase = 100;

		_exPX = (_targetposATL select 0) + _Xhd;
		_exPY = (_targetposATL select 1) + _Yhd;

		_exPos = [_exPX,_exPY,getTerrainHeightASL [_exPX,_exPY]];

		_exDst = _targetposATL distance _exPos;

		if (isNil {_logic getvariable "HAC_ART_Safe"}) then {_safebase = 100} else {_safebase = (_logic getvariable "HAC_ART_Safe")};

		_safe = _safebase * _HAC_Accf * (1 + overcast);

		_safecheck = true;

		if not (_onRoad) then
			{
				{
				if (([(_impactpos select 0) + _Xhd, (_impactpos select 1) + _Yhd] distance (vehicle (leader _x))) < _safe) exitwith 
						{
						_Xhd = _Xhd/2;
						_Yhd = _Yhd/2
						}
				}
			foreach _friends;

				{
				if ([(_impactpos select 0) + _Xhd, (_impactpos select 1) + _Yhd] distance (vehicle (leader _x)) < _safe) exitwith {_safecheck = false};
				}
			foreach _friends;

			if not (_safecheck) then 
				{
				_Xhd = _Xhd/2;
				_Yhd = _Yhd/2;
				_safecheck = true;
					{
					if ([(_impactpos select 0) + _Xhd, (_impactpos select 1) + _Yhd] distance (vehicle (leader _x)) < _safe) exitwith {_safecheck = false};
					}
				foreach _friends;
				if not (_safecheck) then 
					{
					_Xhd = _Xhd/5;
					_Yhd = _Yhd/5;
					_safecheck = true;
						{
						if ([(_impactpos select 0) + _Xhd, (_impactpos select 1) + _Yhd] distance (vehicle (leader _x)) < _safe) exitwith {_safecheck = false};
						}
					foreach _friends
					}
				};

			_impactpos = [(_targetposATL select 0) + _Xhd, (_targetposATL select 1) + _Yhd];
			}
		else
			{
			_nR = _targlead nearRoads 30;

			_stRS = _nR select 0;
			_dMin = _stRS distance _exPos;

				{
				_dAct = _x distance _exPos;
				if (_dAct < _dMin) then {_dMin = _dAct;_stRS = _x}
				}
			foreach _nR;

			_dSum = _targlead distance _stRS;
			_checkedRS = [_stRS];
			_actRS = _stRS;

			while {_dSum < _exDst} do
				{
				_RSArr = (roadsConnectedTo _actRS) - _checkedRS;
				if ((count _RSArr) == 0) exitWith {};
				_stRS = _RSArr select 0;
				_dMin = _stRS distance _exPos;

					{
					_dAct = _x distance _exPos;
					if (_dAct < _dMin) then {_dMin = _dAct;_stRS = _x}
					}
				foreach _RSArr;

				_dSum = _dSum + (_stRS distance _actRS);

				_actRS = _stRS;

				_checkedRS set [(count _checkedRS),_stRS];
				};

			if (_dSum < _exDst) then
				{
				//if (_transdir < 0) then {_transdir = _transdir + 360};
				_angle = [_targetposATL,(getposASL _stRS),1,_logic] call ALiVE_fnc_HAC_AngTowards;
				_impactPos = [(getposASL _stRS),_angle,(_exDst - _dSum),_logic] call ALiVE_fnc_HAC_PosTowards2D
				}
			else
				{
				_rPos = getposASL _stRS;
				_impactPos = [_rPos select 0,_rPos select 1]
				};
			
				{
				if ((_impactpos distance (vehicle (leader _x))) < _safe) exitwith 
					{
					_safeCheck = false;
					_impactpos = [((_impactpos select 0) + (_targetposATL select 0))/2,((_impactpos select 1) + (_targetposATL select 1))/2]
					}
				}
			foreach _friends
			};

		if not (_safeCheck) then
			{
			_safeCheck = true;

				{
				if ((_impactpos distance (vehicle (leader _x))) < _safe) exitwith 
					{
					_safeCheck = false
					}
				}
			foreach _friends
			};

		if not (_safecheck) exitwith {(leader _target) setvariable ["CFF_Taken" + str (leader _target),false]};
		if (not (_battery getvariable [("CFF_Ready" + _batname),true]) and (_x == 1)) exitWith {(leader _target) setvariable ["CFF_Taken" + str (leader _target),false]};
		_battery setvariable [("CFF_Ready" + _batname),false];

		_gauss1 = (random 0.1) + (random 0.1) + (random 0.1) + (random 0.1) + (random 0.1) + (random 0.1) + (random 0.1) + (random 0.1) +  (random 0.1) + (random 0.1);
		_gauss09 = (random 0.09) + (random 0.09) + (random 0.09) + (random 0.09) + (random 0.09) + (random 0.09) + (random 0.09) + (random 0.09) +  (random 0.09) + (random 0.09);
		_gauss04 = (random 0.04) + (random 0.04) + (random 0.04) + (random 0.04) + (random 0.04) + (random 0.04) + (random 0.04) + (random 0.04) +  (random 0.04) + (random 0.04);
		_gauss2 = (random 0.2) + (random 0.2) + (random 0.2) + (random 0.2) + (random 0.2) + (random 0.2) + (random 0.2) + (random 0.2) +  (random 0.2) + (random 0.2);
		_distance2 = _impactPos distance (getposATL (vehicle _batlead));
		_DdistF = (_distance2/10) * (0.1 + _gauss04);
		_DdamageF = 1 + 0.5 * (damage _batlead);
		_DweatherF = 1 + overcast;
		_DskillF = 2 * (skill _batlead);
		_anotherD = 1 + _gauss1;
		_Dreduct = (1 + _gauss2) + _DskillF;
		 
		_spawndisp = _dispF * ((_HAC_Accf * _DdistF * _DdamageF) + (50 * _DweatherF * _anotherD)) / _Dreduct;
		_dispersion = 10000 * (_spawndisp atan2 _distance2) / 57.3;

		_disp = _dispersion;
		if (isNil {_logic getvariable "HAC_ART_SpawnM"}) then {_disp = _dispersion} else {_disp = _spawndisp};

		_HAC_AccF = 1;
		[_battery,_disp] call BIS_ARTY_F_SetDispersion;

		_gauss1b = (random 0.1) + (random 0.1) + (random 0.1) + (random 0.1) + (random 0.1) + (random 0.1) + (random 0.1) + (random 0.1) +  (random 0.1) + (random 0.1);
		_gauss2b = (random 0.2) + (random 0.2) + (random 0.2) + (random 0.2) + (random 0.2) + (random 0.2) + (random 0.2) + (random 0.2) +  (random 0.2) + (random 0.2);
		_AdistF = (_distance2/10) * (0.1 + _gauss09);
		_AweatherF = _DweatherF;
		_AdamageF = 1 + 0.1 * (damage (vehicle _batlead));
		_AskillF = 5 * (_batlead skill "aimingAccuracy");
		_Areduct = (1 + _gauss2b) + _AskillF;
		_spotterF = 0.2 + (random 0.2);
		_anotherA = 1 + _gauss1b;
		if not (isNil {_logic getvariable "HAC_ART_FOAccGain"}) then {_spotterF = (_logic getvariable "HAC_ART_FOAccGain") + (random 0.2)};
		if (((count _phaseF) == 2) and (_x == 1) or ((count _phaseF) == 1)) then {_spotterF = 1};

		_acc = _spotterF * _againF * _accF * ((_AdistF * _AdamageF) + (50 * _AweatherF * _anotherA)) / _Areduct;

		_finalimpact = [(_impactpos select 0) + (random (2 * _acc)) - _acc,(_impactpos select 1) + (random (2 * _acc)) - _acc];

		if (isNull _targlead) exitWith {_waitFor = false};
		if not (alive _targlead) exitWith {_waitFor = false};

		if ((abs (speed _targlead)) > 50) exitWith {_waitFor = false};
		if (((getposATL _targlead) select 2) > 20)  exitWith {_waitFor = false};

		_dstAct = _impactpos distance _batlead;

		if ((_dstAct > _maxRange) or (_dstAct < _minRange)) exitWith {_waitFor = false};

		[_battery, _finalimpact, _template] call BIS_ARTY_F_ExecuteTemplateMission;
		_UL = _batlead;
		if ((random 100) < (_logic getvariable "HAC_xHQ_AIChatDensity")) then {[_UL,(_logic getvariable "HAC_xHQ_AIC_ArtFire"),"ArtFire",_logic] call ALiVE_fnc_HAC_AIChatter};

		_ammoCount = _artyGp getVariable _ammocheck;

		_artyGp setVariable [_ammocheck,_ammoCount - _Amount];

		sleep 0.2;
		_posX = 0;
		_posY = 0;
		if (_Debug) then 
			{
			_distance = _impactPos distance _finalimpact;
			_distance2 = _impactPos distance (getposATL (vehicle _batlead));
			_i = "mark0" + str (_battery);
			_i = createMarker [_i,_impactPos];
			_i setMarkerColor (_logic getvariable ["HAC_HQ_Color","ColorBlue"]);
			_i setMarkerShape "ELLIPSE";
			_i setMarkerSize [_distance, _distance];
			_i setMarkerBrush "Border";

			_dX = (_impactPos select 0) - (getposATL (vehicle _batlead) select 0);
			_dY = (_impactPos select 1) - (getposATL (vehicle _batlead) select 1);
			_angle = _dX atan2 _dY;
			if (_angle >= 180) then {_angle = _angle - 180};
			_dXb = (_distance2/2) * (sin _angle);
			_dYb = (_distance2/2) * (cos _angle);
			_posX = (getposATL (vehicle _batlead) select 0) + _dXb;
			_posY = (getposATL (vehicle _batlead) select 1) + _dYb;

			_i = "mark1" + str (_battery);
			_i = createMarker [_i,[_posX,_posY]];
			_i setMarkerColor (_logic getvariable ["HAC_HQ_Color","ColorBlack"]);
			_i setMarkerShape "RECTANGLE";
			_i setMarkerSize [0.5,_distance2/2];
			_i setMarkerBrush "Solid";
			_i setMarkerdir _angle;

			_dX = (_finalimpact select 0) - (_impactPos select 0);
			_dY = (_finalimpact select 1) - (_impactPos select 1);
			_angle = _dX atan2 _dY;
			if (_angle >= 180) then {_angle = _angle - 180};
			_dXb = (_distance/2) * (sin _angle);
			_dYb = (_distance/2) * (cos _angle);
			_posX2 = (_impactPos select 0) + _dXb;
			_posY2 = (_impactPos select 1) + _dYb;

			_i = "mark2" + str (_battery);
			_i = createMarker [_i,[_posX2,_posY2]];
			_i setMarkerColor (_logic getvariable ["HAC_HQ_Color","ColorBlack"]);
			_i setMarkerShape "RECTANGLE";
			_i setMarkerSize [0.5,_distance/2];
			_i setMarkerBrush "Solid";
			_i setMarkerdir _angle;

			_i = "mark3" + str (_battery);
			_i = createMarker [_i,_impactPos];
			_i setMarkerColor (_logic getvariable ["HAC_HQ_Color","ColorBlack"]);
			_i setMarkerShape "ICON";
			_i setMarkerType "mil_dot";

			_i = "mark4" + str (_battery);
			_i = createMarker [_i,_finalimpact];
			_i setMarkerColor (_logic getvariable ["HAC_HQ_Color","ColorRed"]);
			_i setMarkerShape "ICON";
			_i setMarkerType "mil_dot";
			_i setMarkerText (str (round (_distance)) + "m" + "/" + str (round (_spawndisp)) + "m" + " - " + _Ammo);
				
			[_i,_battery,_distance,_spawndisp,_Ammo,_batlead,_target] spawn
				{
				private ["_logic","_mark","_battery","_distance","_spawndisp","_Ammo","_target","_alive","_stoper","_TOF","_batlead"];

				_mark = _this select 0;
				_battery = _this select 1;
				_distance = _this select 2;
				_spawndisp = _this select 3;
				_Ammo = _this select 4;
				_batlead = _this select 5;
				_target = _this select 6;

				_alive = true;

				waitUntil 
					{
					if (isNull _batlead) then {_alive = false};
					if not (alive _batlead) then {_alive = false};
					((_battery getVariable "ARTY_SHOTCALLED") or not (_alive))
					};

				_stoper = time;
				_TOF = 0;

				while {(not (_battery getVariable "ARTY_SPLASH") and not (_TOF > 100))} do
					{
					if (isNull _batlead) exitWith {(leader _target) setvariable ["CFF_Taken" + str (leader _target),false]};
					if not (alive _batlead) exitWith {(leader _target) setvariable ["CFF_Taken" + str (leader _target),false]};
					_TOF = (round (10 * (time - _stoper)))/10;
					_mark setMarkerText (str (round (_distance)) + "m" + "/" + str (round (_spawndisp)) + "m" + " - " + _Ammo + " - TOF: " + (str _TOF));
					sleep 0.1
					};

				if (isNull _batlead) exitWith {deleteMarker _mark};
				if not (alive _batlead) exitWith {deleteMarker _mark};

				_mark setMarkerText (str (round (_distance)) + "m" + "/" + str (round (_spawndisp)) + "m" + " - " + _Ammo + " - SPLASH!");
				};

			_i = "mark5" + str (_battery);
			_i = createMarker [_i,_finalimpact];
			_i setMarkerColor (_logic getvariable ["HAC_HQ_Color","ColorRed"]);
			_i setMarkerShape "ELLIPSE";
			_i setMarkerSize [_spawndisp,_spawndisp];

			_i = str _battery;
			if (_first == 1) then 
				{
				_i = createMarker [_i,getposATL (vehicle _batlead)];
				_i setMarkerColor (_logic getvariable ["HAC_HQ_Color","ColorBlack"]);
				_i setMarkerShape "ICON";
				_i setMarkerType "n_empty";
				_i setMarkerText (_i + " - " + str (typeof (vehicle _batlead)))
				}
			else
				{
				(str _battery) setMarkerPos getposATL (vehicle _batlead)
				}

			};

		_alive = true;

		waituntil 
			{
			sleep 1;
			
				{
					{
					_AmmoN = _x ammo (primaryWeapon (vehicle _x)); 
					if (_AmmoN == 0) then 
						{
						sleep 0.1;
						reload (vehicle _x)
						}
					}
				foreach units (group _x)
				}
			foreach (synchronizedObjects _battery);

			if (isNull _batlead) then {_alive = false};
			if not (alive _batlead) then {_alive = false};
			
			(([_battery, _template] call BIS_ARTY_F_Available) or not (_alive))
			};

		if not (_alive) exitWith {};

		if (((count _phaseF) == 2) and (_x == 1)) then 
			{
			_alive = true;			

			waitUntil 
				{
				sleep 1;

				if (isNull _batlead) then {_alive = false};
				if not (alive _batlead) then {_alive = false};

				((_battery getVariable "ARTY_SPLASH") or not (_alive))
				};

			sleep 10;

				{
				deleteMarker ("mark" + str (_x) + str (_battery));
				}
			foreach [0,1,2,3,4,5];

			if not (_alive) exitWith {};
			};

		}
	foreach _phaseF;

	_battery setVariable [("CFF_Trg" + _batname),_target];

	_alive = true;

	if (_waitFor) then
		{
		waitUntil 
			{
			sleep 1;

			if (isNull _batlead) then {_alive = false};
			if not (alive _batlead) then {_alive = false};

			((_battery getVariable "ARTY_SPLASH") or not (_alive))
			};

		sleep 10;

		};

			{
			deleteMarker ("mark" + str (_x) + str (_battery));
			}
		foreach [0,1,2,3,4,5];

	if not (_alive) exitWith {(leader _target) setvariable ["CFF_Taken" + str (leader _target),false]};

	(leader _target) setvariable ["CFF_Taken" + str (leader _target),false];

	_battery setvariable [("CFF_Ready" + _batname),true];