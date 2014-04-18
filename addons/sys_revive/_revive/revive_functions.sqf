/* -------------------------------------------------------------------
	Create player actions
------------------------------------------------------------------- */
REV_FNC_Player_Actions = {
	if (alive player && player isKindOf "Man") then {
		player addAction ["<t color=""#C90000"">" + "Revive" + "</t>", {call REV_FNC_Actions}, ["actRevive"], 10, true, true, "", "call REV_FNC_Revive_Chk"];
		player addAction ["<t color=""#C90000"">" + "Suicide" + "</t>", {call REV_FNC_Actions}, ["actSuicide"], 9, false, true, "", "call REV_FNC_Suicide_Chk"];
		player addAction ["<t color=""#C90000"">" + "Drag" + "</t>", {call REV_FNC_Actions}, ["actDrag"], 9, false, true, "", "call REV_FNC_Dragging_Chk"];
		// player addAction ["<t color=""#C90000"">" + "Carry" + "</t>", {call REV_FNC_Actions}, ["actCarry"], 9, false, true, "", "call REV_FNC_Carrying_Chk"];
		player addAction ["<t color=""#C90000"">" + "Stabilize" + "</t>", {call REV_FNC_Actions}, ["actStabilize"], 10, true, true, "", "call REV_FNC_Stabilize_Chk"];
	};
};

/* -------------------------------------------------------------------
	Action Execution
------------------------------------------------------------------- */
REV_FNC_Actions = {
	private ["_params", "_action"];
	_params = _this select 3;
	_action = _params select 0;

	if (_action == "actStabilize") then {
		[cursorTarget] spawn REV_FNC_Stabilize;
	};

	if (_action == "actRevive") then {
		[cursorTarget] spawn REV_FNC_Revive;
	};

	if (_action == "actDrag") then {
		[cursorTarget] spawn REV_FNC_Drag;
	};

	// if (_action == "actCarry") then {
		// [cursorTarget] spawn REV_FNC_Carry;
	// };

	if (_action == "actRelease") then {
		[] spawn REV_FNC_Release;
	};

	if (_action == "actSuicide") then {
		hintSilent "";
		player setDamage 1;
	};
};

/* -------------------------------------------------------------------
	Handle the units death
------------------------------------------------------------------- */
REV_FNC_HandleDamage_EH = {
	private ["_unit", "_killer", "_amountOfDamage", "_isUnconscious"];

	// if (_this select 1 == "") then {
		// diag_log text format ["T=%1 : %2 : %3 : %4", date, _this, _this select 2, time];
	// };
	_unit = _this select 0;
	_amountOfDamage = _this select 2;
	_finalRound = _this select 1;
	_killer = _this select 3;
	_isUnconscious = _unit getVariable "REV_VAR_isUnconscious";
	
	if (alive _unit && _amountOfDamage >= 0.9 && _isUnconscious == 0) then {
		_unit setDamage 0;
		_unit allowDamage false;
		FinalRound = _finalRound;
		AmountDamage = round _amountOfDamage;
		_amountOfDamage = 0;
		[_unit, _killer] spawn REV_FNC_Player_Unconscious;
	};
	_amountOfDamage;
};

