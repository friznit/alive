/*
 * Revive action
 * 
 * Copyleft 2013 naong
 * 
 * This program is free software under the terms of the GNU General Public License version 3.
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

private ["_injured", "_player", "_i","_playerMove","_startTime","_cancel_revive_action"];

scopeName "main";

// Set variable
_injured = _this select 0;
_player = player;
_startTime = time;
_reviveTakeTime = INS_REV_CFG_revive_take_time + (random 5);
INS_REV_GVAR_cancel_revive = false;

// Check medkit
if (INS_REV_CFG_require_medkit) then {
	private ["_uniformItems","_vestItems","_backpackItems","_itemList"];
	_uniformItems = uniformItems _player;
	_vestItems = vestItems _player;
	_backpackItems = backpackItems _player;
	
	_itemList = _uniformItems + _vestItems + _backpackItems;
	
	if !("FirstAidKit" in _itemList) then {
		_player sidechat "You don't have a First Aid Kit."; 
		breakOut "main";
	};
};

// Infrom player is taking care of injured
_injured setVariable ["INS_REV_PVAR_who_taking_care_of_injured", _player, true];

// Attach to injured
_player attachTo [_injured, [-0.888, 0.222, 0]];
_player setDir 90;
_player playMoveNow "AinvPknlMstpSnonWrflDnon_medic";

// Set injured move
[_injured, "AinjPpneMstpSnonWrflDnon_rolltoback"] call INS_REV_FNCT_playMoveNow;

// Detach player
if (GVAR_is_arma3) then {
	if ([_player] call INS_REV_FNCT_is_underwater) then {
		waitUntil {animationState _player == "AinvPknlMstpSnonWrflDnon_medic" || _startTime + _reviveTakeTime < time};
	} else {
		sleep 0.5;
	};
} else {
	sleep 0.5;
};
detach _player;

// Add cancel revive action
_cancel_revive_action = player addAction [
							STR_INS_REV_action_cancel_revive,				/* Title */
							"INS_revive\revive\act_cancel_revive.sqf",		/* Filename */
							[],												/* Arguments */
							10,												/* Priority */
							false,											/* ShowWindow */
							true,											/* HideOnUse */
							"",												/* Shortcut */
							""												/* Condition */
						];

// Wait _reviveTakeTime until player is alive and injured is not disconnected
while {!isNull _player && alive _player && !isNull _injured && alive _injured && _startTime + _reviveTakeTime > time && !INS_REV_GVAR_cancel_revive} do {
	_playerMove = format ["AinvPknlMstpSnonWrflDnon_medic0", floor random 6];
	_player playMove _playerMove;
	waitUntil {animationState _player == _playerMove || INS_REV_GVAR_cancel_revive || _startTime + _reviveTakeTime < time};
	waitUntil {animationState _player != _playerMove || INS_REV_GVAR_cancel_revive || _startTime + _reviveTakeTime < time};
	_player playMoveNow "AinvPknlMstpSnonWrflDnon_medic";
};


// Check medkit
if (INS_REV_CFG_require_medkit) then {
	private ["_uniformItems","_vestItems","_backpackItems","_itemList"];
	_uniformItems = uniformItems _player;
	_vestItems = vestItems _player;
	_backpackItems = backpackItems _player;
	
	_itemList = _uniformItems + _vestItems + _backpackItems;
	
	if !("FirstAidKit" in _itemList) then {
		// Reset variable
		_injured setVariable ["INS_REV_PVAR_who_taking_care_of_injured", nil, true];

		// Finish player revive action
		if !(isNull _player) then {
			if (alive _player && !INS_REV_GVAR_cancel_revive) then {
				_player playMoveNow "AinvPknlMstpSnonWrflDnon_medicEnd";
				sleep 1;
			} else {
				_player playMoveNow "amovpknlmstpsraswrfldnon";
			};
			_player removeAction _cancel_revive_action;
		};

		// Clear variable
		INS_REV_GVAR_cancel_revive = nil;
		_player sidechat "You don't have a First Aid Kit. Revive failed."; 
		breakOut "main";
	} else {
		_player removeItem "FirstAidKit";
	};
};

// If injured is not disconnected
if !(isNull _injured) then {
	// If player and injured is alive
	if (!isNull _player && alive _player && alive _injured && !INS_REV_GVAR_cancel_revive) then {
		// Remove actions
		if !(PVAR_isAce) then {
			INS_REV_GVAR_end_unconscious = _injured;
			publicVariable "INS_REV_GVAR_end_unconscious";
			["INS_REV_GVAR_end_unconscious", INS_REV_GVAR_end_unconscious] spawn INS_REV_FNCT_remove_actions;
		};
		
		// Set variable
		_injured setVariable ["INS_REV_PVAR_is_unconscious", false, true];
		
		// Set injured move
		[_injured, "AmovPpneMstpSrasWrflDnon"] call INS_REV_FNCT_playMoveNow;
		//[_injured, "AmovPpneMstpSnonWnonDnon_healed"] call INS_REV_FNCT_playMoveNow;
	};
	
	// Reset variable
	_injured setVariable ["INS_REV_PVAR_who_taking_care_of_injured", nil, true];
};

// Finish player revive action
if !(isNull _player) then {
	if (alive _player && !INS_REV_GVAR_cancel_revive) then {
		_player playMoveNow "AinvPknlMstpSnonWrflDnon_medicEnd";
		sleep 1;
	} else {
		_player playMoveNow "amovpknlmstpsraswrfldnon";
	};
	_player removeAction _cancel_revive_action;
};

// Clear variable
INS_REV_GVAR_cancel_revive = nil;