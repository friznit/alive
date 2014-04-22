#include <\x\alive\addons\sys_revive\script_component.hpp>

/* -------------------------------------------------------------------
	Create player actions
------------------------------------------------------------------- */
GVAR(FNC_Player_Actions) = {
	if (alive player && player isKindOf "Man") then {
		player addAction ["<t color=""#C90000"">" + "Revive" + "</t>", { call GVAR(FNC_Actions)}, ["actRevive"], 10, true, true, "", "call " + QGVAR(FNC_Revive_Chk)];
		player addAction ["<t color=""#C90000"">" + "Suicide" + "</t>", { call GVAR(FNC_Actions)}, ["actSuicide"], 9, false, true, "", "call " + QGVAR(FNC_Suicide_Chk)];
		player addAction ["<t color=""#C90000"">" + "Drag" + "</t>", {call GVAR(FNC_Actions)}, ["actDrag"], 9, false, true, "", "call " + QGVAR(FNC_Dragging_Chk)];
		// player addAction ["<t color=""#C90000"">" + "Carry" + "</t>", { call GVAR(FNC_Actions)}, ["actCarry"], 9, false, true, "", "call " + QGVAR(FNC_Carrying_Chk)];
		player addAction ["<t color=""#C90000"">" + "Stabilize" + "</t>", { call GVAR(FNC_Actions)}, ["actStabilize"], 11, true, true, "", "call " + QGVAR(FNC_Stabilize_Chk)];
	};
};

/* -------------------------------------------------------------------
	Action Execution
------------------------------------------------------------------- */
GVAR(FNC_Actions) = {
	private ["_params", "_action"];
	_params = _this select 3;
	_action = _params select 0;

	if (_action == "actStabilize") then {
		[cursorTarget] spawn GVAR(FNC_Stabilize);
	};

	if (_action == "actRevive") then {
		[cursorTarget] spawn GVAR(FNC_Revive);
	};

	if (_action == "actDrag") then {
		[cursorTarget] spawn GVAR(FNC_Drag);
	};

	// if (_action == "actCarry") then {
		// [cursorTarget] spawn GVAR(FNC_Carry);
	// };

	if (_action == "actRelease") then {
		[] spawn GVAR(FNC_Release);
	};

	if (_action == "actSuicide") then {
		hintSilent "";
		player setDamage 1;
	};
};

/* -------------------------------------------------------------------
	Handle the units death
------------------------------------------------------------------- */
GVAR(FNC_HandleDamage_EH) = {
	private ["_unit", "_killer", "_amountOfDamage", "_isUnconscious"];

	// if (_this select 1 == "") then {
		// diag_log text format ["T=%1 : %2 : %3 : %4", date, _this, _this select 2, time];
	// };
	_unit = _this select 0;
	_amountOfDamage = _this select 2;
	_finalRound = _this select 1;
	_killer = _this select 3;
	_isUnconscious = _unit getVariable QGVAR(VAR_isUnconscious);
	
	if (alive _unit && _amountOfDamage >= 0.9 && _isUnconscious == 0) then {
		_unit setDamage 0;
		_unit allowDamage false;
		GVAR(FinalRound) = _finalRound;
		GVAR(AmountDamage) = round _amountOfDamage;
		_amountOfDamage = 0;
		[_unit, _killer] spawn GVAR(FNC_Player_Unconscious);
	};
	_amountOfDamage;
};