/* -------------------------------------------------------------------
	Make the player unconscious
------------------------------------------------------------------- */
REV_FNC_Player_Unconscious = {
	private["_unit", "_killer"];
	_unit = _this select 0;
	_killer = _this select 1;

	_unit setVariable ["REV_VAR_isUnconscious", 1, true];
	_unit setVariable ["REV_VAR_isStabilized", 1, true];
	
	[_unit] call REV_FNC_CreateMarker;
	
	/* allows for a revive cam feature, 3rd person view */
	// if (REV_VAR_Spectate) then {
		// need code to allow for 3rd person view of the injured body
	// };

	/* Death message */
	if (REV_VAR_TeamKillNotifications && !isNil "_killer" && isPlayer _killer && _killer != _unit) then {
		REV_VAR_DeathMsg = [_unit, _killer];
		publicVariable "REV_VAR_DeathMsg";
		["REV_VAR_DeathMsg", [_unit, _killer]] call REV_FNC_Public_EH;
	};
	
	if (isPlayer _unit) then {
		10 fadeSound 0.4;
		REV_Unconscious_Effect = [_unit] spawn {
			_unit = _this select 0;
			waitUntil {
				if (!isNull _unit && alive _unit && _unit getVariable "REV_VAR_isUnconscious" == 1 ) then { 
					for "_i" from 1 to REV_VAR_BleedOutTime do  {
						REV_Video_Color_Effect = ppEffectCreate ["colorCorrections", 1554];
						REV_Video_Blurr_Effect = ppEffectCreate ["dynamicBlur", 454];

						REV_Video_Color_Effect ppEffectEnable true;
						REV_Video_Blurr_Effect ppEffectEnable true;

						REV_Video_Color_Effect ppEffectAdjust [1, 1, 0, [1,0,0,0.25], [1,0,0,1], [1,0,0,1]]; 
						REV_Video_Color_Effect ppEffectCommit 0.01;

						REV_Video_Blurr_Effect ppEffectAdjust [3];
						REV_Video_Blurr_Effect ppEffectCommit 0.01;
							
						250 cutRsc ["REV_Wounded_EyePain","PLAIN",0];
						251 cutRsc ["REV_Wounded_BloodSplash","PLAIN",0];
						0 fadeSound 0.2;
						PlaySound "REV_Heartbeat";
						
						sleep 1;
					};
				} else {
					if (!isNull _unit && !(alive _unit) || _unit getVariable "REV_VAR_isUnconscious" == 0) then { 
						true;
					};
				};
			};
		};
		
		disableUserInput true;
		titleText ["", "BLACK FADED",0];
	};
	
	/* Eject the unit if in a vehicle */
	while {vehicle _unit != _unit} do {
		unAssignVehicle _unit;
		_unit action ["eject", vehicle _unit];
		sleep 2;
	};
	
	// _unit setDamage 0.85;
	// sets the amount of damage of the unit, amount will vary based on severity of injury.
	_unit setDamage (AmountDamage/2.5);
    _unit setVelocity [0,0,0];
	_unit setCaptive true;
	
	/* Variable for downed unit to take damagge or not */
    _unit playMove "AinjPpneMstpSnonWrflDnon_rolltoback";
	sleep 3.5;
	_unit disableAI "Move";
    
	_unit switchMove "AinjPpneMstpSnonWrflDnon";
	_unit enableSimulation false;
	// sleep 5;
	_unit allowDamage REV_VAR_isBulletproof;
	_unit setCaptive REV_VAR_isNeutral;
	
	if (isPlayer _unit) then {
		titleText ["", "BLACK IN", 0];
		disableUserInput false;

		_bleedOut = time + REV_VAR_BleedOutTime;
		
		while {!isNull _unit && alive _unit && _unit getVariable "REV_VAR_isUnconscious" == 1 && _unit getVariable "REV_VAR_isStabilized" == 1 && (REV_VAR_BleedOutTime <= 0 || time < _bleedOut)} do {
			
			if (damage player >= 0.6) then {
				[format["Bleeding out in roughly %1 seconds", round (_bleedOut - time), name player],0, 0.035 * safezoneH + safezoneY,5,0.3] spawn BIS_fnc_dynamicText;
			} else {
				[format["%1, you have been knocked unconscious...",name player],0, 0.035 * safezoneH + safezoneY,5,0.3] spawn BIS_fnc_dynamicText;
				sleep 3;
			};
			
			/* debug */
			if (REV_Debug) then {
				hintSilent format["Bleedout in %1 seconds\n\n%2\n\nBleedout rate: %3\n\nRegen Rate: %4\n\nPlayer Damage: %5\n\nDamage Amount: %6", round (_bleedOut - time), call REV_FNC_Friends_Chk, playerBleedRate,playerRegenRate,playerDamage,AmountDamage];
			};
			/* end of debug */
			
			sleep 1;
		};
		
		/* Unit has been stabilized */
		if (_unit getVariable "REV_VAR_isStabilized" == 0) then {
			while { !isNull _unit && alive _unit && _unit getVariable "REV_VAR_isUnconscious" == 1 } do {
				hintSilent format["You have been stabilized\n\n%1", call REV_FNC_Friends_Chk];
				sleep 0.5;
			};
		};
		
		/* Handle player bleedout */
		if (REV_VAR_BleedOutTime > 0 && {time > _bleedOut} && {_unit getVariable ["REV_VAR_isStabilized",0] == 1}) then {
		
			/* Player bled out and died; reset variable */
			_unit setVariable ["REV_VAR_isUnconscious", 0, true];
			_unit setDamage 1;

			/* Back to normal, remove effects */
			if (_unit == player) then {
				5 fadeSound 1;
				terminate REV_Unconscious_Effect;
				ppEffectDestroy REV_Video_Blurr_Effect;
				ppEffectDestroy REV_Video_Color_Effect;
			};
			
			/* Closes any dialog that could be open during revive process */
			// need code here to close any dialogs that may be present
			// closeDialog 0;
			
		} else {
		
			/* Player was revived/stabilized */
			_unit setVariable ["REV_VAR_isStabilized", 0, true];
			sleep 6;
			hintSilent "";
			if (REV_VAR_ReviveDamage) then {
				_unit setDamage 0.33;
			} else {
				_unit setDamage 0;
			};
			_unit enableSimulation true;
			// _unit setCaptive false;
			// _unit allowDamage true;
			
			_unit playMove "amovppnemstpsraswrfldnon";
			_unit playMove "";
			
			/* Back to normal, remove effects */
			if (_unit == player) then {
				5 fadeSound 1;
				terminate REV_Unconscious_Effect;
				ppEffectDestroy REV_Video_Blurr_Effect;
				ppEffectDestroy REV_Video_Color_Effect;
			};
			
			/* Closes any dialog that could be open during revive process */
			// need code here to close any dialogs that may be present
			// closeDialog 0;
			
			sleep 0.2;
			/* Select primary weapon after being revived */
			_unit selectWeapon (primaryWeapon _unit);
		};
	} else {
	
		/* Handle AI bleedout */
		_bleedOut = time + REV_VAR_BleedOutTime;
		
		while {!isNull _unit && alive _unit && _unit getVariable "REV_VAR_isUnconscious" == 1 && _unit getVariable "REV_VAR_isStabilized" == 1 && (REV_VAR_BleedOutTime <= 0 || time < _bleedOut)} do {
			sleep 0.5;
		};
		
		if (_unit getVariable "REV_VAR_isStabilized" == 0) then {			
			while { !isNull _unit && alive _unit && _unit getVariable "REV_VAR_isUnconscious" == 1 } do {
				sleep 0.5;
			};
		};
		
		/* AI has bled out, kill the AI unit, and reset */
		if (REV_VAR_BleedOutTime > 0 && {time > _bleedOut} && {_unit getVariable ["REV_VAR_isStabilized",0] == 1}) then	{
			_unit setVariable ["REV_VAR_isUnconscious", 0, true];
			_unit setVariable ["REV_VAR_isStabilized", 0, true];
			_unit setVariable ["REV_VAR_isDragged", 0, true];
			_unit setVariable ["REV_VAR_isCarried", 0, true];
			_unit setDamage 1;
		};
	};
};

