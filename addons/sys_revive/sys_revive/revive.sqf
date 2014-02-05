private ["_wounded", "_player", "_i"];

_wounded = _this select 0;
_player = player;

_wounded setVariable ["REV_Medical_Support_Unit", _player, true];

// Animations care
_player attachTo [_wounded, [-0.666, 0.222, 0]];
_player setDir 90;
_player playMoveNow "AinvPknlMstpSnonWrflDnon_medic";

REV_code_distant = [_wounded, "playMoveNow", "AinjPpneMstpSnonWrflDnon_rolltoback"];
publicVariable "REV_code_distant";
["REV_code_distant", REV_code_distant] spawn REV_FNCT_code_distant;

sleep 1.5;
// The player plays an animation of random care
if (!isNull _player && alive _player && !isNull _wounded && alive _wounded) then {
	_player playMove format ["AinvPknlMstpSnonWrflDnon_medic%1", floor random 6];
};

// Wait 12 seconds so that no incident occurs
for [{_i = 0}, {_i < 12 && !isNull _player && alive _player && !isNull _wounded && alive _wounded}, {_i = _i + 1}] do {
	sleep 1;
};

if !(isNull _wounded) then {
	// If the player who revives and wounded did not die in the care
	if (!isNull _player && alive _player && alive _wounded) then {
		// Validation resuscitation
		REV_End_Unconciousness = _wounded;
		publicVariable "REV_End_Unconciousness";
		["REV_End_Unconciousness", REV_End_Unconciousness] spawn REV_FNCT_End_Unconciousness;
		_wounded setVariable ["REV_Unconscious", false, true];
		
		// Discount on the belly and back of the gun
		REV_code_distant = [_wounded, "playMoveNow", "AmovPpneMstpSrasWrflDnon"];
		publicVariable "REV_code_distant";
		["REV_code_distant", REV_code_distant] spawn REV_FNCT_code_distant;
	};
	
	_wounded setVariable ["REV_Medical_Support_Unit", nil, true];
};

// End of care
if !(isNull _player) then {
	if (alive _player) then {
		_player playMoveNow "AinvPknlMstpSnonWrflDnon_medicEnd";
		sleep 1;
	};
	detach _player;
};