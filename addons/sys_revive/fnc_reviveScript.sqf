#include <\x\alive\addons\sys_revive\script_component.hpp>

/* Compile revive functions */
call compile preprocessFile "\x\alive\addons\sys_revive\_revive\revive_functions.sqf";

/* Revive Version */
// #define REV_VERSION "v0.91"
["ALIVE Wounding System Initialized...v0.91"] call ALIVE_fnc_dumpR;

////////////////////////////// this is the script version variable section
/* Debug mode */
// REV_Debug = true;

/* Debug mode */
// REV_Language = "en";

/* -------------------------------------------------------------------
	Revive mode/type

	0 = Medic units can revive/stabilize...(medkit is required to revive, all other units can just stabilize)
	1 = All units can revive...(requires either a medkit or firstaid kit) - default setting
	2 = All units can revive/stabilize...(requires a medikit to revive; a firstaidkit can only stabilize)
------------------------------------------------------------------- */
// REV_VAR_ReviveMode = 1;

/* Set the bleed out time (certain death) - 30 seconds is for testing, default value should be 300 */
// REV_VAR_BleedOutTime = 300;

/* Allows units to still take damage when unconcious and during revive - true = invincible, false = bullet magnet */
// REV_VAR_isBulletproof = false;

/* Sets an injured unit to a captive state so the enemy will ignore and not fire on the injured unit */
// REV_VAR_isBulletMagnet = true;

/* Makes playable units revivable both in SP and MP modes */
// REV_VAR_AI_PlayableUnits = true;

/* Enable teamkill notifications */
// REV_VAR_TeamKillNotifications = true;

/* Number of revives/lives allowed */
// REV_VAR_NumRevivesAllowed = 12;  //TODO - This needs to be implemented

/* Revive with damage, not full health when revived */
// REV_VAR_ReviveDamage = true;  //TODO - This needs to be implemented

/* Allows an injured player to commit suicide and respawn at base, deducts from number of revives */
// REV_VAR_Suicide = true;  //TODO - This needs to be implemented

/* Allow unit to be dragged or not */
// REV_VAR_AllowDrag = true;  //TODO - This needs to be implemented

/* Allow unit to be carried or not */
// REV_VAR_AllowCarry = true;  //TODO - This needs to be implemented

/* Allows downed player to view 3rd persion while waiting to be revived */
// REV_VAR_Spectate = false;  //TODO - This needs to be implemented

/* Adds screen effects to player from bullets */
// REV_VAR_BulletEffects = true;

/* Create marker to show on the map where the unconscious player is located */
// REV_VAR_Show_Player_Marker = true; 

///////////////////////////// end of old script version variables section

/* -------------------------------------------------------------------
	Player Event Handlers
------------------------------------------------------------------- */
[] spawn {
    waitUntil {
		sleep .25;
		!isNull player;
	};

	/* Public event handlers */
	QGVAR(VAR_isDragging_EH) addPublicVariableEventHandler GVAR(FNC_Public_EH);
	QGVAR(VAR_isCarrying_EH) addPublicVariableEventHandler GVAR(FNC_Public_EH);
	QGVAR(VAR_DeathMsg) addPublicVariableEventHandler GVAR(FNC_Public_EH);

	player addEventHandler [
		"HandleDamage", GVAR(FNC_HandleDamage_EH)
	];
	
	player addEventHandler [
		"Killed",{
			_body = _this select 0;
			[_body] spawn {
				0 fadeSound .25;
				0 fadeMusic 0;
				sleep 3;
				"dynamicBlur" ppEffectAdjust[0];
				"dynamicBlur" ppEffectCommit 2;
				waitUntil {
					sleep 0.025;
					alive player;
				};
				_body = _this select 0;
				deleteVehicle _body;
				[player] call GVAR(FNC_DeleteMarker);
				terminate GVAR(Unconscious_Effect);
				250 cutText ["", "PLAIN"];
				251 cutText ["", "PLAIN"];
				ppEffectDestroy GVAR(Video_Blurr_Effect);
				ppEffectDestroy GVAR(Video_Color_Effect);
			};
		}
	];
	
	/* Damage Indication EH - adds bullet hit effects to player */
	if (GVAR(VAR_BulletEffects)) then {
		player addEventHandler ["hit",{
			[_this select 1] spawn GVAR(FNC_BloodEffects);
			"colorCorrections" ppEffectAdjust[1, 1.8, -0.2, [4.5 - ((damage player)*5), 3.5, 1.6, -0.02],[1.8 - ((damage player)*5), 1.6, 1.6, 1],[-1.5 + ((damage player)*5),0,-0.2,1]];
			"colorCorrections" ppEffectCommit 0.05;
			addCamShake [1 + random 2, 0.4 + random 1, 15];
		}];
	};

	/* Death EH - adds effects to the player when killed */
	// player addEventHandler ["killed",{
		// 0 fadeSound .25;
		// 0 fadeMusic 0;
		// [] spawn {
			// sleep 3;
			// "dynamicBlur" ppEffectAdjust[0];
			// "dynamicBlur" ppEffectCommit 2;
		// };
	// }];

	/* Respawn EH - when player respawns, this reapplies revive to the new unit */
	player addEventHandler [
		"Respawn",{
			[] spawn GVAR(FNC_Player_Init);
			1 fadeSound 1;
			1 fadeMusic 1;
		}
	];
	
	/* initialize the player */
	[] spawn GVAR(FNC_Player_Init);
};