/* -------------------------------------------------------------------
	Player Revive
------------------------------------------------------------------- */
REV_FNC_Revive = {
	private ["_target"];
	_target = _this select 0;
	
	if (alive _target) then {
	
		/* Move injured into position and detach from player */
		_target attachTo [player, [0.25, 0.78, 0]];
		_target setDir 270;
		player playActionNow "medicStartRightSide";
		sleep 1.5;
		detach _target;
		_sTime = time;
		
		/* wait until either revive is complete or cancelled */
		waitUntil {
			sleep 1;
			if (alive player && (player distance _target) < 2 && (vehicle player == player) && (time > _sTime + 10) && (alive _target)) then {
				player playActionNow "medicstop";
				hintSilent "Unit Revived";
				detach _target;
				
				/* reset variables */
				_target setVariable ["REV_VAR_isUnconscious", 0, true];
				_target setVariable ["REV_VAR_isDragged", 0, true];
				_target setVariable ["REV_VAR_isCarried", 0, true];
				REV_VAR_BleedOutRate = nil;
				sleep 3;
				
				/* remove map marker */
				[_target] call REV_FNC_DeleteMarker;
				
				/* Select primary of the weapon after being revived */
				sleep 0.2;
				_target selectWeapon (primaryWeapon _target);
		
				/* AI revive code */
				if (!isPlayer _target) then {
					if (REV_VAR_ReviveDamage) then {
						_target setDamage 0.33;
					} else {
						_target setDamage 0;
					};
					_target enableSimulation true;
					_target setCaptive false;
					_target allowDamage true;
					_target enableAI "Move";
					_target playMove "amovppnemstpsraswrfldnon";
				};
				true;
			} else {
				if (alive player && (player distance _target) > 2 && (vehicle player == player) && (time < _sTime + 10) || !(alive _target)) then {
					player playActionNow "medicstop";
					hintSilent "Not Revived";
					detach _target;
					true;
				};
			};
		};
	};
};

