/*
 * INS_revive functions for Arma 3
 * 
 * Copyleft 2013 naong
 * 
 * This program is free software under the terms of the GNU General Public License version 3.
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

// Get loadout
// Usage(thread) : '[unit] call INS_REV_FNCT_get_loadout;'
// Return : array
// INS_REV_FNCT_get_loadout = compile preprocessFileLineNumbers 'INS_revive\loadout\fnc_get_loadout.sqf';

// Set loadout
// Usage : '[unit, loadout_array] call INS_REV_FNCT_set_loadout;'
// INS_REV_FNCT_set_loadout = compile preprocessFileLineNumbers 'INS_revive\loadout\fnc_set_loadout.sqf';  

// Prevent drown
// Usage : '[unit] call INS_REV_FNCT_prevent_drown;'
INS_REV_FNCT_prevent_drown = {
	private "_unit";
	_unit = _this select 0;
	_unit setOxygenRemaining 1;
};

// Check unit is underwater
// Usage(thread) : '[unit] call INS_REV_FNCT_is_underwater;'
// Return : boot
INS_REV_FNCT_is_underwater = {
	private ["_unit","_result"];
	_unit = _this select 0;
	_result = underwater _unit;
	_result
};

// Disable thermal cam
// Usage : 'call INS_REV_FNCT_disalble_thermal_cam;'
INS_REV_FNCT_disalble_thermal_cam = {
	false setCamUseTi 0;
};

INS_REV_FNCT_a3_init_completed = true;