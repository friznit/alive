// Functionality available only when nobody takes care of injured
if !(isNil {player getVariable "REV_Medical_Support_Unit"}) then {
	titleText [STR_REV_Receiving_Medical_Attention, "PLAIN"];
	// titleText [format [STR_REV_Receiving_Medical_Attention, REV_New_Player_Unit], "PLAIN"]; // needs to be set-up to read player performing action
} else {
	// terminate all possible execution is closed
	terminate REV_Waiting_For_Revive;
	terminate REV_Player_Respawn;
	terminate REV_Unconscious_Effect;
	
	// Locking the thread of execution issued
	REV_Player_Respawn = [] spawn {
		private ["_player"];
		_player = player;
		
		closeDialog 0;
		
		call REV_FNCT_Delete_Unconcious_Marker;
		
		// Inform everyone of the end of the unconscious state
		REV_End_Unconciousness = _player;
		publicVariable "REV_End_Unconciousness";
		["REV_End_Unconciousness", REV_End_Unconciousness] spawn REV_FNCT_End_Unconciousness;
		_player setVariable ["REV_Unconscious", false, true];
		_player setVariable ["REV_Medical_Support_Unit", nil, true];
		
		// They hide what happens to the player (player + animations in the air forced)
		REV_Video_Color_Effect ppEffectAdjust [0.25, 1, 0, [0, 0, 0, 0], [0, 0, 0, 0], [0, 0, 0, 0]];
		REV_Video_Color_Effect ppEffectCommit 0;
		titleText [STR_REV_BTN_Respawn_In_Progress, "PLAIN"];
		0 fadeSound 1;

		REV_Dead_Body = _player;
		
		// Insulate the body
		//_player setPosATL [getPosATL _player select 0, getPosATL _player select 1, (getPosATL _player select 2)+2000];
		
		// Stop wounded animation, recovery weapon standing
		_player selectWeapon (primaryWeapon _player);
		_player playMoveNow "AmovPercMstpSlowWrflDnon";
		
		sleep 3;
		
		// Back of the body marker of recurrence
		_player setVelocity [0, 0, 0];
		_player setPosATL REV_Revive_Position;
		
		// Removed the possible EH HandleDamage
		if !(isNil {_player getVariable "REV_ID_EH_HandleDamage"}) then {
			_player removeEventHandler ["HandleDamage", _player getVariable "REV_ID_EH_HandleDamage"];
			_player setVariable ["REV_ID_EH_HandleDamage", nil, false];
		};
		
		_player setCaptive false;
		_player switchMove "";
		
		// Restoration of the number of possible resuscitation
		REV_New_Player_Unit = REV_CFG_Number_Revives;
		
		titleText ["", "PLAIN"];
		ppEffectDestroy REV_Video_Blurr_Effect;
		ppEffectDestroy REV_Video_Color_Effect;
	};
};