/* -------------------------------------------------------------------
	Stabilize Player
------------------------------------------------------------------- */
REV_FNC_Stabilize = {
	private ["_target"];
	_target = _this select 0;

	if (alive _target) then {

		/* Move injured into position and detach from player */
		_target attachTo [player, [0.25, 0.78, 0]];
		_target setDir 270;
		player playActionNow "medicStartRightSide";
		sleep 1.5;
		detach _target;
		_sTime = time;

		/* wait until either stabilized is complete or cancelled */
		waitUntil {
			sleep 1;
			if (alive player && (player distance _target) < 2 && (vehicle player == player) && (time > _sTime + 10) && (alive _target)) then {
				player playActionNow "medicstop";
				hintSilent "Unit Stabilized";
				detach _target;
				
				// player playActionNow "medicstop";
				// detach _target;
				
				if (!("Medikit" in (items player))) then {
					player removeItem "FirstAidKit";
				};
				
				/* set varibale for stabilized state */
				_target setVariable ["REV_VAR_isStabilized", 0, true];
				
				/* set level of damage to half */
				_target setDamage 0.33;
				_target enableAI "Move";
				_target playMoveNow "AmovPpneMstpSrasWrflDnon";
				
				sleep 6;
				true;
			} else {
				if (alive player && (player distance _target) > 2 && (vehicle player == player) && (time < _sTime + 10) || !(alive _target)) then {
					player playActionNow "medicstop";
					hintSilent "Not Stabilized";
					detach _target;
					true;
				};
			};
		};
	};
};

