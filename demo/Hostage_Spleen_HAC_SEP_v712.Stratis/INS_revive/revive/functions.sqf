/*
 * INS_revive functions
 * 
 * Copyleft 2013 naong
 * 
 * This program is free software under the terms of the GNU General Public License version 3.
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */
 
// Remote execution
INS_REV_FNCT_remote_exec = {
	private ["_unit", "_command", "_parameter"];
	_unit = _this select 1 select 0;
	_command = _this select 1 select 1;
	_parameter = _this select 1 select 2;
	
	if (_command == "switchMove") exitWith {
		_unit switchMove _parameter;
	};
	if (_command == "allowDamage") exitWith {
		if (_parameter) then {
			_unit allowDamage true;
			_unit setCaptive false;
		} else {
			_unit allowDamage false;
			_unit setCaptive true;
		};
	};
	
	if (local _unit) then 
	{
		switch (_command) do
		{
			//case "switchMove":	{_unit switchMove _parameter;};
			case "setDir":		{_unit setDir _parameter;};
			case "playMove":	{_unit playMove _parameter;};
			case "playMoveNow":	{_unit playMoveNow _parameter;};
			case "moveInCargo":	{_unit moveInCargo _parameter;};
		};
	};
};
"INS_REV_GVAR_remote_exec" addPublicVariableEventHandler INS_REV_FNCT_remote_exec;

// Switch move
// Usage : '[_unit, _move] call INS_REV_FNCT_switchMove;'
INS_REV_FNCT_switchMove = {
	private ["_unit","_move"];
	
	_unit = _this select 0;
	_move = _this select 1;
	
	//_unit switchMove _move;
	//processInitCommands;
	INS_REV_GVAR_remote_exec = [_unit, "switchMove", _move];
	publicVariable "INS_REV_GVAR_remote_exec";
	["INS_REV_GVAR_remote_exec", INS_REV_GVAR_remote_exec] spawn INS_REV_FNCT_remote_exec;
};

// Set allow damage
// Usage : '[_unit, _value] call INS_REV_FNCT_allowDamage;'
INS_REV_FNCT_allowDamage = {
	private ["_unit", "_value"];
	
	_unit = _this select 0;
	_value = _this select 1;
	
	INS_REV_GVAR_remote_exec = [_unit, "allowDamage", _value];
	publicVariable "INS_REV_GVAR_remote_exec";
	["INS_REV_GVAR_remote_exec", INS_REV_GVAR_remote_exec] spawn INS_REV_FNCT_remote_exec;
};

// Set dir
// Usage : '[_unit, _value] call INS_REV_FNCT_setDir;'
INS_REV_FNCT_setDir = {
	private ["_unit","_dir"];
	_unit = _this select 0;
	_dir = _this select 1;
	
	INS_REV_GVAR_remote_exec = [_unit, "setDir", _dir];
	publicVariable "INS_REV_GVAR_remote_exec";
	["INS_REV_GVAR_remote_exec", INS_REV_GVAR_remote_exec] spawn INS_REV_FNCT_remote_exec;
};

// Play move now
// Usage : '[_unit, _move] call INS_REV_FNCT_playMoveNow;'
INS_REV_FNCT_playMoveNow = {
	private ["_unit","_move"];
	_unit = _this select 0;
	_move = _this select 1;
	
	INS_REV_GVAR_remote_exec = [_unit, "playMoveNow", _move];
	publicVariable "INS_REV_GVAR_remote_exec";
	["INS_REV_GVAR_remote_exec", INS_REV_GVAR_remote_exec] spawn INS_REV_FNCT_remote_exec;
};

// Move in cargo
// Usage : '[_unit, _vehicle] call INS_REV_FNCT_moveInCargo;'
INS_REV_FNCT_moveInCargo = {
	private ["_unit","_vehicle"];
	
	_unit = _this select 0;
	_vehicle = _this select 1;
	
	INS_REV_GVAR_remote_exec = [_unit, "moveInCargo", _vehicle];
	publicVariable "INS_REV_GVAR_remote_exec";
	["INS_REV_GVAR_remote_exec", INS_REV_GVAR_remote_exec] spawn INS_REV_FNCT_remote_exec;
};

// Check vehicle is full
// Usage : 'call INS_REV_FNCT_vclisFull;'
// Return : bool
INS_REV_FNCT_vclisFull = { 
	if (_this isKindOf "man" || _this isKindOf "building") exitWith { false };
	if (_this emptyPositions "Driver" > 0) exitWith { false };
	if (_this emptyPositions "Gunner" > 0)exitWith  { false };
	if (_this emptyPositions "Commander" > 0) exitWith { false };
	if (_this emptyPositions "Cargo" > 0) exitWith { false };
	if (isNull (_this turretUnit [0])) exitWith { false };
	true
};

// Move in vehicle
// Usage : '[unit, vehicle] call INS_REV_FNCT_moveInVehicle;'
INS_REV_FNCT_moveInVehicle = { 
    private ["_id","_unit","_vehicle"];
    
    _unit = _this select 0;
    _vehicle = _this select 1;
    
	//if (_vehicle emptyPositions "Driver" > 0) exitWith { _unit action["getInDriver", _vehicle]; };
	if (_vehicle emptyPositions "Driver" > 0) exitWith { _unit moveInDriver _vehicle; };
	
	//if (_vehicle emptyPositions "Gunner" > 0) exitWith { _unit action["getInTurret", _vehicle, [0]]; };
    if (_vehicle emptyPositions "Gunner" > 0) exitWith { _unit moveInGunner _vehicle; };
    
    // Turret
	if (isNull (_vehicle turretUnit [0])) exitWith { _unit moveInTurret [_vehicle, [0]]; };
	
	//if (_vehicle emptyPositions "Commander" > 0) exitWith { _unit action["getInCommander", _vehicle]; };
    if (_vehicle emptyPositions "Commander" > 0) exitWith { _unit moveInCommander _vehicle; };
    
    if (_vehicle emptyPositions "Cargo" > 0) exitWith { 
		_id = count (crew _vehicle - [driver _vehicle] - [gunner _vehicle] - [commander _vehicle]);
		//_unit action["getInCargo", _vehicle, _id];
		_unit moveInCargo [_vehicle, _id];
	};
    
};

// Check object is respawn locations
// Usage : 'object call INS_REV_FNCT_isRespawnLocation;'
// Return : bool
INS_REV_FNCT_isRespawnLocation = {
	private ["_location", "_respawnLocations"];
	
	// Set variable
	_location = _this;
	_result = false;
	_respawnLocations = call INS_REV_FNCT_get_respawn_locations;
	
	// Check location
	if (_location in _respawnLocations) then {
		_result = true;
	};
	
	// Retrun value
	_result
};

// Get respawn locations and alive players
// Usage : 'call INS_REV_FNCT_getFriendly;'
// Return : array
INS_REV_FNCT_getFriendly = {
    private ["_playerSide", "_respawn_locations", "_aliveFriendlyUnits","_result","_temp"];
    
    // Check respawn type
    if (INS_REV_CFG_respawn_type == "ALL") then {
		// Get units
		_aliveFriendlyUnits = call INS_REV_FNCT_getAlivePlayers;
	} else {
		// Check respawn type
		if (INS_REV_CFG_respawn_type == "SIDE") then {
			// Get alive friendly units
			_aliveFriendlyUnits = call INS_REV_FNCT_getAliveFriendlyUnits;
		} else {
			// Get alive group units
			_aliveFriendlyUnits = call INS_REV_FNCT_getAliveGroupUnits;
		};
	};
	
	// Check dead unit (Life time over)
	if (INS_REV_CFG_life_time > 0 && INS_REV_CFG_respawn_location == "BASE") then {
		private "_tempArr";
		_tempArr = _aliveFriendlyUnits;
		_aliveFriendlyUnits = [];
		{
			if !(_x getVariable "INS_REV_PVAR_is_dead") then {
				_aliveFriendlyUnits = _aliveFriendlyUnits + [_x];
			};
		} forEach _aliveFriendlyUnits;
	};
	
	// Get respawn locations
	if (INS_REV_CFG_respawn_location == "FRIENDLY_UNIT") then {
		_respawn_locations = [];
	} else {
		_respawn_locations = call INS_REV_FNCT_get_respawn_locations;
	};
	
	// Set temporary result
	_result = [];
	_result = _result + _aliveFriendlyUnits + _respawn_locations;
	
	// If you can revive your body, add it.
	if (count _result == 0) then {
		_result = [player];
	} else {
		if (call INS_REV_FNCT_can_respawn_player_body) then {
			if (count _aliveFriendlyUnits == 0) then {
				_temp = _result;
				_result = [player] + _temp;
			} else {
				_result = _result + [player];
			};
		};
	};
	
	// return value
	_result
};

// Get respawn locations
// Usage : 'call INS_REV_FNCT_get_respawn_locations;'
// Return : array
INS_REV_FNCT_get_respawn_locations = {
	 private ["_playerSide","_location", "_respawn_locations", "_respawn_locations_result"];
    
    // Check respawn type
    if (INS_REV_CFG_respawn_type == "ALL") then {
    	// Get respawn loacations
		_respawn_locations = INS_REV_CFG_list_of_respawn_locations_blufor + INS_REV_CFG_list_of_respawn_locations_opfor + INS_REV_CFG_list_of_respawn_locations_civ + INS_REV_CFG_list_of_respawn_locations_guer;
	} else {
		// Get respawn loacations
		_playerSide = player getVariable "INS_REV_PVAR_playerSide";
		switch (_playerSide) do {
			case WEST: {
				_respawn_locations = INS_REV_CFG_list_of_respawn_locations_blufor;
			};
			case EAST: {
				_respawn_locations = INS_REV_CFG_list_of_respawn_locations_opfor;
			};
			case CIV: {
				_respawn_locations = INS_REV_CFG_list_of_respawn_locations_civ;
			};
			case GUER: {
				_respawn_locations = INS_REV_CFG_list_of_respawn_locations_guer;
			};
		};
	};
	
	// Check respawn location is alive
	_respawn_locations_result = [];
	{
		// String to Object
		_location = call compile format["%1",_x];
		
		if (alive _location) then {
			_respawn_locations_result = _respawn_locations_result + [_location];
		};
	} forEach _respawn_locations;
	
	_respawn_locations_result
};

