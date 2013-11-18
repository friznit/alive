if (_this select 0 != player) exitWith {};

terminate REV_Waiting_For_Revive;
terminate REV_Player_Respawn;
terminate REV_Unconscious_Effect;

// Interruptible context and store the execution thread launched
REV_Waiting_For_Revive = [] spawn {
	private ["_position_before_death", "_height_ATL_before_death", "_direction_before_death", "_magazines_before_death", "_weapons_before_death", "_sacados_avant_mort", "_player"];
	
	// Storing data corpse
	_position_before_death = getPos REV_Dead_Body;
	_height_ATL_before_death = getPosATL REV_Dead_Body select 2;
	_direction_before_death = getDir REV_Dead_Body;
	_magazines_before_death = magazines REV_Dead_Body;
	_weapons_before_death = weapons REV_Dead_Body;
    
	[] spawn {
		titleText ["", "Black out", 10];
	};
	
	closeDialog 0;
	
	[] call REV_FNCT_Delete_Unconcious_Marker;
	
	// If the player was waiting for resuscitation when death
	// Tell everyone his body is no longer in the unconscious state
	REV_End_Unconciousness = REV_Dead_Body;
	publicVariable "REV_End_Unconciousness";
	["REV_End_Unconciousness", REV_End_Unconciousness] spawn REV_FNCT_End_Unconciousness;
	REV_Dead_Body setVariable ["REV_Unconscious", false, true];
	REV_Dead_Body setVariable ["REV_Medical_Support_Unit", nil, true];	
	// Fade to red and black with bloody screen effect and heartbeat sound to symbolized the death of the player
	10 fadeSound 0.4;
	for "_i" from 1 to 10 do {
		REV_Video_Blurr_Effect = ppEffectCreate ["dynamicBlur", 454];
		REV_Video_Blurr_Effect ppEffectEnable true;
		REV_Video_Blurr_Effect ppEffectAdjust [3];
		REV_Video_Blurr_Effect ppEffectCommit 0.01;
		REV_Video_Color_Effect = ppEffectCreate ["colorCorrections", 1554];
		REV_Video_Color_Effect ppEffectEnable true;
		REV_Video_Color_Effect ppEffectAdjust [1, 1, 0, [1,0,0,0.25], [1,0,0,1], [1,0,0,1]]; 
		REV_Video_Color_Effect ppEffectCommit 0.01;

		250 cutRsc ["REV_Wounded_EyePain","PLAIN",0];
		251 cutRsc ["REV_Wounded_BloodSplash","PLAIN",0];
		0 fadeSound 0.2;
		PlaySound "REV_Heartbeat";
		
		sleep 1;
	};
	
	// Wait until the new body appear
	waitUntil {alive player};
	_player = player;
	
	// set player captive status so that the player is not shot at while on the ground
	_player setCaptive true;
	[] spawn {
		titleText ["", "Black in", 6];
	};
	
	// Storing the position of the player
	REV_Revive_Position = getPosATL _player;
	
	if (REV_New_Player_Unit > 0) then {
		private["_switchMove"];
		// Isolate the new body
		//_player setPosATL [_position_before_death select 0, _position_before_death select 1, 2000];
		
		// Random death poses while waiting on revive
		// _switchMove = (floor(round(random 4)));
		
		// switch (_switchMove) do {
			// case 0: {
				// _player switchMove "AinjPpneMstpSnonWrflDnon";
			// };
			// case 1: {
				// _player switchMove "acts_InjuredAngryRifle01";
			// };
			// case 2: {
				// _player switchMove "acts_InjuredCoughRifle02";
			// };
			// case 3: {
				// _player switchMove "acts_InjuredSpeakingRifle01";
			// };
			// case 4: {
				// _player switchMove "Mortar_01_F_Dead";
			// };
		// };
		
		// Laying without weapon in the hands, posture injured
		_player switchMove "AinjPpneMstpSnonWrflDnon";

		// If the player is injured unintentionally (careless explosion, fall, ...), it is not killed
		_player setVariable ["REV_ID_EH_HandleDamage",_player addEventHandler ["HandleDamage",{
				private ["_victim", "_injury", "_attacker", "_ammo_type"];
				_victim = _this select 0;
				_injury = _this select 2;
				_attacker = _this select 3;
				_ammo_type = _this select 4;
				
				if (isNull _attacker || _attacker == _victim || _ammo_type == "") then {
					_victim setDamage 0;
				} else {
					_injury;
				};
			}],
			false
		];
		
		// Opening the dialog box that allows the base respawn and disable the in-game interactions
		closeDialog 0;

		createDialog "REV_DLG_Waiting_For_Revive";
		titleText [STR_REV_Waiting_For_Revive, "PLAIN"];
		
		//sleep 5;
		
		// Bring the new body instead of death
		_player setVelocity [0, 0, 0];
		_player setDir _direction_before_death;
		// _player setPos [_position_before_death select 0, _position_before_death select 1, _height_ATL_before_death - (_position_before_death select 2)];
		_player setPosATL [_position_before_death select 0, _position_before_death select 1, _height_ATL_before_death];
		_player setCaptive true;

		// Remove the old body
		if (REV_Dead_Body != _player) then {
			deleteVehicle REV_Dead_Body;
		};
		
		// It stores the new body for the next time the player dies
		REV_Dead_Body = _player;
		
		// Inform everyone of the start of the unconscious state
		REV_Unconscious_Player = _player;
		publicVariable "REV_Unconscious_Player";
		_player setVariable ["REV_Unconscious", true, true];
		_player setVariable ["REV_Medical_Support_Unit", nil, true];
		
		[] call REV_FNCT_Create_Unconscious_Marker;
		
		// Execution thread generating visuals symbolizing the unconscious state
		// It will be completed as soon as the player has received care
		10 fadeSound 0.4;
		REV_Unconscious_Effect = [] spawn {
			while {true} do {
				for "_i" from 1 to 10 do  {
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
			};
		};
		
		// Waiting for revive
		while {_player getVariable "REV_Unconscious"} do {
			// If we were dragged or treated by someone
			if !(isNil {_player getVariable "REV_Medical_Support_Unit"}) then {
				private ["_treated_by"];
				_treated_by = _player getVariable "REV_Medical_Support_Unit";
				
				// Player is dead or disconnected
				if (isNull _treated_by || !alive _treated_by || !isPlayer _treated_by) then {
					private["_switchMove"];
					detach _player;
					if !(isNull _treated_by) then {
						detach _treated_by;
					};
						// _switchMove = (floor(round(random 4)));
		
						// switch (_switchMove) do {
							// case 0: {
								// _player switchMove "AinjPpneMstpSnonWrflDnon";
							// };
							// case 1: {
								// _player switchMove "acts_InjuredAngryRifle01";
							// };
							// case 2: {
								// _player switchMove "acts_InjuredCoughRifle02";
							// };
							// case 3: {
								// _player switchMove "acts_InjuredSpeakingRifle01";
							// };
							// case 4: {
								// _player switchMove "Mortar_01_F_Dead";
							// };
						// };
					_player switchMove "AinjPpneMstpSnonWrflDnon";
					// _player switchMove "Mortar_01_F_Dead";
					_player setVariable ["REV_Medical_Support_Unit", nil, true]	;
				};
			};
			sleep 0.3;
		};
		
		[] call REV_FNCT_Delete_Unconcious_Marker;
		
		if (REV_CFG_Injured_On_Revive) then {
			// The player is still wounded by measurement of realism
			_player setDamage 0.4;
		};
		
		// Back to normal game
		terminate REV_Unconscious_Effect;
		closeDialog 0;
		5 fadeSound 1;
		ppEffectDestroy REV_Video_Blurr_Effect;
		ppEffectDestroy REV_Video_Color_Effect;
		
		sleep 0.2;
		// Selection of the weapon
		_player selectWeapon (primaryWeapon _player);
		
		// deduct 1 point from revives available
		REV_New_Player_Unit = REV_New_Player_Unit - 1;
		
		// remove the event handler
		_player removeEventHandler ["HandleDamage", _player getVariable "REV_ID_EH_HandleDamage"];
		_player setVariable ["REV_ID_EH_HandleDamage", nil, false];
		
		// restore player to normal and set captive state to false
		_player setCaptive false;
		0 fadeSound 1;
		_player switchmove "";

		if (REV_New_Player_Unit > 0) then {
			if (REV_New_Player_Unit > 1) then {titleText [format [STR_REV_Available_Revives, REV_New_Player_Unit], "PLAIN"];}
			else {titleText [format [STR_REV_One_Revive_Left, REV_New_Player_Unit], "PLAIN"];};
		} else {
			titleText [STR_REV_No_Revive_Left, "PLAIN"];
		};
	} else {
		titleText [STR_REV_Last_Revive, "PLAIN"];
		if (!REV_CFG_Allow_Respawn) then {
		
			// Remove the old body
			if (REV_Dead_Body != _player) then {
				deleteVehicle REV_Dead_Body;
			};

			// allows for a revive cam feature
			if (REV_CFG_Specator_Cam) then {
				// _player exec "camera.sqs";
			};
			
			// Make the dead body without activating the respawn
			// _player switchMove "AdthPpneMstpSrasWrflDnon_2";
			_player setCaptive true;
			_player switchMove "AinjPpneMstpSnonWrflDnon_injuredHealed";
			_player setDamage 0.6;
			0 fadeSound 1;
			
			sleep 5;
			titleText [STR_REV_Player_Kicked, "PLAIN"];
			
			sleep 2;
			5 fadeSound 1;
			ppEffectDestroy REV_Video_Blurr_Effect;
			ppEffectDestroy REV_Video_Color_Effect;
		} else {
			REV_New_Player_Unit = REV_CFG_Number_Revives;
			
			// Back of the body marker of recurrence
			_player setVelocity [0, 0, 0];
			_player setPosATL REV_Revive_Position;
			
			sleep 3;
			titleText [STR_REV_Respawn, "PLAIN"];
			5 fadeSound 1;
			ppEffectDestroy REV_Video_Blurr_Effect;
			ppEffectDestroy REV_Video_Color_Effect;
		};
		
		REV_Dead_Body = _player;
	};
};