/* -------------------------------------------------------------------
	Drag injured player
------------------------------------------------------------------- */
REV_FNC_Drag = {
	private ["_target", "_id","_player","_aniProne"];

	_player = player;
	_target = _this select 0;
	_aniProne = ["amovppnemstpsraswrfldnon","amovppnemrunslowwrfldf","amovppnemsprslowwrfldfl","amovppnemsprslowwrfldfr","amovppnemrunslowwrfldb","amovppnemsprslowwrfldbl","amovppnemsprslowwrfldr","amovppnemstpsraswrfldnon_turnl","amovppnemstpsraswrfldnon_turnr","amovppnemrunslowwrfldl","amovppnemrunslowwrfldr","amovppnemsprslowwrfldb","amovppnemrunslowwrfldbl","amovppnemsprslowwrfldl","amovppnemsprslowwrfldbr"];
	
	REV_VAR_isDragging = true;

	/* Clear the hint message */
	hintSilent "";
	
	/* Add release action and save its id so it can be removed */
	_id = _player addAction ["<t color=""#C90000"">" + "Release" + "</t>", {call REV_FNC_Actions}, ["actRelease"], 10, true, true, "", "true"];

	if (animationState _player in _aniProne) then {
		
		/* Drag while prone */
		_target attachTo [_player, [0, 1.5, 0.092]];
		_target setDir 180;
		_target setVariable ["REV_VAR_isDragged", 1, true];
		_target switchMove "AinjPpneMstpSnonWrflDnon";
		_target disableAI "Move";
	} else {
		
		/* Drag while crouched */
		_target attachTo [_player, [0, 1.1, 0.092]];
		_target setDir 180;
		_target setVariable ["REV_VAR_isDragged", 1, true];
		_target switchMove "AinjPpneMstpSnonWrflDb";
		_target disableAI "Move";
		_player playMoveNow "AcinPknlMstpSrasWrflDnon";
		sleep 1.25;
		_player playMoveNow "AcinPknlMwlkSrasWrflDb";
	};

	// Waiting for an event terminating the action of dragging
	while {REV_VAR_isDragging && !isNull _player && alive _player && !isNull _target && alive _target} do {
		if !(animationState _player == "AcinPknlMwlkSrasWrflDb" || animationState _player == "AcinPknlMstpSrasWrflDnon" || animationState _player in _aniProne) then {
			_target switchMove "AinjPpneMstpSnonWrflDnon";
			_player removeAction _id;
			detach _target;
			REV_VAR_isDragging = false;
		};
		sleep .5;
	};

	hint "Oops, I fell down";
	
	/* Rotation fix */
	REV_VAR_isDragging_EH = _target;
	publicVariable "REV_VAR_isDragging_EH";
	
	waitUntil {
		sleep .25;
		!alive _player || _player getVariable "REV_VAR_isUnconscious" == 1 || !alive _target || _target getVariable "REV_VAR_isUnconscious" == 0 || !REV_VAR_isDragging || _target getVariable "REV_VAR_isDragged" == 0
	};

	/* Handle release action */
	REV_VAR_isDragging = false;
	
	if (animationState _player in _aniProne) then {
		if (!isNull _target && alive _target) then {
			_target setVariable ["REV_VAR_isDragged", 0, true];
			detach _target;
		};
	} else {
		_target switchMove "AinjPpneMstpSnonWrflDnon";
		_target setVariable ["REV_VAR_isDragged", 0, true];
		detach _target;
	};
	_player removeAction _id;
};

/* -------------------------------------------------------------------
	Carry injured player
------------------------------------------------------------------- */
REV_FNC_Carry = { // WiP
	private ["_target", "_id","_player"];
	_target = _this select 0;
	_player = player;

	REV_VAR_isCarrying = true;

	waitUntil {
		sleep .25;
		animationState _target == "AinjPpneMstpSnonWrflDnon";
	};
	
	if (_target != _player) then {
		_target setVariable ["REV_VAR_isCarried", 1, true];
		_target switchMove "AinjPfalMstpSnonWnonDnon_carried_Up";
		_target attachto [_player,[0.05, 1.1, 0]];
		detach _target;
		_target setPos [getPos _target select 0,getPos _target select 1,0.01];
		[_target, (getDir _player + 180)] call INS_REV_FNCT_setDir;
		[_player, "AcinPknlMstpSrasWrflDnon_AcinPercMrunSrasWrflDnon"] call INS_REV_FNCT_playMoveNow;
		while {animationState _target == "ainjpfalmstpsnonwnondnon_carried_up" && alive _player && !REV_VAR_isCarrying && vehicle _player == _player} do {
			sleep 0.05;
		};
		_player playMove "manPosCarrying";
		sleep 0.1;
	};

	_id = _player addAction ["<t color=""#C90000"">" + "Release" + "</t>", {call REV_FNC_Actions}, ["actRelease"], 10, true, true, "", "true"];
	
	waitUntil {
		sleep .25;
		!alive _player || _player getVariable "REV_VAR_isUnconscious" == 1 || !alive _target || _target getVariable "REV_VAR_isUnconscious" == 0 || !REV_VAR_isCarrying || _target getVariable "REV_VAR_isCarried" == 0
	};
	_player playMoveNow "AcinPknlMstpSrasWrflDnon";

	/* Handle release action */
	REV_VAR_isCarrying = false;
	
	if (!isNull _target && alive _target) then {
		_target switchMove "AinjPpneMstpSnonWrflDnon";
		_target setVariable ["REV_VAR_isCarried", 0, true];
		detach _target;
	};
	_player removeAction _id;
};
	