// Get all players
// Usage : 'call INS_REV_FNCT_getAllPlayers;'
// Return : array
INS_REV_FNCT_getAllPlayers = {
	private ["_playableUnits","_result"];
	
	// Set variable
	_playableUnits = playableUnits;
	_result = [];
	
	// Check unit is player
	{
		if (isPlayer _x) then {
			_result = _result + [_x];
		};
	} forEach _playableUnits;
	
	// Retrun value
	_result
};

// Get all alive players
// Usage : 'call INS_REV_FNCT_getAlivePlayers;'
// Return : array
INS_REV_FNCT_getAlivePlayers = {
	private ["_allPlayers","_result"];
	
	// Set variable
	_allPlayers = call INS_REV_FNCT_getAllPlayers;
	_result = [];
	
	// Check unit is alive
	{
		if (alive _x && !(_x getVariable "INS_REV_PVAR_is_unconscious")) then {
			_result = _result + [_x];
		};
	} forEach _allPlayers;
	
	// Retrun value
	_result
};

// Get all friendlfy players
// Usage : 'call INS_REV_FNCT_getAllFriendlyUnits;'
// Return : array
INS_REV_FNCT_getAllFriendlyUnits = {
	private ["_allPlayers","_result","_playerSide"];
	
	// Set variable
	_allPlayers = call INS_REV_FNCT_getAllPlayers;
	_playerSide = player getVariable "INS_REV_PVAR_playerSide";
	_result = [];
	
	// Check unit is friendly
	{
		if (_x getVariable "INS_REV_PVAR_playerSide" == _playerSide) then {
			_result = _result + [_x];
		};
	} forEach _allPlayers;
	
	// Retrun value
	_result
};

// Get alive friendly players
// Usage : 'call INS_REV_FNCT_getAliveFriendlyUnits;'
// Return : array
INS_REV_FNCT_getAliveFriendlyUnits = {
	private ["_friendlyUnits","_result"];
	
	// Set variable
	_friendlyUnits = call INS_REV_FNCT_getAllFriendlyUnits;
	_result = [];
	
	// Check unit is alive
	{
		if (alive _x && !(_x getVariable "INS_REV_PVAR_is_unconscious")) then {
			_result = _result + [_x];
		};
	} forEach _friendlyUnits;
	
	_result
};

// Get all group players
// Usage : 'call INS_REV_FNCT_getAllGroupUnits;'
// Return : array
INS_REV_FNCT_getAllGroupUnits = {
	private ["_playerGroup","_groupUnits","_result"];
	
	// Set variable
	_playerGroup = player getVariable "INS_REV_PVAR_playerGroup";
	_groupUnits = units _playerGroup;
	_result = [];
	
	// Check is playable unit
	{
		if (isPlayer _x) then {
			_result = _result + [_x];
		};
	} forEach _groupUnits;
	
	// Retrun value
	_result
};

// Get alive group players
// Usage : 'call INS_REV_FNCT_getAliveGroupUnits;'
// Return : array
INS_REV_FNCT_getAliveGroupUnits = {
	private ["_playableUnits","_result","_playerSide"];
	
	// Set variable
	_groupUnits = call INS_REV_FNCT_getAllGroupUnits;
	_result = [];
	
	// Check is alive unit
	{
		if (alive _x && !(_x getVariable "INS_REV_PVAR_is_unconscious")) then {
			_result = _result + [_x];
		};
	} forEach _groupUnits;
	
	// Retrun value
	_result
};

// Check enemies near player
// Usage : '[unit] call INS_REV_FNCT_is_near_enemy;'
// Return : bool
INS_REV_FNCT_is_near_enemy = { 
	private ["_result","_arr1","_arr2","_playerSide"];
	scopeName "main";
	
	_result = false;
	_arr1  = nearestObjects[_this select 0, ["LandVehicle"],INS_REV_CFG_near_enemy_range]; 
	_arr2  = nearestObjects[_this select 0, ["Man"], INS_REV_CFG_near_enemy_range];	
	_playerSide = player getVariable "INS_REV_PVAR_playerSide";
	
	{
	if (side _x != _playerSide && primaryWeapon _x != "" && alive _x && isNil {_x getVariable "INS_REV_PVAR_is_unconscious"}) exitWith {_result = true;};
		if (side _x != _playerSide && primaryWeapon _x != "" && alive _x && !(_x getVariable "INS_REV_PVAR_is_unconscious")) exitWith {_result = true;};
	} forEach _arr2;
	if (_result) exitWith {_result};
	
	for "_i" from 0 to (count _arr1 - 1) do { 
		{ 
			if (side _x != _playerSide && (!alive _x || !(_x getVariable "INS_REV_PVAR_is_unconscious"))) exitWith { 
				_result = true;
				breakTo "main"
			};
		} forEach (crew (_arr1 select _i)); 
	};
	
	_result
}; 

// Check half of friendly players is dead
// Usage : 'call INS_REV_FNCT_is_dead_half_of_players;'
// Return : bool
INS_REV_FNCT_is_dead_half_of_players = {
	private ["_allUnits","_aliveUnits","_result"];
	
	// Check respawn type
	switch (INS_REV_CFG_respawn_type) do {
		case "ALL": {
			_allUnits = call INS_REV_FNCT_getAllPlayers;
			_aliveUnits = call INS_REV_FNCT_getAlivePlayers;
		};
		case "SIDE": {
			_allUnits = call INS_REV_FNCT_getAllFriendlyUnits;
			_aliveUnits = call INS_REV_FNCT_getAliveFriendlyUnits;
		};
		case "GROUP": {
			_allUnits = call INS_REV_FNCT_getAllGroupUnits;
			_aliveUnits = call INS_REV_FNCT_getAliveGroupUnits;
		};
	};
	
	_result = false; 
	if ((count (_allUnits) / 2) >= count _aliveUnits) then {
		_result = true; 
	};
	
	// Return value
	_result
};

// Check player can respawn player's own body
// Usage : 'call INS_REV_FNCT_can_respawn_player_body;'
// Return : bool
INS_REV_FNCT_can_respawn_player_body = {
	private ["_result"];
	
	_result = false;
	
	if (INS_REV_CFG_can_respawn_player_body) then {
		_result = true;
	} else {
		if (INS_REV_CFG_half_dead_repsawn_player_body) then {
			if (call INS_REV_FNCT_is_dead_half_of_players) then {
				_result = true;
			};
		} else {
			private ["_aliveFriendlyUnits","_respawn_locations","_friendly"];
			
			// Check respawn type
		    if (INS_REV_CFG_respawn_type == "ALL") then {
				// Get units
				_aliveFriendlyUnits = call INS_REV_FNCT_getAlivePlayers;
			} else {
				// Check respawn type
				if (INS_REV_CFG_respawn_type == "SIDE") then {
					// Get alive friendly units
					_aliveFriendlyUnits = call INS_REV_FNCT_getAliveFriendlyUnits;
				} else {
					// Get alive group units
					_aliveFriendlyUnits = call INS_REV_FNCT_getAliveGroupUnits;
				};
			};
			
			// Get respawn locations
			_respawn_locations = call INS_REV_FNCT_get_respawn_locations;
			
			// Set temporary result
			_friendly = [];
			_friendly = _friendly + _aliveFriendlyUnits + _respawn_locations;
			
			if (count _friendly == 0) then {
				_result = true;
			};
		};
	};
	
	_result
};

// Check friendly units are all dead
// Usage : 'call INS_REV_FNCT_isAllDead;'
// Return : bool
INS_REV_FNCT_isAllDead = {
	private ["_allUnits","_result"];
	
	// Check respawn type
	switch (INS_REV_CFG_respawn_type) do {
		case "ALL": {
			_allUnits = call INS_REV_FNCT_getAllPlayers;
		};
		case "SIDE": {
			_allUnits = call INS_REV_FNCT_getAllFriendlyUnits;
		};
		case "GROUP": {
			_allUnits = call INS_REV_FNCT_getAllGroupUnits;
		};
	};
	
	_result = true;
	{
		if (!(_x getVariable "INS_REV_PVAR_is_unconscious")) exitWith {_result = false;};
	} forEach _allUnits;
	
	_result
};

// Check is there near friendly units
// Usage : 'call INS_REV_FNCT_isNearFriendly;'
// Return : bool
INS_REV_FNCT_isNearFriendly = {
	private ["_units","_nearUnits","_nearFrieldy","_range","_result"];
	
	// If disalbed in config exit and return true
	if (!INS_REV_CFG_respawn_near_friendly) exitWith {
		true
	};
	
	// Set variable
	_range = INS_REV_CFG_respawn_near_friendly_range;
	_units = call INS_REV_FNCT_getFriendly;
	_nearUnits = nearestObjects [player, ["CAManBase"], _range]; 
	_result = false;
	
	// Check friendly exists defined near area
	{
		if (_x in _units) exitWith {_result = true};
	} forEach _nearUnits; 
	
	// Return value
	_result
};