/* -------------------------------------------------------------------
	Make the player unconscious
------------------------------------------------------------------- */
GVAR(FNC_Player_Unconscious) = {
	private["_unit", "_killer","_reviveDamage"];
	_unit = _this select 0;
	_killer = _this select 1;

	_unit setVariable [QGVAR(VAR_isUnconscious), 1, true];
	if (GVAR(VAR_ReviveMode) == 1) then {
		_unit setVariable [QGVAR(VAR_isStabilized), 0, true];
	} else {
		_unit setVariable [QGVAR(VAR_isStabilized), 1, true];
	};
	
	[_unit] call GVAR(FNC_CreateMarker);
	
	/* allows for a revive cam feature, 3rd person view */
	// if (REV_VAR_Spectate) then {
		// need code to allow for 3rd person view of the injured body
	// };

	/* Death message */
	if (GVAR(VAR_TeamKillNotifications) && !isNil "_killer" && isPlayer _killer && _killer != _unit) then {
		GVAR(VAR_DeathMsg) = [_unit, _killer];
		publicVariable QGVAR(VAR_DeathMsg);
		[QGVAR(VAR_DeathMsg), [_unit, _killer]] call GVAR(FNC_Public_EH);
	};
	
	if (isPlayer _unit) then {
		10 fadeSound 0.4;
		GVAR(Unconscious_Effect) = [_unit] spawn {
			_unit = _this select 0;
			waitUntil {
				if (!isNull _unit && alive _unit && _unit getVariable QGVAR(VAR_isUnconscious) == 1 ) then { 
					for "_i" from 1 to GVAR(VAR_BleedOutTime) do  {
						GVAR(Video_Color_Effect) = ppEffectCreate ["colorCorrections", 1554];
						GVAR(Video_Blurr_Effect) = ppEffectCreate ["dynamicBlur", 454];

						GVAR(Video_Color_Effect) ppEffectEnable true;
						GVAR(Video_Blurr_Effect) ppEffectEnable true;

						GVAR(Video_Color_Effect) ppEffectAdjust [1, 1, 0, [1,0,0,0.25], [1,0,0,1], [1,0,0,1]]; 
						GVAR(Video_Color_Effect) ppEffectCommit 0.01;

						GVAR(Video_Blurr_Effect) ppEffectAdjust [3];
						GVAR(Video_Blurr_Effect) ppEffectCommit 0.01;
							
						250 cutRsc ["REV_Wounded_EyePain","PLAIN",0];
						251 cutRsc ["REV_Wounded_BloodSplash","PLAIN",0];
						0 fadeSound 0.2;
						PlaySound "REV_Heartbeat";
						
						sleep 1;
					};
				} else {
					if (!isNull _unit && !(alive _unit) || _unit getVariable QGVAR(VAR_isUnconscious) == 0) then { 
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
	/* sets the amount of damage of the unit, amount will vary based on severity of injury. */
	_unit setDamage (GVAR(AmountDamage)/2.87);
    _unit setVelocity [0,0,0];
	_unit setCaptive true;
	
	/* Variable for downed unit to take damagge or not */
    _unit playMove "AinjPpneMstpSnonWrflDnon_rolltoback";
	sleep 3.5;
	_unit disableAI "Move";
    
	_unit switchMove "AinjPpneMstpSnonWrflDnon";
	_unit enableSimulation false;
	// sleep 5;

	/* makes the unit take or not take damage when unconscious - Body Armor */
	if (GVAR(VAR_isBulletproof)) then {
		_unit allowDamage false;
	} else {
		_unit allowDamage true;
	};
	
	/* makes the unit targetable or not targetable by the enemy - Bullet Magnet */
	if (GVAR(VAR_isBulletMagnet)) then {
		_unit setCaptive false;
	} else {
		_unit setCaptive true;
	};
	
	if (isPlayer _unit) then {
		titleText ["", "BLACK IN", 0];
		disableUserInput false;

		_bleedOut = time + GVAR(VAR_BleedOutTime);
		
		while {!isNull _unit && alive _unit && _unit getVariable QGVAR(VAR_isUnconscious) == 1 && _unit getVariable QGVAR(VAR_isStabilized) == 1 && (GVAR(VAR_BleedOutTime) <= 0 || time < _bleedOut)} do {
			
			if (damage player >= 0.6) then {
				[format["%2, you are bleeding out and will die in %1 seconds", round (_bleedOut - time), name player],0, 0.035 * safezoneH + safezoneY,5,0.3] spawn BIS_fnc_dynamicText;
			} else {
				[format["%1, you are incapacitated...",name player],0, 0.035 * safezoneH + safezoneY,5,0.3] spawn BIS_fnc_dynamicText;
				sleep 3;
			};
			
			/* debug */
			if (GVAR(Debug)) then {
				hintSilent format["Bleedout in %1 seconds\n\n%2\n\nBleedout rate: %3\n\nRegen Rate: %4\n\nPlayer Damage: %5\n\nDamage Amount: %6", round (_bleedOut - time), call GVAR(FNC_Friends_Chk), GVAR(playerBleedRate),GVAR(playerRegenRate),GVAR(playerDamage),GVAR(AmountDamage)];
			};
			/* end of debug */
			
			sleep 1;
		};
		
		/* Unit has been stabilized */
		if (_unit getVariable QGVAR(VAR_isStabilized) == 0) then {
			while { !isNull _unit && alive _unit && _unit getVariable QGVAR(VAR_isUnconscious) == 1 } do {
				[format["%1, you have been stabilized.", name player],0, 0.035 * safezoneH + safezoneY,5,0.3] spawn BIS_fnc_dynamicText;
				if (GVAR(Debug)) then {
					hintSilent format["You have been stabilized\n\n%1", call GVAR(FNC_Friends_Chk)];
					sleep 0.5;
				};
			};
		};
		
		/* Handle player bleedout */
		if (GVAR(VAR_BleedOutTime) > 0 && {time > _bleedOut} && {_unit getVariable [QGVAR(VAR_isStabilized),0] == 1}) then {
			[format["%1, you have died from excessive blood loss.", name player],0, 0.035 * safezoneH + safezoneY,5,0.3] spawn BIS_fnc_dynamicText;
		
			/* Player bled out and died; reset variable */
			_unit setVariable [QGVAR(VAR_isUnconscious), 0, true];
			_unit setDamage 1;

			/* Back to normal, remove effects */
			if (_unit == player) then {
				5 fadeSound 1;
				terminate GVAR(Unconscious_Effect);
				ppEffectDestroy GVAR(Video_Blurr_Effect);
				ppEffectDestroy GVAR(Video_Color_Effect);
			};
			
			/* Closes any dialog that could be open during revive process */
			// need code here to close any dialogs that may be present
			// closeDialog 0;
			
		} else {
		
			/* Player was revived/stabilized */
			_unit setVariable [QGVAR(VAR_isStabilized), 0, true];
			sleep 6;
			hintSilent "";
			
			/* sets damage after being revived or stabilized */
			if (GVAR(VAR_ReviveDamage)) then {
				if (damage _unit > 0.35) then {
					_reviveDamage = 0.33;
				} else {
					_reviveDamage = (damage _unit);
				};
				_unit setDamage _reviveDamage;
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
				terminate GVAR(Unconscious_Effect);
				ppEffectDestroy GVAR(Video_Blurr_Effect);
				ppEffectDestroy GVAR(Video_Color_Effect);
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
		_bleedOut = time + GVAR(VAR_BleedOutTime);
		
		while {!isNull _unit && alive _unit && _unit getVariable QGVAR(VAR_isUnconscious) == 1 && _unit getVariable QGVAR(VAR_isStabilized) == 1 && (GVAR(VAR_BleedOutTime) <= 0 || time < _bleedOut)} do {
			sleep 0.5;
		};
		
		if (_unit getVariable QGVAR(VAR_isStabilized) == 0) then {			
			while { !isNull _unit && alive _unit && _unit getVariable QGVAR(VAR_isUnconscious) == 1 } do {
				sleep 0.5;
			};
		};
		
		/* AI has bled out, kill the AI unit, and reset */
		if (GVAR(VAR_BleedOutTime) > 0 && {time > _bleedOut} && {_unit getVariable [QGVAR(VAR_isStabilized),0] == 1}) then {
			_unit setVariable [QGVAR(VAR_isUnconscious), 0, true];
			_unit setVariable [QGVAR(VAR_isStabilized), 0, true];
			_unit setVariable [QGVAR(VAR_isDragged), 0, true];
			_unit setVariable [QGVAR(VAR_isCarried), 0, true];
			_unit setDamage 1;
		};
	};
};

/* -------------------------------------------------------------------
	Player Revive
------------------------------------------------------------------- */
GVAR(FNC_Revive) = {
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
				_target setVariable [QGVAR(VAR_isUnconscious), 0, true];
				_target setVariable [QGVAR(VAR_isDragged), 0, true];
				_target setVariable [QGVAR(VAR_isCarried), 0, true];
				GVAR(VAR_BleedOutRate) = nil;
				sleep 3;
				
				/* remove map marker */
				[_target] call GVAR(FNC_DeleteMarker);
				
				/* Select primary of the weapon after being revived */
				sleep 0.2;
				_target selectWeapon (primaryWeapon _target);
		
				/* AI revive code */
				if (!isPlayer _target) then {
					if (GVAR(VAR_ReviveDamage)) then {
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
GVAR(FNC_Stabilize) = {
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
				_target setVariable [QGVAR(VAR_isStabilized), 0, true];
				
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
GVAR(FNC_Drag) = {
	private ["_target", "_id","_player","_aniProne"];

	_player = player;
	_target = _this select 0;
	_aniProne = ["amovppnemstpsraswrfldnon","amovppnemrunslowwrfldf","amovppnemsprslowwrfldfl","amovppnemsprslowwrfldfr","amovppnemrunslowwrfldb","amovppnemsprslowwrfldbl","amovppnemsprslowwrfldr","amovppnemstpsraswrfldnon_turnl","amovppnemstpsraswrfldnon_turnr","amovppnemrunslowwrfldl","amovppnemrunslowwrfldr","amovppnemsprslowwrfldb","amovppnemrunslowwrfldbl","amovppnemsprslowwrfldl","amovppnemsprslowwrfldbr"];
	
	GVAR(VAR_isDragging) = true;

	/* Clear the hint message */
	hintSilent "";
	
	/* Add release action and save its id so it can be removed */
	_id = _player addAction ["<t color=""#C90000"">" + "Release" + "</t>", {call GVAR(FNC_Actions)}, ["actRelease"], 10, true, true, "", "true"];

	if (animationState _player in _aniProne) then {
		
		/* Drag while prone */
		_target attachTo [_player, [0, 1.5, 0.092]];
		_target setDir 180;
		_target setVariable [QGVAR(VAR_isDragged), 1, true];
		_target switchMove "AinjPpneMstpSnonWrflDnon";
		_target disableAI "Move";
	} else {
		
		/* Drag while crouched */
		_target attachTo [_player, [0, 1.1, 0.092]];
		_target setDir 180;
		_target setVariable [QGVAR(VAR_isDragged), 1, true];
		_target switchMove "AinjPpneMstpSnonWrflDb";
		_target disableAI "Move";
		_player playMoveNow "AcinPknlMstpSrasWrflDnon";
		sleep 1.25;
		_player playMoveNow "AcinPknlMwlkSrasWrflDb";
	};

	// Waiting for an event terminating the action of dragging
	while {(GVAR(VAR_isDragging)) && (!isNull _player) && (alive _player) && (!isNull _target) && (alive _target)} do {
		if !(animationState _player == "AcinPknlMwlkSrasWrflDb" || animationState _player == "AcinPknlMstpSrasWrflDnon" || animationState _player in _aniProne) then {
			_target switchMove "AinjPpneMstpSnonWrflDnon";
			_player removeAction _id;
			detach _target;
			GVAR(VAR_isDragging) = false;
		};
		sleep .5;
	};

	hint "I let go!";
	
	/* Rotation fix */
	GVAR(VAR_isDragging_EH) = _target;
	publicVariable QGVAR(VAR_isDragging_EH);
	
	waitUntil {
		sleep .25;
		!alive _player || _player getVariable QGVAR(VAR_isUnconscious) == 1 || !alive _target || _target getVariable QGVAR(VAR_isUnconscious) == 0 || !GVAR(VAR_isDragging) || _target getVariable QGVAR(VAR_isDragged) == 0
	};

	/* Handle release action */
	GVAR(VAR_isDragging) = false;
	
	if (animationState _player in _aniProne) then {
		if (!isNull _target && alive _target) then {
			_target setVariable [QGVAR(VAR_isDragged), 0, true];
			detach _target;
		};
	} else {
		_target switchMove "AinjPpneMstpSnonWrflDnon";
		_target setVariable [QGVAR(VAR_isDragged), 0, true];
		detach _target;
	};
	_player removeAction _id;
};

/* -------------------------------------------------------------------
	Carry injured player
------------------------------------------------------------------- */
GVAR(FNC_Carry) = { // WiP
	private ["_target", "_id","_player"];
	_target = _this select 0;
	_player = player;

	GVAR(VAR_isCarrying) = true;

	waitUntil {
		sleep .25;
		animationState _target == "AinjPpneMstpSnonWrflDnon";
	};
	
	if (_target != _player) then {
		_target setVariable [QGVAR(VAR_isCarried), 1, true];
		_target switchMove "AinjPfalMstpSnonWnonDnon_carried_Up";
		_target attachto [_player,[0.05, 1.1, 0]];
		detach _target;
		_target setPos [getPos _target select 0,getPos _target select 1,0.01];
		[_target, (getDir _player + 180)] call INS_REV_FNCT_setDir;
		[_player, "AcinPknlMstpSrasWrflDnon_AcinPercMrunSrasWrflDnon"] call INS_REV_FNCT_playMoveNow;
		while {animationState _target == "ainjpfalmstpsnonwnondnon_carried_up" && alive _player && !GVAR(VAR_isCarrying) && vehicle _player == _player} do {
			sleep 0.05;
		};
		_player playMove "manPosCarrying";
		sleep 0.1;
	};

	_id = _player addAction ["<t color=""#C90000"">" + "Release" + "</t>", {call GVAR(FNC_Actions)}, ["actRelease"], 10, true, true, "", "true"];
	
	waitUntil {
		sleep .25;
		!alive _player || _player getVariable QGVAR(VAR_isUnconscious) == 1 || !alive _target || _target getVariable QGVAR(VAR_isUnconscious) == 0 || !GVAR(VAR_isCarrying) || _target getVariable QGVAR(VAR_isCarried) == 0
	};
	_player playMoveNow "AcinPknlMstpSrasWrflDnon";

	/* Handle release action */
	GVAR(VAR_isCarrying) = false;
	
	if (!isNull _target && alive _target) then {
		_target switchMove "AinjPpneMstpSnonWrflDnon";
		_target setVariable [QGVAR(VAR_isCarried), 0, true];
		detach _target;
	};
	_player removeAction _id;
};

/* -------------------------------------------------------------------
	Relase option for dragging or carrying an injured unit
------------------------------------------------------------------- */
GVAR(FNC_Release) = {
	private ["_player"];
	_player = player;
	
	/* Default animation */
	if (animationState _player in _aniProne) then {
		_player playMove "amovppnemstpsraswrfldnon";
	} else {
		_player playMove "amovpknlmstpsraswrfldnon";
	};
	GVAR(VAR_isDragging) = false;
	GVAR(VAR_isCarrying) = false;
};

/* -------------------------------------------------------------------
	EH variables
------------------------------------------------------------------- */
GVAR(FNC_Public_EH) = {
	private ["_target","_killed","_killer","_EH"];

	if(count _this < 2) exitWith {};
	
	_EH  = _this select 0;
	_target = _this select 1;

	if (_EH == QGVAR(VAR_isDragging_EH)) then {
		_target setDir 180;
	};
	
	if (_EH == QGVAR(VAR_isCarrying_EH)) then {
		_target setDir 180;
	};
	
	if (_EH == QGVAR(VAR_DeathMsg)) then {
		_killed = _target select 0;
		_killer = _target select 1;

		if (isPlayer _killed && isPlayer _killer) then {
			systemChat format["%1 took a shot in the %3 by %2 at %4:%5", name _killed, name _killer, GVAR(FinalRound), (date select 3), (date select 4)];
		};
	};
};

/* -------------------------------------------------------------------
	Check for revive action
------------------------------------------------------------------- */
GVAR(FNC_Revive_Chk) = {
	private ["_target", "_isTargetUnconscious", "_isDragged","_isPlayerUnconscious","_isMedic","_isCarried","_return","_isTargetStabilized","_action"];

	/* Variables used */
	_return = false;
	_target = cursorTarget;
	_isTargetUnconscious = _target getVariable QGVAR(VAR_isUnconscious);
	_isTargetStabilized = _target getVariable QGVAR(VAR_isStabilized);
	_isPlayerUnconscious = player getVariable QGVAR(VAR_isUnconscious);
	_isDragged = _target getVariable QGVAR(VAR_isDragged); 
	_isCarried = _target getVariable QGVAR(VAR_isCarried); 
	_isMedic = getNumber (configfile >> "CfgVehicles" >> typeOf player >> "attendant");
	
	/* Verifies player is alive, player is conscious, and that the player is close to target */
	if(!alive player || _isPlayerUnconscious == 1 || GVAR(VAR_isDragging) || isNil "_target" || !alive _target || (!isPlayer _target && !GVAR(VAR_SP_PlayableUnits)) || (_target distance player) > 2 ) exitWith {_return};

	/* Verifies revive mode and if the player has either medkit or FAK */
	if ((GVAR(VAR_ReviveMode) >= 0) && !("Medikit" in (items player)) && !("FirstAidKit" in (items player))) exitWith {_return};

	/* Verifies the target is alive, unconscious, stabilized, and not being dragged or carried */
	/* Revive Menu Action */
	if ((_isTargetUnconscious == 1) && (_isTargetStabilized == 0) && (_isDragged == 0) && (_isCarried == 0) && (alive _target)) then {
	
		/* mode one: default action */
		if (GVAR(VAR_ReviveMode) == 1) then {
			if (("Medikit" in (items player)) || ("FirstAidKit" in (items player))) then {
				_return = true;
			};
		};

		/* mode two:  */
		if (GVAR(VAR_ReviveMode) == 2) then {
			if ("Medikit" in (items player)) then {
				_return = true;
			};
		};

		/* mode zero: Medic only mode - units can stabilize only */
		if ((GVAR(VAR_ReviveMode)) == 0) then {
			if (("Medikit" in (items player)) && (_isMedic == 1)) then {
				_return = true;
			};
		};
	};
	_return
};

/* -------------------------------------------------------------------
	Check for stabilize action
------------------------------------------------------------------- */
GVAR(FNC_Stabilize_Chk) = {
	private ["_target", "_isTargetUnconscious", "_isDragged","_isPlayerUnconscious","_isMedic","_isCarried","_return","_isTargetStabilized","_action"];

	/* Variables used */
	_return = false;
	_target = cursorTarget;
	_isTargetUnconscious = _target getVariable QGVAR(VAR_isUnconscious);
	_isTargetStabilized = _target getVariable QGVAR(VAR_isStabilized);
	_isPlayerUnconscious = player getVariable QGVAR(VAR_isUnconscious);
	_isDragged = _target getVariable QGVAR(VAR_isDragged); 
	_isCarried = _target getVariable QGVAR(VAR_isCarried); 
	_isMedic = getNumber (configfile >> "CfgVehicles" >> typeOf player >> "attendant");
	
	/* Verifies player is alive, player is conscious, and that the player is close to target */
	if(!alive player || _isPlayerUnconscious == 1 || GVAR(VAR_isDragging) || isNil "_target" || !alive _target || (!isPlayer _target && !GVAR(VAR_SP_PlayableUnits)) || (_target distance player) > 2 ) exitWith {_return};

	/* Verifies revive mode and if the player has either medkit or FAK */
	if ((GVAR(VAR_ReviveMode) >= 0) && !("Medikit" in (items player)) && !("FirstAidKit" in (items player))) exitWith {_return};

	/* Verifies the target is alive, unconscious, NOT stabilized, and not being dragged or carried */
	/* Stabilize/Patch Menu Action */
	if ((_isTargetUnconscious == 1) && (_isTargetStabilized == 1) && (_isDragged == 0) && (_isCarried == 0) && (alive _target)) then {
		
		/* mode one: default action - option not available - revive only */
		if (GVAR(VAR_ReviveMode) == 1) then {
			_return;
		};

		/* mode two:  */
		if (GVAR(VAR_ReviveMode) == 2) then {
			if (("Medikit" in (items player)) || ("FirstAidKit" in (items player))) then {
				_return = true;
			};
		};

		/* mode zero: Medic only mode - units can stabilize only */
		if (GVAR(VAR_ReviveMode) == 0) then {
			if (("Medikit" in (items player)) || ("FirstAidKit" in (items player))) then {
				_return = true;
			};
		};
	};
	_return
};

/* -------------------------------------------------------------------
	Check for the suicide action
------------------------------------------------------------------- */
GVAR(FNC_Suicide_Chk) = {
	private ["_return","_isPlayerUnconscious"];
	_return = false;
	_isPlayerUnconscious = player getVariable [QGVAR(VAR_isUnconscious),0];
	
	if (alive player && _isPlayerUnconscious == 1) then {
		_return = true;
	};
	_return
};

/* -------------------------------------------------------------------
	Check for the drag action
------------------------------------------------------------------- */
GVAR(FNC_Dragging_Chk) = {
	private ["_target", "_isPlayerUnconscious", "_isDragged","_return","_isTargetUnconscious"];
	_return = false;
	_target = cursorTarget;
	_isPlayerUnconscious = player getVariable QGVAR(VAR_isUnconscious);

	if(!alive player || _isPlayerUnconscious == 1 || GVAR(VAR_isDragging) || isNil "_target" || !alive _target || (!isPlayer _target && !GVAR(VAR_SP_PlayableUnits)) || (_target distance player) > 2 ) exitWith {_return;};
	
	_isTargetUnconscious = _target getVariable QGVAR(VAR_isUnconscious);
	_isDragged = _target getVariable QGVAR(VAR_isDragged); 
	
	if(_isTargetUnconscious == 1 && _isDragged == 0) then {
		_return = true;
	};
	_return
};

/* -------------------------------------------------------------------
	Check for the carry action
------------------------------------------------------------------- */
GVAR(FNC_Carrying_Chk) = {
	private ["_target", "_isPlayerUnconscious", "_isCarried","_return","_isTargetUnconscious"];
	_return = false;
	_target = cursorTarget;
	_isPlayerUnconscious = player getVariable QGVAR(VAR_isUnconscious);

	if( !alive player || _isPlayerUnconscious == 1 || GVAR(VAR_isCarrying) || isNil "_target" || !alive _target || (!isPlayer _target && !GVAR(VAR_SP_PlayableUnits)) || (_target distance player) > 2 ) exitWith { _return;};
	
	_isTargetUnconscious = _target getVariable QGVAR(VAR_isUnconscious);
	_isCarried = _target getVariable QGVAR(VAR_isCarried); 
	
	if(_isTargetUnconscious == 1 && _isCarried == 0) then {
		_return = true;
	};
	_return
};

/* -------------------------------------------------------------------
	Find the closest "friendly" medic near the player
------------------------------------------------------------------- */
GVAR(FNC_Friends_Chk) = {
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
						if (_x call GVAR(FNC_Friendly_Medic)) then {
							_medics = _medics + [_x];
							if (true) exitWith {};
						};
					} forEach crew _x;
				};
			} else {
				if (_x call GVAR(FNC_Friendly_Medic)) then {
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
			hintSilent "This is where an AI unit will come and revive/stabilize you up.";
		};
	} else {
		_hintMsg = "No medic nearby.";
	};
	_hintMsg
};

/* -------------------------------------------------------------------
	Friendly medic action near the player - WIP
------------------------------------------------------------------- */
GVAR(FNC_Friendly_Medic) = {
	private ["_unit","_return","_isMedic"];
	_return = false;
	_unit = _this;
	_isMedic = getNumber (configfile >> "CfgVehicles" >> typeOf _unit >> "attendant");
				
	if ( alive _unit && (isPlayer _unit || GVAR(VAR_SP_PlayableUnits)) && side _unit == GVAR(VAR_PlayerSide) && _unit getVariable QGVAR(VAR_isUnconscious) == 0 && (_isMedic == 1 || GVAR(VAR_ReviveMode) > 0) ) then {_return = true;};
	_return
};

/* -------------------------------------------------------------------
	Visual and sound blood/bleeding effects for injured soldier - WIP
------------------------------------------------------------------- */
GVAR(FNC_BloodEffects) = {
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
GVAR(FNC_CreateMarker) = {
	private ["_unit","_mkr"];
	_unit = _this select 0;
	
	if (GVAR(VAR_Show_Player_Marker) && alive _unit) then {
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
GVAR(FNC_DeleteMarker) = {
	private ["_unit"];
	_unit = _this select 0;
	
	if (GVAR(VAR_Show_Player_Marker) && alive _unit) then {
		deleteMarker ("REV_mark_" + name _unit);
	};
};

/* -------------------------------------------------------------------
	Create a bleedout rate to be used when the unit is unconscious
------------------------------------------------------------------- */
GVAR(FNC_BleedOutRate) = {
	private ["_unit"];
	_unit = _this select 0;
	if (isNil QGVAR(VAR_BleedOutRate)) then {
		if (!GVAR(VAR_BleedOutRate) && alive _unit) then {
			GVAR(VAR_BleedRateValue) = ((damage _unit)/GVAR(VAR_BleedOutTime));
			GVAR(VAR_BleedOutRate) = true;
		};
	};
};