REV_FNC_Release = {
	private ["_player"];
	_player = player;
	
	/* Default animation */
	if (animationState _player in _aniProne) then {
		_player playMove "amovppnemstpsraswrfldnon";
	} else {
		_player playMove "amovpknlmstpsraswrfldnon";
	};
	REV_VAR_isDragging = false;
	REV_VAR_isCarrying = false;
};

/* -------------------------------------------------------------------
	EH variables
------------------------------------------------------------------- */
REV_FNC_Public_EH = {
	private ["_target","_killed","_killer","_EH"];

	if(count _this < 2) exitWith {};
	
	_EH  = _this select 0;
	_target = _this select 1;

	if (_EH == "REV_VAR_isDragging_EH") then {
		_target setDir 180;
	};
	
	if (_EH == "REV_VAR_isCarrying_EH") then {
		_target setDir 180;
	};
	
	if (_EH == "REV_VAR_DeathMsg") then {
		_killed = _target select 0;
		_killer = _target select 1;

		if (isPlayer _killed && isPlayer _killer) then {
			systemChat format["%1 took a shot in the %3 by %2 at %4:%5", name _killed, name _killer, FinalRound, (date select 3), (date select 4)];
		};
	};
};

/* -------------------------------------------------------------------
	Check for revive action
------------------------------------------------------------------- */
REV_FNC_Revive_Chk = {
	private ["_target", "_isTargetUnconscious", "_isDragged","_isPlayerUnconscious","_isMedic","_isCarried","_return"];
	_return = false;
	
	/* Unit that excutes the action */
	_isPlayerUnconscious = player getVariable "REV_VAR_isUnconscious";
	_isMedic = getNumber (configfile >> "CfgVehicles" >> typeOf player >> "attendant");
	_target = cursorTarget;

	/* Verifies player is alive and that the target is injured */
	if( !alive player || _isPlayerUnconscious == 1 || REV_VAR_isDragging || REV_VAR_isCarrying || isNil "_target" || !alive _target || (!isPlayer _target && !REV_VAR_SP_PlayableUnits) || (_target distance player) > 2 ) exitWith {_return};

	_isTargetUnconscious = _target getVariable "REV_VAR_isUnconscious";
	_isDragged = _target getVariable "REV_VAR_isDragged"; 
	_isCarried = _target getVariable "REV_VAR_isCarried"; 
	
	/* Verifies the target is unconscious and if the player is a medic */
	// if (_isTargetUnconscious == 1 && _isDragged == 0 && (_isMedic == 1 || REV_VAR_ReviveMode > 0) ) then {
	if (_isTargetUnconscious == 1 && _isTargetStabilized == 0 && _isDragged == 0 && _isCarried == 0 && alive _target) then {
		/* Verifies the player has a medikit or firstaidkit in their inventory */
		if (REV_VAR_ReviveMode >= 0 && (!("Medikit" in (items player)) && !("FirstAidKit" in (items player)))) then {
			_return = false;
		};
		if (REV_VAR_ReviveMode == 1 && (("Medikit" in (items player)) || ("FirstAidKit" in (items player)))) then {
			_return = true;
		};
		if (REV_VAR_ReviveMode == 2 && ("Medikit" in (items player))) then {
			_return = true;
		};
		if (REV_VAR_ReviveMode == 0 && (("Medikit" in (items player)) || ("FirstAidKit" in (items player))) && (_isMedic == 1)) then {
			_return = true;
		};
	};
	_return
};

