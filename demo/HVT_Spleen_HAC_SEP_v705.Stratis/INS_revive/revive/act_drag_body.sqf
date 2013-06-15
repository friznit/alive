/*
 * Drag body action
 * 
 * Copyleft 2013 naong
 * 
 * This program is free software under the terms of the GNU General Public License version 3.
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

private ["_injured", "_player", "_release_body_action","_playerMove","_wrong_moves"];

// Set variable
_injured = _this select 0;
_player = player;
_wrong_moves = ["helper_switchtocarryrfl","acinpknlmstpsraswrfldnon_amovppnemstpsraswrfldnon","acinpknlmstpsraswrfldnon_acinpercmrunsraswrfldnon","acinpercmrunsraswrfldnon","acinpercmrunsraswrfldf"];
INS_REV_GVAR_do_release_body = false;
INS_REV_GVAR_injured = _injured;

// Infrom player is taking care of injured
_injured setVariable ["INS_REV_PVAR_who_taking_care_of_injured", _player, true];

// Add release body action
_release_body_action = _player addAction [STR_INS_REV_action_release_body, "INS_revive\revive\act_release_body.sqf", _injured, 10, false, true, "", ""];

// Add load body action
//_load_body_action = _player addAction [STR_INS_REV_action_load_body, "INS_revive\revive\act_load_body.sqf", _injured, 10, false, true, "", ""];
if (isNil "FNC_check_load_vehicle") then {
	FNC_check_load_vehicle = {
		private ["_objs","_vcl","_result"];
		_result = false;
		_objs = nearestObjects [player, ["Car","Tank","Helicopter","Plane","Boat"], 5];
		INS_REV_GVAR_load_vehicle = nil;
		if (count _objs > 0) then {
			INS_REV_GVAR_load_vehicle = _objs select 0;
			if (alive INS_REV_GVAR_load_vehicle) then {
				_result = true;
			};
		};
		_result
	};
};

private ["_trigger"];
_trigger = createTrigger["EmptyDetector" ,getPos player];
_trigger setTriggerArea [0, 0, 0, true];
_trigger setTriggerActivation ["NONE", "PRESENT", true];
_trigger setTriggerStatements[
	"call FNC_check_load_vehicle",
	"INS_REV_GVAR_loadActionID = player addAction [format[STR_INS_REV_action_load_body,name INS_REV_GVAR_injured,getText(configFile >> 'CfgVehicles' >> typeOf INS_REV_GVAR_load_vehicle >> 'displayname')], 'INS_revive\revive\act_load_body.sqf',[INS_REV_GVAR_injured,INS_REV_GVAR_load_vehicle],10,false];",
	"player removeAction INS_REV_GVAR_loadActionID; INS_REV_GVAR_loadActionID = nil;"
];

//_load_body_action = _player addAction [STR_INS_REV_action_load_body, "INS_revive\revive\act_load_body.sqf", _injured, 10, false, true, "", ""];

//_load_body_action = _player addAction [
//	STR_INS_REV_action_load_body,			/* Title */
//	"INS_revive\revive\act_load_body.sqf",	/* Filename */
//	[],										/* Arguments */
//	10,										/* Priority */
//	false,									/* ShowWindow */
//	true,									/* HideOnUse */
//	"",										/* Shortcut */
//	"player distance _target < 2 && !(player getVariable ""INS_REV_PVAR_is_unconscious"") && call INS_REV_FNCT_can_revive && alive _target && isPlayer _target && (_target getVariable ""INS_REV_PVAR_is_unconscious"") && isNil {_target getVariable ""INS_REV_PVAR_who_taking_care_of_injured""}"	/* Condition */
//];
	
// Attach player to injured
_injured attachTo [_player, [0, 1.1, 0.092]];
[_injured, 180] call INS_REV_FNCT_setDir;

// Start dragging move
_playerMove = "AcinPknlMstpSrasWrflDnon";
_player playMoveNow _playerMove;
waitUntil {animationState player == _playerMove};
waitUntil {(animationState _player == "acinpknlmwlksraswrfldb" || animationState _player == "acinpknlmstpsraswrfldnon")};

// Set injured move
if !(call INS_REV_FNCT_is_finished_dragging) then {
	//if !(GVAR_is_arma3) then {
		[_injured, "AinjPpneMstpSnonWrflDb_grab"] call INS_REV_FNCT_playMoveNow;
	//} else {
	//	[_injured, "AinjPpneMstpSnonWrflDnon"] call INS_REV_FNCT_playMoveNow;
	//};
};

// Wait until dragging is finished
while {!(call INS_REV_FNCT_is_finished_dragging)} do {
	sleep 0.5;
};

// If injured is not disconnected
if !(isNull _injured) then {
	// Detach injured
	detach _injured;
	
	// If injured is alive set move
	if (alive _injured) then {
		[_injured, "AinjPpneMstpSnonWrflDb_release"] call INS_REV_FNCT_playMoveNow;
	} else {
		[_injured, "AinjPpneMstpSnonWrflDnon"] call INS_REV_FNCT_switchMove;
	};
	_injured setVariable ["INS_REV_PVAR_who_taking_care_of_injured", nil, true];
};

// Finish dragging
if !(isNull _player) then {
	// If player is dead, terminate move
	if (!alive _player) then {
		[_player, "AmovPknlMstpSrasWrflDnon"] call INS_REV_FNCT_switchMove;
	} else {
		// If player stand up, terminate move
		if ((animationState _player) in _wrong_moves) then {
			while {(animationState _player) in _wrong_moves} do {
				[_player, "AmovPknlMstpSrasWrflDnon"] call INS_REV_FNCT_switchMove;
				sleep 0.5;
			};
		} else {
			_player playMoveNow "AmovPknlMstpSrasWrflDnon";
		};
	};
};

// Remove  actions
_player removeAction _release_body_action;
if (!isNil "INS_REV_GVAR_loadActionID") then {
	_player removeAction INS_REV_GVAR_loadActionID;
	INS_REV_GVAR_loadActionID = nil;
};

// Remove trigger
deleteVehicle _trigger;
_trigger = nil;

// Clear variable
INS_REV_GVAR_do_release_body = nil;
INS_REV_GVAR_injured = nil;