// Get dead units
// Usage : 'call INS_REV_FNC_get_dead_units;'
// Return : array
INS_REV_FNC_get_dead_units = {
	private ["_allUnits","_result","_isDead","_isJIP"];
	
	// Check respawn type
	switch (INS_REV_CFG_respawn_type) do {
		case "ALL": {
			_allUnits = call INS_REV_FNCT_getAllPlayers;
		};
		case "SIDE": {
			_allUnits = call INS_REV_FNCT_getAllFriendlyUnits;
		};
		case "GROUP": {
			_allUnits = call INS_REV_FNCT_getAllFriendlyUnits;
		};
	};
	
	_result = [];
	// Check unit is dead
	{
		_isDead = _x getVariable "INS_REV_PVAR_is_unconscious";
		if (isNil "_isDead") then {_isDead = false};
		
		_isTeleport = _x getVariable "INS_REV_PVAR_isTeleport";
		if (isNil "_isTeleport") then {_isTeleport = false};
		
		if ((!alive _x || _isDead) && (isPlayer _x) && !_isTeleport) then {
			_result = _result + [_x];
		};
	} forEach _allUnits;
	
	_result
};

// Check player can revive
// Usage : 'call INS_REV_FNCT_can_revive;'
// Return : bool
INS_REV_FNCT_can_revive = {
	if (INS_REV_CFG_all_player_can_revive) then {
		true
	} else {
		if (INS_REV_CFG_all_medics_can_revive && getNumber (configFile >> "CfgVehicles" >> (typeOf player) >> "attendant") == 1) then {
			true
		} else {
			if (player in INS_REV_CFG_list_of_slots_who_can_revive) then {
				true
			} else {
				if (typeOf player in INS_REV_CFG_list_of_classnames_who_can_revive) then {
					true
				} else {
					false
				};
			};
		};
	};
};

// Set dead marker
// Usage : '[marker_array] call INS_REV_FNC_set_number_of_markers;'
// Return : array
INS_REV_FNC_set_number_of_markers = {
	private ["_markers","_count","_markerCount"];
	
	// Set variable
	_markers = _this select 0;
	_count = _this select 1;
	_markerCount = count _markers;
	
	// Check current marker count
	switch true do {
		// If equal
		case (_markerCount == _count): {
			// exit
		};
		case (_markerCount > _count): {
			// Delete marker
			for "_x" from _count to (_markerCount - 1) do {
				_delMarker = _markers select _x;
				if (INS_REV_CFG_player_marker_serverSide) then {
					deleteMarker _delMarker; 
				} else {
					deleteMarkerLocal _delMarker; 
				};
				_markers = _markers - [_delMarker];
			};
		};
		case (_markerCount < _count): {
			// Create marker
			for "_x" from _markerCount to (_count - 1) do {
				if (INS_REV_CFG_player_marker_serverSide) then {
					_marker=createMarker [format ["dmarker%1",_x],[0,0,0]];
					_marker setMarkerType "mil_dot";
					_marker setMarkerColor "colorRed";
					_marker setMarkerSize [0.4, 0.4];
					_marker setMarkerAlpha 0;
				} else {
					_marker=createMarkerLocal [format ["dmarker%1",_x],[0,0,0]];
					_marker setMarkerTypeLocal "mil_dot";
					_marker setMarkerColorLocal "colorRed";
					_marker setMarkerSizeLocal [0.4, 0.4];
					_marker setMarkerAlphaLocal 0;
				};
				_markers set [_x,_marker];
			};
		};
	};
	
	_markers
};

// Set dead marker
// Usage : '[unit] call INS_REV_FNC_set_dead_marker;'
INS_REV_FNC_set_dead_marker = {
	private ["_markers","_deadUnits","_unit","_marker","_i"];
	
	_markers = _this select 0;
	_deadUnits = call INS_REV_FNC_get_dead_units;
	
	// Syncronize number of markers and aliveplayers count
	_markers = [_markers, count _deadUnits] call INS_REV_FNC_set_number_of_markers;
	
	{
		_unit=_x;
		
		_marker=_markers select (_deadUnits find _unit);
		// Check method serverside or clientside
		if (INS_REV_CFG_player_marker_serverSide) then {
			_marker setMarkerPos getPos _unit;
			_marker setMarkerText format["%1 is down", name _x];
			if (INS_REV_CFG_life_time > 0) then {
				if (_unit getVariable "INS_REV_PVAR_is_dead") then {
					_marker setMarkerAlpha 0;
				} else {
					_marker setMarkerAlpha 1;
				};
			} else {
				_marker setMarkerAlpha 1;
			};
		} else {
			_marker setMarkerPosLocal getPos _unit;
			_marker setMarkerTextLocal format["%1 is down", name _x];
			if (INS_REV_CFG_life_time > 0) then {
				if (_unit getVariable "INS_REV_PVAR_is_dead") then {
					_marker setMarkerAlphaLocal 0;
				} else {
					_marker setMarkerAlphaLocal 1;
				};
			} else {
				_marker setMarkerAlphaLocal 1;
			};
		};
		
	} forEach _deadUnits;
	
	_markers
};

// Draw dead marker
// Usage(thread) : '_script = [] spawn INS_REV_FNCT_draw_dead_marker;'
INS_REV_FNCT_draw_dead_marker = {
	private ["_markers"];
	
	_markers = [];
	
	while {true} do {
		_markers = [_markers] call INS_REV_FNC_set_dead_marker;
		sleep 1;
	};
};

// Add revive related action to unit
// Usage : '[variable, unit] call INS_REV_FNCT_add_actions;'
INS_REV_FNCT_add_actions = {
	private ["_unit", "_id_action", "_isTeleport"];
	
	scopeName "main";
	
	// Set variable
	_unit = _this select 1;
	_isTeleport = _unit getVariable "INS_REV_PVAR_isTeleport";
	if (isNil "_isTeleport") then {_isTeleport = false};
	
	if (INS_REV_CFG_respawn_type != "ALL") then {
		private ["_playerSide","_injuredSide"];
		_injuredSide = _unit getVariable "INS_REV_PVAR_playerSide";
		_playerSide = player getVariable "INS_REV_PVAR_playerSide";
		
		if (_injuredSide != _playerSide) exitWith {
			breakOut "main";
		};
	};
	
	// If unit is not null and not teleported then add actions.
	if (!isNull _unit && !_isTeleport) then	{
		player reveal _unit;
		
		// Revive action
		_id_action = _unit addAction [
			STR_INS_REV_action_revive,				/* Title */
			"INS_revive\revive\act_revive.sqf",		/* Filename */
			[],										/* Arguments */
			10,										/* Priority */
			false,									/* ShowWindow */
			true,									/* HideOnUse */
			"",										/* Shortcut */
			"player distance _target < 2 && !(player getVariable ""INS_REV_PVAR_is_unconscious"") && call INS_REV_FNCT_can_revive && alive _target && isPlayer _target && (_target getVariable ""INS_REV_PVAR_is_unconscious"") && isNil {_target getVariable ""INS_REV_PVAR_who_taking_care_of_injured""}"	/* Condition */
		];
		_unit setVariable ["INS_REV_id_action_revive", _id_action, false];
		
		// Drag body action
		_id_action = _unit addAction [
			STR_INS_REV_action_drag_body,			/* Title */
			"INS_revive\revive\act_drag_body.sqf",	/* Filename */
			[],										/* Arguments */
			10,										/* Priority */
			false,									/* ShowWindow */
			true,									/* HideOnUse */
			"",										/* Shortcut */
			"player distance _target < 2 && !(player getVariable ""INS_REV_PVAR_is_unconscious"") && INS_REV_CFG_player_can_drag_body && alive _target && isPlayer _target && (_target getVariable ""INS_REV_PVAR_is_unconscious"") && isNil {_target getVariable ""INS_REV_PVAR_who_taking_care_of_injured""}"	/* Condition */
		];
		_unit setVariable ["INS_REV_id_action_drag_body", _id_action, false];
	};
};

// Remove revive related action
// Usage : '[variable, unit] call INS_REV_FNCT_remove_actions;'
INS_REV_FNCT_remove_actions = {
	private ["_unit"];
	
	scopeName "main";
	
	_unit = _this select 1;
	
	if (INS_REV_CFG_respawn_type != "ALL") then {
		private ["_playerSide","_injuredSide"];
		_injuredSide = _unit getVariable "INS_REV_PVAR_playerSide";
		_playerSide = player getVariable "INS_REV_PVAR_playerSide";
		
		if (_injuredSide != _playerSide) exitWith {
			breakOut "main";
		};
	};
	
	// If unit is not null then remove actions
	if !(isNull _unit) then	{
		if !(isNil {_unit getVariable "INS_REV_id_action_revive"}) then {
			_unit removeAction (_unit getVariable "INS_REV_id_action_revive");
			_unit setVariable ["INS_REV_id_action_revive", nil, false];
		};
		
		if !(isNil {_unit getVariable "INS_REV_id_action_drag_body"}) then {
			_unit removeAction (_unit getVariable "INS_REV_id_action_drag_body");
			_unit setVariable ["INS_REV_id_action_drag_body", nil, false];
		};
	};
};

// Add unload action to vehicle
// Usage : '[unit, vehicle] call INS_REV_FNCT_add_unload_action;'
INS_REV_FNCT_add_unload_action = {
	private ["_vehicle", "_injured", "_id_action", "_loaded_list"];
	
	// Set variable
	_vehicle = (_this select 1) select 0;
	_injured = (_this select 1) select 1;
	
	// If vehicle is not null then add actions.
	if (!isNull _vehicle) then	{
		player reveal _vehicle;
		
		// Unload action
		_id_action = _vehicle addAction [
			format[STR_INS_REV_action_unload_body,name _injured],				/* Title */
			"INS_revive\revive\act_unload_body.sqf",		/* Filename */
			[_vehicle, _injured],						/* Arguments */
			10,										/* Priority */
			false,									/* ShowWindow */
			true,									/* HideOnUse */
			"",										/* Shortcut */
			""	/* Condition */
		];
		
		// Check loaded list
		if !(isNil {_vehicle getVariable "INS_REV_GVAR_loaded_list"}) then {
			_loaded_list = _vehicle getVariable "INS_REV_GVAR_loaded_list";
		} else {
			_loaded_list = [];
		};
		
		// Update loaded list
		if (count _loaded_list > 0) then {
			_loaded_list set [count _loaded_list, [_injured, _id_action]];
		} else {
			_loaded_list = [[_injured, _id_action]];
		};
		_vehicle setVariable ["INS_REV_GVAR_loaded_list", _loaded_list, false];
	};
};

