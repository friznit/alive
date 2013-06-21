/*
 * INS_revive functions for Arma 2 OA
 * 
 * Copyleft 2013 naong
 * 
 * This program is free software under the terms of the GNU General Public License version 3.
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.

// Get backpack data for Arma 2 OA
// Usage : '[unit] call INS_REV_FNCT_get_loadout_a2oa;'
// Return : array
INS_REV_FNCT_get_loadout_a2oa = {
	private ["_backpack","_result"];
	
	_backpack = unitBackpack (_this select 0);
	
	if (isNull _backpack) then {
		_result = [];
	} else {
		_result = [
			typeOf _backpack,
			getWeaponCargo _backpack,
			getMagazineCargo _backpack
		];
	};
	
	_result
};
 */

// Set backpack data for Arma 2 OA
// Usage : '[unit, backapck_data_array] call INS_REV_FNCT_set_loadout_a2oa;'
INS_REV_FNCT_set_loadout_a2oa = {
	private ["_unit", "_backpack_data"];

	_unit = _this select 0;
	_backpack_data = _this select 1;

	// If the unit has a backpack, remove it
	if !(isNull (unitBackpack _unit)) then
	{
		removeBackpack _unit;
	};

	// If there's backpack data
	if (count _backpack_data == 3) then
	{
		private ["_backpack", "_commande_init", "_i"];
		
		// Remove all items from backpack
		_commande_init = "";
		_commande_init = _commande_init + "clearWeaponCargo this;";
		_commande_init = _commande_init + "clearMagazineCargo this;";
		
		// Add weapons to backpack
		for [{_i = 0}, {_i < count (_backpack_data select 1 select 0)}, {_i = _i+1}] do
		{
			_commande_init = _commande_init + format ["this addWeaponCargo [""%1"",%2];",
				_backpack_data select 1 select 0 select _i,
				_backpack_data select 1 select 1 select _i];
		};
		
		// Add magazine to backpack
		for [{_i = 0}, {_i < count (_backpack_data select 2 select 0)}, {_i = _i+1}] do
		{
			_commande_init = _commande_init + format ["this addMagazineCargo [""%1"",%2];",
				_backpack_data select 2 select 0 select _i,
				_backpack_data select 2 select 1 select _i];
		};
		
		// Add backpack to unit
		_unit addBackpack (_backpack_data select 0);
		_backpack = unitBackpack _unit;
		_backpack setVehicleInit _commande_init;
		processInitCommands;
	};
};

// Disable thermal cam
// Usage : 'call INS_REV_FNCT_disalble_thermal_cam;'
INS_REV_FNCT_disalble_thermal_cam = {
	false setCamUseTi 0;
};

INS_REV_FNCT_a2oa_init_completed = true;