/* -------------------------------------------------------------------
	Player Init Function
------------------------------------------------------------------- */
GVAR(FNC_Player_Init) = {

	/* Store players side */
	GVAR(VAR_PlayerSide) = side player;
	
	sleep 5;
	hintSilent "";
	
	/* resetting variables and values */
	player setVariable [QGVAR(VAR_isUnconscious), 0, true];
	player setVariable [QGVAR(VAR_isStabilized), 0, true];
	player setVariable [QGVAR(VAR_isDragged), 0, true];
	player setVariable [QGVAR(VAR_isCarried), 0, true];
	player setCaptive false;

	GVAR(VAR_isDragging) = false;
	GVAR(VAR_isDragging_EH) = [];
	GVAR(VAR_isCarrying) = false;
	GVAR(VAR_isCarrying_EH) = [];
	GVAR(VAR_DeathMsg) = [];
	
	/* Create actions for players */
	[] spawn GVAR(FNC_Player_Actions);
};

/* -------------------------------------------------------------------
	Drag & Carry animation fix
------------------------------------------------------------------- */
[] spawn {
	waitUntil {
		sleep 1;
		if (animationState player == "acinpknlmstpsraswrfldnon_acinpercmrunsraswrfldnon" || animationState player == "helper_switchtocarryrfl" || animationState player == "AcinPknlMstpSrasWrflDnon") then {
			if (GVAR(VAR_isDragging)) then {
				player switchMove "AcinPknlMstpSrasWrflDnon";
			} else {
				player switchMove "amovpknlmstpsraswrfldnon";
			};
			if (GVAR(VAR_isCarrying)) then {
				player switchMove "AcinPknlMstpSrasWrflDnon";
			} else {
				player switchMove "amovpknlmstpsraswrfldnon";
			};
		};
	};
};