// Remove unload action
// Usage : '[vehicle, unit] call INS_REV_FNCT_remove_unload_action;'
INS_REV_FNCT_remove_unload_action = {
	private ["_vehicle","_injured", "_loaded_list","_i"];
	
	// Set variable
	_vehicle = (_this select 1) select 0;
	_injured = (_this select 1) select 1;
	
	// If vehicle is not null then remove actions
	if !(isNull _vehicle) then	{
		if !(isNil {_vehicle getVariable "INS_REV_GVAR_loaded_list"}) then {
			_loaded_list = _vehicle getVariable "INS_REV_GVAR_loaded_list";
			_i = 0;
			{
				if (_x select 0 == _injured) exitWith {
					_vehicle removeAction (_x select 1);
					_loaded_list set [_i, -1];
					_loaded_list = _loaded_list - [-1];
					if (count _loaded_list > 0) then {
						_vehicle setVariable ["INS_REV_GVAR_loaded_list", _loaded_list, false];
					} else {
						_vehicle setVariable ["INS_REV_GVAR_loaded_list", nil, false];
					};
				};
				_i = _i + 0;
			} forEach _loaded_list;
		};
	};
};

// Check player can respawn to camPlayer.
// Usage : 'call INS_REV_FNCT_can_respawn;'
// Return : bool
INS_REV_FNCT_can_respawn = {
	private ["_result"];
	
	// Set variable
	_result = false;
	
	// If vehicle and not full
	if ([INS_REV_GVAR_camPlayer] call INS_REV_FNCT_is_vehicle) then {
		if (!((vehicle INS_REV_GVAR_camPlayer) call INS_REV_FNCT_vclisFull) && alive vehicle INS_REV_GVAR_camPlayer) then {
			_result = true;
		};
	} else {
		// If player
		if (vehicle INS_REV_GVAR_camPlayer isKindOf "Man" && alive vehicle INS_REV_GVAR_camPlayer) then {
			if (!(INS_REV_GVAR_camPlayer getVariable "INS_REV_PVAR_is_unconscious") || call INS_REV_FNCT_can_respawn_player_body) then {
				_result = true;
			};
		} else {
			// If respawn loacation
			if (INS_REV_GVAR_camPlayer call INS_REV_FNCT_isRespawnLocation) then {
				_result = true;
			};
		};
	};
	
	// Return value
	_result
};

// Check player can respawn to camPlayer.
// Usage : 'call INS_REV_FNCT_can_respawn;'
// Return : bool
INS_REV_FNCT_can_respawn_except_vehicle = {
	private ["_result"];
	
	// Set variable
	_result = false;
	
	// If vehicle and not full
	if ([INS_REV_GVAR_camPlayer] call INS_REV_FNCT_is_vehicle) then {
		if (alive vehicle INS_REV_GVAR_camPlayer) then {
			_result = true;
		};
	} else {
		// If player
		if (vehicle INS_REV_GVAR_camPlayer isKindOf "Man" && alive vehicle INS_REV_GVAR_camPlayer) then {
			if (!(INS_REV_GVAR_camPlayer getVariable "INS_REV_PVAR_is_unconscious") || call INS_REV_FNCT_can_respawn_player_body) then {
				_result = true;
			};
		} else {
			// If respawn loacation
			if (INS_REV_GVAR_camPlayer call INS_REV_FNCT_isRespawnLocation) then {
				_result = true;
			};
		};
	};
	
	// Return value
	_result
};

// Check object is vehicle.
// Usage : '[object] call INS_REV_FNCT_is_vehicle;'
// Return : bool
INS_REV_FNCT_is_vehicle = {
	private ["_result", "_veh"];
	
	// Set variable
	_result = false;
	_veh = _this select 0;
	
	// Check object is vehicle
	if ((vehicle _veh isKindOf "LandVehicle" || vehicle _veh isKindOf "Air" || vehicle _veh isKindOf "Ship")) then {
		_result = true;
	};
	
	// Return value
	_result
};


// Get camera attach coordinate
// Usage : 'call INS_REV_FNCT_get_camAttachCoords;'
// Return : array
INS_REV_FNCT_get_camAttachCoords = {
	private ["_result","_xC","_yC","_zC"];
	
	_xC = INS_REV_GVAR_camRange * sin(INS_REV_GVAR_theta) * cos(INS_REV_GVAR_phi);
	_yC = INS_REV_GVAR_camRange * sin(INS_REV_GVAR_theta) * sin(INS_REV_GVAR_phi);
	_zC = INS_REV_GVAR_camRange * cos(INS_REV_GVAR_theta);
	_result = [_xC,_yC,_zC];
	
	_result
};

// Reset dead camera
// Usage : 'call INS_REV_FNCT_reset_camera;'
INS_REV_FNCT_reset_camera = {
	private ["_friendly","_camAttachCoords","_camStaticCoords"];
	
	// If not exitst INS_REV_GVAR_camPlayer, reset INS_REV_GVAR_camPlayer
	if (isNull INS_REV_GVAR_camPlayer) then { 
		_friendly = call INS_REV_FNCT_getFriendly;
		INS_REV_GVAR_camPlayer = _friendly select 0;
	};
	
	// Set distance
	if ((vehicle INS_REV_GVAR_camPlayer) isKindOf "Man") then {
		INS_REV_GVAR_camRange = 5;
	} else {
		INS_REV_GVAR_camRange = (sizeOf typeOf vehicle INS_REV_GVAR_camPlayer) max 5;
	};
	
	// Set angle and coordinate
	INS_REV_GVAR_theta =  74;
	INS_REV_GVAR_phi   = -90;
	_camAttachCoords = call INS_REV_FNCT_get_camAttachCoords;
	_camStaticCoords = [((getPos vehicle INS_REV_GVAR_camPlayer) select 0) + _xC,((getPos vehicle INS_REV_GVAR_camPlayer) select 1) + _yC,((getPos vehicle INS_REV_GVAR_camPlayer) select 2) + _zC];
	
	// attatch camera to target
	if (INS_REV_GVAR_camPlayer isKindOf "Man" || [INS_REV_GVAR_camPlayer] call INS_REV_FNCT_is_vehicle) then {
		INS_REV_GVAR_dead_camera = "camera" camCreate _camStaticCoords;
		INS_REV_GVAR_dead_camera cameraEffect ["INTERNAL","Back"];
		INS_REV_GVAR_dead_camera CamSetTarget vehicle INS_REV_GVAR_camPlayer;
		INS_REV_GVAR_dead_camera camCommit 0;
		INS_REV_GVAR_dead_camera attachTo [vehicle INS_REV_GVAR_camPlayer, _camAttachCoords];
	} else {
		INS_REV_GVAR_dead_camera = "camera" camCreate _camStaticCoords;
		INS_REV_GVAR_dead_camera cameraEffect ["INTERNAL","Back"];
		INS_REV_GVAR_dead_camera CamSetTarget INS_REV_GVAR_camPlayer;
		INS_REV_GVAR_dead_camera camSetRelPos _camAttachCoords;
		INS_REV_GVAR_dead_camera camCommit 0;
	};
	/*
	INS_REV_GVAR_dead_camera = "camera" camCreate _camStaticCoords;
	INS_REV_GVAR_dead_camera cameraEffect ["INTERNAL","Back"];
	INS_REV_GVAR_dead_camera CamSetTarget vehicle INS_REV_GVAR_camPlayer;
	INS_REV_GVAR_dead_camera camCommit 0;
	INS_REV_GVAR_dead_camera attachTo [vehicle INS_REV_GVAR_camPlayer, _camAttachCoords];
	*/
	
	// Black in effact
	titleText [" ","Black in", 2];
};

