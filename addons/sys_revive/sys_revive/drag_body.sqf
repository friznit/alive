private ["_wounded", "_player", "_id_action"];

_wounded = _this select 0;
_player = player;

_wounded setVariable ["REV_Medical_Support_Unit", _player, true];
REV_Release_Body = false;
_id_action = _player addAction [STR_REV_Action_Release_Body, SYS_RevPath+"sys_revive\release_body.sqf", _wounded, 10, false, true, "", ""];

// Is attached to the injured player
_wounded attachTo [_player, [0, 1.1, 0.092]];
REV_code_distant = [_wounded, "setDir", 180];
publicVariable "REV_code_distant";
["REV_code_distant", REV_code_distant] spawn REV_FNCT_code_distant;

// The player shoots the wounded by the handle of his waistcoat
_player playMoveNow "AcinPknlMstpSrasWrflDnon";
sleep 1;
if (!isNull _player && alive _player && !isNull _wounded && alive _wounded) then {
	REV_code_distant = [_wounded, "playMoveNow", "AinjPpneMstpSnonWrflDb_grab"];
	publicVariable "REV_code_distant";
	["REV_code_distant", REV_code_distant] spawn REV_FNCT_code_distant;
};

sleep 3;

// Waiting for an event terminating the action of dragging
while {!REV_Release_Body && !isNull _player && alive _player && !isNull _wounded && alive _wounded && isPlayer _wounded &&
	(animationState _player == "acinpknlmwlksraswrfldb" || animationState _player == "acinpknlmstpsraswrfldnon")} do {
	sleep 0.1;
};

// The wounded is released
if !(isNull _wounded) then {
	detach _wounded;
	if (alive _wounded) then {
		REV_code_distant = [_wounded, "playMoveNow", "AinjPpneMstpSnonWrflDb_release"];
		publicVariable "REV_code_distant";
		["REV_code_distant", REV_code_distant] spawn REV_FNCT_code_distant;
	} else {
		REV_code_distant = [_wounded, "switchMove", "AinjPpneMstpSnonWrflDnon"];
		publicVariable "REV_code_distant";
		["REV_code_distant", REV_code_distant] spawn REV_FNCT_code_distant;
	};
	_wounded setVariable ["REV_Medical_Support_Unit", nil, true];
};

// The player comes out of the movie dragging the wounded
if !(isNull _player) then {
	if (alive _player) then {
		// The player wanted to sleep while he was dragging the body
		if (animationState _player == "acinpknlmstpsraswrfldnon_amovppnemstpsraswrfldnon") then {
			// It does set
			_player playMoveNow "AmovPpneMstpSrasWrflDnon";
		} else {
			// Back to knees
			_player playMoveNow "AmovPknlMstpSrasWrflDnon";
		};
	} else {
		// Avoid bug ArmA the body sliding on the ground indefinitely
		_player switchMove "AmovPknlMstpSrasWrflDnon";
	};
	_player removeAction _id_action;
};

REV_Release_Body = nil;