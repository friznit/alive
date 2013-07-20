//------------------
// Validate Config
//------------------

// Remove null object in array
// Usage : '[array] call INS_REV_FNCT_remove_null_objects;'
// Return : array
INS_REV_FNCT_remove_null_objects = {
	private ["_arr", "_result"];
	
	_arr = _this select 0;
	_result = [];
	{
		if (!isNull call compile format["%1",_x]) then {
			_result = _result + [_x];
		};
	} forEach _arr;
	
	_result
};

// Get param value(number), return bool value
// Usage : '[param] call INS_REV_FNCT_param_to_value;'
// Return : bool
INS_REV_FNCT_param_to_value = {
	private ["_value", "_result"];
	
	_value = _this select 0;
	_result = true;
	
	if (_value == 0) then {
		_result = false;
	};
	
	_result
};

INS_REV_CFG_list_of_respawn_locations_blufor = [INS_REV_CFG_list_of_respawn_locations_blufor] call INS_REV_FNCT_remove_null_objects;
INS_REV_CFG_list_of_respawn_locations_opfor = [INS_REV_CFG_list_of_respawn_locations_opfor] call INS_REV_FNCT_remove_null_objects;
INS_REV_CFG_list_of_ammobox = [INS_REV_CFG_list_of_ammobox] call INS_REV_FNCT_remove_null_objects;

// Get parameter value from description.ext
for [ {_i = 0}, {_i < count(paramsArray)}, {_i = _i + 1} ] do
{
	call compile format 
	[
		"%1 = %2",
		(configName ((missionConfigFile >> "Params") select _i)),
		(paramsArray select _i)
	];
};

// ALLOW TO REVIVE
if (!isNil "INS_REV_PARAM_allow_revive") then {
	// Everyone
	if (INS_REV_PARAM_allow_revive == 0) then {
		INS_REV_CFG_all_player_can_revive = true;
	} else {
		// Medic Only
		if (INS_REV_PARAM_allow_revive == 1) then {
			INS_REV_CFG_all_player_can_revive = false;
			INS_REV_CFG_all_medics_can_revive = true;
		// Pre-Defined
		} else {
			INS_REV_CFG_all_player_can_revive = false;
			INS_REV_CFG_all_medics_can_revive = false;
		};
	};
} else {
	if (isNil "INS_REV_CFG_all_player_can_revive") then {
		INS_REV_CFG_all_player_can_revive = true;
	};
};

// RESPAWN DELAY TIME
if (!isNil "INS_REV_PARAM_respawn_delay") then {
	INS_REV_CFG_respawn_delay = INS_REV_PARAM_respawn_delay;
} else {
	if (isNil "INS_REV_CFG_respawn_delay") then {
		INS_REV_CFG_respawn_delay = 120;
	};
};

// LIFE TIME FOR REVIVE
if (!isNil "INS_REV_PARAM_life_time") then {
	INS_REV_CFG_life_time = INS_REV_PARAM_life_time;
} else {
	if (isNil "INS_REV_CFG_life_time") then {
		INS_REV_CFG_life_time = 300;
	};
};

// TAKE TIME TO REVIVE
if (!isNil "INS_REV_PARAM_revive_take_time") then {
	INS_REV_CFG_revive_take_time = INS_REV_PARAM_revive_take_time;
} else {
	if (isNil "INS_REV_CFG_revive_take_time") then {
		INS_REV_CFG_revive_take_time = 15;
	};
};

// REQUIRES MEDKIT TO REVIVE
if (!isNil "INS_REV_PARAM_require_medkit") then {
	INS_REV_CFG_require_medkit = [INS_REV_PARAM_require_medkit] call INS_REV_FNCT_param_to_value;
} else {
	if (isNil "INS_REV_CFG_require_medkit") then {
		INS_REV_CFG_require_medkit = false;
	};
};

// PLAYER RESPAWN TYPE
if (!isNil "INS_REV_PARAM_respawn_type") then {
	switch (INS_REV_PARAM_respawn_type) do {
		case 0: {
			// ALL
			INS_REV_CFG_respawn_type = "ALL";
		};
		case 1: {
			// SIDE
			INS_REV_CFG_respawn_type = "SIDE";
		};
		case 2: {
			// GROUP
			INS_REV_CFG_respawn_type = "GROUP";
		};
	};
} else {
	if (isNil "INS_REV_CFG_respawn_type") then {
		INS_REV_CFG_respawn_type = "ALL";
	};
};