// Set respawn tag
// Usage : 'call INS_REV_FNCT_respawn_tag;'
INS_REV_FNCT_respawn_tag = {
	private ["_unit","_leftTime","_lifeTime","_name","_txt","_ctrlText","_color"];
	
	scopeName "main";
	
	// If player turn on map exit
	if INS_REV_GVAR_camMap exitWith {};
	
	// Set variable
	_unit = _this select 0;
	_leftTime = round ((_unit getVariable "INS_REV_PVAR_deadTime") + INS_REV_CFG_respawn_delay - time);
	if (INS_REV_CFG_life_time > 0) then {
		_lifeTime = round (INS_RES_GVAR_killed_time + INS_REV_CFG_life_time - time);
	};
	
	// Set name
	if (!(INS_REV_GVAR_camPlayer call INS_REV_FNCT_isRespawnLocation)) then {
		_name = name INS_REV_GVAR_camPlayer;
	} else {
		_name = toUpper (format["%1",INS_REV_GVAR_camPlayer]);
	};
	
	// If restrict respawn
	If (INS_REV_CFG_respawn_location == "BASE" && !(INS_REV_GVAR_camPlayer call INS_REV_FNCT_isRespawnLocation)) exitWith {
		cutRsc["Rtags", "PLAIN",5]; 	
		_color = "#C11B17";
		_txt = format["%1 (Spectating)<br/>(You can only respawn at the base)", _name];
		_ctrlText = (uiNamespace getVariable 'TAGS_HUD') displayCtrl 64434;
		_ctrlText ctrlSetStructuredText parseText format[
			"<t color='%2' shadow='1' shadowColor='#000000'>%1</t><br/><br/><t color='#808080' shadow='1' shadowColor='#000000'>Left Arrow: Previous unit<br/>Right Arrow: Next unit<br/></t>",
			_txt,
			_color,
			_leftTime
		];
	};
	
	// If restrict respawn
	If (INS_REV_CFG_near_enemy) then {
		if ([INS_REV_GVAR_camPlayer] call INS_REV_FNCT_is_near_enemy && !(INS_REV_GVAR_camPlayer call INS_REV_FNCT_isRespawnLocation)) exitWith {
			cutRsc["Rtags", "PLAIN",5]; 	
			_color = "#C11B17";
			_txt = format["%1 (Spectating)<br/>(There are enemies near %1. You can't respawn.)", _name];
			_ctrlText = (uiNamespace getVariable 'TAGS_HUD') displayCtrl 64434;
			_ctrlText ctrlSetStructuredText parseText format[
				"<t color='%2' shadow='1' shadowColor='#000000'>%1</t><br/><br/><t color='#808080' shadow='1' shadowColor='#000000'>Left Arrow: Previous unit<br/>Right Arrow: Next unit<br/></t>",
				_txt,
				_color,
				_leftTime
			];
			breakOut "main";
		};
	};
	
	// If left respawn delay time
	if (_leftTime > 0) exitWith {
		cutRsc["Rtags", "PLAIN",5]; 	
		_color = "#C11B17";
		_txt = format["%1 (Spectating)<br/>(Respawn in %2 sec)", _name, _leftTime];
		_ctrlText = (uiNamespace getVariable 'TAGS_HUD') displayCtrl 64434; 	
		_ctrlText ctrlSetStructuredText parseText format[
			"<t color='%2' shadow='1' shadowColor='#000000'>%1</t><br/><br/><t color='#808080' shadow='1' shadowColor='#000000'>Left Arrow: Previous unit<br/>Right Arrow: Next unit<br/></t>",
			_txt,
			_color
		];
	};
	
	// If you can respawn
	if (INS_REV_CFG_life_time > 0) then {
		if (_lifeTime > 0) then {
			_txt = format["%1 (Press Enter to Spawn)<br/>(Life Time : %2)", _name, _lifeTime];
		} else {
			_txt = format["%1 (Press Enter to Spawn)<br/></t><t color='#C11B17' shadow='1' shadowColor='#000000'>(Life time is over. You cannot be revived.)", _name];
		};
	} else {
		_txt   = format["%1 (Press Enter to Spawn)", _name];
	};
	if (!(INS_REV_GVAR_camPlayer call INS_REV_FNCT_isRespawnLocation)) then {
		_color = "#347C17";
	} else {
		_color = "#2554C7";
	};
	
	/*
	// If camplayer lost conscious
	if (lifeState INS_REV_GVAR_camPlayer == "UNCONSCIOUS") then {
		_txt   = format["%1 (Cannot spawn on a critically wounded soldier)", getName(INS_REV_GVAR_camPlayer)]; 
		_color = "#C11B17";
	};
	*/
	
	// If vehicle is not full and not respawn location
	if (vehicle INS_REV_GVAR_camPlayer call INS_REV_FNCT_vclisFull && !(INS_REV_GVAR_camPlayer call INS_REV_FNCT_isRespawnLocation)) then {
		if (INS_REV_CFG_life_time > 0) then {
			if (_lifeTime > 0) then {
				_txt = format["%1 (Cannot spawn while vehicle is full)<br/>(Life Time : %2)", name INS_REV_GVAR_camPlayer, _lifeTime];
			} else {
				_txt = format["%1 (Cannot spawn while vehicle is full)<br/>(Life time is over. You cannot be revived.)", name INS_REV_GVAR_camPlayer];
			};
		} else {
			_txt   = format["%1 (Cannot spawn while vehicle is full)", name INS_REV_GVAR_camPlayer];
		};
		_color = "#C11B17";
	};
	
	// Apply respawn tag
	cutRsc["Rtags", "PLAIN",5]; 	
	_ctrlText = (uiNamespace getVariable 'TAGS_HUD') displayCtrl 64434; 	
	_ctrlText ctrlSetStructuredText parseText format[
		"<t color='%2' shadow='1' shadowColor='#000000'>%1</t><br/><br/><t color='#808080' shadow='1' shadowColor='#000000'>Left Arrow: Previous unit<br/>Right Arrow: Next unit<br/></t>",
		_txt,
		_color
	];
};

// Dead camera
// Usage(thread) : '_sctipt = unit spawn INS_REV_FNCT_dead_camera;'
INS_REV_FNCT_dead_camera = {
	private ["_unit","_camPlayer","_KH","_MH1","_MH2","_to_be_Respawned_in","_doRespawn","_camAttachCoords","_vehicle","_ctrlText","_deadTime","_condition","_isTeleport"];
	disableserialization;
	
	// Set parameter to variable
	_unit 						= _this;
	
	// Set variable
	_camPlayer    				= objNull;
	INS_REV_GVAR_camMap			= false;
	INS_REV_GVAR_camPlayer   	= objNull;
	
	//sleep 0.1;
	
	// Initialize dead camera
	call INS_REV_FNCT_reset_camera;
	
	// Check arma 2
	if (GVAR_is_arma3 || GVAR_is_arma2oa) then {
		call INS_REV_FNCT_disalble_thermal_cam;
	};
	showcinemaborder false;	// Disable cinema border
	
	// Initialize variable
	_camPlayer				= INS_REV_GVAR_camPlayer;
	_vehicle				= vehicle INS_REV_GVAR_camPlayer;
	_to_be_Respawned_in		= round (time + 5);
	_doRespawn				= false;
	INS_REV_GVAR_enterSpawn	= false;
	
	// Wait until player be respawned
	waitUntil {player getVariable "INS_REV_PVAR_is_unconscious"};
	_unit = player;
	
	// Set revive delay time
	_isTeleport = _unit getVariable "INS_REV_PVAR_isTeleport";
	// If not teleport
	if (!_isTeleport) then {
		_deadTime = _unit getVariable "INS_REV_PVAR_deadTime";
		
		// If not exist INS_REV_PVAR_deadTime
		if (isNil "_deadTime") then {
			_deadTime = time;
		} else {;
			// Delay time is not expired
			if (_deadTime + INS_REV_CFG_respawn_delay < time) then {
				_deadTime = time;
			};
		};
	} else {
		_deadTime = time - INS_REV_CFG_respawn_delay;
	};
	_unit setVariable ["INS_REV_PVAR_deadTime", _deadTime, false];
	
	// Keyboard and mouse hooking
	waitUntil { !(isNull (findDisplay 46)) };
	_KH = (findDisplay 46) displayAddEventHandler ["KeyDown", "_this call INS_REV_FNCT_onKeyPress;"];
	_MH1 = (findDisplay 46) displayAddEventHandler ["MouseMoving", "_this call INS_REV_FNCT_onMouseMove;"];
	_MH2 = (findDisplay 46) displayAddEventHandler ["MouseZChanged", "_this call INS_REV_FNCT_onMouseWheel;"];
	
	// Check Ace mod
	if (PVAR_isAce) then {
		_condition = _unit call ace_sys_wounds_fnc_isUncon;
	} else {
		_condition = _unit getVariable "INS_REV_PVAR_is_unconscious";
	};
	
	// Loop while player is unconscious
	while {_condition && alive _unit} do {
		// If changed camera target, reset camera
		if (isNull INS_REV_GVAR_camPlayer || INS_REV_GVAR_camPlayer != _camPlayer) then {
			call INS_REV_FNCT_reset_camera;
			
			// Reset variables
			_camPlayer				= INS_REV_GVAR_camPlayer;
			_vehicle				= vehicle INS_REV_GVAR_camPlayer;
			_to_be_Respawned_in		= round (time + 5);
			INS_REV_GVAR_enterSpawn	= false;
		};
		
		// Display respawn tag
		if ((INS_REV_GVAR_camPlayer call INS_REV_FNCT_isRespawnLocation || alive INS_REV_GVAR_camPlayer) && !INS_REV_GVAR_enterSpawn) then {
			// Reset player's to be respawned time
			_to_be_Respawned_in = round (time + 5);
			
			// If player get in vehicle then change deadCamera's coordinate
			if (_vehicle != vehicle INS_REV_GVAR_camPlayer) then { 
				_vehicle   = vehicle INS_REV_GVAR_camPlayer;
				_camAttachCoords = call INS_REV_FNCT_get_camAttachCoords;
				INS_REV_GVAR_dead_camera attachTo [_vehicle, _camAttachCoords];
				INS_REV_GVAR_dead_camera camSetTarget _vehicle;	
				INS_REV_GVAR_dead_camera camCommit 0;
			};
			
			// Update respawn tag
			[_unit] call INS_REV_FNCT_respawn_tag;
		};
		
		// Display to be respawned timeout tag
		if (_camPlayer == INS_REV_GVAR_camPlayer && INS_REV_GVAR_enterSpawn) then {
			// If not player can respawn to camPlayer then exit
			if !(call INS_REV_FNCT_can_respawn) exitWith {
				// Reset variable
				INS_REV_GVAR_enterSpawn = false; _to_be_Respawned_in = round (time + 5);
			};
			
			// Display respawn tag
			cutRsc["Rtags", "PLAIN",5];
			_ctrlText = (uiNamespace getVariable 'TAGS_HUD') displayCtrl 64434; 	
			_ctrlText ctrlSetStructuredText parseText format[
				"<t color='%2' shadow='1' shadowColor='#000000'>Spawning in %1</t><br/><br/><t color='#808080' shadow='1' shadowColor='#000000'>Left Arrow: Previous unit<br/>Right Arrow: Next unit<br/></t>",
				round (_to_be_Respawned_in - time),
				"#FFFFFF"
			]; 
			
			// If to be respawned timeout is over, do respawn (End loop)
			if (round (_to_be_Respawned_in - time) <= 0) exitWith {
				// Check Ace mod
				if (PVAR_isAce) then {
					if ([_player] call ACE_fnc_isBurning) then { ['ace_sys_wounds_burnoff', _player] call CBA_fnc_globalEvent;};
					_unit call ace_sys_wounds_fnc_unitInit;
					_unit call ace_sys_wounds_fnc_RemoveBleed;
					_unit call ace_sys_wounds_fnc_RemovePain;
					_unit call ace_sys_wounds_fnc_RemoveUncon;
					[_unit,0] call ace_sys_wounds_fnc_heal;
				};
				
				// Reset variable
				_unit setVariable ["INS_REV_PVAR_is_unconscious", false, true];
				_doRespawn = true;
			};
		};
		
		// If player choose respawn to INS_REV_GVAR_camPlayer (Exit loop)
		if (_doRespawn) exitWith {
			// If player can respawn to camPlayer
			if (call INS_REV_FNCT_can_respawn) then {
				if ([INS_REV_GVAR_camPlayer] call INS_REV_FNCT_is_vehicle && !(vehicle INS_REV_GVAR_camPlayer call INS_REV_FNCT_vclisFull)) then {
					if (INS_REV_GVAR_is_loaded && INS_REV_CFG_medevac) then {
						_unit action ["EJECT", vehicle _unit];
						sleep 0.5;
					};
					[_unit,(vehicle INS_REV_GVAR_camPlayer)] call INS_REV_FNCT_moveInVehicle;
				} else {
					if (INS_REV_GVAR_is_loaded && INS_REV_CFG_medevac) then {
						_unit action ["EJECT", vehicle _unit];
						sleep 0.5;
					};
					_unit setDir getDir INS_REV_GVAR_camPlayer;
					_unit setPosATL getPosATL INS_REV_GVAR_camPlayer;
					
					[_unit, "AmovPercMstpSrasWrflDnon"] call INS_REV_FNCT_switchMove;
				};
				_doRespawn = false;
			} else {
				// If failed respawn to camPlayer, respawn your body
				[_unit, "AmovPercMstpSrasWrflDnon"] call INS_REV_FNCT_switchMove;
			};
		};
		
		// If INS_REV_GVAR_camPlayer is dead, reset camera
		if !(call INS_REV_FNCT_can_respawn_except_vehicle) then {
		 	INS_REV_GVAR_camPlayer = objNull; 
		};
		
		// If left respawn delay time, check allDead and nearest friendly
		if (_deadTime + INS_REV_CFG_respawn_delay > time) then {
			if (INS_REV_CFG_respawn_near_friendly) then {
				if (!(call INS_REV_FNCT_isNearFriendly) && _deadTime + 10 < time) then {
					_unit setVariable ["INS_REV_PVAR_deadTime", _deadTime - INS_REV_CFG_respawn_delay, true];
				};
			};
			if (INS_REV_CFG__all_dead_respawn) then {
				if (call INS_REV_FNCT_isAllDead) then {
					_unit setVariable ["INS_REV_PVAR_deadTime", _deadTime - INS_REV_CFG_respawn_delay, true];
				};
			};
		};
		
		// Moditor frequency
		sleep 0.2;
		
		// Update player's condition
		if (PVAR_isAce) then {
			_condition = _unit call ace_sys_wounds_fnc_isUncon;
		} else {
			_condition = _unit getVariable "INS_REV_PVAR_is_unconscious";
		};
	};
	
	// Remove display eventhander
	(findDisplay 46) displayRemoveEventHandler ["KeyDown",_KH];
	(findDisplay 46) displayRemoveEventHandler ["MouseMoving",_MH1];
	(findDisplay 46) displayRemoveEventHandler ["MouseZChanged",_MH2];
	
	// Terminate dead camera
	openMap [false,false];
	INS_REV_GVAR_dead_camera cameraEffect ["terminate","back"];
	camDestroy INS_REV_GVAR_dead_camera;
	"dynamicBlur" ppEffectEnable true;
	"dynamicBlur" ppEffectAdjust [6];
	"dynamicBlur" ppEffectCommit 0;
	"dynamicBlur" ppEffectAdjust [0.0];
	"dynamicBlur" ppEffectCommit 5;
};