/* -------------------------------------------------------------------
	Health regeneration and bleedout effects
------------------------------------------------------------------- */
[] spawn {
	private ["_fatigue","_oxygen","_hRegenRate"];
	
	while {alive player} do {
		/* Variables */
		_fatigue = getFatigue player;
		_oxygen = getOxygenRemaining player;
		
		if (isNil QGVAR(playerBleedRate)) then {
			GVAR(playerBleedRate) = 0;
		};
		if (isNil QGVAR(playerRegenRate)) then {
			GVAR(playerRegenRate) = 0;
		};
		if (isNil QGVAR(playerDamage)) then {
			GVAR(playerDamage) = 0;
		};
		
		/* Health regeneration/bleedout */
		_hRegenRate = (1 - _fatigue);
		if (_hRegenRate == 0) then {
			_hRegenRate = 1;
		};
		
		waitUntil {player getVariable QGVAR(VAR_isUnconscious) == 1};
		
		if (damage player >= 0.6) then {
			
			/* Bleeding out */
			player setDamage ((damage player) + ((1-(getFatigue player))*(0.0017)));
			// player setDamage ((damage player) + ((1-(getFatigue player))/GVAR(VAR_BleedOutTime)));
			if (GVAR(Debug)) then {
				GVAR(playerBleedRate) = ((damage player) + ((1-(getFatigue player))*(0.0017)));
			};
		} else {

			/* Regeneration */
			if (damage player < 0.6 && damage player > 0.25) then {
				player setDamage (damage player - ((random(0.015)) + (getFatigue player/95)));
				player setVariable [GVAR(isUnconscious),0,true];
				if (GVAR(Debug)) then {
					GVAR(playerRegenRate) = (damage player - ((random(0.015)) + (getFatigue player/95)));
				};
			} else {
				if (damage player <= 0.25) then {
					/* reset variables */
					player setVariable [QGVAR(VAR_isUnconscious), 0, true];
					player setVariable [QGVAR(VAR_isDragged), 0, true];
					player setVariable [QGVAR(VAR_isCarried), 0, true];
					sleep 3;
					
					/* Back to normal game, remove effects */
					5 fadeSound 1;
					ppEffectDestroy GVAR(Video_Blurr_Effect);
					ppEffectDestroy GVAR(Video_Color_Effect);
					sleep 0.2;
					
					/* remove map marker */
					[player] call GVAR(FNC_DeleteMarker);
					
					/* Select primary weapon after being revived */
					player selectWeapon (primaryWeapon player);
					
					/* set players state for captive and damage */
					player setCaptive false;
					player allowDamage true;
					
					/* terminate all effects and exit */
					terminate GVAR(Unconscious_Effect);
					250 cutText ["", "PLAIN"];
					251 cutText ["", "PLAIN"];

				};
			};
		};
		
		if (GVAR(Debug)) then {
			GVAR(playerDamage) = (damage player);
		};
		
		if (getPosASLW player select 2 > 0) then {
		
			/* Health/Fatigue ColorCorrection */
			"colorCorrections" ppEffectAdjust[1, (1-(damage player)/4)+_fatigue/3, ((-0.02)-((damage player)/10)), [4.5 - ((damage player)*5) - _fatigue/2, 3.5, 1.6+_fatigue/3, -0.02],[1.8 - ((damage player)*5), 1.6, 1.6, 1],[-1.5 + ((damage player)*5),0,-0.2,1]];
			"colorCorrections" ppEffectCommit 0.1;
		
			/* Health/Fatigue Blur */
			"dynamicBlur" ppEffectEnable true;
			"dynamicBlur" ppEffectAdjust[((damage player)/2) + _fatigue/3];
			"dynamicBlur" ppEffectCommit 0.1;
		} else {
		
			/* Blur underwater */
			"RadialBlur" ppEffectEnable true; 
			"RadialBlur" ppEffectAdjust[abs(speed player)/10000,abs(speed player)/20000 + _fatigue,0.3,0.1];
			"RadialBlur" ppEffectCommit 0.1;
			"dynamicBlur" ppEffectEnable true; 
			"dynamicBlur" ppEffectAdjust[(1-_oxygen)*3];
			"dynamicBlur" ppEffectCommit 0.1;
		};
		sleep 1;
	};
};

/* -------------------------------------------------------------------
	AI Unit Settings
------------------------------------------------------------------- */
if (GVAR(VAR_AI_PlayableUnits) > 0) then {
	/* Add revive to ALL Playable AI units */
	if (GVAR(VAR_AI_PlayableUnits) == 1) then {
		{
			if (!isPlayer _x) then {
				_x addEventHandler ["HandleDamage", GVAR(FNC_HandleDamage_EH)];
				_x setVariable [QGVAR(VAR_isUnconscious), 0, true];
				_x setVariable [QGVAR(VAR_isStabilized), 0, true];
				_x setVariable [QGVAR(VAR_isDragged), 0, true];
				_x setVariable [QGVAR(VAR_isCarried), 0, true];
			};
		} forEach switchableUnits;
	};
	/* Add revive to ALL AI units on side of player */
	if (GVAR(VAR_AI_PlayableUnits) == 2) then {
		[] call GVAR(FNC_UnitSideArray);
	};
	/* Add revive to ALL AI units (Friendly, Enemy, & Civillian */
	if (GVAR(VAR_AI_PlayableUnits) == 3) then {
		[] call GVAR(FNC_UnitArray);
	};
};