// PLAYER RESPAWN LOCATION
if (!isNil "INS_REV_PARAM_respawn_location") then {
	switch (INS_REV_PARAM_respawn_location) do {
		case 0: {
			// Base + Alive friendly unit
			INS_REV_CFG_respawn_location = "BOTH";
		};
		case 1: {
			// Base
			INS_REV_CFG_respawn_location = "BASE";
		};
		case 2: {
			// Alive Friendly Unit
			INS_REV_CFG_respawn_location = "FRIENDLY_UNIT";
		};
	};
} else {
	if (isNil "INS_REV_CFG_respawn_location") then {
		INS_REV_CFG_respawn_location = "BOTH";
	};
};

// JIP TELEPORT ACTION
if (!isNil "INS_REV_PARAM_jip_action") then {
	INS_REV_CFG_JIP_Teleport_Action = INS_REV_PARAM_jip_action;
} else {
	if (isNil "INS_REV_CFG_JIP_Teleport_Action") then {
		INS_REV_CFG_JIP_Teleport_Action = 1;
	};
};

// ALLOW TO DRAG BODY
if (!isNil "INS_REV_PARAM_can_drag_body") then {
	INS_REV_CFG_player_can_drag_body = [INS_REV_PARAM_can_drag_body] call INS_REV_FNCT_param_to_value;
} else {
	if (isNil "INS_REV_CFG_player_can_drag_body") then {
		INS_REV_CFG_player_can_drag_body = true;
	};
};

// Allow to load Body (MEDEVAC)
if (!isNil "INS_REV_PARAM_medevac") then {
	INS_REV_CFG_medevac = [INS_REV_PARAM_medevac] call INS_REV_FNCT_param_to_value;
} else {
	if (isNil "INS_REV_CFG_medevac") then {
		INS_REV_CFG_medevac = true;
	};
};

// PLAYER CAN RESPAWN PLAYER's BODY
if (!isNil "INS_REV_PARAM_can_respawn_player_body") then {
	INS_REV_CFG_can_respawn_player_body = [INS_REV_PARAM_can_respawn_player_body] call INS_REV_FNCT_param_to_value;
} else {
	if (isNil "INS_REV_CFG_can_respawn_player_body") then {
		INS_REV_CFG_can_respawn_player_body = false;
	};
};

// PLAYER CAN RESPAWN PLAYER's BODY, WHEN HALF OF PLAYERS ARE DEAD
if (!isNil "INS_REV_PARAM_half_dead_repsawn_player_body") then {
	INS_REV_CFG_half_dead_repsawn_player_body = [INS_REV_PARAM_half_dead_repsawn_player_body] call INS_REV_FNCT_param_to_value;
} else {
	if (isNil "INS_REV_CFG_half_dead_repsawn_player_body") then {
		INS_REV_CFG_half_dead_repsawn_player_body = false;
	};
};

// PLAYER CAN RESPAWN IMMEDIATELY WHEN THERE'S NOT EXIST FRIENDLY UNIT NEAR PLAYER
if (!isNil "INS_REV_PARAM_near_friendly") then {
	INS_REV_CFG_respawn_near_friendly = [INS_REV_PARAM_near_friendly] call INS_REV_FNCT_param_to_value;
} else {
	if (isNil "INS_REV_CFG_respawn_near_friendly") then {
		INS_REV_CFG_respawn_near_friendly = false;
	};
};

// Friendly unit search distnace
if (!isNil "INS_REV_PARAM_near_friendly_distance") then {
	INS_REV_CFG_respawn_near_friendly_range = INS_REV_PARAM_near_friendly_distance;
} else {
	if (isNil "INS_REV_CFG_respawn_near_friendly_range") then {
		INS_REV_CFG_respawn_near_friendly_range = 50;
	};
};

// PLAYER CAN RESPAWN IMMEDIATELY WHEN ALL PLAYERS ARE DEAD
if (!isNil "INS_REV_PARAM_all_dead_respawn") then {
	INS_REV_CFG__all_dead_respawn = [INS_REV_PARAM_all_dead_respawn] call INS_REV_FNCT_param_to_value;
} else {
	if (isNil "INS_REV_CFG__all_dead_respawn") then {
		INS_REV_CFG__all_dead_respawn = true;
	};
};

// PLAYER CANNOT RESPAWN, IF EXIST ENEMY UNIT NEAR PLAYER
if (!isNil "INS_REV_PARAM_near_enemy") then {
	INS_REV_CFG_near_enemy = [INS_REV_PARAM_near_enemy] call INS_REV_FNCT_param_to_value;
} else {
	if (isNil "INS_REV_CFG_near_enemy") then {
		INS_REV_CFG_near_enemy = false;
	};
};

// Enemy unit search distnace
if (!isNil "INS_REV_PARAM_near_enemy_distance") then {
	INS_REV_CFG_near_enemy_range = INS_REV_PARAM_near_enemy_distance;
} else {
	if (isNil "INS_REV_CFG_near_enemy_range") then {
		INS_REV_CFG_near_enemy_range = 50;
	};
};