// KeyDown event handler
INS_REV_FNCT_onKeyPress = {
	private ["_handled","_list","_id","_size","_key","_leftTime"];
	
	scopeName "main";
	
	_key     = _this select 1;
	// _shift   = _this select 2;
	//_ctrl    = _this select 3;
	//_alt	 = _this select 4;
	_handled = false;
	
	/*
	if (_key in actionKeys "tacticalView") then { hint "Tactical View is disabled in current mission."; _handled=true; };
	*/
	
	// if not alive player then exit function.
	if (!alive player) exitWith {};
	
	if (_key in (actionKeys 'showmap')) then {
		//if isNull respawnCamera exitWith {};
		INS_REV_GVAR_camMap = !INS_REV_GVAR_camMap;
		openMap [INS_REV_GVAR_camMap,INS_REV_GVAR_camMap];
		if INS_REV_GVAR_camMap then {
			mapAnimAdd [0,0.1,getPosATL INS_REV_GVAR_camPlayer];
			mapAnimCommit;
		};
	};
	
	switch _key do {
		//TAB key
		/*
		case 15: {
			if (!_ctrl) exitWith {};
			if (useroptions != 1) exitWith {};
			if (!dialog) then {
				createDialog "OPTIONS";
			} else {
				closeDialog 0;
			};
		}; 
		*/
		
		//ESC key
		//case 1: {
		//};
		
		//N key
		case 49: {
			//if (isNull respawnCamera) exitWith {};
			if (isNil "INS_REV_GVAR_camNVG") then { INS_REV_GVAR_camNVG = true; };
			camUseNVG INS_REV_GVAR_camNVG;
			INS_REV_GVAR_camNVG = !INS_REV_GVAR_camNVG;
		};
		
		//W key
		case 17: {
			if (speed player == 0 && lifeState player != "UNCONSCIOUS") then { detach player; };
		};
		
		//S key
		case 31: {
			if (speed player == 0 && lifeState player != "UNCONSCIOUS") then { detach player; };
		};
		
		//Y key (used for Teamkill Punishment Forgive action)
		case 21: { 	
			Punish_YES = True;
		}; 
		
		//Enter key
		case 28: {
			_leftTime = round ((player getVariable "INS_REV_PVAR_deadTime") + INS_REV_CFG_respawn_delay - time);
			if ( _leftTime > 0) exitWith {};
			if (INS_REV_CFG_respawn_location == "BASE" && !(INS_REV_GVAR_camPlayer call INS_REV_FNCT_isRespawnLocation)) exitWith {};
			if (isNull INS_REV_GVAR_dead_camera || INS_REV_GVAR_camMap ) exitWith {};
			if (INS_REV_GVAR_enterSpawn) exitWith { INS_REV_GVAR_enterSpawn = false;};
			if (INS_REV_CFG_near_enemy) then {if ([INS_REV_GVAR_camPlayer] call INS_REV_FNCT_is_near_enemy && !(INS_REV_GVAR_camPlayer call INS_REV_FNCT_isRespawnLocation)) exitWith {breakOut "main";};};
			if (!INS_REV_GVAR_enterSpawn && (INS_REV_GVAR_camPlayer call INS_REV_FNCT_isRespawnLocation)) exitWith { INS_REV_GVAR_enterSpawn = true;};
			if (vehicle INS_REV_GVAR_camPlayer call INS_REV_FNCT_vclisFull) exitWith {};
			//if (lifeState INS_REV_GVAR_camPlayer == "UNCONSCIOUS") exitWith {};	
			if !INS_REV_GVAR_enterSpawn then { INS_REV_GVAR_enterSpawn = true;};
		};
		
		//Left
		case 203: {
			//if isNull respawnCamera exitWith {};
			//_list     = (call INS_REV_FNCT_getGroupMembers) + [flag_usa];
			_list     = call INS_REV_FNCT_getFriendly;
			_size     = count _list;
			_id       = _list find INS_REV_GVAR_camPlayer;
			_id       = _id - 1;
			if (_id < 0) then { _id = _size - 1; };
			INS_REV_GVAR_camPlayer =  _list select _id;
		};
		
		//Right 
		case 205: {
			//if isNull respawnCamera exitWith {};
			_list     = call INS_REV_FNCT_getFriendly;
			_size     = count _list;
			_id       = _list find INS_REV_GVAR_camPlayer;
			_id       = _id + 1;
			if (_id == _size) then { _id = 0; };
			INS_REV_GVAR_camPlayer =  _list select _id;
		};	
		//Backspace
		//case 14: {
		//};
	};
	
	_handled
};

// MouseMove event handler
INS_REV_FNCT_onMouseMove = {
	private ["_xS","_yS","_xC","_yC","_zC","_camAttachCoords"];
	
	// If not exist dead camera, exit
	if (isNull INS_REV_GVAR_dead_camera ) exitWith {};	
	_yS = (_this select 1);	
	_xS = (_this select 2);
	
	// Calculate theta
	INS_REV_GVAR_theta = INS_REV_GVAR_theta - _xS;
	if (INS_REV_GVAR_theta < 20) then {INS_REV_GVAR_theta = 20;};
	if (INS_REV_GVAR_theta > 160) then {INS_REV_GVAR_theta = 160;};
	
	// Calculate phi
	INS_REV_GVAR_phi = INS_REV_GVAR_phi - _yS;
	if (INS_REV_GVAR_phi < -270) then {INS_REV_GVAR_phi = -270;};
	if (INS_REV_GVAR_phi > 90) then {INS_REV_GVAR_phi = 90;};
	
	// Calculate cam attach coordinate
	_camAttachCoords = call INS_REV_FNCT_get_camAttachCoords;
	
	// If camPlayer is man or vehicle then attach camera.
	if (INS_REV_GVAR_camPlayer isKindOf "Man" || [INS_REV_GVAR_camPlayer] call INS_REV_FNCT_is_vehicle) then {
		INS_REV_GVAR_dead_camera attachTo [vehicle INS_REV_GVAR_camPlayer, _camAttachCoords];
	} else {
		// Or set camera
		detach INS_REV_GVAR_dead_camera;
		INS_REV_GVAR_dead_camera CamSetTarget vehicle INS_REV_GVAR_camPlayer;
		INS_REV_GVAR_dead_camera camSetRelPos _camAttachCoords;
		INS_REV_GVAR_dead_camera camCommit 0.5;
	};
	/*
	INS_REV_GVAR_dead_camera attachTo [vehicle INS_REV_GVAR_camPlayer, _camAttachCoords];
	*/
};

