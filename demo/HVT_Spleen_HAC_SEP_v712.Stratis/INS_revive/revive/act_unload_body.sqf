/*
 * Load body action
 * 
 * Copyleft 2013 naong
 * 
 * This program is free software under the terms of the GNU General Public License version 3.
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

private ["_id","_player","_injured","_loaded_vehicle"];

_player = player;
_loaded_vehicle = (_this select 3) select 0;
_injured = (_this select 3) select 1;
_id = _this select 2;

if (vehicle _injured == _loaded_vehicle) then {
	// Unload
	_injured action ["EJECT", vehicle _injured];
	
	// Swtich move
	if (_injured getVariable "INS_REV_PVAR_is_unconscious") then {
		[_injured, "AinjPpneMstpSnonWrflDnon"] call INS_REV_FNCT_switchMove;
		while {animationState _injured != "AinjPpneMstpSnonWrflDnon"} do {
			sleep 0.1;
			[_injured, "AinjPpneMstpSnonWrflDnon"] call INS_REV_FNCT_switchMove;
		};
	};
	
	player sidechat format["'%1' unloaded from '%2'",name _injured, getText(configFile >> 'CfgVehicles' >> typeOf _loaded_vehicle >> 'displayname')];
};

// Remove unload action
INS_REV_GVAR_del_unload = [_loaded_vehicle, _injured];
publicVariable "INS_REV_GVAR_del_unload";
["INS_REV_GVAR_del_unload", INS_REV_GVAR_del_unload] spawn INS_REV_FNCT_remove_unload_action;
_loaded_vehicle removeAction _id;