/* -------------------------------------------------------------------
	Check for stabilize action
------------------------------------------------------------------- */
REV_FNC_Stabilize_Chk = {
	private ["_target", "_isTargetUnconscious", "_isDragged","_isCarried","_return","_isPlayerUnconscious","_isTargetStabilized"];
	_return = false;
	
	/* Varifies the unit that will excute the action */
	_isPlayerUnconscious = player getVariable "REV_VAR_isUnconscious";
	_isMedic = getNumber (configfile >> "CfgVehicles" >> typeOf player >> "attendant");
	_target = cursorTarget;

	/* Verifies that the player is alive and if the target is injured */
	if( !alive player || _isPlayerUnconscious == 1 || REV_VAR_isDragging || REV_VAR_isCarrying || isNil "_target" || !alive _target || (!isPlayer _target && !REV_VAR_SP_PlayableUnits) || (_target distance player) > 2 ) exitWith {_return};

	_isTargetUnconscious = _target getVariable "REV_VAR_isUnconscious";
	_isTargetStabilized = _target getVariable "REV_VAR_isStabilized";
	_isDragged = _target getVariable "REV_VAR_isDragged"; 
	_isCarried = _target getVariable "REV_VAR_isCarried"; 
	
	/* Verifies that the target is unconscious, has not been stabilized, and if the player has a FAK or Medikit */
	// if (_isTargetUnconscious == 1 && _isTargetStabilized == 1 && _isDragged == 0 && _isCarried == 0 && (("FirstAidKit" in (items player)) || ("Medikit" in (items player)))) then {
	if (_isTargetUnconscious == 1 && _isTargetStabilized == 1 && _isDragged == 0 && _isCarried == 0 && alive _target) then {
		/* Verifies the player has a medikit or firstaidkit in their inventory */
		if (REV_VAR_ReviveMode >= 0 && (!("Medikit" in (items player)) && !("FirstAidKit" in (items player)))) then {
			_return = false;
		};
		if (REV_VAR_ReviveMode == 2 && (("Medikit" in (items player)) || ("FirstAidKit" in (items player)))) then {
			_return = true;
		};
		if (REV_VAR_ReviveMode == 0 && (("Medikit" in (items player)) || ("FirstAidKit" in (items player)))) then {
			_return = true;
		};
	};
	_return
};

/* -------------------------------------------------------------------
	Check for the suicide action
------------------------------------------------------------------- */
REV_FNC_Suicide_Chk = {
	private ["_return","_isPlayerUnconscious"];
	_return = false;
	_isPlayerUnconscious = player getVariable ["REV_VAR_isUnconscious",0];
	
	if (alive player && _isPlayerUnconscious == 1) then {
		_return = true;
	};
	_return
};

/* -------------------------------------------------------------------
	Check for the drag action
------------------------------------------------------------------- */
REV_FNC_Dragging_Chk = {
	private ["_target", "_isPlayerUnconscious", "_isDragged","_return","_isTargetUnconscious"];
	_return = false;
	_target = cursorTarget;
	_isPlayerUnconscious = player getVariable "REV_VAR_isUnconscious";

	if(!alive player || _isPlayerUnconscious == 1 || REV_VAR_isDragging || isNil "_target" || !alive _target || (!isPlayer _target && !REV_VAR_SP_PlayableUnits) || (_target distance player) > 2 ) exitWith {_return;};
	
	_isTargetUnconscious = _target getVariable "REV_VAR_isUnconscious";
	_isDragged = _target getVariable "REV_VAR_isDragged"; 
	
	if(_isTargetUnconscious == 1 && _isDragged == 0) then {
		_return = true;
	};
	_return
};

/* -------------------------------------------------------------------
	Check for the carry action
------------------------------------------------------------------- */
REV_FNC_Carrying_Chk = {
	private ["_target", "_isPlayerUnconscious", "_isCarried","_return","_isTargetUnconscious"];
	_return = false;
	_target = cursorTarget;
	_isPlayerUnconscious = player getVariable "REV_VAR_isUnconscious";

	if( !alive player || _isPlayerUnconscious == 1 || REV_VAR_isCarrying || isNil "_target" || !alive _target || (!isPlayer _target && !REV_VAR_SP_PlayableUnits) || (_target distance player) > 2 ) exitWith {_return;};
	
	_isTargetUnconscious = _target getVariable "REV_VAR_isUnconscious";
	_isCarried = _target getVariable "REV_VAR_isCarried"; 
	
	if(_isTargetUnconscious == 1 && _isCarried == 0) then {
		_return = true;
	};
	_return
};