// MouseWheel event handler
INS_REV_FNCT_onMouseWheel = {
	private ["_xC","_yC","_zC","_vC","_camAttachCoords"];
	
	// If not exist dead camera, exit
	if (isNull INS_REV_GVAR_dead_camera) exitWith {};
	
	// Calculate cam range
	_vC = (_this select 1);
	if (_vC > 0) then {
		INS_REV_GVAR_camRange = INS_REV_GVAR_camRange - 1;
	} else {
		INS_REV_GVAR_camRange = INS_REV_GVAR_camRange + 1;
	};
	if (INS_REV_GVAR_camRange < 2) then {INS_REV_GVAR_camRange = 2;};
	
	// Calculate cam attach coordinate
	_camAttachCoords = call INS_REV_FNCT_get_camAttachCoords;
	
	// If camPlayer is man or vehicle then attach camera.
	if (INS_REV_GVAR_camPlayer isKindOf "Man" || [INS_REV_GVAR_camPlayer] call INS_REV_FNCT_is_vehicle) then {
		INS_REV_GVAR_dead_camera attachTo [vehicle INS_REV_GVAR_camPlayer, _camAttachCoords];
	} else {
		// Or set camera
		detach INS_REV_GVAR_dead_camera;
		INS_REV_GVAR_dead_camera CamSetTarget vehicle INS_REV_GVAR_camPlayer;
		INS_REV_GVAR_dead_camera camSetRelPos _camAttachCoords;
		INS_REV_GVAR_dead_camera camCommit 0.5;
	};
	/*
	INS_REV_GVAR_dead_camera attachTo [vehicle INS_REV_GVAR_camPlayer, _camAttachCoords];
	*/
};

// On killed event handler
INS_REV_FNCT_onKilled = {
	if (_this select 0 != player) exitWith {};
	
	// Terminate existing thread
	terminate INS_REV_thread_exec_wait_revive;
	
	// Set variable
	player setVariable ["INS_REV_PVAR_is_unconscious", false, true];
	player setVariable ["INS_REV_PVAR_is_dead", false, true];
	if (INS_REV_CFG_life_time > 0) then {
		INS_RES_GVAR_killed_time = time;
		INS_REV_GVAR_is_lifeTime_over = false;
	};
	
	// Spawn new thread
	INS_REV_thread_exec_wait_revive = [] spawn INS_REV_FNCT_onKilled_process;
};

// Process onKilled event
INS_REV_FNCT_onKilled_process = {
	private ["_position_before_dead", "_altitude_ATL_before_dead", "_direction_before_dead","_magazines_before_dead","_weapons_before_dead", "_player","_condition","_loadout","_who_taking_care_of_injured"];
	
	// Memorize player's body position
	_position_before_dead = getPos INS_REV_GVAR_body_before_dead;
	_altitude_ATL_before_dead = getPosATL INS_REV_GVAR_body_before_dead select 2;
	_direction_before_dead = getDir INS_REV_GVAR_body_before_dead;
	
	// Memorize player's loadout
	if (!GVAR_is_arma3) then {
		_magazines_before_dead = magazines INS_REV_GVAR_body_before_dead;
		_weapons_before_dead = weapons INS_REV_GVAR_body_before_dead;
		
		// Backpack
		if (GVAR_is_arma2oa) then {
			[_player, INS_REV_GVAR_player_loadout] call INS_REV_FNCT_set_loadout_a2oa;
		};
	};
	
	// Remove dead body's actions
	if !(PVAR_isAce) then {
		INS_REV_GVAR_end_unconscious = INS_REV_GVAR_body_before_dead;
		publicVariable "INS_REV_GVAR_end_unconscious";
		["INS_REV_GVAR_end_unconscious", INS_REV_GVAR_end_unconscious] spawn INS_REV_FNCT_remove_actions;
		INS_REV_GVAR_body_before_dead setVariable ["INS_REV_PVAR_is_unconscious", false, true];
		INS_REV_GVAR_body_before_dead setVariable ["INS_REV_PVAR_who_taking_care_of_injured", nil, true];
	};
	
	// Wait respawn camera
	sleep round (playerRespawnTime - 1);
	
	// Terminate existing dead camera thread
	terminate INS_REV_thread_dead_camera;
	
	// Start dead camera thread
	INS_REV_thread_dead_camera = player spawn INS_REV_FNCT_dead_camera;
	
	// Wait until player will be respawned
	waitUntil {alive player};
	sleep 0.1;
	
	// If Ace mod, terminate spectator
	if (PVAR_isAce) then {
		ace_sys_spectator_exit_spectator=true;
		[player,1,true,9999999] call ace_w_setunitdam;
	};
	
	// Set variable
	_player = player;
	
	// Revert Loadout
	if (GVAR_is_arma3) then {
		[_player, INS_REV_GVAR_player_loadout] call INS_REV_FNCT_set_loadout;
	} else {
		{_player addMagazine _x;} forEach _magazines_before_dead;
		{_player addWeapon _x;} forEach _weapons_before_dead;
		
		if (GVAR_is_arma2oa) then {
			[_player, INS_REV_GVAR_player_loadout] call INS_REV_FNCT_set_loadout_a2oa;
		};
	};
	
	// Set player do not allow damage and cannot be attacked
	[_player, false] call INS_REV_FNCT_allowDamage;
	if !(PVAR_isAce) then {
		[_player, "AinjPpneMstpSnonWrflDnon"] call INS_REV_FNCT_switchMove;
	};
	
	// Set variable
	if !(PVAR_isAce) then {
		INS_REV_GVAR_start_unconscious = _player;
		publicVariable "INS_REV_GVAR_start_unconscious";
	};
	_player setVariable ["INS_REV_PVAR_is_unconscious", true, true];
	_player setVariable ["INS_REV_PVAR_playerSide", INS_REV_GVAR_body_before_dead getVariable "INS_REV_PVAR_playerSide", true];
	_player setVariable ["INS_REV_PVAR_playerGroup", INS_REV_GVAR_body_before_dead getVariable "INS_REV_PVAR_playerGroup", true];
	_player setVariable ["INS_REV_PVAR_playerGroupColor", INS_REV_GVAR_body_before_dead getVariable "INS_REV_PVAR_playerGroupColor", true];
	_player setVariable ["INS_REV_PVAR_who_taking_care_of_injured", nil, true];
	_player setVariable ["INS_REV_revived", false, true];
	
	// If player not used teleport, remove dead body
	if !(_player getVariable "INS_REV_PVAR_isTeleport") then {
		waitUntil {INS_REV_GVAR_body_before_dead != _player};
		if !(GVAR_is_arma3) then {
			if (call INS_REV_FNCT_can_respawn_player_body) then {deleteVehicle INS_REV_GVAR_body_before_dead;};
		} else {
			deleteVehicle INS_REV_GVAR_body_before_dead;
		};
	};
	
	// Check Ace mod
	if (!PVAR_isAce) then {
		// If player can respawn player's own body
		if !(GVAR_is_arma3) then {
			if (!(call INS_REV_FNCT_can_respawn_player_body)) then {
				//_player setPos [_position_before_dead select 0, _position_before_dead select 1, 2000];
				_player setPos [0,0,0];
			};
		};
		
		// If player not used teleport, remove dead body
		if !(_player getVariable "INS_REV_PVAR_isTeleport") then {
			// If player cannot respawn player's own body
			if !(GVAR_is_arma3) then {
				if (!(call INS_REV_FNCT_can_respawn_player_body)) then {
					sleep 5;
					deleteVehicle INS_REV_GVAR_body_before_dead;
				};
			};
		};
		_player setVelocity [0, 0, 0];
		_player setDir _direction_before_dead;
		_player setPos [_position_before_dead select 0, _position_before_dead select 1, _altitude_ATL_before_dead - (_position_before_dead select 2)];
	};
	
	// Reset variable
	INS_REV_GVAR_body_before_dead = _player;
	
	// Wait respawn or revive
	if (PVAR_isAce) then {
		_condition = _player call ace_sys_wounds_fnc_isUncon;
	} else {
		_condition = _player getVariable "INS_REV_PVAR_is_unconscious";
	};
	while {_condition} do
	{
		_who_taking_care_of_injured = _player getVariable "INS_REV_PVAR_who_taking_care_of_injured";
			
		// If somebody is taking care of you
		if !(isNil "_who_taking_care_of_injured") then {
			// If the one who taking care of you is not alive.
			if (isNull _who_taking_care_of_injured || !alive _who_taking_care_of_injured || !isPlayer _who_taking_care_of_injured) then	{
				// Reset player's state
				detach _player;
				if !(isNull _who_taking_care_of_injured) then {detach _who_taking_care_of_injured;};
				_player switchMove "AinjPpneMstpSnonWrflDnon";
				_player setVariable ["INS_REV_PVAR_who_taking_care_of_injured", nil, true];
			};
		};
		
		// Check MEDEVAC vehicle
		if (!PVAR_isAce && INS_REV_CFG_player_can_drag_body &&INS_REV_CFG_medevac) then {
			if (_player != vehicle _player) then {
				if (alive vehicle _player) then {
					INS_REV_GVAR_is_loaded = true;
					INS_REV_GVAR_loaded_vehicle = vehicle _player;
				} else {
					[] call INS_REV_FNCT_unload_injured;
				};
			};
			
			if (_player == vehicle _player && INS_REV_GVAR_is_loaded) then {
				[] call INS_REV_FNCT_unload_injured;
			};
		};
		
		// Check Life Time
		if (INS_REV_CFG_life_time > 0) then {
			if (!INS_REV_GVAR_is_lifeTime_over) then {
				if (time > round (INS_RES_GVAR_killed_time + INS_REV_CFG_life_time)) then {
					INS_REV_GVAR_is_lifeTime_over = true;
					
					// Remove revive action
					INS_REV_GVAR_end_unconscious = _player;
					publicVariable "INS_REV_GVAR_end_unconscious";
					["INS_REV_GVAR_end_unconscious", INS_REV_GVAR_end_unconscious] spawn INS_REV_FNCT_remove_actions;
					
					// Set variable for dead marker
					_player setVariable ["INS_REV_PVAR_is_dead", true, true];
				};
			};
		};
		
		sleep 0.3;
		
		// Check Ace mod
		if (PVAR_isAce) then {
			_condition = _player call ace_sys_wounds_fnc_isUncon;
		} else {
			_condition = _player getVariable "INS_REV_PVAR_is_unconscious";
		};
		
		// Prevent drown in Arma3
		if (GVAR_is_arma3) then {
			[_player] call INS_REV_FNCT_prevent_drown;
		};
	};
	
	sleep 0.2;
	
	// Select primary weapon
	_player selectWeapon (primaryWeapon _player);
	
	// Check Ace mod
	if (PVAR_isAce) then {
		if ([_player] call ACE_fnc_isBurning) then { ['ace_sys_wounds_burnoff', _player] call CBA_fnc_globalEvent;};
		//[_player, 0, true, 999999] call ace_w_setunitdam;
		//_player call ace_sys_wounds_fnc_RemoveBleed;
		//_player call ace_sys_wounds_fnc_RemovePain;
		//_player call ace_sys_wounds_fnc_RemoveUncon;
		//_player setVariable ["ace_w_heal", true];
		//_player setVariable ["ace_w_eh",0];
		//[_player,0] call ace_sys_wounds_fnc_heal;
		_player call ace_sys_wounds_fnc_unitInit;
		[_player,0] call ace_sys_wounds_fnc_heal;
		_player setdamage 0;
	} else {
		// Remove revive action
		INS_REV_GVAR_end_unconscious = _player;
		publicVariable "INS_REV_GVAR_end_unconscious";		
		["INS_REV_GVAR_end_unconscious", INS_REV_GVAR_end_unconscious] spawn INS_REV_FNCT_remove_actions;
		
		// Remove unload action
		if (INS_REV_GVAR_is_loaded && INS_REV_CFG_medevac) then {
			INS_REV_GVAR_del_unload = [INS_REV_GVAR_loaded_vehicle, _player];
			publicVariable "INS_REV_GVAR_del_unload";
			["INS_REV_GVAR_del_unload", INS_REV_GVAR_del_unload] spawn INS_REV_FNCT_remove_unload_action;
			
			INS_REV_GVAR_is_loaded = false;
			INS_REV_GVAR_loaded_vehicle = nil;
		};
	};
	
	
	// Set player allow damage and can be attacked
	[_player, true] call INS_REV_FNCT_allowDamage;
	
	// Reset variable
	isJIP = false;
	_player setVariable ["INS_REV_PVAR_isTeleport", false, true];
	_player setVariable ["INS_REV_PVAR_is_dead", false, true];
};

