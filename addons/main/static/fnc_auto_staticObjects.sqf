private ["_categories"];

_categories = [
	["ALIVE_Indexing_Blacklist","Blacklist"],
	["ALIVE_airBuildingTypes","Generic - Air"],
	["ALIVE_militaryAirBuildingTypes","Military - Air"],
	["ALIVE_militaryHeliBuildingTypes","Military - Heli"],
	["ALIVE_militaryBuildingTypes","Military - Generic"],
	["ALIVE_militaryParkingBuildingTypes","Military - Parking"],
	["ALIVE_militarySupplyBuildingTypes","Military - Supply"],
	["ALIVE_militaryHQBuildingTypes","Military - HQ"],
	["ALIVE_civilianAirBuildingTypes","Civilian - Air"],
	["ALIVE_civilianHeliBuildingTypes","Civilian - Heli"],
	["ALIVE_civilianPopulationBuildingTypes","Civilian - Population"],
	["ALIVE_civilianHQBuildingTypes","Civilian - HQ"],
	["ALIVE_civilianPowerBuildingTypes","Civilian - Power"],
	["ALIVE_civilianCommsBuildingTypes","Civilian - Comms"],
	["ALIVE_civilianMarineBuildingTypes","Civilian - Marine"],
	["ALIVE_civilianRailBuildingTypes","Civilian - Rail"],
	["ALIVE_civilianFuelBuildingTypes","Civilian - Fuel"],
	["ALIVE_civilianConstructionBuildingTypes","Civilian - Construction"],
	["ALIVE_civilianSettlementBuildingTypes","Civilian - Settlement"]
];

// Init arrays

{
	call compile format["%1 = []", _x select 0];
} foreach _categories;

createDialog "alive_indexing_list";
{
	private ["_index"];
	_index = ((findDisplay 1601) displayCtrl 1) lbAdd (_x select 1);
} foreach _categories;

{

	private ["_model","_samples","_idc"];
	_model = _x select 0;
	_samples = _x select 1;
	wrp_model = _model;
	ALIVE_map_index_choice = 99;
	_i = 0;

	while {ALIVE_map_index_choice == 99} do
	{
		private ["_o","_id","_pos","_obj","_cam"];
		_o = _samples select _i;
		_id = _o select 0;
		_pos = _o select 1;
		_obj = _pos nearestObject _id;


		_cam = [_obj, false, "HIGH"] call ALiVE_fnc_addCamera;
		[_cam, true] call ALIVE_fnc_startCinematic;
		cutText [format["Object: %1, Model: %2", typeof _obj, str(_model)],"PLAIN DOWN"];

		[_cam,_obj,2] call ALIVE_fnc_chaseShot;
		sleep 2;
		camDestroy _cam;
		_i = _i + 1;
		if (_i == count _samples) then {_i = 0;};
	};

	// Once choice made, record choice in array
	call compile format['%1 pushBack "%2"', ((_categories select ALIVE_map_index_choice) select 0), _model];

} foreach wrp_objects;

closeDialog 0
// Dump arrays to extension that can write the staticData file
