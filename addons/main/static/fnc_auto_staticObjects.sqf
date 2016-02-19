{

	private ["_model","_samples"];
	_model = _x select 0;
	_samples = _x select 1;
	ALIVE_map_index_choice = "";
	// createDialog "ALiVE_map_index";
	_i = 0;

diag_log str(_x);

	while {ALIVE_map_index_choice == ""} do
	{
		_o = _samples select _i;
		_id = _o select 0;
		_pos = _o select 1;
		diag_log str(_o);
		_obj = _pos nearestObject _id;
		["ALiVE Indexer", format["Object: %1", typeof _obj]] call ALiVE_fnc_sendHint;
		_cam = [_obj, false] call ALiVE_fnc_addCamera;
		[_cam,_obj,4] call ALIVE_fnc_staticShot;
		sleep 4;
		_i = _i + 1;
		if (_i == count _samples) then {ALIVE_map_index_choice = "1";};
	};

} foreach wrp_objects;