// Unload player from vehicle
// Usage : 'call INS_REV_FNCT_unload_injured;'
INS_REV_FNCT_unload_injured = {
	private ["_player"];
	
	_player = player;
	
	// Remove unload action
	INS_REV_GVAR_del_unload = [INS_REV_GVAR_loaded_vehicle, _player];
	publicVariable "INS_REV_GVAR_del_unload";
	["INS_REV_GVAR_del_unload", INS_REV_GVAR_del_unload] spawn INS_REV_FNCT_remove_unload_action;
	
	// Unload
	_player action ["EJECT", vehicle _player];
	[_player, "AinjPpneMstpSnonWrflDnon"] call INS_REV_FNCT_switchMove;
	while {animationState _player != "AinjPpneMstpSnonWrflDnon"} do {
		sleep 0.1;
		[_player, "AinjPpneMstpSnonWrflDnon"] call INS_REV_FNCT_switchMove;
	};
	
	INS_REV_GVAR_is_loaded = false;
	INS_REV_GVAR_loaded_vehicle = nil;
};

// Teleport to teammate action
INS_REV_FNCT_init_teleport_to_teamate = {
	sleep 3;
	INS_REV_GVAR_teleportToTeam = player addAction [
		"<t color='#06ff00'>Teleport To Teammate</t>",	/* Title */
		"INS_revive\revive\act_teleportToTeam.sqf",		/* Script */
		[],		/* Arguments */
		10,		/* Priority */
		false,	/* ShowWindow */
		true,	/* HideOnUse */
		"",		/* Shortcut */
		""		/* Condition */
	];
	sleep 10;
	hintSilent "Use your scroll wheel to teleport to your teammate. (It available only within 3 minutes.)";
	sleep 180;//3min
	player removeAction INS_REV_GVAR_teleportToTeam;
	isJIP = false;
	player setVariable ["INS_REV_PVAR_isTeleport", false, true];
};

// Check dragging is finished
// Usage : 'call INS_REV_FNCT_is_finished_dragging;'
// Return : bool
INS_REV_FNCT_is_finished_dragging = {
	private "_result";
	
	_result = true;
	
	if (!INS_REV_GVAR_do_release_body) then {
		if (!isNull _player && alive _player && !isNull _injured && alive _injured && isPlayer _injured) then {
			if (animationState _player == "acinpknlmwlksraswrfldb" || animationState _player == "acinpknlmstpsraswrfldnon") then {
				_result = false;
			};
		};
	};
	
	_result
};

// Get group color index
// Usage : '[unit] call FNC_GET_GROUP_COLOR_INDEX;'
// Return : number
INS_REV_FNCT_get_group_color_index = {
	private ["_phoneticCode", "_found", "_index", "_result", "_i", "_j"];
	
	// Set variable
	_unit = _this select 0;
	_phoneticCode = ["Alpha","Bravo","Charlie","Delta","Echo","Foxtrot","Golf"];
	_found = false;
	_index = 0;
	
	// Find group name
	{
		for "_i" from 1 to 4 do {
		 	for "_j" from 1 to 3 do {
		 		_groupName = format["%1 %2-%3", _x, _i, _j];
		 		if (format["b %1",_groupName] == str(group _unit) || format["o %1",_groupName] == str(group _unit)) exitWith {
		 			_found = true;
		 		};
		 		_index = _index + 1;
			};
			if (_found) exitWith {};
		};
		if (_found) exitWith {};
	} forEach _phoneticCode;
	
	// If not found, return 0
	if (!_found) then {
		_result = 0;
	} else {
		_result = _index % 10;
	};
	
	_result
};

// Get group color
// Usage : '[unit] call FNC_GET_GROUP_COLOR;'
// Return : string
INS_REV_FNCT_get_group_color = {
	private ["_unit", "_colors", "_colorIndex", "_result"];
	
	// Set varialble
	_unit = _this select 0;
	_colors = ["ColorGreen","ColorYellow","ColorOrange","ColorPink","ColorBrown","ColorKhaki","ColorBlue","ColorRed","ColorBlack","ColorWhite"];
	_colorIndex = [_unit] call INS_REV_FNCT_get_group_color_index;
	
	// Set color
	_result = _colors select _colorIndex;
	
	// Return value
	_result
};

// Damage event handler
// Usage : 'player addEventHandler ["HandleDamage", {_this call INS_REV_FNCT_clientHD}];'
// Return : damage
INS_REV_FNCT_clientHD = {
	private ["_unit","_dam"];
	_unit = _this select 0;
	//_part = _this select 1;
	_dam = _this select 2;
	//_injurer = _this select 3;
	//_ammo = _this select 4;
	
	if (!alive _unit || {_dam == 0}) exitWith {
		//__TRACE_1("ClientHD exiting, unit dead or healing","_dam");
		_dam
	};
	if (_unit getVariable "INS_REV_PVAR_is_unconscious") exitWith {
		//__TRACE_2("ClientHD exiting, unit uncon or invulnerable","_part");
		0
	};
	/*
	if (d_no_teamkill == 0 && {_dam >= 0.1} && {!isNull _injurer} && {isPlayer _injurer} && {_injurer != _unit} && {vehicle _unit == _unit} && {side (group _injurer) == side (group _unit)}) exitWith {
		if (_part == "" && {_ammo != ""} && {getText (configFile >> "CfgAmmo" >> _ammo >> "simulation") in __shots} && {time > (__pGetVar(d_tk_cutofft) + 3)}) then {
			_unit setVariable ["d_tk_cutofft", time];
			hint format [(localize "STR_DOM_MISSIONSTRING_497"), name _injurer];
			["d_unit_tkr", [_unit,_injurer]] call d_fnc_NetCallEventCTS;
			if (d_domdatabase) then {
				["d_ptkkg", _injurer] call d_fnc_NetCallEventCTS;
			};
		};
		0
	};
	if (_dam >= 0.9 && {time > INS_REV_GVAR_player_loadout_time}) then {
		//__TRACE_1("ClientHD saving respawn gear","_dam");
		//_unit setVariable [QGVARXR(last_gear_save), time + 1];
		//call d_fnc_save_respawngear;
		//_unit setVariable [QGVARXR(isleader), leader (group player) == player];
		//GVARXR(pl_group) = group player;
		INS_REV_GVAR_player_loadout_time = time + 1;
		INS_REV_GVAR_player_loadout = [_unit] call INS_REV_FNCT_get_loadout;
	};
	*/
	BIS_hitArray = _this; BIS_wasHit = true;
	_dam
};

// Inform that initialization of functions is completed
INS_REV_FNCT_init_completed = true;
