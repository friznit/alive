private ["_categories","_result"];

_categories = [

	["ALIVE_Indexing_Blacklist","Blacklist","Any objects that should not be included in analysis"],

	["ALIVE_militaryBuildingTypes","Military Buildings","All military buildings here"],
	["ALIVE_militaryParkingBuildingTypes","Military - Parking","Buildings that ambient vehicles will be placed around"],
	["ALIVE_militarySupplyBuildingTypes","Military - Supply","Buildings that ambient supply boxes will be placed around"],
	["ALIVE_militaryHQBuildingTypes","Military - HQ","Buildings that can be selected as HQ locations"],
	["ALIVE_airBuildingTypes","Generic - Air","All building where fixed wing aircraft can be spawned"],
	["ALIVE_militaryAirBuildingTypes","Military - Air","Buildings that ambient fixed wing aircraft spawn in"],
	["ALIVE_civilianAirBuildingTypes","Civilian - Air","Buildings that ambient fixed wing aircraft spawn in"],

	["ALIVE_heliBuildingTypes","Generic - Air","All building where rotary wing aircraft can be spawned"],
	["ALIVE_militaryHeliBuildingTypes","Military - Heli","Buildings that ambient helicopters spawn in"],
	["ALIVE_civilianHeliBuildingTypes","Civilian - Heli","Buildings that ambient helicopters spawn in"],

	["ALIVE_civilianPopulationBuildingTypes","Civilian - Population","Buildings that ambient civs can spawn in and ambient vehicles can spawn around"],
	["ALIVE_civilianHQBuildingTypes","Civilian - HQ","Buildings that can be selected as HQ locations for insurgency/occupation"],
	["ALIVE_civilianSettlementBuildingTypes","Civilian - Settlement","All buildings used to create a civilian cluster (this should include all buildings listed in Civilian - Population)"],

	["ALIVE_civilianPowerBuildingTypes","Civilian - Power",""],
	["ALIVE_civilianCommsBuildingTypes","Civilian - Comms",""],
	["ALIVE_civilianMarineBuildingTypes","Civilian - Marine",""],
	["ALIVE_civilianRailBuildingTypes","Civilian - Rail",""],
	["ALIVE_civilianFuelBuildingTypes","Civilian - Fuel",""],
	["ALIVE_civilianConstructionBuildingTypes","Civilian - Construction",""]
];

// Init arrays

{
	call compile format["%1 = []", _x select 0];
} foreach _categories;

{
	private ["_model","_samples","_idc"];
	_model = _x select 0;
	_samples = _x select 1;
	ALiVE_wrp_model = _model;
	ALIVE_map_index_choice = 99;
	_i = 0;
	createDialog "alive_indexing_list";
	while {ALIVE_map_index_choice == 99} do
	{
		private ["_o","_id","_pos","_obj","_cam"];
		_o = _samples select _i;
		_id = _o select 0;
		_pos = _o select 1;
		_obj = _pos nearestObject _id;

		_cam = [_obj, false, "HIGH"] call ALiVE_fnc_addCamera;
		[_cam, true] call ALIVE_fnc_startCinematic;
		cutText [format["Progress:%3/%4 - Object: %1, Model: %2", typeof _obj, str(_model), _foreachIndex + 1, count wrp_objects],"PLAIN DOWN"];

		[_cam,_obj,2] call ALIVE_fnc_chaseShot;
		sleep 1;
		camDestroy _cam;
		_i = _i + 1;
		if (_i == count _samples) then {_i = 0;};
	};

	// Once choice made, record choice in array
	// call compile format['%1 pushBack "%2"', ((_categories select ALIVE_map_index_choice) select 0), _model];
	// Reset Checkboxes
	closeDialog 0;

} foreach wrp_objects;

// Dump arrays to extension that can write the staticData file
{
	private ["_array","_arrayActual","_result"];
	_array = _x select 0;
	_arrayActual = call compile _array;
	//diag_log format['staticData~%1|%2 = %2 + %3;',worldName,_array, _arrayActual];
	_result = "ALiVEClient" callExtension format['staticData~%1|%2 = %2 + %3;',worldName,_array, _arrayActual];
	//diag_log str(_result);

} foreach _categories;

_result = "ALiVEClient" callExtension format['staticData~%1|};',worldName];
// diag_log str(_result);

true