/* -------------------------------------------------------------------
	Find the closest "friendly" medic near the player
------------------------------------------------------------------- */
REV_FNC_Friends_Chk = {
	private ["_unit", "_units", "_medics", "_hintMsg","_dist","_unitName","_distance"];
	_units = nearestObjects [getpos player, ["Man", "Car", "Air", "Ship"], 800];
	_medics = [];
	_dist = 800;
	_hintMsg = "";
	
	/* Look for friendly medics */
	if (count _units > 1) then {
		{
			if (_x isKindOf "Car" || _x isKindOf "Air" || _x isKindOf "Ship") then {
				if (alive _x && count (crew _x) > 0) then {
					{
						if (_x call REV_FNC_Friendly_Medic) then {
							_medics = _medics + [_x];
							if (true) exitWith {};
						};
					} forEach crew _x;
				};
			} else {
				if (_x call REV_FNC_Friendly_Medic) then {
					_medics = _medics + [_x];
				};
			};
		} forEach _units;
	};
	
	/* Get the closest medic */
	if (count _medics > 0) then {
		{
			if (player distance _x < _dist) then {
				_unit = _x;
				_dist = player distance _x;
			};
		} forEach _medics;
		
		if (!isNull _unit) then {
			_unitName	= name _unit;
			_distance	= floor (player distance _unit);
			_hintMsg = format["Closest Medic:\n%1 is %2m away.", _unitName, _distance];
			hintSilent "This is where a AI unit will come and stablilize and heal you up.";
		};
	} else {
		_hintMsg = "No medic nearby.";
	};
	_hintMsg
};

/* -------------------------------------------------------------------
	Friendly medic action near the player - WIP
------------------------------------------------------------------- */
REV_FNC_Friendly_Medic = {
	private ["_unit","_return","_isMedic"];
	_return = false;
	_unit = _this;
	_isMedic = getNumber (configfile >> "CfgVehicles" >> typeOf _unit >> "attendant");
				
	if ( alive _unit && (isPlayer _unit || REV_VAR_SP_PlayableUnits) && side _unit == REV_VAR_PlayerSide && _unit getVariable "REV_VAR_isUnconscious" == 0 && (_isMedic == 1 || REV_VAR_ReviveMode > 0) ) then {_return = true;};
	_return
};

/* -------------------------------------------------------------------
	Visual and sound blood/bleeding effects for injured soldier - WIP
------------------------------------------------------------------- */
REV_FNC_BloodEffects = {
	private ["_bloodSFX","_chooseSFX"];

	/* creates effect for player when being shot */
	if (!((_this select 0) isKindOf "Man")) exitWith {};
	_bloodSFX = ["blood1","blood2","blood3","blood4","blood5"];
	_chooseSFX = _bloodSFX select (round(random((count(_bloodSFX))-1)));
	if (isNil "_chooseSFX") then {
		_chooseSFX = 5;
	};
	playMusic _chooseSFX;
};

/* -------------------------------------------------------------------
	Create map marker at the injured units position
------------------------------------------------------------------- */
REV_FNC_CreateMarker = {
	private ["_unit","_mkr"];
	_unit = _this select 0;
	
	if (REV_VAR_Show_Player_Marker && alive _unit) then {
		private ["_mkr"];
		_mkr = createMarker [("REV_mark_" + name _unit), getPos _unit];
		_mkr setMarkerType "mil_triangle";
		_mkr setMarkerColor "colorRed";
		_mkr setMarkerText format ["Unconscious: %1", (name _unit)];
	};
};

/* -------------------------------------------------------------------
	Remove the created map marker when injured unit is revived/dead
------------------------------------------------------------------- */
REV_FNC_DeleteMarker = {
	private ["_unit"];
	_unit = _this select 0;
	
	if (REV_VAR_Show_Player_Marker && alive _unit) then {
		deleteMarker ("REV_mark_" + name _unit);
	};
};

/* -------------------------------------------------------------------
	Create a bleedout rate to be used when the unit is unconscious
------------------------------------------------------------------- */
REV_FNC_BleedOutRate = {
	private ["_unit"];
	_unit = _this select 0;
	if (isNil "REV_VAR_BleedOutRate") then {
		if (!REV_VAR_BleedOutRate && alive _unit) then {
			REV_VAR_BleedRateValue = ((damage _unit)/REV_VAR_BleedOutTime);
			REV_VAR_BleedOutRate = true;
		};
	};
};








